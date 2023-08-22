Return-Path: <bpf+bounces-8267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212478474C
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F3C1C20B47
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB61DDD7;
	Tue, 22 Aug 2023 16:25:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C91D2E6
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F15C433C7;
	Tue, 22 Aug 2023 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692721536;
	bh=Q+r3oxlYBxRghMxUbHFTOIiX5XSGjgru9PagyxC488w=;
	h=From:To:Cc:Subject:Date:From;
	b=Fh1dty56cRg3F7Cqr2mULpE6ISouwiRnFi0CVfvcb8G3CdvsD321Q/bTb2sGtx0s9
	 xGExByW+BJJfwaauZfEKyY2naTOZjdLesa1OXqgT3N6Hpi7uw9H+ZaDcVquz1zOM3o
	 g3PLEbWhXggJ1+AUO+dJ3nscQe+VxWAfR7reHk7KG7kV32fMGusWiG/Rq4IiRkgIB/
	 vzKzEnQROIIxojdgZungWqdSCPR7UZwS3W5SS3W0RQmX91KeJK4L1+OTRNGNHyr1mY
	 TrQvRMuTn7oGeLJay7PzbHZRokzcsUIYVL0sBpfb/suC5eaDJ2Wj72osI4c8gSGd0u
	 8QPVcUG2XiMNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 0/9] tracing: Improbe BTF support on probe events
Date: Wed, 23 Aug 2023 01:25:31 +0900
Message-Id: <169272153143.160970.15584603734373446082.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 6th version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/all/169137686814.271367.11218568219311636206.stgit@devnote2/

This version is adding Steve's Ack and allocate the struct btf_anon_stack
from heap.

This series can be applied on top of "probes/core" branch of
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

Thank you,

---

Masami Hiramatsu (Google) (9):
      tracing/probes: Support BTF argument on module functions
      tracing/probes: Move finding func-proto API and getting func-param API to trace_btf
      tracing/probes: Add a function to search a member of a struct/union
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from $retval
      tracing/probes: Add string type check with BTF
      tracing/fprobe-event: Assume fprobe is a return event by $retval
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   64 ++-
 include/linux/btf.h                                |    1 
 kernel/bpf/btf.c                                   |    2 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    3 
 kernel/trace/trace_btf.c                           |  122 +++++
 kernel/trace/trace_btf.h                           |   11 
 kernel/trace/trace_eprobe.c                        |    4 
 kernel/trace/trace_fprobe.c                        |   59 ++
 kernel/trace/trace_kprobe.c                        |    1 
 kernel/trace/trace_probe.c                         |  499 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   27 +
 kernel/trace/trace_uprobe.c                        |    1 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   20 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   10 
 15 files changed, 650 insertions(+), 175 deletions(-)
 create mode 100644 kernel/trace/trace_btf.c
 create mode 100644 kernel/trace/trace_btf.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

