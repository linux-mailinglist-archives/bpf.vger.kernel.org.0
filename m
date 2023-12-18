Return-Path: <bpf+bounces-18238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE8817C0E
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 21:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424DB28464B
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6054650;
	Mon, 18 Dec 2023 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoDCASE/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D351E52E;
	Mon, 18 Dec 2023 20:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30E9C433C8;
	Mon, 18 Dec 2023 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702931801;
	bh=dAOyyU+aPtQu+XM1BL0WUdir2IdvIhUUVAbyrsyrv5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoDCASE/Y//4LPYrP0o1Xcn64hqxs+o300P3uGJ/HzPNqHWzfHPby2IHVK1pbpjR8
	 1BBWH7/zQQNWkeJHSBuWGE+D6+kFI3MVA7L97YMZgASi7b77kjIU0M82pH3xtFl01x
	 iYdG/D/57mPT9iktPSgBEMYl9ESEvCjMzZXpV+c9A+qRyBzFmFikLsumuppUoUVBe/
	 JNCJeC9Sb2l7raDx8n+dg0O+Csq5qBEV9vPhXtULBI1r/nwvbF9bPwwg0i2Fusgw1P
	 tR2X+yzEbtpkD0miAw7EFY8Dw0FfH8RWrr62kAdhnn/g0jAyUMHPZsi2rgEQHw6HA2
	 GhIfFaW6edzyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 12F2C403EF; Mon, 18 Dec 2023 17:36:39 -0300 (-03)
Date: Mon, 18 Dec 2023 17:36:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
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
Subject: Re: [PATCH v1 14/14] libperf cpumap: Document perf_cpu_map__nr's
 behavior
Message-ID: <ZYCtV6YcDLpgau75@kernel.org>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-15-irogers@google.com>
 <0e1ca950-b5a4-1e08-8696-4e3e12e21b19@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1ca950-b5a4-1e08-8696-4e3e12e21b19@arm.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 12, 2023 at 03:20:47PM +0000, James Clark escreveu:
> On 29/11/2023 06:02, Ian Rogers wrote:
> >  LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
> > +/**
> > + * perf_cpu_map__cpu - get the CPU value at the given index. Returns -1 if index
> > + *                     is invalid.
> > + */
> >  LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
> > +/**
> > + * perf_cpu_map__nr - for an empty map returns 1, as perf_cpu_map__cpu returns a
> > + *                    cpu of -1 for an invalid index, this makes an empty map
> > + *                    look like it contains the "any CPU"/dummy value. Otherwise
> > + *                    the result is the number CPUs in the map plus one if the
> > + *                    "any CPU"/dummy value is present.
> 
> Hmmm... I'm not sure whether to laugh or cry at that API.
> 
> Reviewed-by: James Clark <james.clark@arm.com>



Thanks, applied to perf-tools-next.

- Arnaldo


