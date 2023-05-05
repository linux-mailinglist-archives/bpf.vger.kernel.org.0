Return-Path: <bpf+bounces-151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938586F8B17
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA2281073
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EADF58;
	Fri,  5 May 2023 21:33:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC78BE73
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DC4C433D2;
	Fri,  5 May 2023 21:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683322409;
	bh=M4kahhFPmrKwLmC+dwLRPb9KCPDgd7YIFYm187tld3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5spICSYMMdXNA9wHyGc+FulwdcXkR8owOHc+m9ihjvpDcUM0ZP+xGyFkDCDTae+p
	 qeg31jfxTIBoDPNErCo0O6lh81M5Y51fCeh8XMuY2YJA6g//xr1X+vI8RgTBe8Ffh3
	 rWT8e4hMgwgyA7aaxdroUzKRpBPz6meLsKarHStHqlWKQBYmcAgd8K4y8yWBCfRjcU
	 SqJv9W7XEu4pYQVDMTr+y1+OdQieT2eViMMSzqic7JRJwsJwSfsCE8GzTU+qNpHpgI
	 kaYlbYox6jL/K2mpdGlPkneCGW4w15X/lWnlSFqQs7RkAgdTWrwmeSOPzatqYDU0bB
	 7bNKd+k1o3SSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B359C403B5; Fri,  5 May 2023 18:33:26 -0300 (-03)
Date: Fri, 5 May 2023 18:33:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFV2JhBV6xyLm7xg@kernel.org>
References: <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <ZFUFmxDU/6Z/JEsi@kernel.org>
 <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFVqeKLssg7uzxzI@krava>
X-Url: http://acmel.wordpress.com

Em Fri, May 05, 2023 at 10:43:36PM +0200, Jiri Olsa escreveu:
> On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > On Fri, May 5, 2023 at 9:56 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > That with the preserve_access_index isn't needed, we need just the
> > > > fields that we access in the tools, right?
> > >
> > > I'm now doing build test this in many distro containers, without the two
> > > reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> > > test build and also for the functionality tests on the tools using such
> > > bpf skels, see below, no touching of vmlinux nor BTF data during the
> > > build.
> > >
> > > - Arnaldo
> > >
> > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2001
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated from BTF,
> > >  use subset of used structs + CO-RE
> > >
> > > Linus reported a build break due to using a vmlinux without a BTF elf
> > > section to generate the vmlinux.h header with bpftool for use in the BPF
> > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > >
> > > Instead add a vmlinux.h file with the structs needed with the fields the
> > > tools need, marking the structs with __attribute__((preserve_access_index)),
> > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > >
> > > In some cases the vmlinux.h file that was being generated by bpftool
> > > from the kernel BTF information was not needed at all, just including
> > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > types were not being used.
> > >
> > > To keep te patch small, include those UAPI headers from the trimmed down
> > > vmlinux.h file, that then provides the tools with just the structs and
> > > the subset of its fields needed for them.
> > >
> > > Testing it:
> > >
> > >   # perf lock contention -b find / > /dev/null
> 
> I tested perf lock con -abv -L rcu_state sleep 1
> and needed fix below
> 
> jirka

patch not applying trying to do it manually.

- Arnaldo
 
> 
> ---
> From b12aea55f1171dc09cde2957f9019c84bda7adbb Mon Sep 17 00:00:00 2001
> From: Jiri Olsa <jolsa@kernel.org>
> Date: Fri, 5 May 2023 13:28:46 +0200
> Subject: [PATCH] perf tools: Fix lock_contention bpf program
> 
> We need to define empty 'struct rq' so the runqueues gets
> resolved properly:
> 
>   # ./perf lock con -b
>   libbpf: extern (var ksym) 'runqueues': incompatible types, expected [99] fwd rq, but kernel has [19783] struct rq
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
>   Failed to load lock-contention BPF skeleton
> 
> Also rq__old/rq__new need additional '_' so the suffix is ignored
> properly.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 8911e2a077d8..c2bf24c68c14 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -416,13 +416,15 @@ int contention_end(u64 *ctx)
>  	return 0;
>  }
>  
> +struct rq {};
> +
>  extern struct rq runqueues __ksym;
>  
> -struct rq__old {
> +struct rq___old {
>  	raw_spinlock_t lock;
>  } __attribute__((preserve_access_index));
>  
> -struct rq__new {
> +struct rq___new {
>  	raw_spinlock_t __lock;
>  } __attribute__((preserve_access_index));
>  
> @@ -434,8 +436,8 @@ int BPF_PROG(collect_lock_syms)
>  
>  	for (int i = 0; i < MAX_CPUS; i++) {
>  		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
> -		struct rq__new *rq_new = (void *)rq;
> -		struct rq__old *rq_old = (void *)rq;
> +		struct rq___new *rq_new = (void *)rq;
> +		struct rq___old *rq_old = (void *)rq;
>  
>  		if (rq == NULL)
>  			break;
> -- 
> 2.40.1
> 

-- 

- Arnaldo

