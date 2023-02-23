Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A106A12A3
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBWWMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 17:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBWWMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 17:12:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC96584BC
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:12:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso767727pjb.5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgHmLcow5mNkR5VANAM+kNb9sAcNrB7+oiLAYWG/2Cc=;
        b=RGY7aBWQrjc4VbUl9Kwpx5VhwrzSCUdJSjmViay1gdpUF8Uyd/7ZqkXN0dWDVFztPv
         olwblrpy8UxjIAPDb1FYlXkiOCLjuXZgyKHFOgBiv5LVeRL5Xd/2tLGviX4cCwWN1wkE
         bf8GFx+c0n/gC2Kl5bMGCuwCEhgjiQDZvItpldKS0sLINg7zMeUKPiyiORqphLZseyPQ
         YuE2tiFDVzqwhj8mrCvcxdKC8MhXJI0qiZreRVEhQZ4T846cYvOSTdWi0NSj3agiYeJG
         WapYtVgKk9QsCU5ARdLUS3BPhN4aujrQMWJH0IKjDRSbSP1uX4K42eAXQ6kVDxtk/x+3
         /nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgHmLcow5mNkR5VANAM+kNb9sAcNrB7+oiLAYWG/2Cc=;
        b=R+H6hgNkY6a9v6yR7gyS5ACN6KkWCYDdnZuRPy1hEcOqt93mPwBMjL4BIFM8Gx9HmS
         JuslTt9l+trlJirvqDJj6CmBRI+KPDA/jOtFPXYyTc5o0n4UvYqdL+pqhCKRWgboePRd
         q4pP78hc2LQqGOUM3TOBInEXacmP40+49lzdnxgIGF9MAvGamNCaKEqt163J2WAYbWdR
         RM1V0AJq3yLw0yueej7z0ZzuMJkj2N5/k9F6HYWlJft2HVQcwYz7O4mU8ki0/uhr7j9h
         TbOtN7yYgFK24snkPGkdx+kEsKi77J1Ch+D6U6J3+M5UC1mdQKYdae53oF//PdUxNQ8l
         nxig==
X-Gm-Message-State: AO0yUKWL3APV3Sch4cRy1EebsiBxXEbAnflXg4E1+HeyMaJ1MtgMMDDE
        6Q1rWSlHLBrOvvpfADoUsIr5kjAyeRQfDukD
X-Google-Smtp-Source: AK7set+tHZB3AoWXBnCVmzTv+zyAWaHeBIXNcNWEVMW2KWW/cfMZh953VMmhoBhYr4w2IGTh/+X0Pg==
X-Received: by 2002:a17:902:fb4d:b0:196:8a80:4d91 with SMTP id lf13-20020a170902fb4d00b001968a804d91mr11882705plb.35.1677190334552;
        Thu, 23 Feb 2023 14:12:14 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:28ee:5de8:8f1:37ad? ([2601:647:4900:b6:28ee:5de8:8f1:37ad])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b0019607aeda8bsm7847146plb.73.2023.02.23.14.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 14:12:14 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <d979c6ab-7afc-3c83-c7e6-27bad47c0a9c@oracle.com>
Date:   Thu, 23 Feb 2023 14:12:12 -0800
Cc:     bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <29E6F588-71C9-4022-80C0-B9B0405DDFAB@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
 <d979c6ab-7afc-3c83-c7e6-27bad47c0a9c@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Dec 20, 2022, at 2:26 AM, Alan Maguire <alan.maguire@oracle.com> =
wrote:
>=20
> On 17/12/2022 01:57, Aditi Ghag wrote:
>> The socket destroy helper is used to
>> forcefully terminate sockets from certain
>> BPF contexts. We plan to use the capability
>> in Cilium to force client sockets to reconnect
>> when their remote load-balancing backends are
>> deleted. The other use case is on-the-fly
>> policy enforcement where existing socket
>> connections prevented by policies need to
>> be terminated.
>>=20
>> The helper is currently exposed to iterator
>> type BPF programs where users can filter,
>> and terminate a set of sockets.
>>=20
>> Sockets are destroyed asynchronously using
>> the work queue infrastructure. This allows
>> for current the locking semantics within
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
>>=20
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
>>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>> include/linux/bpf.h            |  1 +
>> include/uapi/linux/bpf.h       | 17 +++++++++
>> kernel/bpf/core.c              |  1 +
>> kernel/trace/bpf_trace.c       |  2 +
>> net/core/filter.c              | 70 =
++++++++++++++++++++++++++++++++++
>> tools/include/uapi/linux/bpf.h | 17 +++++++++
>> 6 files changed, 108 insertions(+)
>>=20
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3de24cfb7a3d..60eaa05dfab3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2676,6 +2676,7 @@ extern const struct bpf_func_proto =
bpf_get_retval_proto;
>> extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>> extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>> extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>> +extern const struct bpf_func_proto bpf_sock_destroy_proto;
>>=20
>> const struct bpf_func_proto *tracing_prog_func_proto(
>>   enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 464ca3f01fe7..789ac7c59fdf 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5484,6 +5484,22 @@ union bpf_attr {
>>  *		0 on success.
>>  *
>>  *		**-ENOENT** if the bpf_local_storage cannot be found.
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
>> + *
>> + *		On error, may return **EPROTONOSUPPORT**, **EBUSY**, =
**EINVAL**.
>> + *
>> + *		**-EPROTONOSUPPORT** if protocol specific destroy =
handler is not implemented.
>> + *
>> + *		**-EBUSY** if another socket destroy operation is in =
progress.
>>  */
>> #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>> 	FN(unspec, 0, ##ctx)				\
>> @@ -5698,6 +5714,7 @@ union bpf_attr {
>> 	FN(user_ringbuf_drain, 209, ##ctx)		\
>> 	FN(cgrp_storage_get, 210, ##ctx)		\
>> 	FN(cgrp_storage_delete, 211, ##ctx)		\
>> +	FN(sock_destroy, 212, ##ctx)			\
>> 	/* */
>>=20
>> /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that =
don't
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 7f98dec6e90f..c59bef9805e5 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2651,6 +2651,7 @@ const struct bpf_func_proto =
bpf_snprintf_btf_proto __weak;
>> const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
>> const struct bpf_func_proto bpf_set_retval_proto __weak;
>> const struct bpf_func_proto bpf_get_retval_proto __weak;
>> +const struct bpf_func_proto bpf_sock_destroy_proto __weak;
>>=20
>> const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
>> {
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 3bbd3f0c810c..016dbee6b5e4 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1930,6 +1930,8 @@ tracing_prog_func_proto(enum bpf_func_id =
func_id, const struct bpf_prog *prog)
>> 		return &bpf_get_socket_ptr_cookie_proto;
>> 	case BPF_FUNC_xdp_get_buff_len:
>> 		return &bpf_xdp_get_buff_len_trace_proto;
>> +	case BPF_FUNC_sock_destroy:
>> +		return &bpf_sock_destroy_proto;
>> #endif
>> 	case BPF_FUNC_seq_printf:
>> 		return prog->expected_attach_type =3D=3D BPF_TRACE_ITER =
?
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 929358677183..9753606ecc26 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11569,6 +11569,8 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>> 		break;
>> 	case BPF_FUNC_ktime_get_coarse_ns:
>> 		return &bpf_ktime_get_coarse_ns_proto;
>> +	case BPF_FUNC_sock_destroy:
>> +		return &bpf_sock_destroy_proto;
>> 	default:
> This is a really neat feature! One question though; above it seems to
> suggest that the helper is only exposed to BPF iterators, but by

The v2 patch only exposes the capability to BPF iterators. The patch =
series
has details involving locking semantics due to which the kfunc is only =
available
for BPF iterators at the moment.=20

> adding it to bpf_sk_base_func_proto() won't it be available to
> other BPF programs like sock_addr, sk_filter etc? If I've got that
> right, we'd definitely want to exclude potentially unprivileged
> programs from having access to this helper. And to be clear, I'd
> definitely see value in having it accessible to other BPF program
> types too like sockops if possible, but just wanted to check.=20
>=20
>> 		return bpf_base_func_proto(func_id);
>> 	}
>> @@ -11578,3 +11580,71 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>>=20
>> 	return func;
>> }
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
>=20
> risk of a NULL sk here?
>=20
> Thanks!
>=20
> Alan

