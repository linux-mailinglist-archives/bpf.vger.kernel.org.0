Return-Path: <bpf+bounces-3471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08573E667
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D734280E57
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA7125C1;
	Mon, 26 Jun 2023 17:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801AD520;
	Mon, 26 Jun 2023 17:26:16 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79001AB;
	Mon, 26 Jun 2023 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687800375; x=1719336375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SLHs10iJGAAF5phF+GbeJBaS0WCv5SXVNHF8Rxr9/g=;
  b=dDeVKmul3EglJqK3YkGqacc6JMIVo8rxFhMg4mPRe3iNyuZtsp6ILyx7
   vCQxeXawFNuGjAimu/otfnOzEXNOKofHqzvX5DwP/Nt6RhNSHZA0anc5F
   Vx+GTKLNysRIXw4VBu9U+d0CUWwRJ3Tcstqv1BDeOmiR9DVGXEi4DaOOE
   I=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="1139662461"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 17:26:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 7379640D52;
	Mon, 26 Jun 2023 17:26:01 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 17:25:52 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 26 Jun 2023 17:25:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lmb@isovalent.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <hemanthmalla@gmail.com>,
	<joe@wand.net.nz>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<martin.lau@linux.dev>, <mykolal@fb.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@google.com>, <shuah@kernel.org>, <song@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v3 1/7] udp: re-score reuseport groups when connected sockets are present
Date: Mon, 26 Jun 2023 10:25:37 -0700
Message-ID: <20230626172537.57064-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v3-1-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-1-907b4cbb7b99@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 26 Jun 2023 16:08:58 +0100
> Contrary to TCP, UDP reuseport groups can contain TCP_ESTABLISHED
> sockets. To support these properly we remember whether a group has
> a connected socket and skip the fast reuseport early-return. In
> effect we continue scoring all reuseport sockets and then choose the
> one with the highest score.
> 
> The current code fails to re-calculate the score for the result of
> lookup_reuseport. According to Kuniyuki Iwashima:
> 
>     1) SO_INCOMING_CPU is set
>        -> selected sk might have +1 score
> 
>     2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
>        -> selected sk will have more than 8
> 
>   Using the old score could trigger more lookups depending on the
>   order that sockets are created.
> 
>     sk -> sk (SO_INCOMING_CPU) -> sk (ESTABLISHED)
>     |     |
>     `-> select the next SO_INCOMING_CPU sk
>           |
>           `-> select itself (We should save this lookup)
> 
> Fixes: efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.")
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

1 minor nit below.


> ---
>  net/ipv4/udp.c | 20 +++++++++++++++-----
>  net/ipv6/udp.c | 19 ++++++++++++++-----
>  2 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index fd3dae081f3a..5ef478d2c408 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -450,14 +450,24 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  		score = compute_score(sk, net, saddr, sport,
>  				      daddr, hnum, dif, sdif);
>  		if (score > badness) {
> -			result = lookup_reuseport(net, sk, skb,
> -						  saddr, sport, daddr, hnum);
> +			badness = score;
> +			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +			if (!result) {
> +				result = sk;
> +				continue;
> +			}
> +
>  			/* Fall back to scoring if group has connections */
> -			if (result && !reuseport_has_conns(sk))
> +			if (!reuseport_has_conns(sk))
>  				return result;
>  
> -			result = result ? : sk;
> -			badness = score;
> +			/* Reuseport logic returned an error, keep original score. */
> +			if (IS_ERR(result))
> +				continue;
> +
> +			badness = compute_score(result, net, saddr, sport,
> +						daddr, hnum, dif, sdif);
> +

Unnecessary blank line here.


>  		}
>  	}
>  	return result;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index e5a337e6b970..8b3cb1d7da7c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -193,14 +193,23 @@ static struct sock *udp6_lib_lookup2(struct net *net,
>  		score = compute_score(sk, net, saddr, sport,
>  				      daddr, hnum, dif, sdif);
>  		if (score > badness) {
> -			result = lookup_reuseport(net, sk, skb,
> -						  saddr, sport, daddr, hnum);
> +			badness = score;
> +			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +			if (!result) {
> +				result = sk;
> +				continue;
> +			}
> +
>  			/* Fall back to scoring if group has connections */
> -			if (result && !reuseport_has_conns(sk))
> +			if (!reuseport_has_conns(sk))
>  				return result;
>  
> -			result = result ? : sk;
> -			badness = score;
> +			/* Reuseport logic returned an error, keep original score. */
> +			if (IS_ERR(result))
> +				continue;
> +
> +			badness = compute_score(sk, net, saddr, sport,
> +						daddr, hnum, dif, sdif);
>  		}
>  	}
>  	return result;
> 
> -- 
> 2.40.1

