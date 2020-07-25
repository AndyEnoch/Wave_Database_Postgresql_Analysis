--- QUESTION 1 ---
SELECT count(*) FROM public.users;

--- QUESTION 2 ---
SELECT COUNT(*) FROM public.transfers 
	WHERE send_amount_currency = 'CFA';

--- QUESTION 3 ---
SELECT COUNT(DISTINCT u_id) FROM public.transfers
	WHERE send_amount_currency = 'CFA';


--- QUESTION 4 ---
SELECT COUNT(*), EXTRACT (month FROM when_created) AS month FROM public.agent_transactions
  	WHERE EXTRACT (year FROM when_created) = '2018'
    GROUP BY
    EXTRACT (MONTH FROM when_created);


--- QUESTION 5 ---
--------------- Net Depositors  ---------
SELECT COUNT(agents.agent_id) AS number_net_depositors
 	FROM public.agent_transactions, public.agents
 	WHERE amount < 0
 		AND agent_transactions.agent_id = agents.agent_id
 		AND agent_transactions.when_created > current_date - interval '7 days';

-------------- Net Withdrawers -----------
SELECT COUNT(agents.agent_id) AS number_net_withdrawers
 	FROM public.agent_transactions, public.agents
 	WHERE amount > 0
 		AND agent_transactions.agent_id = agents.agent_id
 		AND agent_transactions.when_created > current_date - interval '7 days';

--- QUESTION 6 ---
SELECT COUNT(atx_id) AS volume, city
		FROM public.agent_transactions
 		INNER JOIN public.agents ON agents.agent_id = agent_transactions.agent_id
 		WHERE agent_transactions.when_created > now() -INTERVAL '7 days'
 		GROUP BY city;


--- QUESTION 7 ---
SELECT COUNT(atx_id) AS volume, city, country
		FROM public.agent_transactions
		INNER JOIN public.agents ON agents.agent_id = agent_transactions.agent_id
		WHERE agent_transactions.when_created > now() -INTERVAL '7 days'
		GROUP BY city, country;


--- QUESTION 8 ---
SELECT COUNT(atx_id) AS volume, kind, country
		FROM public.agent_transactions, public.transfers, public.agents
		WHERE agent_transactions.when_created BETWEEN '2018-11-23' AND '2018-12-30'
		GROUP BY kind, country;

--- QUESTION 9 ---
SELECT DISTINCT COUNT(transfers.source_wallet_id) AS Unique_Senders, 
		COUNT(transfer_id) AS transaction_count, 
		      transfers.kind AS transfer_Kind, 
		      wallets.ledger_location AS Country, 
		SUM(transfers.send_amount_scalar) AS Volume 
		FROM transfers INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id 
		WHERE (transfers.when_created > (NOW() - INTERVAL '7 days')) 
		GROUP BY wallets.ledger_location, transfers.kind;


--- QUESTION 10 ---
SELECT source_wallet_id, send_amount_scalar FROM transfers 
	WHERE send_amount_currency = 'CFA' 
	AND (send_amount_scalar>10000000) 
	AND (transfers.when_created > (NOW() - INTERVAL '1 month'));
	