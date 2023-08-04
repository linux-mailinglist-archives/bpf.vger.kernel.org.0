Return-Path: <bpf+bounces-7011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B177021F
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0062826AD
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F578C2DB;
	Fri,  4 Aug 2023 13:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF3C14A
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 13:45:21 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF9170F
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 06:45:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583e91891aeso23258297b3.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691156714; x=1691761514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFjOj5n/pnoN1dMFIl4rP1O9RZ0CMtGw4Zpf0LApXq4=;
        b=X6Tg9Hj0FPC7j0g0E8SVZc9As5oqGp8Wc2bHTV5BWGlJzJfVHJXqLJ/z2+wq+q7iOn
         YXyA5fJq7wNvImJyxlznrlYC6OpTy4lPcqjrS82Xtg6Zq9lO4i/YMTkXFxnM4v9//70M
         uyCGVZK3vvLB6GHu9OkwVRmJzTfRYeYeRUUQVxS7JlV/n0pv9rz1zjcKc216b3i2YL96
         S+OAy0sAOeIqAQbymxPCDSzVTnwTqs5HdHmRNelm+dRJkhUQ75q53zmAeUi0ra7OsxWD
         1Tm51b10i5QBRJm8KW54zEmn2E6OOOQ2tyvomVxeraG14Jqim6cXlsA3vKxBbFdx+0vl
         /tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156714; x=1691761514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFjOj5n/pnoN1dMFIl4rP1O9RZ0CMtGw4Zpf0LApXq4=;
        b=g2ga4hnP1V39SqnG+qgMlZJpAv9NbYaT4VPxrq6DhyG/HEmc/W7vbfeMcwzi27ovoG
         1lIzVSUZHxiu+81vTaL7QIB6T/cAGQtSrCU/1b2+7vKyDjlfsAfbKAKl81vwt0ImqgLC
         vZjyS5cl9Rx1N2tu5PhifIMVInatm0qaOVZIMmfvcgPkxJJlHLkPgtZrSF2avNLjHAD4
         YZDKZnVgDq8Y1Mgdld3GUflqmFVTnRdLzbhiH8lb/6tWA+IawuEnQ3R7gq32+TVV7Mgf
         IvHyTXwpQu+1GaQ4M9WCAzUJCIFsL+gApLosvi1cW0QB0TIq9KbomYNBbb6pp59nC7yQ
         yafA==
X-Gm-Message-State: AOJu0YwDriMsDqd1o0e9fgt1iil0dqClGP2gSY8E6p46VYEjuTcZdgtI
	dCAHVk97ls1YLUryWa1Cyc9eFg==
X-Google-Smtp-Source: AGHT+IGsmsbyIAE5Wg5xYkedvbP55jv1I5DOFPFlN68/nYITNiTw0nmASOEROfoxmXtVy6Ck6NnxbQ==
X-Received: by 2002:a81:8704:0:b0:583:9018:29ec with SMTP id x4-20020a818704000000b00583901829ecmr1730320ywf.32.1691156714023;
        Fri, 04 Aug 2023 06:45:14 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id w128-20020a0ded86000000b00583f8f41cb8sm717094ywe.63.2023.08.04.06.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:45:13 -0700 (PDT)
Date: Fri, 4 Aug 2023 15:45:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 6/6] team: remove unused input parameters in
 lb_htpm_select_tx_port and lb_hash_select_tx_port
Message-ID: <ZM0A51WuvXQa67CS@nanopsycho>
References: <20230804123116.2495908-1-shaozhengchao@huawei.com>
 <20230804123116.2495908-7-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804123116.2495908-7-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 02:31:16PM CEST, shaozhengchao@huawei.com wrote:
>The input parameters "lb_priv" and "skb" in lb_htpm_select_tx_port and
>lb_hash_select_tx_port are unused, so remove them.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>---
> drivers/net/team/team_mode_loadbalance.c | 10 ++--------
> 1 file changed, 2 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
>index a6021ae51d0d..00f8989c29c0 100644
>--- a/drivers/net/team/team_mode_loadbalance.c
>+++ b/drivers/net/team/team_mode_loadbalance.c
>@@ -30,8 +30,6 @@ static rx_handler_result_t lb_receive(struct team *team, struct team_port *port,
> struct lb_priv;
> 
> typedef struct team_port *lb_select_tx_port_func_t(struct team *,
>-						   struct lb_priv *,
>-						   struct sk_buff *,
> 						   unsigned char);
> 
> #define LB_TX_HASHTABLE_SIZE 256 /* hash is a char */
>@@ -118,8 +116,6 @@ static void lb_tx_hash_to_port_mapping_null_port(struct team *team,
> 
> /* Basic tx selection based solely by hash */
> static struct team_port *lb_hash_select_tx_port(struct team *team,
>-						struct lb_priv *lb_priv,
>-						struct sk_buff *skb,
> 						unsigned char hash)
> {
> 	int port_index = team_num_to_port_index(team, hash);
>@@ -129,8 +125,6 @@ static struct team_port *lb_hash_select_tx_port(struct team *team,
> 
> /* Hash to port mapping select tx port */
> static struct team_port *lb_htpm_select_tx_port(struct team *team,
>-						struct lb_priv *lb__priv,

Squash the previous patch in this one to avoid this odd "__" thing.

Thanks!


>-						struct sk_buff *skb,
> 						unsigned char hash)
> {
> 	struct lb_priv *lb_priv = get_lb_priv(team);
>@@ -140,7 +134,7 @@ static struct team_port *lb_htpm_select_tx_port(struct team *team,
> 	if (likely(port))
> 		return port;
> 	/* If no valid port in the table, fall back to simple hash */
>-	return lb_hash_select_tx_port(team, lb_priv, skb, hash);
>+	return lb_hash_select_tx_port(team, hash);
> }
> 
> struct lb_select_tx_port {
>@@ -230,7 +224,7 @@ static bool lb_transmit(struct team *team, struct sk_buff *skb)
> 
> 	hash = lb_get_skb_hash(lb_priv, skb);
> 	select_tx_port_func = rcu_dereference_bh(lb_priv->select_tx_port_func);
>-	port = select_tx_port_func(team, lb_priv, skb, hash);
>+	port = select_tx_port_func(team, hash);
> 	if (unlikely(!port))
> 		goto drop;
> 	if (team_dev_queue_xmit(team, port, skb))
>-- 
>2.34.1
>

