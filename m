Return-Path: <bpf+bounces-10988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6AA7B0EEC
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 00:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 92E90282117
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742C5384;
	Wed, 27 Sep 2023 22:32:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8110F9
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 22:32:46 +0000 (UTC)
Received: from out-193.mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A62102
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:32:42 -0700 (PDT)
Message-ID: <f78069e0-9885-b3ab-4ad7-8abe94b9ad0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695853959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYhPt0WbV+kQzTZ03d5exi5Qvxj5uV0S90OfqsTWgvI=;
	b=w9Fg/yzScPo2UrkJuJ5C3NmBOio4wNn5BsO7aPtqlymDZB3jQapgm+Ow59ZQNCaxT290dJ
	0zS9+ipjmjg3Iq+Da+Er7NKNpcEDdroGVukAiJ3aQP0roC7PBrMK40vf2iW6zbXVDWx+uQ
	rDtP8eQ1qG+Rs5t/1oM0cbk3FPcsdZw=
Date: Wed, 27 Sep 2023 15:32:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
 <20230926202753.1482200-5-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230926202753.1482200-5-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/26/23 1:27 PM, Daan De Meyer wrote:
> These hooks allows intercepting connect(), getsockname(),
> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> socket hooks get write access to the address length because the
> address length is not fixed when dealing with unix sockets and
> needs to be modified when a unix socket address is modified by
> the hook. Because abstract socket unix addresses start with a
> NUL byte, we cannot recalculate the socket address in kernelspace
> after running the hook by calculating the length of the unix socket
> path using strlen().
> 
> These hooks can be used when users want to multiplex syscall to a
> single unix socket to multiple different processes behind the scenes
> by redirecting the connect() and other syscalls to process specific
> sockets.
> 
> We do not implement support for intercepting bind() because when
> using bind() with unix sockets with a pathname address, this creates
> an inode in the filesystem which must be cleaned up. If we rewrite
> the address, the user might try to clean up the wrong file, leaking
> the socket in the filesystem where it is never cleaned up. Until we
> figure out a solution for this (and a use case for intercepting bind()),
> we opt to not allow rewriting the sockaddr in bind() calls.

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 31561e789715..c069f3510365 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -48,19 +48,24 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
>   	CGROUP_ATYPE(CGROUP_INET6_BIND);
>   	CGROUP_ATYPE(CGROUP_INET4_CONNECT);
>   	CGROUP_ATYPE(CGROUP_INET6_CONNECT);
> +	CGROUP_ATYPE(CGROUP_UNIX_CONNECT);
>   	CGROUP_ATYPE(CGROUP_INET4_POST_BIND);
>   	CGROUP_ATYPE(CGROUP_INET6_POST_BIND);
>   	CGROUP_ATYPE(CGROUP_UDP4_SENDMSG);
>   	CGROUP_ATYPE(CGROUP_UDP6_SENDMSG);
> +	CGROUP_ATYPE(CGROUP_UNIX_SENDMSG);
>   	CGROUP_ATYPE(CGROUP_SYSCTL);
>   	CGROUP_ATYPE(CGROUP_UDP4_RECVMSG);
>   	CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
> +	CGROUP_ATYPE(CGROUP_UNIX_RECVMSG);
>   	CGROUP_ATYPE(CGROUP_GETSOCKOPT);
>   	CGROUP_ATYPE(CGROUP_SETSOCKOPT);
>   	CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
>   	CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
> +	CGROUP_ATYPE(CGROUP_UNIX_GETPEERNAME);
>   	CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
>   	CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
> +	CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
>   	CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
>   	default:
>   		return CGROUP_BPF_ATTACH_TYPE_INVALID;
> @@ -283,24 +288,36 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)			\
>   	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT)
> +

Remove the no _LOCK version because it is not used.

>   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
>   
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)
> +
>   #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
>   
>   #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_SENDMSG, t_ctx)
> +
>   #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
>   
>   #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_RECVMSG, NULL)
> +
>   /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
>    * fullsock and its parent fullsock cannot be traced by
>    * sk_to_full_sk().
> @@ -492,10 +509,14 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen) ({ 0; })

Same here. Not needed.

> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })

[ ... ]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index ba2c57cf4046..4a4e3b1f00b1 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1455,7 +1455,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>    * @flags: Pointer to u32 which contains higher bits of BPF program
>    *         return value (OR'ed together).
>    *
> - * socket is expected to be of type INET or INET6.
> + * socket is expected to be of type INET, INET6 or UNIX.
>    *
>    * This function will return %-EPERM if an attached program is found and
>    * returned value != 1 during execution. In all other cases, 0 is returned.
> @@ -1479,7 +1479,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   	/* Check socket family since not all sockets represent network
>   	 * endpoint (e.g. AF_UNIX).
>   	 */
> -	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
> +	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
> +		sk->sk_family != AF_UNIX)

./scripts/checkpatch.pl --strict:

CHECK: Alignment should match open parenthesis
#211: FILE: kernel/bpf/cgroup.c:1483:
+	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
+		sk->sk_family != AF_UNIX)

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd1c42b28483..956f413e98a3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7829,6 +7829,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		switch (prog->expected_attach_type) {
>   		case BPF_CGROUP_INET4_CONNECT:
>   		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>   			return &bpf_bind_proto;

bpf_bind support is still not removed...

[ ... ]

> @@ -2744,6 +2773,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
>   					 state->msg->msg_name);
>   			unix_copy_addr(state->msg, skb->sk);
> +
> +			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> +							      state->msg->msg_name,
> +							      &state->msg->msg_namelen);
> +

Re-pasting the comment from v5:

it will be useful to mention the reason in the commit message in case we need to 
look back a few months later why only recvmsg is supported but not sendmsg for 
connected stream.


