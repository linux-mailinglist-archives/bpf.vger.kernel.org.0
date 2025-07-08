Return-Path: <bpf+bounces-62607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BAFAFC04E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE70425D0E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60F21B908;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6Z1voif"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDA1C8606;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940050; cv=none; b=rbqn4Bv7YhYgneHv8op/Tx1sNJCrRw6sP+uTqFt6wstZ4KqpzsGvL6lz/UyhdzqCeAVHO3ezzQ2ijDDaClQYf/7QazRoBZqvgnD8lJtABZJCOAvqTodu2SNd8iqplNiJf4XXBiEePCgD4Qte3wlrKPp9XVOmPTQDI+ynm5qwL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940050; c=relaxed/simple;
	bh=AIE1bYpSQl2sDdlrLBEu7VHTjeRI0UsChEr6022uLng=;
	h=Message-ID:Date:From:To:Cc:Subject; b=XjQmhicYV8exeQ+PCWEBmsT+VAQZJY7txF1gzisrnPz/ZNgol5TwJVl9S/BaYzMvZvTjNcpkuXBvtLvI6u64fEJ+k6bz5zYs6365uVdlISBq0hHDA3s7WtDWr1SVM/egr8DKxQvw6NDp5MLF90xjkA8J99+KSqp5nksc4r1t1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6Z1voif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE06CC4CEE3;
	Tue,  8 Jul 2025 02:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940050;
	bh=AIE1bYpSQl2sDdlrLBEu7VHTjeRI0UsChEr6022uLng=;
	h=Date:From:To:Cc:Subject:From;
	b=T6Z1voifSAnMTSG+iRKH3UQAe2bqZ0/pU4pxDBYSVOu7Gs7biMqUKPypYXZ+/dRtp
	 Msn5/HceB6wYqaNTJKH+pEvrxTkrZh/OnGFbmVKL8xJ7/owi8OoCcDofDWpL4GMyic
	 hoYJPh6Tp/2+KMDQggogauuV9/wLzQ45dwrk6xqFeDiD4Z5SphJE3AZGElqsaTpp+/
	 0MqpX68tLwJVAsJuFS3ukMeZ9yutNEvHtxGrKoLrYjkMnemTPQESG1MandHTjur/4n
	 h0PXbIlDkILEx2k6HoB9GbtzZwcyTGDSVMBghuP09ge/8HJoubLnu03CV1DTQcnvRF
	 xIkZec/bX1F8A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxda-00000000D3f-0CsA;
	Mon, 07 Jul 2025 22:00:50 -0400
Message-ID: <20250708020003.565862284@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:03 -0400
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
Subject: [PATCH v13 00/11] perf: Support the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This is based on top of the deferred unwind core patch series:

 https://lore.kernel.org/linux-trace-kernel/20250708012239.268642741@kernel.org/
   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
     unwind/core

This series implements the perf interface to use deferred user space stack
tracing.

The code for this series is located here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/perf

Changes since v12: https://lore.kernel.org/linux-trace-kernel/20250701180410.755491417@goodmis.org/

- Also check against PF_USER_WORKER as io workers do not have PF_KTHREAD
  set.

- Removed deferred_request_nmi() and have NMIs just use the normal
  deferred_request() function. As Peter Zijlstra has stated, in_nmi() can
  nest because some exceptions set in_nmi() and another NMI could come in.

- Removed use of timestamp. The deferred unwind has gone back to using
  cookies, and perf doesn't use the cookie. This means the
  struct perf_callchain_deferred_event is not modified.

Head SHA1: 3d88d03d533ede8d2d513942e768607aa9279c4b


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
 include/uapi/linux/perf_event.h           |  19 +-
 kernel/bpf/stackmap.c                     |   8 +-
 kernel/events/callchain.c                 |  49 ++--
 kernel/events/core.c                      | 407 +++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     |  19 +-
 tools/lib/perf/include/perf/event.h       |   7 +
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
 tools/perf/util/session.c                 |  78 ++++++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 22 files changed, 742 insertions(+), 36 deletions(-)

