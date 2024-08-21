Return-Path: <bpf+bounces-37737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D595A2FD
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2AA1F22BAE
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4B15444F;
	Wed, 21 Aug 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdTa+j/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B881531DD;
	Wed, 21 Aug 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258339; cv=none; b=YBl0cuhEx9FvLsP0VNhbRw+f/PYJhxMIDyMVTI4MiTvfYQc1JWFrtLQUwoYcN2MgwUBAvSyEa6Cr9eaIfM3ZTjVb6aidfHf5i42aNCmxdgVj7u3dt/OPei67fmJTvxcSA6fK/PrbXd6u8sNUYBXGIxwMVRlQar8jtTy4jJJ5LDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258339; c=relaxed/simple;
	bh=nI1kfnd2AQwutPhf1hifBDEGMiu0e4Ykf6os4DdKgJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDFEcJCnMA9gSxnrnqFDJLbJHtihtzm05WYaB7iOOFVqf0GPQbUeW89ryZBnGglUNEDT4zYHFatSy+67S09nrFerO/2PARa/B/lS+//qgfZx7Uq9FQEP2xXp5IoEsWSOkEPyfuO3PQwbY4iH7IfeavHEC+/TxiN4pCvY0P+XFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdTa+j/l; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso5397027a91.1;
        Wed, 21 Aug 2024 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724258337; x=1724863137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dGCCMIKQLvLb5lnBclxR1FcGee18F5yKa1iehrvVxc=;
        b=GdTa+j/lpC28XxOZok+cDrM/UfhW6Y7CUm/IK19bxxVTatfC2+xhbIRepSmrW0DuD+
         zwoU9HxfpQEA+BXAJdY7LvL1hhiP8sNrlQE1Y63N6QKRjgzK3ILxA6vGocJp/i9JQts7
         nMMQTqoY3ysgroAkX3ZofiLW13ilRY2QJKDo/vzcDJMG+GgF2LDHTalFfILqzQAiibJf
         guaUEmVNNoiFoN5fMcxe9IYl4Li/kQoHAWgLLseELXSzqEfj2cyfn3Ofj+RaFtnU3djk
         VLVN/bdAtBKIHizuZj/TU2tezR3Xzur+mX2PjTyaN+c6ING0qXqP/52SqwPcBveCA8rd
         uMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258337; x=1724863137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dGCCMIKQLvLb5lnBclxR1FcGee18F5yKa1iehrvVxc=;
        b=Gi8R0k3YCQYt5aLKUlHOH7Qq28+7NMqDRKUATVwyl86oHeauGZVEHrzwioZgjYjL3K
         HS0MJ5VOQAgwXtdPQAGGt/n5oYLa20EsrcFBTD5ZDx3U+BrI1JLSp79djpkM8O25dQzj
         DELZWLmhVXf+21j785cRgr5Q3AunRO9XqmLZ1cHt5anpGxNMaNvYP2R8s/f1+4jvJOnI
         JBdRBwCIAiSgrgcqwgdZSCPCGSV5gzu+DPjfQ6tw90aN7S51Sx3E/cYY50wHWPLwwJn3
         uTdLnPXi0d6PA+8rMLu5Mmoi4YSTJkgjB7701E9YCFJimYqjhHLynzA9fBiggun+qxoi
         TkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVItMmnJPbJwInwnpK9JMtzgzkFD1NbphAWOGzOlWwZiEvl1S8+RdFh3kmRXhB+EqEYbTM=@vger.kernel.org, AJvYcCWT1hTpwSYOmOL3qJ0kbFF0IsSs+mkliaxzYYY20MlUiSO8YWvpzm9F5zk10eqT1R0/iaUozW9z3wqJhTdM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7unVlJUOo+SOTep0vYHOmBPByBIsk6uzWdHtPodRLdWjWvEL8
	eLhEKz6KFGv8kJQ45WwjtDGyoTdu32Qdx9KgATIPaozOOUZc/DGVd21GZv4rsfMV024xMyK20kM
	jb5R75SnoM513yUvjYlPyftyhlnM=
X-Google-Smtp-Source: AGHT+IHgxlHE0G6w+twguixO3/VlEkkkbuLBd55NFEezH/MWu9XzW4Z1Kp0q4Y3McHwDxo7Ps6VEC2chZal/3Cl1/P4=
X-Received: by 2002:a17:90a:e54a:b0:2d3:cc31:5fdc with SMTP id
 98e67ed59e1d1-2d5e99c59f9mr3369843a91.5.1724258336829; Wed, 21 Aug 2024
 09:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813203409.3985398-1-andrii@kernel.org>
In-Reply-To: <20240813203409.3985398-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 09:38:44 -0700
Message-ID: <CAEf4BzaKcrKXsdEu9Jo6=QAgn+SX3QxjmAt3vQEQ46UOkLh5eg@mail.gmail.com>
Subject: Re: [PATCH v3] uprobes: turn trace_uprobe's nhit counter to be
 per-CPU one
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, peterz@infradead.org, oleg@redhat.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:34=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> trace_uprobe->nhit counter is not incremented atomically, so its value
> is questionable in when uprobe is hit on multiple CPUs simultaneously.
>
> Also, doing this shared counter increment across many CPUs causes heavy
> cache line bouncing, limiting uprobe/uretprobe performance scaling with
> number of CPUs.
>
> Solve both problems by making this a per-CPU counter.
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>

Is there anything else I'm expected to do about this patch? If not,
can this please be applied? Thanks!

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..c3df411a2684 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>  #include <linux/rculist.h>
>  #include <linux/filter.h>
> +#include <linux/percpu.h>
>
>  #include "trace_dynevent.h"
>  #include "trace_probe.h"
> @@ -62,7 +63,7 @@ struct trace_uprobe {
>         char                            *filename;
>         unsigned long                   offset;
>         unsigned long                   ref_ctr_offset;
> -       unsigned long                   nhit;
> +       unsigned long __percpu          *nhits;
>         struct trace_probe              tp;
>  };
>
> @@ -337,6 +338,12 @@ alloc_trace_uprobe(const char *group, const char *ev=
ent, int nargs, bool is_ret)
>         if (!tu)
>                 return ERR_PTR(-ENOMEM);
>
> +       tu->nhits =3D alloc_percpu(unsigned long);
> +       if (!tu->nhits) {
> +               ret =3D -ENOMEM;
> +               goto error;
> +       }
> +
>         ret =3D trace_probe_init(&tu->tp, event, group, true, nargs);
>         if (ret < 0)
>                 goto error;
> @@ -349,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *eve=
nt, int nargs, bool is_ret)
>         return tu;
>
>  error:
> +       free_percpu(tu->nhits);
>         kfree(tu);
>
>         return ERR_PTR(ret);
> @@ -362,6 +370,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu=
)
>         path_put(&tu->path);
>         trace_probe_cleanup(&tu->tp);
>         kfree(tu->filename);
> +       free_percpu(tu->nhits);
>         kfree(tu);
>  }
>
> @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_file =
*m, void *v)
>  {
>         struct dyn_event *ev =3D v;
>         struct trace_uprobe *tu;
> +       unsigned long nhits;
> +       int cpu;
>
>         if (!is_trace_uprobe(ev))
>                 return 0;
>
>         tu =3D to_trace_uprobe(ev);
> +
> +       nhits =3D 0;
> +       for_each_possible_cpu(cpu) {
> +               nhits +=3D per_cpu(*tu->nhits, cpu);
> +       }
> +
>         seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> -                       trace_probe_name(&tu->tp), tu->nhit);
> +                  trace_probe_name(&tu->tp), nhits);
>         return 0;
>  }
>
> @@ -1512,7 +1529,8 @@ static int uprobe_dispatcher(struct uprobe_consumer=
 *con, struct pt_regs *regs)
>         int ret =3D 0;
>
>         tu =3D container_of(con, struct trace_uprobe, consumer);
> -       tu->nhit++;
> +
> +       this_cpu_inc(*tu->nhits);
>
>         udd.tu =3D tu;
>         udd.bp_addr =3D instruction_pointer(regs);
> --
> 2.43.5
>

