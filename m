Return-Path: <bpf+bounces-59828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4859CACFB54
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFFC1898CD5
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BA1DDC33;
	Fri,  6 Jun 2025 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnb7XpJZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638EF7FD;
	Fri,  6 Jun 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177849; cv=none; b=HGEWeXpTIyLJC04ifEM6LJH/JSkDGU8hP1xJOyU5yxGu9ft9Oui0VEb584vH/dTeeAwaBkAGgJ+Gh8haRaeN+lhsElcx5c70G3JK42q2hqmlPwwF+oEWuu8lO0jmn8OvyZHGQG65xmStBSe74ns+ljxkPC1zRUXjb8zzmXlLTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177849; c=relaxed/simple;
	bh=n4s9I5oBH0Ds6zdVWzWpq5dfQH24U9msWd0nmP1p8XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSfGFJWXPli8nHkyzoODKjuXUgEPrWNMS8ufWbm70kX20fxVF/3Dv7gHTIJKm8nNZINWfS/OWGGVOFYe7308cMU2IdJUm8jNw6lnvdU/wTIzvPgicMgDMvPNxEGVRp2NQuxvk91d8fZhM+frEYaZEgrnpsX5E7kDfmpb43Ul2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnb7XpJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45E9C4CEE7;
	Fri,  6 Jun 2025 02:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749177848;
	bh=n4s9I5oBH0Ds6zdVWzWpq5dfQH24U9msWd0nmP1p8XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnb7XpJZUBVO7XX4XeozSlTZNgvY/nZOkxfQwaIBlvvVh5A9RYuSI1PeirljQW23l
	 fxhw7UBPoKDsmhyP9fC+Q7Ele6zbFwusRPr5x9J0QtS8cebnCnBqUxa+t2DRNDbSXI
	 7mB6r+OXtZ6dzkyM70biUhNVeeYGWlXGppWXkGj4nVOmYIg8a9jvGproHCc8iye6WQ
	 yJV06gioxtnN4nDNeV8m9+r5PRSmiieCJGSVOycRLZQufrV3jQFy3lGQj2lCRCfru0
	 3uaw1Qy75lpbxkwEeJCCd3yTyZtTPxT4dgJ6o2wdmbYUyHoOYUZ9glGNRt3OB58Uok
	 z3uOyijeIStjw==
Date: Thu, 5 Jun 2025 19:44:06 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>,
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Move uid filtering to BPF filters
Message-ID: <aEJV9i0AptY81GfS@google.com>
References: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>

Hi Ian,

On Wed, Jun 04, 2025 at 10:45:34AM -0700, Ian Rogers wrote:
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. The
> /proc scanning also misses processes starting after the perf
> command. Add a helper for commands that support UID filtering and wire
> up. Remove the non-BPF UID filtering support given it doesn't work.
> 
> v4: Add a warning message on top of Namhyung's BPF filter error message:
> https://lore.kernel.org/lkml/20250604054234.23608-1-namhyung@kernel.org/
>     in the parse_uid_filter helper. In TUI the warning is shown then
>     the BPF error shown, with stdio the warning appears below the BPF
>     errors.
> 
> v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
>     tmp.perf-tools-next.
> 
> v2: Add a perf record uid test (Namhyung) and force setting
>     system-wide for perf trace and perf record (Namhyung). Ensure the
>     uid filter isn't set on tracepoint evsels.
> 
> v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/
> 
> Ian Rogers (10):
>   perf parse-events filter: Use evsel__find_pmu
>   perf target: Separate parse_uid into its own function
>   perf parse-events: Add parse_uid_filter helper
>   perf record: Switch user option to use BPF filter
>   perf tests record: Add basic uid filtering test
>   perf top: Switch user option to use BPF filter
>   perf trace: Switch user option to use BPF filter
>   perf bench evlist-open-close: Switch user option to use BPF filter
>   perf target: Remove uid from target
>   perf thread_map: Remove uid options

I've noticed two things.

* it takes a quite long time to load the BPF filter.  Not sure what's
  the issue, but maybe annoying for users.

* normal users cannot use BPF filter even if the BPF is loaded and
  pinned already.  It works fine for perf record.

I don't think the issues are from this change though.

Thanks,
Namhyung

> 
>  tools/perf/bench/evlist-open-close.c        | 36 ++++++++------
>  tools/perf/builtin-ftrace.c                 |  1 -
>  tools/perf/builtin-kvm.c                    |  2 -
>  tools/perf/builtin-record.c                 | 27 ++++++-----
>  tools/perf/builtin-stat.c                   |  4 +-
>  tools/perf/builtin-top.c                    | 22 +++++----
>  tools/perf/builtin-trace.c                  | 27 +++++++----
>  tools/perf/tests/backward-ring-buffer.c     |  1 -
>  tools/perf/tests/event-times.c              |  8 ++-
>  tools/perf/tests/keep-tracking.c            |  2 +-
>  tools/perf/tests/mmap-basic.c               |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
>  tools/perf/tests/openat-syscall.c           |  2 +-
>  tools/perf/tests/perf-record.c              |  1 -
>  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
>  tools/perf/tests/shell/record.sh            | 26 ++++++++++
>  tools/perf/tests/switch-tracking.c          |  2 +-
>  tools/perf/tests/task-exit.c                |  1 -
>  tools/perf/tests/thread-map.c               |  2 +-
>  tools/perf/util/bpf-filter.c                |  2 +-
>  tools/perf/util/evlist.c                    |  3 +-
>  tools/perf/util/parse-events.c              | 47 +++++++++++++-----
>  tools/perf/util/parse-events.h              |  1 +
>  tools/perf/util/python.c                    | 10 ++--
>  tools/perf/util/target.c                    | 54 +++------------------
>  tools/perf/util/target.h                    | 15 ++----
>  tools/perf/util/thread_map.c                | 32 ++----------
>  tools/perf/util/thread_map.h                |  6 +--
>  tools/perf/util/top.c                       |  4 +-
>  tools/perf/util/top.h                       |  1 +
>  31 files changed, 164 insertions(+), 182 deletions(-)
> 
> -- 
> 2.50.0.rc0.604.gd4ff7b7c86-goog
> 

