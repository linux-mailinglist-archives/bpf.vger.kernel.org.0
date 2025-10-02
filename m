Return-Path: <bpf+bounces-70215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C94BB48B9
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA53B19C1167
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963BC261B9C;
	Thu,  2 Oct 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJR7j5Zp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804B1E3DCF
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422752; cv=none; b=KTnctqY7PmzD3m83yHSQg884s2Ql/Rj9vj1DFLTusFH3motOrdGR9oOY5LjWi4CEnhzrNJGavRJWDaJuc0ri/XIXTo2wna1GhAykkEdrAC4stipQFbDZu0AWEDfHB4JAov5lKqfd/w1AbmJJPpi+PfFUbG2h9zu6pD6pmKUcmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422752; c=relaxed/simple;
	bh=NVfPzjoWTU07D45BcSJs5wOYo8i0CB5QK35kQXrChSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix0XRsOv4WqTzp+9CWdzYczTf7DnXOAEmafqUXMHsVHaf/zsSNrH89N94TQK7o0AyTh3Varx8gN1lmAQvTZBxRlV43mT+TLSC3Rc/Y2m/HbvuR4moYze6zkkMPxrtSBrnb80ftB4qpSeR+5F36QYbKz8MreD3ri3TxJ4vvMOU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJR7j5Zp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so1069515a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422750; x=1760027550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J82hEbppU5PpCA3ET4b2HIdeaLxw8NSSqjpat9l2Btg=;
        b=XJR7j5Zp7x8SLw5kI8IBGmgQwdwnEi2iOLAepbb3H4MXHfSn6TxXzTliVKutGgyz3+
         DMoo/UBnmBRhXnmUUVCcrSqJGs0NL4n2J1Ci8bzsS7ZecEyUK3joQzM4pmRTtoj1qoh0
         6IfwpZdUfBxqX+jRXdLuK/tuwRcOv+0NHzFiki+cZyKZ6KdDZS+sXJQcnCoC0phTPFc8
         X4l5SsmRkor5rtjep2jvLL1mt7M09HWgTOk+akl1Ir0VdXdWQg0+sCl0fSB79IXoK7IZ
         ezbllLNDE9TkuGRIhb5P5+k4oAYmKfnofdeCum+2lV3a18cvIxlsNzEQgO+SNbmGIL2Z
         Gjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422750; x=1760027550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J82hEbppU5PpCA3ET4b2HIdeaLxw8NSSqjpat9l2Btg=;
        b=xUDGLRLzlvu7NFhN4eunZ58a90LzCaX8CzHnWHSOysP8Amrluwqwax65RWbBu5EOBR
         Qoz+wRCKJ7ifB5F3EO4FaZU8U+SGqVpmdTVPKC4Z/A/FNt55SUaXyNiilJx8AanSxIev
         FIQjOk8VY60g6YXJux4474F0hgQcDib9ZzZsO/fK9s9HwjtknTgwoqswVP9ONcVCGaPa
         mLvr5VuIebZ92vxSQCdNaVaw1SlZpn7xOf9PURvoAgm7s1QuslXzqI0vfL7pa1hxdCtY
         sMT59I5LGTQUyNU0mO2j7N5hdBENaux9ifmRzbVoYT12pxGj1ynk1giaBQ5/UdsYwlbP
         Fd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgn+abfClZvu8N7z+tPnreVh4f8XGPQbFrbdN4serllusV8iErLVKOlI+RUS7rylTGvsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZtlOrOwIwUEhBZE5ZK60itL4Tz5XcjWm2+YNGg3m9Amjk/mo
	4mr3K+LpRwGiYDjnTXlDGS+q30zM6xHno4W2ipg7qzAiATdJAluW4t54VZW5/OUyPGoK8ZqsHRh
	oUGHj3heyczKx8jxkWvfJu00QLMTf/8Q=
X-Gm-Gg: ASbGncvDFuHTON6YHWZ+KBTh3Lss5Q4hkxeNna29Im8d4MW97vqjZpbzFMFbqWh4MjW
	SIjrc7t+iTVhBAEfEhajRCpdXVLPHj472FqqcxiT0bZcRXWnNFIttbM1EhuFFXkVJZe983HGJcT
	sN3c3mz/+0KqkvqOccY1B6aRD9EK2lERsoC7XojFXztmQiMKrl5KNCZu09De3cjVhecaQRbD44s
	PzQIYbJsB7J50wvkz+qWM3/VQavyro=
X-Google-Smtp-Source: AGHT+IH1kqYprFVu+gRwT9ksEvkx2IZae2hfvbLLg7njU+1lezqfM8necgEFjx5pebciFSKMYMvp+Z1vh9PYQgWKCRA=
X-Received: by 2002:a17:90b:1b49:b0:335:228c:6f24 with SMTP id
 98e67ed59e1d1-339a6f314bamr9388726a91.25.1759422749743; Thu, 02 Oct 2025
 09:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-8-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-8-roman.gushchin@linux.dev>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:37:25 -0400
X-Gm-Features: AS18NWDbe-kMSZ7SJAYFEu7SK7fkTQUsM14-iqOYEo7iaeFy2DxQ3izBL6FI7Mg
Message-ID: <CALC8CXfcJjoHyZAiHm1meGtKf9CAbgnmhy4fxMqaa5Gb_ZHvwQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/14] mm: allow specifying custom oom constraint for
 bpf triggers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Roman Gushchin...
RUSSKIEEEEEE

On Mon, Aug 18, 2025 at 1:05=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Currently there is a hard-coded list of possible oom constraints:
> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
> Also, add an ability to specify a custom constraint name
> when calling bpf_out_of_memory(). If an empty string is passed
> as an argument, CONSTRAINT_BPF is displayed.
>
> The resulting output in dmesg will look like this:
>
> [  315.224875] kworker/u17:0 invoked oom-killer: gfp_mask=3D0x0(), order=
=3D0, oom_score_adj=3D0
>                oom_policy=3Ddefault
> [  315.226532] CPU: 1 UID: 0 PID: 74 Comm: kworker/u17:0 Not tainted 6.16=
.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> [  315.226534] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-5.fc42 04/01/2014
> [  315.226536] Workqueue: bpf_psi_wq bpf_psi_handle_event_fn
> [  315.226542] Call Trace:
> [  315.226545]  <TASK>
> [  315.226548]  dump_stack_lvl+0x4d/0x70
> [  315.226555]  dump_header+0x59/0x1c6
> [  315.226561]  oom_kill_process.cold+0x8/0xef
> [  315.226565]  out_of_memory+0x111/0x5c0
> [  315.226577]  bpf_out_of_memory+0x6f/0xd0
> [  315.226580]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  315.226589]  bpf_prog_3018b0cf55d2c6bb_handle_psi_event+0x5d/0x76
> [  315.226594]  bpf__bpf_psi_ops_handle_psi_event+0x47/0xa7
> [  315.226599]  bpf_psi_handle_event_fn+0x63/0xb0
> [  315.226604]  process_one_work+0x1fc/0x580
> [  315.226616]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  315.226624]  worker_thread+0x1d9/0x3b0
> [  315.226629]  ? __pfx_worker_thread+0x10/0x10
> [  315.226632]  kthread+0x128/0x270
> [  315.226637]  ? lock_release+0xd4/0x2d0
> [  315.226645]  ? __pfx_kthread+0x10/0x10
> [  315.226649]  ret_from_fork+0x81/0xd0
> [  315.226652]  ? __pfx_kthread+0x10/0x10
> [  315.226655]  ret_from_fork_asm+0x1a/0x30
> [  315.226667]  </TASK>
> [  315.239745] memory: usage 42240kB, limit 9007199254740988kB, failcnt 0
> [  315.240231] swap: usage 0kB, limit 0kB, failcnt 0
> [  315.240585] Memory cgroup stats for /cgroup-test-work-dir673/oom_test/=
cg2:
> [  315.240603] anon 42897408
> [  315.241317] file 0
> [  315.241493] kernel 98304
> ...
> [  315.255946] Tasks state (memory values in pages):
> [  315.256292] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file =
rss_shmem pgtables_bytes swapents oom_score_adj name
> [  315.257107] [    675]     0   675   162013    10969    10712      257 =
        0   155648        0             0 test_progs
> [  315.257927] oom-kill:constraint=3DCONSTRAINT_BPF_PSI_MEM,nodemask=3D(n=
ull),cpuset=3D/,mems_allowed=3D0,oom_memcg=3D/cgroup-test-work-dir673/oom_t=
est/cg2,task_memcg=3D/cgroup-test-work-dir673/oom_test/cg2,task=3Dtest_prog=
s,pid=3D675,uid=3D0
> [  315.259371] Memory cgroup out of memory: Killed process 675 (test_prog=
s) total-vm:648052kB, anon-rss:42848kB, file-rss:1028kB, shmem-rss:0kB, UID=
:0 pgtables:152kB oom_score_adj:0
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/oom.h |  4 ++++
>  mm/oom_kill.c       | 38 +++++++++++++++++++++++++++++---------
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index ef453309b7ea..4b04944b42de 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -19,6 +19,7 @@ enum oom_constraint {
>         CONSTRAINT_CPUSET,
>         CONSTRAINT_MEMORY_POLICY,
>         CONSTRAINT_MEMCG,
> +       CONSTRAINT_BPF,
>  };
>
>  /*
> @@ -58,6 +59,9 @@ struct oom_control {
>
>         /* Policy name */
>         const char *bpf_policy_name;
> +
> +       /* BPF-specific constraint name */
> +       const char *bpf_constraint;
>  #endif
>  };
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index df409f0fac45..67afcd43a5f7 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -240,13 +240,6 @@ long oom_badness(struct task_struct *p, unsigned lon=
g totalpages)
>         return points;
>  }
>
> -static const char * const oom_constraint_text[] =3D {
> -       [CONSTRAINT_NONE] =3D "CONSTRAINT_NONE",
> -       [CONSTRAINT_CPUSET] =3D "CONSTRAINT_CPUSET",
> -       [CONSTRAINT_MEMORY_POLICY] =3D "CONSTRAINT_MEMORY_POLICY",
> -       [CONSTRAINT_MEMCG] =3D "CONSTRAINT_MEMCG",
> -};
> -
>  static const char *oom_policy_name(struct oom_control *oc)
>  {
>  #ifdef CONFIG_BPF_SYSCALL
> @@ -256,6 +249,27 @@ static const char *oom_policy_name(struct oom_contro=
l *oc)
>         return "default";
>  }
>
> +static const char *oom_constraint_text(struct oom_control *oc)
> +{
> +       switch (oc->constraint) {
> +       case CONSTRAINT_NONE:
> +               return "CONSTRAINT_NONE";
> +       case CONSTRAINT_CPUSET:
> +               return "CONSTRAINT_CPUSET";
> +       case CONSTRAINT_MEMORY_POLICY:
> +               return "CONSTRAINT_MEMORY_POLICY";
> +       case CONSTRAINT_MEMCG:
> +               return "CONSTRAINT_MEMCG";
> +#ifdef CONFIG_BPF_SYSCALL
> +       case CONSTRAINT_BPF:
> +               return oc->bpf_constraint ? : "CONSTRAINT_BPF";
> +#endif
> +       default:
> +               WARN_ON_ONCE(1);
> +               return "";
> +       }
> +}
> +
>  /*
>   * Determine the type of allocation constraint.
>   */
> @@ -267,6 +281,9 @@ static enum oom_constraint constrained_alloc(struct o=
om_control *oc)
>         bool cpuset_limited =3D false;
>         int nid;
>
> +       if (oc->constraint =3D=3D CONSTRAINT_BPF)
> +               return CONSTRAINT_BPF;
> +
>         if (is_memcg_oom(oc)) {
>                 oc->totalpages =3D mem_cgroup_get_max(oc->memcg) ?: 1;
>                 return CONSTRAINT_MEMCG;
> @@ -458,7 +475,7 @@ static void dump_oom_victim(struct oom_control *oc, s=
truct task_struct *victim)
>  {
>         /* one line summary of the oom killer context. */
>         pr_info("oom-kill:constraint=3D%s,nodemask=3D%*pbl",
> -                       oom_constraint_text[oc->constraint],
> +                       oom_constraint_text(oc),
>                         nodemask_pr_args(oc->nodemask));
>         cpuset_print_current_mems_allowed();
>         mem_cgroup_print_oom_context(oc->memcg, victim);
> @@ -1344,11 +1361,14 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_c=
ontrol *oc,
>   * Returns a negative value if an error has been occurred.
>   */
>  __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> -                                 int order, bool wait_on_oom_lock)
> +                                 int order, bool wait_on_oom_lock,
> +                                 const char *constraint_text__nullable)
>  {
>         struct oom_control oc =3D {
>                 .memcg =3D memcg__nullable,
>                 .order =3D order,
> +               .constraint =3D CONSTRAINT_BPF,
> +               .bpf_constraint =3D constraint_text__nullable,
>         };
>         int ret;
>
> --
> 2.50.1
>
>

