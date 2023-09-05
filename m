Return-Path: <bpf+bounces-9273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD97792E3F
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE47280F98
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFDDDD9;
	Tue,  5 Sep 2023 19:05:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC01DDAF
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:05:03 +0000 (UTC)
Received: from out-215.mta0.migadu.com (out-215.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44FCE4
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 12:04:34 -0700 (PDT)
Message-ID: <52177bd8-65a5-ef4d-b00d-47509855c3e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693940578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnMKLkenAHv7Z0a1x7H2J4DxcoYi4GZjMBQaE+GgU1A=;
	b=S990k/7XAwIwNasdLfq/n1ijnWrQFNXr9Qt81kxY/A1WuATvEzSmkvup9UHn6ICeS2y5MW
	OFVg1lwmKNGDEwPImUWlL4tEEX06acvf5Yw4QOA0Dma/5/lNwJTfy9DqWQ0eoTwEEP1gEl
	bbqZKHdb2MvOaiXoMfsx0NInv7/WiV8=
Date: Tue, 5 Sep 2023 12:02:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-5-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230831153455.1867110-5-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 8:34 AM, Daan De Meyer wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0680569f9bd0..d8f508c56055 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14540,14 +14540,19 @@ static int check_return_code(struct bpf_verifier_env *env)
>   	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>   		if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
>   		    env->prog->expected_attach_type == BPF_CGROUP_UDP6_RECVMSG ||
> +		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_RECVMSG ||
>   		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETPEERNAME ||
>   		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETPEERNAME ||
> +		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETPEERNAME ||
>   		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
> -		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME)
> +		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME ||
> +		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETSOCKNAME)
>   			range = tnum_range(1, 1);

A note that getpeername, getsockname, and recvmsg cannot return err (err is 
value 0 for cgroup-bpf). More on this later.

>   		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
>   		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND)
>   			range = tnum_range(0, 3);
> +		if (env->prog->expected_attach_type == BPF_CGROUP_UNIX_BIND)
> +			range = tnum_range(0, 1);

A few words in the commit message is needed for the difference on the return 
code between UNIX_BIND and INET[46]_BIND. (ie. the 
BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE).

Also, the default range should be (0, 1) already (the 'struct tnum range = 
tnum_range(0, 1)' at the beginning of this function). The same goes for 
UNIX_SENDMSG (and the existing INET[46]_SENDMSG) which should already have the 
default (0, 1) range. Thus, no need to have a special test case here.

>   		break;
>   	case BPF_PROG_TYPE_CGROUP_SKB:
>   		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3ed6cd33b268..be4e0e923aa6 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -81,6 +81,7 @@
>   #include <net/xdp.h>
>   #include <net/mptcp.h>
>   #include <net/netfilter/nf_conntrack_bpf.h>
> +#include <linux/un.h>

Is this needed?

>   
>   static const struct bpf_func_proto *
>   bpf_sk_base_func_proto(enum bpf_func_id func_id);
> @@ -7828,6 +7829,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		switch (prog->expected_attach_type) {
>   		case BPF_CGROUP_INET4_CONNECT:
>   		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>   			return &bpf_bind_proto;
>   		default:
>   			return NULL;
> @@ -7856,16 +7858,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		switch (prog->expected_attach_type) {
>   		case BPF_CGROUP_INET4_BIND:
>   		case BPF_CGROUP_INET6_BIND:
> +		case BPF_CGROUP_UNIX_BIND:
>   		case BPF_CGROUP_INET4_CONNECT:
>   		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>   		case BPF_CGROUP_UDP4_RECVMSG:
>   		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>   		case BPF_CGROUP_UDP4_SENDMSG:
>   		case BPF_CGROUP_UDP6_SENDMSG:
> +		case BPF_CGROUP_UNIX_SENDMSG:
>   		case BPF_CGROUP_INET4_GETPEERNAME:
>   		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>   		case BPF_CGROUP_INET4_GETSOCKNAME:
>   		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>   			return &bpf_sock_addr_setsockopt_proto;
>   		default:
>   			return NULL;
> @@ -7874,16 +7882,22 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		switch (prog->expected_attach_type) {
>   		case BPF_CGROUP_INET4_BIND:
>   		case BPF_CGROUP_INET6_BIND:
> +		case BPF_CGROUP_UNIX_BIND:
>   		case BPF_CGROUP_INET4_CONNECT:
>   		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>   		case BPF_CGROUP_UDP4_RECVMSG:
>   		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_UNIX_RECVMSG:
>   		case BPF_CGROUP_UDP4_SENDMSG:
>   		case BPF_CGROUP_UDP6_SENDMSG:
> +		case BPF_CGROUP_UNIX_SENDMSG:
>   		case BPF_CGROUP_INET4_GETPEERNAME:
>   		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_UNIX_GETPEERNAME:
>   		case BPF_CGROUP_INET4_GETSOCKNAME:
>   		case BPF_CGROUP_INET6_GETSOCKNAME:
> +		case BPF_CGROUP_UNIX_GETSOCKNAME:
>   			return &bpf_sock_addr_getsockopt_proto;
>   		default:
>   			return NULL;
> @@ -8931,8 +8945,8 @@ static bool sock_addr_is_valid_access(int off, int size,
>   	if (off % size != 0)
>   		return false;
>   
> -	/* Disallow access to IPv6 fields from IPv4 contex and vise
> -	 * versa.
> +	/* Disallow access to fields not belonging to the attach type's address
> +	 * family.
>   	 */
>   	switch (off) {
>   	case bpf_ctx_range(struct bpf_sock_addr, user_ip4):
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 86930a8ed012..94fd6f2441d8 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -116,6 +116,7 @@
>   #include <linux/freezer.h>
>   #include <linux/file.h>
>   #include <linux/btf_ids.h>
> +#include <linux/bpf-cgroup.h>
>   
>   #include "scm.h"
>   
> @@ -1323,6 +1324,12 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>   	struct sock *sk = sock->sk;
>   	int err;
>   
> +	if (cgroup_bpf_enabled(CGROUP_UNIX_BIND)) {

It is a dup test. The same static_key test will be done in 
BPF_CGROUP_RUN_SA_PROG*() also?

The same comment for other places before calling BPF_CGROUP_RUN_PROG_UNIX_* and 
BPF_CGROUP_RUN_SA_PROG().

> +		err = BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, &addr_len);
> +		if (err)
> +			return err;
> +	}
> +
>   	if (addr_len == offsetof(struct sockaddr_un, sun_path) &&
>   	    sunaddr->sun_family == AF_UNIX)
>   		return unix_autobind(sk);
> @@ -1377,6 +1384,13 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
>   		goto out;
>   
>   	if (addr->sa_family != AF_UNSPEC) {
> +		if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
> +			err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, addr,
> +								    &alen);
> +			if (err)
> +				goto out;
> +		}
> +
>   		err = unix_validate_addr(sunaddr, alen);
>   		if (err)
>   			goto out;
> @@ -1486,6 +1500,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>   	int err;
>   	int st;
>   
> +	if (cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) {
> +		err = BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr,
> +							    &addr_len);
> +		if (err)
> +			goto out;
> +	}
> +
>   	err = unix_validate_addr(sunaddr, addr_len);
>   	if (err)
>   		goto out;
> @@ -1749,7 +1770,7 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>   	struct sock *sk = sock->sk;
>   	struct unix_address *addr;
>   	DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, uaddr);
> -	int err = 0;
> +	int addr_len = 0, err = 0;
>   
>   	if (peer) {
>   		sk = unix_peer_get(sk);
> @@ -1766,14 +1787,37 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>   	if (!addr) {
>   		sunaddr->sun_family = AF_UNIX;
>   		sunaddr->sun_path[0] = 0;
> -		err = offsetof(struct sockaddr_un, sun_path);
> +		addr_len = offsetof(struct sockaddr_un, sun_path);
>   	} else {
> -		err = addr->len;
> +		addr_len = addr->len;
>   		memcpy(sunaddr, addr->name, addr->len);
>   	}
> +
> +	if (peer && cgroup_bpf_enabled(CGROUP_UNIX_GETPEERNAME)) {
> +		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
> +					     CGROUP_UNIX_GETPEERNAME);
> +		if (err)

UNIX_GETPEERNAME can only have return value 1 (OK), so no need to do err check here.

> +			goto out;
> +
> +		err = unix_validate_addr(sunaddr, addr_len);

Since the kfunc is specific to the unix address, how about doing the 
unix_validate_addr check in the kfunc itself?

> +		if (err)
> +			goto out;
> +	}
> +
> +	if (!peer && cgroup_bpf_enabled(CGROUP_UNIX_GETSOCKNAME)) {
> +		err = BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &addr_len,
> +					     CGROUP_UNIX_GETSOCKNAME);
> +		if (err)

Same here on the unnecessary err check.

> +			goto out;
> +
> +		err = unix_validate_addr(sunaddr, addr_len);
> +		if (err)
> +			goto out;
> +	}
> +
>   	sock_put(sk);
>   out:
> -	return err;
> +	return err ?: addr_len;
>   }
>   
>   static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
> @@ -1919,6 +1963,15 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>   		goto out;
>   
>   	if (msg->msg_namelen) {
> +		if (cgroup_bpf_enabled(CGROUP_UNIX_SENDMSG)) {
> +			err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
> +								    msg->msg_name,
> +								    &msg->msg_namelen,
> +								    NULL);
> +			if (err)
> +				goto out;
> +		}
> +
>   		err = unix_validate_addr(sunaddr, msg->msg_namelen);
>   		if (err)
>   			goto out;
> @@ -2328,14 +2381,30 @@ static int unix_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg,
>   	return unix_dgram_recvmsg(sock, msg, size, flags);
>   }
>   
> -static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
> +static int unix_recvmsg_copy_addr(struct msghdr *msg, struct sock *sk)
>   {
>   	struct unix_address *addr = smp_load_acquire(&unix_sk(sk)->addr);
> +	int err;
>   
>   	if (addr) {
>   		msg->msg_namelen = addr->len;
>   		memcpy(msg->msg_name, addr->name, addr->len);
> +
> +		if (cgroup_bpf_enabled(CGROUP_UNIX_RECVMSG)) {
> +			err = BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> +								    msg->msg_name,
> +								    &msg->msg_namelen);
> +			if (err)

Same here on the unnecessary err check.

> +				return err;
> +
> +			err = unix_validate_addr(msg->msg_name,
> +						 msg->msg_namelen);

If unix_validate_addr is done in the kfunc, the unix_recvmsg_copy_addr does not 
need to return error and the changes in the unix_recvmsg_copy_addr's caller is 
not needed also.

> +			if (err)
> +				return err;
> +		}
>   	}
> +
> +	return 0;
>   }
>   
>   int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
> @@ -2390,8 +2459,11 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>   						EPOLLOUT | EPOLLWRNORM |
>   						EPOLLWRBAND);
>   
> -	if (msg->msg_name)
> -		unix_copy_addr(msg, skb->sk);
> +	if (msg->msg_name) {
> +		err = unix_recvmsg_copy_addr(msg, skb->sk);
> +		if (err)
> +			goto out_free;
> +	}
>   
>   	if (size > skb->len - skip)
>   		size = skb->len - skip;
> @@ -2743,7 +2815,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   		if (state->msg && state->msg->msg_name) {
>   			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
>   					 state->msg->msg_name);
> -			unix_copy_addr(state->msg, skb->sk);
> +			err = unix_recvmsg_copy_addr(state->msg, skb->sk);
> +			if (err)
> +				break;
>   			sunaddr = NULL;
>   		}


