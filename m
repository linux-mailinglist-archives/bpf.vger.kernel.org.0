Return-Path: <bpf+bounces-40614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA298AF65
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD991C2130D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9711187347;
	Mon, 30 Sep 2024 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbJOGqWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45015E97;
	Mon, 30 Sep 2024 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732950; cv=none; b=dEV3hTJO9jwLUJ6vtIbjdPUwM2ZycJOhli4CH22yYwYFjdQAlsrYb1D0ti6vdK5EnCekCKyYf3tK8qj8jLridBEoPnb0ZtvShDjud2n+3FRHvdny7vK/RcD64WiOZfH8FLVd4XJZLFbSgcvVukCT9B2Mij8dL7WMNH9tbQsCoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732950; c=relaxed/simple;
	bh=n6p2rf3/kdt9aomaPY8/OOMh33kr6Y0Bhyx+wYtPwZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQzLWhC7u7o+d4nnIkk34DLHktvkCJaMyuS4k4FEAdeTNvchiO8Nufc2jeYrFe3FMzT6a3OVGfTrTZi7QNJkNLRhuKDtZJll6xWhKgXDGMA5i/BNGkIlstau9twTU+evN0VAgLneVcnV97sWvxDbxADYQrUtG/Vlq4eYFVSX1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbJOGqWS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so3079626a91.2;
        Mon, 30 Sep 2024 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727732948; x=1728337748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NvwH7J9RmZnAE9MhK+XghnKQt8nf7AhDP5uZDkgZ6U=;
        b=LbJOGqWSyDU+QeJomn+fPiQRnUe30GRg/kue8KOAsI9Hs4hqaZSXMn8WIt0D9A1BKD
         K73aUC2MV/AAfRH2ogS9nYVVl3SZprWzgCvNK+b3nfOCT2NimUF8uOrG0Hh9Q4UEHZU7
         h0wpnMGzZvVLwx9Wa5YZmQfPgi97GyS1555Obh8f6Gsv5lCASdsATx0GgL2z3oH6BhKp
         RC4Ly7lXT0lXHWqNyU8H2KSn27hZ77MATEsPDBLnK6F/qJ7qRvcPdQ02873Ojw+X8Ani
         SiLZ7vkwLqwaPKdpc6xhmbHPv3EW6XM82de58SartvwOzq3zQi0rxRwgDfshWm8qLeO1
         wgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732948; x=1728337748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NvwH7J9RmZnAE9MhK+XghnKQt8nf7AhDP5uZDkgZ6U=;
        b=E/nko0NJnZRG67dLwcxzbOKGxd9pqv+MHZdzYnFozdFrrEHbFtjprCImuBZVfPsgsR
         6jVlEBWT+CBnW4AyBsukDd0yOZ7tFlktNXbTXkJZagM9worZj8ExhqDb6ZrhFVwruO9d
         oBeVzb5MrcfxhD/jG4qLPHFuLy8Z3/AOrzX5WBHYx4rxQgOkL+QQBQSO5vy7n6gb1ZDT
         PgJEQ4vO8iOzz31chrwIybVOaPLTMDnrceAGWc/VPkuFKgifIy51n2J6S0n6MxEi5Yiq
         C3KIdlgTm6MwBRMNFZeq8CecLLcid6HPzuZpct4/Au0K2d5EK8kEh5zT8l6yq6+kNVW4
         jCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiOI8ALNGpH0CthcWtTQOkP153HLiml0sgUW0smIkN3JM59r8Xw2XIHlPe93koWCWug4SPcoX+/8iCEjSi@vger.kernel.org, AJvYcCWGoGD5EMsDCO0Vw/qELx27lsMPJooJHuaevA7h/rsURezVeMJnNzjIBEjB6JS9atYyGzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMR1yCbmqEgqcQtg+bCVkB/JmxTTAYd10E+zxlasSPkf2UZ4x
	tV0Mk06dwLdLE0xIlEtg43m8lNiUgevt49xHSLPLh+12D+alODqdTfASC3td+QGa3Ugtth/8Ztg
	gLA+vF9HXUNrHRPPZdGpL+byfmH50fg==
X-Google-Smtp-Source: AGHT+IH9fqFiMjAM8mUwUhqCnAz+/lSkMBgzdYjLn17UBNdu5OsLTqlkVy2Vy0yAdFfBIsltYnUWlBb9n5Bf3T2/H9w=
X-Received: by 2002:a17:90a:8a8c:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e0b8872f4fmr16921981a91.1.1727732948235; Mon, 30 Sep 2024
 14:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926115328.105634-1-puranjay@kernel.org> <20240926115328.105634-2-puranjay@kernel.org>
In-Reply-To: <20240926115328.105634-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:48:55 -0700
Message-ID: <CAEf4BzaUq9WqKL1n8uHJQw3hbEFHYS4c3RN7qPWzbtYHzREThw@mail.gmail.com>
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

On Thu, Sep 26, 2024 at 4:53=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Implement bpf_send_signal_remote kfunc that is similar to
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
>  kernel/trace/bpf_trace.c | 78 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a582cd25ca876..51b27db1321fc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -802,6 +802,9 @@ struct send_signal_irq_work {
>         struct task_struct *task;
>         u32 sig;
>         enum pid_type type;
> +       bool is_siginfo;
> +       kernel_siginfo_t info;
> +       int value;
>  };
>
>  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
> @@ -811,7 +814,11 @@ static void do_bpf_send_signal(struct irq_work *entr=
y)
>         struct send_signal_irq_work *work;
>
>         work =3D container_of(entry, struct send_signal_irq_work, irq_wor=
k);
> -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->t=
ype);
> +       if (work->is_siginfo)
> +               group_send_sig_info(work->sig, &work->info, work->task, w=
ork->type);
> +       else
> +               group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task,=
 work->type);
> +
>         put_task_struct(work->task);
>  }
>
> @@ -848,6 +855,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_t=
ype type)
>                  * irq works get executed.
>                  */
>                 work->task =3D get_task_struct(current);
> +               work->is_siginfo =3D false;
>                 work->sig =3D sig;
>                 work->type =3D type;
>                 irq_work_queue(&work->irq_work);
> @@ -3484,3 +3492,71 @@ static int __init bpf_kprobe_multi_kfuncs_init(voi=
d)
>  }
>
>  late_initcall(bpf_kprobe_multi_kfuncs_init);
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_send_signal_remote(struct task_struct *task, int sig=
, enum pid_type type,
> +                                      int value)
> +{
> +       struct send_signal_irq_work *work =3D NULL;
> +       kernel_siginfo_t info;
> +
> +       if (type !=3D PIDTYPE_PID && type !=3D PIDTYPE_TGID)
> +               return -EINVAL;
> +       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
> +               return -EPERM;
> +       if (unlikely(!nmi_uaccess_okay()))
> +               return -EPERM;
> +       /* Task should not be pid=3D1 to avoid kernel panic. */
> +       if (unlikely(is_global_init(task)))
> +               return -EPERM;
> +
> +       clear_siginfo(&info);
> +       info.si_signo =3D sig;
> +       info.si_errno =3D 0;
> +       info.si_code =3D SI_KERNEL;
> +       info.si_pid =3D 0;
> +       info.si_uid =3D 0;
> +       info.si_value.sival_int =3D value;

It seems like it could be either int sival_int or `void *sival_ptr`,
i.e., it's actually a 64-bit value on 64-bit architectures.

Can we allow passing a full u64 here and assign it to sival_ptr (with a cas=
t)?

> +
> +       if (irqs_disabled()) {
> +               /* Do an early check on signal validity. Otherwise,
> +                * the error is lost in deferred irq_work.
> +                */
> +               if (unlikely(!valid_signal(sig)))
> +                       return -EINVAL;
> +
> +               work =3D this_cpu_ptr(&send_signal_work);
> +               if (irq_work_is_busy(&work->irq_work))
> +                       return -EBUSY;
> +
> +               work->task =3D get_task_struct(task);
> +               work->is_siginfo =3D true;
> +               work->info =3D info;
> +               work->sig =3D sig;
> +               work->type =3D type;
> +               work->value =3D value;
> +               irq_work_queue(&work->irq_work);
> +               return 0;
> +       }
> +
> +       return group_send_sig_info(sig, &info, task, type);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(send_signal_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_send_signal_remote, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(send_signal_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_send_signal_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &send_signal_kfunc_ids,
> +};
> +
> +static int __init bpf_send_signal_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_send=
_signal_kfunc_set);

let's allow it for other program types (at least kprobes, tracepoints,
raw_tp, etc, etc)? Is there any problem just allowing it for any
program type?


> +}
> +
> +late_initcall(bpf_send_signal_kfuncs_init);
> --
> 2.40.1
>

