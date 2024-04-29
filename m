Return-Path: <bpf+bounces-28098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DD8B5A8E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744621F21C35
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF97BAF0;
	Mon, 29 Apr 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5c61wun"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112A79950;
	Mon, 29 Apr 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398687; cv=none; b=tCrKyBjbWhBfNJMzSZgxOEBJxkk8q9Ip+DIKRZqVenaqbThaV5z0fC/NxPIhB2WYPEfWfARVlbBKYk6+H9hESLrlZoQ6TB4UPRZ/8M2HRf/wzOatIkacF0dmD/edcfy0EekmJDMNEqbY/3If+zNybHCecCES068RgFc5uvCFbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398687; c=relaxed/simple;
	bh=odyPaTA/NBNHAchzjVqJiP2jl0Yo6XGZMxvJSgkgKFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g8ctb78tfi21m7vlAcrHG4t++pja60ZAEvK9hOrpMMHGwVN2ufL4/nNf/nM3PNoAZkjtjuUQEC0E4X6H3XuIOqsozxEvzle0eHGm1ZaAowhN/veBw8wtDjmfktD9G46XVE+ky9hysArqGteqKXbrUuh5iGGkosVpBvlmMjGyxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5c61wun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68756C4AF17;
	Mon, 29 Apr 2024 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714398686;
	bh=odyPaTA/NBNHAchzjVqJiP2jl0Yo6XGZMxvJSgkgKFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5c61wunqAacEMS3E6c8pNczBD1EAXrrSWT+ABXr2u4rRtaVqjCFUafYO5SbXFmxW
	 Y5buu4FvNHaCyPhdBzpUso/RVCKbtdw4HqV6cN/z8KHV/EQx9G6ALNK/Hzd+kBad0w
	 UU2XvMzysLvE3rbyR2yfbwooMG7W0tgXR4lsmkwLrh/mgnRxA0fYzSk9sK2lkbpZy0
	 Dmw9lA+ExiYpXRJfxa0eHYG5dGPsM1Cm75UZwVdPwHL1p+tCApfzHQUdGGQipGLt60
	 CZjwEEn7rgh6WjCPg0gwv/tRxfyl/y3DxJ99izTnj1eI3STNvt64Ah8GaT9xckdkH8
	 f6rd46qSLti6w==
Date: Mon, 29 Apr 2024 22:51:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240429225119.410833c12d9f6fbcce0a58db@kernel.org>
In-Reply-To: <CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrii,

On Thu, 25 Apr 2024 13:31:53 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Hey Masami,
> 
> I can't really review most of that code as I'm completely unfamiliar
> with all those inner workings of fprobe/ftrace/function_graph. I left
> a few comments where there were somewhat more obvious BPF-related
> pieces.
> 
> But I also did run our BPF benchmarks on probes/for-next as a baseline
> and then with your series applied on top. Just to see if there are any
> regressions. I think it will be a useful data point for you.

Thanks for testing!

> 
> You should be already familiar with the bench tool we have in BPF
> selftests (I used it on some other patches for your tree).

What patches we need?

> 
> BASELINE
> ========
> kprobe         :   24.634 ± 0.205M/s
> kprobe-multi   :   28.898 ± 0.531M/s
> kretprobe      :   10.478 ± 0.015M/s
> kretprobe-multi:   11.012 ± 0.063M/s
> 
> THIS PATCH SET ON TOP
> =====================
> kprobe         :   25.144 ± 0.027M/s (+2%)
> kprobe-multi   :   28.909 ± 0.074M/s
> kretprobe      :    9.482 ± 0.008M/s (-9.5%)
> kretprobe-multi:   13.688 ± 0.027M/s (+24%)

This looks good. Kretprobe should also use kretprobe-multi (fprobe)
eventually because it should be a single callback version of
kretprobe-multi.

> 
> These numbers are pretty stable and look to be more or less representative.
> 
> As you can see, kprobes got a bit faster, kprobe-multi seems to be
> about the same, though.
> 
> Then (I suppose they are "legacy") kretprobes got quite noticeably
> slower, almost by 10%. Not sure why, but looks real after re-running
> benchmarks a bunch of times and getting stable results.

Hmm, kretprobe on x86 should use ftrace + rethook even with my series.
So nothing should be changed. Maybe cache access pattern has been
changed?
I'll check it with tracefs (to remove the effect from bpf related changes)

> 
> On the other hand, multi-kretprobes got significantly faster (+24%!).
> Again, I don't know if it is expected or not, but it's a nice
> improvement.

Thanks!

> 
> If you have any idea why kretprobes would get so much slower, it would
> be nice to look into that and see if you can mitigate the regression
> somehow. Thanks!

OK, let me check it.

Thank you!

> 
> 
> >  51 files changed, 2325 insertions(+), 882 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

