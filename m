Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0E6F3B26
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 02:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEBABk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 20:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBABj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 20:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D51FEE;
        Mon,  1 May 2023 17:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A348A62055;
        Tue,  2 May 2023 00:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766EAC433D2;
        Tue,  2 May 2023 00:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682985697;
        bh=BNsRcKYRPV8D42UslfOjNLcHiF0qsYMcQ6gMsgBkLLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9EtGwfBO4NmrZz2PdQU6d9T7GY3CIT16EOOk+Ri+q1lfQa3S6hVS8p+wD30qfRs2
         UIW9vFEUR4NBQe0U5ws4eEihJ6X7+J1CsfoqRyv7Ouxmcc2hmH6ERdufJ8ea6rCGlO
         3u+qPYf5ZOcU25XjAN+4FWupBtp3603Wye8Ht9ICe6f++HuR4dK+PUnpBan/u3Pfxp
         KVqUkwcEbq7VIFc+Rb+3Iic2/FhdY5HW2Jz/vgwzG0vQqTTaxC9Vp5omf8E4+97H2w
         lty/kZWksxC3rIq7VqbKKFMBrjxrofntJ9E3qJlaI+t0BxfsucYLDc4LdOJUJP07yE
         O3t5GhA+BTFhA==
Date:   Tue, 2 May 2023 09:01:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [v8] Re: [PATCH v9 00/11] tracing: Add fprobe events
Message-Id: <20230502090133.dcfc898a4bb33205c73fb6ea@kernel.org>
In-Reply-To: <168295372484.3157983.731333785390494141.stgit@mhiramat.roam.corp.google.com>
References: <168295372484.3157983.731333785390494141.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oops, the title version is wrong, this is 8th version. Hmm, it must be my typo...

On Tue,  2 May 2023 00:08:45 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 8th version of improve fprobe and add a basic fprobe event
> support for ftrace (tracefs) and perf. Here is the previous version.
> 
> https://lore.kernel.org/all/168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com/
> 
> This version is a minor update for fixing wrong indentation [8/11]
> and update kconfig help message[6/11].
> 
> You can also get this series from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> 
> With this fprobe events, we can continue to trace function entry/exit
> even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
> CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> it is not available if the architecture only supports
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS (e.g. arm64). And that means kprobe
> events can not probe function entry/exit effectively on such architecture.
> But this problem can be solved if the dynamic events supports fprobe events
> because fprobe events doesn't use kprobe but ftrace via fprobe.
> 
> FPROBE EVENTS
> =============
> 
> Fprobe events allows user to add new events on the entry and exit of kernel
> functions (which can be ftraced). Unlike kprobe events, the fprobe events
> can only probe the function entry and exit, and it can only trace the
> function args, return value, and stacks. (no registers)
> For probing function body, users can continue to use the kprobe events.
> 
> The tracepoint probe events (tprobe events) also allows user to add new
> events dynamically on the tracepoint. Most of the tracepoint already has
> trace-events, so this feature is useful if you only want to know a
> specific parameter, or trace the tracepoints which has no trace-events
> (e.g. sched_*_tp tracepoints only exposes the tracepoints.)
> 
> The fprobe events syntax is;
> 
>  f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
>  f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]
> 
> And tracepoint probe events syntax is;
> 
>  t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]
> 
> This series includes BTF argument support for fprobe/tracepoint events,
> and kprobe events. This allows us to fetch a specific function parameter
> by name, and all parameters by '$$args'.
> Note that enabling this feature, you need to enable CONFIG_BPF_SYSCALL and
> confirm that your arch supports CONFIG_HAVE_FUNCTION_ARG_ACCESS_API.
> 
> E.g.
> 
>  # echo 't kfree ptr' >> dynamic_events
>  # echo 'f kfree object' >> dynamic_events
>  # cat dynamic_events 
> t:tracepoints/kfree kfree ptr=ptr
> f:fprobes/kfree__entry kfree object=object
>  # echo 1 > events/fprobes/enable
>  # echo 1 > events/tracepoints/enable
>  # echo > trace
>  # head -n 20 trace | tail
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>             tail-84      [000] .....  1324.561958: kfree__entry: (kfree+0x4/0x140) object=0xffff888006383c00
>             tail-84      [000] ...1.  1324.561961: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff888006383c00
>             tail-84      [000] .....  1324.561988: kfree__entry: (kfree+0x4/0x140) object=0x0
>             tail-84      [000] ...1.  1324.561988: kfree: (__probestub_kfree+0x4/0x10) ptr=0x0
>             tail-84      [000] .....  1324.561989: kfree__entry: (kfree+0x4/0x140) object=0xffff88800671e600
>             tail-84      [000] ...1.  1324.561989: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff88800671e600
>             tail-84      [000] .....  1324.562368: kfree__entry: (kfree+0x4/0x140) object=0xffff8880065e0580
>             tail-84      [000] ...1.  1324.562369: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff8880065e0580
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (11):
>       fprobe: Pass return address to the handlers
>       tracing/probes: Add fprobe events for tracing function entry and exit.
>       selftests/ftrace: Add fprobe related testcases
>       tracing/probes: Add tracepoint support on fprobe_events
>       tracing/probes: Move event parameter fetching code to common parser
>       tracing/probes: Support function parameters if BTF is available
>       tracing/probes: Add $$args meta argument for all function args
>       tracing/probes: Add BTF retval type support
>       selftests/ftrace: Add tracepoint probe test case
>       selftests/ftrace: Add BTF arguments test cases
>       Documentation: tracing/probes: Add fprobe event tracing document
> 
> 
>  Documentation/trace/fprobetrace.rst                |  187 +++
>  Documentation/trace/index.rst                      |    1 
>  include/linux/fprobe.h                             |   11 
>  include/linux/rethook.h                            |    2 
>  include/linux/trace_events.h                       |    3 
>  include/linux/tracepoint-defs.h                    |    1 
>  include/linux/tracepoint.h                         |    5 
>  kernel/kprobes.c                                   |    1 
>  kernel/trace/Kconfig                               |   26 
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/bpf_trace.c                           |    6 
>  kernel/trace/fprobe.c                              |   17 
>  kernel/trace/rethook.c                             |    3 
>  kernel/trace/trace.c                               |   13 
>  kernel/trace/trace.h                               |   11 
>  kernel/trace/trace_eprobe.c                        |   44 -
>  kernel/trace/trace_fprobe.c                        | 1194 ++++++++++++++++++++
>  kernel/trace/trace_kprobe.c                        |   33 -
>  kernel/trace/trace_probe.c                         |  504 +++++++-
>  kernel/trace/trace_probe.h                         |   43 +
>  kernel/trace/trace_uprobe.c                        |    8 
>  lib/test_fprobe.c                                  |   10 
>  samples/fprobe/fprobe_example.c                    |    6 
>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 +
>  .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
>  .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   99 ++
>  .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 +
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   13 
>  29 files changed, 2291 insertions(+), 140 deletions(-)
>  create mode 100644 Documentation/trace/fprobetrace.rst
>  create mode 100644 kernel/trace/trace_fprobe.c
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
