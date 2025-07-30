Return-Path: <bpf+bounces-64737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24364B16632
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCED1AA7084
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56352E093F;
	Wed, 30 Jul 2025 18:26:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724DA1DE4E7;
	Wed, 30 Jul 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899988; cv=none; b=APREyKftwbFZusF4MPHEomyqPRXOew2/egIl0fIbIB3miX88Kbhwd1c3hfN0HvcVx1cBLdk6I/bvSickiphlGjGzvG52y1FlXnvF70vxZM86SfHV8zpIFb63JjlSXFgWRMyl5R1MCeKuM2/hJzKtYigsnJ1QcKUXr6IyBMOdtKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899988; c=relaxed/simple;
	bh=I8VXE60ASwpxlj2aJHTunROXyMJlVkJgK2wvsHBAuaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFWLKPR0d2RQFOtNMUIYHhQozqehCnflb/nmJA6JrtvRypBMQ+qEtT3El206kb1+x0lQG5fjM7n6bQ/QNy4okq1+UG3YeLPlSQnyqh5rjlVibx8ov2kKv4mzDWGY73AfJdf8s6XXfTs9gnAoF4QLaRp3SZd10oSLQVDu8cmpt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEB51BF7;
	Wed, 30 Jul 2025 11:26:17 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A3B3F66E;
	Wed, 30 Jul 2025 11:26:25 -0700 (PDT)
Date: Wed, 30 Jul 2025 19:26:23 +0100
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
Message-ID: <20250730182623.GE143191@e132581.arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
 <fd7c39d2-64b4-480e-8a29-abefcdc7d10a@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7c39d2-64b4-480e-8a29-abefcdc7d10a@intel.com>

Hi Adrian,

On Mon, Jul 28, 2025 at 08:02:51PM +0300, Adrian Hunter wrote:
> On 25/07/2025 12:59, Leo Yan wrote:
> > This series extends Perf for fine-grained tracing by using BPF program
> > to pause and resume AUX tracing. The BPF program can be attached to
> > tracepoints (including ftrace tracepoints and dynamic tracepoints, like
> > kprobe, kretprobe, uprobe and uretprobe).
> 
> Using eBPF to pause/resume AUX tracing seems like a great idea.
> 
> AFAICT with this patch set, there is just support for pause/resume
> much like what could be done directly without eBPF, so I wonder if you
> could share a bit more on how you see this evolving, and what your
> future plans are?

IIUC, here you mean the tool can use `perf probe` to firstly create
probes, then enable tracepoints as PMU event for AUX pause and resume.

I would say a benefit from this series is users can use a single
command to create probes and bind eBPF program for AUX pause and
resume in one go.

To be honest, at current stage, I don't have clear idea for expanding
this feature. But a clear requirement is: AUX trace data usually is
quite huge, after initial analysis, developers might want to focus
on specific function profiling (based on function entry and exit) or
specific period (E.g., start tracing when hit a tracepoing and stop when
hit another tracepoint).

eBPF program is powerful. Basically, we can extend it in two different
dimensions. One direction is we can easily attach the eBPF program to more
kernel modules, like networking, storage, etc. Another direction is to
improve the eBPF program itself as a filter for better fine-grained
tracing, so far we only support limited filtering based on CPU ID or PID,
we also can extend the filtering based on time, event types, etc.

Thanks,
Leo

