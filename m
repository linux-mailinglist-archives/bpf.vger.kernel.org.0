Return-Path: <bpf+bounces-57011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE9CAA3FB2
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BC83B43D1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214421B7F4;
	Wed, 30 Apr 2025 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+HUEtDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737E2DC767
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972954; cv=none; b=UuhBY1RpwI7LgUaQYn258tDB8xusdCZhOLDfOlrKMMOMcftVYT97kYBbkMnBv5gk1quxX9ojCiCC6AZM/ivx0un2ulit9G2b5CXy/rX59bsNE91SB0yy9LO0/c4gjY0AL9W0b3rLSNHwbI39Sq0EZ4EbN3Gv+E+mTq1Pgg+tR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972954; c=relaxed/simple;
	bh=rckdEsw4LI+2Q4VYEsNzqiOS7xxyq/0EBJvPBWu9bjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRoFp0v2QWTdfGpmbGDxrcoAbYN6A+iXA0Z0k5KLUW4GLmrUwKfyRP5+4KDQmpzgmNlGKC/3QjvRMiyAe/NCgxaTB44nTSZ0vy/saq8Zwwj3i78FkPl4oRAO94AWLMjXRW09XFOqpqvyJxpmOg9GwSSk7SibtldD158cVxVDcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+HUEtDP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47666573242so500001cf.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745972952; x=1746577752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SET8sA9iAqxjHw6Ms59eY6Brr42Gs60ohd9HvBlI7Ok=;
        b=B+HUEtDPnbQRVIZj2INCuc0Qeqf0iXm5Zn1bBgA1QDnMi4YJ+oELctz9VPs9HHM5dL
         HtNo343gEFXv3Tlikn+CPejXj5Ia/4C8OQpxoiP2kuL1qJNttSFNXbvHlDnI0wlwPVJV
         aL3JVvr9ewpnseJdudlCHvHm7Ws5WbVES000+6GVed7i7dmGDYKRCffL5U4aGjrpfrT8
         0aPRhlKlFKS4IwcxjG5B4TZco4VJHFGbpFamYDlX8OPpaDZzsDcFocdh2sstzZgxkPoR
         tSDCRrPhw3fe0Z21J6sFte7ZveqerUo1X8eUjbXcjv59cIPOBc/snPtXvODu+XjmODil
         tv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972952; x=1746577752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SET8sA9iAqxjHw6Ms59eY6Brr42Gs60ohd9HvBlI7Ok=;
        b=nKw8JqSDWWbhqn78mjpqbIdD+2uKpJKYiPNZazsjLw4V+zG637MSVj4B5e4SEQALwZ
         PIp1SkSN9hhaJNxnarD1ovHMW5byVTqPVYzLecauNZf7g66TrO2aNFYpUV/64DTzikpr
         1xGvBi8tT5JtVaLD5Od2xHRnDAL0MLaIbFtM3zu6iLsvbOXIlAmx6X1ud8yiGGYgXQnH
         7rpIKRnFEj+tmg7qni1xzLSoo9kGQ4Z2d1s4awXiY1gwdWB/BXDFlbcMcwUdXxeP9SMR
         2nY0nGOcHeeNAfQyYf47cLQOLsO353nEzGqQ4VeL5ebt3N5m0yMxwMCVKzamGLlGwgVA
         OO0w==
X-Forwarded-Encrypted: i=1; AJvYcCX9tTWVs/hoFJzJu1BYgSToFnrgKiPOSXav08GNKk9tu+Mrrsu8pq+bHLKyZtMdDzLMHv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3Wgx9XakqtLPVoVt3BcAHl94TBcqO3SXPmoMXPkyG8PUowGW
	Lx4R6uYeQPUmrDu4FWZViTWB8fsYha9pbUclD4ygyfdIJCW6y/O9ZZWFWLL/BQO7Jus8ey7T+b5
	cbDN9Ua2d62yXOkTtRhgimcWPiqUcmhYvXDjr
X-Gm-Gg: ASbGnctGKLA043IznFprjYbi6un9WvK8pGCqeoVdYIw4jl6QLOM1QScA8VBfDTobicB
	sP+EyOb5fzGlnELGqa7v6FNjFXmZ5If9LNmdSLGQsSd/m/talS1QMPvxCMr211/2w8OUdsY1JJd
	S82l2mPBXWF4jb0lB76QI6TH2dWGxpPZe6uGctCaE84XuNZM3qinYAYE5RZ7E4XRA=
X-Google-Smtp-Source: AGHT+IGYYwIA/2/5KM/ug1jcPdIS8qPi3fGg3w/31Max0dqI27BtipvLcMKHWDfaI1D8DwJd48fBi1Tpym4pkltqpto=
X-Received: by 2002:ac8:7e83:0:b0:486:9b6e:dd46 with SMTP id
 d75a77b69052e-489b993a5b3mr2073341cf.10.1745972951520; Tue, 29 Apr 2025
 17:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev> <20250428033617.3797686-10-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-10-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 17:28:59 -0700
X-Gm-Features: ATxdqUHFz_05fXYir2rslhYlMwSd6Gi_vbBqhLqf6_eQZAIUdoejhM82LlPFoTU
Message-ID: <CAJuCfpEdyZWac7diTUYV7JjkpAPDuy9hwT5sfE2AC2zDVPA9ZA@mail.gmail.com>
Subject: Re: [PATCH rfc 09/12] sched: psi: bpf hook to handle psi events
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Rientjes <rientjes@google.com>, 
	Josh Don <joshdon@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 8:37=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Introduce a bpf hook to handle psi events. The primary intended
> purpose of this hook is to declare OOM events based on the reaching
> a certain memory pressure level, similar to what systemd-oomd and oomd
> are doing in userspace.

It's a bit awkward that this requires additional userspace action to
create PSI triggers. I have almost no experience with BPF, so this
might be a stupid question, but maybe we could provide a bpf kfunc for
the BPF handler to register its PSI trigger(s) upon handler
registration?


>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  kernel/sched/psi.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1396674fa722..4c4eb4ead8f6 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -176,6 +176,32 @@ static void psi_avgs_work(struct work_struct *work);
>
>  static void poll_timer_fn(struct timer_list *t);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +__bpf_hook_start();
> +
> +__weak noinline int bpf_handle_psi_event(struct psi_trigger *t)
> +{
> +       return 0;
> +}
> +
> +__bpf_hook_end();
> +
> +BTF_KFUNCS_START(bpf_psi_hooks)
> +BTF_ID_FLAGS(func, bpf_handle_psi_event, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_psi_hooks)
> +
> +static const struct btf_kfunc_id_set bpf_psi_hook_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_psi_hooks,
> +};
> +
> +#else
> +static inline int bpf_handle_psi_event(struct psi_trigger *t)
> +{
> +       return 0;
> +}
> +#endif
> +
>  static void group_init(struct psi_group *group)
>  {
>         int cpu;
> @@ -489,6 +515,7 @@ static void update_triggers(struct psi_group *group, =
u64 now,
>
>                 /* Generate an event */
>                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> +                       bpf_handle_psi_event(t);
>                         if (t->of)
>                                 kernfs_notify(t->of->kn);
>                         else
> @@ -1655,6 +1682,8 @@ static const struct proc_ops psi_irq_proc_ops =3D {
>
>  static int __init psi_proc_init(void)
>  {
> +       int err =3D 0;
> +
>         if (psi_enable) {
>                 proc_mkdir("pressure", NULL);
>                 proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
> @@ -1662,9 +1691,14 @@ static int __init psi_proc_init(void)
>                 proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops=
);
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>                 proc_create("pressure/irq", 0666, NULL, &psi_irq_proc_ops=
);
> +#endif
> +#ifdef CONFIG_BPF_SYSCALL
> +               err =3D register_btf_fmodret_id_set(&bpf_psi_hook_set);
> +               if (err)
> +                       pr_err("error while registering bpf psi hooks: %d=
", err);
>  #endif
>         }
> -       return 0;
> +       return err;
>  }
>  module_init(psi_proc_init);
>
> --
> 2.49.0.901.g37484f566f-goog
>

