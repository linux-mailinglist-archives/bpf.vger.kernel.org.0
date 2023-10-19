Return-Path: <bpf+bounces-12688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8520A7CF607
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A5C281F81
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DB18B10;
	Thu, 19 Oct 2023 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glxnQJzH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F818AE1;
	Thu, 19 Oct 2023 11:02:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A586A112;
	Thu, 19 Oct 2023 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697713335; x=1729249335;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dS7MBxgFMsSLS+p8OyIgAOLuaoqyA0fOLFfs16p9U9o=;
  b=glxnQJzHnwK2nGIZx0u9JSK8g1exn4Kp+xckDxFnk2uuCNqnyZu0r+XX
   Y8h2FWMs/hpZRD07WmNyzGoQYi4EJVmeKuuWzpj6XA+BNyxcgI9PlMJd4
   hO8kG5OmW2uh3SBK+kWmC0OUMz/lrTMMilS9GGo2cROmT2UjeKlFp/SbQ
   76qNU4EXMPfnrgVuz/MG9PIteX8KGRfz4u/JZ3+V4g4MzhV4KoR4zi6Rz
   MDqVxSnpBsG4TW9zQmsxK27jkQa0t3v8OpwcEubZKYZAg1SahrWyxUgju
   PCVElCGkuqQfuDa9fm6w4psd/5rfgHb53eCYfh/ZvLFYKgWeUxwNqaPOx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366464129"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="366464129"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 04:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760603065"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760603065"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.14])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 04:02:09 -0700
Message-ID: <f184e872-4673-419d-9ea8-2d449d9cfd5b@intel.com>
Date: Thu, 19 Oct 2023 14:02:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] perf record: Lazy load kernel symbols
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>,
 Song Liu <song@kernel.org>, Sandipan Das <sandipan.das@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Artem Savkov <asavkov@redhat.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andi Kleen
 <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20231012062359.1616786-1-irogers@google.com>
 <20231012062359.1616786-11-irogers@google.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231012062359.1616786-11-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/23 09:23, Ian Rogers wrote:
> Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
> changed it so that loading a kernel dso would cause the symbols for
> the dso to be eagerly loaded. For perf record this is overhead as the
> symbols won't be used. Add a symbol_conf to control the behavior and
> disable it for perf record and perf inject.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c   | 4 ++++
>  tools/perf/builtin-record.c   | 2 ++
>  tools/perf/util/event.c       | 4 ++--
>  tools/perf/util/symbol_conf.h | 3 ++-
>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c8cf2fdd9cff..1539fb18c749 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2265,6 +2265,10 @@ int cmd_inject(int argc, const char **argv)
>  		"perf inject [<options>]",
>  		NULL
>  	};
> +
> +	/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
> +	symbol_conf.lazy_load_kernel_maps = true;

Possibly not for itrace kernel decoding, so:

	if (!inject->itrace_synth_opts.set)
		symbol_conf.lazy_load_kernel_maps = true;

> +
>  #ifndef HAVE_JITDUMP
>  	set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
>  #endif
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..8ec818568662 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>  # undef set_nobuild
>  #endif
>  
> +	/* Disable eager loading of kernel symbols that adds overhead to perf record. */
> +	symbol_conf.lazy_load_kernel_maps = true;
>  	rec->opts.affinity = PERF_AFFINITY_SYS;
>  
>  	rec->evlist = evlist__new();
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 923c0fb15122..68f45e9e63b6 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
>  		al->level = 'k';
>  		maps = machine__kernel_maps(machine);
> -		load_map = true;
> +		load_map = !symbol_conf.lazy_load_kernel_maps;
>  	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
>  		al->level = '.';
>  	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
>  		al->level = 'g';
>  		maps = machine__kernel_maps(machine);
> -		load_map = true;
> +		load_map = !symbol_conf.lazy_load_kernel_maps;
>  	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
>  		al->level = 'u';
>  	} else {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 0b589570d1d0..2b2fb9e224b0 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -42,7 +42,8 @@ struct symbol_conf {
>  			inline_name,
>  			disable_add2line_warn,
>  			buildid_mmap2,
> -			guest_code;
> +			guest_code,
> +			lazy_load_kernel_maps;
>  	const char	*vmlinux_name,
>  			*kallsyms_name,
>  			*source_prefix,


