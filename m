Return-Path: <bpf+bounces-18237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF01A817C02
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 21:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF471F235B4
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1227204D;
	Mon, 18 Dec 2023 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS/Q8n0H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993521DA29;
	Mon, 18 Dec 2023 20:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25F5C433C8;
	Mon, 18 Dec 2023 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702931697;
	bh=XgCl1gqQm6Hy5BOss5zz/mULMH3Fu6AXj/W8dxIHYHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QS/Q8n0HomxDBTx2LKKlbPGNDImEA97qdRUmVuqa5R8EuNIxsUl7LRL/bjK83zntp
	 NGzkbF7nTBSH3f2cPbPeNSQYAdI88+ovZeV1M6URpnZaAricEZK3rZYVPSBNcDAgOW
	 tJy2o9+D6LGkBued47DuFDUxWuoyX7Ro/ahqgnTaCBg/1MmoXlwiThIjVmM7COY2Yq
	 Tqg8WBZVsKTkxG0r6StGxQQzphrdhOqa2TzWxORnL5Leiw/xwGu0jrbikLtKDkVHja
	 IBrIAiVxAAzAA3fqHxyYCDdIbM0C5UM/2dm6nRZd12YUrlXVSsW5vzKZKqRZGSxuM8
	 lCqvo/eiCDM6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 81F6D403EF; Mon, 18 Dec 2023 17:34:54 -0300 (-03)
Date: Mon, 18 Dec 2023 17:34:54 -0300
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
Subject: Re: [PATCH v1 10/14] perf top: Avoid repeated function calls
Message-ID: <ZYCs7mh3GgvNz2-A@kernel.org>
References: <20231129060211.1890454-1-irogers@google.com>
 <20231129060211.1890454-11-irogers@google.com>
 <e067c360-56ac-1756-3b3b-4bf5f663be87@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e067c360-56ac-1756-3b3b-4bf5f663be87@arm.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 12, 2023 at 03:11:53PM +0000, James Clark escreveu:
> 
> 
> On 29/11/2023 06:02, Ian Rogers wrote:
> > Add a local variable to avoid repeated calls to perf_cpu_map__nr.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> > ---
> >  tools/perf/util/top.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
> > index be7157de0451..4db3d1bd686c 100644
> > --- a/tools/perf/util/top.c
> > +++ b/tools/perf/util/top.c
> > @@ -28,6 +28,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
> >  	struct record_opts *opts = &top->record_opts;
> >  	struct target *target = &opts->target;
> >  	size_t ret = 0;
> > +	int nr_cpus;
> >  
> >  	if (top->samples) {
> >  		samples_per_sec = top->samples / top->delay_secs;
> > @@ -93,19 +94,17 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
> >  	else
> >  		ret += SNPRINTF(bf + ret, size - ret, " (all");
> >  
> > +	nr_cpus = perf_cpu_map__nr(top->evlist->core.user_requested_cpus);
> >  	if (target->cpu_list)
> >  		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
> > -				perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
> > -				? "s" : "",
> > +				nr_cpus > 1 ? "s" : "",
> >  				target->cpu_list);
> >  	else {
> >  		if (target->tid)
> >  			ret += SNPRINTF(bf + ret, size - ret, ")");
> >  		else
> >  			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
> > -					perf_cpu_map__nr(top->evlist->core.user_requested_cpus),
> > -					perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
> > -					? "s" : "");
> > +					nr_cpus, nr_cpus > 1 ? "s" : "");
> >  	}
> >  
> >  	perf_top__reset_sample_counters(top);
> 

-- 

- Arnaldo

