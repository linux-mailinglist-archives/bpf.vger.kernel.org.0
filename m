Return-Path: <bpf+bounces-17558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CB80F511
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF1C281DC8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DEC7E765;
	Tue, 12 Dec 2023 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om/wqvN1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1673171;
	Tue, 12 Dec 2023 17:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73489C433C7;
	Tue, 12 Dec 2023 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702403980;
	bh=tz+1sOWttKcl3a8KlUuaREBKUL4WYsTUmoJCIWI8J2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=om/wqvN1PT76jVx/CfKav0nLkaf4CK4kqAC9r5+o/YFTFqzJLHV9AFhmuzmz4coDn
	 fWzG57/kj9GpAm+RcsJS48A/3bH+zV98QatK9AWvebFMDP44ueRKvJkj4zBo87pv7B
	 fFrEaCF70kW33lgPk7dL0BxUfuaG7uAvH/PK3mXtiUrg55cUSjJw2r6nV1ZHyyJ7kL
	 zeLYMo0lW/ZaUtXclPRnko4YHMrqeIMR/n83FFlKHKDTycU9LDKXmnDSeXz+AcXTT0
	 Zelv8DCmuwKtE2ScA3Ogd/zM/KTKdvJ2jXprmgB2wLgTJ83ABdtQ7TNhrrvgqJ/l+I
	 vnPkYllRSx33Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 945A9403EF; Tue, 12 Dec 2023 14:59:37 -0300 (-03)
Date: Tue, 12 Dec 2023 14:59:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Changbin Du <changbin.du@huawei.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 00/14] Clean up libperf cpumap's empty function
Message-ID: <ZXifiVytVbebYE3U@kernel.org>
References: <20231129060211.1890454-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 28, 2023 at 10:01:57PM -0800, Ian Rogers escreveu:
> Rename and clean up the use of libperf CPU map functions particularly
> focussing on perf_cpu_map__empty that may return true for maps
> containing CPUs but also with an "any CPU"/dummy value.
> 
> perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> will yield the "any CPU"/dummy value. Reduce the appearance of some
> calls to this by using the perf_cpu_map__for_each_cpu macro.
> 
> Ian Rogers (14):
>   libperf cpumap: Rename perf_cpu_map__dummy_new
>   libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
>   libperf cpumap: Rename perf_cpu_map__empty
>   libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
>   libperf cpumap: Add for_each_cpu that skips the "any CPU" case

Applied 1-6, with James Reviewed-by tags, would be good to have Adrian
check the PT and BTS parts, testing the end result if he things its all
ok.

- Arnaldo

