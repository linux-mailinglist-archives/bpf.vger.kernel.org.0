Return-Path: <bpf+bounces-49301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC19A172D2
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11D416A7AC
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16651EF081;
	Mon, 20 Jan 2025 18:50:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2D199949;
	Mon, 20 Jan 2025 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399039; cv=none; b=mf+q2xny+nsIx09b4X6NXL+wQDfxHq+JuuneRfjH09dcTFyeo/gKrow4MOIy1sD+f9+Qithsei7T50ek2fR+U4avg2yrd+gQo9ljYv23qRCAa6rh3WHRik2VcZIJHyT/dQPm3l/JCetYIC5l9JuRaNFDsdEji08ukKY4WseZzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399039; c=relaxed/simple;
	bh=vt7mxhs2tJXhOscLDovbVIXY3e4C7hGDQHTiTR7J038=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4cKfpof05OpEhUeH+sqP8TFFGHc/2gD6vA/pqDS3mLllE1GuCZs2S8mhBhkZJW05KDQyiEnwg/OmCki/3/G8zuFc6P2ajGP7WXzOi/+WR7jgPQLLYWV5gbUxJu8zS5skFxWBbInNKuFz3ZrPZO7htvuNuXlHoA60D1qZxNIpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D9251063;
	Mon, 20 Jan 2025 10:51:04 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 902C53F740;
	Mon, 20 Jan 2025 10:50:35 -0800 (PST)
Date: Mon, 20 Jan 2025 18:50:33 +0000
From: Leo Yan <leo.yan@arm.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v1] samples/bpf: Add a trace tool with perf PMU counters
Message-ID: <20250120185033.GA261349@e132581.arm.com>
References: <20250119153343.116795-1-leo.yan@arm.com>
 <ee0b3bb3-476b-4792-84e1-c53fa4dbabee@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0b3bb3-476b-4792-84e1-c53fa4dbabee@iogearbox.net>

Hi Daniel,

On Mon, Jan 20, 2025 at 05:18:23PM +0100, Daniel Borkmann wrote:
> 
> Hi Leo,
> 
> On 1/19/25 4:33 PM, Leo Yan wrote:
> > Developers might need to profile a program with fine-grained
> > granularity.  E.g., a user case is to account the CPU cycles for a small
> > program or for a specific function within the program.
> > 
> > This commit introduces a small tool with using eBPF program to read the
> > perf PMU counters for performance metrics.  As the first step, the four
> > counters are supported with the '-e' option: cycles, instructions,
> > branches, branch-misses.
> > 
> > The '-r' option is provided for support raw event number.  This option
> > is mutually exclusive to the '-e' option, users either pass a raw event
> > number or a counter name.
> > 
> > The tool enables the counters for the entire trace session in free-run
> > mode.  It reads the beginning values for counters when the profiled
> > program is scheduled in, and calculate the interval when the task is
> > scheduled out.  The advantage of this approach is to dismiss the
> > statistics noise (e.g. caused by the tool itself) as possible.

[...]

> Thanks for this work! Few suggestions.. the contents of samples/bpf/ are in process of being
> migrated into BPF selftests given they have been bit-rotting for quite some time, so we'd like
> to migrate missing coverage into BPF CI (see test_progs in tools/testing/selftests/bpf/). That
> could be one option, or an alternative is to extend bpftool for profiling BPF programs (see
> 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")).

Thanks for suggestions!

The naming or info in the commit log might cause confuse.  The purpose
of this patch is to measure PMU counters for normal programs (not BPF
program specific).  To achieve profiling accuracy, it opens perf event
in thread mode, and support function based trace and can be userspace
mode only.

My understanding for bpftool is for eBPF program specific.  I looked
into a bit the commit 47c09d6a9f67, it is nature for integrating the
tracing feature for eBPF program specific.  My patch is for tracing
normal userspace programs, I am not sure if this is really wanted by
bpftool.  I would like to hear opinions from bpftool maintainer before
proceeding.

My program mainly uses eBPF attaching to uprobe.  selftest/bpf has
contained the related functionality testing, actually I refered the
test for writing my code :).  So maybe it is not quite useful for
merging the code as a test?

If both options are not ideal, I would spend time to land the
feature in perf tool - the perf tool has supported eBPF backend for
reading PMU counters, but it is absent function based profiling.

Thanks,
Leo

