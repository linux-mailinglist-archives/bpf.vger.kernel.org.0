Return-Path: <bpf+bounces-41277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC0995654
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AF428315B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3851FA25F;
	Tue,  8 Oct 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNaB+YXr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A320B20;
	Tue,  8 Oct 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411598; cv=none; b=W4Slg5HUnfjgmv4DnehlMuDLlF8rm9I0JL+9YwohOEAnJIxFHfn91+xm+TG9JdlhXfB09sWbcAgumuvG6MZa9NJZUTNwxNmZloWt8x2eX8QO9XfNVzzMp8fFoKs8ng04wvV4Svb2NuXHv484XlGCC4Lr5zl5pxS5Lw+MbEe9r7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411598; c=relaxed/simple;
	bh=jw8bQOfoGZpBwdlUWQQfKOqlP31GoPgliV1EFOf+BUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9WbQfKXlN8DujD1Q1qz6XV/5bOIo/rYUPWGHbPnN1R91ZwSsdzGZjZBZRlFkijsAtILbEz4+O6AB/ZxeoFoMAZ3i4y8XYd+5hhPvlZBDWU+1mdQnry4d59ZU9U7LS9eOh8xb+NpcjvEJyCBWU94Ab07In/CaGzXZAALYxp3oZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNaB+YXr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso70421a91.0;
        Tue, 08 Oct 2024 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728411596; x=1729016396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jq0IjXbTTC7OHJEi6pwvNWOSOrUSVV9JLcoc5kGj5I=;
        b=lNaB+YXrVVOtb8yi3XJpWfffUFudPrlkB2+frpqwVrL18C3nTIJj380vadmPPbo+kU
         jOfvcdtadNnhQ0ZLYKpbQOVa3qjpRN5f1brsGr4OLLIJXbRsNiWvgUUNNUE4ljLIckCq
         aEewmSQxXU9v0EU6mcsrhGEY+v0CUHDHD5F/dimdI+xQaznTq4mU/SLIW28P25w2Y4SF
         6GhA2AJROLzjmEq/FHCPSFhqdi/ky6TITJMEF6M0GaFfXaqXFHIMp9xras0CQgHsD5xN
         FoJknunTaZIbmQVjnNEnwDZxQFCN/WGi3uZ4IyDEXGIIUS7OvgaYusUIw+U1Hx7qweiZ
         B2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411596; x=1729016396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jq0IjXbTTC7OHJEi6pwvNWOSOrUSVV9JLcoc5kGj5I=;
        b=tvNqhadWvYBUG0TvAop9+S5lmxbqqCyEGd69ZSqPdGA3RIKSIAOmS+Gh0omn8e9lM9
         234mWI2kvCRlflqnc+jrE9Ru3AkTTXG80OfmFOqwJPlsSZUrdotKvLxntIDhZIL/Dhfj
         uC6sgnSdyyliSj6LjFQUSCURC7MiC6kAzFoqRgZrMRU+ln/p/xPNxBemfKqTDh9BM0Xq
         29Rn/G/NTxew6GElntukIgCHGmgzHqZhit3IwFZU97BAOcT/8WFzhucbLQupti+gDEOo
         S/qw8Nm7IvVug2f44Sq/hFcZMbq9d/ejyZ1P2Bt4UZopbZesrPSwhA8nadT13iJwxJHR
         Rq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlFOsm11TdhB4aPYMqUP5mqRTA0jR4qWgXmrplDYLOSBGx05+K4eIuwjVF2d7fjlIQdsM=@vger.kernel.org, AJvYcCUtVRyTQUo6y7PRqR1PKnzifF9NwPHGiZ6FQLP6gb5OK3/GQSXHN0fmWpCgQVy+lTRlcSr+z6GzkT5Q1qMZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqt/VzA0YOlq6G+I8gsUZrLBhPdNeC72lSRDANfP24pMYU0j8Y
	aJLdlIEVg58LU5wmTcVVIQ9AybEYOuP+61Xgyabr2lPb3DmO+rjnju2ZjuZ6gtMAS2autXaEgr/
	k+2v3b5OQPFgJdxPZle/We9YZaIA=
X-Google-Smtp-Source: AGHT+IH+QnkUnRF6TpH/0y2eXX0NUtZvoLCBEtEMBqfyL7ENJJStAHYoN5jc5Gy18nUVBbI5vzCJuruK8AgCd2egnvg=
X-Received: by 2002:a17:90a:6fa6:b0:2e0:8518:44fa with SMTP id
 98e67ed59e1d1-2e27ddb7035mr6157116a91.7.1728411595999; Tue, 08 Oct 2024
 11:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008114940.44305-1-puranjay@kernel.org> <20241008114940.44305-2-puranjay@kernel.org>
In-Reply-To: <20241008114940.44305-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Oct 2024 11:19:43 -0700
Message-ID: <CAEf4Bza5HCFZmMA8UcM92TXzDq8CxKpjPkQ_s2PLuc-dGR8y2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: implement bpf_send_signal_task() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Implement bpf_send_signal_task kfunc that is similar to
> bpf_send_signal_thread and bpf_send_signal helpers  but can be used to
> send signals to other threads and processes. It also supports sending a
> cookie with the signal similar to sigqueue().
>
> If the receiving process establishes a handler for the signal using the
> SA_SIGINFO flag to sigaction(), then it can obtain this cookie via the
> si_value field of the siginfo_t structure passed as the second argument
> to the handler.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/helpers.c     |  1 +
>  kernel/trace/bpf_trace.c | 52 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4053f279ed4cc..2fd3feefb9d94 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3035,6 +3035,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
>  #endif
>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_throw)
> +BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(generic_btf_ids)
>
>  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a582cd25ca876..d9662e84510d3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -802,6 +802,8 @@ struct send_signal_irq_work {
>         struct task_struct *task;
>         u32 sig;
>         enum pid_type type;
> +       bool has_siginfo;
> +       struct kernel_siginfo info;
>  };
>
>  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
> @@ -809,27 +811,46 @@ static DEFINE_PER_CPU(struct send_signal_irq_work, =
send_signal_work);
>  static void do_bpf_send_signal(struct irq_work *entry)
>  {
>         struct send_signal_irq_work *work;
> +       struct kernel_siginfo *siginfo;
>
>         work =3D container_of(entry, struct send_signal_irq_work, irq_wor=
k);
> -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->t=
ype);
> +       siginfo =3D work->has_siginfo ? &work->info : SEND_SIG_PRIV;
> +
> +       group_send_sig_info(work->sig, siginfo, work->task, work->type);
>         put_task_struct(work->task);
>  }
>
> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> +static int bpf_send_signal_common(u32 sig, enum pid_type type, struct ta=
sk_struct *task, u64 value)
>  {
>         struct send_signal_irq_work *work =3D NULL;
> +       struct kernel_siginfo info;
> +       struct kernel_siginfo *siginfo;
> +
> +       if (!task) {
> +               task =3D current;
> +               siginfo =3D SEND_SIG_PRIV;
> +       } else {
> +               clear_siginfo(&info);
> +               info.si_signo =3D sig;
> +               info.si_errno =3D 0;
> +               info.si_code =3D SI_KERNEL;
> +               info.si_pid =3D 0;
> +               info.si_uid =3D 0;
> +               info.si_value.sival_ptr =3D (void *)(unsigned long)value;
> +               siginfo =3D &info;
> +       }
>
>         /* Similar to bpf_probe_write_user, task needs to be
>          * in a sound condition and kernel memory access be
>          * permitted in order to send signal to the current
>          * task.
>          */
> -       if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
> +       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
>                 return -EPERM;
>         if (unlikely(!nmi_uaccess_okay()))
>                 return -EPERM;
>         /* Task should not be pid=3D1 to avoid kernel panic. */
> -       if (unlikely(is_global_init(current)))
> +       if (unlikely(is_global_init(task)))
>                 return -EPERM;
>
>         if (irqs_disabled()) {
> @@ -847,19 +868,21 @@ static int bpf_send_signal_common(u32 sig, enum pid=
_type type)
>                  * to the irq_work. The current task may change when queu=
ed
>                  * irq works get executed.
>                  */
> -               work->task =3D get_task_struct(current);
> +               work->task =3D get_task_struct(task);
> +               work->has_siginfo =3D siginfo =3D=3D &info;
> +               copy_siginfo(&work->info, &info);

we shouldn't copy_siginfo() if !work->has_siginfo, no?

other than that, lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                 work->sig =3D sig;
>                 work->type =3D type;
>                 irq_work_queue(&work->irq_work);
>                 return 0;
>         }
>
> -       return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
> +       return group_send_sig_info(sig, siginfo, task, type);
>  }
>
>  BPF_CALL_1(bpf_send_signal, u32, sig)
>  {
> -       return bpf_send_signal_common(sig, PIDTYPE_TGID);
> +       return bpf_send_signal_common(sig, PIDTYPE_TGID, NULL, 0);
>  }
>
>  static const struct bpf_func_proto bpf_send_signal_proto =3D {
> @@ -871,7 +894,7 @@ static const struct bpf_func_proto bpf_send_signal_pr=
oto =3D {
>
>  BPF_CALL_1(bpf_send_signal_thread, u32, sig)
>  {
> -       return bpf_send_signal_common(sig, PIDTYPE_PID);
> +       return bpf_send_signal_common(sig, PIDTYPE_PID, NULL, 0);
>  }
>
>  static const struct bpf_func_proto bpf_send_signal_thread_proto =3D {
> @@ -3484,3 +3507,16 @@ static int __init bpf_kprobe_multi_kfuncs_init(voi=
d)
>  }
>
>  late_initcall(bpf_kprobe_multi_kfuncs_init);
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, =
enum pid_type type,
> +                                    u64 value)
> +{
> +       if (type !=3D PIDTYPE_PID && type !=3D PIDTYPE_TGID)
> +               return -EINVAL;
> +
> +       return bpf_send_signal_common(sig, type, task, value);
> +}
> +
> +__bpf_kfunc_end_defs();
> --
> 2.40.1
>

