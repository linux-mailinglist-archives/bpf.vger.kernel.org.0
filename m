Return-Path: <bpf+bounces-74457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A92C5BAAA
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E50C74F2441
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152042E4274;
	Fri, 14 Nov 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrkdr4yo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0E1F91E3;
	Fri, 14 Nov 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103621; cv=none; b=uwuRWST7bEPYHPUZPIMkh5pBVAROVm5zeRMDIh/0rO3CKyoR8bspOE7PqL5j8gcEBrR4aj74+0PDz+OCFbm9RT6/Mk4NvsqAiy1hLpGB3foy87Ui9k2y9WQGLSp0qhMixHJy2xpJcx0RMLN/ZArlb74REq921ZGVZ37tF2IgtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103621; c=relaxed/simple;
	bh=ISwBolgxx7hbnB3Y8sXW5Udjn4UVs3WolZP3+PcKh9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFd61oHEykBDml/M8LyP6ubXvr7KA6fljFPM5qfvPBGtXcvC61DVM5p0lKDALxpV0WIjfR9fDtllKPRld8/KNcstJGPmvNEv4GBGwhruGw/8plevfTDhAyNFXtEEjOJZbG4+aAeczJI61duKHypvu9Po7sDNYXR4CK6mrdOfIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrkdr4yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85E4C4CEFB;
	Fri, 14 Nov 2025 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763103620;
	bh=ISwBolgxx7hbnB3Y8sXW5Udjn4UVs3WolZP3+PcKh9E=;
	h=From:To:Cc:Subject:Date:From;
	b=Jrkdr4yovuwHfBaiqq6cH8Fp9P2fRQM+yJhg2+ZqjPr9BZulmbx78TSz8K0chGKtS
	 GR/mHxqBqNYce2zp4UfoadV7jfxAuRV7kC9a47F8SgY21n6R+4YcgRHkCSjxGfTTWV
	 2QNsSIZEMbh7IZmnnc7N7d2YTVVLUkjxnxmfPxpkRSD+rm8mRyMLA89kz7WF+qHbZx
	 W5ard6xcaTcp4B/G6/H1QVZWTJ01soJcxEcB7vx1/y6tohTBwyQ682iCEKqy0iDv48
	 MUC1hyyNGXmemGYXc1EXdLvFwJcXz7GDBf/Qmr9+SLMk87dI78sNZIrHqI8aX/xKxn
	 ixvfBDnA9TkKQ==
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
Subject: [PATCHSET v3 0/5] perf tools: Add deferred callchain support
Date: Thu, 13 Nov 2025 23:00:13 -0800
Message-ID: <20251114070018.160330-1-namhyung@kernel.org>
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

This version has the following changes.

* handle new attr.defer_output to generate deferred callchains
* fix crash when cookies don't match  (Steven)
* disable merging for perf inject
* fix missing feature detection bug
* symbolize merged callchains properly

Here's an example session.

  $ perf record -g pwd
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
                 b00000006 [unknown] ([unknown])
      
  pwd    2312   121.163447: DEFERRED CALLCHAIN
              7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
  ...

The code is available at 'perf/defer-callchain-v3' branch in

  git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  tools headers UAPI: Sync linux/perf_event.h for deferred callchains
  perf tools: Minimal DEFERRED_CALLCHAIN support
  perf record: Enable defer_callchain for user callchains
  perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
  perf tools: Merge deferred user callchains

 tools/include/uapi/linux/perf_event.h     | 21 +++++-
 tools/lib/perf/include/perf/event.h       |  8 ++
 tools/perf/Documentation/perf-script.txt  |  5 ++
 tools/perf/builtin-inject.c               |  1 +
 tools/perf/builtin-report.c               |  1 +
 tools/perf/builtin-script.c               | 92 +++++++++++++++++++++++
 tools/perf/util/callchain.c               | 29 +++++++
 tools/perf/util/callchain.h               |  3 +
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evlist.c                  |  1 +
 tools/perf/util/evlist.h                  |  2 +
 tools/perf/util/evsel.c                   | 43 +++++++++++
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +
 tools/perf/util/sample.h                  |  2 +
 tools/perf/util/session.c                 | 85 +++++++++++++++++++++
 tools/perf/util/tool.c                    |  2 +
 tools/perf/util/tool.h                    |  4 +-
 19 files changed, 302 insertions(+), 2 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


