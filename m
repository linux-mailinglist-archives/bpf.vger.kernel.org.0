Return-Path: <bpf+bounces-66056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD1B2D1F7
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 04:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AAA2A55F8
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2B2C21D9;
	Wed, 20 Aug 2025 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0hbYlVl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A582C21C1;
	Wed, 20 Aug 2025 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657190; cv=none; b=JH0jmg80pzXzL7b0AC2xsMF1bfrNpC2UeNN/KqHVgf/AbQ0VOzex6AkFq1rm4Fj9wnA6J73K3jk4n9blwc9vtsz63jSa+t1Xirx1H0TYPaZYD3OLjao/7yrq/i1SHdw9VpASGMuLyIgzvwQZUBJlsK8a57gwbArqUl1Ow8jLM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657190; c=relaxed/simple;
	bh=ahTPjfAg4oi6c56ffxAx3eXqxzuaJMTQwV9UOIeOKvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QESnw3pbU+1B7UyRt3nxwGlnZ4jId6v40XjgGMSbeHslCaumYe5KnKTAeAP8gBx4lxqMr/FyKzGssxOrBKJBKaLzwn+Sz5rbxEpzf6uPy84PYVWFfc+4wmRwW+LmL26wZXXOIoFvt4smD88Rb92qevoVSN0C1b17Z4Cnjngu3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0hbYlVl; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e934c8f9751so3135225276.2;
        Tue, 19 Aug 2025 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755657187; x=1756261987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFZsfawiVxjLNHZ7IzinbbpvJf2yb/Yl68UbpSZ1Gs8=;
        b=k0hbYlVlTe/DugExaesNRLCO8EgIuBkICzGlaGtfeEkUNKywIFWToU+NzNZg6mXfy3
         DyTyp423EAmSooSLClYzhsrqRBC2Z5lUsib+JneT0UkxwrZlCAW7Z803zdBj+ACu8nEa
         dOWwGqCByPL1jCozrobtRK1gh4aOuREKKHKg865gY17pobNjwJD4y7648/Y6qsnpDxY3
         uJENZ1HWpNKhfrjAGHslta2wKDe/lMACLg1dSk9EysasqEdY4GHziRxO422wfeQPHKHF
         OIimnxaEkEUg7K+psYna/FpZHW/g00/xLMUcrbdXOUIaZEF130PKOmqSQ/5lEUKpRCCU
         VlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755657187; x=1756261987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFZsfawiVxjLNHZ7IzinbbpvJf2yb/Yl68UbpSZ1Gs8=;
        b=KOfjfohr8dFOAj8MrcHKJakKt2i97XekeVTAGUAcvyCNkv4M0zUrZ0zH+DVFcg6CJv
         wqzjooPNGly4nRKrAaWEBf6pB9pORpgTfRcUYD8I2Wbv94NRG954cXNioC9g/JbxdOTE
         enjkE3BPOBCh0y3T38l8jQYq71RalNqcgWg+Vqh1x8u24i6DR2uAbe1LvrVrx0PXo73b
         BfhQAqnImVhosLvlA26jQ6DasfDF0x3M/uKAZ5odkX+317m0YjarDXdQI0enJEwFizYU
         Ncug8cWsZIoX7BBRnfWkrVBCAHrKPsW+9YIVvRT05O6w1RpEpkIrKeOca/EqIzgZZ6X7
         FhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEofvdcgu94ZA/NFnGK0uvlQWMxuNKcBRSTkFq+HlvwXMqmknNJCpo6uDKlIcmB5wGdKXwsFBo+nwzWw7x@vger.kernel.org, AJvYcCXJemUXThh+hjk9zDUDg9rzHIReF+6OrInOGD3PYq/6e1E4FJeepDKipthzxNAoh5gLNvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqJSluwCvD0rpMaaLim6BXtpP8SIVgIxpIPi1q3ES9SQue8AS
	32IQAs9RM/9ok3byvUsW9UXaFsygCKdeLoR9zceRWy+e9XsA628UBX4WkOr3c/jERV5dJvECZOv
	/M0Os2z7IZ+ThS/XqyQpVJOJeuWVkmylSW7Ms
X-Gm-Gg: ASbGncuaF7wKe/NVzHmiCGwVhVr85llowztkOvk1gBh4sb64ARiFULVZav7eE+IR5bP
	jgbLMe+Ye4f097u/94M85a+Lcn+WcvTzPQ2XFPhn/ZWkRq6/3QAuEUPW1aHGEXY4THVe/UKFVXJ
	u9QkvFVgg7bvncSdZZCLqKma49Y54zitsFVu5seim7d5phQjVInrBQjHRA1LP/RkKewhQkAgV+Q
	DmUt3c=
X-Google-Smtp-Source: AGHT+IESExhkO5Z3C9hzTKDiKtUDK3BCG7C+9gnrPGkoPW05GT4xC2Eq2mCwCKHzaZohVdqbVMlOfOn87mq0VXfoOII=
X-Received: by 2002:a05:690c:6ac5:b0:71f:b944:103d with SMTP id
 00721157ae682-71fb9444a43mr1815717b3.46.1755657187424; Tue, 19 Aug 2025
 19:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
 <20250819015832.11435-3-dongml2@chinatelecom.cn> <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250819123214.GH4067720@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 20 Aug 2025 10:32:56 +0800
X-Gm-Features: Ac12FXyrr8knAwpzzu1QatH6z4ggFtRoL4iJ_8v7RFTEZnYKLwUfbyrLRuIQkT0
Message-ID: <CADxym3Z7xtda+sf1PL8i_1TY8tqy-e3GqM1vAVJu5_VZ+CazMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched: make migrate_enable/migrate_disable inline
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	simona.vetter@ffwll.ch, tzimmermann@suse.de, jani.nikula@intel.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:32=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Aug 19, 2025 at 09:58:31AM +0800, Menglong Dong wrote:
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index be00629f0ba4..00383fed9f63 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_runnin=
g_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> >
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +EXPORT_SYMBOL_GPL(runqueues);
>
> Oh no, absolutely not.
>
> You never, ever, export a variable, and certainly not this one.
>
> How about something like so?
>
> I tried 'clever' things with export inline, but the compiler hates me,
> so the below is the best I could make work.

I see. You mean that we don't export the various, and use the
inlined version in vmlinux, and use the external version in modules,
which I think is nice ;)

(I were not aware that we should export various :/)

I'll try your advice.

Thanks!
Menglong Dong

>
> ---
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2315,6 +2315,7 @@ static __always_inline void alloc_tag_re
>  #define alloc_tag_restore(_tag, _old)          do {} while (0)
>  #endif
>
> +#ifndef MODULE
>  #ifndef COMPILE_OFFSETS
>
>  extern void __migrate_enable(void);
> @@ -2328,7 +2329,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq
>  #define this_rq_raw() PERCPU_PTR(&runqueues)
>  #endif
>
> -static inline void migrate_enable(void)
> +static inline void _migrate_enable(void)
>  {
>         struct task_struct *p =3D current;
>
> @@ -2363,7 +2364,7 @@ static inline void migrate_enable(void)
>         (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))--;
>  }
>
> -static inline void migrate_disable(void)
> +static inline void _migrate_disable(void)
>  {
>         struct task_struct *p =3D current;
>
> @@ -2382,10 +2383,30 @@ static inline void migrate_disable(void)
>         (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))++;
>         p->migration_disabled =3D 1;
>  }
> -#else
> -static inline void migrate_disable(void) { }
> -static inline void migrate_enable(void) { }
> -#endif
> +#else /* !COMPILE_OFFSETS */
> +static inline void _migrate_disable(void) { }
> +static inline void _migrate_enable(void) { }
> +#endif /* !COMPILE_OFFSETS */
> +
> +#ifndef CREATE_MIGRATE_DISABLE
> +static inline void migrate_disable(void)
> +{
> +       _migrate_disable();
> +}
> +
> +static inline void migrate_enable(void)
> +{
> +       _migrate_enable();
> +}
> +#else /* CREATE_MIGRATE_DISABLE */
> +extern void migrate_disable(void);
> +extern void migrate_enable(void);
> +#endif /* CREATE_MIGRATE_DISABLE */
> +
> +#else /* !MODULE */
> +extern void migrate_disable(void);
> +extern void migrate_enable(void);
> +#endif /* !MODULE */
>
>  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7,6 +7,9 @@
>   *  Copyright (C) 1991-2002  Linus Torvalds
>   *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
>   */
> +#define CREATE_MIGRATE_DISABLE
> +#include <linux/sched.h>
> +
>  #include <linux/highmem.h>
>  #include <linux/hrtimer_api.h>
>  #include <linux/ktime_api.h>
> @@ -119,7 +122,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_updat
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> -EXPORT_SYMBOL_GPL(runqueues);
>
>  #ifdef CONFIG_SCHED_PROXY_EXEC
>  DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> @@ -2382,6 +2384,11 @@ static void migrate_disable_switch(struc
>         __do_set_cpus_allowed(p, &ac);
>  }
>
> +void migrate_disable(void)
> +{
> +       _migrate_disable();
> +}
> +
>  void __migrate_enable(void)
>  {
>         struct task_struct *p =3D current;
> @@ -2392,7 +2399,11 @@ void __migrate_enable(void)
>
>         __set_cpus_allowed_ptr(p, &ac);
>  }
> -EXPORT_SYMBOL_GPL(__migrate_enable);
> +
> +void migrate_enable(void)
> +{
> +       _migrate_enable();
> +}
>
>  static inline bool rq_has_pinned_tasks(struct rq *rq)
>  {

