Return-Path: <bpf+bounces-65184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D2B1D1CB
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 07:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1377626DE8
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 05:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CA1EDA02;
	Thu,  7 Aug 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaBceNuY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A93208;
	Thu,  7 Aug 2025 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542961; cv=none; b=fc1/5b5iBZJXfekC7xT9wn0ow6VcAjad4LZ67YLnO1hITVrqUr469Tt7rgDd273GFfP2lgz1QFJhXASlNf1CUeWXrhPJAszqCfpJBz6o96AFUFIHwO6ccAkYjP0ldoY1sCqE6MqttOQCgYAf4f/A/Pm/0UAhc7SQnJE08usgi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542961; c=relaxed/simple;
	bh=iLPBsrHPqBLwygLabAH3oPQ7LeYJ3hzY3ZqvBa5reBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfWuMDZEdhDl77N4/phLff/UtcVRnnImHvEPvf5eBj68eNS0sqk2TxP7sE/Qkp48h/mvetxFrtcy8eYexGNpPwjWJ58he+kFu9o0BrFsO2gdLrVOyZKgoKaZgdFg/lu+yek8E5zgFDynbJGQb7jk8AhEEGePrltXrFK+JBMAumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaBceNuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4929BC4CEEB;
	Thu,  7 Aug 2025 05:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754542960;
	bh=iLPBsrHPqBLwygLabAH3oPQ7LeYJ3hzY3ZqvBa5reBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaBceNuYPPe3whqcuZMdpvOiHx3vzbPyxVVozyRKnXOer4DMe3lomi2J7AnglQ23j
	 zw7bsRNnCajR8+8mdSH4g0+ENpqD20WIg8oZaqJ7TcDFgVBUK8aeLRR5cKGxeLPf06
	 Rq0YgoBGH43GkhfZRJrHj1evJhu+NvO94Lh5SrmrbhZrQ8aDJBkNBptjqBBIWS3Ifc
	 adwQPtqElmJ4XwE16IgL3LkROF+xp7HrC9lYNQRbm4yXY6ak4irfDsPffKhmSBdssv
	 0zrZj5gctdt68kVjiG817/B0qrkPW0UWHnct6rT6qyzyELeoIm32AdfKMiWT2I9Uic
	 i4XIRlUdPU2xA==
Date: Wed, 6 Aug 2025 22:02:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] perf bpf-filter: Enable events manually
Message-ID: <aJQzbpV_NXCD5-Ob@google.com>
References: <20250806114227.14617-1-iii@linux.ibm.com>
 <20250806114227.14617-3-iii@linux.ibm.com>
 <aJPc2NvJqLOGaIKl@google.com>
 <CAADnVQJG6U6X1qarpbdXra12m-PhNJK5f-jyw695osnOm6AZnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJG6U6X1qarpbdXra12m-PhNJK5f-jyw695osnOm6AZnQ@mail.gmail.com>

Hi Alexei,

On Wed, Aug 06, 2025 at 04:38:09PM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 6, 2025 at 3:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Aug 06, 2025 at 01:40:35PM +0200, Ilya Leoshkevich wrote:
> > > On s390, and, in general, on all platforms where the respective event
> > > supports auxiliary data gathering, the command:
> > >
> > >    # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
> > >    [ perf record: Woken up 1 times to write data ]
> > >    [ perf record: Captured and wrote 0.011 MB perf.data ]
> > >    # ./perf report --stats | grep SAMPLE
> > >    #
> > >
> > > does not generate samples in the perf.data file. On x86 the command:
> > >
> > >   # sudo perf record -e intel_pt// -u 0 ls
> > >
> > > is broken too.
> > >
> > > Looking at the sequence of calls in 'perf record' reveals this
> > > behavior:
> > >
> > > 1. The event 'cycles' is created and enabled:
> > >
> > >    record__open()
> > >    +-> evlist__apply_filters()
> > >        +-> perf_bpf_filter__prepare()
> > >          +-> bpf_program.attach_perf_event()
> > >              +-> bpf_program.attach_perf_event_opts()
> > >                  +-> __GI___ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
> > >
> > >    The event 'cycles' is enabled and active now. However the event's
> > >    ring-buffer to store the samples generated by hardware is not
> > >    allocated yet.
> > >
> > > 2. The event's fd is mmap()ed to create the ring buffer:
> > >
> > >    record__open()
> > >    +-> record__mmap()
> > >        +-> record__mmap_evlist()
> > >          +-> evlist__mmap_ex()
> > >              +-> perf_evlist__mmap_ops()
> > >                  +-> mmap_per_cpu()
> > >                      +-> mmap_per_evsel()
> > >                          +-> mmap__mmap()
> > >                              +-> perf_mmap__mmap()
> > >                                  +-> mmap()
> > >
> > >    This allocates the ring buffer for the event 'cycles'. With mmap()
> > >    the kernel creates the ring buffer:
> > >
> > >    perf_mmap(): kernel function to create the event's ring
> > >    |            buffer to save the sampled data.
> > >    |
> > >    +-> ring_buffer_attach(): Allocates memory for ring buffer.
> > >        |        The PMU has auxiliary data setup function. The
> > >        |        has_aux(event) condition is true and the PMU's
> > >        |        stop() is called to stop sampling. It is not
> > >        |        restarted:
> > >        |
> > >        |        if (has_aux(event))
> > >        |                perf_event_stop(event, 0);
> > >        |
> > >        +-> cpumsf_pmu_stop():
> > >
> > >    Hardware sampling is stopped. No samples are generated and saved
> > >    anymore.
> > >
> > > 3. After the event 'cycles' has been mapped, the event is enabled a
> > >    second time in:
> > >
> > >    __cmd_record()
> > >    +-> evlist__enable()
> > >        +-> __evlist__enable()
> > >          +-> evsel__enable_cpu()
> > >              +-> perf_evsel__enable_cpu()
> > >                  +-> perf_evsel__run_ioctl()
> > >                      +-> perf_evsel__ioctl()
> > >                          +-> __GI___ioctl(., PERF_EVENT_IOC_ENABLE, .)
> > >
> > >    The second
> > >
> > >       ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> > >
> > >    is just a NOP in this case. The first invocation in (1.) sets the
> > >    event::state to PERF_EVENT_STATE_ACTIVE. The kernel functions
> > >
> > >    perf_ioctl()
> > >    +-> _perf_ioctl()
> > >        +-> _perf_event_enable()
> > >            +-> __perf_event_enable()
> > >
> > >    return immediately because event::state is already set to
> > >    PERF_EVENT_STATE_ACTIVE.
> > >
> > > This happens on s390, because the event 'cycles' offers the possibility
> > > to save auxilary data. The PMU callbacks setup_aux() and free_aux() are
> > > defined. Without both callback functions, cpumsf_pmu_stop() is not
> > > invoked and sampling continues.
> > >
> > > To remedy this, remove the first invocation of
> > >
> > >    ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
> > >
> > > in step (1.) Create the event in step (1.) and enable it in step (3.)
> > > after the ring buffer has been mapped.
> > >
> > > Output after:
> > >
> > >  # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
> > >  [ perf record: Woken up 3 times to write data ]
> > >  [ perf record: Captured and wrote 0.876 MB perf.data ]
> > >  # ./perf  report --stats | grep SAMPLE
> > >               SAMPLE events:      16200  (99.5%)
> > >               SAMPLE events:      16200
> > >  #
> > >
> > > The software event succeeded both before and after the patch:
> > >
> > >  # ./perf record -e cpu-clock -aB --synth=no -u 0 -- \
> > >                                         ./perf test -w thloop 2
> > >  [ perf record: Woken up 7 times to write data ]
> > >  [ perf record: Captured and wrote 2.870 MB perf.data ]
> > >  # ./perf  report --stats | grep SAMPLE
> > >               SAMPLE events:      53506  (99.8%)
> > >               SAMPLE events:      53506
> > >  #
> > >
> > > Fixes: b4c658d4d63d61 ("perf target: Remove uid from target")
> > > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Do you mind if I take the whole set through the bpf tree ?
> 
> I'm planning to send bpf PR in a couple days, so by -rc1
> all trees will see the fix.

Sure, I don't think we have conflicting changes and we'll sync
perf-tools-next once -rc1 is released.

Thanks,
Namhyung


