Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214266EA340
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 07:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDUFij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjDUFii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 01:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF165B7;
        Thu, 20 Apr 2023 22:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E188564DC5;
        Fri, 21 Apr 2023 05:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A8C433D2;
        Fri, 21 Apr 2023 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682055513;
        bh=okX8G73kUYpMvr7PR1bTBTURUIZ0HskAOzEnVg/ac5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rcq5qUUbeaGkV0SXQHTsMfe1ovnEc1Ga4y8233Pk/NDzDU21nWqH8OzY6CS7RgNaR
         sQAxx6bX8nvfWZIYS4+zHlbtl0xcRaTldYz4Q+BCoMo+TFU8AEdo8zk0ySCDAZNGff
         gMrbXQf00qVW0qBwlJ9+/Eug4KytKGpw+vcU4Nh1DzySTreycombjlRxwalViElGxb
         x0J7KjYEwgyvVEhtPknJAIqexkE2aJd8S1lrPVXnUqthoJkKKYEQlLVPkIT0xmLXgz
         g+KiqQ5i+Pn7fNXpl5rywQiQqRSL7FltkyMnw1XKWAe2+sOGke4AP6XDukp26TvQze
         k6gwnYjZ8hHZw==
Date:   Fri, 21 Apr 2023 14:38:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230421143828.bb274512144e133eb5fead1a@kernel.org>
In-Reply-To: <CAADnVQ+R3ySQpFDnn-2EtUooDmkwTBCh_yRjqNBDhS5SvWrTYQ@mail.gmail.com>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
        <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
        <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local>
        <20230421084106.5a02844971e18cdd8ad163be@kernel.org>
        <CAADnVQ+R3ySQpFDnn-2EtUooDmkwTBCh_yRjqNBDhS5SvWrTYQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 20 Apr 2023 16:46:08 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Apr 20, 2023 at 4:41 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 20 Apr 2023 11:49:32 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Thu, Apr 20, 2023 at 08:25:50PM +0900, Masami Hiramatsu (Google) wrote:
> > > > +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > > > +                       struct pt_regs *regs)
> > > > +{
> > > > +   struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > > > +   struct fentry_trace_entry_head *entry;
> > > > +   struct hlist_head *head;
> > > > +   int size, __size, dsize;
> > > > +   int rctx;
> > > > +
> > > > +   if (bpf_prog_array_valid(call)) {
> > > > +           unsigned long orig_ip = instruction_pointer(regs);
> > > > +           int ret;
> > > > +
> > > > +           ret = trace_call_bpf(call, regs);
> > >
> > > Please do not call bpf from fprobe.
> > > There is no use case for it.
> >
> > OK.
> >
> > >
> > > > +
> > > > +           /*
> > > > +            * We need to check and see if we modified the pc of the
> > > > +            * pt_regs, and if so return 1 so that we don't do the
> > > > +            * single stepping.
> > > > +            */
> > > > +           if (orig_ip != instruction_pointer(regs))
> > > > +                   return 1;
> > > > +           if (!ret)
> > > > +                   return 0;
> > > > +   }
> > > > +
> > > > +   head = this_cpu_ptr(call->perf_events);
> > > > +   if (hlist_empty(head))
> > > > +           return 0;
> > > > +
> > > > +   dsize = __get_data_size(&tf->tp, regs);
> > > > +   __size = sizeof(*entry) + tf->tp.size + dsize;
> > > > +   size = ALIGN(__size + sizeof(u32), sizeof(u64));
> > > > +   size -= sizeof(u32);
> > > > +
> > > > +   entry = perf_trace_buf_alloc(size, NULL, &rctx);
> > > > +   if (!entry)
> > > > +           return 0;
> > > > +
> > > > +   entry->ip = entry_ip;
> > > > +   memset(&entry[1], 0, dsize);
> > > > +   store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > > > +   perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
> > > > +                         head, NULL);
> > > > +   return 0;
> > > > +}
> > > > +NOKPROBE_SYMBOL(fentry_perf_func);
> > > > +
> > > > +static void
> > > > +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > > > +           unsigned long ret_ip, struct pt_regs *regs)
> > > > +{
> > > > +   struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > > > +   struct fexit_trace_entry_head *entry;
> > > > +   struct hlist_head *head;
> > > > +   int size, __size, dsize;
> > > > +   int rctx;
> > > > +
> > > > +   if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs))
> > > > +           return;
> > >
> > > Same here.
> > > These two parts look like copy-paste from kprobes.
> > > I suspect this code wasn't tested at all.
> >
> > OK, I missed to test that bpf part. I thought bpf could be appended to
> > any "trace-event" (looks like trace-event), isn't it?
> 
> No. We're not applying bpf filtering to any random event
> that gets introduced in a tracing subsystem.
> fprobe falls into that category.
> Every hook where bpf can be invoked has to be thought through.
> That mental exercise didn't happen here.

OK. Just out of curiousity, where is the "tracepoint" filter applied?
In the kernel (verifier?) or the userspace?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
