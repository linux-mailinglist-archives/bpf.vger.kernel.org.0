Return-Path: <bpf+bounces-2793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B728A733FED
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 11:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612892818E4
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064EC6FD9;
	Sat, 17 Jun 2023 09:47:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C377FA
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 09:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C7C433C0;
	Sat, 17 Jun 2023 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686995222;
	bh=d9JppF1OB3clmSKXHuYWpmtIhrX7ndE0udMJPpQlMlk=;
	h=From:To:Cc:Subject:Date:From;
	b=aeWrP8MlUoLe1DnJN6pO6cV0x6syd1Vrx+dpfkFANqLKPQESkm4+06wJ/FU9q2jeD
	 y5AfAUpTLzeNVUYGzJdRdM0xZAnVR2F7fkHMfD0Fit2qQyPIiOsS1id/ylFOc9tjuX
	 hMlt3Q0Os3bahFQ4KRnPqVWqbAM/bbfritHI6bHF5BOG9g5L1IYXx0FPL54DWZH8Mr
	 niVfIwyzSz/UylzwuPFy0PLIwp0VbK8x7AkXCIrobwk9LvyhRC4KUTNjCkbAhoj58B
	 MpKTnRtV958fyRVALytHECE0s+4nvGcJfCG+WUta9AnzjaunUZuuYOypxGyfTpZV5A
	 dYq5ahJfXaSzw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH 0/5] tracing: Improbe BTF support on probe events
Date: Sat, 17 Jun 2023 18:46:58 +0900
Message-ID:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

Here is a seires of patches to improve the BTF support on probe events.

In the previous series, I introduced BTF based function argument support.
This series focuses on accessing data structure fields and string type
checking. Here is the list of the patches.

- [1/5] Add data field access support from BTF args.
- [2/5] Add data field access support from retval.
- [3/5] "string" type checks the BTF type and add dereference
        automatically.
- [4/5] Update testcases
- [5/5] Update documents

With this series, you can trace information from function entry/exit and
tracepoints. For example, you can get information about data structures
that are not exposed to user space (via traceevent), or find out what
the data in the data structure pointed by the return value of a function
was.
This was previously possible with the `perf probe` command, but with BTF
you can do it with just tracefs. (Of course `perf probe` is still useful
for debugging kernel with tracing function body or where any tracepoint
is not provided.)

Example:

 # echo 'f getname_flags%return retval->name:string' > dynamic_events
 # echo 1 > events/fprobes/getname_flags__exit/enable
 # ls > /dev/null
 # head -n 40 trace | tail
              ls-87      [000] ...1.  8067.616101: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./function_profile_enabled"
              ls-87      [000] ...1.  8067.616108: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./trace_stat"
              ls-87      [000] ...1.  8067.616115: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_notrace"
              ls-87      [000] ...1.  8067.616122: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_function"
              ls-87      [000] ...1.  8067.616129: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace"


This series can be applied on top of "probes/core" branch of the
linux-trace.git.

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext


Thank you,

---

Masami Hiramatsu (Google) (5):
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from retval
      tracing/probes: Add string type check with BTF
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   50 ++-
 kernel/trace/trace_probe.c                         |  347 ++++++++++++++++++--
 kernel/trace/trace_probe.h                         |   19 +
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 5 files changed, 376 insertions(+), 55 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

