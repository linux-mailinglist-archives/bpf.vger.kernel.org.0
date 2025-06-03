Return-Path: <bpf+bounces-59480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F3ACBF42
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370F5171429
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9DB1B424F;
	Tue,  3 Jun 2025 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6VmfHcU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1E78C91;
	Tue,  3 Jun 2025 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748925680; cv=none; b=Lv3E5bhMFCc8+8I7lg4lJz+dIvqu3QGvEmLoAGTiuWPF1AAfsPC1X5YvqyQoG5AvYWMoZGl81Pb/Te/LBzzCdVR+Foa3sl+mcUHuTJk5oSpqUaCzn3CrEkOBACDd+8skbNiMeBKgwRrgmZKdFLWYTkzHIVWJhNU2HaM10NLTkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748925680; c=relaxed/simple;
	bh=/bsiI5KcRVhq7P7NwCyJd77r79UN8srwDIxHx/aYaRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnlpfRoKfcueZsZGueZvIwFjypVhJiSIH8KjShZF8BM5NjnSqr9IKAygxygEYwR8aQCEW6MlLe7fV5SB1kUEJ6Skt94M7mlrAsNLxuT2OG7ETLYzZRoP7TB7U98Zc9GZDkkHuvaWLbkheLDpO/qQq0+qB6XV+RQTdV12LybS/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6VmfHcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72163C4CEED;
	Tue,  3 Jun 2025 04:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748925678;
	bh=/bsiI5KcRVhq7P7NwCyJd77r79UN8srwDIxHx/aYaRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6VmfHcUUefyK2v7foJKTJEwutqdcJVzxRRPryr9HhK2+AaPYexYh8ZIo2d1u442a
	 +zPnoR3nV8d+LyqRTUc+td3qcLIdA2ufaFzxOjmFdLZsmDDmnuGv7Jq7kn4/CQ4zzd
	 wB4t/i7ULyi2hPb04EsU/3SbC/o/Wq433P3CuSn6uNACun2gIGt1cM/LeuiIzj9neM
	 p7Zsoiq+o42dSNbo+3Uw79bwqdou5hpAPg4L3D60Un85tyFdNP1x+QygQmMstkHd8N
	 dQfu+rmrts35aRBKO1kP5TpnEEmcxdSk7KQq5HE5+1vOpxnHgVBPBryV3tEafsylqS
	 c9CoEc7EtnG+w==
Date: Mon, 2 Jun 2025 21:41:15 -0700
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
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
Message-ID: <aD586_XkeOH2_Fes@google.com>
References: <20250425214008.176100-1-irogers@google.com>
 <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>

Hi Ian,

On Tue, May 27, 2025 at 01:39:21PM -0700, Ian Rogers wrote:
> On Fri, Apr 25, 2025 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > BPF filters for uid filtering. The /proc scanning in thread_map is
> > racy as the PID may exit before the perf_event_open causing perf to
> > abort. BPF UID filters are more robust as they avoid the race. The
> > /proc scanning also misses processes starting after the perf
> > command. Add a helper for commands that support UID filtering and wire
> > up. Remove the non-BPF UID filtering support given it doesn't work.
> >
> > v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
> >     tmp.perf-tools-next.
> >
> > v2: Add a perf record uid test (Namhyung) and force setting
> >     system-wide for perf trace and perf record (Namhyung). Ensure the
> >     uid filter isn't set on tracepoint evsels.
> >
> > v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/
> 
> Ping. Thanks,

I'm ok with preferring BPF over /proc scanning, but still hesitate to
remove it since some people don't use BPF.  Can you please drop that
part and make parse_uid_filter() conditional on BPF?

Thanks,
Namhyung

 
> > Ian Rogers (10):
> >   perf parse-events filter: Use evsel__find_pmu
> >   perf target: Separate parse_uid into its own function
> >   perf parse-events: Add parse_uid_filter helper
> >   perf record: Switch user option to use BPF filter
> >   perf tests record: Add basic uid filtering test
> >   perf top: Switch user option to use BPF filter
> >   perf trace: Switch user option to use BPF filter
> >   perf bench evlist-open-close: Switch user option to use BPF filter
> >   perf target: Remove uid from target
> >   perf thread_map: Remove uid options
> >
> >  tools/perf/bench/evlist-open-close.c        | 36 ++++++++------
> >  tools/perf/builtin-ftrace.c                 |  1 -
> >  tools/perf/builtin-kvm.c                    |  2 -
> >  tools/perf/builtin-record.c                 | 27 ++++++-----
> >  tools/perf/builtin-stat.c                   |  4 +-
> >  tools/perf/builtin-top.c                    | 22 +++++----
> >  tools/perf/builtin-trace.c                  | 27 +++++++----
> >  tools/perf/tests/backward-ring-buffer.c     |  1 -
> >  tools/perf/tests/event-times.c              |  8 ++-
> >  tools/perf/tests/keep-tracking.c            |  2 +-
> >  tools/perf/tests/mmap-basic.c               |  2 +-
> >  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
> >  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
> >  tools/perf/tests/openat-syscall.c           |  2 +-
> >  tools/perf/tests/perf-record.c              |  1 -
> >  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
> >  tools/perf/tests/shell/record.sh            | 26 ++++++++++
> >  tools/perf/tests/switch-tracking.c          |  2 +-
> >  tools/perf/tests/task-exit.c                |  1 -
> >  tools/perf/tests/thread-map.c               |  2 +-
> >  tools/perf/util/bpf-filter.c                |  2 +-
> >  tools/perf/util/evlist.c                    |  3 +-
> >  tools/perf/util/parse-events.c              | 33 ++++++++-----
> >  tools/perf/util/parse-events.h              |  1 +
> >  tools/perf/util/python.c                    | 10 ++--
> >  tools/perf/util/target.c                    | 54 +++------------------
> >  tools/perf/util/target.h                    | 15 ++----
> >  tools/perf/util/thread_map.c                | 32 ++----------
> >  tools/perf/util/thread_map.h                |  6 +--
> >  tools/perf/util/top.c                       |  4 +-
> >  tools/perf/util/top.h                       |  1 +
> >  31 files changed, 150 insertions(+), 182 deletions(-)
> >
> > --
> > 2.49.0.850.g28803427d3-goog
> >

