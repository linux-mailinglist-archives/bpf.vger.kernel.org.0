Return-Path: <bpf+bounces-61426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A31AE6F3F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807CB17F935
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7A2E6D1B;
	Tue, 24 Jun 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/xxu/YP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BAF170826;
	Tue, 24 Jun 2025 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792282; cv=none; b=Mlo87QXCzlcAcFNzNQueml5x/5xbKqvlaHexulvS+UQuZ8BQR8Wl1sFCLYkLbmoIBgbSVif01RPz96FGo7lr/OIcADGe5kulKnBk2A2U5ensepqJDzPgGYJQxpR9XyLm6vjz7Sap13Zsb//4OyrMVBrXmEy8a/A4kbNcRie/uhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792282; c=relaxed/simple;
	bh=A8rgEKagyWeVEdJAVjJt38k9kxuz0+r57uXv1TcLXWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0lzO+8kdLWNMDrUwtAi0F6xhT5Ij4br17tJal1/n8+2sKkt2D8+Joo9FEgHlOZ+HYkefM+2mfTO9AciV+lR5QIV71Zeca/WJP9BLa+a++9Er5YiK7ZnvliC7z5kt6zaVd4ESVcFrLyGvc8WIjKC2jGC0TmjHT4Og1kfl1nMtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/xxu/YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F708C4CEE3;
	Tue, 24 Jun 2025 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750792281;
	bh=A8rgEKagyWeVEdJAVjJt38k9kxuz0+r57uXv1TcLXWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/xxu/YPxiwkFDZriQZ5k4RD0x45p5MsMvYsjkvk8RQVIA8BQ86X5v1ztx0vPArnk
	 /fBwg/hHGDbwRE2sRhwbCqPXBgoaa0D94kkyY/B6c5KI/21szKWq0S/CHAC8un9aOz
	 JeBDQMtRBDgEFvti8V/SvGUpL0wnoj0ksbv1Xrsu32l4qrbULXalJPdW4G7u2abBcn
	 IFjRxXoIYFveMptlfNzYFh7s/xqVtQ4Iye/QmdM9e09ToAXTpYiIu1F90fyAUhwFY5
	 CZjshnsZJpjUl5BwbpOi3GSfWRofEKR4nU0VdBtdsA8VhZkLn5AIjTtHRrI8g7VXtx
	 r/qQhyCkQ7wcQ==
Date: Tue, 24 Jun 2025 12:11:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
Message-ID: <aFr4VwxaAi5u5U2F@google.com>
References: <20250607061238.161756-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250607061238.161756-1-irogers@google.com>

On Fri, Jun 06, 2025 at 11:12:34PM -0700, Ian Rogers wrote:
> Pipe mode has no header and emits the data as if it were events. The
> dumping of features was controlled by the --header/-I options which
> makes little sense when they are events, normally traced when
> dump_trace is true. Switch to making pipe feature events also be
> traced with detail when other events are.

I'm not sure I'm following.  Are you saying the pipe mode doesn't
support features with --header/-I option?

It seems to work for me.

  $ git show
  commit be59dba332e1e8edd3e88d991ba0e4795ae2bcb2 (HEAD -> perf-testing)
  Author: Ian Rogers <irogers@google.com>
  Date:   Tue Jun 17 15:33:56 2025 -0700
  
      libperf evsel: Add missed puts and asserts
      
      A missed evsel__close before evsel__delete was the source of leaking
      perf events due to a hybrid test. Add asserts in debug builds so that
      this shouldn't happen in the future. Add puts missing on the cpu map
      and thread maps.
      
      Signed-off-by: Ian Rogers <irogers@google.com>
      Link: https://lore.kernel.org/r/20250617223356.2752099-4-irogers@google.com
      Signed-off-by: Namhyung Kim <namhyung@kernel.org>
  
  $ ./perf version
  perf version 6.16.rc3.gbe59dba332e1
  
  $ ./perf record -o- true | ./perf report -i- --header-only
  # ========
  # captured on    : Tue Jun 24 12:06:38 2025
  # header version : 1
  # data offset    : 0
  # data size      : 0
  # feat offset    : 0
  # ========
  #
  # hostname : bangji
  # os release : 6.12.20-1rodete1-amd64
  # perf version : 6.16.rc3.gbe59dba332e1
  # arch : x86_64
  # nrcpus online : 4
  # nrcpus avail : 8
  # cpudesc : 11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz
  # cpuid : GenuineIntel,6,140,1
  # total memory : 32566540 kB
  # cmdline : /home/namhyung/project/linux/tools/perf/perf record -o- true 
  # event : name = cycles:P, , id = { 369, 370, 371, 372 }, type = 0 (PERF_TYPE_HARDWARE), ...
  # CPU_TOPOLOGY info available, use -I to display
  # NUMA_TOPOLOGY info available, use -I to display
  # pmu mappings: cpu = 4, breakpoint = 5, cstate_core = 22, cstate_pkg = 23, hwmon_acpitz = 4294901760, ...
  # time of first sample : 0.000000
  # time of last sample : 0.000000
  # sample duration :      0.000 ms
  # MEM_TOPOLOGY info available, use -I to display
  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
  # intel_pt pmu capabilities: topa_multiple_entries=1, psb_cyc=1, single_range_output=1, ...
  
> 
> The attr event in pipe mode had no dumping, wire this up and use the
> existing perf_event_attr fprintf support.
> 
> The header's bpf_prog_info or bpf_btf may be empty when written. If
> they are empty just skip writing them to save space.

These look good to me.

Thanks,
Namhyung

> 
> Ian Rogers (4):
>   perf header: In pipe mode dump features without --header/-I
>   perf header: Allow tracing of attr events
>   perf header: Display message if BPF/BTF info is empty
>   perf header: Don't write empty BPF/BTF info
> 
>  tools/perf/util/header.c | 46 ++++++++++++++++++++++++++--------------
>  tools/perf/util/header.h |  1 +
>  2 files changed, 31 insertions(+), 16 deletions(-)
> 
> -- 
> 2.50.0.rc0.604.gd4ff7b7c86-goog
> 

