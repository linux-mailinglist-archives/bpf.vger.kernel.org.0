Return-Path: <bpf+bounces-40510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F313989678
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FA21F22841
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F217E013;
	Sun, 29 Sep 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFBCOFXz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2E154BED;
	Sun, 29 Sep 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630053; cv=none; b=fShKySmVJMn1LEASy/jbtlB1gnj57UbID4IwlHWdG6nVY5jeiuR4hNsEho/JvCFisuVaxnLCNuf9gEtNxnk06AyB1CIkXehN7Ydh7T4WWeBiUO6f6Cqzu3+61b9aT/A7QJSIqmXVaoFkjXQv9k3+y6lTp56vLkGYbDlZ9s8GAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630053; c=relaxed/simple;
	bh=JEYG6VvrMXHx4KWb1o2iWV/PqQza+18wa1vjRIIPF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upYY2UaffALoqzgkpxvA9YQGX/OTLEzF1EkYguAoaWZH0md++gHKr4+8pkzu1hKzHJGZiwbdimhA7nUriNq1uDSFBaXNH7blZYGFdASNz80hrk6b6BaXlT6CArQP7Y1NIzw30Aaa8HRsGyqvgxkm2CG56P4LfOgHAmSuPs54hJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFBCOFXz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso1000391f8f.2;
        Sun, 29 Sep 2024 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727630049; x=1728234849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujx86CAlBOuJagVhHvFTxkQxVPjlVr6IAEtlsGZ7IPY=;
        b=dFBCOFXzvn8m1lCV2yAvrHYYQhq2Mimnvu/5WO3dUuKFE6Q+wGp8tdn3twQJfGqIMw
         rydykjF1K4ctFkkxzXgZlLN363ugr7UFluwln3rSWmtDJpuB9Y7ZdUsrPVdqmRZjBtvA
         Y1sHudoqpwvLxP67Z4m9K5QNcEB9HdvIRItcXVvorZH+podnBlyX1c6awxEkjLuptNaU
         XCfPRcDfRPTB0O5njqdRtURHynuPrq/cyAL0PZcX3P73UOTyZ4MxSbRBJbFox5RwH3Vl
         feSoLvbruxRwb36HhhqqO+po30OwRy0FoYP2wENqwkEMUMr6GMp0WytV1TRipYIaSiUe
         gQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630049; x=1728234849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujx86CAlBOuJagVhHvFTxkQxVPjlVr6IAEtlsGZ7IPY=;
        b=fbTtq68xUNdO8fyC4Q3o7rDJBzvU8dRYGb9rcQ27hHWYyjBMCzqgU2Xr35NrUfRvuG
         fon9kljpfrPIel7Q1q7cFXCPK2Dbfi4LCzs0WIXT98RqXG502nidqyEU/PLg4FZnuZUY
         wzFzRTR7zxAQVrOQeMpzxrx7UOy4O+Eg407NaBiAgxuiwY2G6NlUNP5Ulsbqt+f85VSD
         d3hOregCDpdnJsmozVZ0X4A/R4QZx6Zarzm78AcLbwJHCCxn6pxOMO7v4UkV9KmlsdS1
         BZAnGCjeE6DrpVMK6Ar4xpFew88EtPIQ3uU+Gke4BfPGYoZMn/vDMiFUEZ4kRjthk4HB
         IFsA==
X-Forwarded-Encrypted: i=1; AJvYcCXbN6RdjdZBeeDbjk/U2dSX21D0PoEM3W6bVwnW0NgnTru0Ydux12R890rOXcC+Y/JV7tsGsO3uXazWwcE4@vger.kernel.org, AJvYcCXjl/SuTVUcTzPso2H0f05DlaFK8PuUF6/dLLKGJkPNjVqy9sTDEAwlrSoR9B8WGZSsuPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cZZmZM6Bd278LxWAHMnvz44KqObauzxZo2oupd0F283WorNB
	5oi7pg77D3U4XlwnMVqbIz2gu3EejvSjR5Dk8KuZz7hGJI7uOFIeSWbHjA3TEloQijpVxX3Gh77
	J4KTGVks9uX79+yMcCn5cnmkLD50=
X-Google-Smtp-Source: AGHT+IEvRwkn2gMwVAZdKl5/Khty3QtE8LNL8UvKVRpAvWk+bJ7tNsFc8gB2qyKTkbJZwPwLUP0s7jQ8/7WXiF3NMn4=
X-Received: by 2002:a5d:4587:0:b0:37c:cea2:826f with SMTP id
 ffacd0b85a97d-37cd5a692e1mr8138299f8f.2.1727630049388; Sun, 29 Sep 2024
 10:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926115328.105634-1-puranjay@kernel.org> <20240926115328.105634-2-puranjay@kernel.org>
In-Reply-To: <20240926115328.105634-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:13:58 -0700
Message-ID: <CAADnVQJL5xpF=5hWdavOcU8gbZKwqsqMBLFySqpsr+K_3C+=vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: implement bpf_send_signal_remote() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>
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

This is very similar with bpf_send_signal_common().
Pls avoid copy paste and share the code instead.

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
> +}
> +
> +late_initcall(bpf_send_signal_kfuncs_init);

Let's avoid all this later_init proliferation.
We have way too many of them across the whole kernel.
Reuse one of the existing places and add kfunc there.
With that extra bpf_send_signal_kfunc_set and send_signal_kfunc_ids
won't be necessary.

pw-bot: cr

