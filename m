Return-Path: <bpf+bounces-38425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E745C964CBB
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C691C220F6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEDF1B654B;
	Thu, 29 Aug 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaZ4j7Jd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EC146A96;
	Thu, 29 Aug 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952518; cv=none; b=qJmDaxWorMdwsvZaOTE+kEj8jsLDSRkTw7XfwFyOZnRcZJEgeLxLk+NEpgl763Fg6dcWPofdpFhhd6lwXwgsjksayaa8zMqrdlzuRD6ZcAzSRXi7FYHGImkKuk1xHpMfyD6pf0QtzUNZASA+Ub4thAvnNglZMmPjZUwOVXpnvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952518; c=relaxed/simple;
	bh=KJKoUfWUoMAHUQHg5Fy0b3Mzd2sRhvl7cmJ2Y9HGAoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sw5OrMEd4qiUzHwsAckaTAoLFsk75iou5ETZiq9G890dDbGHf2Ug1MJwpkNqzsLrMulUewcQzNulYSAkHGg9l2ZD7Z/OtJJHpiRN5G/GNt/BzyNemKox6F8nLBq3NpyUmhW/QtkTob/fsUWY7XKsFrVmg/4OG0nUbMWIq0c6jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaZ4j7Jd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so575448a12.3;
        Thu, 29 Aug 2024 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724952516; x=1725557316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHtTBbzeYQ0PhvAJXeu6V6EJfe+INUGk7sZpaNX20bs=;
        b=gaZ4j7JdqeP+aTOB9mDQtq39X2oloBwWLt+kLzILOiIeQbPUHwRXvBMxj15gnG0FX5
         m464HLDoMtTAfbcu/F0UUUAS39H9INmvEzC2JKLAvl+6fFtI4ButbfAAEwZ5HfQyDbMj
         r/pUp+INcUxdFeQNS1EPKBaY7wWKjzqLImuoqXxxPTxLWU5sWF1nk+Jzss5DUy5W1AxW
         Osn9cx8+kKWw/m8yIszPeC8DzTNF6gnmIvFCvUfLNc2x33J565oFRF/fo1PdgrMBCMIk
         t7nJpeRl4N5+9HVD1A/Vghjlb2oot1wQXfRBqK8uwsU80ZXZ5qXS+dXB4jToV+xHdfCl
         QbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724952516; x=1725557316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHtTBbzeYQ0PhvAJXeu6V6EJfe+INUGk7sZpaNX20bs=;
        b=lEgjVuweoZEoEjmsx0hSFFbrH/YreakorPex8zmzxWN2Z0cQYx1aHkWZFrxVw9JCtx
         zDcM0AtMc5rV4TaI8AMEMcZQHONuSwdCfInpGnfTcCFKx+ReL+VmbfZKiqAZpEwGaJx7
         VjeeEby+M0uNwHQieKJ5VtnlluXq5H/cRQgymvS2KsDI4I+3M8UfKRSkn0P6GcSvwHlb
         oau3IB98X3YgQjqqYVRxJ5LU9fr1S3JHFzhZ1ZhW26lrkdj1UB25nATLc+X+uitbTwKs
         HHgJcLeYMvmV2yGy8+JnN48gRHcCAyq/znIKhFgpZQ+giT3IBI2taFdUzbG/vJ6H3Te1
         aB3w==
X-Forwarded-Encrypted: i=1; AJvYcCVPZUnImHgpR74XKEQ8S4Nn5rpBG52gyo3trKUqVBMT1OlALzd1dYmaFFxwAByNl9Y/deUAQRvWQs+is207SROk9Skd@vger.kernel.org, AJvYcCWOpX7dmDRwg3+Bw0hxmONeZtD6mSDLWA8cdzCtSwsctL4r2jRWnySFt70BNuiKIqz/LIc=@vger.kernel.org, AJvYcCX0wO1Itl5KJnOHdpu7WfJHyr0l2tVtU/RD2Z+G06yBlKmvtkzJ16PVfvkSLxVsh8GWgBdX/cLOd0qTZkpP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/m1RYN3Ox7QNTdmUCtmn34OMi3UFrHEEKI/FTmcvnJ7Zr2RJ
	SD4w9HBUaV2UyuxWiosopK4OgkaLRsjDuq+WHQZPr0seqUFzFa9/lQfPxh8k49Fd6VbTfFXqQuY
	pX3KXVyWGkwS12XchF7Tdx+9BKXw=
X-Google-Smtp-Source: AGHT+IHFSsyIXZBp/wN1WeIfBQIX6SXXWbfTEQ+vV3dVVPuTZikp/jdnt41Q1uEUqofGNYCJ3J6pvEG0iPugoozqPs8=
X-Received: by 2002:a17:90b:4b45:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2d85618168dmr4248026a91.1.1724952515912; Thu, 29 Aug 2024
 10:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813203409.3985398-1-andrii@kernel.org> <20240828125418.07c3c63e08dc688e62fef4d2@kernel.org>
In-Reply-To: <20240828125418.07c3c63e08dc688e62fef4d2@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Aug 2024 10:28:24 -0700
Message-ID: <CAEf4BzbHuHPuLHT5E619crJ1Gdvr8LnQpR7w=vrx8Gb6NHAeZA@mail.gmail.com>
Subject: Re: [PATCH v3] uprobes: turn trace_uprobe's nhit counter to be
 per-CPU one
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, peterz@infradead.org, oleg@redhat.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 8:55=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 13 Aug 2024 13:34:09 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > trace_uprobe->nhit counter is not incremented atomically, so its value
> > is questionable in when uprobe is hit on multiple CPUs simultaneously.
> >
> > Also, doing this shared counter increment across many CPUs causes heavy
> > cache line bouncing, limiting uprobe/uretprobe performance scaling with
> > number of CPUs.
> >
> > Solve both problems by making this a per-CPU counter.
> >
>
> Looks good to me. Let me pick it to linux-trace probes/for-next.
>

Thanks! I just checked linux-trace repo, doesn't seem like this was
applied yet, is that right? Or am I checking in the wrong place?

> Thank you,
>
>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/trace/trace_uprobe.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index c98e3b3386ba..c3df411a2684 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/string.h>
> >  #include <linux/rculist.h>
> >  #include <linux/filter.h>
> > +#include <linux/percpu.h>
> >
> >  #include "trace_dynevent.h"
> >  #include "trace_probe.h"
> > @@ -62,7 +63,7 @@ struct trace_uprobe {
> >       char                            *filename;
> >       unsigned long                   offset;
> >       unsigned long                   ref_ctr_offset;
> > -     unsigned long                   nhit;
> > +     unsigned long __percpu          *nhits;
> >       struct trace_probe              tp;
> >  };
> >
> > @@ -337,6 +338,12 @@ alloc_trace_uprobe(const char *group, const char *=
event, int nargs, bool is_ret)
> >       if (!tu)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     tu->nhits =3D alloc_percpu(unsigned long);
> > +     if (!tu->nhits) {
> > +             ret =3D -ENOMEM;
> > +             goto error;
> > +     }
> > +
> >       ret =3D trace_probe_init(&tu->tp, event, group, true, nargs);
> >       if (ret < 0)
> >               goto error;
> > @@ -349,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *e=
vent, int nargs, bool is_ret)
> >       return tu;
> >
> >  error:
> > +     free_percpu(tu->nhits);
> >       kfree(tu);
> >
> >       return ERR_PTR(ret);
> > @@ -362,6 +370,7 @@ static void free_trace_uprobe(struct trace_uprobe *=
tu)
> >       path_put(&tu->path);
> >       trace_probe_cleanup(&tu->tp);
> >       kfree(tu->filename);
> > +     free_percpu(tu->nhits);
> >       kfree(tu);
> >  }
> >
> > @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_fil=
e *m, void *v)
> >  {
> >       struct dyn_event *ev =3D v;
> >       struct trace_uprobe *tu;
> > +     unsigned long nhits;
> > +     int cpu;
> >
> >       if (!is_trace_uprobe(ev))
> >               return 0;
> >
> >       tu =3D to_trace_uprobe(ev);
> > +
> > +     nhits =3D 0;
> > +     for_each_possible_cpu(cpu) {
> > +             nhits +=3D per_cpu(*tu->nhits, cpu);
> > +     }
> > +
> >       seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> > -                     trace_probe_name(&tu->tp), tu->nhit);
> > +                trace_probe_name(&tu->tp), nhits);
> >       return 0;
> >  }
> >
> > @@ -1512,7 +1529,8 @@ static int uprobe_dispatcher(struct uprobe_consum=
er *con, struct pt_regs *regs)
> >       int ret =3D 0;
> >
> >       tu =3D container_of(con, struct trace_uprobe, consumer);
> > -     tu->nhit++;
> > +
> > +     this_cpu_inc(*tu->nhits);
> >
> >       udd.tu =3D tu;
> >       udd.bp_addr =3D instruction_pointer(regs);
> > --
> > 2.43.5
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

