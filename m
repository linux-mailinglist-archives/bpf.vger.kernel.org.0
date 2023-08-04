Return-Path: <bpf+bounces-7029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A51770671
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4EB1C2188F
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EA1AA71;
	Fri,  4 Aug 2023 16:56:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443541AA63
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:56:19 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1014C1E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:56:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-3fe490c05c9so4932295e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691168166; x=1691772966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zH1gfAZL/CHXWhUKBOjRWmStytVRzUGZT7A4tTO4es=;
        b=Iwt5fF26kFAKOEDoWE21JxOS6w1Ag4sQhIBKYJITAfYlSILdX1jvNUzcZ3NuLZG+3g
         I4mg8INmtIQQuatK1qOmGW8v4i1Lc5BH6WrjNJ11Xt5NnmbQupW/bLmKd+vz7J4I7Xo2
         xWAIDXzj3yfQmdDHOciLmU5zpCKqjr0KBWxinPffzUo+RD3khnJ5FgTHAbyyaPLKHTUb
         cGbibjH5FxweXxul4Y+ow9fBLoRxsdQkVr5pST1x0c0xawcMBmoKYIXWicApAR0KsJ98
         c5gdspe06MEnOVLtKpE9pJfhGA4zESuoB9UbQbreSh7BMK2KZwj/GAdu3ga6gWjLL9ZK
         Xn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168166; x=1691772966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zH1gfAZL/CHXWhUKBOjRWmStytVRzUGZT7A4tTO4es=;
        b=ZbriZrqUpFV2QrxzSGrZrl7LBNYTA3gHwdlXWxRM5C9K0QBGqm9bdFHKklNQWC6zmQ
         uUh65KSCrAWwqkmrBZpGTuGIKP9XQn+yglOPyXdEuB1pUKJdqXRniMwq6CeyYE2rRTI7
         LnIMg+gbj4oaEgFR50/O68QqVhjB3CxWu2ybxt171u6n5MZIpsH9tT9f6X+yYChMHb2S
         TDlhSOMSlywqXz9C0W3OW+x4NqlSXWWTiNWupWfUFayLXwXNSuTO93dlZCz3aJKzEifS
         nI2GgPjGD9EZkIyGlI+qHe1bj7QbkIjXjVsfSHBOVYME8tVJ3ujdSOhf4eb7m8Trux6v
         7rYA==
X-Gm-Message-State: AOJu0YyIvrFCRf3gijqx8wAiXGAjv99i5qcZl/GO/WS1Dnvn8IzNg6MV
	JfaeZHZqog2+rwJjefFAmT6TBA==
X-Google-Smtp-Source: AGHT+IGOvjd3Aba85DiZ9dQCEMUuiJQ4rHnqoYQ9tnOqgC10PPzUObF8ODN/dL+gVMemokXgWeuOng==
X-Received: by 2002:adf:ebc7:0:b0:313:e2e3:d431 with SMTP id v7-20020adfebc7000000b00313e2e3d431mr159375wrn.12.1691168166141;
        Fri, 04 Aug 2023 09:56:06 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0031432f1528csm2938483wrx.45.2023.08.04.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:56:05 -0700 (PDT)
Date: Fri, 4 Aug 2023 18:56:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 6/6] team: remove unused input parameters in
 lb_htpm_select_tx_port and lb_hash_select_tx_port
Message-ID: <ZM0tpBCYYmNPnwRI@nanopsycho>
References: <20230804123116.2495908-1-shaozhengchao@huawei.com>
 <20230804123116.2495908-7-shaozhengchao@huawei.com>
 <ZM0A51WuvXQa67CS@nanopsycho>
 <4b0bde83-5187-521d-e90b-1f36da541ce8@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0bde83-5187-521d-e90b-1f36da541ce8@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 04:06:39PM CEST, shaozhengchao@huawei.com wrote:
>
>
>On 2023/8/4 21:45, Jiri Pirko wrote:
>> Fri, Aug 04, 2023 at 02:31:16PM CEST, shaozhengchao@huawei.com wrote:
>> > The input parameters "lb_priv" and "skb" in lb_htpm_select_tx_port and
>> > lb_hash_select_tx_port are unused, so remove them.
>> > 
>> > Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> > ---
>> > drivers/net/team/team_mode_loadbalance.c | 10 ++--------
>> > 1 file changed, 2 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
>> > index a6021ae51d0d..00f8989c29c0 100644
>> > --- a/drivers/net/team/team_mode_loadbalance.c
>> > +++ b/drivers/net/team/team_mode_loadbalance.c
>> > @@ -30,8 +30,6 @@ static rx_handler_result_t lb_receive(struct team *team, struct team_port *port,
>> > struct lb_priv;
>> > 
>> > typedef struct team_port *lb_select_tx_port_func_t(struct team *,
>> > -						   struct lb_priv *,
>> > -						   struct sk_buff *,
>> > 						   unsigned char);
>> > 
>> > #define LB_TX_HASHTABLE_SIZE 256 /* hash is a char */
>> > @@ -118,8 +116,6 @@ static void lb_tx_hash_to_port_mapping_null_port(struct team *team,
>> > 
>> > /* Basic tx selection based solely by hash */
>> > static struct team_port *lb_hash_select_tx_port(struct team *team,
>> > -						struct lb_priv *lb_priv,
>> > -						struct sk_buff *skb,
>> > 						unsigned char hash)
>> > {
>> > 	int port_index = team_num_to_port_index(team, hash);
>> > @@ -129,8 +125,6 @@ static struct team_port *lb_hash_select_tx_port(struct team *team,
>> > 
>> > /* Hash to port mapping select tx port */
>> > static struct team_port *lb_htpm_select_tx_port(struct team *team,
>> > -						struct lb_priv *lb__priv,
>> 
>> Squash the previous patch in this one to avoid this odd "__" thing.
>> 
>> Thanks!
>> 
>Hi Jiri:
>	Thank you for your review. I will change it and send v2.

Did you hear about netdev rules by any chance?

https://www.kernel.org/doc/html/v6.5-rc4/process/maintainer-netdev.html?highlight=24h

Could you please read it?


>
>Zhengchao Shao
>> 
>> > -						struct sk_buff *skb,
>> > 						unsigned char hash)
>> > {
>> > 	struct lb_priv *lb_priv = get_lb_priv(team);
>> > @@ -140,7 +134,7 @@ static struct team_port *lb_htpm_select_tx_port(struct team *team,
>> > 	if (likely(port))
>> > 		return port;
>> > 	/* If no valid port in the table, fall back to simple hash */
>> > -	return lb_hash_select_tx_port(team, lb_priv, skb, hash);
>> > +	return lb_hash_select_tx_port(team, hash);
>> > }
>> > 
>> > struct lb_select_tx_port {
>> > @@ -230,7 +224,7 @@ static bool lb_transmit(struct team *team, struct sk_buff *skb)
>> > 
>> > 	hash = lb_get_skb_hash(lb_priv, skb);
>> > 	select_tx_port_func = rcu_dereference_bh(lb_priv->select_tx_port_func);
>> > -	port = select_tx_port_func(team, lb_priv, skb, hash);
>> > +	port = select_tx_port_func(team, hash);
>> > 	if (unlikely(!port))
>> > 		goto drop;
>> > 	if (team_dev_queue_xmit(team, port, skb))
>> > -- 
>> > 2.34.1
>> > 
>> 

