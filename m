Return-Path: <bpf+bounces-38894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE096C1A5
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69D01F2A76B
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE271DC723;
	Wed,  4 Sep 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+k29TYr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE21CF7AE;
	Wed,  4 Sep 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462168; cv=none; b=JOcGIG0dlPg+4BJKwJeCG2ZcAGQuQXtlGhLIdimbGAhtymi1x8a7ye7TbNbF37vLmNR3qk+p49KOFm6DYvPEJXjiWuKirRlN4wlqi5XgMofUZEQgG//d3FHg/VxzIF2e4ReV/qpOgnysHcJL6Q/tNtWJ/vQcxBxKeBODrxGNNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462168; c=relaxed/simple;
	bh=YymxA90uLDffbMQSSxTy3XJ/qBHNozuAOEdyuVSdT9k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g7LoXbtmbtIkMwt0hNrxMb0oJ4Pid5BQPSaaZLni4icuDSTCLJnSVjZpN+Tge8BxS5IK+iWTUqnjzvJcXUsfijjHTZ8LoJQ57S59ouymKutFWYO+/PBqHeLNYL9TMPgDyEbxXx2PxdDbMmXD9Hs0/mjc0UZPYAr2WBtfivLHdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+k29TYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A98C4CEC2;
	Wed,  4 Sep 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725462168;
	bh=YymxA90uLDffbMQSSxTy3XJ/qBHNozuAOEdyuVSdT9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r+k29TYryGIW2p5y43JK6E91RZ05wnlp7zpF9RXzZKqev0nszXnWGQveoTldrpPav
	 W3SyS3cZBDjj8oTeYVUl/0xKiE09ZvA19Hqwlg+oi6oWJefmUY9yKfr1UiadBpt+2I
	 fz6yAA+O4ZYBF5udPDFnh16pEJzhs8lNt51Txk/o0oxK5wSok7UhZ6TVmR7vxfGzgB
	 a+pumtrCKQ8ZpBVUg1a2Yx5+DiXej/tBEHuz2X41VNzOoW8F/xnfO8wxLPf6QAPiVR
	 mssjS9gR8f9ZNMlcHBG/dx4CmCCy61yUfoIaYK9DcL3FHDIEYB7Pxs40Y/siXrTV1L
	 RSynTMwTZVsrw==
Date: Thu, 5 Sep 2024 00:02:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, peterz@infradead.org, oleg@redhat.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v3] uprobes: turn trace_uprobe's nhit counter to be
 per-CPU one
Message-Id: <20240905000243.c8549b30be33a3ad73eabf05@kernel.org>
In-Reply-To: <CAEf4BzbHuHPuLHT5E619crJ1Gdvr8LnQpR7w=vrx8Gb6NHAeZA@mail.gmail.com>
References: <20240813203409.3985398-1-andrii@kernel.org>
	<20240828125418.07c3c63e08dc688e62fef4d2@kernel.org>
	<CAEf4BzbHuHPuLHT5E619crJ1Gdvr8LnQpR7w=vrx8Gb6NHAeZA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 10:28:24 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Aug 27, 2024 at 8:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 13 Aug 2024 13:34:09 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > trace_uprobe->nhit counter is not incremented atomically, so its value
> > > is questionable in when uprobe is hit on multiple CPUs simultaneously.
> > >
> > > Also, doing this shared counter increment across many CPUs causes heavy
> > > cache line bouncing, limiting uprobe/uretprobe performance scaling with
> > > number of CPUs.
> > >
> > > Solve both problems by making this a per-CPU counter.
> > >
> >
> > Looks good to me. Let me pick it to linux-trace probes/for-next.
> >
> 
> Thanks! I just checked linux-trace repo, doesn't seem like this was
> applied yet, is that right? Or am I checking in the wrong place?

Sorry, I missed to push probes/for-next. Let me push it.

Thank you,

> 
> > Thank you,
> >
> >
> > > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/trace/trace_uprobe.c | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > > index c98e3b3386ba..c3df411a2684 100644
> > > --- a/kernel/trace/trace_uprobe.c
> > > +++ b/kernel/trace/trace_uprobe.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/string.h>
> > >  #include <linux/rculist.h>
> > >  #include <linux/filter.h>
> > > +#include <linux/percpu.h>
> > >
> > >  #include "trace_dynevent.h"
> > >  #include "trace_probe.h"
> > > @@ -62,7 +63,7 @@ struct trace_uprobe {
> > >       char                            *filename;
> > >       unsigned long                   offset;
> > >       unsigned long                   ref_ctr_offset;
> > > -     unsigned long                   nhit;
> > > +     unsigned long __percpu          *nhits;
> > >       struct trace_probe              tp;
> > >  };
> > >
> > > @@ -337,6 +338,12 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
> > >       if (!tu)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > > +     tu->nhits = alloc_percpu(unsigned long);
> > > +     if (!tu->nhits) {
> > > +             ret = -ENOMEM;
> > > +             goto error;
> > > +     }
> > > +
> > >       ret = trace_probe_init(&tu->tp, event, group, true, nargs);
> > >       if (ret < 0)
> > >               goto error;
> > > @@ -349,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
> > >       return tu;
> > >
> > >  error:
> > > +     free_percpu(tu->nhits);
> > >       kfree(tu);
> > >
> > >       return ERR_PTR(ret);
> > > @@ -362,6 +370,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
> > >       path_put(&tu->path);
> > >       trace_probe_cleanup(&tu->tp);
> > >       kfree(tu->filename);
> > > +     free_percpu(tu->nhits);
> > >       kfree(tu);
> > >  }
> > >
> > > @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
> > >  {
> > >       struct dyn_event *ev = v;
> > >       struct trace_uprobe *tu;
> > > +     unsigned long nhits;
> > > +     int cpu;
> > >
> > >       if (!is_trace_uprobe(ev))
> > >               return 0;
> > >
> > >       tu = to_trace_uprobe(ev);
> > > +
> > > +     nhits = 0;
> > > +     for_each_possible_cpu(cpu) {
> > > +             nhits += per_cpu(*tu->nhits, cpu);
> > > +     }
> > > +
> > >       seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> > > -                     trace_probe_name(&tu->tp), tu->nhit);
> > > +                trace_probe_name(&tu->tp), nhits);
> > >       return 0;
> > >  }
> > >
> > > @@ -1512,7 +1529,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> > >       int ret = 0;
> > >
> > >       tu = container_of(con, struct trace_uprobe, consumer);
> > > -     tu->nhit++;
> > > +
> > > +     this_cpu_inc(*tu->nhits);
> > >
> > >       udd.tu = tu;
> > >       udd.bp_addr = instruction_pointer(regs);
> > > --
> > > 2.43.5
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

