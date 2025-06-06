Return-Path: <bpf+bounces-59917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C1AD0872
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984493B45EF
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5F1F5413;
	Fri,  6 Jun 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBTFSRIm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899461E32CF;
	Fri,  6 Jun 2025 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236556; cv=none; b=kYpQGWt3wTaNJGwK6zYRVGqLyykLa/IMDofjVBwv2Ia1ouqMwrST5rQtMbuX+PgcP4lgcZAq5hPMyjSNWvuOmpC5CkZNdkTMrBM47pp1O/WKBhyVKHi536Q20vMB8qnf2jBSI0GaNp10yUDsJMLBxcDwJeZRS4ivJu2ujlxobQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236556; c=relaxed/simple;
	bh=a4zS+f4/L3VUhoY85jKW59MyAD/HA3R1PKujB+DYmJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eoh8A+iDEnC7DEAFpcsZpx/c1g24fTmFoRi0UBBIH5gXYhiEO9sc74c+9Och/ruJXKC3cgmySER/0lPL1DS4laQHUFNFfS2pzTyBGC3QpJ7gMGymuzgIoC4244Cq+6zsqN+dgnxGvSrPb/bW43Cz1b6gyMTp+6qdjpyVOUhnNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBTFSRIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F37C4CEEE;
	Fri,  6 Jun 2025 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749236556;
	bh=a4zS+f4/L3VUhoY85jKW59MyAD/HA3R1PKujB+DYmJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBTFSRImwUhWTqHbK3GfkpIJqT2MWRLvOL4xH3c7LmW34WhWjxRKRo0mZxD+Hd3b1
	 no+GIK+ZbTIdtrj6/Jm+3yEgNxfLjMNQhTn+GhHIq6jrHc9buqX4II2lMNv1FvFWkj
	 +bv4HHrfouLV/lZXaH7d7grOHFeBUgtFLM6xgv9Ht4nmse9RQoPI7eY2iBGLdmg5/B
	 DBZ6u1r0bpqFQsUEAE2eQi3qh2pphPyPXvOHzbdtJHijqosHN7CNEHzBOQYeVSKqbj
	 3fUHTjoyUSbqchAUk0qunoCsnuqFuU0DeNIva7aHBxfQlkplwThO13LMeHvzxjTUEj
	 nWH1z18hVLYnA==
Date: Fri, 6 Jun 2025 12:02:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf: collect BPF metadata from new programs, and
 display the new event
Message-ID: <aEM7SeSC7yup7TJ7@google.com>
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-4-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605233934.1881839-4-blakejones@google.com>

Hi Blake,

On Thu, Jun 05, 2025 at 04:39:33PM -0700, Blake Jones wrote:
> This collects metadata for any BPF programs that were loaded during a
> "perf record" run, and emits it at the end of the run. It also adds support
> for displaying the new PERF_RECORD_BPF_METADATA type.

Can you please split the final synthesis and the processing/display
parts?  I prefer commits doing one at a time.

>
> Here's some example "perf script -D" output for the new event type. The
> ": unhandled!" message is from tool.c, analogous to other behavior there.
> I've elided some rows with all NUL characters for brevity, and I wrapped
> one of the >75-column lines to fit in the commit guidelines.
> 
> 0x50fc8@perf.data [0x260]: event: 84
> .
> . ... raw event: size 608 bytes
> .  0000:  54 00 00 00 00 00 60 02 62 70 66 5f 70 72 6f 67  T.....`.bpf_prog
> .  0010:  5f 31 65 30 61 32 65 33 36 36 65 35 36 66 31 61  _1e0a2e366e56f1a
> .  0020:  32 5f 70 65 72 66 5f 73 61 6d 70 6c 65 5f 66 69  2_perf_sample_fi
> .  0030:  6c 74 65 72 00 00 00 00 00 00 00 00 00 00 00 00  lter............
> .  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [...]
> .  0110:  74 65 73 74 5f 76 61 6c 75 65 00 00 00 00 00 00  test_value......
> .  0120:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [...]
> .  0150:  34 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00  42..............
> .  0160:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [...]
> 
> 0 0x50fc8 [0x260]: PERF_RECORD_BPF_METADATA \
>       prog bpf_prog_1e0a2e366e56f1a2_perf_sample_filter
>   entry 0:           test_value = 42
> : unhandled!

Looks good, thanks!
Namhyung

