Return-Path: <bpf+bounces-7012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FCC77028D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931AD28230D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04636CA4B;
	Fri,  4 Aug 2023 14:06:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECCC139;
	Fri,  4 Aug 2023 14:06:45 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB96B9;
	Fri,  4 Aug 2023 07:06:42 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHSB35pq5z1Z1Sb;
	Fri,  4 Aug 2023 22:03:55 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 22:06:40 +0800
Message-ID: <4b0bde83-5187-521d-e90b-1f36da541ce8@huawei.com>
Date: Fri, 4 Aug 2023 22:06:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 6/6] team: remove unused input parameters in
 lb_htpm_select_tx_port and lb_hash_select_tx_port
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230804123116.2495908-1-shaozhengchao@huawei.com>
 <20230804123116.2495908-7-shaozhengchao@huawei.com>
 <ZM0A51WuvXQa67CS@nanopsycho>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZM0A51WuvXQa67CS@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/4 21:45, Jiri Pirko wrote:
> Fri, Aug 04, 2023 at 02:31:16PM CEST, shaozhengchao@huawei.com wrote:
>> The input parameters "lb_priv" and "skb" in lb_htpm_select_tx_port and
>> lb_hash_select_tx_port are unused, so remove them.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> drivers/net/team/team_mode_loadbalance.c | 10 ++--------
>> 1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
>> index a6021ae51d0d..00f8989c29c0 100644
>> --- a/drivers/net/team/team_mode_loadbalance.c
>> +++ b/drivers/net/team/team_mode_loadbalance.c
>> @@ -30,8 +30,6 @@ static rx_handler_result_t lb_receive(struct team *team, struct team_port *port,
>> struct lb_priv;
>>
>> typedef struct team_port *lb_select_tx_port_func_t(struct team *,
>> -						   struct lb_priv *,
>> -						   struct sk_buff *,
>> 						   unsigned char);
>>
>> #define LB_TX_HASHTABLE_SIZE 256 /* hash is a char */
>> @@ -118,8 +116,6 @@ static void lb_tx_hash_to_port_mapping_null_port(struct team *team,
>>
>> /* Basic tx selection based solely by hash */
>> static struct team_port *lb_hash_select_tx_port(struct team *team,
>> -						struct lb_priv *lb_priv,
>> -						struct sk_buff *skb,
>> 						unsigned char hash)
>> {
>> 	int port_index = team_num_to_port_index(team, hash);
>> @@ -129,8 +125,6 @@ static struct team_port *lb_hash_select_tx_port(struct team *team,
>>
>> /* Hash to port mapping select tx port */
>> static struct team_port *lb_htpm_select_tx_port(struct team *team,
>> -						struct lb_priv *lb__priv,
> 
> Squash the previous patch in this one to avoid this odd "__" thing.
> 
> Thanks!
> 
Hi Jiri:
	Thank you for your review. I will change it and send v2.

Zhengchao Shao
> 
>> -						struct sk_buff *skb,
>> 						unsigned char hash)
>> {
>> 	struct lb_priv *lb_priv = get_lb_priv(team);
>> @@ -140,7 +134,7 @@ static struct team_port *lb_htpm_select_tx_port(struct team *team,
>> 	if (likely(port))
>> 		return port;
>> 	/* If no valid port in the table, fall back to simple hash */
>> -	return lb_hash_select_tx_port(team, lb_priv, skb, hash);
>> +	return lb_hash_select_tx_port(team, hash);
>> }
>>
>> struct lb_select_tx_port {
>> @@ -230,7 +224,7 @@ static bool lb_transmit(struct team *team, struct sk_buff *skb)
>>
>> 	hash = lb_get_skb_hash(lb_priv, skb);
>> 	select_tx_port_func = rcu_dereference_bh(lb_priv->select_tx_port_func);
>> -	port = select_tx_port_func(team, lb_priv, skb, hash);
>> +	port = select_tx_port_func(team, hash);
>> 	if (unlikely(!port))
>> 		goto drop;
>> 	if (team_dev_queue_xmit(team, port, skb))
>> -- 
>> 2.34.1
>>
> 

