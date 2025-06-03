Return-Path: <bpf+bounces-59488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81BACC07F
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E24118922DA
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7165268688;
	Tue,  3 Jun 2025 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp9ubILs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266831482E7;
	Tue,  3 Jun 2025 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933523; cv=none; b=FLfecIH0tTrECt0AFzsr/ObQj2gYJghuTXRz19I8KZi8e9vVJl86LBNHqXWhjvw30DMr9IQpAUayBjlX8EP0qr/wLr+0kyARJ5p8o/EBCOLajV6RiSp1gyk0Y7mzp+9stx9IK5Z1gVUYm83hUkD4BQq/BxcAwfveJM6Rr5yp6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933523; c=relaxed/simple;
	bh=Kjp0tuLw4XvD1ShgDjXom8aEbBouPSch+dAuZVlg1lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbPm83fsGiBoJQ4e+pP052P9tULlPWvtUAMBQjPJIIcDWDtPNOm62T42sn3i8U/YAj2a7cTKk6zYX3YMEhpt/U9+rEekbA8I6QR3ufy11Bou68Wxw0nS5sB4riY3T4L+WjL9+85oSxwH7IM3Tr76Jfj7mxs87Ph5u9/3upM7qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp9ubILs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA8AC4CEED;
	Tue,  3 Jun 2025 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748933522;
	bh=Kjp0tuLw4XvD1ShgDjXom8aEbBouPSch+dAuZVlg1lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cp9ubILs58FREDHmwfcXTl8H52EfWllmO2J0fZq/mnImXJRpewkU3Dj5Jkd2ZtHHB
	 aX6aPQTM1xqYQKsOexgJP0gWMY4hquIuD3hKbJdOc48XFGFiH+OX6RCLbfqc2WomgU
	 IWxwN52klZVJ6GdpmAh4Cms02mu8bw0QTZFRexRU5C6cvBeNXl6cBSXPkYg0LlcqKP
	 i2HIclhrTkgfCWe/kDRFBzBZMbtbZpQigz7BEudTCxD3YEK2l+JXVTsc9RINhrezI3
	 kPIgAa70f//PDY/7axp7PBSUIXBHgpma25WDymPfpsko3IDWHiozSt+ihOsvkCmHUp
	 63/oCweUJ0/HQ==
Date: Mon, 2 Jun 2025 23:52:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Joe Mario <jmario@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] perf/amd/ibs: Add load/store SW filters to IBS OP PMU
Message-ID: <aD6bkAXjRllFvRTV@google.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
 <20250529123456.1801-2-ravi.bangoria@amd.com>
 <aDq1iG3P9_BBnx7C@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDq1iG3P9_BBnx7C@gmail.com>

Hello,

+ bpf list

On Sat, May 31, 2025 at 09:53:44AM +0200, Ingo Molnar wrote:
> 
> * Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> 
> > Since current IBS OP PMU does not have the capability to tag only load/
> > stores instructions, tools like perf mem/c2c ends up recording lots of
> > unwanted samples. So, introduce a load/store software filter in the IBS
> > OP PMU:
> > 
> >   ibs_op/swfilt=1,ldop=1/         --> Only load samples
> >   ibs_op/swfilt=1,stop=1/         --> Only store samples
> >   ibs_op/swfilt=1,ldop=1,stop=1/  --> Load OR store samples
> > 
> > Other HW or SW filters in combination with this ldst filter are logical
> > AND. For ex:
> > 
> >   ibs_op/swfilt=1,ldop=1,stop=1/u is
> >   "privilege == userspace && (ldop == 1 || stop == 1)"
> > 
> >   ibs_op/swfilt=1,ldop=1,stop=1,l3missonly=1/ is
> >   "l3missonly == 1 && (ldop == 1 || stop == 1)"
> 
> No objections, but:
> 
> > An alternate approach is mem_op BPF filter:
> > 
> >   perf record --filter "mem_op == load || mem_op == store" ...
> > 
> > However, there are few issues with it:
> > o BPF filter is called after preparing entire perf sample. If the sample
> >   does not satisfy the filtering criteria, all the efforts of preparing
> >   perf sample gets wasted.
> 
> Could we add an 'early' BPF callback point as well, to fast-discard 
> samples?

I guess that would require a new BPF program type than PERF_EVENT and
handle driver-specific details.

> 
> > o BPF filter requires root privilege.
> 
> Could we add 'built-in', 'safe' BPF scripts that are specifically 
> prepared for perf events filtering purposes, that can be toggled by 
> non-root users as well? These could be toggled by tooling via sysfs or 
> so, or even via the perf syscall if that turns out to be the better 
> approach.

We have BPF filter framework in the perf tools and it can be run as
normal user.  But root user should load and pin the BPF program prior
to use like below.

  $ sudo perf record --setup-filter pin

  $ perf record -d -e ibs_op/swfilt/u --filter 'mem_op == load' ...

Thanks,
Namhyung

> 
> It would give us the flexibility and extensibility of BPF, combining it 
> with the safety & compatibility of the filtering functionality being 
> provided by the kernel.
> 
> It could be provided in the form of a BPF program crypto signature 
> registry of upstream-approved BPF scripts for perf BPF callback(s),
> or so. (While root could load any BPF script.)
> 
> Thanks,
> 
> 	Ingo

