Return-Path: <bpf+bounces-63744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD28B0A8AC
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5DAA8767D
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957292E7171;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOzc0Kno"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6A2E5433;
	Fri, 18 Jul 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856980; cv=none; b=Kuw/sWGXlAQzQYNjDWi6XHe1vqIrNB1VhatU+X086mIWhq8PQ5bkaDjFkO97Vf9KyhtbLkWcRtvU+GjnjpknGcgbDoZzW3PUILIo7FHXFFBtlJi5TNguqCN/r0v5DJCEnbuAlgo4GWEB4s0Dl/XxOHQ8Wftt6SLfjEV6PbsT2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856980; c=relaxed/simple;
	bh=bE+eAgrZ3LfmBx40aBbR03Bt5Aui65kGfAn0UrENcUs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cSGDJp1fH2FG40+UWHatjkUk9hVwl9GwFQGltiz24iX9gkt7VhqNyPwnSnkECWCANYUSgGM8lTHbPDw4RZCoEkFiDA9+ZPAVgNNh1RgEUn8OIFjwLqpl93epHfXyZALzmZDKzMJk10OwFL7Ll7hwiKVnn75b1bQxEazY++uFImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOzc0Kno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85620C4CEEB;
	Fri, 18 Jul 2025 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856979;
	bh=bE+eAgrZ3LfmBx40aBbR03Bt5Aui65kGfAn0UrENcUs=;
	h=Date:From:To:Cc:Subject:From;
	b=NOzc0KnouEJNPflqi5tZeAy2XMkZX65fRsNE1yNYB52WJO4++dqhIjiuaIeVQRDYN
	 9jm37XLjvEksuLFTY5hhOHBu2Rr0IWiMTm2iIp3Gvw33beB1GKbaxv/CXJmfpt7DqD
	 ovTnlZbDRC9LLrjiy4Lv3APtZyGvSkJ2TtETY6qVaNMB0GQM5KnUh/kRjJOWQLDB0h
	 XddhnG/UXkjz5jLibZtSuUQpYY8sKZXzBUief+GQxyRtLWz6y6sWCoAYvkjvE/fLCD
	 j6wDUAO+haLHaJurmc4bEc4yE+c5q/XMjD19nKTZo4AI25LyMupXC2eKqNExrtL/ox
	 JQte9mhghtKTw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucoB9-00000007JVo-0pvE;
	Fri, 18 Jul 2025 12:43:23 -0400
Message-ID: <20250718164119.089692174@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 12:41:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v14 00/11] perf: Support the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This is based on top of the deferred unwind core patch series:

 https://lore.kernel.org/linux-trace-kernel/20250717004910.297898999@kernel.org/
   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
     unwind/core

This series implements the perf interface to use deferred user space stack
tracing.

The first 5 patches are clean ups and simplifications. There's a standalone
series with these patches here:

  https://lore.kernel.org/linux-trace-kernel/20250717173125.434618999@kernel.org/


Patch 6 implements a task deferred tracing that works with events following
a specific task (per thread).

Patch 7 implements a per CPU deferred tracing that requires the application
(perf user space) to have a per CPU event buffer for every CPU where a task
may migrate to from the time a deferred request is made to when the stack
trace occurs, as a task may migrate to a different CPU after the request and
before it goes back to user space.

The rest of the patches implement the tool side of perf.

KNOWN ISSUES:

- The marker that adds the USER_DEFERRED when the request was made, should
  also add the cookie. As the cookie can be used to figure out if dropped
  events missed a stack trace and not to attach a stack trace to the wrong
  events.

- The writing of the stack trace should probably be changed to act more like
  get_perf_callchain() where it does fixups to uprobes.

The code for this series is located here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/perf

Head SHA1: 5753b61c16f61e50f35bf0f3dfbf8a00b8de2d51

Changes since v13: https://lore.kernel.org/linux-trace-kernel/20250708020003.565862284@kernel.org/

- Missed one location to replace the current->mm == NULL check that still
  only checked PF_KTHREAD. It must also check PF_USER_WORKER.

- Need to copy the trace.entries[] one a at a time as the perf entry in
  the ring buffer has 64 bit entries, but trace.entries[] are size long.
 
- Added back the cookie field in perf_callchain_deferred_event structure
  (Note, it was a timestamp before) (Namhyung Kim)
 
- Add the cookie to the comment explaining perf_callchain_deferred_event.

- Fixed deferred_unwind_request() to return 1 if the request was already
  queued or was already executed to not incorrectly increment
  nr_no_switch_fast.

- Display the cookie in the -D output


Josh Poimboeuf (5):
      perf: Remove get_perf_callchain() init_nr argument
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if the task is a kernel thread
      perf: Support deferred user callchains

Namhyung Kim (4):
      perf tools: Minimal CALLCHAIN_DEFERRED support
      perf record: Enable defer_callchain for user callchains
      perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
      perf tools: Merge deferred user callchains

Steven Rostedt (2):
      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
      perf: Support deferred user callchains for per CPU events

----
 include/linux/perf_event.h                |  13 +-
 include/uapi/linux/perf_event.h           |  20 +-
 kernel/bpf/stackmap.c                     |   8 +-
 kernel/events/callchain.c                 |  49 ++--
 kernel/events/core.c                      | 424 +++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     |  19 +-
 tools/lib/perf/include/perf/event.h       |   8 +
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 +++++++
 tools/perf/util/callchain.c               |  24 ++
 tools/perf/util/callchain.h               |   3 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  39 +++
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/sample.h                  |   3 +-
 tools/perf/util/session.c                 |  79 ++++++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 22 files changed, 762 insertions(+), 36 deletions(-)

