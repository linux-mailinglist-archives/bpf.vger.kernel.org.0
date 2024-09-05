Return-Path: <bpf+bounces-39070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341696E442
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853AE1F27566
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EC1A3BC8;
	Thu,  5 Sep 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlgewrX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75816BE15
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568879; cv=none; b=uXvwEY/WTP/xem+sOuf2AVBwECp9ISclNgLlnaAbZMln35eU9mTf8hmcazkCYqvmVNK+3Wxr6JxlEWf24cK9Z2jJg2ETUqeON/o3IhhVh4S/O33jdX11nlOMSN5vcM5kelucRDutZdcTIBrmVyjGoFyg5SYQMvXKSqrfDytu1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568879; c=relaxed/simple;
	bh=0V/2gKlsSw+Ddh6PElJ77SK+hLaY+UeB/vsqktmayGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtR6G07iZxit7IrZpKIILRCRl6KbOdjMwnC80REX1QrLf6gro/30YXxyKB2+/kBOrCpW0Bi7m2UUcXK4tQ7q0GZwYtIREkHtqt7R+nvkUow7mqQA7ngKVBHt4PqMvpFO3saE0ctVh6qzzwtNwtU+lBZQItQ8vYOH6FrbNKRuUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlgewrX7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so937786a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725568877; x=1726173677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efk4NkaP4qY1cgK5dpLWpprGMZagl6RT1LyivPu8OHs=;
        b=jlgewrX7fBIjIhpaCcaffx5NWha40m8WekJjbZepU6k466rGHB9PkUHLmddXbHT5ak
         1AVQ0Q0DMOdwevKGuDusndpdf2o34EQwc2UX42tlspjqUQj8AQmqpz6muVbMyExtsydE
         lgj5xgHVAbI8JsT0pA17doMaXuhVeKdgPU545Bw9AGcLv6k8jL+KOtHsmIElTcU2w4rY
         8Fumc4ybESis9hlpFtaXzkyFXfWSy3x5EcbjWtuJA8rK+66D/eYa5wYaPbm1fcU1CEyI
         6AA8HTnC+Xvk1ms9J0ERWFsSCl9MhTMzOiQaxkk1GxH+fwQ6YrRUU5IrpEBUKXPUZzQg
         4Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725568877; x=1726173677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efk4NkaP4qY1cgK5dpLWpprGMZagl6RT1LyivPu8OHs=;
        b=FEes3QkkHy6y9DjbjZY7LzTvOSTpM/7NEV3O3g0pgXz/alilkhIKfzPHKWbBblqc0J
         M5NlCo1ENohaCYEP6biScZsC8w7oLFOW6EY8GGA9I2hyZS2csgZVs0S/sgabDC6rJJL4
         O8B/odgWpTUDgu3oT34KMQkaK8OW3LJD2QK97Hie0zMKHKgg3EvpwXjOEJ+oAompcCCj
         GdS2wtakduvrmDsEE23xM7gwZ2HwY7QQ5MH1yzzZGpN8tH6FLsqiwfleql6jr1e1Lers
         es2HBC6FwnoH53vsHGFQ/ndN3vmSaTmT9TcjQOtbx+ozNTLHQlgbDfLxOM6MgPHe/Lul
         fDkg==
X-Forwarded-Encrypted: i=1; AJvYcCVkB3bvH5L1HZRVesWgmpQxqUk+EREsBTa649dMTYjlRJAe7eSgxYCqm01rgsAunNHL89s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15UByEezAh0Au4ZlGLKX//V/YNHz1WvF6cvo5lMrp55191ez+
	dy/BWYFjdwMhsc5vEIXIfZ7fZPm5uHH3U3/ooT5bId+/YrBk8uKLBiMjzicmGrXjgBlTyQ61xfo
	IlWJo5dAI0v2ai//ATn72lYJyzdk=
X-Google-Smtp-Source: AGHT+IGIUjgBiqWsEmInovLeFGquQsyMZFQ9ZOw5bpkNpVFU53emOami+rFPjIqQAsUW1DLJtDzReI9019iE2pBJbek=
X-Received: by 2002:a17:90a:7087:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2dad50f9fc1mr701938a91.37.1725568877292; Thu, 05 Sep 2024
 13:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724113944.75977-1-puranjay@kernel.org> <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
 <mb61pjzfrsgc4.fsf@kernel.org> <CAEf4BzaOxhTBf5TDZ0tstQNtdh-uf+d+ARTTX0YMnapdXucP5g@mail.gmail.com>
 <mb61ph6auscl1.fsf@kernel.org>
In-Reply-To: <mb61ph6auscl1.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:41:05 -0700
Message-ID: <CAEf4BzarSHKvUZ3X+gs9yCRQeYG+M6m2DA6=k9b6GofXn_gsdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid() helpers
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:56=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, Sep 4, 2024 at 6:23=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >>
> >> Hi,
> >> Sorry for the delay on this.
> >>
> >> > On Wed, Jul 24, 2024 at 4:40=E2=80=AFAM Puranjay Mohan <puranjay@ker=
nel.org> wrote:
> >> >>
> >> >> Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers whic=
h are
> >> >> similar to bpf_send_signal_thread and bpf_send_signal helpers
> >> >> respectively but can be used to send signals to other threads and
> >> >> processes.
> >> >
> >> > Thanks for working on this!
> >> > But it needs more homework.
> >> >
> >> >>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
> >> >>         FN(unspec, 0, ##ctx)                            \
> >> >> @@ -6006,6 +6041,8 @@ union bpf_attr {
> >> >>         FN(user_ringbuf_drain, 209, ##ctx)              \
> >> >>         FN(cgrp_storage_get, 210, ##ctx)                \
> >> >>         FN(cgrp_storage_delete, 211, ##ctx)             \
> >> >> +       FN(send_signal_pid, 212, ##ctx)         \
> >> >> +       FN(send_signal_tgid, 213, ##ctx)                \
> >> >
> >> > We stopped adding helpers long ago.
> >> > They need to be kfuncs.
> >> >
> >> >>         /* */
> >> >>
> >> >>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER t=
hat don't
> >> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> >> index cd098846e251..f1e58122600d 100644
> >> >> --- a/kernel/trace/bpf_trace.c
> >> >> +++ b/kernel/trace/bpf_trace.c
> >> >> @@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_wor=
k *entry)
> >> >>         put_task_struct(work->task);
> >> >>  }
> >> >>
> >> >> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> >> >> +static int bpf_send_signal_common(u32 sig, enum pid_type type, u32=
 pid)
> >> >>  {
> >> >>         struct send_signal_irq_work *work =3D NULL;
> >> >> +       struct task_struct *tsk;
> >> >> +
> >> >> +       if (pid) {
> >> >> +               tsk =3D find_task_by_vpid(pid);
> >> >
> >> > by vpid ?
> >> >
> >> > tracing bpf prog will have "random" current and "random" pidns.
> >> >
> >> > Should it be find_get_task vs find_task too ?
> >> >
> >> > Should kfunc take 'task' parameter instead
> >> > received from bpf_task_from_pid() ?
> >> >
> >> > two kfuncs for pid/tgid is overkill. Combine into one?
> >>
> >> So, I will add a single kfunc that can do both pid and tgid and it wil=
l
> >> take the 'task' parameter received from the call to bpf_task_from_pid(=
)
> >> and a 'bool' to select pid/tgid.
> >
> > Can you please also investigate passing an extra u64 of "context" to
> > the signal handler? It's been requested before, and at least for some
> > signals the kernel seems to support this functionality. Would be best
> > to avoid proliferation of kfuncs, if we can handle all this in one.
> >
>
> Yes, I will look into that. Are you referring to the 'void *context'
> that is passed to the handlers registered with sigaction()? like:
>
> --- 8< ---
>
> void  handle_prof_signal(int signal, siginfo_t * info, void * context)
> {
> }
>
> struct sigaction sig_action;
> struct sigaction old_action;
>
> memset(&sig_action, 0, sizeof(sig_action));
>
> sig_action.sa_sigaction =3D handle_prof_signal;
> sig_action.sa_flags =3D SA_RESTART | SA_SIGINFO;
> sigemptyset(&sig_action.sa_mask);
>
> sigaction(SIGPROF, &sig_action, &old_action);
>
> --- >8 ---
>
> And we want to the BPF program to also be able to pass a custom context
> to the signal handler like above? is there an existing mechanism to do
> that in the kernel?

There must be. I think last time I looked at this, I found this (from [0]):

       =E2=80=A2  If the signal is sent using sigqueue(3), an accompanying =
value
          (either an integer or a pointer) can be sent with the signal.
          If the receiving process establishes a handler for this signal
          using the SA_SIGINFO flag to sigaction(2), then it can obtain
          this data via the si_value field of the siginfo_t structure
          passed as the second argument to the handler.  Furthermore,
          the si_pid and si_uid fields of this structure can be used to
          obtain the PID and real user ID of the process sending the
          signal.

And there were some kernel-side parts related to that, yes. But please
take a look yourself and check if it's all sane.

  [0] https://man7.org/linux/man-pages/man7/signal.7.html


>
> Thanks,
> Puranjay

