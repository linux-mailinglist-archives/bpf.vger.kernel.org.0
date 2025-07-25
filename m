Return-Path: <bpf+bounces-64360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9DB11C16
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25C95A554F
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170D2DE6F3;
	Fri, 25 Jul 2025 10:16:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677561EE03B;
	Fri, 25 Jul 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438581; cv=none; b=HAYCph5ufzLnPmdT6CoiFgmDD43fh763b7BWrT94Wl7YAx89hvRbrahYLsnVFyV9jQM/itOYLDiykGKwvqEKE2XGl4KUWypnXq0n6bw9+0L7yYhg0BObRj8D1F13zmnUmJBU5NlEASvqPLtzmZG6j8Ni2Z5bh1O21RyGl/UT/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438581; c=relaxed/simple;
	bh=bBvDU0/nAl16eDM+UvA8fshEVWPs5dN2UNTysgLef8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmeuDBY3zMEy3DGRgqa4rceaGHxcrwOOSBXymTQiDqF3PJWaOBRxjG01HvHBfbK6BWfeJ48qhJg+UIVbY4cKizwScB4Iof+nCDpEGPkPDoKc3ihke6y+YHtnrQJs6F21mT8s02iFTXxIoP1I/g/3e2cSd/r722+Wi7COkwWVw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03D2D1756;
	Fri, 25 Jul 2025 03:16:13 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6EB3F5A1;
	Fri, 25 Jul 2025 03:16:19 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:16:17 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	KP Singh <kpsingh@kernel.org>,
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
	Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
Message-ID: <20250725101617.GA143191@e132581.arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>

Hi all,

On Fri, Jul 25, 2025 at 10:59:09AM +0100, Leo Yan wrote:
> This series extends Perf for fine-grained tracing by using BPF program
> to pause and resume AUX tracing. The BPF program can be attached to
> tracepoints (including ftrace tracepoints and dynamic tracepoints, like
> kprobe, kretprobe, uprobe and uretprobe).

Due to stale prefixes in my local b4 configuration, the version number
in this series is mess.

I have resent v3 [1], please kindly review the resent version. Sorry
for inconvenience.

Leo

[1] https://lore.kernel.org/linux-perf-users/20250725-perf_aux_pause_resume_bpf_rebase-v3-0-ae21deb49d1a@arm.com/T/#mb884408efc23dc7013b925e65fe4eeb051b97c7f

