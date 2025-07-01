Return-Path: <bpf+bounces-61967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5DAF026F
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FAB7A5330
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309028314D;
	Tue,  1 Jul 2025 18:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D66280331;
	Tue,  1 Jul 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393065; cv=none; b=V1oZskKh3VG0FtbuTMdrTHOzQD2UOIJIdOR7ZgxV4PZBEd++7bkKen0dwP8fDMhYfqp018BuBUbUe6rVbMxTguSgcxAU67Xsq+oXpb+YSHnouEiKV46k4sS5NofMAFYjCS/7NsJn+AzuqHu7JK8HZvlDc/qFQP2paCZwkxF+ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393065; c=relaxed/simple;
	bh=yKe763bU9QaA9aQniTg/ZCZy2qRZlZ2/F1Tf8wMEJAc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=LxcTIa+UY6j24p1prPx8ln3zP007nEYUP9yV7zf6esFprcmYUlBTQyucZOcnlkfn6P95y4xnzemH0IqaSvBNhtgZ/gVh9iBWym9kEQd1EfWct1rDU7on/klvajC0ffzjdUK2WYa/Y9EqXVsPQRSYY+QYYDhgQ/GNKdRhIV0cnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D4CF780584;
	Tue,  1 Jul 2025 18:04:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id AA7A720017;
	Tue,  1 Jul 2025 18:04:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWfLj-00000007fzF-2pFT;
	Tue, 01 Jul 2025 14:04:55 -0400
Message-ID: <20250701180410.755491417@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:04:10 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 00/11] perf: Support the deferred unwinding infrastructure
X-Stat-Signature: zm3xgu38a5fxu75hswpu6fbei5kc46oj
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: AA7A720017
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18peYPOreBwlNyLpCo+VgvEcppik9hmHQU=
X-HE-Tag: 1751393057-936083
X-HE-Meta: U2FsdGVkX1+yXY2i2DsCKUqlgmT9/so7w0BbCRW/S/s2tKB+M1SwiSGcIzuSpdafVDIxqNS3DbR4b/m1Q8rz7qS0HxNuQikrmJEoP1A3YoKUQZptZoTtW+GkayQYAfJ1x+NR9zOLhvESl2Flef1ExJHcEbhG+NMJdsP07dOxG6O0EPxceaeD5Hye5uBLhBvcbGJV+bi92Nk+8r/sT9RvPn3GO7j9y7Q+hDCTErvTY5PvSos8MIxebDdqgV5jtceXgu5LVwE4QR/xgumwV+GNCSzjB3sJRV/YhggHWYRZzF46unTmj1/da1kkAXRLNbdA+S473dDeTVUcI4ScIscEQKmYFGYBze2Z2hMjQADql3jFrbtpUlgMHx02wo3YNYVn
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This is based on top of the deferred unwind core patch series:

 https://lore.kernel.org/linux-trace-kernel/20250701005321.942306427@goodmis.org/
 git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/core


This series implements the perf interface to use deferred user space stack
tracing.

The code can be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/perf

  Head SHA1: e00f51618c68b5b6fd6054488212504592c9e392

Changes since v11: https://lore.kernel.org/linux-trace-kernel/20250625231541.584226205@goodmis.org/

- Also check against PF_USER_WORKER as io workers do not have PF_KTHREAD
  set.

- Removed deferred_request_nmi() and have NMIs just use the normal
  deferred_request() function. As Peter Zijlstra has stated, in_nmi() can
  nest because some exceptions set in_nmi() and a real NMI could come in.


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
 kernel/events/core.c                      | 410 +++++++++++++++++++++++++++++-
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
 22 files changed, 745 insertions(+), 36 deletions(-)

