Return-Path: <bpf+bounces-40593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64398AC02
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 20:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03E32835A1
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE57199FB0;
	Mon, 30 Sep 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioUrR/UN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CD199933;
	Mon, 30 Sep 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720537; cv=none; b=HnLKkhcvGJIiYCv54IKevcq4ZUA2Jo77ea6PNAs7wkc9YEDNLynRf6eRbODmtt1+Ik8AfWCSRLo82KDI+DpfrO/0ZCWDSeYhUEC7CqzxHjTBjd4QC2YehVV0VBW/MeN6ViLWcUjdZ/ReFrtnjmo/Kum50zdt8SX+rIgzUNoQa70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720537; c=relaxed/simple;
	bh=/pJ74pdlnuOKjRnnxAqN0F9sQN50xyetEDeX3R0qWr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic7qO3nbGWL3i933BRtGhffYKNPuS4IQWn9KAbuQISwFt14cboNrKth8maS++yEgXhREsYGMwdHww0/P9AmpZvcVL75PbAYA3mW+CkqkYdcG+PC0LqEP96MPkFEXfkweTUZ5nSL6oRKrsbbJRfz5k7WY9tyGiPC0b/U0iv/YSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioUrR/UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F2C4CEC7;
	Mon, 30 Sep 2024 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727720537;
	bh=/pJ74pdlnuOKjRnnxAqN0F9sQN50xyetEDeX3R0qWr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioUrR/UNPdNnrtciGUGy5Y+MBwXqMlsO1NUGtUWfjHpYCGWZOW/q1kXLEAoyQAnHk
	 aRTT3fRdH9pMqC0vxs4KQbDPf7erIMSwuMiwZ9NQUxyJYuRzdPZMN9rqajXZnuCYLR
	 LXjLmSa5tzSd/MTteO6nJpENL5ym+nY2eDjxGgoRwOXXFaaRBGRhHY9b3vzdRlmYz0
	 /e2SmLFoDFBoAeDvrq3DWGLMlD53EC8ta9JjkgjmBjWTFrp24JIRaxqDP10GrWTrdr
	 y1ZNqUkUhCWpObk6vPEHuC5ZQoMPE/ihIEvP1Kr3UX89ErzSXM+Vx7mV68WAop7J0a
	 FH+VdKgJE6OsQ==
Date: Mon, 30 Sep 2024 08:22:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	liaochang1@huawei.com,
	Daniel Hodges <hodges.daniel.scott@gmail.com>
Subject: Re: [RFC PATCH 0/2] cpufreq_ext: Introduce cpufreq ext governor
Message-ID: <ZvrsV-A1Jizokuef@slm.duckdns.org>
References: <20240927101342.3240263-1-zouyipeng@huawei.com>
 <CAADnVQJmVo4BU345irnnLNxQ_sT1cOEx8ky4T2iH_ZKpAyFfww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJmVo4BU345irnnLNxQ_sT1cOEx8ky4T2iH_ZKpAyFfww@mail.gmail.com>

(cc'ing Daniel Hodges and quoting the whole body)

On Sun, Sep 29, 2024 at 09:56:02AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 27, 2024 at 3:03 AM Yipeng Zou <zouyipeng@huawei.com> wrote:
> >
> > Hi everyone,
> >
> > I am currently working on a patch for a CPU frequency governor based on
> > BPF, which can use BPF to customize and implement various frequency
> > scaling strategies.
> >
> > If you have any feedback or suggestions, please do let me know.
> >
> > Motivation
> > ----------
> >
> > 1. Customization
> >
> > Existing cpufreq governors in the kernel are designed for general
> > scenarios, which may not always be optimal for specific or specialized
> > workloads.
> >
> > The userspace governor allows direct control over cpufreq, but users
> > often require guidance from the kernel to achieve the desired frequency.
> >
> > Cpufreq_ext aims to address this by providing a customizable framework that
> > can be tailored to the unique needs of different systems and applications.
> >
> > While cpufreq governors can be implemented within a kernel module,
> > maintaining a ko tailored for specific scenarios can be challenging.
> > The complexity and overhead associated with kernel modules make it
> > difficult to quickly adapt and deploy custom frequency scaling strategies.
> >
> > Cpufreq_ext leverages BPF to offer a more lightweight and flexible approach
> > to implementing customized strategies, allowing for easier maintenance and
> > deployment.
> >
> > 2. Integration with sched_ext:
> >
> > sched_ext is a scheduler class whose behavior can be defined by a set of
> > BPF programs - the BPF scheduler.
> >
> > Look for more about sched_ext in [1]:
> >
> >         [1] https://www.kernel.org/doc/html/next/scheduler/sched-ext.html
> >
> > The interaction between CPU frequency scaling and task scheduling is
> > critical for performance.
> >
> > cpufreq_ext can work with sched_ext to ensure that both scheduling
> > decisions and frequency adjustments are made in a coordinated manner,
> > optimizing system responsiveness and power consumption.
> 
> I think sched-ext already has a mechanism to influence cpufreq.
> How is this different ?

FWIW, sched_ext's cpufreq implementation is through the schedutil governor.
All that the BPF scheduler does is providing utilization signal to the
governor. This seems to work fine for sched_ext schedulers (this doesn't
preclude more direct BPF governor).

> Pls cc sched-ext folks in the future.

Yeah, it'd be great if you can cc Daniel, me and sched-ext@meta.com.

> > Overview
> > --------
> >
> > The cpufreq ext is a BPF based cpufreq governor, we can customize
> > cpufreq governor in BPF program.
> >
> > CPUFreq ext works as common cpufreq governor with cpufreq policy.
> >
> >                    --------------------------
> >                   |        BPF governor      |
> >                    --------------------------
> >                                |
> >                                v
> >                           BPF Register
> >                                |
> >                                v
> >             --------------------------------------
> >            |             CPUFreq ext              |
> >             --------------------------------------
> >               ^                ^               ^
> >               |                |               |
> >            ---------       ---------       ---------
> >           | policy0 | ... | policy1 | ... | policyn |
> >            ---------       ---------       ---------
> >
> > We can register serval function hooks to cpufreq ext by BPF Struct OPS.
> >
> > The first patch define a dbs_governor, and it's works like other
> > governor.
> >
> > The second patch gives a sample how to use it, implement one
> > typical cpufreq governor, switch to max cpufreq when VIP task
> > is running on target cpu.
> >
> > Detail
> > ------
> >
> > The cpufreq ext use bpf_struct_ops to register serval function hooks.
> >
> >         struct cpufreq_governor_ext_ops {
> >                 ...
> >         }
> >
> > Cpufreq_governor_ext_ops defines all the functions that BPF programs can
> > implement customly.
> >
> > If you need to add a custom function, you only need to define it in this
> > struct.
> >
> > At the moment we have defined the basic functions.
> >
> > 1. unsigned long (*get_next_freq)(struct cpufreq_policy *policy)
> >
> >         Make decision how to adjust cpufreq here.
> >         The return value represents the CPU frequency that will be
> >         updated.
> >
> > 2. unsigned int (*get_sampling_rate)(struct cpufreq_policy *policy)
> >
> >         Make decision how to adjust sampling_rate here.
> >         The return value represents the governor samplint rate that
> >         will be updated.
> >
> > 3. unsigned int (*init)(void)
> >
> >         BPF governor init callback, return 0 means success.
> >
> > 4. void (*exit)(void)
> >
> >         BPF governor exit callback.
> >
> > 5. char name[CPUFREQ_EXT_NAME_LEN]
> >
> >         BPF governor name.
> >
> > The cpufreq_ext also add sysfs interface which refer to governor status.
> >
> > 1. ext/stat attribute:
> >
> >         Access to current BPF governor status.
> >
> >         # cat /sys/devices/system/cpu/cpufreq/ext/stat
> >         Stat: CPUFREQ_EXT_INIT
> >         BPF governor: performance
> >
> > There are number of constraints on the cpufreq_ext:
> >
> > 1. Only one ext governor can be registered at a time.
> >
> > 2. By default, it operates as a performance governor when no BPF
> >    governor is registered.
> >
> > 3. The cpufreq_ext governor must be selected before loading a BPF
> >    governor; otherwise, the installation of the BPF governor will fail.
> >
> > TODO
> > ----
> >
> > The current patch is a starting point, and future work will focus on
> > expanding its capabilities.
> >
> > I plan to leverage the BPF ecosystem to introduce innovative features,
> > such as real-time adjustments and optimizations based on system-wide
> > observations and analytics.
> >
> > And I am looking forward to any insights, critiques, or suggestions you
> > may have.
> >
> > Yipeng Zou (2):
> >   cpufreq_ext: Introduce cpufreq ext governor
> >   cpufreq_ext: Add bpf sample
> >
> >  drivers/cpufreq/Kconfig        |  23 ++
> >  drivers/cpufreq/Makefile       |   1 +
> >  drivers/cpufreq/cpufreq_ext.c  | 525 +++++++++++++++++++++++++++++++++
> >  samples/bpf/.gitignore         |   1 +
> >  samples/bpf/Makefile           |   8 +-
> >  samples/bpf/cpufreq_ext.bpf.c  | 113 +++++++
> >  samples/bpf/cpufreq_ext_user.c |  48 +++
> >  7 files changed, 718 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/cpufreq/cpufreq_ext.c
> >  create mode 100644 samples/bpf/cpufreq_ext.bpf.c
> >  create mode 100644 samples/bpf/cpufreq_ext_user.c
> >
> > --
> > 2.34.1
> >

-- 
tejun

