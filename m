Return-Path: <bpf+bounces-60653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E00DAD99CE
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CCF1659FF
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 02:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F11BD9C9;
	Sat, 14 Jun 2025 02:46:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83C1B85CC;
	Sat, 14 Jun 2025 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869201; cv=none; b=svuQGl3+TVL57YrZz4wH+HqjJZ1oP3T017BIUgfUfQ5FQemopxqQFyaFm/2D0Ls8uj8W5yfM+wBjdgGIApPUwc/VsUqJcon6BgTG3hDjY6hcaJSfFh61WnwwlRWEgdGIlolshZZjgpBWaESyhwpbFuJn15mdttjDZpqIfvCLH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869201; c=relaxed/simple;
	bh=JTGYm6UQO3uJQdmBqdagt34oi1y0i3cjdt18QncFRfU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=foN1BIt3PcY3Bxb9wCFja5H1dA8Ni41Lb6Q3X7xcXcJEG/I1Y+SFd0UgkuDkEqK/etrYymRwD+uiTrRW0Ffx1HIHAek3kTkaDU559wng5i1zA1ys59fh2hKMvev5Dzm6Zz6tfMdRLMwVE+RlCwDkjrfLxSl+TKTh1DX4++F2KEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 292601D8A02;
	Sat, 14 Jun 2025 02:45:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 3C63E20027;
	Sat, 14 Jun 2025 02:45:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uQGvL-00000002Slx-35II;
	Fri, 13 Jun 2025 22:47:15 -0400
Message-ID: <20250614024605.597728558@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Jun 2025 22:46:05 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 00/11] perf: Support the deferred unwinding infrastructure
X-Rspamd-Queue-Id: 3C63E20027
X-Stat-Signature: o7up5jaqfrdapzm3wke17esxama9ztag
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18U5bFLLoM8EQRnOl0ObCKv5h9zLCk7uPI=
X-HE-Tag: 1749869137-556071
X-HE-Meta: U2FsdGVkX1+WbTfRvDXPowhnOP/iAPpJ8ft41ICC/Z+tIkKrSU8BHurmZxM5KNn7S8rHXZAGgawtwaAHxkB0gvyDdtqGUhx5O6DcfK/NImgm/jItLoUkQmXSaSA+wNGytE88+wa6cUk36iPeWIwMDWAcNae0gaJH0FhyOb+grTj/eVUOgkUYKJ4MCYJ23xyWapcL129p0PsYd93/t1JK6x1ZYDOaOkOZFsv09ec9A0zblvI5uobZzYcbWSo3hLEzyCp7Qr8+dD87j/rCrBb11MMzQOlc/5whewXL0BbQzfCD5t1hkeIOODKlKf7RuS6ow2+UmK6LG46GwM6Z54XXkmadeRnu0zIQpYy9ja0RXcpMn+DEK5OFhc/A1EfCz0nx
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This is based on top of the deferred unwind core patch series:

  https://lore.kernel.org/linux-trace-kernel/20250611005421.144238328@goodmis.org/

Which is based on top of v6.16-rc1.

This series implements the perf interface to use deferred user space stack
tracing. This version fixes a few issues from v9 and addresses the comments
from v8 where as v9 was just a rebase.

Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250611013421.040264741@goodmis.org/

- Remove CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED as it is never used.

- Fixed up the synchronization of rcuwait for cpu deferred events.

- Added more comments to describe how the unwind deferred works.

- Tagged the cpu_events with __rcu and added rcu annotation.
 

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
 kernel/events/core.c                      | 420 +++++++++++++++++++++++++++++-
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
 22 files changed, 757 insertions(+), 35 deletions(-)

