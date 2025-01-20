Return-Path: <bpf+bounces-49306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13ACA1743E
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 22:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC93A9FC2
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFD1F03E4;
	Mon, 20 Jan 2025 21:37:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525319993D;
	Mon, 20 Jan 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737409037; cv=none; b=sDP4KhvssqpNU4RTtakZA3535PwKbwyTiEVk213aLv1r2DnCfFfDnHArxbKBrD1N7moPX5WRBKCaiMX6m/HJBJZeB/+UJWpXoAUu1xQjlxzjOfXZYWmVPj+vOPeghpmwG4ksP/A+BxBx1APlRzPzyvFFOoH5fdgVwPe56dm+Y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737409037; c=relaxed/simple;
	bh=u4YXtpdCSImGbVl3jYvJokxjwCnHqvgNr2Mmk9tGlJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loBOmSFdg67A/GZ14Y7wu/l/cF4pLg5a2fggfr+j/XEWBOIetyUNO2nlH4lsAO638F5pXrlJY3VBMf6Gm2LR+lEnod+tKCkNN126Z1OHbZMuiZA1Y7060+EslvG4onJloZQw551QVBPRgjjz0T4nyfVIjz03ggli3oNMf+K/+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92F4106F;
	Mon, 20 Jan 2025 13:37:42 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A7E3F740;
	Mon, 20 Jan 2025 13:37:14 -0800 (PST)
Date: Mon, 20 Jan 2025 21:37:08 +0000
From: Leo Yan <leo.yan@arm.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v1] samples/bpf: Add a trace tool with perf PMU counters
Message-ID: <20250120213708.GB261349@e132581.arm.com>
References: <20250119153343.116795-1-leo.yan@arm.com>
 <ee0b3bb3-476b-4792-84e1-c53fa4dbabee@iogearbox.net>
 <20250120185033.GA261349@e132581.arm.com>
 <CAADnVQKrOi1cJrFUXuwacmbWCxR-oKRr_tTiyQJP0=jvnkXO3A@mail.gmail.com>
 <365689f8-12c1-44b3-a351-97e6f54c1928@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <365689f8-12c1-44b3-a351-97e6f54c1928@iogearbox.net>

On Mon, Jan 20, 2025 at 08:54:30PM +0100, Daniel Borkmann wrote:
> On 1/20/25 8:38 PM, Alexei Starovoitov wrote:
> > On Mon, Jan 20, 2025 at 10:50 AM Leo Yan <leo.yan@arm.com> wrote:

[...]

> > > My understanding for bpftool is for eBPF program specific.  I looked
> > > into a bit the commit 47c09d6a9f67, it is nature for integrating the
> > > tracing feature for eBPF program specific.  My patch is for tracing
> > > normal userspace programs, I am not sure if this is really wanted by
> > > bpftool.  I would like to hear opinions from bpftool maintainer before
> > > proceeding.
> 
> Yes, that suggestion was if it would have been applicable also
> for the existing bpftool (BPF program) profiling functionality.
> 
> > > My program mainly uses eBPF attaching to uprobe.  selftest/bpf has
> > > contained the related functionality testing, actually I refered the
> > > test for writing my code :).  So maybe it is not quite useful for
> > > merging the code as a test?
> > > 
> > > If both options are not ideal, I would spend time to land the
> > > feature in perf tool - the perf tool has supported eBPF backend for
> > > reading PMU counters, but it is absent function based profiling.
> > 
> > We don't add tools to kernel repo. bpftool is an exception
> > because it's used during the selftest build.
> > 'perf' is another exception for historical reasons.
> > 
> > This particular feature fits 'perf' the best.
> 
> Agree, looks like perf is the best target for integration then.

Thanks for suggestions, Alexei and Daniel.  It makes sense for me to
move to perf, and now I understand the policy for moving code from
samples/bpf.

It may be irrelevant to the patch itself.  I know we have great BPF
toolings (BCC/bpftrace, etc), but it would be a bit confused for me
that we don't have a offical repo to maintain C based BPF toolkits.

Sometimes, C based BPF tool is small and handy ...

Thanks,
Leo

