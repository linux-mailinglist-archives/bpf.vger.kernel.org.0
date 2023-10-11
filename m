Return-Path: <bpf+bounces-11945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A37C5AAD
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0A1C20FB0
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994C3995C;
	Wed, 11 Oct 2023 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TRgBegkH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EC3993F;
	Wed, 11 Oct 2023 17:58:56 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E17FE1;
	Wed, 11 Oct 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697047135; x=1728583135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOGQWiFnWglSLhNSIIXiCn7OerwS7IFFwVfjw1g+k34=;
  b=TRgBegkH40n7wLO8oXByTv+wS5x4EdSiV1xgPwYKaaqv0J54pnF1RX4F
   +UzwEb8/J4SpPV9EPX5Slub7mK/LA1o0V5TbNV4g5AvD1l44F1qKvP+VQ
   wF0LmrMPLq48auJVEztW4NdW+oLBI4PZZnpGQ6Ow633oXyByyEFSrDmf+
   I=;
X-IronPort-AV: E=Sophos;i="6.03,216,1694736000"; 
   d="scan'208";a="369255882"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 17:58:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 68E4E804DC;
	Wed, 11 Oct 2023 17:58:45 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 17:58:43 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 17:58:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v10 3/9] bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
Date: Wed, 11 Oct 2023 10:58:33 -0700
Message-ID: <20231011175833.45358-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231011170321.73950-4-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-4-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.62]
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 11 Oct 2023 19:03:12 +0200
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set_sun_path() that allows modifying a unix
> sockaddr from bpf. While this is already possible for AF_INET and AF_INET6,
> we'll need this kfunc when we add unix socket support since modifying the
> address for those requires modifying both the address and the sockaddr
> length.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  kernel/bpf/btf.c  |  1 +
>  net/core/filter.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
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
> index a094694899c9..12fbd8a560c8 100644
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
> @@ -11752,6 +11753,32 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
>  
>  	return 0;
>  }
> +
> +__bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
> +					   const u8 *sun_path, u32 sun_path__sz)
> +{
> +	struct sockaddr *sa = sa_kern->uaddr;
> +	struct sockaddr_un *un;
> +
> +	if (sa_kern->sk->sk_family != AF_UNIX)
> +		return -EINVAL;
> +
> +	/* We do not allow changing the address of unnamed unix sockets. */
> +	if (sa_kern->uaddrlen == 0)
> +		return -EINVAL;

Instead of adding this check, you can call the hooks after
unix_validate_addr() in connect() and sendmsg().

In unix_getname(), you can move up the bpf hooks into the else
branch below.

    if (!addr) {
        ...
    } else {
        ...
        <-- here
    }


> +
> +	/* We do not allow changing the address to unnamed or larger than the
> +	 * maximum allowed address size for a unix sockaddr.
> +	 */
> +	if (sun_path__sz == 0 || sun_path__sz > UNIX_PATH_MAX)
> +		return -EINVAL;
> +
> +	un = (struct sockaddr_un *)sa;
> +	memcpy(un->sun_path, sun_path, sun_path__sz);
> +	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
> +
> +	return 0;
> +}
>  __diag_pop();
>  
>  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> @@ -11776,6 +11803,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
>  BTF_SET8_END(bpf_kfunc_check_set_xdp)
>  
> +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> +BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
> +BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>  	.owner = THIS_MODULE,
>  	.set = &bpf_kfunc_check_set_skb,
> @@ -11786,6 +11817,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
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
> @@ -11800,7 +11836,9 @@ static int __init bpf_kfunc_init(void)
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

