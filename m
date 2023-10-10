Return-Path: <bpf+bounces-11818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5D7C021B
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD62E281FC1
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697FE2FE3A;
	Tue, 10 Oct 2023 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t8YRRgzh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B782FE2A;
	Tue, 10 Oct 2023 17:00:35 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD15A9D;
	Tue, 10 Oct 2023 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696957233; x=1728493233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ASnzCpkAHajmoJ0lPHWgTC4MMKjh5x49ov8QmLYAQKE=;
  b=t8YRRgzhJVUTPjjnmKLQc8HYiCRPQYvWawSaqwbYsidkTyx6gGwLkAH3
   bP76dl9hfIUvTiKu963DL7UGTukQVNBuGSseAJDXNzywTlETzUJ75z47e
   1SLX/3lwFjt649HMq6pNJGyIYqfA965Bgr+Uuac6aOLGfth7qj+qdYpxF
   o=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="34793768"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 17:00:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 5AD3E60CA7;
	Tue, 10 Oct 2023 17:00:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 17:00:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 17:00:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v9 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr from bpf
Date: Tue, 10 Oct 2023 10:00:19 -0700
Message-ID: <20231010170019.4924-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006074530.892825-4-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-4-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.11]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Fri,  6 Oct 2023 09:44:57 +0200
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set_unix_addr() that allows modifying a
> sockaddr from bpf. While this is already possible for AF_INET and AF_INET6,
> we'll need this kfunc when we add unix socket support since modifying the
> address for those requires modifying both the address and the sockaddr
> length.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  kernel/bpf/btf.c  |  1 +
>  net/core/filter.c | 34 +++++++++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 69101200c124..15d71d2986d3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7850,6 +7850,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>  	case BPF_PROG_TYPE_SYSCALL:
>  		return BTF_KFUNC_HOOK_SYSCALL;
>  	case BPF_PROG_TYPE_CGROUP_SKB:
> +	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>  		return BTF_KFUNC_HOOK_CGROUP_SKB;
>  	case BPF_PROG_TYPE_SCHED_ACT:
>  		return BTF_KFUNC_HOOK_SCHED_ACT;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a094694899c9..bd1c42b28483 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -81,6 +81,7 @@
>  #include <net/xdp.h>
>  #include <net/mptcp.h>
>  #include <net/netfilter/nf_conntrack_bpf.h>
> +#include <linux/un.h>
>  
>  static const struct bpf_func_proto *
>  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> @@ -11752,6 +11753,26 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
>  
>  	return 0;
>  }
> +
> +__bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
> +					    const u8 *addr, u32 addrlen__sz)

I'd rename addrlen__sz to sun_path_len or something else because the
conventional addrlen for AF_UNIX contains offsetof(struct sockaddr_un,
sun_path).

Also it would be good to document that the length is of sun_path[].


> +{
> +	struct sockaddr *sa = sa_kern->uaddr;
> +	struct sockaddr_un *un;
> +
> +	if (sa_kern->sk->sk_family != AF_UNIX)
> +		return -EINVAL;
> +
> +	/* We do not allow changing the address of unnamed unix sockets. */

This comment is slightly confusing as addrlen__sz is a user-specified
value for destination address of named sockets except for getsockname().

So, probably we can just remove the comment.  (or s/of/to/ ?)


> +	if (addrlen__sz == 0 || addrlen__sz > UNIX_PATH_MAX)
> +		return -EINVAL;
> +
> +	un = (struct sockaddr_un *)sa;
> +	memcpy(un->sun_path, addr, addrlen__sz);
> +	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + addrlen__sz;
> +
> +	return 0;
> +}
>  __diag_pop();
>  
>  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> @@ -11776,6 +11797,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
>  BTF_SET8_END(bpf_kfunc_check_set_xdp)
>  
> +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> +BTF_ID_FLAGS(func, bpf_sock_addr_set_unix_addr)
> +BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>  	.owner = THIS_MODULE,
>  	.set = &bpf_kfunc_check_set_skb,
> @@ -11786,6 +11811,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
>  	.set = &bpf_kfunc_check_set_xdp,
>  };
>  
> +static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_kfunc_check_set_sock_addr,
> +};
> +
>  static int __init bpf_kfunc_init(void)
>  {
>  	int ret;
> @@ -11800,7 +11830,9 @@ static int __init bpf_kfunc_init(void)
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
> -	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> +						&bpf_kfunc_set_sock_addr);
>  }
>  late_initcall(bpf_kfunc_init);
>  
> -- 
> 2.41.0

