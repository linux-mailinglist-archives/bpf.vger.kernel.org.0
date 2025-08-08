Return-Path: <bpf+bounces-65263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9475B1E7AC
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8531623A53
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE0275AE0;
	Fri,  8 Aug 2025 11:47:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852262750E5;
	Fri,  8 Aug 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653660; cv=none; b=UeL7F5nAH77wMORWhbkpm2nTUF8bQMdPhm0mLW/tzAEOXwvYCPFwoXccGM9VNYeBlX9e5WurSH4tSzGb3AOhGOgpAxHRmFcIPQ0Iyulr6LT90qU0/xbkDJxj5+3cdC4BVLdoIIOqo7Chmf0ygN9AyXz0cIGbKygtnT4MUgYR86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653660; c=relaxed/simple;
	bh=fw0LMFAx6/CelKIeGgsPTOu4keOgrwh72hmn0s1QYnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAMsMJey+xauUicgPRJndYf+xF6GA2omgsqjK1/H1QXrZDB/0t+auhvXEkY+8WS1kLCh42of82mknYI1hOI+TkUH3okuThBdaguOzQ8FK9ROIBvbaZeS5WN7JGg4P9KcB1u4DCZNd6Vbdcj8FOZUF+M3Q6A2fAOPXVIeRYze1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72FF016F8;
	Fri,  8 Aug 2025 04:47:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290483F673;
	Fri,  8 Aug 2025 04:47:36 -0700 (PDT)
Date: Fri, 8 Aug 2025 12:47:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
Message-ID: <20250808114734.GB3420125@e132581.arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
 <fd7c39d2-64b4-480e-8a29-abefcdc7d10a@intel.com>
 <20250730182623.GE143191@e132581.arm.com>
 <0a0ed9d4-6511-4f0b-868f-22a3f95697f8@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0ed9d4-6511-4f0b-868f-22a3f95697f8@intel.com>

On Tue, Aug 05, 2025 at 10:16:29PM +0300, Adrian Hunter wrote:
> On 30/07/2025 21:26, Leo Yan wrote:
> > Hi Adrian,
> > 
> > On Mon, Jul 28, 2025 at 08:02:51PM +0300, Adrian Hunter wrote:
> >> On 25/07/2025 12:59, Leo Yan wrote:
> >>> This series extends Perf for fine-grained tracing by using BPF program
> >>> to pause and resume AUX tracing. The BPF program can be attached to
> >>> tracepoints (including ftrace tracepoints and dynamic tracepoints, like
> >>> kprobe, kretprobe, uprobe and uretprobe).
> >>
> >> Using eBPF to pause/resume AUX tracing seems like a great idea.
> >>
> >> AFAICT with this patch set, there is just support for pause/resume
> >> much like what could be done directly without eBPF, so I wonder if you
> >> could share a bit more on how you see this evolving, and what your
> >> future plans are?
> > 
> > IIUC, here you mean the tool can use `perf probe` to firstly create
> > probes, then enable tracepoints as PMU event for AUX pause and resume.
> 
> Yes, like:
> 
> $ sudo perf probe 'do_sys_openat2 how->flags how->mode'
> Added new event:
>   probe:do_sys_openat2 (on do_sys_openat2 with flags=how->flags mode=how->mode)
> 
> You can now use it in all perf tools, such as:
> 
>         perf record -e probe:do_sys_openat2 -aR sleep 1
> 
> $ sudo perf probe do_sys_openat2%return
> Added new event:
>   probe:do_sys_openat2__return (on do_sys_openat2%return)
> 
> You can now use it in all perf tools, such as:
> 
>         perf record -e probe:do_sys_openat2__return -aR sleep 1
> 
> $ sudo perf record --kcore -e intel_pt/aux-action=start-paused/k -e probe:do_sys_openat2/aux-action=resume/ --filter='flags==0x98800' -e probe:do_sys_openat2__return/aux-action=pause/ -- ls

Thanks a lot for sharing the commands. I was able to replicate them
using CoreSight.

Given that we can achieve the same result without using BPF, I am not
sure how useful this series is. It may give us a base for exploring
profiling that combines AUX trace and BPF, but I am fine with holding
on until we have clear requirements for it.

I would get suggestion from you and maintainers before proceeding
further.

Thanks,
Leo

