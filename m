Return-Path: <bpf+bounces-40615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A998AF75
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D79B2417F
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48118754D;
	Mon, 30 Sep 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPBjaXoP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9A15E97;
	Mon, 30 Sep 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733153; cv=none; b=UH02dWlIyw+yuwd/2JMkBNRRLYMoPAX5OLpxBOO3nT1P+Ys2IoY9z8b23mLNyOcex1MZFpEMZj3EeuF7Lz4HODR81swW1GhvaxI4iwrbZjy2NKvV/ksAVDGTXV/7zHJX/l1tB0e4AjbIiR/PCIPTjohXgmdCVH09Zxxs8r12lfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733153; c=relaxed/simple;
	bh=7AYToSm+YLx/ySbs4rmudrF2CAZpd+LDWLQoVQwrMuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxpL/Kmg4Me3/jUsd7mz2lOKEtjMxsUzLEKlOzoK6J9G9eM6PCO9oIeZqjhhVALKg64INiQhIpKIfLgaAoj967o7JRr2QEXbpSn65pjEILz9199gSSw81J3P2yZZlV+qC+6Ml/CMRbdMf5gUiRIo+EKlZEAEL87co7m2crGvhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPBjaXoP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e137183587so1029766a91.3;
        Mon, 30 Sep 2024 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727733150; x=1728337950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/dGOU6/DyGTPGsE+EFtrlj1MYO6DRcr08abM9lQN98=;
        b=IPBjaXoP2+4q+Tn3/Y31RUFw0fWTX+XC3iqBSSdQagx3Z5HGciplVS2SrQz8X5zKyu
         RpLoGeKirnCty7RhFXun3zugtqG2xgtjFQHYcyekWBl6xDV/4M6MJnpbmOMcAB4mCyzY
         w6hYuLGDmDE+pvs7GBGSAFECshBRnLiGqcbnPV1Bph6swSl2edofN+gOEBQ/sRJihP8J
         3skJkRqj2FNYcskVMSU8OCQVDcq34e+wMoHmRjzQnMqk2a9/DysNkcySbpN3oG7xPF1G
         bhjwIJXTnb7KLGiW1j7+n7AquzKaVeSbJZw3QxknTQqkEHq5VVFoGFSprip+ZBWgOzeg
         YPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727733150; x=1728337950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/dGOU6/DyGTPGsE+EFtrlj1MYO6DRcr08abM9lQN98=;
        b=Vsc+dt6vY1r7JCz8Jh9cjXu36XpScdeXgTUNbXitZyUES90X0fdWjabLButCPcYyZb
         jqag0EB7cLalzrIpcV0SI/abmePB0fv8WYjKVq+7jS4OmNyyTlxHlIoUyL0jKDuEkIYE
         BcViHZzexcn8fvKs3JMwy8DyKDHEjuBfk/SRQiVP9gpcCi2w0Zi3OfevMxZdN21zWM5D
         5Gegyskle9mkjvA2yfJmZfAw787dCxG1zyvuEG93/PLuceRZkg81s91v96SR/372U3Kj
         GDLbsDxgqIME+s6Lhp9Hfq0wCqJzqdsBtGHXaaLDustx4pI8qa5i6vSBvE2z+APdz2IU
         cJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlvidMO7owTKhzXplAMm15KY5dN6AzMfNVG+AEBcnUMgD5fuy6qCw6YDwVdqbnOKDzcj0=@vger.kernel.org, AJvYcCWwKGv3mPhNaAifQs6lgKc+72lleWoHpj8sNGHvNUtq928xsZBEPPURThjbpZF5fQZlu4U9eNLeknqzwkne@vger.kernel.org
X-Gm-Message-State: AOJu0YzChuniC2Sc9Wtm661ud2l/mOgMAkswg9sA88l3XdS57U27rOOj
	eljW4zB1WVamsqRWCsVdrUXgYI32MCtiIh+nLl/Y179SWOjVgj9APmxCMgotKTwH2HNdRSGBE8G
	ENIIwxsIDzrnW8lYG9ofaKW2T6zU=
X-Google-Smtp-Source: AGHT+IG2R76mkh8zb+ZI+9j/OwCAT4Yf5sniEhlyf0cw/FcLd0xejibzVdTv7ntB03TCtxyU//Ade71LQxtoH7GwD2s=
X-Received: by 2002:a17:90a:f00a:b0:2d8:3fe8:a18e with SMTP id
 98e67ed59e1d1-2e0b8872d71mr15883003a91.5.1727733150147; Mon, 30 Sep 2024
 14:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926115328.105634-1-puranjay@kernel.org> <20240926115328.105634-2-puranjay@kernel.org>
 <CAEf4BzaUq9WqKL1n8uHJQw3hbEFHYS4c3RN7qPWzbtYHzREThw@mail.gmail.com>
In-Reply-To: <CAEf4BzaUq9WqKL1n8uHJQw3hbEFHYS4c3RN7qPWzbtYHzREThw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:52:18 -0700
Message-ID: <CAEf4Bzac9hbk7vgKETsS56iqy9Did8Zq6HJkQha4ksCE-Fk-2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: implement bpf_send_signal_remote() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 4:53=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Implement bpf_send_signal_remote kfunc that is similar to
> > bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
> > send signals to other threads and processes. It also supports sending a
> > cookie with the signal similar to sigqueue().
> >
> > If the receiving process establishes a handler for the signal using the
> > SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
> > si_value field of the siginfo_t structure passed as the second argument
> > to the handler.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 78 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a582cd25ca876..51b27db1321fc 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -802,6 +802,9 @@ struct send_signal_irq_work {
> >         struct task_struct *task;
> >         u32 sig;
> >         enum pid_type type;
> > +       bool is_siginfo;
> > +       kernel_siginfo_t info;
> > +       int value;
> >  };
> >
> >  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
> > @@ -811,7 +814,11 @@ static void do_bpf_send_signal(struct irq_work *en=
try)
> >         struct send_signal_irq_work *work;
> >
> >         work =3D container_of(entry, struct send_signal_irq_work, irq_w=
ork);
> > -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work-=
>type);
> > +       if (work->is_siginfo)
> > +               group_send_sig_info(work->sig, &work->info, work->task,=
 work->type);
> > +       else
> > +               group_send_sig_info(work->sig, SEND_SIG_PRIV, work->tas=
k, work->type);
> > +
> >         put_task_struct(work->task);
> >  }
> >
> > @@ -848,6 +855,7 @@ static int bpf_send_signal_common(u32 sig, enum pid=
_type type)
> >                  * irq works get executed.
> >                  */
> >                 work->task =3D get_task_struct(current);
> > +               work->is_siginfo =3D false;
> >                 work->sig =3D sig;
> >                 work->type =3D type;
> >                 irq_work_queue(&work->irq_work);
> > @@ -3484,3 +3492,71 @@ static int __init bpf_kprobe_multi_kfuncs_init(v=
oid)
> >  }
> >
> >  late_initcall(bpf_kprobe_multi_kfuncs_init);
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_send_signal_remote(struct task_struct *task, int s=
ig, enum pid_type type,
> > +                                      int value)

Bikeshedding here a bit, but would bpf_send_signal_task() be a better
name for something that accepts task_struct?

> > +{
> > +       struct send_signal_irq_work *work =3D NULL;
> > +       kernel_siginfo_t info;
> > +
> > +       if (type !=3D PIDTYPE_PID && type !=3D PIDTYPE_TGID)
> > +               return -EINVAL;
> > +       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
> > +               return -EPERM;
> > +       if (unlikely(!nmi_uaccess_okay()))
> > +               return -EPERM;
> > +       /* Task should not be pid=3D1 to avoid kernel panic. */
> > +       if (unlikely(is_global_init(task)))
> > +               return -EPERM;
> > +
> > +       clear_siginfo(&info);
> > +       info.si_signo =3D sig;
> > +       info.si_errno =3D 0;
> > +       info.si_code =3D SI_KERNEL;
> > +       info.si_pid =3D 0;
> > +       info.si_uid =3D 0;
> > +       info.si_value.sival_int =3D value;
>
> It seems like it could be either int sival_int or `void *sival_ptr`,
> i.e., it's actually a 64-bit value on 64-bit architectures.
>
> Can we allow passing a full u64 here and assign it to sival_ptr (with a c=
ast)?

Seems like Alexei already suggested that on patch #2, I support the request=
.

>
> > +
> > +       if (irqs_disabled()) {
> > +               /* Do an early check on signal validity. Otherwise,
> > +                * the error is lost in deferred irq_work.
> > +                */
> > +               if (unlikely(!valid_signal(sig)))
> > +                       return -EINVAL;
> > +
> > +               work =3D this_cpu_ptr(&send_signal_work);
> > +               if (irq_work_is_busy(&work->irq_work))
> > +                       return -EBUSY;
> > +
> > +               work->task =3D get_task_struct(task);
> > +               work->is_siginfo =3D true;
> > +               work->info =3D info;
> > +               work->sig =3D sig;
> > +               work->type =3D type;
> > +               work->value =3D value;
> > +               irq_work_queue(&work->irq_work);
> > +               return 0;
> > +       }
> > +
> > +       return group_send_sig_info(sig, &info, task, type);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(send_signal_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_send_signal_remote, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(send_signal_kfunc_ids)
> > +
> > +static const struct btf_kfunc_id_set bpf_send_signal_kfunc_set =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .set =3D &send_signal_kfunc_ids,
> > +};
> > +
> > +static int __init bpf_send_signal_kfuncs_init(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_se=
nd_signal_kfunc_set);
>
> let's allow it for other program types (at least kprobes, tracepoints,
> raw_tp, etc, etc)? Is there any problem just allowing it for any
> program type?
>
>
> > +}
> > +
> > +late_initcall(bpf_send_signal_kfuncs_init);
> > --
> > 2.40.1
> >

