Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3646F0FB3
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 02:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjD1AkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 20:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD1AkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 20:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8709213A;
        Thu, 27 Apr 2023 17:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F165640A5;
        Fri, 28 Apr 2023 00:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D8C433D2;
        Fri, 28 Apr 2023 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682642410;
        bh=HBZ9LJ8/7gelW0e3hNFH3mKrs+p2XBy1gBkw9/WVGDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EBeLOerbxR3am7drGe0il1lide8MozrpM9KFv9Yh9qhkN7uwvqCirSX8jKxozYJ1U
         3kFFW+FyMFx7pRRgL417+81AeryNX7YP5HKpAAGtA+TOt4s+2XvvZINu6qCQITPUdC
         W7Hoej5bTCWSsqQuI+3T5Zg+ELudyJsUcc44nInTjmaSL9NaNCRn77dqYUjRWFOMTE
         Kx/RHZ4cE+jbXM9gC8P5chJLhYcycbYjR9+NyY6IcNlpF8FHP9Z6Yic01AUyIMZ6fe
         F+1OadHM9AidbsTj9y15NLsvuTPgVjobeDygU8U0mdLJeA6g29h7HKhosILhHqY4+4
         aqejdUIDrS5Xg==
Date:   Fri, 28 Apr 2023 09:40:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v7 00/11] tracing: Add fprobe events
Message-Id: <20230428094006.49275a20ab80e0142a6c43c0@kernel.org>
In-Reply-To: <ZEpjgKmDwg1GTCTR@krava>
References: <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
        <ZEpjgKmDwg1GTCTR@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Apr 2023 13:58:56 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Apr 27, 2023 at 10:17:45AM +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is the 7th version of improve fprobe and add a basic fprobe event
> > support for ftrace (tracefs) and perf. Here is the previous version.
> > 
> > https://lore.kernel.org/all/168234755610.2210510.12133559313738141202.stgit@mhiramat.roam.corp.google.com/
> > 
> > This version is rebased on the latest linux-trace/for-next, fixes
> > bpf_get_btf_vmlinux() return value check [6/11] and adds new BTF $retval
> > type support [9/11] (I forgot to implement this feature last time).
> > Also updates according to the BTF $retval type support.
> > 
> > You can also get this series from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> > 
> > With this fprobe events, we can continue to trace function entry/exit
> > even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
> > CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> > it is not available if the architecture only supports
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS (e.g. arm64). And that means kprobe
> > events can not probe function entry/exit effectively on such architecture.
> > But this problem can be solved if the dynamic events supports fprobe events
> > because fprobe events doesn't use kprobe but ftrace via fprobe.
> > 
> > FPROBE EVENTS
> > =============
> > 
> > Fprobe events allows user to add new events on the entry and exit of kernel
> > functions (which can be ftraced). Unlike kprobe events, the fprobe events
> > can only probe the function entry and exit, and it can only trace the
> > function args, return value, and stacks. (no registers)
> > For probing function body, users can continue to use the kprobe events.
> > 
> > The tracepoint probe events (tprobe events) also allows user to add new
> > events dynamically on the tracepoint. Most of the tracepoint already has
> > trace-events, so this feature is useful if you only want to know a
> > specific parameter, or trace the tracepoints which has no trace-events
> > (e.g. sched_*_tp tracepoints only exposes the tracepoints.)
> > 
> > The fprobe events syntax is;
> > 
> >  f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
> >  f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]
> > 
> > And tracepoint probe events syntax is;
> > 
> >  t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]
> > 
> > This series includes BTF argument support for fprobe/tracepoint events,
> > and kprobe events. This allows us to fetch a specific function parameter
> > by name, and all parameters by '$$args'.
> 
> are you planning to fetch and display more complicated types in future?
> like strings or dereferencing struct field from argument pointer

Yes, that's on my next TODO list. The string thing is a bit problematic,
but I think in most case, "const char *" is used for the strings.

> 
> > Note that enabling this feature, you need to enable CONFIG_BPF_SYSCALL and
> > confirm that your arch supports CONFIG_HAVE_FUNCTION_ARG_ACCESS_API.
> > 
> > E.g.
> > 
> >  # echo 't kfree ptr' >> dynamic_events
> >  # echo 'f kfree object' >> dynamic_events
> >  # cat dynamic_events 
> > t:tracepoints/kfree kfree ptr=ptr
> > f:fprobes/kfree__entry kfree object=object
> >  # echo 1 > events/fprobes/enable
> >  # echo 1 > events/tracepoints/enable
> >  # echo > trace
> >  # head -n 20 trace | tail
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >             tail-84      [000] .....  1324.561958: kfree__entry: (kfree+0x4/0x140) object=0xffff888006383c00
> >             tail-84      [000] ...1.  1324.561961: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff888006383c00
> >             tail-84      [000] .....  1324.561988: kfree__entry: (kfree+0x4/0x140) object=0x0
> >             tail-84      [000] ...1.  1324.561988: kfree: (__probestub_kfree+0x4/0x10) ptr=0x0
> >             tail-84      [000] .....  1324.561989: kfree__entry: (kfree+0x4/0x140) object=0xffff88800671e600
> >             tail-84      [000] ...1.  1324.561989: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff88800671e600
> >             tail-84      [000] .....  1324.562368: kfree__entry: (kfree+0x4/0x140) object=0xffff8880065e0580
> >             tail-84      [000] ...1.  1324.562369: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff8880065e0580
> 
> I checked with perf and record/stat/script seem to work fine with this
> 
>   # ./perf record -e 'fprobes:myprobe'
>   ^C[ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.162 MB perf.data (1 samples) ]
> 
>   # ./perf script
>     systemd-oomd   479 [001] 14550.722079: fprobes:myprobe: (ffffffff81505be0) filename=0x557b033662b0

Thanks for testing!

> 
> perf trace seems to be off with __probe_ip for some reason:
> 
>   # ./perf trace -e 'fprobes:myprobe'
>      0.000 systemd-oomd/479 fprobes:myprobe(__probe_ip: -2125440032, filename: 93986839069680)
>      1.189 systemd-oomd/479 fprobes:myprobe(__probe_ip: -2125440032, filename: 93986839070144)
> 
> but it's probably perf issue

Yeah, it seems that the perf trace handles __probe_ip as signed long.
Does that happen with kprobe events too?

Thank you,
> 
> thanks,
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
