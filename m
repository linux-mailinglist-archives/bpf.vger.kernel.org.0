Return-Path: <bpf+bounces-67630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E32B4658F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF91C81831
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADCF2EFD86;
	Fri,  5 Sep 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7SSYs7W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864A277035
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107923; cv=none; b=dKT6iGZkj+hXQ4AlrFuz/QM7iljAzwammvYwfQw74lsqPWpjwB+0nskj0NmvJ3R/+GpIoJlxHqaiK3pJfAyqzu/J7Ge7AKulf8oILXFiVpeKUybfOTrcQDJ7J9aRDTvd23Eaw8QSeCXVrU10Vs44iMqxCh7z4Jc4dqFNZMxBaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107923; c=relaxed/simple;
	bh=8z/iL4QYlR+pRdThNQfyIKN4Xr1dWg0Wb9TYJDgYDL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3Y8BgHtepIqSDNDwN7kMK5wz6lxahbX4PYKbFtv+TyOP/b0frkYrkwXFMuJTxKxSfdF9Bk1YADtkj2UP0sklCgWxgR6ku+wtVABrYJ+uEfRGkgX7e8KrLmaLDxHent+NyGuxagmJqy2Ge5AEK+IijnS4D8VdEVO6tIROkdNfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7SSYs7W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2518a38e7e4so68215ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107921; x=1757712721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DfAhYd3LT/pV9fOl4Kwen4gAUhsjl5rx3IXXsTpz6M=;
        b=U7SSYs7Wjad+z/nXjaoATubqnR/I70N2C2ohxBwjJ/naidWMZBbKoIAxhj67DMcHBt
         GMhRq32HsY76nB65J/Bf8ee536LwFc41g3OkfBPYxc9qvbWYbEoSqgkT1UoEGrQ+7iGt
         +lvuWoKXfeT1oIfavKUpX5RkvUjwgoQcSypufNYR8OuaaVX0Xl3kCtS5t6vCtfZ2OT8y
         /zxXI/1k2TaYVAZ3Ooo2ozo5hrGjdWshOLB8Ulo1oY7bNuU5uIW7ZYquCnrHeGpSz5IT
         fHOFTPqDtGVGxG34bihHXjs06GngtEeO/ajTNU23wlsCXWwj9E2IDS7HB1QT0b1evckd
         S5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107921; x=1757712721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DfAhYd3LT/pV9fOl4Kwen4gAUhsjl5rx3IXXsTpz6M=;
        b=QxgmAMVRrZClQqMimyqdeetTyA11cdp1o2qjhR/1MD0OVj4lRoNOMdzgdgbNrCDHG2
         8pIqMnU81M7bsklhNJqcrHW7qLSl+rHhOhQle3ccEx42AO7cZOlkwlHk61fQESHrIEIS
         ibp+d2YIIxmAV1TrAY1Whq4VMrL9WQfB9JR3Q/vhJmSwlVAV1oJs5sy3ug6fHYQD++pZ
         t8tmXCFHe2MhPVoVVS7vq2qeTP73/DWQkk8G2nFEUr7+qg3Si4E7dhWxRSHsIfxX8BYT
         LH7f0Akj7sAbvAYJDdM36cm0nw4MMQnVRZeAJxvKtD7DJ9j6opVNVdPBPCX9Ny2ZXQzO
         9ROg==
X-Gm-Message-State: AOJu0YzDikTqjkQs3w2hvhf+K0V8sZY20DKFlyUlsaoTriidHWRrfVQ5
	IDxqYS4N/CQ29Od9QcfPsnkzHjJFCZ1+OsjtpV11CWzxfn2WmRwmw4PeSmC1bn247QdRit2DYWb
	TgvTtew8M9+qte1jUmXJftRZ9nOe9Ec8=
X-Gm-Gg: ASbGncupnM3cpOVSGOVV7dJWrthUj3B+Ep7sfRMKMcgTp19i/Dwu3CfdyFZoRx7Djg+
	YLz7qmSgI8z6CyI5BArMIMD2IBX6nwjYtGy0yFfvDqXwD8gf6qh5X+TFNh74cvJkH87jjo3rafa
	cyoHwR2xGD8qvzV4tg/RZtHI/eqwl0DxLrJtx6gh4fK8NiWwdI2uA7OWGVqwi0VtJFx41UbB9+p
	C9i
X-Google-Smtp-Source: AGHT+IFjPuQEFlqkzTQUA+4FoCRJhuUn3Ol3+Jgk6V85eWXHnSer4SAcWvpiUQlBJaO0B6AwcD621+6jVFyXrA2uHkk=
X-Received: by 2002:a17:902:e843:b0:246:a152:2ad9 with SMTP id
 d9443c01a7336-24cedc9542cmr66546245ad.11.1757107921020; Fri, 05 Sep 2025
 14:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:31:45 -0700
X-Gm-Features: Ac12FXxtqSUnwiYws-r6xkop28po1Mz7wG2jXBrwHpdDuTK1VaV-3T9Q3V7aPfY
Message-ID: <CAEf4BzYuAu5hgPN9MkcOzB09iEj6YxQMw9q0wpw8-QUkd-pGDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
> program schedule task_work callbacks for a target task:
>  * bpf_task_work_schedule_signal() =E2=86=92 schedules with TWA_SIGNAL
>  * bpf_task_work_schedule_resume() =E2=86=92 schedules with TWA_RESUME
>
> Each map value should embed a struct bpf_task_work, which the kernel
> side pairs with struct bpf_task_work_kern, containing a pointer to
> struct bpf_task_work_ctx, that maintains metadata relevant for the
> concrete callback scheduling.
>
> A small state machine and refcounting scheme ensures safe reuse and
> teardown:
>  STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STANDBY
>
> A FREED terminal state coordinates with map-value
> deletion (bpf_task_work_cancel_and_free()).

I'd mention that FREED state can be switched into from any point in
the above linear sequence of states and it's always handled in a
wait-free fashion. In all cases except SCHEDULED (when there might not
be any actively participating side besides the one that does FREED
handling, as we are just pending, potentially for a while, for task
work callback execution), if there is any cleanup necessary
(cancellation, putting references, etc.), actively participating side
will notice transition to FREED and ensure clean up.

>
> Scheduling itself is deferred via irq_work to keep the kfunc callable
> from NMI context.
>
> Lifetime is guarded with refcount_t + RCU Tasks Trace.
>
> Main components:
>  * struct bpf_task_work_context =E2=80=93 Metadata and state management p=
er task
> work.
>  * enum bpf_task_work_state =E2=80=93 A state machine to serialize work
>  scheduling and execution.
>  * bpf_task_work_schedule() =E2=80=93 The central helper that initiates
> scheduling.
>  * bpf_task_work_acquire_ctx() - Attempts to take ownership of the contex=
t,
>  pointed by passed struct bpf_task_work, allocates new context if none
>  exists yet.
>  * bpf_task_work_callback() =E2=80=93 Invoked when the actual task_work r=
uns.
>  * bpf_task_work_irq() =E2=80=93 An intermediate step (runs in softirq co=
ntext)
> to enqueue task work.
>  * bpf_task_work_cancel_and_free() =E2=80=93 Cleanup for deleted BPF map =
entries.
>
> Flow of successful task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING, marks context is owned by

typo: mark context as owned?

>  this task work scheduler
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.
>  4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.
>  5) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  6) BPF callback is executed
>  7) Context is cleaned up, refcounts released, context state set back to
>  STANDBY.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 317 insertions(+), 2 deletions(-)
>

I don't see any more problems, it looks good to me!

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>

> +
> +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
> +{
> +       /*
> +        * Scheduled task_work callback holds ctx ref, so if we successfu=
lly
> +        * cancelled, we put that ref on callback's behalf. If we couldn'=
t
> +        * cancel, callback is inevitably run or has already completed

typo: will inevitably run

> +        * running, and it would have taken care of its ctx ref itself.
> +        */
> +       if (task_work_cancel_match(ctx->task, task_work_match, ctx))
> +               bpf_task_work_ctx_put(ctx);
> +}
> +

[...]

> +       err =3D task_work_add(ctx->task, &ctx->work, ctx->mode);
> +       if (err) {
> +               bpf_task_work_ctx_reset(ctx);
> +               /*
> +                * try to switch back to STANDBY for another task_work re=
use, but we might have
> +                * gone to FREED already, which is fine as we already cle=
aned up after ourselves
> +                */
> +               (void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STAN=
DBY);
> +
> +               /* we don't have RCU protection, so put after switching s=
tate */

heh, I guess we do have RCU protection (that guard above), but yeah,
putting after all the manipulations with ctx makes most sense, let's
fix up the comment here

> +               bpf_task_work_ctx_put(ctx);
> +       }
> +
> +       /*
> +        * It's technically possible for just scheduled task_work callbac=
k to
> +        * complete running by now, going SCHEDULING -> RUNNING and then
> +        * dropping its ctx refcount. Instead of capturing extra ref just=
 to
> +        * protected below ctx->state access, we rely on RCU protection t=
o
> +        * perform below SCHEDULING -> SCHEDULED attempt.
> +        */
> +       state =3D cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULE=
D);
> +       if (state =3D=3D BPF_TW_FREED)
> +               bpf_task_work_cancel(ctx); /* clean up if we switched int=
o FREED state */
> +}
> +

[...]

