Return-Path: <bpf+bounces-3473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97573E67E
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C241C203AE
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE012B69;
	Mon, 26 Jun 2023 17:33:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034BA125BC;
	Mon, 26 Jun 2023 17:33:21 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A31B0;
	Mon, 26 Jun 2023 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687800800; x=1719336800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h4ykPayTseFKp+d8V4hTAoUMXEmrxzNUN9/DJl/pfPo=;
  b=EugQ6rlySrDX6ShX3DzKM8rB6Se9GYVoRWpWh6/daMgIZHmL6Zn2hLE2
   ivY+tEjtXmpdM7QaOm+Xa6iW7jw9x+zcJHBT5Mli3bQedIsFnO258oqpI
   +fqsOd7A3pH1u4FBPxA7KVXjB3R/CqYtSloN1zefH3m3AGSptijFYfY1I
   M=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="592791065"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 17:33:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id E974245FE2;
	Mon, 26 Jun 2023 17:33:11 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 17:33:02 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 26 Jun 2023 17:32:57 +0000
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
Subject: Re: [PATCH bpf-next v3 2/7] net: export inet_lookup_reuseport and inet6_lookup_reuseport
Date: Mon, 26 Jun 2023 10:32:49 -0700
Message-ID: <20230626173249.57682-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613-so-reuseport-v3-2-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-2-907b4cbb7b99@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.15]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 26 Jun 2023 16:08:59 +0100
> Rename the existing reuseport helpers for IPv4 and IPv6 so that they
> can be invoked in the follow up commit. Export them so that DCCP which
> may be built as a module can access them.

We need not export the functions unless there is a real user.

I added a deprecation notice for DCCP recently, so I bet DCCP
will not get SO_REUSEPORT support.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=b144fcaf46d4


> 
> No change in functionality.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  include/net/inet6_hashtables.h |  7 +++++++
>  include/net/inet_hashtables.h  |  5 +++++
>  net/ipv4/inet_hashtables.c     | 15 ++++++++-------
>  net/ipv6/inet6_hashtables.c    | 19 ++++++++++---------
>  4 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 56f1286583d3..032ddab48f8f 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -48,6 +48,13 @@ struct sock *__inet6_lookup_established(struct net *net,
>  					const u16 hnum, const int dif,
>  					const int sdif);
>  
> +struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
> +				    struct sk_buff *skb, int doff,
> +				    const struct in6_addr *saddr,
> +				    __be16 sport,
> +				    const struct in6_addr *daddr,
> +				    unsigned short hnum);
> +
>  struct sock *inet6_lookup_listener(struct net *net,
>  				   struct inet_hashinfo *hashinfo,
>  				   struct sk_buff *skb, int doff,
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 99bd823e97f6..8734f3488f5d 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -379,6 +379,11 @@ struct sock *__inet_lookup_established(struct net *net,
>  				       const __be32 daddr, const u16 hnum,
>  				       const int dif, const int sdif);
>  
> +struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
> +				   struct sk_buff *skb, int doff,
> +				   __be32 saddr, __be16 sport,
> +				   __be32 daddr, unsigned short hnum);
> +
>  static inline struct sock *
>  	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
>  				const __be32 saddr, const __be16 sport,
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index e7391bf310a7..920131e4a65d 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -332,10 +332,10 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
> -					    struct sk_buff *skb, int doff,
> -					    __be32 saddr, __be16 sport,
> -					    __be32 daddr, unsigned short hnum)
> +struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
> +				   struct sk_buff *skb, int doff,
> +				   __be32 saddr, __be16 sport,
> +				   __be32 daddr, unsigned short hnum)
>  {
>  	struct sock *reuse_sk = NULL;
>  	u32 phash;
> @@ -346,6 +346,7 @@ static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
>  	}
>  	return reuse_sk;
>  }
> +EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
>  
>  /*
>   * Here are some nice properties to exploit here. The BSD API
> @@ -369,8 +370,8 @@ static struct sock *inet_lhash2_lookup(struct net *net,
>  	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
> -			result = lookup_reuseport(net, sk, skb, doff,
> -						  saddr, sport, daddr, hnum);
> +			result = inet_lookup_reuseport(net, sk, skb, doff,
> +						       saddr, sport, daddr, hnum);
>  			if (result)
>  				return result;
>  
> @@ -399,7 +400,7 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
> +	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b64b49012655..b7c56867314e 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -111,12 +111,12 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
> -					    struct sk_buff *skb, int doff,
> -					    const struct in6_addr *saddr,
> -					    __be16 sport,
> -					    const struct in6_addr *daddr,
> -					    unsigned short hnum)
> +struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
> +				    struct sk_buff *skb, int doff,
> +				    const struct in6_addr *saddr,
> +				    __be16 sport,
> +				    const struct in6_addr *daddr,
> +				    unsigned short hnum)
>  {
>  	struct sock *reuse_sk = NULL;
>  	u32 phash;
> @@ -127,6 +127,7 @@ static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
>  	}
>  	return reuse_sk;
>  }
> +EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
>  
>  /* called with rcu_read_lock() */
>  static struct sock *inet6_lhash2_lookup(struct net *net,
> @@ -143,8 +144,8 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
>  	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
>  		score = compute_score(sk, net, hnum, daddr, dif, sdif);
>  		if (score > hiscore) {
> -			result = lookup_reuseport(net, sk, skb, doff,
> -						  saddr, sport, daddr, hnum);
> +			result = inet6_lookup_reuseport(net, sk, skb, doff,
> +							saddr, sport, daddr, hnum);
>  			if (result)
>  				return result;
>  
> @@ -175,7 +176,7 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
>  	if (no_reuseport || IS_ERR_OR_NULL(sk))
>  		return sk;
>  
> -	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
> +	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
>  	if (reuse_sk)
>  		sk = reuse_sk;
>  	return sk;
> 
> -- 
> 2.40.1

