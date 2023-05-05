Return-Path: <bpf+bounces-70-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC36F7A02
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FD61C213DE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06F2EDE;
	Fri,  5 May 2023 00:13:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8465621
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:13:36 +0000 (UTC)
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380712E9B
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:13:34 -0700 (PDT)
Message-ID: <1013e81f-5a0a-dd0b-c18d-3ee849c079ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683245612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmgQUgw7bDELYzuG6ChHVQgWLxBmtakYX8fodKUgyFI=;
	b=JSK+cRQAkwuDNtatrR5bg6eaLVNhb/BNufV3haVgRJ0ycF909+il/Q36BNDurKTuqBmxLw
	4s9SSAZpIot69our2BZIHbo2wxKmhFrORe+631ITil8P2SXcInyxz16CscN+U7kl2HukyL
	KIMzqqEiAfEn1WdDIRDAfAlCNEKHLS4=
Date: Thu, 4 May 2023 17:13:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 06/10] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: sdf@google.com, bpf@vger.kernel.org
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
 <20230503225351.3700208-7-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230503225351.3700208-7-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/3/23 3:53 PM, Aditi Ghag wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 727c5269867d..97d70b7959a1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11715,3 +11715,60 @@ static int __init bpf_kfunc_init(void)
>   	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
>   }
>   late_initcall(bpf_kfunc_init);
> +
> +/* Disables missing prototype warnings */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
> + *
> + * The function expects a non-NULL pointer to a socket, and invokes the
> + * protocol specific socket destroy handlers.
> + *
> + * The helper can only be called from BPF contexts that have acquired the socket
> + * locks.
> + *
> + * Parameters:
> + * @sock: Pointer to socket to be destroyed
> + *
> + * Return:
> + * On error, may return EPROTONOSUPPORT, EINVAL.
> + * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
> + * 0 otherwise
> + */
> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> +{
> +	struct sock *sk = (struct sock *)sock;
> +
> +	if (!sk)

If the kfunc has the KF_TRUSTED_ARGS flag, this NULL test is no longer needed. 
More details below.

> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 * Supporting protocols will need to acquire lock_sock in the BPF context
> +	 * prior to invoking this kfunc.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
> +					   sk->sk_protocol != IPPROTO_UDP))
> +		return -EOPNOTSUPP;
> +
> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(sock_destroy_kfunc_set)

nit. Rename it to a more generic name for future sk_iter related kfunc.
May be bpf_sk_iter_kfunc_set ?

> +BTF_ID_FLAGS(func, bpf_sock_destroy)

Follow up on the v6 patch-set regarding KF_TRUSTED_ARGS.
KF_TRUSTED_ARGS is needed here to avoid the cases where a PTR_TO_BTF_ID sk is 
obtained by following another pointer. eg. getting a sk pointer (may be even 
NULL) by following another sk pointer. The recent PTR_TRUSTED concept in the 
verifier can guard this. I tried and the following should do:

diff --git i/net/core/filter.c w/net/core/filter.c
index 68b228f3eca6..d82e038da0e3 100644
--- i/net/core/filter.c
+++ w/net/core/filter.c
@@ -11767,7 +11767,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
  __diag_pop()

  BTF_SET8_START(sock_destroy_kfunc_set)
-BTF_ID_FLAGS(func, bpf_sock_destroy)
+BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
  BTF_SET8_END(sock_destroy_kfunc_set)

  static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git i/net/ipv4/tcp_ipv4.c w/net/ipv4/tcp_ipv4.c
index 887f83a90d85..a769284e8291 100644
--- i/net/ipv4/tcp_ipv4.c
+++ w/net/ipv4/tcp_ipv4.c
@@ -3354,7 +3354,7 @@ static struct bpf_iter_reg tcp_reg_info = {
  	.ctx_arg_info_size	= 1,
  	.ctx_arg_info		= {
  		{ offsetof(struct bpf_iter__tcp, sk_common),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
  	},
  	.get_func_proto		= bpf_iter_tcp_get_func_proto,
  	.seq_info		= &tcp_seq_info,
diff --git i/net/ipv4/udp.c w/net/ipv4/udp.c
index 746c85f2bb03..945b641b363b 100644
--- i/net/ipv4/udp.c
+++ w/net/ipv4/udp.c
@@ -3646,7 +3646,7 @@ static struct bpf_iter_reg udp_reg_info = {
  	.ctx_arg_info_size	= 1,
  	.ctx_arg_info		= {
  		{ offsetof(struct bpf_iter__udp, udp_sk),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
  	},
  	.seq_info		= &udp_seq_info,
  };

Please take a look and run through the test_progs. If you agree on the changes, 
this should be included in the same patch 6.

> +BTF_SET8_END(sock_destroy_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &sock_destroy_kfunc_set,
> +};
> +
> +static int init_subsystem(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sock_destroy_kfunc_set);
> +}
> +late_initcall(init_subsystem);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 288693981b00..2259b4facc2f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4679,8 +4679,10 @@ int tcp_abort(struct sock *sk, int err)
>   		return 0;
>   	}
>   
> -	/* Don't race with userspace socket closes such as tcp_close. */
> -	lock_sock(sk);
> +	/* BPF context ensures sock locking. */
> +	if (!has_current_bpf_ctx())
> +		/* Don't race with userspace socket closes such as tcp_close. */
> +		lock_sock(sk);
>   
>   	if (sk->sk_state == TCP_LISTEN) {
>   		tcp_set_state(sk, TCP_CLOSE);
> @@ -4702,9 +4704,11 @@ int tcp_abort(struct sock *sk, int err)
>   	}
>   
>   	bh_unlock_sock(sk);
> +

nit. unnecessary new line change.

>   	local_bh_enable();
>   	tcp_write_queue_purge(sk);
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tcp_abort);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 150551acab9d..5f48cdf82a45 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2925,7 +2925,8 @@ EXPORT_SYMBOL(udp_poll);
>   
>   int udp_abort(struct sock *sk, int err)
>   {
> -	lock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		lock_sock(sk);
>   
>   	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
>   	 * with close()
> @@ -2938,7 +2939,8 @@ int udp_abort(struct sock *sk, int err)
>   	__udp_disconnect(sk, 0);
>   
>   out:
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);
>   
>   	return 0;
>   }


