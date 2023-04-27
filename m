Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967206F053C
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbjD0L7D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjD0L7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 07:59:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FA4C3D;
        Thu, 27 Apr 2023 04:59:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-959a626b622so797830466b.0;
        Thu, 27 Apr 2023 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682596739; x=1685188739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AE7Pspd28nFtHWfyIzA120GvJp4aroY+ZH6NEOLYSVY=;
        b=fgKLrUtQzL7xid5SkT14yLFXtyHM4Krt/K+Vesqq6FddnrKpdE5lN4tQ9YDsDTkFr3
         bHfJDJHTjHFfGsTr9C5XddTJyIs3JmngwkkCJHilsVQPJKkRdK06+zYr7YSUrfaLAh7Z
         FzRTDZcBCuy7rmzM7XJ8G61tUIEWr/aiwDchxCqv6rQnLk0zjJ5mubKQUx7Z/zsq+iuo
         lg7TsEiQbQSUqrx29E6BRsvePZvHTeEwoAS9QKlGxRvpXx/naySV8aPifxKfhXBDNt0N
         aE3DPFNJyU+r0r4TTqTzfakJGrnbFJ75RB80NoJ1qKTp8ZqczciQRFZCDKP6oyMsH3dF
         vcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682596739; x=1685188739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE7Pspd28nFtHWfyIzA120GvJp4aroY+ZH6NEOLYSVY=;
        b=i9yIHrduY3WzqSL1zjqeD6MUrxIxSeij6qsR4FgrL5E9hivIK3V5YpAgC+uAwByrd1
         AjVMx+uxBd4Wubku/gL89Rk+/YwSM09Vqb/O60S9o8DMpdxPB5NLqqdQQheuE1A3KHgj
         7fUaTKgyAJ+5hEKi+jyfFKmincUSjnn46n8+xQkpB06zqG0ejjIJnt6SEgak/NKV0P5L
         0UyJQsWDiL+7/FoRG8ecPOpeMsDxImAAU2y1oIs/94t2xCwo7BVfMcTjYrtzrZzg5wH2
         4lKpex75tZdtUTaEO5WYxxtpbdqeEYJzXI0VLGEO3wK0/lFtGq8Z0NIOw7mz/L8PxJ0H
         HUFQ==
X-Gm-Message-State: AC+VfDxvXngGkBAbNr0MmD955tyDCKM1stRwFLHw1D/FQiDmbJtpjGAS
        /MPR5lSD6yd4czpcpYsALzs=
X-Google-Smtp-Source: ACHHUZ7lpvqWveupZjInIJ3m9ZqG439Xu8iO1z3t4DXYCmhoeZazsYr/aAslTH1pP9VgZXhTerGgUA==
X-Received: by 2002:a17:907:968a:b0:939:e870:2b37 with SMTP id hd10-20020a170907968a00b00939e8702b37mr1610565ejc.70.1682596739003;
        Thu, 27 Apr 2023 04:58:59 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090681c100b0094f67ea6598sm9491285ejx.193.2023.04.27.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 04:58:58 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 13:58:56 +0200
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v7 00/11] tracing: Add fprobe events
Message-ID: <ZEpjgKmDwg1GTCTR@krava>
References: <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168255826500.2565678.17719875734305974633.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 10:17:45AM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 7th version of improve fprobe and add a basic fprobe event
> support for ftrace (tracefs) and perf. Here is the previous version.
> 
> https://lore.kernel.org/all/168234755610.2210510.12133559313738141202.stgit@mhiramat.roam.corp.google.com/
> 
> This version is rebased on the latest linux-trace/for-next, fixes
> bpf_get_btf_vmlinux() return value check [6/11] and adds new BTF $retval
> type support [9/11] (I forgot to implement this feature last time).
> Also updates according to the BTF $retval type support.
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

are you planning to fetch and display more complicated types in future?
like strings or dereferencing struct field from argument pointer

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

I checked with perf and record/stat/script seem to work fine with this

  # ./perf record -e 'fprobes:myprobe'
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.162 MB perf.data (1 samples) ]

  # ./perf script
    systemd-oomd   479 [001] 14550.722079: fprobes:myprobe: (ffffffff81505be0) filename=0x557b033662b0

perf trace seems to be off with __probe_ip for some reason:

  # ./perf trace -e 'fprobes:myprobe'
     0.000 systemd-oomd/479 fprobes:myprobe(__probe_ip: -2125440032, filename: 93986839069680)
     1.189 systemd-oomd/479 fprobes:myprobe(__probe_ip: -2125440032, filename: 93986839070144)

but it's probably perf issue

thanks,
jirka
