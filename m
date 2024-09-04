Return-Path: <bpf+bounces-38898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBD96C29C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93031F263F7
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42081DEFCB;
	Wed,  4 Sep 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHIFZiva"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0B15E90
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464188; cv=none; b=a9XhEldeqSN2J5uVvnxI3y7It+ndl40/VET9B80KNhHJxWGzGUmWlQ4J+XwFoAaho7+6uFEj0WtgBCRjc/a1vwsqR1vmmxINKeg87hNXr4LvaxFPBc0fQyTl54F5wQfdFSUq+pOMaoQWpQY6GspeZvJpo8//b/P4+BFTCCY+Jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464188; c=relaxed/simple;
	bh=YCS2ykCG3LOcxIFIyJhuAfA0say2suQLgc/4Z4QCNYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCPGot15vtQ8s6w/R2P7Y7qPTMWFyyQU0k4jH5Q2cgRr1J36tR3M4DVgmCIiYKIJT1TL7yn1jPNKkGh6k6ZApIVzTLJhC9Gvn7Lc3IJnnIdj/V6q7wRrsAQj6tyqSFf4wEKJqmdTjmE7W0JBz525kABPqTbd+FZDeJwmYWl95qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHIFZiva; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so3404669a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464185; x=1726068985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhtKfKvNtb3Y/+7j/mr1U/WAQtZqlNHMqU0kBvO3+ts=;
        b=LHIFZivabR1Ev/EHS+7k0hyFfUCpd+MEyBKxdeBvtPKJ8Mr0RKV0RzoBLCp2xeDvKu
         aDP3Z9Evi7bIfPHz4JN6NbPdfeHeAgTx/iYl3aCBqfH2vLT6HO1CelwmaesXUEPA/laz
         Pjshum5gQ5DsfdxSYtyEqcwGpvmXVJxim3YuumRK6hcAcj7V7ir0daTB6lt4GqWdiReH
         iJciQ9Vyz+B1O6BZP/oIFgLmRm6QueJzcloenQ9lLRsKwhtYFsideGMjS/6I2vuDCsRT
         vBnl86N1PL59eS1RrbDBjyGsgpacsoMLRt2qjAPKSmD7QEkpgDL/rfoSXxOkhPitUrPD
         sn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464185; x=1726068985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhtKfKvNtb3Y/+7j/mr1U/WAQtZqlNHMqU0kBvO3+ts=;
        b=U+KHS8zJrjjas4j3TU5ufRymGj3+ZsJR/tuwauSTZLQx6qV6eSSgYGoEcSAHe+eaO3
         /V+SSILOUteLGyuGXu1Y4P40aESFlY+gKMix9bpt0A3B1wjJXeQawp4u+f5qlHlFPrdv
         +3lSjdM58cCOwolJEhR8GIoubdgCzNDCyFPSI1nxpNI0pea6BR473DtrqItX63MR29+f
         qaU1TxkprFcoY6sgiJFABQghw+PmIaQWoFYRQjANz7cVlHw4ft9J1+6dr9sYQR1PQuou
         6X/F8JyylrzkQwrX+sA6UCLwoJ+iBRfkcTRrYPZHQmZpeIH4O88oAjpqeot/Gi/HqF1O
         pYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeReTu/pqMepsyb0Lt+0oV7QfowmbxM/x6pUqCfnO67xhbWMp+edGxEEftajXpquJlBMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VwKMXtlVUVTwGCWy3g3aJagJ/KqwavDd1g1X/gdyVNnszG30
	K2o0J3az5aHFiU3W5zWT+P3XxtRE3/rTiWILQZatAwXeL7HyeZYhYyz5W40J6LvrkxOoKFY0nVO
	FiqTbvzmG5Xgjv5zF58ZOxelMiDU=
X-Google-Smtp-Source: AGHT+IFBb9W46HLZqO55IxgTXTEvMpDDcF9uuJoK32c9HVf/FFpiv2dkStQAsyAo+E/z3n6NaA7TmrGAGotqRhEH2zc=
X-Received: by 2002:a17:907:e8c:b0:a86:ae0a:a52a with SMTP id
 a640c23a62f3a-a89a3821fb1mr1226155866b.55.1725464184728; Wed, 04 Sep 2024
 08:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724113944.75977-1-puranjay@kernel.org> <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
 <mb61pjzfrsgc4.fsf@kernel.org>
In-Reply-To: <mb61pjzfrsgc4.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Sep 2024 08:36:13 -0700
Message-ID: <CAADnVQKC=etEeN5z58En6anV=PTsQQNxzXmqSh-ddNWwGodTUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid() helpers
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:23=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> Hi,
> Sorry for the delay on this.
>
> > On Wed, Jul 24, 2024 at 4:40=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers which a=
re
> >> similar to bpf_send_signal_thread and bpf_send_signal helpers
> >> respectively but can be used to send signals to other threads and
> >> processes.
> >
> > Thanks for working on this!
> > But it needs more homework.
> >
> >>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
> >>         FN(unspec, 0, ##ctx)                            \
> >> @@ -6006,6 +6041,8 @@ union bpf_attr {
> >>         FN(user_ringbuf_drain, 209, ##ctx)              \
> >>         FN(cgrp_storage_get, 210, ##ctx)                \
> >>         FN(cgrp_storage_delete, 211, ##ctx)             \
> >> +       FN(send_signal_pid, 212, ##ctx)         \
> >> +       FN(send_signal_tgid, 213, ##ctx)                \
> >
> > We stopped adding helpers long ago.
> > They need to be kfuncs.
> >
> >>         /* */
> >>
> >>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that=
 don't
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index cd098846e251..f1e58122600d 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_work *=
entry)
> >>         put_task_struct(work->task);
> >>  }
> >>
> >> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> >> +static int bpf_send_signal_common(u32 sig, enum pid_type type, u32 pi=
d)
> >>  {
> >>         struct send_signal_irq_work *work =3D NULL;
> >> +       struct task_struct *tsk;
> >> +
> >> +       if (pid) {
> >> +               tsk =3D find_task_by_vpid(pid);
> >
> > by vpid ?
> >
> > tracing bpf prog will have "random" current and "random" pidns.
> >
> > Should it be find_get_task vs find_task too ?
> >
> > Should kfunc take 'task' parameter instead
> > received from bpf_task_from_pid() ?
> >
> > two kfuncs for pid/tgid is overkill. Combine into one?
>
> So, I will add a single kfunc that can do both pid and tgid and it will
> take the 'task' parameter received from the call to bpf_task_from_pid()
> and a 'bool' to select pid/tgid.

why bool ?
enum pid_type is kernel enum that is available to bpf progs
via vmlinux.h. The prog can just pass that directly.
Do you see any safety issue that it will pass PIDTYPE_MAX ?
If so that can be an additional check inside kfunc.

