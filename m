Return-Path: <bpf+bounces-7225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A240773ACA
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C9281874
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5912B81;
	Tue,  8 Aug 2023 14:53:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AB12B6C
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26319C433CA;
	Tue,  8 Aug 2023 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691506432;
	bh=uwQnu9f4p3k5CfpSJXtgO6zZRF7NC7rvvkAoWiX73N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kWWVkBumS+i71Op3410bY/vV7U4C2J0z4eah/iV9yVXuMEHBAInHVfSo4Vr8Nn/ho
	 Ux2la/urUI7czt+QMS6s1RA5yhJPj7y0SZpiKrz1ARokPd2lWBarZnEnFD71VVQ83w
	 3jM0Ns1O5gvK/o5iGJKSf8W3tipPUS2Z3zzGfX78wzMqXx+iNmGCNpXGRE1yfT7zlj
	 rgCrpabu2SiqpwN5eryt+ZL2AzRMU4o+rcCAt8jVFMbe8cqhvIH/tCW64EBDMl67O4
	 jzw74Yy57/LlxPOXFlUY7vCvPCt6B6mQiU/Z6g6xF6pZjhURJr+Z6ASCpAsb7ZIn3l
	 t6SApgn6cNcWw==
Date: Tue, 8 Aug 2023 23:53:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
Message-Id: <20230808235346.fdd76875c71f0806773fad74@kernel.org>
In-Reply-To: <CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 8 Aug 2023 16:29:27 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > Florent, feel free to add your rethook for arm64, but please do not remove
> > kretprobe trampoline yet. It is another discussion point. We may be possible
> > to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
> > allows nest probe. (maybe we can skip that case?)
> 
> Ack :)
> 
> >  arch/Kconfig                    |    1 +
> >  arch/arm64/include/asm/ftrace.h |   11 ++++++
> >  arch/loongarch/Kconfig          |    1 +
> >  arch/s390/Kconfig               |    1 +
> >  arch/x86/Kconfig                |    1 +
> >  arch/x86/kernel/rethook.c       |    9 +++--
> >  include/linux/fprobe.h          |    4 +-
> >  include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
> >  include/linux/rethook.h         |   11 +++---
> >  kernel/kprobes.c                |    9 ++++-
> >  kernel/trace/Kconfig            |    9 ++++-
> >  kernel/trace/bpf_trace.c        |   14 +++++--
> >  kernel/trace/fprobe.c           |    8 ++--
> >  kernel/trace/rethook.c          |   16 ++++----
> >  kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------------
> >  kernel/trace/trace_probe_tmpl.h |    2 +
> >  lib/test_fprobe.c               |   10 +++--
> >  samples/fprobe/fprobe_example.c |    4 +-
> 
> I believe that Documentation/trace/fprobe.rst should also be modified
> following the API change

Indeed. Let me update it.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

