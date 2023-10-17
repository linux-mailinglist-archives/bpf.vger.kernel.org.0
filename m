Return-Path: <bpf+bounces-12461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE987CC922
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44ABBB21228
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC36347B1;
	Tue, 17 Oct 2023 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m1XFIs1p"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9382D03C;
	Tue, 17 Oct 2023 16:53:14 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE3AB;
	Tue, 17 Oct 2023 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697561593; x=1729097593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYMS26X/tscicdPoA7u1E7ofsnxzW2sufLuPqW6vXyA=;
  b=m1XFIs1plp7gTltbXdyZ3AHFucsPZaPukXcVFr0eZYCu5fAUL90VfbDf
   Pk/C/PMLVDt1rH3SmmzQKMBaj6PFLqCYpOZjQ0Dx4fEYzUS3A/9oVtqkM
   1OLm5grjA7ofxwggT0w7Y8IL3E83T1xWbVrysyw+635nG8Hgrfjm0DL1h
   g=;
X-IronPort-AV: E=Sophos;i="6.03,232,1694736000"; 
   d="scan'208";a="36355217"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:53:02 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id C6603488DE;
	Tue, 17 Oct 2023 16:52:55 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:39670]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.42:2525] with esmtp (Farcaster)
 id f4c7dc41-9623-4b8f-bfbc-2020be008e4d; Tue, 17 Oct 2023 16:52:55 +0000 (UTC)
X-Farcaster-Flow-ID: f4c7dc41-9623-4b8f-bfbc-2020be008e4d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 16:52:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 16:52:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 06/11] bpf: tcp: Add SYN Cookie validation SOCK_OPS hook.
Date: Tue, 17 Oct 2023 09:52:39 -0700
Message-ID: <20231017165239.20308-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013220433.70792-7-kuniyu@amazon.com>
References: <20231013220433.70792-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.38]
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 13 Oct 2023 15:04:28 -0700
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 514f1a4abdee..b1dd415863ff 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -317,6 +317,37 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
>  }
>  EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
>  
> +#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
> +int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_buff *skb)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +
> +	sock_ops.op = BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB;
> +	sock_ops.sk = req_to_sk(req);
> +	sock_ops.args[0] = tcp_rsk(req)->snt_isn;
> +
> +	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> +
> +	if (BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk))
> +		goto err;
> +
> +	if (!sock_ops.replylong[0])
> +		goto err;

I noticed this test is insufficient to check valid MSS.
I'll use msstab[0] as the minimum valid MSS in v2.

---8<---
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 22353a9af52d..4af165fd48f9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -287,6 +287,7 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
 	struct bpf_sock_ops_kern sock_ops;
 	struct net *net = sock_net(sk);
 	u32 options;
+	u16 min_mss;
 
 	if (tcp_opt->saw_tstamp) {
 		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
@@ -307,7 +308,8 @@ int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_
 	if (BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk))
 		goto err;
 
-	if (!sock_ops.replylong[0])
+	min_mss = skb->protocol == htons(ETH_P_IP) ? msstab[0] : IPV6_MIN_MTU - 60;
+	if (sock_ops.replylong[0] < min_mss)
 		goto err;
 
 	options = sock_ops.replylong[1];
---8<---



> +
> +	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
> +
> +	return sock_ops.replylong[0];
> +
> +err:
> +	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bpf_skops_cookie_check);
> +#endif
> +
>  /* On input, sk is a listener.
>   * Output is listener if incoming packet would not create a child
>   *           NULL if memory could not be allocated.

