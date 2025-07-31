Return-Path: <bpf+bounces-64802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF99B17002
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052893B7C5D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC522BE7BB;
	Thu, 31 Jul 2025 10:57:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517592BE7C7;
	Thu, 31 Jul 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959462; cv=none; b=Xnb37jHN+hi68X96sBARpqksl9kW8dLTJScmukMYNYj+inCfE9oq+HqDMw6nUDsDUK39QhNh0wJvWG7RPRVfmSUXOn7CdcsxUUWLK3xP8om8RsNwZiGhqyd3UH3cthwlb6M1JHYBUSkxGHErFkQCa3Ldd0PnpIZvT76g0+ORDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959462; c=relaxed/simple;
	bh=XmRDefPS7256cXgbN7EdkkG/1Z2+f8NW1zw/oLbcdhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQPVTNFTxkg1eOcSVV3dhGFa4GrTGncQ4iwdYP1P+T8JiWDKJyj6xMmUrgJz/Gsdvhpa0+r+B4wXxFVRzVL1kbmP7vTpws0npI033ssoFZJRMXSOiPWiiNQPYQeRl3wKtOZ8l9fAnFt4NKmD6fKwHZnvnKFxH2nXVbHc4DxXGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8FA71D13;
	Thu, 31 Jul 2025 03:57:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508213F66E;
	Thu, 31 Jul 2025 03:57:39 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:57:37 +0100
From: Leo Yan <leo.yan@arm.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 5/6] perf record: Support AUX pause and resume
 with BPF
Message-ID: <20250731105737.GG143191@e132581.arm.com>
References: <202507310818.a05d2380-lkp@intel.com>
 <20250731091148.GF143191@e132581.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731091148.GF143191@e132581.arm.com>

Hi,

On Thu, Jul 31, 2025 at 10:11:48AM +0100, Leo Yan wrote:
> Hi,
> 
> On Thu, Jul 31, 2025 at 03:26:01PM +0800, kernel test robot wrote:
> 
> [...]
> 
> > 2025-07-30 19:06:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-e350af63969b875598f0656a20d801bbcaa7bd76/tools/perf/perf test 64 -v
> >  64: Convert perf time to TSC                                        :
> >  64.1: TSC support                                                   : Running (2 active)
> >  64.1: TSC support                                                   : Ok
> > --- start ---
> > test child forked, pid 7359
> > Using CPUID GenuineIntel-6-9E-D
> > evlist__open() failed
> > ---- end(-1) ----
> >  64.2: Perf time to TSC                                              : FAILED!
> 
> I roughly read the job.yaml file, seems it does not install clang.
> Thus, the building will not enalbe the option BUILD_BPF_SKEL=1.
> 
> As a result, auxtrace__update_bpf_map() will return a failure. I will
> fix this issue in next spin.
> 
> Thanks for test and reporting.

I played a bit and found that if with the option "BUILD_BPF_SKEL := 0",
I even failed to build perf (I will fix in new version).

I think you should have built perf with enabled BUILD_BPF_SKEL. However,
in this case, I cannot reproduce the test failure, both on my x86_64 and
Arm64 machines. I reviewed the code and have no clue this patch will
cause the failure.

Is it possible to run the test at your side with the option "perf test
64 -vvv" for debugging info?  Or if it is possible related to the
setting kernel.perf_event_paranoid?

Thanks,
Leo

