Return-Path: <bpf+bounces-42085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492699F51F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B971F23BA0
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20D20B1F5;
	Tue, 15 Oct 2024 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNnku2Q7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00A1FC7DB;
	Tue, 15 Oct 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016450; cv=none; b=PNcC2LFUt0rcLOw3ciAvH0Xwp5ZFr56HK1OC9Q2hVaHWYtYm+rTmBZMH9Cdg2N+r0/Xr6v6bvmKZ8E11sHCrxn/nwDSlr/nRoL0oM7E8kgd9R0fagOMEC9sboI+2YyBFNZp5u3N+WVEbPNu4BZm5+qUuvuXrYplqWAsfe2TE0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016450; c=relaxed/simple;
	bh=g8nT497GMiygyFDnwm3UL7vZJXgT02yAs6uY8uejgpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeQQL3NJ7MTSLCP2W86R7200iQoEoz1ra+AR0xxJWeWTLYj2FGHntoRBuFRK9ChQD7KSTCF3C6/A/D0+Wp8VA/VlYE5GIPYKfI4cWRuK272FIIhvKfvOcUo1LvHFfNVzEszFh078r5fUmdg65l0vjjNAF5ZLiMV78YFtBdPYlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNnku2Q7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so66960755e9.3;
        Tue, 15 Oct 2024 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729016447; x=1729621247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hIvEnwBZ343cKXtDWuohtqPG1xM3p2Kt+DcJe0+iuY=;
        b=hNnku2Q7+2wRJhSt3BgY/tGDabxArWx+Vi0yWjp0q1cTRr/zRzcfIowwJ/coK8LhVD
         4ryPlgxNIJhgsu8k/iZwvdbnTb4cCqb8RnesLOqCHqw+LwWvfWbIoiyba09wLqHkwoys
         ZyQvGeOsVhRehySJ7OfcnGibyxPHxwrgm1z7rFc8Y/SMHFuIpx3OP4znZ2PFGgHaJx9G
         Cm863F9NoDwsAggs82Fwd3gDpRRABNOUUOxsWbTcy7PaBd+TMN9j23QE05SSmw4b59tg
         e0bRuZapBkZdsyrYZsig7U2HTHxZQUPlkf2KiMMJN8A6DkVyte1b2T77Pl+HibP2XnqJ
         W8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016447; x=1729621247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hIvEnwBZ343cKXtDWuohtqPG1xM3p2Kt+DcJe0+iuY=;
        b=F3Vv09tWeQeGryT0ziR0znTLxCdj7rmEqQ3Gz6y4cJMJUprsK+d/sLMCVRxshQPg31
         ZsVJRtCpmupObOKQpLhiUT4YMW8ExKsQbL8kfFAOtsJFbJjs8TvaOUzJ1My53f52NPUd
         u+tdD4LLmoePlEPS2TWJVN8Q741FCbvwGw1nd3PwKidlPl+5P5FRs2I5VikVkg+SggMn
         eq6nlrUTDmd5MyHUBBkeiNvoEABpC2Tgxy0kc67Xb43dixTITa8tEfNwieXioByjjYEQ
         0B7tiHA6qe8D4Esh56ZZrrQzCXkfvgBk2c8EZuIhin2r4/nqon8y7Wm2DNjauwYVn23u
         OrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM0geHepBYK5cgl0/QZ5vswqyqYBIJFaqup7sXqd0KGobPHY9rutc/MTjRnHkqe1+AeQ8=@vger.kernel.org, AJvYcCXSaHnOSEd3XSY75Snkcex6NYFqla2EcGPdKzw22QrMnryzJ12uotMWeLwBapNgX5vouAvFJgKItNFyscAW@vger.kernel.org
X-Gm-Message-State: AOJu0YzE74WrdAES+I7kzI+xQPC3SRNa0UUvs+A0EGGOFvnHto/B0xYY
	thfYnvLtLljcyFRQbweMNse48BfWmhNT1QpFFf47rxf8Ytf3yYQd63ejYMmHkJ/ApEZkn07JhLu
	IRf+bOKnsyZD5Z0Oeu7oQILe7Ac2ROg==
X-Google-Smtp-Source: AGHT+IHvJ85qAy8RGc7TMIASBFKYzWQ9JcXsWekK+Q8OmG4nD6dD8iSA26w0OoZimU4HtbjlgcCICbIJ9/P2WVIS20M=
X-Received: by 2002:a05:600c:190f:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-431255db3f6mr133664955e9.12.1729016446377; Tue, 15 Oct 2024
 11:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008114940.44305-1-puranjay@kernel.org> <20241008114940.44305-2-puranjay@kernel.org>
 <CAEf4Bza5HCFZmMA8UcM92TXzDq8CxKpjPkQ_s2PLuc-dGR8y2A@mail.gmail.com> <mb61pbjzln0yn.fsf@kernel.org>
In-Reply-To: <mb61pbjzln0yn.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Oct 2024 11:20:34 -0700
Message-ID: <CAADnVQ+_dpZCYrh3-6nLwSr_Bwndq4TCvqu=m8jQJP+k1AZa6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: implement bpf_send_signal_task() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Tue, Oct 8, 2024 at 4:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> >>
> >> Implement bpf_send_signal_task kfunc that is similar to
> >> bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
> >> send signals to other threads and processes. It also supports sending =
a
> >> cookie with the signal similar to sigqueue().
> >>
> >> If the receiving process establishes a handler for the signal using th=
e
> >> SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
> >> si_value field of the siginfo_t structure passed as the second argumen=
t
> >> to the handler.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  kernel/bpf/helpers.c     |  1 +
> >>  kernel/trace/bpf_trace.c | 52 +++++++++++++++++++++++++++++++++------=
-
> >>  2 files changed, 45 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 4053f279ed4cc..2fd3feefb9d94 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3035,6 +3035,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQU=
IRE | KF_RCU | KF_RET_NULL)
> >>  #endif
> >>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> >>  BTF_ID_FLAGS(func, bpf_throw)
> >> +BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> >>  BTF_KFUNCS_END(generic_btf_ids)
> >>
> >>  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index a582cd25ca876..d9662e84510d3 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -802,6 +802,8 @@ struct send_signal_irq_work {
> >>         struct task_struct *task;
> >>         u32 sig;
> >>         enum pid_type type;
> >> +       bool has_siginfo;
> >> +       struct kernel_siginfo info;
> >>  };
> >>
> >>  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
> >> @@ -809,27 +811,46 @@ static DEFINE_PER_CPU(struct send_signal_irq_wor=
k, send_signal_work);
> >>  static void do_bpf_send_signal(struct irq_work *entry)
> >>  {
> >>         struct send_signal_irq_work *work;
> >> +       struct kernel_siginfo *siginfo;
> >>
> >>         work =3D container_of(entry, struct send_signal_irq_work, irq_=
work);
> >> -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work=
->type);
> >> +       siginfo =3D work->has_siginfo ? &work->info : SEND_SIG_PRIV;
> >> +
> >> +       group_send_sig_info(work->sig, siginfo, work->task, work->type=
);
> >>         put_task_struct(work->task);
> >>  }
> >>
> >> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> >> +static int bpf_send_signal_common(u32 sig, enum pid_type type, struct=
 task_struct *task, u64 value)
> >>  {
> >>         struct send_signal_irq_work *work =3D NULL;
> >> +       struct kernel_siginfo info;
> >> +       struct kernel_siginfo *siginfo;
> >> +
> >> +       if (!task) {
> >> +               task =3D current;
> >> +               siginfo =3D SEND_SIG_PRIV;
> >> +       } else {
> >> +               clear_siginfo(&info);
> >> +               info.si_signo =3D sig;
> >> +               info.si_errno =3D 0;
> >> +               info.si_code =3D SI_KERNEL;
> >> +               info.si_pid =3D 0;
> >> +               info.si_uid =3D 0;
> >> +               info.si_value.sival_ptr =3D (void *)(unsigned long)val=
ue;
> >> +               siginfo =3D &info;
> >> +       }
> >>
> >>         /* Similar to bpf_probe_write_user, task needs to be
> >>          * in a sound condition and kernel memory access be
> >>          * permitted in order to send signal to the current
> >>          * task.
> >>          */
> >> -       if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
> >> +       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
> >>                 return -EPERM;
> >>         if (unlikely(!nmi_uaccess_okay()))
> >>                 return -EPERM;
> >>         /* Task should not be pid=3D1 to avoid kernel panic. */
> >> -       if (unlikely(is_global_init(current)))
> >> +       if (unlikely(is_global_init(task)))
> >>                 return -EPERM;
> >>
> >>         if (irqs_disabled()) {
> >> @@ -847,19 +868,21 @@ static int bpf_send_signal_common(u32 sig, enum =
pid_type type)
> >>                  * to the irq_work. The current task may change when q=
ueued
> >>                  * irq works get executed.
> >>                  */
> >> -               work->task =3D get_task_struct(current);
> >> +               work->task =3D get_task_struct(task);
> >> +               work->has_siginfo =3D siginfo =3D=3D &info;
> >> +               copy_siginfo(&work->info, &info);
> >
> > we shouldn't copy_siginfo() if !work->has_siginfo, no?
>
> Yes, but it is only used when has_siginfo is true, so copying it doesn't
> cause any problems. I just didn't want to add another check here.

Still, let's avoid a pointless copy.
If I'm reading it correctly it will copy uninitialized memory
and sanitizers won't be happy.

Pls respin.

