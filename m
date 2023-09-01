Return-Path: <bpf+bounces-9120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE3790281
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF5280D5A
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513BC8ED;
	Fri,  1 Sep 2023 19:34:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428CC136;
	Fri,  1 Sep 2023 19:34:55 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967D10E0;
	Fri,  1 Sep 2023 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693596893; x=1725132893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0sjN+DpzgAIpX6cjAlkmDFxsN+1G6pPyHr/Ys16WsA=;
  b=bZ/pSRTcc5wxZ6VvTdMEg17PzyxCEcMFvxERRu61Y17+IvEFC6IoaIq7
   exi9qp7Lr4vRLUz0/8CuSUafbmZWjxoQ2+qO7mwTVRhkytu5zBW5BNyMP
   ltgLH41+FQ/gtpIQsFgfTZkjQTdKxnuO5hi/PW8dMqYRHvgO0Qy2hf9U8
   s=;
X-IronPort-AV: E=Sophos;i="6.02,220,1688428800"; 
   d="scan'208";a="236692927"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 19:34:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 7C54F40DEF;
	Fri,  1 Sep 2023 19:34:50 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 19:34:47 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 19:34:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Implement cgroup sockaddr hooks for unix sockets
Date: Fri, 1 Sep 2023 12:34:37 -0700
Message-ID: <20230901193437.36868-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230831153455.1867110-5-daan.j.demeyer@gmail.com>
References: <20230831153455.1867110-5-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.14]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 31 Aug 2023 17:34:48 +0200
> These hooks allows intercepting bind(), connect(), getsockname(),
> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> socket hooks get write access to the address length because the
> address length is not fixed when dealing with unix sockets and
> needs to be modified when a unix socket address is modified by
> the hook. Because abstract socket unix addresses start with a
> NUL byte, we cannot recalculate the socket address in kernelspace
> after running the hook by calculating the length of the unix socket
> path using strlen().
> 
> Write support is added for uaddrlen to allow the unix socket hooks
> to modify the sockaddr length from the bpf program.
> 
> This hook can be used when users want to multiplex syscall to a
> single unix socket to multiple different processes behind the scenes
> by redirecting the connect() and other syscalls to process specific
> sockets.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  include/linux/bpf-cgroup-defs.h |  6 +++
>  include/linux/bpf-cgroup.h      | 29 ++++++++++-
>  include/uapi/linux/bpf.h        | 14 +++--
>  kernel/bpf/cgroup.c             | 13 ++++-
>  kernel/bpf/syscall.c            | 18 +++++++
>  kernel/bpf/verifier.c           |  7 ++-
>  net/core/filter.c               | 18 ++++++-
>  net/unix/af_unix.c              | 90 ++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h  | 14 +++--
>  9 files changed, 187 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> index 7b121bd780eb..8196ccb81915 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -26,21 +26,27 @@ enum cgroup_bpf_attach_type {
>  	CGROUP_DEVICE,
>  	CGROUP_INET4_BIND,
>  	CGROUP_INET6_BIND,
> +	CGROUP_UNIX_BIND,
>  	CGROUP_INET4_CONNECT,
>  	CGROUP_INET6_CONNECT,
> +	CGROUP_UNIX_CONNECT,
>  	CGROUP_INET4_POST_BIND,
>  	CGROUP_INET6_POST_BIND,
>  	CGROUP_UDP4_SENDMSG,
>  	CGROUP_UDP6_SENDMSG,
> +	CGROUP_UNIX_SENDMSG,
>  	CGROUP_SYSCTL,
>  	CGROUP_UDP4_RECVMSG,
>  	CGROUP_UDP6_RECVMSG,
> +	CGROUP_UNIX_RECVMSG,
>  	CGROUP_GETSOCKOPT,
>  	CGROUP_SETSOCKOPT,
>  	CGROUP_INET4_GETPEERNAME,
>  	CGROUP_INET6_GETPEERNAME,
> +	CGROUP_UNIX_GETPEERNAME,
>  	CGROUP_INET4_GETSOCKNAME,
>  	CGROUP_INET6_GETSOCKNAME,
> +	CGROUP_UNIX_GETSOCKNAME,
>  	CGROUP_INET_SOCK_RELEASE,
>  	CGROUP_LSM_START,
>  	CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 31561e789715..0d572228fa62 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -46,21 +46,27 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
>  	CGROUP_ATYPE(CGROUP_DEVICE);
>  	CGROUP_ATYPE(CGROUP_INET4_BIND);
>  	CGROUP_ATYPE(CGROUP_INET6_BIND);
> +	CGROUP_ATYPE(CGROUP_UNIX_BIND);
>  	CGROUP_ATYPE(CGROUP_INET4_CONNECT);
>  	CGROUP_ATYPE(CGROUP_INET6_CONNECT);
> +	CGROUP_ATYPE(CGROUP_UNIX_CONNECT);
>  	CGROUP_ATYPE(CGROUP_INET4_POST_BIND);
>  	CGROUP_ATYPE(CGROUP_INET6_POST_BIND);
>  	CGROUP_ATYPE(CGROUP_UDP4_SENDMSG);
>  	CGROUP_ATYPE(CGROUP_UDP6_SENDMSG);
> +	CGROUP_ATYPE(CGROUP_UNIX_SENDMSG);
>  	CGROUP_ATYPE(CGROUP_SYSCTL);
>  	CGROUP_ATYPE(CGROUP_UDP4_RECVMSG);
>  	CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
> +	CGROUP_ATYPE(CGROUP_UNIX_RECVMSG);
>  	CGROUP_ATYPE(CGROUP_GETSOCKOPT);
>  	CGROUP_ATYPE(CGROUP_SETSOCKOPT);
>  	CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
>  	CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
> +	CGROUP_ATYPE(CGROUP_UNIX_GETPEERNAME);
>  	CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
>  	CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
> +	CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
>  	CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
>  	default:
>  		return CGROUP_BPF_ATTACH_TYPE_INVALID;
> @@ -272,9 +278,13 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>  	__ret;								       \
>  })
>  
> +#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_BIND, NULL)
> +
>  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
>  	((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||		       \
> -	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
> +	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT) ||		       \
> +	  cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) &&		       \
>  	 (sk)->sk_prot->pre_connect)

Do we need this change ?
AF_UNIX does not have pre_connect().


>  
>  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)			\
> @@ -283,24 +293,36 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>  #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)			\
>  	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
>  
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT)
> +
>  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
>  	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
>  
>  #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
>  	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
>  
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)
> +
>  #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
>  	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
>  
>  #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
>  	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
>  
> +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_SENDMSG, t_ctx)
> +
>  #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
>  	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
>  
>  #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
>  	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
>  
> +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_RECVMSG, NULL)
> +
>  /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
>   * fullsock and its parent fullsock cannot be traced by
>   * sk_to_full_sk().
> @@ -486,16 +508,21 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>  #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8790b3962e4b..c51889d7e5d8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1040,6 +1040,12 @@ enum bpf_attach_type {
>  	BPF_TCX_INGRESS,
>  	BPF_TCX_EGRESS,
>  	BPF_TRACE_UPROBE_MULTI,
> +	BPF_CGROUP_UNIX_BIND,
> +	BPF_CGROUP_UNIX_CONNECT,
> +	BPF_CGROUP_UNIX_SENDMSG,
> +	BPF_CGROUP_UNIX_RECVMSG,
> +	BPF_CGROUP_UNIX_GETPEERNAME,
> +	BPF_CGROUP_UNIX_GETSOCKNAME,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> @@ -2695,8 +2701,8 @@ union bpf_attr {
>   * 		*bpf_socket* should be one of the following:
>   *
>   * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> - * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
> - * 		  and **BPF_CGROUP_INET6_CONNECT**.
> + * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
> + * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
>   *
>   * 		This helper actually implements a subset of **setsockopt()**.
>   * 		It supports the following *level*\ s:
> @@ -2934,8 +2940,8 @@ union bpf_attr {
>   * 		*bpf_socket* should be one of the following:
>   *
>   * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> - * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
> - * 		  and **BPF_CGROUP_INET6_CONNECT**.
> + * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
> + * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
>   *
>   * 		This helper actually implements a subset of **getsockopt()**.
>   * 		It supports the same set of *optname*\ s that is supported by
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 534b6c7f5659..f2304f69016f 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1455,7 +1455,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>   * @flags: Pointer to u32 which contains higher bits of BPF program
>   *         return value (OR'ed together).
>   *
> - * socket is expected to be of type INET or INET6.
> + * socket is expected to be of type INET, INET6 or UNIX.
>   *
>   * This function will return %-EPERM if an attached program is found and
>   * returned value != 1 during execution. In all other cases, 0 is returned.
> @@ -1479,7 +1479,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  	/* Check socket family since not all sockets represent network
>  	 * endpoint (e.g. AF_UNIX).
>  	 */
> -	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
> +	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
> +		sk->sk_family != AF_UNIX)
>  		return 0;
>  
>  	if (!ctx.uaddr) {
> @@ -1492,6 +1493,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  		ctx.uaddrlen = sizeof(struct sockaddr_in);
>  	else if (sk->sk_family == AF_INET6)
>  		ctx.uaddrlen = sizeof(struct sockaddr_in6);
> +	else if (sk->sk_family == AF_UNIX)
> +		return -EINVAL; /* uaddrlen must always be provided for AF_UNIX. */
>  
>  	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
>  	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> @@ -2533,10 +2536,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		case BPF_CGROUP_SOCK_OPS:
>  		case BPF_CGROUP_UDP4_RECVMSG:
>  		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  			return NULL;
>  		default:
>  			return &bpf_get_retval_proto;
> @@ -2548,10 +2554,13 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		case BPF_CGROUP_SOCK_OPS:
>  		case BPF_CGROUP_UDP4_RECVMSG:
>  		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  			return NULL;
>  		default:
>  			return &bpf_set_retval_proto;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ebeb0695305a..eb47e93bcce6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2440,16 +2440,22 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
>  		switch (expected_attach_type) {
>  		case BPF_CGROUP_INET4_BIND:
>  		case BPF_CGROUP_INET6_BIND:
> +		case BPF_CGROUP_UNIX_BIND:
>  		case BPF_CGROUP_INET4_CONNECT:
>  		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  		case BPF_CGROUP_UDP4_SENDMSG:
>  		case BPF_CGROUP_UDP6_SENDMSG:
> +		case BPF_CGROUP_UNIX_SENDMSG:
>  		case BPF_CGROUP_UDP4_RECVMSG:
>  		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>  			return 0;
>  		default:
>  			return -EINVAL;
> @@ -3670,16 +3676,22 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
>  		return BPF_PROG_TYPE_CGROUP_SOCK;
>  	case BPF_CGROUP_INET4_BIND:
>  	case BPF_CGROUP_INET6_BIND:
> +	case BPF_CGROUP_UNIX_BIND:
>  	case BPF_CGROUP_INET4_CONNECT:
>  	case BPF_CGROUP_INET6_CONNECT:
> +	case BPF_CGROUP_UNIX_CONNECT:
>  	case BPF_CGROUP_INET4_GETPEERNAME:
>  	case BPF_CGROUP_INET6_GETPEERNAME:
> +	case BPF_CGROUP_UNIX_GETPEERNAME:
>  	case BPF_CGROUP_INET4_GETSOCKNAME:
>  	case BPF_CGROUP_INET6_GETSOCKNAME:
> +	case BPF_CGROUP_UNIX_GETSOCKNAME:
>  	case BPF_CGROUP_UDP4_SENDMSG:
>  	case BPF_CGROUP_UDP6_SENDMSG:
> +	case BPF_CGROUP_UNIX_SENDMSG:
>  	case BPF_CGROUP_UDP4_RECVMSG:
>  	case BPF_CGROUP_UDP6_RECVMSG:
> +	case BPF_CGROUP_UNIX_RECVMSG:
>  		return BPF_PROG_TYPE_CGROUP_SOCK_ADDR;
>  	case BPF_CGROUP_SOCK_OPS:
>  		return BPF_PROG_TYPE_SOCK_OPS;
> @@ -3932,18 +3944,24 @@ static int bpf_prog_query(const union bpf_attr *attr,
>  	case BPF_CGROUP_INET_SOCK_RELEASE:
>  	case BPF_CGROUP_INET4_BIND:
>  	case BPF_CGROUP_INET6_BIND:
> +	case BPF_CGROUP_UNIX_BIND:
>  	case BPF_CGROUP_INET4_POST_BIND:
>  	case BPF_CGROUP_INET6_POST_BIND:
>  	case BPF_CGROUP_INET4_CONNECT:
>  	case BPF_CGROUP_INET6_CONNECT:
> +	case BPF_CGROUP_UNIX_CONNECT:
>  	case BPF_CGROUP_INET4_GETPEERNAME:
>  	case BPF_CGROUP_INET6_GETPEERNAME:
> +	case BPF_CGROUP_UNIX_GETPEERNAME:
>  	case BPF_CGROUP_INET4_GETSOCKNAME:
>  	case BPF_CGROUP_INET6_GETSOCKNAME:
> +	case BPF_CGROUP_UNIX_GETSOCKNAME:
>  	case BPF_CGROUP_UDP4_SENDMSG:
>  	case BPF_CGROUP_UDP6_SENDMSG:
> +	case BPF_CGROUP_UNIX_SENDMSG:
>  	case BPF_CGROUP_UDP4_RECVMSG:
>  	case BPF_CGROUP_UDP6_RECVMSG:
> +	case BPF_CGROUP_UNIX_RECVMSG:
>  	case BPF_CGROUP_SOCK_OPS:
>  	case BPF_CGROUP_DEVICE:
>  	case BPF_CGROUP_SYSCTL:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0680569f9bd0..d8f508c56055 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14540,14 +14540,19 @@ static int check_return_code(struct bpf_verifier_env *env)
>  	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>  		if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
>  		    env->prog->expected_attach_type == BPF_CGROUP_UDP6_RECVMSG ||
> +		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_RECVMSG ||
>  		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETPEERNAME ||
>  		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETPEERNAME ||
> +		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETPEERNAME ||
>  		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
> -		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME)
> +		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME ||
> +		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETSOCKNAME)
>  			range = tnum_range(1, 1);
>  		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
>  		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND)
>  			range = tnum_range(0, 3);
> +		if (env->prog->expected_attach_type == BPF_CGROUP_UNIX_BIND)
> +			range = tnum_range(0, 1);
>  		break;
>  	case BPF_PROG_TYPE_CGROUP_SKB:
>  		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3ed6cd33b268..be4e0e923aa6 100644
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
> @@ -7828,6 +7829,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		switch (prog->expected_attach_type) {
>  		case BPF_CGROUP_INET4_CONNECT:
>  		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>  			return &bpf_bind_proto;
>  		default:
>  			return NULL;
> @@ -7856,16 +7858,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		switch (prog->expected_attach_type) {
>  		case BPF_CGROUP_INET4_BIND:
>  		case BPF_CGROUP_INET6_BIND:
> +		case BPF_CGROUP_UNIX_BIND:
>  		case BPF_CGROUP_INET4_CONNECT:
>  		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>  		case BPF_CGROUP_UDP4_RECVMSG:
>  		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>  		case BPF_CGROUP_UDP4_SENDMSG:
>  		case BPF_CGROUP_UDP6_SENDMSG:
> +		case BPF_CGROUP_UNIX_SENDMSG:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  			return &bpf_sock_addr_setsockopt_proto;
>  		default:
>  			return NULL;
> @@ -7874,16 +7882,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		switch (prog->expected_attach_type) {
>  		case BPF_CGROUP_INET4_BIND:
>  		case BPF_CGROUP_INET6_BIND:
> +		case BPF_CGROUP_UNIX_BIND:
>  		case BPF_CGROUP_INET4_CONNECT:
>  		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>  		case BPF_CGROUP_UDP4_RECVMSG:
>  		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>  		case BPF_CGROUP_UDP4_SENDMSG:
>  		case BPF_CGROUP_UDP6_SENDMSG:
> +		case BPF_CGROUP_UNIX_SENDMSG:
>  		case BPF_CGROUP_INET4_GETPEERNAME:
>  		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>  		case BPF_CGROUP_INET4_GETSOCKNAME:
>  		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>  			return &bpf_sock_addr_getsockopt_proto;
>  		default:
>  			return NULL;
> @@ -8931,8 +8945,8 @@ static bool sock_addr_is_valid_access(int off, int size,
>  	if (off % size != 0)
>  		return false;
>  
> -	/* Disallow access to IPv6 fields from IPv4 contex and vise
> -	 * versa.
> +	/* Disallow access to fields not belonging to the attach type's address
> +	 * family.
>  	 */
>  	switch (off) {
>  	case bpf_ctx_range(struct bpf_sock_addr, user_ip4):
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 86930a8ed012..94fd6f2441d8 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -116,6 +116,7 @@
>  #include <linux/freezer.h>
>  #include <linux/file.h>
>  #include <linux/btf_ids.h>
> +#include <linux/bpf-cgroup.h>
>  
>  #include "scm.h"
>  
> @@ -1323,6 +1324,12 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  	struct sock *sk = sock->sk;
>  	int err;
>  
> +	if (cgroup_bpf_enabled(CGROUP_UNIX_BIND)) {
> +		err = BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, &addr_len);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (addr_len == offsetof(struct sockaddr_un, sun_path) &&
>  	    sunaddr->sun_family == AF_UNIX)
>  		return unix_autobind(sk);
> @@ -1377,6 +1384,13 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
>  		goto out;
>  
>  	if (addr->sa_family != AF_UNSPEC) {
> +		if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
> +			err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, addr,
> +								    &alen);
> +			if (err)
> +				goto out;
> +		}
> +
>  		err = unix_validate_addr(sunaddr, alen);
>  		if (err)
>  			goto out;
> @@ -1486,6 +1500,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  	int err;
>  	int st;
>  
> +	if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
> +		err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr,
> +							    &addr_len);
> +		if (err)
> +			goto out;
> +	}
> +
>  	err = unix_validate_addr(sunaddr, addr_len);
>  	if (err)
>  		goto out;
> @@ -1749,7 +1770,7 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>  	struct sock *sk = sock->sk;
>  	struct unix_address *addr;
>  	DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, uaddr);
> -	int err = 0;
> +	int addr_len = 0, err = 0;
>  
>  	if (peer) {
>  		sk = unix_peer_get(sk);
> @@ -1766,14 +1787,37 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>  	if (!addr) {
>  		sunaddr->sun_family = AF_UNIX;
>  		sunaddr->sun_path[0] = 0;
> -		err = offsetof(struct sockaddr_un, sun_path);
> +		addr_len = offsetof(struct sockaddr_un, sun_path);
>  	} else {
> -		err = addr->len;
> +		addr_len = addr->len;
>  		memcpy(sunaddr, addr->name, addr->len);
>  	}
> +
> +	if (peer && cgroup_bpf_enabled(CGROUP_UNIX_GETPEERNAME)) {
> +		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
> +					     CGROUP_UNIX_GETPEERNAME);
> +		if (err)
> +			goto out;
> +
> +		err = unix_validate_addr(sunaddr, addr_len);
> +		if (err)
> +			goto out;
> +	}
> +
> +	if (!peer && cgroup_bpf_enabled(CGROUP_UNIX_GETSOCKNAME)) {
> +		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
> +					     CGROUP_UNIX_GETSOCKNAME);
> +		if (err)
> +			goto out;
> +
> +		err = unix_validate_addr(sunaddr, addr_len);
> +		if (err)
> +			goto out;
> +	}
> +
>  	sock_put(sk);
>  out:
> -	return err;
> +	return err ?: addr_len;
>  }
>  
>  static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
> @@ -1919,6 +1963,15 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  		goto out;
>  
>  	if (msg->msg_namelen) {
> +		if (cgroup_bpf_enabled(CGROUP_UNIX_SENDMSG)) {
> +			err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
> +								    msg->msg_name,
> +								    &msg->msg_namelen,
> +								    NULL);
> +			if (err)
> +				goto out;
> +		}
> +
>  		err = unix_validate_addr(sunaddr, msg->msg_namelen);
>  		if (err)
>  			goto out;
> @@ -2328,14 +2381,30 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
>  	return unix_dgram_recvmsg(sock, msg, size, flags);
>  }
>  
> -static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
> +static int unix_recvmsg_copy_addr(struct msghdr *msg, struct sock *sk)
>  {
>  	struct unix_address *addr = smp_load_acquire(&unix_sk(sk)->addr);
> +	int err;
>  
>  	if (addr) {
>  		msg->msg_namelen = addr->len;
>  		memcpy(msg->msg_name, addr->name, addr->len);
> +
> +		if (cgroup_bpf_enabled(CGROUP_UNIX_RECVMSG)) {
> +			err = BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> +								    msg->msg_name,
> +								    &msg->msg_namelen);
> +			if (err)
> +				return err;
> +
> +			err = unix_validate_addr(msg->msg_name,
> +						 msg->msg_namelen);
> +			if (err)
> +				return err;
> +		}
>  	}
> +
> +	return 0;
>  }
>  
>  int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
> @@ -2390,8 +2459,11 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>  						EPOLLOUT | EPOLLWRNORM |
>  						EPOLLWRBAND);
>  
> -	if (msg->msg_name)
> -		unix_copy_addr(msg, skb->sk);
> +	if (msg->msg_name) {
> +		err = unix_recvmsg_copy_addr(msg, skb->sk);
> +		if (err)
> +			goto out_free;
> +	}
>  
>  	if (size > skb->len - skip)
>  		size = skb->len - skip;
> @@ -2743,7 +2815,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  		if (state->msg && state->msg->msg_name) {
>  			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
>  					 state->msg->msg_name);
> -			unix_copy_addr(state->msg, skb->sk);
> +			err = unix_recvmsg_copy_addr(state->msg, skb->sk);
> +			if (err)
> +				break;
>  			sunaddr = NULL;
>  		}
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 8790b3962e4b..c51889d7e5d8 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1040,6 +1040,12 @@ enum bpf_attach_type {
>  	BPF_TCX_INGRESS,
>  	BPF_TCX_EGRESS,
>  	BPF_TRACE_UPROBE_MULTI,
> +	BPF_CGROUP_UNIX_BIND,
> +	BPF_CGROUP_UNIX_CONNECT,
> +	BPF_CGROUP_UNIX_SENDMSG,
> +	BPF_CGROUP_UNIX_RECVMSG,
> +	BPF_CGROUP_UNIX_GETPEERNAME,
> +	BPF_CGROUP_UNIX_GETSOCKNAME,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> @@ -2695,8 +2701,8 @@ union bpf_attr {
>   * 		*bpf_socket* should be one of the following:
>   *
>   * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> - * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
> - * 		  and **BPF_CGROUP_INET6_CONNECT**.
> + * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
> + * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
>   *
>   * 		This helper actually implements a subset of **setsockopt()**.
>   * 		It supports the following *level*\ s:
> @@ -2934,8 +2940,8 @@ union bpf_attr {
>   * 		*bpf_socket* should be one of the following:
>   *
>   * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> - * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
> - * 		  and **BPF_CGROUP_INET6_CONNECT**.
> + * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
> + * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
>   *
>   * 		This helper actually implements a subset of **getsockopt()**.
>   * 		It supports the same set of *optname*\ s that is supported by
> -- 
> 2.41.0

