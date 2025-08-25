Return-Path: <bpf+bounces-66420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B561B349BF
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25122A2A95
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788330AAC5;
	Mon, 25 Aug 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaNFXEl4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE962E1EF8;
	Mon, 25 Aug 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145267; cv=none; b=pvreKTTA4jqOJiE/G7JTXKCa8UBfON0BXDBA0btynZ1HRbsp2bf1uMFmYxDwPkyLnmQdtccbrtEdtAGIZ3IMqdAxn9Da+DzIMN4101MR0pPzHMZl54/JKYch8elK0P9UhHy5q/IWhICDTBD0pdx4mKrTsW1dFtRkmiPPDITlROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145267; c=relaxed/simple;
	bh=0FjaHJEeu8OC+uKc6tIBQ9qXWiuDw10dTkSnPT1smBM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=eAYFfGqxejbQahEC9lcnCxdpoDIlr7jWzoGalKoueKlJljM7n1Y5dXeQuGUETdPENPVfwHHXULrc1/74Au8ZlgSSQ/wwHyH8IMboED8y/5MaMU9aFqdPoMARMnpG5PRrXqxUG6szp5cwNyTvmWjjap4svxskulSZCHbB+G89010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaNFXEl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B162C4CEED;
	Mon, 25 Aug 2025 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145267;
	bh=0FjaHJEeu8OC+uKc6tIBQ9qXWiuDw10dTkSnPT1smBM=;
	h=Date:From:To:Cc:Subject:From;
	b=ZaNFXEl4XBvKbfhivQ87H3Cy74zCosWse1EFKgvLlz5l99E9P1xwmDEM2OEwTeZY/
	 G9mfdcykGQP8qBZndgN1cXJD5TKF2iLqSWo+UEEtWpJ0p9k5OWud7ZbRSdPDdUR+xS
	 EQraoO2RrCQ4q9nsocticSsL0WF4lZkmHkjY80QgiHQugY5+v1NOeh2EFOUthJ7doK
	 N/4/fm3Zp4YgWcgkC6LVEC6PAMz1P3NzHtQkTbj+jZrooS1sQ18AgY0z4DeNrkAENr
	 5uxet4tzr4wjNJhiuMlZ15+LVrrgnXmxQ9jXc86FjZiYT+JLrrKhveBI5L3t+FbO7O
	 iex0WflY1GfKQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uqbbt-00000002n2e-2DVB;
	Mon, 25 Aug 2025 14:08:01 -0400
Message-ID: <20250825180638.877627656@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 25 Aug 2025 14:06:38 -0400
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
Subject: [PATCH v15 0/8] perf: Support the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This patch is based off of:  https://lore.kernel.org/linux-trace-kernel/20250820180338.701352023@kernel.org
And requires these patches to be enabled: https://lore.kernel.org/linux-trace-kernel/20250820190546.172023727@kernel.org/

To run this series, you can checkout this repo that has this series as well as the above:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  unwind/perf-test

This series implements the perf interface to use deferred user space stack
tracing.

The first 4 patches implement the kernel side of perf to do the deferred stack
tracing, and the last 4 patches implement the perf user space side to read
this new interface.

Patch 1 adds a new API interface to the user unwinder logic to allow perf to
get the current context cookie for it's task event tracing. Perf's task event
tracing maps a single task per perf event buffer and it follows the task
around, so it only needs to implement its own task_work to do the deferred
stack trace. Because it can still suffer not knowing which user stack trace
belongs to which kernel stack due to dropped events, having the cookie to
create a unique identifier for each user space stack trace to know which
kernel stack to append it to is useful.

Patch 2 adds the per task deferred stack traces to perf. It adds a new event
type called PERF_RECORD_CALLCHAIN_DEFERRED that is recorded when a task is
about to go back to user space and happens in a location that pages may be
faulted in. It also adds a new callchain context called PERF_CONTEXT_USER_DEFERRED
that is used as a place holder in a kernel callchain to append the deferred
user space stack trace to.

Patch 3 adds the user stack trace context cookie in the kernel callchain right
after the PERF_CONTEXT_USER_DEFERRED context so that the user space side can
map the request to the deferred user space stack trace.

Patch 4 adds support for the per CPU perf events that will allow the kernel to
associate each of the per CPU perf event buffers to a single application. This
is needed so that when a request for a deferred stack trace happens on a task
that then migrates to another CPU, it will know which CPU buffer to use to
record the stack trace on. It is possible to have more than one perf user tool
running and a request made by one perf tool should have the deferred trace go
to the same perf tool's perf CPU event buffer. A global list of all the
descriptors representing each perf tool that is using deferred stack tracing
is created to manage this.

The last 4 patches implement the perf user space tooling side of this.

Changes since v14: https://lore.kernel.org/linux-trace-kernel/20250718164119.089692174@kernel.org/

- Moved the clean up patches into their own series (mentioned at the beginning)

- Added unwind_user_get_cookie() API to allow the task events to add cookies
  to differentiate which user stack belongs to which kernel stack in the event
  of dropped events.

- Save the cookie in the kernel callchain right after the PERF_CONTEXT_USER_DEFERRED

- Have the perf user space tooling match the cookies as well as the TID
  between the request and the user stack recording, to know which kernel stack
  gets the user space trace appended to it based on its context cookie.

Josh Poimboeuf (1):
      perf: Support deferred user callchains

Namhyung Kim (4):
      perf tools: Minimal CALLCHAIN_DEFERRED support
      perf record: Enable defer_callchain for user callchains
      perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
      perf tools: Merge deferred user callchains

Steven Rostedt (3):
      unwind deferred: Add unwind_user_get_cookie() API
      perf: Have the deferred request record the user context cookie
      perf: Support deferred user callchains for per CPU events

----
 include/linux/perf_event.h                |  11 +-
 include/linux/unwind_deferred.h           |   5 +
 include/uapi/linux/perf_event.h           |  25 +-
 kernel/bpf/stackmap.c                     |   4 +-
 kernel/events/callchain.c                 |  14 +-
 kernel/events/core.c                      | 421 +++++++++++++++++++++++++++++-
 kernel/unwind/deferred.c                  |  21 ++
 tools/include/uapi/linux/perf_event.h     |  25 +-
 tools/lib/perf/include/perf/event.h       |   8 +
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 +++++++
 tools/perf/util/callchain.c               |  24 ++
 tools/perf/util/callchain.h               |   3 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  42 +++
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/sample.h                  |   4 +-
 tools/perf/util/session.c                 |  80 ++++++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 24 files changed, 786 insertions(+), 10 deletions(-)

