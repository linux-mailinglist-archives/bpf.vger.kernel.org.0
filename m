Return-Path: <bpf+bounces-41186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD4993DE9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 06:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4691C24268
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 04:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563278685;
	Tue,  8 Oct 2024 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc6V1unm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424C3C0C;
	Tue,  8 Oct 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361483; cv=none; b=IjZWIxHSFhi2gguzdSY0ZwtRCuXtTTq4xcVv7czD1KLHqd3xor04AzXE3HY5K1ymskvaTcKMlRtkV5NvKP15qPLzRYr1f67q/+7egOpAK2eTlqgm1uEzi0SNl6HwAxHAR+KQjbaRb2CBTmtZ6/SiE8NQLQ+VJEdHnXqJJPMZioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361483; c=relaxed/simple;
	bh=so/nl/Kem0klmMnenAiz3hVrhvNngCaBJdBqzHmRpYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uexkXlNcILK3ZfPLmoJ4YVxpSsE3OZv/BBvNV09eL6EfEusRQMRLhm2C2046AsqROOnaGEF1HKeSiCMTwSMwRFnJ+GvgyjRpYOB7m2gLnUyx98JBBHa43a1P+0YfxTPIrnlAuSvs0db5R8Sg6u7V69izId+reyWDwozWjTQG15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc6V1unm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b833f9b35so44220825ad.2;
        Mon, 07 Oct 2024 21:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728361481; x=1728966281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWti4zorau3ReA1q4GOxR8ruEn2HPXjYThgm7CozDvs=;
        b=Qc6V1unmTd/5GEsOn3YFbpvxIOEzwZH9e1Kweya5kh1osLb0LV3iPWcgSKjIouoZBD
         QaZ/3AGzxM5PESxc9L+/rKfF9o+h4XfdEQcezebvRz3aTQ7Uj4/l68U5RQMcMDsHfHqc
         7WwsLlXhtScPm17/Fq2LtA2phErlMFYpueDHnSuP60Z6P/drqhWVL8yLylS25Fvf1vJn
         0UWm0hMpL4wmGotApzz0BIKEsKUxXYY3bNFNSrYFNK6DDyeMrmnszYtizdUV2Ezf43xa
         r/+fONuAWuK30zY1Oba7tLitlLOT617AauSCp/+hyyEoOIkyDHGbd8/27zjEUhsd0hFH
         NgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361481; x=1728966281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWti4zorau3ReA1q4GOxR8ruEn2HPXjYThgm7CozDvs=;
        b=bu7egNXrL1L+7ccZhE2B/o9N0+6JdjlYXjbBaTFJUbtr28hSymTVA9obBK47Gcp/rz
         sw+gjYH2uCUxc8VlVNMxCUtCwtGLhG1DPP4WxAOyOKnUh6hyi8zpc9QOMrInhP7X8nyr
         cGXm/n1aFDFFon/FNxpMTXtTdXPeTQ83hUmOud1WfNNLCLIeKOU9j4j7UFEQuNwqRsut
         iKwPGQUfQXpdoNk0T+CYwbXFVeZx6f3KTdNvGDprFyg7fVjMUhMzpSZDUr1Jwy3tLRR1
         0ll3W6wyRhzeQNq5NfX4PKdOv1UrSV6TlxjjLrazenkEgcTihs4THL52+UxFqUGtn/VL
         dvcg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKZ5QyhEjcERm7an+Yf7HCZC1Kq+X0jOHB068Hz9/0SvjUAoW6Nj8Gu5db6qxOeHY5K8=@vger.kernel.org, AJvYcCWi3SfkHnI1imfS8Fa+I2RIIyYGDcyIqFBlYgX40M5EA1T/9ordmgqYpXvU3YpCcD/P88mOnarH0bAcDVME@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2s1teekZPga8AFiorUaDJ9kkTmOPP1jxMpwA+ZAe60AE0NHXP
	BUcNvCSQGqODphXWV0uBoeVN02chM0ljWvnjHz4tojwuwsJR3UAJJVWO7VMC83YsmqRjnu7buCC
	dW34PSLEr9yn1qRJk1w0LuPjfLqI=
X-Google-Smtp-Source: AGHT+IFD7tOvjZYwVALv2jrofqDMU2Fc6pBOTv+b2ZRDyK0ZMEmGIMfId0LN/bdf+6cJfdcVuaDLlezLdRAtv7kDqxk=
X-Received: by 2002:a17:903:234f:b0:20c:3d9e:5f2b with SMTP id
 d9443c01a7336-20c3d9e60acmr59879205ad.57.1728361480758; Mon, 07 Oct 2024
 21:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007103426.128923-1-puranjay@kernel.org> <20241007103426.128923-2-puranjay@kernel.org>
In-Reply-To: <20241007103426.128923-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 21:24:28 -0700
Message-ID: <CAEf4BzZMiwcMY3H9=qwpgCKQxDZmKHcmxEJtRhrTCgNar8YaXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: implement bpf_send_signal_task() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:34=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
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
>  kernel/trace/bpf_trace.c | 54 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 47 insertions(+), 8 deletions(-)
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
> index a582cd25ca876..ae8c9fa8b04d1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -802,6 +802,8 @@ struct send_signal_irq_work {
>         struct task_struct *task;
>         u32 sig;
>         enum pid_type type;
> +       bool has_siginfo;
> +       kernel_siginfo_t info;

group_send_sig_info() refers to this as `struct kernel_siginfo`, let's
use that and avoid unnecessary typedefs

>  };
>
>  static DEFINE_PER_CPU(struct send_signal_irq_work, send_signal_work);
> @@ -811,25 +813,43 @@ static void do_bpf_send_signal(struct irq_work *ent=
ry)
>         struct send_signal_irq_work *work;
>
>         work =3D container_of(entry, struct send_signal_irq_work, irq_wor=
k);
> -       group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->t=
ype);
> +       if (work->has_siginfo)
> +               group_send_sig_info(work->sig, &work->info, work->task, w=
ork->type);
> +       else
> +               group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task,=
 work->type);

There is lots of duplication while the only difference is between
providing SEND_SIG_PRIV and our own &work->info. So maybe let's just
have something like

struct kernel_siginfo *siginfo;

siginfo =3D work->has_siginfo ? &work->info : SEND_SIG_PRIV;
group_send_sig_info(work->sig, siginfo, work->task, work->type);

?

>         put_task_struct(work->task);
>  }
>
> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> +static int bpf_send_signal_common(u32 sig, enum pid_type type, struct ta=
sk_struct *tsk, u64 value)

task? why tsk?

>  {
>         struct send_signal_irq_work *work =3D NULL;
> +       kernel_siginfo_t info;
> +       bool has_siginfo =3D false;
> +
> +       if (!tsk) {
> +               tsk =3D current;
> +       } else {
> +               has_siginfo =3D true;

nit: I find it less confusing for cases like with has_siginfo here,
for the variable to be explicitly assigned in both branches, instead
of defaulting to false and then reassigned in one of the branches

> +               clear_siginfo(&info);
> +               info.si_signo =3D sig;
> +               info.si_errno =3D 0;
> +               info.si_code =3D SI_KERNEL;
> +               info.si_pid =3D 0;
> +               info.si_uid =3D 0;
> +               info.si_value.sival_ptr =3D (void *)value;
> +       }

kernel test bot complains that this should probably be (void
*)(unsigned long)value (which will truncate on 32-bit archtes, but oh
well)

but can you please double check that it's ok to set
info.si_value.sival_ptr for any signal? Because si_value.sival_ptr is
actually defined inside __sifields._rt._sigval, which clearly would
conflict with _kill, _timer, _sigchld and other groups of signals.

so I suspect we'd need to have a list of signals that are OK accepting
this extra u64 value, and reject it otherwise (instead of silently
corrupting data inside __sifields

pw-bot: cr

>
>         /* Similar to bpf_probe_write_user, task needs to be
>          * in a sound condition and kernel memory access be
>          * permitted in order to send signal to the current
>          * task.
>          */
> -       if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
> +       if (unlikely(tsk->flags & (PF_KTHREAD | PF_EXITING)))
>                 return -EPERM;
>         if (unlikely(!nmi_uaccess_okay()))
>                 return -EPERM;
>         /* Task should not be pid=3D1 to avoid kernel panic. */
> -       if (unlikely(is_global_init(current)))
> +       if (unlikely(is_global_init(tsk)))
>                 return -EPERM;
>
>         if (irqs_disabled()) {
> @@ -847,19 +867,24 @@ static int bpf_send_signal_common(u32 sig, enum pid=
_type type)
>                  * to the irq_work. The current task may change when queu=
ed
>                  * irq works get executed.
>                  */
> -               work->task =3D get_task_struct(current);
> +               work->task =3D get_task_struct(tsk);
> +               work->has_siginfo =3D has_siginfo;
> +               work->info =3D info;

if you are using clear_siginfo(), you probably should use copy_siginfo() he=
re?

>                 work->sig =3D sig;
>                 work->type =3D type;
>                 irq_work_queue(&work->irq_work);
>                 return 0;
>         }
>
> -       return group_send_sig_info(sig, SEND_SIG_PRIV, current, type);
> +       if (has_siginfo)
> +               return group_send_sig_info(sig, &info, tsk, type);
> +
> +       return group_send_sig_info(sig, SEND_SIG_PRIV, tsk, type);

Similarly to what I mentioned at the very top, the only difference is
a pointer to struct kernel_siginfo, so make it explicit?

struct kernel_siginfo *siginfo;

siginfo =3D task =3D=3D current ? SEND_SIG_PRIV : &info;

?

>  }
>
>  BPF_CALL_1(bpf_send_signal, u32, sig)
>  {
> -       return bpf_send_signal_common(sig, PIDTYPE_TGID);
> +       return bpf_send_signal_common(sig, PIDTYPE_TGID, NULL, 0);
>  }
>
>  static const struct bpf_func_proto bpf_send_signal_proto =3D {
> @@ -871,7 +896,7 @@ static const struct bpf_func_proto bpf_send_signal_pr=
oto =3D {
>
>  BPF_CALL_1(bpf_send_signal_thread, u32, sig)
>  {
> -       return bpf_send_signal_common(sig, PIDTYPE_PID);
> +       return bpf_send_signal_common(sig, PIDTYPE_PID, NULL, 0);
>  }
>
>  static const struct bpf_func_proto bpf_send_signal_thread_proto =3D {
> @@ -3484,3 +3509,16 @@ static int __init bpf_kprobe_multi_kfuncs_init(voi=
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

