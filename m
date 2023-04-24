Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF26ED07D
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDXOqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDXOqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 10:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BE59F5;
        Mon, 24 Apr 2023 07:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC7C62207;
        Mon, 24 Apr 2023 14:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D8DC433EF;
        Mon, 24 Apr 2023 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682347560;
        bh=atXhJJhwd5MHAOfI4qFdF5QYcFwglLv91Lc3dXq2Wxo=;
        h=From:To:Cc:Subject:Date:From;
        b=oxr9iMh7QLBjOO0QMvW5Rhitp37gczodx/GZuj+Mebl7IKAgUm84bTPQ4N4cOZRvi
         W17JSRCeV56uKHUGCgC7ioiIArVbPH1bmbdwBXge22FHRzprRzbizjHGCyEHNVDNxj
         wxfvErg4FMIhSaI2yGhDSG8EklF0q/YlHzV4e+EtsSjUgdNo+jxl4UrG+OX2bK94Nz
         gWeMe6v/B/NSo+N+YAsf8MJz+ukiW86HKOphk+h9SNYj2R1QUmxFHXgBlkl7mXmLkc
         MWpfvfNHwGZqXa2pTzu0pf8TfUObT18FtdNl9yVHPRzA9Q+aJFB84rpfoJhaVjGh/x
         iJpooafR4wXVw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v6 00/10] tracing: Add fprobe events
Date:   Mon, 24 Apr 2023 23:45:56 +0900
Message-ID:  <168234755610.2210510.12133559313738141202.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here is the 6th version of improve fprobe and add a basic fprobe event
support for ftrace (tracefs) and perf. Here is the previous version.

https://lore.kernel.org/all/168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com/

I applied some feedbacks about BPF and BTF related code, and fix patch
description. Major code changes are dropping the bpf_prog call [2/10],
Making find_tracepoint() static [4/10], and using bpf_get_btf_vmlinux()
[6/10]. This version also added a documentation about the fprobe events
[10/10].

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

With this fprobe events, we can continue to trace function entry/exit
even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
it is not available if the architecture only supports
CONFIG_DYNAMIC_FTRACE_WITH_ARGS (e.g. arm64). And that means kprobe
events can not probe function entry/exit effectively on such architecture.
But this problem can be solved if the dynamic events supports fprobe events
because fprobe events doesn't use kprobe but ftrace via fprobe.

FPROBE EVENTS
=============

Fprobe events allows user to add new events on the entry and exit of kernel
functions (which can be ftraced). Unlike kprobe events, the fprobe events
can only probe the function entry and exit, and it can only trace the
function args, return value, and stacks. (no registers)
For probing function body, users can continue to use the kprobe events.

The tracepoint probe events (tprobe events) also allows user to add new
events dynamically on the tracepoint. Most of the tracepoint already has
trace-events, so this feature is useful if you only want to know a
specific parameter, or trace the tracepoints which has no trace-events
(e.g. sched_*_tp tracepoints only exposes the tracepoints.)

The fprobe events syntax is;

 f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
 f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]

And tracepoint probe events syntax is;

 t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]

This series includes BTF argument support for fprobe/tracepoint events,
and kprobe events. This allows us to fetch a specific function parameter
by name, and all parameters by '$$args'.
Note that enabling this feature, you need to enable CONFIG_BPF_SYSCALL and
confirm that your arch supports CONFIG_HAVE_FUNCTION_ARG_ACCESS_API.

E.g.

 # echo 't kfree ptr' >> dynamic_events
 # echo 'f kfree object' >> dynamic_events
 # cat dynamic_events 
t:tracepoints/kfree kfree ptr=ptr
f:fprobes/kfree__entry kfree object=object
 # echo 1 > events/fprobes/enable
 # echo 1 > events/tracepoints/enable
 # echo > trace
 # head -n 20 trace | tail
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            tail-84      [000] .....  1324.561958: kfree__entry: (kfree+0x4/0x140) object=0xffff888006383c00
            tail-84      [000] ...1.  1324.561961: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff888006383c00
            tail-84      [000] .....  1324.561988: kfree__entry: (kfree+0x4/0x140) object=0x0
            tail-84      [000] ...1.  1324.561988: kfree: (__probestub_kfree+0x4/0x10) ptr=0x0
            tail-84      [000] .....  1324.561989: kfree__entry: (kfree+0x4/0x140) object=0xffff88800671e600
            tail-84      [000] ...1.  1324.561989: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff88800671e600
            tail-84      [000] .....  1324.562368: kfree__entry: (kfree+0x4/0x140) object=0xffff8880065e0580
            tail-84      [000] ...1.  1324.562369: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff8880065e0580


Thank you,

---

Masami Hiramatsu (Google) (10):
      fprobe: Pass return address to the handlers
      tracing/probes: Add fprobe events for tracing function entry and exit.
      selftests/ftrace: Add fprobe related testcases
      tracing/probes: Add tracepoint support on fprobe_events
      tracing/probes: Move event parameter fetching code to common parser
      tracing/probes: Support function parameters if BTF is available
      tracing/probes: Add $$args meta argument for all function args
      selftests/ftrace: Add tracepoint probe test case
      selftests/ftrace: Add BTF arguments test cases
      Documentation: tracing/probes: Add fprobe event tracing document


 Documentation/trace/fprobetrace.rst                |  184 +++
 Documentation/trace/index.rst                      |    1 
 include/linux/fprobe.h                             |   11 
 include/linux/rethook.h                            |    2 
 include/linux/trace_events.h                       |    3 
 include/linux/tracepoint-defs.h                    |    1 
 include/linux/tracepoint.h                         |    5 
 kernel/kprobes.c                                   |    1 
 kernel/trace/Kconfig                               |   25 
 kernel/trace/Makefile                              |    1 
 kernel/trace/bpf_trace.c                           |    6 
 kernel/trace/fprobe.c                              |   17 
 kernel/trace/rethook.c                             |    3 
 kernel/trace/trace.c                               |   13 
 kernel/trace/trace.h                               |   11 
 kernel/trace/trace_eprobe.c                        |   44 -
 kernel/trace/trace_fprobe.c                        | 1194 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |   33 -
 kernel/trace/trace_probe.c                         |  440 ++++++-
 kernel/trace/trace_probe.h                         |   42 +
 kernel/trace/trace_uprobe.c                        |    8 
 lib/test_fprobe.c                                  |   10 
 samples/fprobe/fprobe_example.c                    |    6 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   98 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   12 
 29 files changed, 2221 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
