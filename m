Return-Path: <bpf+bounces-69768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528EBA10CC
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278D77B6207
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825F31A568;
	Thu, 25 Sep 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhzdCY0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB031A06A
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825576; cv=none; b=IBYd4raFMnpImO/q5PbpNv83Q3clp5bhuDmopcWx38eGI4Iim5hT2azWxaFt3aeJgLeut5yvVR/n/7JIQDsMMJ5qLLv94YWOskOLT3BeNNX9+YK5ettEbvM3xJi5ISGK1J8qPAKX0VFYsbc660qPrrDUmmIY85KqpPxysdFYof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825576; c=relaxed/simple;
	bh=i7GLpPjPBvVQWjuEK/nlyhoW5qJe/Sfaozh+wuUpN6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3OmQr6tFEfgxf79DX/WMaly/TtABrHWo5IdxyGmYbxUod4NvXu3U0XFqUrqq82xb35r6OaudwUmHp65ASXltaR0FtMXt88Ky4jMZz6WXVjtAb8d3mW2x6EmhTt6gM/uZmkSteZpJOvbUDcFrn4Gbwh4w8WVIZvZsJ/VdORj2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhzdCY0o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d2c35c459so11298075ad.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825574; x=1759430374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aOtjyDHmsqCIz7rR6q+jApNpJ0ke3+flpbgYL/MfZI=;
        b=KhzdCY0oOuERhtOJDkwLOsj6knxCdsSQrM7zubpL9RNVJ8YHu8ZukmccrvTi6RPnPT
         SLk63+P3bf42P3kx2jFQktdF/WHbJZhxv5/IuQr9IDOXv/DTomk/KykLbt7KFZz5dZm4
         qoLNF1i9iE+7ZbGFBQltSS0R0AvgvjpPYvuwwrPNGjLL72D286oXITqzeKRyCSAB8Sp3
         O26TtOxb3zkfw/Zp1pV52pQUn2eTFIg2Zm52YOmWk48iiNEbh5ueTjpXBQaJqWF+aQo3
         tBz9ZjtTXOH53GWfuuP2E3fOurLr+ZAHgscNyw1NTVYH/fIm20B971F7X1GfI5/pcaY4
         D+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825574; x=1759430374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aOtjyDHmsqCIz7rR6q+jApNpJ0ke3+flpbgYL/MfZI=;
        b=RC4nuIkc28G81Tk364pVvBcC8cyoelwj535DnIMS3MuEZMN0p/lO/Juv0HqvttyQrC
         nbvxaZizh2gyU7vA8SRZ2+JvrdtcQdUxYkGwYoHmfno5AL3Ix9rw0b+1oXZibPxW4Hrf
         ux8rF4reAunoz4BKTc6HeO9aeLcFL6wTleyj+wVAUgKCVZEuRrql2yrRqXpm2lFpizUk
         osedyEe0+obFJWlV4DdR72PNz8tfUHCm//1EQj1juWPK8qqpuBaAUXNeNeVu8mggg4dC
         CUpd1lPEQlTBU/Lwy78iVyVye+hXiGTQ7pbSqHLDKmIxELZ84OQU/vQomGdxVwaLzfac
         yTKg==
X-Forwarded-Encrypted: i=1; AJvYcCWPKR4w6CvUJRH5b81AzJtjs5dOY2IZqPfWHjDzEEDBCxJsTqv+HSHcffPqaSvOsOO5ay4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ac1AVOZygSplgbsHdvBhFTrZwW36+cQK979eLd7XdmvEEBjD
	/ApZtkUO9f0ox37kgcT2kYz9YlGpjRHXeIFB4kMPv1KhocBAGbW2kk9wAZ8uLuSjf3sMpZqw0Dv
	Sr702ep1Vv5ZSFK5yIgzZj5r2zZtODX4=
X-Gm-Gg: ASbGnctEHlLqAN2+RRaLMHZ/GBArQbZl39StFfaVeAjVZmN6z23Sb5GhHYFy8JespC3
	iPnCQTyjAh+avLeTM2fa9Kb3vPNc5yWJJNT9Xi+oUfHKwxhlBdcARI2ep/EE+/bbO2yCCaYCRzX
	5XkDRytpgBOHi1v7K8bzAtx5G7RTNtUof0Im5c1Dfb4o0h1cfMxwN1hIx9WXloQejq8gLrrgx9i
	J13bw1d+HStqtAULO9s828DTEk/Sa8U0w==
X-Google-Smtp-Source: AGHT+IERsujXswi5CQpVX+uwrI/EOY0gASLqeRQdQ8nQLXP6JNzAU+nJhK+3EmsbHE1U2CitbY4z5HqDwZmyGAehnro=
X-Received: by 2002:a17:903:fa4:b0:26e:146e:7692 with SMTP id
 d9443c01a7336-27ed49d0931mr53365205ad.17.1758825573656; Thu, 25 Sep 2025
 11:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop> <20250923142036.112290-1-paulmck@kernel.org>
In-Reply-To: <20250923142036.112290-1-paulmck@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 11:39:18 -0700
X-Gm-Features: AS18NWCKjC5vc6d6hJ8nJpmgoTLBlPcTgAy1h98sL0EUChh4svSRk8DVvw0VrRQ
Message-ID: <CAEf4Bzan+yAzKcBG8VWFWOwR6PigRAjmQB8KrcRwheZnRaTEyQ@mail.gmail.com>
Subject: Re: [PATCH 01/34] rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:22=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> This commit saves more than 500 lines of RCU code by re-implementing
> RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
> more code that does not cause problems by its presence, but that is no
> longer required.
>
> This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
> be removed on common-case architectures in a later commit.
>
> [ paulmck: Apply kernel test robot, Boqun Feng, and Zqiang feedback. ]
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/rcupdate_trace.h | 107 ++++--
>  include/linux/sched.h          |   1 +
>  kernel/rcu/srcutiny.c          |  13 +-
>  kernel/rcu/tasks.h             | 617 +--------------------------------
>  4 files changed, 104 insertions(+), 634 deletions(-)
>

makes sense to me overall, but I had a few questions below

> diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trac=
e.h
> index e6c44eb428ab63..3f46cbe6700038 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -12,28 +12,28 @@
>  #include <linux/rcupdate.h>
>  #include <linux/cleanup.h>
>
> -extern struct lockdep_map rcu_trace_lock_map;
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +extern struct srcu_struct rcu_tasks_trace_srcu_struct;
> +#endif // #ifdef CONFIG_TASKS_TRACE_RCU
>
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +#if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
>
>  static inline int rcu_read_lock_trace_held(void)
>  {
> -       return lock_is_held(&rcu_trace_lock_map);
> +       return srcu_read_lock_held(&rcu_tasks_trace_srcu_struct);
>  }
>
> -#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> +#else // #if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TR=
ACE_RCU)
>
>  static inline int rcu_read_lock_trace_held(void)
>  {
>         return 1;
>  }
>
> -#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> +#endif // #else // #if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFI=
G_TASKS_TRACE_RCU)

nit: // #else // #if... looks very unconventional

>
>  #ifdef CONFIG_TASKS_TRACE_RCU
>
> -void rcu_read_unlock_trace_special(struct task_struct *t);
> -
>  /**
>   * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical =
section
>   *
> @@ -50,12 +50,14 @@ static inline void rcu_read_lock_trace(void)
>  {
>         struct task_struct *t =3D current;
>
> -       WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting=
) + 1);
> -       barrier();
> -       if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
> -           t->trc_reader_special.b.need_mb)
> -               smp_mb(); // Pairs with update-side barriers
> -       rcu_lock_acquire(&rcu_trace_lock_map);
> +       if (t->trc_reader_nesting++) {
> +               // In case we interrupted a Tasks Trace RCU reader.
> +               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map=
);

why is this a "try_lock" variant instead of a no-try "lock_acquire"
one? Some lockdep special treatment for nested locking?

> +               return;
> +       }
> +       barrier();  // nesting before scp to protect against interrupt ha=
ndler.
> +       t->trc_reader_scp =3D srcu_read_lock_fast(&rcu_tasks_trace_srcu_s=
truct);
> +       smp_mb(); // Placeholder for more selective ordering
>  }
>
>  /**

[...]

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2b272382673d62..89d3646155525f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -939,6 +939,7 @@ struct task_struct {
>
>  #ifdef CONFIG_TASKS_TRACE_RCU
>         int                             trc_reader_nesting;
> +       struct srcu_ctr __percpu        *trc_reader_scp;
>         int                             trc_ipi_to_cpu;
>         union rcu_special               trc_reader_special;
>         struct list_head                trc_holdout_list;
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index e3b64a5e0ec7e1..3450c3751ef7ad 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -106,15 +106,15 @@ void __srcu_read_unlock(struct srcu_struct *ssp, in=
t idx)
>         newval =3D READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
>         WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
>         preempt_enable();
> -       if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> +       if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !i=
rqs_disabled())

this seems like something that probably should be done in a separate
patch with an explanation on why?

>                 swake_up_one(&ssp->srcu_wq);
>  }
>  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>
>  /*
>   * Workqueue handler to drive one grace period and invoke any callbacks
> - * that become ready as a result.  Single-CPU and !PREEMPTION operation
> - * means that we get away with murder on synchronization.  ;-)
> + * that become ready as a result.  Single-CPU operation and preemption
> + * disabling mean that we get away with murder on synchronization.  ;-)
>   */
>  void srcu_drive_gp(struct work_struct *wp)
>  {
> @@ -141,7 +141,12 @@ void srcu_drive_gp(struct work_struct *wp)
>         WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>         WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wa=
kes! */
>         preempt_enable();
> -       swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nes=
ting[idx]));
> +       do {
> +               // Deadlock issues prevent __srcu_read_unlock() from
> +               // doing an unconditional wakeup, so polling is required.
> +               swait_event_timeout_exclusive(ssp->srcu_wq,
> +                                             !READ_ONCE(ssp->srcu_lock_n=
esting[idx]), HZ / 10);
> +       } while (READ_ONCE(ssp->srcu_lock_nesting[idx]));

ditto, generic srcu change, driven by RCU Tasks Trace transformation,
but probably worth calling it out separately?

>         preempt_disable();  // Needed for PREEMPT_LAZY
>         WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() ch=
eap. */
>         WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);

[...]

