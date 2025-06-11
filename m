Return-Path: <bpf+bounces-60279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25503AD47F3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0ECD17B6F6
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CD13CA97;
	Wed, 11 Jun 2025 01:36:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660842AA4;
	Wed, 11 Jun 2025 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605774; cv=none; b=Iw5qx/UQPyTijt4JPQhK/lK1XSwsJzBg2Pn5TnB3omhILN3crcMXOcgyPEFQEeTO3kTRhsR4FMUZW1rhPLsu+W8TjtnljEoiYrQTnTZ+STioPA5GyLZV+QldHmleyIcPdpCLt8iduhCvHvKenoxjd2IVdgooyxLrkrOejzSD/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605774; c=relaxed/simple;
	bh=MpJdpddXsVJiuVlaeGBIgk5Z404B3FToLOFBnbqeFhU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hJIM788YLdzzWj5xey1ymhArHIDUHh7hdYNxRBhHr9db8D0IXlwZ/953UaAk1skIK0vAaS8wMdOzijvVj+9aBwd22o4/6p5v7QnAT9p+MrXCRe0aT20W0tZPZ5FMCo+nbstSNDFcxrONP33+8KpIIF1BUWsu0HayDSexf+EuEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B27D7BE015;
	Wed, 11 Jun 2025 01:36:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id CAFF320025;
	Wed, 11 Jun 2025 01:36:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPK-00000000wLz-25fs;
	Tue, 10 Jun 2025 21:37:38 -0400
Message-ID: <20250611013421.040264741@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:21 -0400
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
Subject: [PATCH v9 00/11] perf: Support the deferred unwinding infrastructure
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: CAFF320025
X-Stat-Signature: igps57wmz71brj5ypafo1is8fcjtt8iz
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18au498b2hYozqqnRJKSPuGK88FMgHZO9E=
X-HE-Tag: 1749605766-192294
X-HE-Meta: U2FsdGVkX1+5TC2VLMpiEOp2/E9VYeeQ55OvU5pEBlMimi94rHj/rEObcUNTUpEnK81EHxCoWAVjD0r18iUCOCGZDz3+uQposABv/wCMW8R+wk8sldjgcQqIdczjtw7Vd6N7q5Vr6MQ3N18PkoI0/XMnJDbDUkjlHDH1aqEdSGX+jyDyGnP/gWaal9JA9vS+u5IptiE74fN1ON8+0tE4OrWNqhoMObkqIjHbIwwS0r+OZ1s6JddGdJ8qYCi2UVadxrQXDkVcu9bHMVX11i62IxXEMfxp8N9vuHBj0U91lacKguzoxDaunAaKmwtPCN1jH1aFGirmnikhaMwL1ABXQEMN/iWrDHJxIdfqLYRD65YUbvAc4VBk0fokMDdZKw7olW5EK3NO3VclJ29SIUyf4Q==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This is based on top of the deferred unwind core patch series:

  https://lore.kernel.org/linux-trace-kernel/20250611005421.144238328@goodmis.org/

Which is based on top of v6.16-rc1.

This series implements the perf interface to use deferred user space stack
tracing. I'm posting this now for review and comments and a way for people to
test out the unwind deferred core series. As this has updates to user ABI it
should be scrutinized much more as once this is accepted it is set in stone.
This is why this is a separate patch series.

Changes since v8: https://lore.kernel.org/linux-trace-kernel/20250509164524.448387100@goodmis.org/

- Simply rebased on top of the latest unwind deferred core.

- This still has issues that were brought up in v8 by Andii regarding
  cross_task and user vs kernel stack tracing. I did not yet address these
  concerns as I just wanted to get this series out based on v6.16-rc*.

  https://lore.kernel.org/linux-trace-kernel/CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com/

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
 arch/Kconfig                              |   3 +
 include/linux/perf_event.h                |  14 +-
 include/uapi/linux/perf_event.h           |  19 +-
 kernel/bpf/stackmap.c                     |   8 +-
 kernel/events/callchain.c                 |  47 ++--
 kernel/events/core.c                      | 352 +++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     |  19 +-
 tools/lib/perf/include/perf/event.h       |   7 +
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 ++++++++
 tools/perf/util/callchain.c               |  24 ++
 tools/perf/util/callchain.h               |   3 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  39 ++++
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/sample.h                  |   3 +-
 tools/perf/util/session.c                 |  78 +++++++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 23 files changed, 691 insertions(+), 34 deletions(-)

