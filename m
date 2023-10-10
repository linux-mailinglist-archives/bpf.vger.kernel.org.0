Return-Path: <bpf+bounces-11816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF47C01F9
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF671C20DD0
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5916FD2;
	Tue, 10 Oct 2023 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AMhsL1Wt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8A2FE22;
	Tue, 10 Oct 2023 16:51:01 +0000 (UTC)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE277DB;
	Tue, 10 Oct 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696956658; x=1728492658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+GD+ccU0M5aAIYzUeQZbl97+pWOGtXZOgKe0hpb44c=;
  b=AMhsL1Wt/SM7fIvrHsG5OFsjLwBSW0dhfCL6qA+2rLy4MJTp/JpgALi4
   Rm2/QXcSVUG2OGzLSTJLSD/JihLX91NF2ZMATaxXBFp14OLQnhuzYP5oq
   Wq0gMHFF6jLcNBf2f2DdQ14Rqiycw2piNN/lMdRIzMz3UBXg4mxUXPey0
   U=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="588268501"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 16:50:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 81EB962A2A;
	Tue, 10 Oct 2023 16:50:54 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 16:50:45 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 16:50:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v9 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
Date: Tue, 10 Oct 2023 09:50:34 -0700
Message-ID: <20231010165034.3539-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006074530.892825-3-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-3-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.11]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Fri,  6 Oct 2023 09:44:56 +0200
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's propagate the sockaddr length back to the caller after running
> a bpf cgroup sockaddr hook program. While not important for AF_INET or
> AF_INET6, the sockaddr length is important when working with AF_UNIX
> sockaddrs as the size of the sockaddr cannot be determined just from the
> address family or the sockaddr's contents.
> 
> __cgroup_bpf_run_filter_sock_addr() is modified to take the uaddrlen as
> an input/output argument. After running the program, the modified sockaddr
> length is stored in the uaddrlen pointer.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  include/linux/bpf-cgroup.h | 73 +++++++++++++++++++-------------------
>  include/linux/filter.h     |  1 +
>  kernel/bpf/cgroup.c        | 20 +++++++++--
>  net/ipv4/af_inet.c         |  7 ++--
>  net/ipv4/ping.c            |  2 +-
>  net/ipv4/tcp_ipv4.c        |  2 +-
>  net/ipv4/udp.c             |  9 +++--
>  net/ipv6/af_inet6.c        |  9 ++---
>  net/ipv6/ping.c            |  2 +-
>  net/ipv6/tcp_ipv6.c        |  2 +-
>  net/ipv6/udp.c             |  6 ++--
>  11 files changed, 78 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 8506690dbb9c..31561e789715 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
>  
>  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  				      struct sockaddr *uaddr,
> +				      int *uaddrlen,
>  				      enum cgroup_bpf_attach_type atype,
>  				      void *t_ctx,
>  				      u32 *flags);
> @@ -230,22 +231,22 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>  #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)				       \
>  	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET6_POST_BIND)
>  
> -#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)				       \
> +#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype)		       \
>  ({									       \
>  	int __ret = 0;							       \
>  	if (cgroup_bpf_enabled(atype))					       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  NULL, NULL);	       \
> +		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
> +							  atype, NULL, NULL);  \
>  	__ret;								       \
>  })
>  
> -#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)		       \
> +#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)	       \
>  ({									       \
>  	int __ret = 0;							       \
>  	if (cgroup_bpf_enabled(atype))	{				       \
>  		lock_sock(sk);						       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  t_ctx, NULL);	       \
> +		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
> +							  atype, t_ctx, NULL); \
>  		release_sock(sk);					       \
>  	}								       \
>  	__ret;								       \
> @@ -256,14 +257,14 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
>   * should be bypassed (BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).
>   */
> -#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, bind_flags)	       \
> +#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, bind_flags) \
>  ({									       \
>  	u32 __flags = 0;						       \
>  	int __ret = 0;							       \
>  	if (cgroup_bpf_enabled(atype))	{				       \
>  		lock_sock(sk);						       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  NULL, &__flags);     \
> +		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
> +							  atype, NULL, &__flags); \
>  		release_sock(sk);					       \
>  		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
>  			*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;	       \
> @@ -276,29 +277,29 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>  	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
>  	 (sk)->sk_prot->pre_connect)
>  
> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)			       \
> -	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET4_CONNECT)
> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT)

Do we need to pass uaddrlen for INET[46] cases ?

The size of AF_INET6? addr is fixed, and we actually need not read
uaddrlen.  Then, we can pass NULL as uaddrlen so that we need not
change the callers of these macros.  Also, it would be clearer that
INET[46] macros do not use uaddrlen.

  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr) \
  -     BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET4_CONNECT)
  +     BPF_CGROUP_RUN_SA_PROG(sk, uaddr, NULL, CGROUP_INET4_CONNECT)


>  
> -#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr)			       \
> -	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET6_CONNECT)
> +#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
>  
> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr)		       \
> -	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET4_CONNECT, NULL)
> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
>  
> -#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr)		       \
> -	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_INET6_CONNECT, NULL)
> +#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
>  
> -#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
> -	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_SENDMSG, t_ctx)
> +#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
>  
> -#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx)		       \
> -	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_SENDMSG, t_ctx)
> +#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
>  
> -#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr)			\
> -	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP4_RECVMSG, NULL)
> +#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
>  
> -#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr)			\
> -	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, CGROUP_UDP6_RECVMSG, NULL)
> +#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
>  
>  /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
>   * fullsock and its parent fullsock cannot be traced by
> @@ -477,24 +478,24 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>  }
>  
>  #define cgroup_bpf_enabled(atype) (0)
> -#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
> -#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype) ({ 0; })
> +#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
>  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
>  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, flags) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 27406aee2d40..a3c74fbe848b 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1335,6 +1335,7 @@ struct bpf_sock_addr_kern {
>  	 */
>  	u64 tmp_reg;
>  	void *t_ctx;	/* Attach type specific context. */
> +	u32 uaddrlen;
>  };
>  
>  struct bpf_sock_ops_kern {
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 03b3d4492980..e6af22316909 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1450,6 +1450,9 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>   *                                       provided by user sockaddr
>   * @sk: sock struct that will use sockaddr
>   * @uaddr: sockaddr struct provided by user
> + * @uaddrlen: Pointer to the size of the sockaddr struct provided by user. It is
> + *            read-only for AF_INET[6] uaddr but can be modified for AF_UNIX
> + *            uaddr.
>   * @atype: The type of program to be executed
>   * @t_ctx: Pointer to attach type specific context
>   * @flags: Pointer to u32 which contains higher bits of BPF program
> @@ -1462,6 +1465,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>   */
>  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  				      struct sockaddr *uaddr,
> +				      int *uaddrlen,
>  				      enum cgroup_bpf_attach_type atype,
>  				      void *t_ctx,
>  				      u32 *flags)
> @@ -1473,6 +1477,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  	};
>  	struct sockaddr_storage unspec;
>  	struct cgroup *cgrp;
> +	int ret;
>  
>  	/* Check socket family since not all sockets represent network
>  	 * endpoint (e.g. AF_UNIX).
> @@ -1483,11 +1488,20 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  	if (!ctx.uaddr) {
>  		memset(&unspec, 0, sizeof(unspec));
>  		ctx.uaddr = (struct sockaddr *)&unspec;
> -	}
> +		ctx.uaddrlen = 0;
> +	} else if (uaddrlen)
> +		ctx.uaddrlen = *uaddrlen;
> +	else
> +		return -EINVAL;

When could uaddrlen be NULL ?


>  
>  	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> -	return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> -				     0, flags);
> +	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> +				    0, flags);
> +
> +	if (!ret && uaddrlen)
> +		*uaddrlen = ctx.uaddrlen;

Now uaddrlen seems always non-NULL, so can't we pass NULL for INET
macros to save hunks below.


> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
>  
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 3d2e30e20473..7e27ad37b939 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -452,7 +452,7 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  	/* BPF prog is run before any checks are done so that if the prog
>  	 * changes context in a wrong way it will be caught.
>  	 */
> -	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
> +	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, &addr_len,
>  						 CGROUP_INET4_BIND, &flags);
>  	if (err)
>  		return err;
> @@ -788,6 +788,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	struct sock *sk		= sock->sk;
>  	struct inet_sock *inet	= inet_sk(sk);
>  	DECLARE_SOCKADDR(struct sockaddr_in *, sin, uaddr);
> +	int sin_addr_len = sizeof(*sin);
>  
>  	sin->sin_family = AF_INET;
>  	lock_sock(sk);
> @@ -800,7 +801,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
>  		}
>  		sin->sin_port = inet->inet_dport;
>  		sin->sin_addr.s_addr = inet->inet_daddr;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
> +		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
>  				       CGROUP_INET4_GETPEERNAME);
>  	} else {
>  		__be32 addr = inet->inet_rcv_saddr;
> @@ -808,7 +809,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
>  			addr = inet->inet_saddr;
>  		sin->sin_port = inet->inet_sport;
>  		sin->sin_addr.s_addr = addr;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
> +		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
>  				       CGROUP_INET4_GETSOCKNAME);
>  	}
>  	release_sock(sk);
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 4dd809b7b188..2887177822c9 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -301,7 +301,7 @@ static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
>  	if (addr_len < sizeof(struct sockaddr_in))
>  		return -EINVAL;
>  
> -	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
>  }
>  
>  /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f13eb7e23d03..7c18dd3ce011 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -194,7 +194,7 @@ static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
>  
>  	sock_owned_by_me(sk);
>  
> -	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, &addr_len);
>  }
>  
>  /* This will initiate an outgoing connection. */
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c3ff984b6354..7b21a51dd25a 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1143,7 +1143,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
>  		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
> -					    (struct sockaddr *)usin, &ipc.addr);
> +					    (struct sockaddr *)usin,
> +					    &msg->msg_namelen,
> +					    &ipc.addr);
>  		if (err)
>  			goto out_free;
>  		if (usin) {
> @@ -1865,7 +1867,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
>  		*addr_len = sizeof(*sin);
>  
>  		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
> -						      (struct sockaddr *)sin);
> +						      (struct sockaddr *)sin,
> +						      addr_len);
>  	}
>  
>  	if (udp_test_bit(GRO_ENABLED, sk))
> @@ -1904,7 +1907,7 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  	if (addr_len < sizeof(struct sockaddr_in))
>  		return -EINVAL;
>  
> -	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
>  }
>  EXPORT_SYMBOL(udp_pre_connect);
>  
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index c6ad0d6e99b5..f5817f8150dd 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -454,7 +454,7 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  	/* BPF prog is run before any checks are done so that if the prog
>  	 * changes context in a wrong way it will be caught.
>  	 */
> -	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr,
> +	err = BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, &addr_len,
>  						 CGROUP_INET6_BIND, &flags);
>  	if (err)
>  		return err;
> @@ -520,6 +520,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
>  		  int peer)
>  {
>  	struct sockaddr_in6 *sin = (struct sockaddr_in6 *)uaddr;
> +	int sin_addr_len = sizeof(*sin);
>  	struct sock *sk = sock->sk;
>  	struct inet_sock *inet = inet_sk(sk);
>  	struct ipv6_pinfo *np = inet6_sk(sk);
> @@ -539,7 +540,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
>  		sin->sin6_addr = sk->sk_v6_daddr;
>  		if (inet6_test_bit(SNDFLOW, sk))
>  			sin->sin6_flowinfo = np->flow_label;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
> +		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
>  				       CGROUP_INET6_GETPEERNAME);
>  	} else {
>  		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
> @@ -547,13 +548,13 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
>  		else
>  			sin->sin6_addr = sk->sk_v6_rcv_saddr;
>  		sin->sin6_port = inet->inet_sport;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
> +		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
>  				       CGROUP_INET6_GETSOCKNAME);
>  	}
>  	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
>  						 sk->sk_bound_dev_if);
>  	release_sock(sk);
> -	return sizeof(*sin);
> +	return sin_addr_len;
>  }
>  EXPORT_SYMBOL(inet6_getname);
>  
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index e8fb0d275cc2..d2098dd4ceae 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -56,7 +56,7 @@ static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
>  	if (addr_len < SIN6_LEN_RFC2133)
>  		return -EINVAL;
>  
> -	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
>  }
>  
>  static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 94afb8d0f2d0..3a1e76a2d33e 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -135,7 +135,7 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
>  
>  	sock_owned_by_me(sk);
>  
> -	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
>  }
>  
>  static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 5e9312eefed0..622b10a549f7 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -410,7 +410,8 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		*addr_len = sizeof(*sin6);
>  
>  		BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk,
> -						      (struct sockaddr *)sin6);
> +						      (struct sockaddr *)sin6,
> +						      addr_len);
>  	}
>  
>  	if (udp_test_bit(GRO_ENABLED, sk))
> @@ -1157,7 +1158,7 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
>  	if (addr_len < SIN6_LEN_RFC2133)
>  		return -EINVAL;
>  
> -	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr);
> +	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
>  }
>  
>  /**
> @@ -1510,6 +1511,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
>  		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
>  					   (struct sockaddr *)sin6,
> +					   &addr_len,
>  					   &fl6->saddr);
>  		if (err)
>  			goto out_no_dst;
> -- 
> 2.41.0

