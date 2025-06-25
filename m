Return-Path: <bpf+bounces-61615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47074AE920B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631416A3538
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37202F94AB;
	Wed, 25 Jun 2025 23:16:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064F2F3646;
	Wed, 25 Jun 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893365; cv=none; b=Lp7q1PPKlh84Rk63VhoAP7zg8hksrpQJrFOF4FJQsTB6ji9y9cxDbdF6mKp0E+rqZM2nHroCeZKy575OVjQshRD0lcjXftc7Mz6eFMTHQ6VzbS6ug7K2i0P00SaVIxBg+7pi8490UKfoEGkmXJCRedl6dHpN1YOyVSMExjp1r5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893365; c=relaxed/simple;
	bh=Umn+ScgSRnA/hfGr3imuIglkH7+kvqT0cE1QZM7nsdQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dT5OF+eb6Br/KpGo17ZBTCFKx4K6ubBV0ya5REtLoIKqu6kbfW/Nc5ueEB2bnJcO2FOWAtCJFc8ra1ZUFECtkOQkhcdlCE2iH0dCfcttCxOaEvVCme/TsL/RcACty4mJSt1vcUmTo5zhJdqkdKgMSB6WuHosmrZdjzO2GnA4BRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CA36C1A0784;
	Wed, 25 Jun 2025 23:15:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id D6C1080009;
	Wed, 25 Jun 2025 23:15:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLp-000000044fH-3OGU;
	Wed, 25 Jun 2025 19:16:21 -0400
Message-ID: <20250625231541.584226205@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
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
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 00/11] perf: Support the deferred unwinding infrastructure
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D6C1080009
X-Stat-Signature: c79fuz3hd14cab8ht74td7w538x3rkz8
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19t464FQAQY5A9I2dwVp9JU1ObIkOlUlqA=
X-HE-Tag: 1750893356-152776
X-HE-Meta: U2FsdGVkX18bEXihUvvqf72N4carTM0iuAvItw6mJraqTC4iSm7aVCYe+5ysmN5fvlQ8xMVG3gdUnJtdKUp2O7ADoBwO+eZwxyMke6/LbJhfXd6PWx/hUAr1KIaNVXHJ85OemcMffPx5Iir+Y6Wj2wCgQ7wnR/l4Lp4h2kXBJ0bfE+wRaoZyuc6BStQxHh5TqhduciGrea6t0LvlMDMXEsi7XXrYe1jsERNUCdPBS3mIdTa5LoJi1LNrCnf6TpAjpowSbnGn4e51TMwho88PIu3XxS9Brr7dtSnm54JUq2q0SyOcKyAiYwuKdddSvY4UTAomGucKEYNQAC3RMF3kVz8EIw7mN6YHCDigds7dT8KGuK5sb0de4kJlHlUQtdkD
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This is based on top of the deferred unwind core patch series:

 https://lore.kernel.org/linux-trace-kernel/20250625225600.555017347@goodmis.org/ 

This series implements the perf interface to use deferred user space stack
tracing. This version fixes a few issues from v10.

Changes since v10: https://lore.kernel.org/linux-trace-kernel/20250614024605.597728558@goodmis.org/

- Rebased on v11 of the core patches

- Added another smp_mb() between the call to perf_event_callchain_deferred()
  and clearing of cpu_unwind->processing.

- Update using the renamed function that was renamed from
  unwind_deferred_trace() to unwind_user_faultable() in the core
  series.

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
      perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL
      perf: Support deferred user callchains for per CPU events

----
 include/linux/perf_event.h                |  14 +-
 include/uapi/linux/perf_event.h           |  19 +-
 kernel/bpf/stackmap.c                     |   8 +-
 kernel/events/callchain.c                 |  49 ++--
 kernel/events/core.c                      | 426 +++++++++++++++++++++++++++++-
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
 22 files changed, 763 insertions(+), 35 deletions(-)

