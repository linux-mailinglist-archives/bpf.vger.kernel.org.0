Return-Path: <bpf+bounces-48578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E50A09B6A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 20:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73009188EE9C
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0022257A;
	Fri, 10 Jan 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYx8sS5y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC7214225;
	Fri, 10 Jan 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535326; cv=none; b=TCHSD7SigH8KO9bENOnOGvtjwdX++U8T+D8gsM117Cj+Ud91+nABMSvfysHVUyLCXBj4AOynXmBX+M+XNyZ2YM37CmDVghaYG1C+3tfyBaXbfRxCf3ISh2AtPuZmVsltf2GiAjPhMqSSyhlo2kJNgDAiZJ162g/fmRlZ7eqkZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535326; c=relaxed/simple;
	bh=pvRpioX99tGG3pirkv8iYfX5Ac6GPRSh/b6szM6jbho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8mt//RkH66x6JY+Dv5MJJE73cN1sanWgFFCxtBdteRZXfjT2oaa2E1aigIQDUIQfbLwfXlTNJKuGO6lv8vwpnopt6/u6G/go3zvkEReSX72Vlq5xCyYItvmsQFWsTORhhYKRN1iedTq67jf407J54v/Oa2s39XIcaV6tVNw9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYx8sS5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6428C4CED6;
	Fri, 10 Jan 2025 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736535326;
	bh=pvRpioX99tGG3pirkv8iYfX5Ac6GPRSh/b6szM6jbho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYx8sS5yDUy4Dw1dfY17Jv4wKYU86OHspL49n2inukygYaIjJ8e7hhzCH+H0agmW5
	 S5F+smZCzRXhKrMICwnBAJg42jc57VcjguTPQMpFCbH8P9iKSWoCz6d9UNB1c5+nLQ
	 iXOgHrgPjhFUQ6SkpsW5gcJBmi8LS+FZ7h6njjMkmf4CKyraVocB3HrhGfqmI6HLhz
	 UxgcuBHjhlqaQV9txRtaAWqqbBO9JCIIiXFmqURBpJw+J8Zm15j0zB2kbxM4wyya7b
	 J2zyMHL1YIYpeFrn4Y25qs4EnS9o9pxXS1Bg96u4/koELnLyeAGVe5M3RZmWiPdELQ
	 H4Nib5iDe0x7w==
Date: Fri, 10 Jan 2025 10:55:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <Z4FtHGBbCEeLQhAm@google.com>
References: <20250109222109.567031-1-irogers@google.com>
 <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
 <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>

On Thu, Jan 09, 2025 at 08:44:38PM -0800, Ian Rogers wrote:
> On Thu, Jan 9, 2025 at 5:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > Whilst for many tools it is an expected behavior that failure to open
> > > a perf event is a failure, ARM decided to name PMU events the same as
> > > legacy events and then failed to rename such events on a server uncore
> > > SLC PMU. As perf's default behavior when no PMU is specified is to
> > > open the event on all PMUs that advertise/"have" the event, this
> > > yielded failures when trying to make the priority of legacy and
> > > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > > legacy event user on ARM hardware may find their event opened on an
> > > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > > such events which this patch implements. Rather than have the skipping
> > > conditional on running on ARM, the skipping is done on all
> > > architectures as such a fundamental behavioral difference could lead
> > > to problems with tools built/depending on perf.
> > >
> > > An example of perf record failing to open events on x86 is:
> > > ```
> > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > Error:
> > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > >
> > > Error:
> > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> > > "dmesg | grep -i perf" may provide additional information.
> > >
> > > Error:
> > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> > > The LLC-prefetch-read event is not supported.
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> >
> > I'm afraid this can be too noisy.
> 
> The intention is to be noisy:
> 1) it matches the existing behavior, anything else is potentially a regression;

Well.. I think you're changing the behavior. :)  Also currently it just
fails on the first event so it won't be too much noisy.

  $ perf record -e data_read,data_write,LLC-prefetch-read -a sleep 0.1
  event syntax error: 'data_read,data_write,LLC-prefetch-read'
                       \___ Bad event name
  
  Unable to find event on a PMU of 'data_read'
  Run 'perf list' for a list of valid events
  
   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]
  
      -e, --event <event>   event selector. use 'perf list' to list available events


> 2) it only happens if trying to record on a PMU/event that doesn't
> support recording, something that is currently an error and so we're
> not motivated to change the behavior as no-one should be using it;

It was caught by Linus, so we know at least one (very important) user.


> 3) for the wildcard case the only offender is ARM's SLC PMU and the
> appropriate fix there has always been to make the CPU cycle's event
> name match the bus_cycles event name by calling it cpu_cycles -
> something that doesn't conflict with a core PMU event name, the thing
> that has introduced all these problems, patches, long email exchanges,
> unfixed inconsistencies, etc.. If the errors aren't noisy then there
> is little motivation for the ARM SLC PMU's event name to be fixed.

I understand your concern but I'm not sure it's the best way to fix the
issue.

James, Leo, is there any chance you can rename the SLC cycles event in
the kernel driver?

Thanks,
Namhyung


