Return-Path: <bpf+bounces-63221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC065B046D0
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D484A374E
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A425F797;
	Mon, 14 Jul 2025 17:45:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379C625F97F;
	Mon, 14 Jul 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515111; cv=none; b=JhVCHTkN64eBWWLTTKj69W+rDBpcHY31vdZy20zx25MgwUQhK8lnfX7vsq0SJ4NOL4kVnz3tWFxL/60t3QYYvyGnu3PzSjXMXzXI49INOCXH4TVPrQsmzwNlUvOFWbUoTru0Ir0XsTRR9Avy9bjxQDaIzryqpL5vzemmnFQVWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515111; c=relaxed/simple;
	bh=SsN6wdwjXMhhB3HBPP8qMeDnvJahGIOcFyVHDWp0hDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvGUjd3HV8T7r61SPdf8wkWq0b4TQL2d7WJM2hvd4AKcVC4ieNQJtN4p6UxF+R82E/NWoga25zcI5FKgtjm829uOVFPa46iCh02/Ykh746A3GYmhGU/eB4hF/uQvcVXRA7awpfbXwDEFilapuD9CDQW0PPimA+dFK6QgpdPtVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9C61764;
	Mon, 14 Jul 2025 10:44:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A39843F66E;
	Mon, 14 Jul 2025 10:45:07 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:45:05 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
Message-ID: <20250714174505.GA3020098@e132581.arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
 <20241215193436.275278-3-leo.yan@arm.com>
 <80f412f1-a060-463b-9034-3128906e6929@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f412f1-a060-463b-9034-3128906e6929@linux.dev>

Hi Yonghong,

Really sorry for the long delay. Now I am restarting this work.

On Mon, Dec 16, 2024 at 09:21:15AM -0800, Yonghong Song wrote:
> On 12/15/24 11:34 AM, Leo Yan wrote:
> > The bpf_perf_event_aux_pause kfunc will be used to control the Perf AUX
> > area to pause or resume.
> > 
> > An example use-case is attaching eBPF to Ftrace tracepoints.  When a
> > tracepoint is hit, the associated eBPF program will be executed.  The
> > eBPF program can invoke bpf_perf_event_aux_pause() to pause or resume
> > AUX trace.  This is useful for fine-grained tracing by combining
> > Perf and eBPF.
> > 
> > This commit implements the bpf_perf_event_aux_pause kfunc, and make it
> > pass the eBPF verifier.
> 
> The subject and commit message mentions to implement a kfunc,
> but actually you implemented a uapi helper. Please implement a kfunc
> instead (searching __bpf_kfunc in kernel/bpf directory).

After some research, my understanding is that kfunc is flexible for
exposing APIs via BTF, whereas BPF_CALL is typically used for core BPF
features - such as accessing BPF maps.

Coming back to this patch: it exposes a function with the following
definition:

  int bpf_perf_event_aux_pause(struct bpf_map *map, u64 flags, u32 pause);

I'm not certain whether using __bpf_kfunc is appropriate here, or if I
should stick to BPF_CALL to ensure support for accessing bpf_map
pointers?

Thanks,
Leo

