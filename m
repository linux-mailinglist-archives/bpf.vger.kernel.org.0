Return-Path: <bpf+bounces-9293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC737930DE
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 23:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A7628104A
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1283FC1D;
	Tue,  5 Sep 2023 21:21:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5BDF6E
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 21:21:11 +0000 (UTC)
Received: from out-229.mta0.migadu.com (out-229.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970D109
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 14:21:08 -0700 (PDT)
Message-ID: <c73a6a41-9e05-c473-0e46-56d0fcfb9ac8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693948866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNTk6Yo9m7FscLZdoiGNW5dIwBabF662OJ2IDixcREg=;
	b=Uc1KP79VmL/7W6iMoGhhXmMS365V3G3mXbX8QnZch6hFp5CjoaAG0d3hE6NOMnsrFq5rMr
	5AiAcYxCl1RA6VZPLkcDN1NZ2OtVFxoocF+woiWAF8NteWgbssBJjrsRm5kJUbH0yVfXC2
	ddyZ1K2EQ/YdsHFZfPrL1S6el0QqFLk=
Date: Tue, 5 Sep 2023 14:21:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-3-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230831153455.1867110-3-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 8:34 AM, Daan De Meyer wrote:
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's propagate the sockaddr length back to the caller after running
> a bpf cgroup sockaddr hook program. While not important for AF_INET or
> AF_INET6, the sockaddr length is important when working with AF_UNIX
> sockaddrs as the size of the sockaddr cannot be determined just from the
> address family or the sockaddr's contents.
> 
> __cgroup_bpf_run_filter_sock_addr() is modified to take the uaddrlen as
> an input/output argument. After running the program, the modified sockaddr
> length is stored in the uaddrlen pointer. If no uaddrlen pointer is
> provided, we determine the uaddrlen based on the socket family. For the


> existing AF_INET and AF_INET6 use cases, we don't pass in the address
> length explicitly and just determine it based on the passed in socket
> family.

The description on the inet address length needs an update, at least the 
AF_INET6 one.

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 8506690dbb9c..31561e789715 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -120,6 +120,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
>   
>   int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   				      struct sockaddr *uaddr,
> +				      int *uaddrlen,
>   				      enum cgroup_bpf_attach_type atype,
>   				      void *t_ctx,
>   				      u32 *flags);
> @@ -230,22 +231,22 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk)				       \
>   	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET6_POST_BIND)
>   
> -#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype)				       \
> +#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype)		       \
>   ({									       \
>   	int __ret = 0;							       \
>   	if (cgroup_bpf_enabled(atype))					       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  NULL, NULL);	       \
> +		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
> +							  atype, NULL, NULL);  \
>   	__ret;								       \
>   })
>   
> -#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx)		       \
> +#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx)	       \
>   ({									       \
>   	int __ret = 0;							       \
>   	if (cgroup_bpf_enabled(atype))	{				       \
>   		lock_sock(sk);						       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  t_ctx, NULL);	       \
> +		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
> +							  atype, t_ctx, NULL); \
>   		release_sock(sk);					       \
>   	}								       \
>   	__ret;								       \
> @@ -256,14 +257,14 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>    * (at bit position 0) is to indicate CAP_NET_BIND_SERVICE capability check
>    * should be bypassed (BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).
>    */
> -#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, bind_flags)	       \
> +#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, bind_flags) \
>   ({									       \
>   	u32 __flags = 0;						       \
>   	int __ret = 0;							       \
>   	if (cgroup_bpf_enabled(atype))	{				       \
>   		lock_sock(sk);						       \
> -		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, atype,     \
> -							  NULL, &__flags);     \
> +		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
> +							  atype, NULL, &__flags); \
>   		release_sock(sk);					       \
>   		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
>   			*bind_flags |= BIND_NO_CAP_NET_BIND_SERVICE;	       \
> @@ -276,29 +277,29 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
>   	 (sk)->sk_prot->pre_connect)
>   
> -#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr)			       \
> -	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, CGROUP_INET4_CONNECT)
> +#define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT)
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
>   /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
>    * fullsock and its parent fullsock cannot be traced by
> @@ -477,24 +478,24 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>   }
>   
>   #define cgroup_bpf_enabled(atype) (0)
> -#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
> -#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype) ({ 0; })
> +#define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
>   #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
>   #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, atype, flags) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
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
>   #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 761af6b3cf2b..77db4263d68d 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1285,6 +1285,7 @@ struct bpf_sock_addr_kern {
>   	 */
>   	u64 tmp_reg;
>   	void *t_ctx;	/* Attach type specific context. */
> +	u32 uaddrlen;
>   };
>   
>   struct bpf_sock_ops_kern {
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..534b6c7f5659 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1449,6 +1449,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>    *                                       provided by user sockaddr
>    * @sk: sock struct that will use sockaddr
>    * @uaddr: sockaddr struct provided by user
> + * @uaddrlen: Pointer to the size of the sockaddr struct provided by user
>    * @type: The type of program to be executed
>    * @t_ctx: Pointer to attach type specific context
>    * @flags: Pointer to u32 which contains higher bits of BPF program
> @@ -1461,6 +1462,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>    */
>   int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   				      struct sockaddr *uaddr,
> +				      int *uaddrlen,
>   				      enum cgroup_bpf_attach_type atype,
>   				      void *t_ctx,
>   				      u32 *flags)
> @@ -1472,6 +1474,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   	};
>   	struct sockaddr_storage unspec;
>   	struct cgroup *cgrp;
> +	int ret;
>   
>   	/* Check socket family since not all sockets represent network
>   	 * endpoint (e.g. AF_UNIX).
> @@ -1482,11 +1485,22 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   	if (!ctx.uaddr) {
>   		memset(&unspec, 0, sizeof(unspec));
>   		ctx.uaddr = (struct sockaddr *)&unspec;
> -	}
> +		ctx.uaddrlen = 0;
> +	} else if (uaddrlen)
> +		ctx.uaddrlen = *uaddrlen;
> +	else if (sk->sk_family == AF_INET)
> +		ctx.uaddrlen = sizeof(struct sockaddr_in);
> +	else if (sk->sk_family == AF_INET6)
> +		ctx.uaddrlen = sizeof(struct sockaddr_in6);

I was thinking to pass addrlen whenever possible for AF_INET and AF_INET6.

If I read correctly, all AF_INET6 cases have addrlen available in this patch.
May be just pass addrlen for AF_INET also, then the new sk->sk_family test here 
can be avoided?


