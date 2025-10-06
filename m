Return-Path: <bpf+bounces-70438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38123BBF211
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 21:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3BA3BC947
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728152D7DF3;
	Mon,  6 Oct 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiatnbsA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E114885D;
	Mon,  6 Oct 2025 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780677; cv=none; b=AMPybufbDBPauAXsPTzgkXNq72SMQpJNnRfs1mJzYm4H6+kcMwMin4gp0v5DNJJVO1vjjKk6NeaOq6XIP4OAssZ1gdyuAUomtIwq2DuG9x0zOJ0n1oVzhaK0X6TRtvy8z2HnF3NSF9I4O2GB5WJ76/sPLVG3sHFlcwGmCaFxEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780677; c=relaxed/simple;
	bh=qZdlfvx4NHVgS3zK5rCX3pUDSLdi/H8kB8dmIyAMjo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXziqvjOBjyFe5rtXawAl/h+LBCUbqTkQ8gWYOMaljZDXD9PbENfqZIN7cgv91H5PwXNl7t+KPJo7Pt3wcROiqunmfYd1EK0xYVZZ0iwBHqXpTNegoBxh5CpYGInya6bk44fYtPgmzISq/zkabUbIhE7Hl0X8Ng7888ZA8MvMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiatnbsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FF3C4CEF5;
	Mon,  6 Oct 2025 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759780676;
	bh=qZdlfvx4NHVgS3zK5rCX3pUDSLdi/H8kB8dmIyAMjo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiatnbsAO1zIsKeKGvIXzf6cGeSzaMyFMTXyFbdQls4B2r2NwUmvRdyI06BB8gOrC
	 lsaU7IjLVi2kMY3pXczGwqIGjD74hXfHCbKyNXUcLUdxi7hu/EMBgTH1V4pADks0Nz
	 tbDzw3MuxNC8/4mSllBp6K8XMCJ/J55K3TjfWfmjDNbO/eLyQhOYKhZvQtU02sclsE
	 SGx8+T3oNEIa/tXsTDINd7SrxB6sMMAG8QMIOode67zWqtFZxKhiMV52FkEn31ql3u
	 R5x1SSBJrSIVvaFRCU3BF9Ng+LS8pRONHRZ3DEboch9T9dykOUSd4I3+zKAfaHcxXF
	 VPApBDZsmO5bg==
Date: Mon, 6 Oct 2025 16:57:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing
 hybrid
Message-ID: <aOQfQW5WODbioEiA@x1>
References: <20251001181229.1010340-1-irogers@google.com>
 <20251001181229.1010340-2-irogers@google.com>
 <CAP-5=fVHetc8DqdqxURJm_VtaH6apJKoyVOSpfQrE2ntkEa+4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVHetc8DqdqxURJm_VtaH6apJKoyVOSpfQrE2ntkEa+4g@mail.gmail.com>

On Mon, Oct 06, 2025 at 09:18:22AM -0700, Ian Rogers wrote:
> On Wed, Oct 1, 2025 at 11:12 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Don't open evsels on all CPUs, open them just on the CPUs they
> > support. This avoids opening say an e-core event on a p-core and
> > getting a failure - achieve this by getting rid of the "all_cpu_map".
> >
> > In install_pe functions don't use the cpu_map_idx as a CPU number,
> > translate the cpu_map_idx, which is a dense index into the cpu_map
> > skipping holes at the beginning, to a proper CPU number.
> >
> > Before:
> > ```
> > $ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >    <not supported>      cpu_atom/cycles/
> >        566,270,672      cpu_core/cycles/
> >    <not supported>      cpu_atom/instructions/
> >        572,792,836      cpu_core/instructions/           #    1.01  insn per cycle
> >
> >        1.001595384 seconds time elapsed
> > ```
> >
> > After:
> > ```
> > $ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >        443,299,201      cpu_atom/cycles/
> >      1,233,919,737      cpu_core/cycles/
> >        213,634,112      cpu_atom/instructions/           #    0.48  insn per cycle
> >      2,758,965,527      cpu_core/instructions/           #    2.24  insn per cycle
> >
> >        1.001699485 seconds time elapsed
> > ```
> >
> > Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> +Thomas Falcon
> 
> I think it'd be nice to get this quite major fix for
> --bpf-counters/bperf for hybrid architectures into v6.18 and stable
> builds. Thomas would it be possible for you to give a Tested-by tag
> using the reproduction in the commit message?

Its even already in linux-next:

⬢ [acme@toolbx perf-tools-next]$ git log -5 --oneline linux-next/master tools/perf/util/bpf_counter.c
b91917c0c6fa6df9 perf bpf_counter: Fix handling of cpumap fixing hybrid
8c519a825b4add85 perf bpf_counter: Move header declarations into C code
07dc3a6de33098b0 perf stat: Support inherit events during fork() for bperf
effe957c6bb70cac libperf cpumap: Replace usage of perf_cpu_map__new(NULL) with perf_cpu_map__new_online_cpus()
b84b3f47921568a8 perf bpf_counter: Fix a few memory leaks
⬢ [acme@toolbx perf-tools-next]$

