Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD26A1281
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 23:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBWWCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 17:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWWCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 17:02:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8A4FA8F
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:02:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so845024pjh.0
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aefPqGYo35E4R2oWUb7lQBXfGnT/EYSUyKdqK5kN3ik=;
        b=JUodybYcYP/OzdIxthIaXEz6N9cz20mTnLjmQNmGKfgyWZA8oici/tSaDN4FuPK9yu
         3AQPsnABb0y8P2FgXH+/caiPzJoA21pEv29dbjKMlPmhGq/Jm7Xb8ZzLHk3/5ppu0lJj
         BYQYGNhhH6eWFpxFHEqpxh08P3MsTP8rTNBCqMc0WZZFK4pi9Ai+7+wyNMvlKgt1+0qa
         KDoXhtKkNhTjgAwhiRY7jbLlKm7eWQ5VUwMtGtSwletoOKoO0Wpr/PVYtRB5Gn5DnzWL
         /IhU8+7ZU6c3gvTj4/zlzHfJuApctrr+tAccKsR0SSnBLr40aM0OtKPtU2TTFDuxW/pG
         fq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aefPqGYo35E4R2oWUb7lQBXfGnT/EYSUyKdqK5kN3ik=;
        b=pW0qsziaYWF2atYKSkF0aRzy/mefMj+/NJrgnE7GN6JbcM3fS5jRZdSqfpI7WOi6bT
         65imlaf2BsaLGdNdIP96GlIbGYFT+LkxqlPxc2FgI7DX37N30yelSwfVDDBGdmEXquYr
         yIOQs/12X5YP+hD3hbkNZ0B+lh0ImM6L7F7PfQPJl/9oXLTEDKVs5tdYQJraYNi2xDQD
         Xf1LsEjv660d/6ujjSNZgGmvMkPV7y6DMVlbJviknOmJf9WAQ/hLotPn6IJ1PRs357HQ
         IX0CMW19fXc9IJAiO1CstvXM0KNcMjsTK4l4lNEg/2B1INiD2M/F+j8zQ3+/v1Aq5HxA
         dJBQ==
X-Gm-Message-State: AO0yUKVPLyu/fLb03u12jV4Dd2e24MDK62b5imfEcrQboCFKbcYWrh4P
        x7AV+X31Kvl2eFgUKZwy7T2jjw==
X-Google-Smtp-Source: AK7set//RSWMQD3knshjG3NLEfWGS7a8ZTL8EzjqgkaMkMa22cc/AgqF0oipOg1UKLLu/xtEYR/U0w==
X-Received: by 2002:a05:6a20:430e:b0:bc:9007:e53 with SMTP id h14-20020a056a20430e00b000bc90070e53mr14103688pzk.0.1677189764512;
        Thu, 23 Feb 2023 14:02:44 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:28ee:5de8:8f1:37ad? ([2601:647:4900:b6:28ee:5de8:8f1:37ad])
        by smtp.gmail.com with ESMTPSA id m18-20020a6562d2000000b005026c125d47sm7541172pgv.21.2023.02.23.14.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 14:02:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <Y6Cr4X4h0buvET8U@google.com>
Date:   Thu, 23 Feb 2023 14:02:42 -0800
Cc:     bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CB96D06-044C-4DAC-8A06-43649366131F@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
 <Y6Cr4X4h0buvET8U@google.com>
To:     sdf@google.com
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Dec 19, 2022, at 10:22 AM, sdf@google.com wrote:
>=20
> On 12/17, Aditi Ghag wrote:
>> The socket destroy helper is used to
>> forcefully terminate sockets from certain
>> BPF contexts. We plan to use the capability
>> in Cilium to force client sockets to reconnect
>> when their remote load-balancing backends are
>> deleted. The other use case is on-the-fly
>> policy enforcement where existing socket
>> connections prevented by policies need to
>> be terminated.
>=20
>> The helper is currently exposed to iterator
>> type BPF programs where users can filter,
>> and terminate a set of sockets.
>=20
>> Sockets are destroyed asynchronously using
>> the work queue infrastructure. This allows
>> for current the locking semantics within
>=20
> s/current the/the current/ ?
>=20
>> socket destroy handlers, as BPF iterators
>> invoking the helper acquire *sock* locks.
>> This also allows the helper to be invoked
>> from non-sleepable contexts.
>> The other approach to skip acquiring locks
>> by passing an argument to the `diag_destroy`
>> handler didn't work out well for UDP, as
>> the UDP abort function internally invokes
>> another function that ends up acquiring
>> *sock* lock.
>> While there are sleepable BPF iterators,
>> these are limited to only certain map types.
>> Furthermore, it's limiting in the sense that
>> it wouldn't allow us to extend the helper
>> to other non-sleepable BPF programs.
>=20
>> The work queue infrastructure processes work
>> items from per-cpu structures. As the sock
>> destroy work items are executed asynchronously,
>> we need to ref count sockets before they are
>> added to the work queue. The 'work_pending'
>> check prevents duplicate ref counting of sockets
>> in case users invoke the destroy helper for a
>> socket multiple times. The `{READ,WRITE}_ONCE`
>> macros ensure that the socket pointer stored
>> in a work queue item isn't clobbered while
>> the item is being processed. As BPF programs
>> are non-preemptible, we can expect that once
>> a socket is ref counted, no other socket can
>> sneak in before the ref counted socket is
>> added to the work queue for asynchronous destroy.
>> Finally, users are expected to retry when the
>> helper fails to queue a work item for a socket
>> to be destroyed in case there is another destroy
>> operation is in progress.
>=20
> nit: maybe reformat to fit into 80 characters per line? A bit hard to
> read with this narrow formatting..
>=20
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  include/linux/bpf.h            |  1 +
>>  include/uapi/linux/bpf.h       | 17 +++++++++
>>  kernel/bpf/core.c              |  1 +
>>  kernel/trace/bpf_trace.c       |  2 +
>>  net/core/filter.c              | 70 =
++++++++++++++++++++++++++++++++++
>>  tools/include/uapi/linux/bpf.h | 17 +++++++++
>>  6 files changed, 108 insertions(+)
>=20
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3de24cfb7a3d..60eaa05dfab3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2676,6 +2676,7 @@ extern const struct bpf_func_proto =
bpf_get_retval_proto;
>>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>> +extern const struct bpf_func_proto bpf_sock_destroy_proto;
>=20
>>  const struct bpf_func_proto *tracing_prog_func_proto(
>>    enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 464ca3f01fe7..789ac7c59fdf 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5484,6 +5484,22 @@ union bpf_attr {
>>   *		0 on success.
>>   *
>>   *		**-ENOENT** if the bpf_local_storage cannot be found.
>> + *
>> + * int bpf_sock_destroy(struct sock *sk)
>> + *	Description
>> + *		Destroy the given socket with **ECONNABORTED** error =
code.
>> + *
>> + *		*sk* must be a non-**NULL** pointer to a socket.
>> + *
>> + *	Return
>> + *		The socket is destroyed asynchronosuly, so 0 return =
value may
>> + *		not suggest indicate that the socket was successfully =
destroyed.
>=20
> s/suggest indicate/ with either suggest or indicate?
>=20
>> + *
>> + *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, =
**EINVAL**.
>> + *
>> + *		**-EPROTONOSUPPORT** if protocol specific destroy =
handler is not implemented.
>> + *
>> + *		**-EBUSY** if another socket destroy operation is in =
progress.
>>   */
>>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>  	FN(unspec, 0, ##ctx)				\
>> @@ -5698,6 +5714,7 @@ union bpf_attr {
>>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>>  	FN(cgrp_storage_get, 210, ##ctx)		\
>>  	FN(cgrp_storage_delete, 211, ##ctx)		\
>> +	FN(sock_destroy, 212, ##ctx)			\
>>  	/* */
>=20
>>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER =
that don't
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 7f98dec6e90f..c59bef9805e5 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2651,6 +2651,7 @@ const struct bpf_func_proto =
bpf_snprintf_btf_proto __weak;
>>  const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
>>  const struct bpf_func_proto bpf_set_retval_proto __weak;
>>  const struct bpf_func_proto bpf_get_retval_proto __weak;
>> +const struct bpf_func_proto bpf_sock_destroy_proto __weak;
>=20
>>  const struct bpf_func_proto * __weak =
bpf_get_trace_printk_proto(void)
>>  {
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 3bbd3f0c810c..016dbee6b5e4 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1930,6 +1930,8 @@ tracing_prog_func_proto(enum bpf_func_id =
func_id, const struct bpf_prog *prog)
>>  		return &bpf_get_socket_ptr_cookie_proto;
>>  	case BPF_FUNC_xdp_get_buff_len:
>>  		return &bpf_xdp_get_buff_len_trace_proto;
>> +	case BPF_FUNC_sock_destroy:
>> +		return &bpf_sock_destroy_proto;
>>  #endif
>>  	case BPF_FUNC_seq_printf:
>>  		return prog->expected_attach_type =3D=3D BPF_TRACE_ITER =
?
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 929358677183..9753606ecc26 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11569,6 +11569,8 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>>  		break;
>>  	case BPF_FUNC_ktime_get_coarse_ns:
>>  		return &bpf_ktime_get_coarse_ns_proto;
>> +	case BPF_FUNC_sock_destroy:
>> +		return &bpf_sock_destroy_proto;
>>  	default:
>>  		return bpf_base_func_proto(func_id);
>>  	}
>> @@ -11578,3 +11580,71 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>=20
>>  	return func;
>>  }
>> +
>> +struct sock_destroy_work {
>> +	struct sock *sk;
>> +	struct work_struct destroy;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct sock_destroy_work, =
sock_destroy_workqueue);
>> +
>> +static void bpf_sock_destroy_fn(struct work_struct *work)
>> +{
>> +	struct sock_destroy_work *sd_work =3D container_of(work,
>> +			struct sock_destroy_work, destroy);
>> +	struct sock *sk =3D READ_ONCE(sd_work->sk);
>> +
>> +	sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>> +	sock_put(sk);
>> +}
>> +
>> +static int __init bpf_sock_destroy_workqueue_init(void)
>> +{
>> +	int cpu;
>> +	struct sock_destroy_work *work;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		work =3D per_cpu_ptr(&sock_destroy_workqueue, cpu);
>> +		INIT_WORK(&work->destroy, bpf_sock_destroy_fn);
>> +	}
>> +
>> +	return 0;
>> +}
>> +subsys_initcall(bpf_sock_destroy_workqueue_init);
>> +
>> +BPF_CALL_1(bpf_sock_destroy, struct sock *, sk)
>> +{
>> +	struct sock_destroy_work *sd_work;
>> +
>> +	if (!sk->sk_prot->diag_destroy)
>> +		return -EOPNOTSUPP;
>> +
>> +	sd_work =3D this_cpu_ptr(&sock_destroy_workqueue);
>=20
> [..]
>=20
>> +	/* This check prevents duplicate ref counting
>> +	 * of sockets, in case the handler is invoked
>> +	 * multiple times for the same socket.
>> +	 */
>=20
> This means this helper can also be called for a single socket during
> invocation; is it an ok compromise?
>=20
> I'm also assuming it's still possible that this helper gets called for
> the same socket on different cpus?

Thanks for the review. The v2 patch series refactored this code path =
significantly, and it executes the destroy handlers synchronously.=20

>=20
>> +	if (work_pending(&sd_work->destroy))
>> +		return -EBUSY;
>> +
>> +	/* Ref counting ensures that the socket
>> +	 * isn't deleted from underneath us before
>> +	 * the work queue item is processed.
>> +	 */
>> +	if (!refcount_inc_not_zero(&sk->sk_refcnt))
>> +		return -EINVAL;
>> +
>> +	WRITE_ONCE(sd_work->sk, sk);
>> +	if (!queue_work(system_wq, &sd_work->destroy)) {
>> +		sock_put(sk);
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +const struct bpf_func_proto bpf_sock_destroy_proto =3D {
>> +	.func		=3D bpf_sock_destroy,
>> +	.ret_type	=3D RET_INTEGER,
>> +	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
>> +};
>> diff --git a/tools/include/uapi/linux/bpf.h =
b/tools/include/uapi/linux/bpf.h
>> index 464ca3f01fe7..07154a4d92f9 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -5484,6 +5484,22 @@ union bpf_attr {
>>   *		0 on success.
>>   *
>>   *		**-ENOENT** if the bpf_local_storage cannot be found.
>> + *
>> + * int bpf_sock_destroy(void *sk)
>> + *	Description
>> + *		Destroy the given socket with **ECONNABORTED** error =
code.
>> + *
>> + *		*sk* must be a non-**NULL** pointer to a socket.
>> + *
>> + *	Return
>> + *		The socket is destroyed asynchronosuly, so 0 return =
value may
>> + *		not indicate that the socket was successfully destroyed.
>> + *
>> + *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, =
**EINVAL**.
>> + *
>> + *		**-EPROTONOSUPPORT** if protocol specific destroy =
handler is not implemented.
>> + *
>> + *		**-EBUSY** if another socket destroy operation is in =
progress.
>>   */
>>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>  	FN(unspec, 0, ##ctx)				\
>> @@ -5698,6 +5714,7 @@ union bpf_attr {
>>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>>  	FN(cgrp_storage_get, 210, ##ctx)		\
>>  	FN(cgrp_storage_delete, 211, ##ctx)		\
>> +	FN(sock_destroy, 212, ##ctx)			\
>>  	/* */
>=20
>>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER =
that don't
>> --
>> 2.34.1

