Return-Path: <bpf+bounces-38782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE7696A223
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC91D28234E
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47236F30D;
	Tue,  3 Sep 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDFXK/p7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055B22EE5;
	Tue,  3 Sep 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376721; cv=none; b=TcvMvL9LpzWZKpT0YpIhSB8Q8DHfRjwJWfnrc0R8oz3TcuK51O7xNSC+Vh5RfzuHvfInAkEGp44UEr7IqJaAGf/+Y9n9lGAOuLpi0t6ET+CSW11I3qnz5eVD2zuM9tn2/MzZZZhlvpYtBzTqRwtoJ6E3tNwHWiOM/PEa+2W8oo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376721; c=relaxed/simple;
	bh=2z43npMWeb2qk5CIDIRw0W+N2lQ4P58mK0pr8KfONrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBq3fft08UpNsTDpfVjH9RuH7nQWCwm8uKeZTGg050WYpyFupS92vtASL0icSb4A7Yy+ngBXd2qr30/7mz0sFs12uJ/QktraHmDBSQqW5/NiAYJznjGg/ajRwbBe7U2a+VKN7Sy6kgL9wRKf7YmxbW7vsEGLTshcWvv9sT9Iymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDFXK/p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4943C4CEC4;
	Tue,  3 Sep 2024 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376720;
	bh=2z43npMWeb2qk5CIDIRw0W+N2lQ4P58mK0pr8KfONrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDFXK/p7nUPdbpuMX3mokRDZjPXIFvaMKU4ud9LXIw7khRgwqvk0+pUNRiITxXNuE
	 z2OqP3AQBRHeY9DUriIoTMJuQznJ8egQKsYuVREVeLYNhMtqhYSDUZfL7cw1NUTFhW
	 Jof1j6yiJalulasvhHWbXtBsRLojnewdngO30Y+xzjiJnaK5W6AC5DoGtZr2+gMbdy
	 6wgvfcSdqqYWN7mquV/Y03vvHU9Mi4iz/pjnTG6DOySp2Dx674PeWU8J0Mxpl0op7Q
	 8hPeQ5gBllK6+wtFwLstWGA8kGjUa4AwgaOW4PUyJ768CAF20TXfjNxwKx72J8OHx0
	 qHGrTQDUxg0lQ==
Date: Tue, 3 Sep 2024 12:18:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/5] perf tools: Constify BPF control data properly
 (v1)
Message-ID: <ZtcozBEf_RItlB9Y@x1>
References: <20240902200515.2103769-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902200515.2103769-1-namhyung@kernel.org>

On Mon, Sep 02, 2024 at 01:05:10PM -0700, Namhyung Kim wrote:
> Hello,
> 
> I've realized that some control data (usually for filter actions)
> should be defined as 'const volatile' so that it can passed to the BPF
> core and to be optimized properly (like with dead code elimination).
> 
> Convert the existing codes with the similar patterns.

Thanks, tested all the features using BPF, applied to perf-tools-next,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (5):
>   perf stat: Constify control data for BPF
>   perf ftrace latency: Constify control data for BPF
>   perf kwork: Constify control data for BPF
>   perf lock contention: Constify control data for BPF
>   perf record offcpu: Constify control data for BPF
> 
>  tools/perf/util/bpf_counter_cgroup.c          |  6 +--
>  tools/perf/util/bpf_ftrace.c                  |  8 ++--
>  tools/perf/util/bpf_kwork.c                   |  9 ++--
>  tools/perf/util/bpf_kwork_top.c               |  7 +--
>  tools/perf/util/bpf_lock_contention.c         | 45 ++++++++++---------
>  tools/perf/util/bpf_off_cpu.c                 | 16 +++----
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c   |  2 +-
>  tools/perf/util/bpf_skel/func_latency.bpf.c   |  7 +--
>  tools/perf/util/bpf_skel/kwork_top.bpf.c      |  2 +-
>  tools/perf/util/bpf_skel/kwork_trace.bpf.c    |  5 ++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 27 +++++------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c        |  9 ++--
>  12 files changed, 76 insertions(+), 67 deletions(-)
> 
> -- 
> 2.46.0.469.g59c65b2a67-goog

