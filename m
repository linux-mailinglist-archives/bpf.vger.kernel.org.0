Return-Path: <bpf+bounces-52479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79AA432B3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15B17A90CE
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9E80BFF;
	Tue, 25 Feb 2025 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZziCC+8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A094450FE
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448599; cv=none; b=qwVVDfb0oYx07blRFVQIQVJxEmp6v/6QFkakrS5/5dX2UxPZnNDrphniPcXQC/2Kn5ad3zJi0sv9fe5TAEE6fYycv2YWf/Oby4l+PjwdgFKRCotOjMhv4hpIZHDVpHyMbqUpo7zR+JWikpL69pIZ6aoDPsapVu/L3sPG36z4M1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448599; c=relaxed/simple;
	bh=j+6aTMl2rNUjG/vgGurN8eRqCNBphB+pjXyAUFD9oy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nioGvZpASCaJfE+gfF/7l0RJo4cwz5cHwUfHLe8OlqPWn2Fz/yS9fXnFFF1xj+qAgsr4rpPD8DQBprwxuPS9zFWgwjMkWZo6RE8HF4e7qt9novKGMZwlgalYcboxKVqrroX+jPoRi2a/hpScVQu1FnRJGR9KDJLmicyU3lPTQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZziCC+8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f5fc33602so2838712f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740448596; x=1741053396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trWE/oOnA5Co0JUBGiH/9efp3t7/0zNk4bvEJQafcGA=;
        b=nZziCC+8O/Mvok/xvUzlPQRH3+jc4NvndBjEtEmKrR+NyzVn9voXZb76a02v3jV1Gs
         3MJ/jT9l2ylNfwTbTedFVRZlIju9/RGdj5Q7k78HPqurMuQcRLzmPNk34I1wF1DYBob/
         JzWwt84ZFW1Qdb7xfv4k0I4p/UlFvD1MAfmW8O432fDFnnL1vQH06ee+rv5nwiOpvkz2
         +QNcGznrKQSi1UF463uen615k7hbuuqz7D87vdB4+rdB0S5NzG/yfxAVyu72dHyH17yr
         ChFkICm71lmUdCYNwadPFLzEXYW63F8XS07KirvtpKhJgp5eZ8HM306FbpbtQQYmec1k
         cMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448596; x=1741053396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trWE/oOnA5Co0JUBGiH/9efp3t7/0zNk4bvEJQafcGA=;
        b=KvoJlMfDgH919KwKHqV0WI8Htw3l/qfr1sQ5bVIs9JrsR/wJjQv0ZUGtnk9zdN3Cnr
         y3j4KIjvLckhFYtOsWH7KRpKY2CDqDohY8LH+whJF8cYMhTfyvAQoWRimSjRJtceXeNQ
         EwooHDvJJStzg0m73sEFZI+fJlOUqy8FgeP2gyoaDDhSUMtYnEtpBrti1hiTRuT7VvQL
         +aD4ifF4WlcUUpv3hMiIa1SRP48FZmfL/dL9PjzF9UirDJyUdRxY6A9ZhUWdVNr0YCIW
         fdDd4GkwT6aIvfsbKUWUbnfKc1FvQfTYkAewj3Kuh65FGYoCxIf+tpng+enzVCvN2+ed
         LoBw==
X-Gm-Message-State: AOJu0YyhghU3fCcgHQiSM/Z8ZbaTuEr7PKTmDerACVHOUviboMLZGy2d
	7Mv1JWDbHip9MjNTXFza+Q4BJNxdaldiQsf8alzcTLYg+pnvDMO51ztn/VGurQQs/HrQtzMfXIH
	jvPN4JLXEi9IcYuju0RE0DhcuSa4=
X-Gm-Gg: ASbGncvQOvMRhIC4pxchFhn78poLXUJVrRMFjb7hVZYGYxtW2JIhE01G0ToQxG8DSWl
	J3DOnKlq3JG8y73MQYtTeQ80/wudqtr3R9EYlGXsMEAdkpqhU9BECEFfBIl/PNcBO7dAQONnNwH
	D17506BTe4UAHvIhrSvMGjlPU=
X-Google-Smtp-Source: AGHT+IFc/2qKc1UWdHnqRH9XLaKsmsJZ/UbhIV6MfvW8+G0y1wahHA0wgvwy868PJlbbhWvW0Cciyxhjg+sI+wnohrA=
X-Received: by 2002:a5d:64a7:0:b0:38b:f4e6:21aa with SMTP id
 ffacd0b85a97d-38f6f3c50b0mr9415081f8f.5.1740448596145; Mon, 24 Feb 2025
 17:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224221637.4780-1-alexei.starovoitov@gmail.com> <CAEf4BzZ1GHkBBu73aeyBRQ3MZ9Lp0ar7FKBrk5F-fAOJXxDhEg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1GHkBBu73aeyBRQ3MZ9Lp0ar7FKBrk5F-fAOJXxDhEg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Feb 2025 17:56:25 -0800
X-Gm-Features: AQ5f1Jo8EdAhNGmSZDtu6rAUGiKmlSJRxOHtVLfG4I5YN3I1ckIPSI0CGEqq3cg
Message-ID: <CAADnVQ+zsg5BXJyUtVCcon2-t_RLxez_D42+-ZRGwOzd0TQWBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 2:16=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Fix the following deadlock:
> > CPU A
> > _free_event()
> >   perf_kprobe_destroy()
> >     mutex_lock(&event_mutex)
> >       perf_trace_event_unreg()
> >         synchronize_rcu_tasks_trace()
> >
> > There are several paths where _free_event() grabs event_mutex
> > and calls sync_rcu_tasks_trace. Above is one such case.
> >
> > CPU B
> > bpf_prog_test_run_syscall()
> >   rcu_read_lock_trace()
> >     bpf_prog_run_pin_on_cpu()
> >       bpf_prog_load()
> >         bpf_tracing_func_proto()
> >           trace_set_clr_event()
> >             mutex_lock(&event_mutex)
> >
> > Delegate trace_set_clr_event() to workqueue to avoid
> > such lock dependency.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
>
> There is a tiny chance that bpf_printk() might not produce data (for a
> little bit) if the time between program verification and its
> triggering right after that is shorter than workqueue delay, right?

yeah, but also see the comment in __set_printk_clr_event().
Unfortunately users can enable/disable this event at any time
just like other ftrace events.
The trace_bpf_trace_printk is fragile and racy.
In addition, trace_pipe can be configured in weird ways.
cat /sys/kernel/tracing/trace_pipe
will look nothing like normal.
All existing footgun warnings apply.

With Kumar we started discussing a new debug/printk mechanism.
So that arena faults, res_spin_lock timeous can be printed there
and consumed per program instead of global trace_pipe.

> It's probably negligible in practice, so lgtm
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a612f6f182e5..13bef2462e94 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -392,7 +392,7 @@ static const struct bpf_func_proto bpf_trace_printk=
_proto =3D {
> >         .arg2_type      =3D ARG_CONST_SIZE,
> >  };
> >
> > -static void __set_printk_clr_event(void)
> > +static void __set_printk_clr_event(struct work_struct *work)
> >  {
> >         /*
> >          * This program might be calling bpf_trace_printk,
> > @@ -405,10 +405,11 @@ static void __set_printk_clr_event(void)
> >         if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
> >                 pr_warn_ratelimited("could not enable bpf_trace_printk =
events");
> >  }
> > +static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
> >
> >  const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
> >  {
> > -       __set_printk_clr_event();
> > +       schedule_work(&set_printk_work);
> >         return &bpf_trace_printk_proto;
> >  }
> >
> > @@ -451,7 +452,7 @@ static const struct bpf_func_proto bpf_trace_vprint=
k_proto =3D {
> >
> >  const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
> >  {
> > -       __set_printk_clr_event();
> > +       schedule_work(&set_printk_work);
> >         return &bpf_trace_vprintk_proto;
> >  }
> >
> > --
> > 2.43.5
> >

