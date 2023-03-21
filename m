Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2B6C3EBB
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 00:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCUXnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCUXnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 19:43:07 -0400
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D94E055
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:43:05 -0700 (PDT)
Message-ID: <aa458066-529f-cb84-ce4e-2c780aad17bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679442182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FUtONdYnvcODxJnu0PD4rJepgqtnyjgFQ5k0C4QHGU=;
        b=DpmPs9yl3Ve/7dIjdlV99aIhfeUHC8V5jIkZnPUNx0WJEjE+gD7AvsMoZKfA1dvJgxUz4U
        gFL6qNJjmsDXx6ZBVJ5VBQ4T8n0XZnGKr/LYEWYigY1pxVkVY2iIJs4RxP09v5MljbksS2
        BDU6tY0pppdalnhOB/8sTuAUPq0v4jA=
Date:   Tue, 21 Mar 2023 16:43:00 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf@vger.kernel.org
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-3-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230321184541.1857363-3-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/21/23 11:45 AM, Aditi Ghag wrote:
> diff --git a/include/net/udp.h b/include/net/udp.h
> index de4b528522bb..d2999447d3f2 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>   struct udp_iter_state {
>   	struct seq_net_private  p;
>   	int			bucket;
> +	int			offset;

All offset change is easier to review with patch 1 together, so please move them 
to patch 1.

>   	struct udp_seq_afinfo	*bpf_seq_afinfo;
>   };
>   
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1d6f165923bf..ba3e0dac119c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>   
>   	return func;
>   }
> +
> +/* Disables missing prototype warnings */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
> + *
> + * The helper expects a non-NULL pointer to a socket. It invokes the
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
> + * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
> + * 0 otherwise
> + */
> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> +{
> +	struct sock *sk = (struct sock *)sock;
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
> +		return -EOPNOTSUPP;
> +
> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(sock_destroy_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_sock_destroy)
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

It still needs a way to guarantee the running context is safe to use this kfunc. 
  BPF_PROG_TYPE_TRACING is too broad. Trying to brainstorm ways here instead of 
needing to filter by expected_attach_type. I wonder using KF_TRUSTED_ARGS like this:

BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)

is enough or it needs some care to filter out BPF_TRACE_RAW_TP after looking at 
prog_args_trusted().
or it needs another tag to specify this kfunc requires the arg to be locked also.

> +}
> +late_initcall(init_subsystem);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 33f559f491c8..59a833c0c872 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>   		return 0;
>   	}
>   
> -	/* Don't race with userspace socket closes such as tcp_close. */
> -	lock_sock(sk);
> +	/* BPF context ensures sock locking. */
> +	if (!has_current_bpf_ctx())
> +		/* Don't race with userspace socket closes such as tcp_close. */
> +		lock_sock(sk);

This is ok.

>   
>   	if (sk->sk_state == TCP_LISTEN) {
>   		tcp_set_state(sk, TCP_CLOSE);
> @@ -4688,7 +4690,8 @@ int tcp_abort(struct sock *sk, int err)
>   
>   	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
>   	local_bh_disable();
> -	bh_lock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		bh_lock_sock(sk);

This may or may not work, depending on the earlier lock_sock_fast() done in 
bpf_iter_tcp_seq_show() returned true or false. It is probably a good reason to 
replace the lock_sock_fast() with lock_sock() in bpf_iter_tcp_seq_show().

>   
>   	if (!sock_flag(sk, SOCK_DEAD)) {
>   		sk->sk_err = err;
> @@ -4700,10 +4703,13 @@ int tcp_abort(struct sock *sk, int err)
>   		tcp_done(sk);
>   	}
>   
> -	bh_unlock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		bh_unlock_sock(sk);
> +
>   	local_bh_enable();
>   	tcp_write_queue_purge(sk);
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tcp_abort);

