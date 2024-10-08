Return-Path: <bpf+bounces-41282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC589956C5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B04F1F26077
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301B212EFD;
	Tue,  8 Oct 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHoAIdQY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C351E04A9;
	Tue,  8 Oct 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412722; cv=none; b=tBdPGEptggUFz00iGsq7dvc+pN7/TX2x43ypKvanwsCRrXBevxN2oxIeJDFw+CyJH6xiEwdcXVAz9BUA5Oyy9LCB6UDkpJAKASyP16JNQVt4CQQIIOlnrDcWioeKj/PlE0uZcrfksmvHZezRsf5lxfC5Sj5oBiDnBN+mW0beu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412722; c=relaxed/simple;
	bh=dLz2ZBA6L5v8uDqUKzhTJ9UOlinhQAVB5p3xRKS9eG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0rQDzwFdyWjoY/o+Ty0AZ2tDQe7sj5MxIS+DjshORAwXAZZMKIPdS07GwxFIUJc/csGkB8BsDsd+/9bQ5ISp+gGlYRpoHIMotEZCue7yyOcGel5xtubgqawQinHTBbKUIAqK5f9mAgHDAXBVUnhUNFnmed1Wn00czyXhXwDmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHoAIdQY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e29555a1b2so397497a91.3;
        Tue, 08 Oct 2024 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412719; x=1729017519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsE/EZliWlbn6BtJlkYSgP3EkhvWs+acR8Hxh38oK7o=;
        b=VHoAIdQYzVg2nQS0dMtKRnS6fARqRCOL27Er+idyY+irPTgwudLxUUZCxrD9Ncj/r5
         a/ZTywDPZAqfQjhwsMcJBX+pNLnVgXHZRO2i18ZpuGsP4h/zteWqiS1Ml3aUM4UReE9B
         QA1pyL+aRqdN9I37VSCsGCNWg7L/yJ1N9BvEU/ntm/msqy1Pca8oEEYZbbiovK9dhAZc
         rEuYVQ2DlG08LoSPWHELHNpRqxvlV0icOHD2gblo7cTYphGL871XDv8mKa+1Mx7n24Nq
         +fj/qBI4W5KfEEgXd6rcCcB7UTQAYWefXf1mpxIcPiuz/j9EDYginDrRC2AEAN9fz7jO
         bojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412719; x=1729017519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsE/EZliWlbn6BtJlkYSgP3EkhvWs+acR8Hxh38oK7o=;
        b=cNuqhqYUkwvTgYMr0WHQLW/l/lEvPDPASpBpkDZX7Fn2Pc2oxzxrppxDww54EkKMWM
         bjxMtFQ31EqdRZx/ZJSy9DRF/KvQU4U3JcLnjLQcm8/t6km38jMJ6yoFEAgMK44IQmap
         TgBqSfh/fpT1ywWoP/X8q0zyKsNvJQuH8QI4CaIlwhpIiDV58jKm7bxwTkDkPleo8b30
         zVWIDTVib7Ua484Y7ArLBzxewX3zuVvQVMd+0E0MmwNciHTU0YEg54T8qQPRZmmLHATH
         gJbfNCLyiSMXbwIog+gyqaZVL4UE2NKbUGZhlDsWrK8d+11gwUzGopaGN1OK/LyAdyzq
         vnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNTW7eMn2AwQV5b+uVcx761lEkUmP3er2KJm9CtuvwhkTn1rNNycJcYlawneYxH97yO8U=@vger.kernel.org, AJvYcCXTWwaZmGFw1Bz5QndkrmJEpKLRUnlkjjBEaTZjYTejxp5tI1edxPIr1AjtR9o95BePQR6gG8w2aU1IzoeT@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFBQP5Ys+/HsLaD5hVvWN7W/VETC8Hkkj4olW2SL8UQph9HIy
	YP054lG/2z3Vdjs/22JbC+uboZO5xN4khjXJXVGHzjVdxej18XKV6XUllKJatFCsp28ikM5HQde
	pY+RZb59wMLeKBc0EDY42NVvct5o=
X-Google-Smtp-Source: AGHT+IEEBRN0w+ro8u+BOIFDodFgJw09NAlx5+ME/D3KtRH50tOhIplZ1G8r86CnVrHcGpKZgDFmCUaPPaZga/9Yb7k=
X-Received: by 2002:a17:90a:458b:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2e1e6212e23mr21168425a91.1.1728412719520; Tue, 08 Oct 2024
 11:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007103426.128923-1-puranjay@kernel.org> <20241007103426.128923-2-puranjay@kernel.org>
 <CAEf4BzZMiwcMY3H9=qwpgCKQxDZmKHcmxEJtRhrTCgNar8YaXQ@mail.gmail.com> <CANk7y0iz9SWLXFMbdhOp+1JBqaB6Qhyt6rKonQyE4vGLy=7hYw@mail.gmail.com>
In-Reply-To: <CANk7y0iz9SWLXFMbdhOp+1JBqaB6Qhyt6rKonQyE4vGLy=7hYw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Oct 2024 11:38:27 -0700
Message-ID: <CAEf4BzZLdJmDGLr3GoLBkXrO_UfPRD-cLBKN5yAv0ATDx-Szvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: implement bpf_send_signal_task() kfunc
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Tue, Oct 8, 2024 at 6:24=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 7, 2024 at 3:34=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> > >
> > > Implement bpf_send_signal_task kfunc that is similar to
> > > bpf_send_signal_thread and bpf_send_signal helpers  but can be used t=
o
> > > send signals to other threads and processes. It also supports sending=
 a
> > > cookie with the signal similar to sigqueue().
> > >
> > > If the receiving process establishes a handler for the signal using t=
he
> > > SA_SIGINFO flag to sigaction(), then it can obtain this cookie via th=
e
> > > si_value field of the siginfo_t structure passed as the second argume=
nt
> > > to the handler.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > >  kernel/bpf/helpers.c     |  1 +
> > >  kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++----=
--
> > >  2 files changed, 47 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 4053f279ed4cc..2fd3feefb9d94 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -3035,6 +3035,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQ=
UIRE | KF_RCU | KF_RET_NULL)
> > >  #endif
> > >  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_throw)
> > > +BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> > >  BTF_KFUNCS_END(generic_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index a582cd25ca876..ae8c9fa8b04d1 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -802,6 +802,8 @@ struct send_signal_irq_work {
> > >         struct task_struct *task;
> > >         u32 sig;
> > >         enum pid_type type;
> > > +       bool has_siginfo;
> > > +       kernel_siginfo_t info;
> >
> > group_send_sig_info() refers to this as `struct kernel_siginfo`, let's
> > use that and avoid unnecessary typedefs
> >
> > >  };
> > >
> > >  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work)=
;
> > > @@ -811,25 +813,43 @@ static void do_bpf_send_signal(struct irq_work =
*entry)
> > >         struct send_signal_irq_work *work;
> > >
> > >         work =3D container_of(entry, struct send_signal_irq_work, irq=
_work);
> > > -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, wor=
k->type);
> > > +       if (work->has_siginfo)
> > > +               group_send_sig_info(work->sig, &work->info, work->tas=
k, work->type);
> > > +       else
> > > +               group_send_sig_info(work->sig, SEND_SIG_PRIV, work->t=
ask, work->type);
> >
> > There is lots of duplication while the only difference is between
> > providing SEND_SIG_PRIV and our own &work->info. So maybe let's just
> > have something like
> >
> > struct kernel_siginfo *siginfo;
> >
> > siginfo =3D work->has_siginfo ? &work->info : SEND_SIG_PRIV;
> > group_send_sig_info(work->sig, siginfo, work->task, work->type);
> >
> > ?
> >
> > >         put_task_struct(work->task);
> > >  }
> > >
> > > -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> > > +static int bpf_send_signal_common(u32 sig, enum pid_type type, struc=
t task_struct *tsk, u64 value)
> >
> > task? why tsk?
> >
> > >  {
> > >         struct send_signal_irq_work *work =3D NULL;
> > > +       kernel_siginfo_t info;
> > > +       bool has_siginfo =3D false;
> > > +
> > > +       if (!tsk) {
> > > +               tsk =3D current;
> > > +       } else {
> > > +               has_siginfo =3D true;
> >
> > nit: I find it less confusing for cases like with has_siginfo here,
> > for the variable to be explicitly assigned in both branches, instead
> > of defaulting to false and then reassigned in one of the branches
> >
> > > +               clear_siginfo(&info);
> > > +               info.si_signo =3D sig;
> > > +               info.si_errno =3D 0;
> > > +               info.si_code =3D SI_KERNEL;
> > > +               info.si_pid =3D 0;
> > > +               info.si_uid =3D 0;
> > > +               info.si_value.sival_ptr =3D (void *)value;
> > > +       }
> >
> > kernel test bot complains that this should probably be (void
> > *)(unsigned long)value (which will truncate on 32-bit archtes, but oh
> > well)
> >
> > but can you please double check that it's ok to set
> > info.si_value.sival_ptr for any signal? Because si_value.sival_ptr is
> > actually defined inside __sifields._rt._sigval, which clearly would
> > conflict with _kill, _timer, _sigchld and other groups of signals.
> >
> > so I suspect we'd need to have a list of signals that are OK accepting
> > this extra u64 value, and reject it otherwise (instead of silently
> > corrupting data inside __sifields
>
> I tried reading the man pages of sigqueue and it allows using all signals=
.
>
> To test it, I sent SIGCHLD to a process with si_value.sival_ptr using
> sigqueue() and it worked as expected.
>
> It shouldn't affect us as we are not populating all fields of
> __sifields anyway. For example if you send SIGCHLD using

But __sifields is *a union*, where there is a separate struct for
kill, separate for timer signals, separate for POSIX.1b signals, and
yet another struct (inside the union, so they are all mutually
exclusive) for SIGCHLD. Then another group for SIGILL, SIGFPE,
SIGSEGV, SIGBUS, SIGTRAP, SIGEMT. SIGPOLL is separate, and SIGSYS is
separate still.

So I'm confused. Sure, C will allow you to set _rt._sigval fields, but
the question is which part of that union is the kernel using for
different signals? Or are you saying that whatever is sent with
group_send_sig_info() will use __sifields._rt part of the union,
regardless of the actual signal?

> this new kfunc, there is no way to set _utime and _stime or even _pid
> and _uid, here only the signal number
> and this u64 value is relevant.
>
> I will make all the other suggested changes in the next version.
>
>
> Thanks,
> Puranjay

