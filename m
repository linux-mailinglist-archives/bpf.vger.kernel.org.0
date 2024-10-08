Return-Path: <bpf+bounces-41238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221F99452D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B721F254A8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A31922C7;
	Tue,  8 Oct 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbH+UvdL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CEEEC8;
	Tue,  8 Oct 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382674; cv=none; b=ux7c6DerfhvpuSbQZVcqKymojTDlKBg6E5UWQVrBiIRvqsO3KL46FI5m2cpFsMSwALTtSdHDBR3+O7RsodJxnN7A+ga/Zm3hdDvTKnv4tetgMywsv2clqnhsl+eNLuoFp8v8n56txJ7Xa1hoi4c5rlk48W2dkXRB54C2cirs63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382674; c=relaxed/simple;
	bh=SFYF8/r/i06nkK3/m1NYik/yK1v1qRVIA7kXQjfjO/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy4A1vWHZn3zHvq59jVvazUYT7t4Hf4YGaG3Olf3BPbOlm9UahUGtckA0uqmtGNQRQTxC2efzpbsZh+xBpDeHmuEumNsZRRFkDG8LpcaVqpEQM135dFCrK4JNRJnbK/cPPaoH6jwdospbFa/fPtCfYZhn6hJn1+We94pJR1hgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbH+UvdL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539973829e7so5414480e87.0;
        Tue, 08 Oct 2024 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728382670; x=1728987470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm7RsSOhPfPPwg70mqf7oHnrMTjRMeHo6UNAH6x59BU=;
        b=kbH+UvdLbEFk7SEQLyPAKWk/3w2k0UKUeL7l23+2BxoymrAUFI1RCVe1ruU1xLU8Mg
         iFZLstghLSbbimJyL6sL8qDqaOUYvdhOUdJhcQymZxbDOiVO1cYOQx2KksnsLJTCgYzB
         HmV96D2Ib//G+U+ka0yHFKkFcQjm+gFIqhJLzVtKoEqBpRfLM9tqNuXr7SkdBoU6Jisa
         7UOAw/+ICpNLbfcRHaCPbPbQrBatbyN4OhyYsYsj7AQeUTdlDiSfrdM/DJ/6H79cEe2T
         BO7x0xEW7CFp7Ss+HLUmkP/UbFHrRfPIAkXTUUmOmPQeqDQlyvSJyyxQFRE4K+2879ni
         /vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728382670; x=1728987470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm7RsSOhPfPPwg70mqf7oHnrMTjRMeHo6UNAH6x59BU=;
        b=l7il8s12Z4JJeAIhif2mRRjSQpoVGFG0ZbMUpLRdEBKr5oyqKM44YiO7G2EwCpsPRZ
         3yo95njbFQK21J0KQkRTOy7jLIhMvp7qVWzmz+L44SrqQD1Xs7/7vON5V87czXnid3jk
         p8CmkwTij4utscOW6qb+aUe7VRPkM5ugCu/ybmUb6vQo20GnvM7UPIVN32RGnPen6aIE
         wktSRgBecrb8H21pJIS4qONlQJwdWNevAtjPgsCsHf4nvVBJzKtNbUvA159oRSzsZQNf
         XAmU3oVITlfDo5nGSnlFlBwYEvJY4ur7Bh627dsSYiAKZpylUMNBJVU7JwvGQTJlwf2h
         TdWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6UFH6HgXW4Q2masBVQit1vsTgs2mFJfoySEVLyIodVH9Un1hyrkHzhsV5a2yEVyQkvSg=@vger.kernel.org, AJvYcCWLmzPp4IDHy95Qqc/SF9uAjaqH0iGeszWUrexTOwkMn7qJyXbPk5Blo6wEgJgi5S09dgpjJj9g2xUEPJ/4@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFFowcukXMB/RDXGoEXdJ7M3euDgXJMRA2maESDOmnv5FGV68
	baNrO0gahSjpTJ547mBXzqomRiIbbmKZGaWfZ9yGCIo1wsj4XtJqEOueWOFtz4TEfH4bZDdOXxz
	8lZHX2XMWhWna8tsoLiOtpACjP/c=
X-Google-Smtp-Source: AGHT+IG9ul/fVGV3oF7muBBRZwCiXz8jJbGeHfwS4n+Cr+pqbGbkFWeiWoHTUm6aRcIwL3VIwsS52xrFtC7i+c+jZ9Q=
X-Received: by 2002:a05:6512:138e:b0:539:9505:7e5 with SMTP id
 2adb3069b0e04-539ab87e201mr7007245e87.36.1728382669868; Tue, 08 Oct 2024
 03:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007103426.128923-1-puranjay@kernel.org> <20241007103426.128923-2-puranjay@kernel.org>
 <CAEf4BzZMiwcMY3H9=qwpgCKQxDZmKHcmxEJtRhrTCgNar8YaXQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZMiwcMY3H9=qwpgCKQxDZmKHcmxEJtRhrTCgNar8YaXQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 8 Oct 2024 12:17:37 +0200
Message-ID: <CANk7y0iz9SWLXFMbdhOp+1JBqaB6Qhyt6rKonQyE4vGLy=7hYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: implement bpf_send_signal_task() kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 6:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 7, 2024 at 3:34=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > Implement bpf_send_signal_task kfunc that is similar to
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
> >  kernel/bpf/helpers.c     |  1 +
> >  kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++------
> >  2 files changed, 47 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 4053f279ed4cc..2fd3feefb9d94 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3035,6 +3035,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUI=
RE | KF_RCU | KF_RET_NULL)
> >  #endif
> >  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_throw)
> > +BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> >  BTF_KFUNCS_END(generic_btf_ids)
> >
> >  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a582cd25ca876..ae8c9fa8b04d1 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -802,6 +802,8 @@ struct send_signal_irq_work {
> >         struct task_struct *task;
> >         u32 sig;
> >         enum pid_type type;
> > +       bool has_siginfo;
> > +       kernel_siginfo_t info;
>
> group_send_sig_info() refers to this as `struct kernel_siginfo`, let's
> use that and avoid unnecessary typedefs
>
> >  };
> >
> >  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
> > @@ -811,25 +813,43 @@ static void do_bpf_send_signal(struct irq_work *e=
ntry)
> >         struct send_signal_irq_work *work;
> >
> >         work =3D container_of(entry, struct send_signal_irq_work, irq_w=
ork);
> > -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work-=
>type);
> > +       if (work->has_siginfo)
> > +               group_send_sig_info(work->sig, &work->info, work->task,=
 work->type);
> > +       else
> > +               group_send_sig_info(work->sig, SEND_SIG_PRIV, work->tas=
k, work->type);
>
> There is lots of duplication while the only difference is between
> providing SEND_SIG_PRIV and our own &work->info. So maybe let's just
> have something like
>
> struct kernel_siginfo *siginfo;
>
> siginfo =3D work->has_siginfo ? &work->info : SEND_SIG_PRIV;
> group_send_sig_info(work->sig, siginfo, work->task, work->type);
>
> ?
>
> >         put_task_struct(work->task);
> >  }
> >
> > -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> > +static int bpf_send_signal_common(u32 sig, enum pid_type type, struct =
task_struct *tsk, u64 value)
>
> task? why tsk?
>
> >  {
> >         struct send_signal_irq_work *work =3D NULL;
> > +       kernel_siginfo_t info;
> > +       bool has_siginfo =3D false;
> > +
> > +       if (!tsk) {
> > +               tsk =3D current;
> > +       } else {
> > +               has_siginfo =3D true;
>
> nit: I find it less confusing for cases like with has_siginfo here,
> for the variable to be explicitly assigned in both branches, instead
> of defaulting to false and then reassigned in one of the branches
>
> > +               clear_siginfo(&info);
> > +               info.si_signo =3D sig;
> > +               info.si_errno =3D 0;
> > +               info.si_code =3D SI_KERNEL;
> > +               info.si_pid =3D 0;
> > +               info.si_uid =3D 0;
> > +               info.si_value.sival_ptr =3D (void *)value;
> > +       }
>
> kernel test bot complains that this should probably be (void
> *)(unsigned long)value (which will truncate on 32-bit archtes, but oh
> well)
>
> but can you please double check that it's ok to set
> info.si_value.sival_ptr for any signal? Because si_value.sival_ptr is
> actually defined inside __sifields._rt._sigval, which clearly would
> conflict with _kill, _timer, _sigchld and other groups of signals.
>
> so I suspect we'd need to have a list of signals that are OK accepting
> this extra u64 value, and reject it otherwise (instead of silently
> corrupting data inside __sifields

I tried reading the man pages of sigqueue and it allows using all signals.

To test it, I sent SIGCHLD to a process with si_value.sival_ptr using
sigqueue() and it worked as expected.

It shouldn't affect us as we are not populating all fields of
__sifields anyway. For example if you send SIGCHLD using
this new kfunc, there is no way to set _utime and _stime or even _pid
and _uid, here only the signal number
and this u64 value is relevant.

I will make all the other suggested changes in the next version.


Thanks,
Puranjay

