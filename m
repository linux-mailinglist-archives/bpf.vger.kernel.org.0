Return-Path: <bpf+bounces-7111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4FB77187F
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77C4281165
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826181A;
	Mon,  7 Aug 2023 02:54:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A037642
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFEDC433C7;
	Mon,  7 Aug 2023 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691376873;
	bh=K/svtr178nDNGv75I/PN9a7tqopFRrIQt4KacXAcLRI=;
	h=From:To:Cc:Subject:Date:From;
	b=UzKbWa7wJj4pCrkQElqAtPq+J3oXgR5U+VkpC+pBw6SBim4j/U+0C0FQYjpAhbesF
	 R0+YAKHQoY5HsQKr/rXfOmQ96M53/m4PBqR0iNvmTaILywN/uio5rPc84Fkc4C6aOA
	 ri09oNFmC5bh9wbLvmYIYU94TGyjKWyL8Ci4EvKT4TZSbbSBeFXkBJ1UL4+VhbVC3a
	 g5t5pzoUqX6y6aFV/hCdEzGYNSt0XpwU0dBU1DaA6wbijctgoiX/DaC+WmJ7BLiYE1
	 ppc9Qx0dDuD3GQF++R7ROfwkymC72cVbBEZ3WbbpAuG1dXkhf8E4GUqgpTJLjmckCy
	 Ltb2oHV/Pmqww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Date: Mon,  7 Aug 2023 11:54:28 +0900
Message-Id: <169137686814.271367.11218568219311636206.stgit@devnote2>
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

Here is the 5th version of series to improve the BTF support on probe events.
The previous series is here:

https://lore.kernel.org/all/169078860386.173706.3091034523220945605.stgit@devnote2/

This version introduces kernel/trace/trace_btf.c to separate the btf generic
functions. These functions will be moved to btf.c next merge window.
This fixes the member-search function to return the bit-offset of the
parent anonymous union/structure. Thus the caller can calculate the real
bit-offset from the root data structure.
This also fixes the ftrace selftest issue which fails if the kernel
supports only BTF args but not support field access.

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
 kernel/trace/trace_btf.c                           |  109 ++++
 kernel/trace/trace_btf.h                           |   11 
 kernel/trace/trace_eprobe.c                        |    4 
 kernel/trace/trace_fprobe.c                        |   59 ++
 kernel/trace/trace_kprobe.c                        |    1 
 kernel/trace/trace_probe.c                         |  499 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   27 +
 kernel/trace/trace_uprobe.c                        |    1 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   20 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   10 
 15 files changed, 637 insertions(+), 175 deletions(-)
 create mode 100644 kernel/trace/trace_btf.c
 create mode 100644 kernel/trace/trace_btf.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

