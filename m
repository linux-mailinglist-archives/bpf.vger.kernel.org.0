Return-Path: <bpf+bounces-75126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C35C71C9F
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6359C4E54C4
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F929C351;
	Thu, 20 Nov 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSnB/Pj1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8829293D;
	Thu, 20 Nov 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604649; cv=none; b=IzN3INRTVzXqlBOKvV0A36wzEaSf2QJ5OFK9MM3oX4pO6vb1qWZ/Xn1VsEpvfrRRUqRbEXWGGqvGMO1xCCzJjlZIZzx/1cY+ANFAwMvfsUc6LVSt6BQ4lUcW19QOnpaRb+/HfGpYhanCx2NpGWWffkED+5u7kdEXjX4RCgkKhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604649; c=relaxed/simple;
	bh=wmxKNgOjkxVsjYwcUFsQJIQOmPj8AtmwO5pYfTRRrqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdXWkzEDe8dgdz8vF9ZsRz0kNdd46CglrMbxDphq5fK+lwo+391VMxPqpkTkHtp/j+YIbYqZ6f4pEkuAGMYjxL5rKB/Ze5cgt/1a6H2H1GCCb4HT8F2/f8Xu5JwmrlsxzdbpLthyfLYIumZEZ/GDvKhmYgYT3F6JqZgF/oWD9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSnB/Pj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9C4C19421;
	Thu, 20 Nov 2025 02:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604648;
	bh=wmxKNgOjkxVsjYwcUFsQJIQOmPj8AtmwO5pYfTRRrqY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZSnB/Pj111tbOL8O1FQ9VXTrwTnNA+MTx7t2u6C4Zj8AqlYsvJBZr2Iv4G7W+dzlM
	 G1QtQHCUdbzuUJiQK76S2Hcn7wXoDWrDaVychAPT7ggK85ocGcUugO5Dk3P6qCiqL6
	 TLq+4G99z0/jS4ZLJ0lNUhyOUrvHwrmWaDgwtuYJW7MjzTDFfjP4Dfa8nhAqE33I0F
	 iJGCokCCkFQQ+/KQeAH0nsKY/YZvIkkswBDgAQA3AvDn27fQBr5RKPSc9IdgxviyKN
	 AuplRA0uZGHqZhsIeFAZkz1Ipa/g9BX+SpYiia4b3qRTBG87VWc8TaSy3PV+HZmzXu
	 7CB9BUFsvZeRA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCHSET v5 0/6] perf tools: Add deferred callchain support
Date: Wed, 19 Nov 2025 18:10:40 -0800
Message-ID: <20251120021046.94490-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a new version of deferred callchain support as the kernel part
is merged to the tip tree.  Actually this is based on Steve's work (v16).

  https://lore.kernel.org/r/20250908175319.841517121@kernel.org

v5 changes)

* update delegate tools  (Ian)
* copy and flush remaining samples  (Ian)
* add Ian's Reviewed-by tags

v4: https://lore.kernel.org/r/20251115234106.348571-1-namhyung@kernel.org

* add --call-graph fp,defer option   (Ian, Steve)
* add more comment on the cookie  (Ian)
* display cookie part in the deferred callchain  (Ian)

v3: https://lore.kernel.org/r/20251114070018.160330-1-namhyung@kernel.org

* handle new attr.defer_output to generate deferred callchains
* fix crash when cookies don't match  (Steven)
* disable merging for perf inject
* fix missing feature detection bug
* symbolize merged callchains properly

Here's an example session.

  $ perf record --call-graph fp,defer  pwd
  /home/namhyung/project/linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.010 MB perf.data (29 samples) ]

  $ perf evlist -v
  cpu/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES),
  { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|PERIOD,
  read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1,
  task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, build_id: 1,
  defer_callchain: 1, defer_output: 1

  $ perf script
  ...
  pwd    2312   121.163435:     249113 cpu/cycles/P:
          ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsyms])
          ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
          ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
          ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
          ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
          ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
          ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
              7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
  ...

  $ perf script --no-merge-callchains
  ...
  pwd    2312   121.163435:     249113 cpu/cycles/P:
          ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsyms])
          ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
          ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
          ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
          ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
          ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
          ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
                 b00000006 (cookie) ([unknown])

  pwd    2312   121.163447: DEFERRED CALLCHAIN [cookie: b00000006]
              7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
  ...

The code is available at 'perf/defer-callchain-v5' branch in

  git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  tools headers UAPI: Sync linux/perf_event.h for deferred callchains
  perf tools: Minimal DEFERRED_CALLCHAIN support
  perf record: Add --call-graph fp,defer option for deferred callchains
  perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
  perf tools: Merge deferred user callchains
  perf tools: Flush remaining samples w/o deferred callchains

 tools/include/uapi/linux/perf_event.h     |  21 ++-
 tools/lib/perf/include/perf/event.h       |  13 ++
 tools/perf/Documentation/perf-config.txt  |   3 +
 tools/perf/Documentation/perf-record.txt  |   4 +
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-inject.c               |   1 +
 tools/perf/builtin-report.c               |   1 +
 tools/perf/builtin-script.c               |  93 +++++++++++
 tools/perf/util/callchain.c               |  45 +++++-
 tools/perf/util/callchain.h               |   4 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   2 +
 tools/perf/util/evsel.c                   |  50 +++++-
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/evsel_fprintf.c           |   5 +-
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +
 tools/perf/util/sample.h                  |   2 +
 tools/perf/util/session.c                 | 183 ++++++++++++++++++++++
 tools/perf/util/tool.c                    |   5 +
 tools/perf/util/tool.h                    |   4 +-
 22 files changed, 439 insertions(+), 8 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


