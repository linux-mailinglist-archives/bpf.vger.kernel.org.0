Return-Path: <bpf+bounces-40654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775398B739
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D8F1F21EB7
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2419D072;
	Tue,  1 Oct 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To9NLtaj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26B1E4AF;
	Tue,  1 Oct 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771995; cv=none; b=c8HgvN+A3WTS50fOyQdc+PAeYJX72wK/pCRNWOLu2uwIEoAzfJYxeFGfn7ZmEGfe4rOABnaHJnABo3C+wJG6rf3njKg00r49Cai1TyfNvS+yj4OlbhA1SVuGCcLG6U1j5Exaoq4i1hRQNhbDOBg6Ws0Lko2XvwRxELLVmDRlH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771995; c=relaxed/simple;
	bh=Qcz6VQ4uHlgWk01HX04LTuG6JfPgG3fkjsGgl9MctzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnffOIm3IdVtonzuS0RakjHqwbeEF2N3sptLyQLHBcxwg7VGBNhiO3QIEotTKAFu6VNKjRNjXcTuA1MTfkrJSoFc7BUQ0wyMJvuDRG+l4RJp5oe30SUolzJuWMVN9PHgD0o8Lh7ylAGVa5GPreglvvQ8nUXUjGc2W/hqNpyai84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To9NLtaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA2FC4CEC6;
	Tue,  1 Oct 2024 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727771994;
	bh=Qcz6VQ4uHlgWk01HX04LTuG6JfPgG3fkjsGgl9MctzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=To9NLtajc6x3xsqu0x7pI6et5ppKJuzjdtZ7NuoV5SOmVhgrdyXJ7baCcGI0MJc+b
	 i/+LpUmbjfLb1sFmQa5O+kFJ8Y0MVlZSfqQwevXT56Rx30OSPVAxzA/6180RdKTDyv
	 DYU8rsYuVScHPnkSF4H8Mf5jOqEoo+axC9OzcakgD1LbkbdhSa0UmF09CvSHALtBEg
	 vKgb0BYM+oWb1m0myMQyh2iPRQODJEIvaoTMqIU4vLrJNJgv1Tf4TTEpOQDgN7BWLi
	 w5DscMAa3tSfxlroY4mbqn9IQw3JifL3I5+2ULvn+Y9J+N+zKri94HVMHZS45pKq8r
	 2V79rNjJbkpsw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: implement bpf_send_signal_remote()
 kfunc
In-Reply-To: <CAEf4Bzac9hbk7vgKETsS56iqy9Did8Zq6HJkQha4ksCE-Fk-2A@mail.gmail.com>
References: <20240926115328.105634-1-puranjay@kernel.org>
 <20240926115328.105634-2-puranjay@kernel.org>
 <CAEf4BzaUq9WqKL1n8uHJQw3hbEFHYS4c3RN7qPWzbtYHzREThw@mail.gmail.com>
 <CAEf4Bzac9hbk7vgKETsS56iqy9Did8Zq6HJkQha4ksCE-Fk-2A@mail.gmail.com>
Date: Tue, 01 Oct 2024 08:39:41 +0000
Message-ID: <mb61pr090cj3m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Sep 30, 2024 at 2:48=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Sep 26, 2024 at 4:53=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
>> >
>> > Implement bpf_send_signal_remote kfunc that is similar to
>> > bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
>> > send signals to other threads and processes. It also supports sending a
>> > cookie with the signal similar to sigqueue().
>> >
>> > If the receiving process establishes a handler for the signal using the
>> > SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
>> > si_value field of the siginfo_t structure passed as the second argument
>> > to the handler.
>> >
>> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> > ---
>> >  kernel/trace/bpf_trace.c | 78 +++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 77 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> > index a582cd25ca876..51b27db1321fc 100644
>> > --- a/kernel/trace/bpf_trace.c
>> > +++ b/kernel/trace/bpf_trace.c
>> > @@ -802,6 +802,9 @@ struct send_signal_irq_work {
>> >         struct task_struct *task;
>> >         u32 sig;
>> >         enum pid_type type;
>> > +       bool is_siginfo;
>> > +       kernel_siginfo_t info;
>> > +       int value;
>> >  };
>> >
>> >  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
>> > @@ -811,7 +814,11 @@ static void do_bpf_send_signal(struct irq_work *e=
ntry)
>> >         struct send_signal_irq_work *work;
>> >
>> >         work =3D container_of(entry, struct send_signal_irq_work, irq_=
work);
>> > -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work=
->type);
>> > +       if (work->is_siginfo)
>> > +               group_send_sig_info(work->sig, &work->info, work->task=
, work->type);
>> > +       else
>> > +               group_send_sig_info(work->sig, SEND_SIG_PRIV, work->ta=
sk, work->type);
>> > +
>> >         put_task_struct(work->task);
>> >  }
>> >
>> > @@ -848,6 +855,7 @@ static int bpf_send_signal_common(u32 sig, enum pi=
d_type type)
>> >                  * irq works get executed.
>> >                  */
>> >                 work->task =3D get_task_struct(current);
>> > +               work->is_siginfo =3D false;
>> >                 work->sig =3D sig;
>> >                 work->type =3D type;
>> >                 irq_work_queue(&work->irq_work);
>> > @@ -3484,3 +3492,71 @@ static int __init bpf_kprobe_multi_kfuncs_init(=
void)
>> >  }
>> >
>> >  late_initcall(bpf_kprobe_multi_kfuncs_init);
>> > +
>> > +__bpf_kfunc_start_defs();
>> > +
>> > +__bpf_kfunc int bpf_send_signal_remote(struct task_struct *task, int =
sig, enum pid_type type,
>> > +                                      int value)
>
> Bikeshedding here a bit, but would bpf_send_signal_task() be a better
> name for something that accepts task_struct?

I agree, will use that name in the next version.

>> > +{
>> > +       struct send_signal_irq_work *work =3D NULL;
>> > +       kernel_siginfo_t info;
>> > +
>> > +       if (type !=3D PIDTYPE_PID && type !=3D PIDTYPE_TGID)
>> > +               return -EINVAL;
>> > +       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
>> > +               return -EPERM;
>> > +       if (unlikely(!nmi_uaccess_okay()))
>> > +               return -EPERM;
>> > +       /* Task should not be pid=3D1 to avoid kernel panic. */
>> > +       if (unlikely(is_global_init(task)))
>> > +               return -EPERM;
>> > +
>> > +       clear_siginfo(&info);
>> > +       info.si_signo =3D sig;
>> > +       info.si_errno =3D 0;
>> > +       info.si_code =3D SI_KERNEL;
>> > +       info.si_pid =3D 0;
>> > +       info.si_uid =3D 0;
>> > +       info.si_value.sival_int =3D value;
>>
>> It seems like it could be either int sival_int or `void *sival_ptr`,
>> i.e., it's actually a 64-bit value on 64-bit architectures.
>>
>> Can we allow passing a full u64 here and assign it to sival_ptr (with a =
cast)?
>
> Seems like Alexei already suggested that on patch #2, I support the reque=
st.
>
>>
>> > +
>> > +       if (irqs_disabled()) {
>> > +               /* Do an early check on signal validity. Otherwise,
>> > +                * the error is lost in deferred irq_work.
>> > +                */
>> > +               if (unlikely(!valid_signal(sig)))
>> > +                       return -EINVAL;
>> > +
>> > +               work =3D this_cpu_ptr(&send_signal_work);
>> > +               if (irq_work_is_busy(&work->irq_work))
>> > +                       return -EBUSY;
>> > +
>> > +               work->task =3D get_task_struct(task);
>> > +               work->is_siginfo =3D true;
>> > +               work->info =3D info;
>> > +               work->sig =3D sig;
>> > +               work->type =3D type;
>> > +               work->value =3D value;
>> > +               irq_work_queue(&work->irq_work);
>> > +               return 0;
>> > +       }
>> > +
>> > +       return group_send_sig_info(sig, &info, task, type);
>> > +}
>> > +
>> > +__bpf_kfunc_end_defs();
>> > +
>> > +BTF_KFUNCS_START(send_signal_kfunc_ids)
>> > +BTF_ID_FLAGS(func, bpf_send_signal_remote, KF_TRUSTED_ARGS)
>> > +BTF_KFUNCS_END(send_signal_kfunc_ids)
>> > +
>> > +static const struct btf_kfunc_id_set bpf_send_signal_kfunc_set =3D {
>> > +       .owner =3D THIS_MODULE,
>> > +       .set =3D &send_signal_kfunc_ids,
>> > +};
>> > +
>> > +static int __init bpf_send_signal_kfuncs_init(void)
>> > +{
>> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_s=
end_signal_kfunc_set);
>>
>> let's allow it for other program types (at least kprobes, tracepoints,
>> raw_tp, etc, etc)? Is there any problem just allowing it for any
>> program type?
>>
>>
>> > +}
>> > +
>> > +late_initcall(bpf_send_signal_kfuncs_init);
>> > --
>> > 2.40.1
>> >

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZvu1ThQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2ndbrAQCfIcuWTHMcufHJ1bYitlCsOYpS3KKT
HLXiY+QDA6CGDgD/an28okX/P+RZJHQeZPVjrK3bMpWZW1DWm9w1f4dAHg8=
=FDYr
-----END PGP SIGNATURE-----
--=-=-=--

