Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A16511B3
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 19:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiLSSWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiLSSW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 13:22:28 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFD614D
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:22:27 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so7428075plk.19
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2x0wSnYsewH4iAEwOQjvU/hpNGhiU8GmT5H0SSWTXo=;
        b=snxFxnVxuowKEhwiUl/7+qTDSdd1kz+8QpWlqWdv7SLmHD+rwb+71YUt7cW/hk5c1e
         JiBtcmCVNtYquQZlEpf+AGAM4H1z0GC8jAezsZRp6/fhZCyqARgLsE4nBg43i8Xu5+1V
         TsTa0kFzOESMB/eY+Leatljf1ouHV8BNMA0F4gYTuhg6kOqxF0z+qcQggprJQoSeEF2W
         qgkEIKcd8/NKo99GvxR2vCAmHzcd4BO2E6vfNftGjYsf9zvqUAU8L8a3Mbup3bAI6Cmd
         +THFcASVG1uzcF7QSgjzeHBjNvUUcFUHR/Mxky6D1TbhBlvlQ11OTAa5gb3MYWI6PiHH
         eCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2x0wSnYsewH4iAEwOQjvU/hpNGhiU8GmT5H0SSWTXo=;
        b=RlM93fvQZyMOSb8c5JeYDd+YjRIrp42E8t3VqEFF4ilCkXCtfryyIUzWmh3+PZtLRp
         Zre78phvs7k2Ig3DNUaqSiy6i+uq6EASizHUZOlIiyn6dYD+ggkAR4YdsW6nSHm5NKlL
         saIXIIsOffTvFCM1pJsV4/95Gw74lMmPJMJzBbxLrM/AxsUzsRBYR7h7j84L093Ucv1D
         l8K8nrM/FeRvlkmzwDIwN6o+gQWaMgtWhEmWL+0wEKrdFpG9lAs8Ln2EWpy5vkf6wd0G
         MJmalOozN4oeXCgzptryrUlpjNSs/7lTkiBHbzh+K2NsBoKt9RPDeS7Hee/SjckS0Pdz
         +CQA==
X-Gm-Message-State: ANoB5pnVKSpXufLWpGodihXmKk5KuabVMXOd47NhHpnPoRF3JtnOQmzr
        23gE6jVeRPNwTZynlWWZFNAy7wE=
X-Google-Smtp-Source: AA0mqf7ShZ5ShlpngrVJ8rq61klbutwITgFJwBL/M8UJsHxwRCVENMl+57UPV1ee9y8J0/vqrubx27Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:3052:b0:189:63ef:ef3b with SMTP id
 u18-20020a170903305200b0018963efef3bmr66454027pla.112.1671474147090; Mon, 19
 Dec 2022 10:22:27 -0800 (PST)
Date:   Mon, 19 Dec 2022 10:22:25 -0800
In-Reply-To: <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <cover.1671242108.git.aditi.ghag@isovalent.com> <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
Message-ID: <Y6Cr4X4h0buvET8U@google.com>
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
From:   sdf@google.com
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/17, Aditi Ghag wrote:
> The socket destroy helper is used to
> forcefully terminate sockets from certain
> BPF contexts. We plan to use the capability
> in Cilium to force client sockets to reconnect
> when their remote load-balancing backends are
> deleted. The other use case is on-the-fly
> policy enforcement where existing socket
> connections prevented by policies need to
> be terminated.

> The helper is currently exposed to iterator
> type BPF programs where users can filter,
> and terminate a set of sockets.

> Sockets are destroyed asynchronously using
> the work queue infrastructure. This allows
> for current the locking semantics within

s/current the/the current/ ?

> socket destroy handlers, as BPF iterators
> invoking the helper acquire *sock* locks.
> This also allows the helper to be invoked
> from non-sleepable contexts.
> The other approach to skip acquiring locks
> by passing an argument to the `diag_destroy`
> handler didn't work out well for UDP, as
> the UDP abort function internally invokes
> another function that ends up acquiring
> *sock* lock.
> While there are sleepable BPF iterators,
> these are limited to only certain map types.
> Furthermore, it's limiting in the sense that
> it wouldn't allow us to extend the helper
> to other non-sleepable BPF programs.

> The work queue infrastructure processes work
> items from per-cpu structures. As the sock
> destroy work items are executed asynchronously,
> we need to ref count sockets before they are
> added to the work queue. The 'work_pending'
> check prevents duplicate ref counting of sockets
> in case users invoke the destroy helper for a
> socket multiple times. The `{READ,WRITE}_ONCE`
> macros ensure that the socket pointer stored
> in a work queue item isn't clobbered while
> the item is being processed. As BPF programs
> are non-preemptible, we can expect that once
> a socket is ref counted, no other socket can
> sneak in before the ref counted socket is
> added to the work queue for asynchronous destroy.
> Finally, users are expected to retry when the
> helper fails to queue a work item for a socket
> to be destroyed in case there is another destroy
> operation is in progress.

nit: maybe reformat to fit into 80 characters per line? A bit hard to
read with this narrow formatting..


> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   include/linux/bpf.h            |  1 +
>   include/uapi/linux/bpf.h       | 17 +++++++++
>   kernel/bpf/core.c              |  1 +
>   kernel/trace/bpf_trace.c       |  2 +
>   net/core/filter.c              | 70 ++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h | 17 +++++++++
>   6 files changed, 108 insertions(+)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3de24cfb7a3d..60eaa05dfab3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2676,6 +2676,7 @@ extern const struct bpf_func_proto  
> bpf_get_retval_proto;
>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>   extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>   extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_sock_destroy_proto;

>   const struct bpf_func_proto *tracing_prog_func_proto(
>     enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 464ca3f01fe7..789ac7c59fdf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5484,6 +5484,22 @@ union bpf_attr {
>    *		0 on success.
>    *
>    *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * int bpf_sock_destroy(struct sock *sk)
> + *	Description
> + *		Destroy the given socket with **ECONNABORTED** error code.
> + *
> + *		*sk* must be a non-**NULL** pointer to a socket.
> + *
> + *	Return
> + *		The socket is destroyed asynchronosuly, so 0 return value may
> + *		not suggest indicate that the socket was successfully destroyed.

s/suggest indicate/ with either suggest or indicate?

> + *
> + *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, **EINVAL**.
> + *
> + *		**-EPROTONOSUPPORT** if protocol specific destroy handler is not  
> implemented.
> + *
> + *		**-EBUSY** if another socket destroy operation is in progress.
>    */
>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>   	FN(unspec, 0, ##ctx)				\
> @@ -5698,6 +5714,7 @@ union bpf_attr {
>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>   	FN(cgrp_storage_get, 210, ##ctx)		\
>   	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(sock_destroy, 212, ##ctx)			\
>   	/* */

>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that  
> don't
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7f98dec6e90f..c59bef9805e5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2651,6 +2651,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto  
> __weak;
>   const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
>   const struct bpf_func_proto bpf_set_retval_proto __weak;
>   const struct bpf_func_proto bpf_get_retval_proto __weak;
> +const struct bpf_func_proto bpf_sock_destroy_proto __weak;

>   const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
>   {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..016dbee6b5e4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1930,6 +1930,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id,  
> const struct bpf_prog *prog)
>   		return &bpf_get_socket_ptr_cookie_proto;
>   	case BPF_FUNC_xdp_get_buff_len:
>   		return &bpf_xdp_get_buff_len_trace_proto;
> +	case BPF_FUNC_sock_destroy:
> +		return &bpf_sock_destroy_proto;
>   #endif
>   	case BPF_FUNC_seq_printf:
>   		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 929358677183..9753606ecc26 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11569,6 +11569,8 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>   		break;
>   	case BPF_FUNC_ktime_get_coarse_ns:
>   		return &bpf_ktime_get_coarse_ns_proto;
> +	case BPF_FUNC_sock_destroy:
> +		return &bpf_sock_destroy_proto;
>   	default:
>   		return bpf_base_func_proto(func_id);
>   	}
> @@ -11578,3 +11580,71 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)

>   	return func;
>   }
> +
> +struct sock_destroy_work {
> +	struct sock *sk;
> +	struct work_struct destroy;
> +};
> +
> +static DEFINE_PER_CPU(struct sock_destroy_work, sock_destroy_workqueue);
> +
> +static void bpf_sock_destroy_fn(struct work_struct *work)
> +{
> +	struct sock_destroy_work *sd_work = container_of(work,
> +			struct sock_destroy_work, destroy);
> +	struct sock *sk = READ_ONCE(sd_work->sk);
> +
> +	sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +	sock_put(sk);
> +}
> +
> +static int __init bpf_sock_destroy_workqueue_init(void)
> +{
> +	int cpu;
> +	struct sock_destroy_work *work;
> +
> +	for_each_possible_cpu(cpu) {
> +		work = per_cpu_ptr(&sock_destroy_workqueue, cpu);
> +		INIT_WORK(&work->destroy, bpf_sock_destroy_fn);
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(bpf_sock_destroy_workqueue_init);
> +
> +BPF_CALL_1(bpf_sock_destroy, struct sock *, sk)
> +{
> +	struct sock_destroy_work *sd_work;
> +
> +	if (!sk->sk_prot->diag_destroy)
> +		return -EOPNOTSUPP;
> +
> +	sd_work = this_cpu_ptr(&sock_destroy_workqueue);

[..]

> +	/* This check prevents duplicate ref counting
> +	 * of sockets, in case the handler is invoked
> +	 * multiple times for the same socket.
> +	 */

This means this helper can also be called for a single socket during
invocation; is it an ok compromise?

I'm also assuming it's still possible that this helper gets called for
the same socket on different cpus?

> +	if (work_pending(&sd_work->destroy))
> +		return -EBUSY;
> +
> +	/* Ref counting ensures that the socket
> +	 * isn't deleted from underneath us before
> +	 * the work queue item is processed.
> +	 */
> +	if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +		return -EINVAL;
> +
> +	WRITE_ONCE(sd_work->sk, sk);
> +	if (!queue_work(system_wq, &sd_work->destroy)) {
> +		sock_put(sk);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct bpf_func_proto bpf_sock_destroy_proto = {
> +	.func		= bpf_sock_destroy,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +};
> diff --git a/tools/include/uapi/linux/bpf.h  
> b/tools/include/uapi/linux/bpf.h
> index 464ca3f01fe7..07154a4d92f9 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5484,6 +5484,22 @@ union bpf_attr {
>    *		0 on success.
>    *
>    *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * int bpf_sock_destroy(void *sk)
> + *	Description
> + *		Destroy the given socket with **ECONNABORTED** error code.
> + *
> + *		*sk* must be a non-**NULL** pointer to a socket.
> + *
> + *	Return
> + *		The socket is destroyed asynchronosuly, so 0 return value may
> + *		not indicate that the socket was successfully destroyed.
> + *
> + *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, **EINVAL**.
> + *
> + *		**-EPROTONOSUPPORT** if protocol specific destroy handler is not  
> implemented.
> + *
> + *		**-EBUSY** if another socket destroy operation is in progress.
>    */
>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>   	FN(unspec, 0, ##ctx)				\
> @@ -5698,6 +5714,7 @@ union bpf_attr {
>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>   	FN(cgrp_storage_get, 210, ##ctx)		\
>   	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(sock_destroy, 212, ##ctx)			\
>   	/* */

>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that  
> don't
> --
> 2.34.1

