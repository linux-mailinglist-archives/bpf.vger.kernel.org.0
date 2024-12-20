Return-Path: <bpf+bounces-47464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24339F9A5E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3430B189330D
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463262288C4;
	Fri, 20 Dec 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H++3vzxz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70552210C0;
	Fri, 20 Dec 2024 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722440; cv=none; b=kyw6Z3GOU3i0RiSFEtHtoWr4Q+DnS473ElPAdK4xXgyT+veKr5DbX0vG9TcldinvLLQYdN9UjtIYhKtscuiOTt4dM9FQGXPw6Ldwt5/kh+H56eNm1NBq5vRtMAyhsgXmVOMng8v5X4kPPMDO6dH3Xu0X+TX8wUSpsyTQ03KL32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722440; c=relaxed/simple;
	bh=8XbdBcK3RoQ29Q3VwBSaVOI51Tab2e3sofg0RlarLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcFwd/tx6KKF9Ds1CDdUtoqyjfW39R2iB1K0qxx4p+xM7Yfbrfwz3nOY6yol31Uxg5MQ/kw5xZ4Mcp17LHQVhvbOA2ggHXlC086725AThTaG0E/bQ50vJY3Xcbnug5aDgwTuonqE9Js7veSot+W2lK66TZgnI3lSb4iSJZx9bLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H++3vzxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384F5C4CECD;
	Fri, 20 Dec 2024 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734722440;
	bh=8XbdBcK3RoQ29Q3VwBSaVOI51Tab2e3sofg0RlarLnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H++3vzxzY6lrc9JZ87oEZGsCSBoH2fPiwmDg/zOlK1d3G6zDy2tXm/wiNw5myOerx
	 NvEEzKA6zbeZvNy9hXwePCGVHjR0B5uAW2K/tZ7ccwXsRxuzXSfnQWeomH7rY+Cs0U
	 RomiXeA4uGcoCPLbeXbuhvZ2Sqboov9dBjeh4zy5P/EAdzZ9ezyG/zSG3nMiki+747
	 E5tSrKx+mYBjCfWBNz96lxv6HNOzTgwHguvASpWnpDUKEcr3lJxDZj8C3JbAWMyPYm
	 WpA46tlvK5HIOnQrNKBT2RbqdlBa9AxKiacP61E4vDpxv2u0oBlYaQ8kSmIOjy1DLM
	 2n2mgFCIQ43+w==
Date: Fri, 20 Dec 2024 16:20:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>
Subject: Re: [PATCH v3 0/4] perf lock contention: Symbolize locks using slab
 cache names
Message-ID: <Z2XDhXZsfUVtU7MY@x1>
References: <20241220060009.507297-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220060009.507297-1-namhyung@kernel.org>

On Thu, Dec 19, 2024 at 10:00:05PM -0800, Namhyung Kim wrote:
> Hello,
> 
> This is to support symbolization of dynamic locks using slab
> allocator's metadata.  The kernel support is merged to v6.13.
> 
> It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
> kfunc to get the information from an address.  The feature detection is
> done using BTF type info and it won't have any effect on old kernels.
> 
> v3 changes)
> 
>  * fix build error with GEN_VMLINUX_H=1  (Arnaldo)

Thanks, applied to perf-tools-next,

- Arnaldo

>  * update comment to explain slab cache ID  (Vlastimil)
>  * add Ian's Acked-by
> 
> v2) https://lore.kernel.org/linux-perf-users/20241108061500.2698340-1-namhyung@kernel.org
> 
>  * don't use libbpf_get_error()  (Andrii)
> 
> v1) https://lore.kernel.org/linux-perf-users/20241105172635.2463800-1-namhyung@kernel.org
> 
> With this change, it can show locks in a slab object like below.  I
> added "&" sign to distinguish them from global locks.
> 
>     # perf lock con -abl sleep 1
>      contended   total wait     max wait     avg wait            address   symbol
> 
>              2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
>              1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
>              4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
>              2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
>              3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)
>              3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   text_mutex (mutex)
>              1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   tracepoint_srcu_srcu_usage (mutex)
>              2       362 ns       239 ns       181 ns   ffffffffa41cf840   pcpu_alloc_mutex (mutex)
>              1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   &signal_cache (mutex)
>              1       215 ns       215 ns       215 ns   ffffffffa41b4c28   tracepoint_srcu_srcu_usage (mutex)
> 
> The first two were from "task_struct" slab cache.  It happened to
> match with the type name of object but there's no guarantee.  We need
> to add type info to slab cache to resolve the lock inside the object.
> Anyway, the third one has no dedicated slab cache and was allocated by
> kmalloc.
> 
> Those slab objects can be used to filter specific locks using -L or
>  --lock-filter option.  (It needs quotes to avoid special handling in
> the shell).
> 
>     # perf lock con -ab -L '&task_struct' sleep 1
>        contended   total wait     max wait     avg wait         type   caller
> 
>                1     25.10 us     25.10 us     25.10 us        mutex   perf_event_exit_task+0x39
>                1     21.60 us     21.60 us     21.60 us        mutex   futex_exit_release+0x21
>                1      5.56 us      5.56 us      5.56 us        mutex   futex_exec_release+0x21
> 
> The code is available at 'perf/lock-slab-v3' branch in my tree
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf lock contention: Add and use LCB_F_TYPE_MASK
>   perf lock contention: Run BPF slab cache iterator
>   perf lock contention: Resolve slab object name using BPF
>   perf lock contention: Handle slab objects in -L/--lock-filter option
> 
>  tools/perf/builtin-lock.c                     |  39 ++++-
>  tools/perf/util/bpf_lock_contention.c         | 140 +++++++++++++++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  95 +++++++++++-
>  tools/perf/util/bpf_skel/lock_data.h          |  15 +-
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   8 +
>  tools/perf/util/lock-contention.h             |   2 +
>  6 files changed, 292 insertions(+), 7 deletions(-)
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog

