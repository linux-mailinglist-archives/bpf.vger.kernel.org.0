Return-Path: <bpf+bounces-7811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2877CE04
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8C82814DB
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C5134DC;
	Tue, 15 Aug 2023 14:25:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9D5C9D;
	Tue, 15 Aug 2023 14:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D9FC433C8;
	Tue, 15 Aug 2023 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692109528;
	bh=coObV9y/RYS3AiSNn8u13h8zoAh7+fxjKoeBOZzSR9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jyvy+H7ssDO2P5B/nS4Sc2bspYwRxSNsTRDI+ZodIPUfCNJcmo/Of3p8kOorKTxUs
	 eRM/jzo7f9zNOI0mgx36unEe+oIA3yaUSUd2qNpge/UbziBLmuYQLvNPosoOobv2dQ
	 AfNuScxOGKv8xlTk6TTHR4JDnUsAF4iZuepIDxItyzW5618GCTPewpu9gaYo6a5o0U
	 /SvSbs7MZ2AKaZpbogI+kljbfBzjoX6GnbFizCB3bckrMeX7welOSI6LW7wusVYFSh
	 Db9JWBESivJmEWHewjC8O7qmsfcp0g2bctBSZnN4msw1MhaDr4mdRD8+4DWf9vHxUB
	 jrU77Ync1/adg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id DACE6404DF; Tue, 15 Aug 2023 11:25:25 -0300 (-03)
Date: Tue, 15 Aug 2023 11:25:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a
 skeleton
Message-ID: <ZNuK1TFwdjyezV3I@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810184853.2860737-3-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Thu, Aug 10, 2023 at 11:48:51AM -0700, Ian Rogers escreveu:
> Previously a BPF event of augmented_raw_syscalls.c could be used to
> enable augmentation of syscalls by perf trace. As BPF events are no
> longer supported, switch to using a BPF skeleton which when attached
> explicitly opens the sysenter and sysexit tracepoints.
> 
> The dump map is removed as debugging wasn't supported by the
> augmentation and bpf_printk can be used when necessary.
> 
> Remove tools/perf/examples/bpf/augmented_raw_syscalls.c so that the
> rename/migration to a BPF skeleton captures that this was the source.
> +#ifdef HAVE_BPF_SKEL
> +	trace.skel = augmented_raw_syscalls_bpf__open();
> +	if (!trace.skel) {
> +		pr_debug("Failed to open augmented syscalls BPF skeleton");
> +	} else {
> +		/*
> +		 * Disable attaching the BPF programs except for sys_enter and
> +		 * sys_exit that tail call into this as necessary.
> +		 */
> +		bpf_program__set_autoattach(trace.skel->progs.syscall_unaugmented,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_connect,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_sendto,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_open,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_openat,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_rename,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_renameat,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_perf_event_open,
> +					    /*autoattach=*/false);
> +		bpf_program__set_autoattach(trace.skel->progs.sys_enter_clock_nanosleep,
> +					    /*autoattach=*/false);
> +
> +		err = augmented_raw_syscalls_bpf__load(trace.skel);
>  

So I converted the above to:

		struct bpf_program *prog;

		bpf_object__for_each_program(prog, trace.skel->obj) {
			if (prog != trace.skel->progs.sys_enter && prog != trace.skel->progs.sys_exit)
				bpf_program__set_autoattach(prog, /*autoattach=*/false);
		}

So that we don't have to add new lines disabling attachment when adding
support for other pointer receiving syscalls.

- Arnaldo

