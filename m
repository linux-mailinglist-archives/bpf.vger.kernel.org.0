Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AE6EC455
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 06:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDXEZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 00:25:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADE1FE3;
        Sun, 23 Apr 2023 21:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38FDC61B4B;
        Mon, 24 Apr 2023 04:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D359AC433EF;
        Mon, 24 Apr 2023 04:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682310303;
        bh=Zua6L/hjc3WFgygJ/KfVa8EDxia4HmdVPahd6/IlxdE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9lMFFYp0hzVZ2TEwHcNm5kYoZ//Ys+PeMosVEnwMlD+vj4GlNKqaMnRSufZFl0FI
         zNInAQ4FlON1bKKRd95XES27j7i5aT2Zf3C3FuoZ5EDZhmNxa9IYv5b/zaRZ100jL+
         +ArPLlR1rsveMG0/oclONaUJq1PyUV89BeVQUwVc1jt4zM3vD/lt4R14RUH/d37Ijw
         kNVRB/xLJclOC8gC8EkHqq6kiXdnkLpVbJ+iCw62faSHcM8RAyKlo03y6EufyhWZs3
         fL2MT4jpM3B5bLxsX0+GdD+8bzqzJo4G7g2AdbTUKmEFyzQQW+YCXKuc3PN1qtqe+g
         6u6RT51rn+o0A==
Date:   Mon, 24 Apr 2023 13:24:59 +0900
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
Message-Id: <20230424132459.2f373669e178c3be74e71b0e@kernel.org>
In-Reply-To: <CAADnVQKAqZybpvzWRFCXmfbUSpaM2YYx9shRSSLnYWp=tQMyHg@mail.gmail.com>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
        <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
        <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local>
        <20230421084106.5a02844971e18cdd8ad163be@kernel.org>
        <CAADnVQ+R3ySQpFDnn-2EtUooDmkwTBCh_yRjqNBDhS5SvWrTYQ@mail.gmail.com>
        <20230421143828.bb274512144e133eb5fead1a@kernel.org>
        <CAADnVQKAqZybpvzWRFCXmfbUSpaM2YYx9shRSSLnYWp=tQMyHg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Apr 2023 09:31:12 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Apr 20, 2023 at 10:38 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 20 Apr 2023 16:46:08 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Thu, Apr 20, 2023 at 4:41 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Thu, 20 Apr 2023 11:49:32 -0700
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > > On Thu, Apr 20, 2023 at 08:25:50PM +0900, Masami Hiramatsu (Google) wrote:
> > > > > > +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > > > > > +                       struct pt_regs *regs)
> > > > > > +{
> > > > > > +   struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > > > > > +   struct fentry_trace_entry_head *entry;
> > > > > > +   struct hlist_head *head;
> > > > > > +   int size, __size, dsize;
> > > > > > +   int rctx;
> > > > > > +
> > > > > > +   if (bpf_prog_array_valid(call)) {
> > > > > > +           unsigned long orig_ip = instruction_pointer(regs);
> > > > > > +           int ret;
> > > > > > +
> > > > > > +           ret = trace_call_bpf(call, regs);
> > > > >
> > > > > Please do not call bpf from fprobe.
> > > > > There is no use case for it.
> > > >
> > > > OK.
> > > >
> > > > >
> > > > > > +
> > > > > > +           /*
> > > > > > +            * We need to check and see if we modified the pc of the
> > > > > > +            * pt_regs, and if so return 1 so that we don't do the
> > > > > > +            * single stepping.
> > > > > > +            */
> > > > > > +           if (orig_ip != instruction_pointer(regs))
> > > > > > +                   return 1;
> > > > > > +           if (!ret)
> > > > > > +                   return 0;
> > > > > > +   }
> > > > > > +
> > > > > > +   head = this_cpu_ptr(call->perf_events);
> > > > > > +   if (hlist_empty(head))
> > > > > > +           return 0;
> > > > > > +
> > > > > > +   dsize = __get_data_size(&tf->tp, regs);
> > > > > > +   __size = sizeof(*entry) + tf->tp.size + dsize;
> > > > > > +   size = ALIGN(__size + sizeof(u32), sizeof(u64));
> > > > > > +   size -= sizeof(u32);
> > > > > > +
> > > > > > +   entry = perf_trace_buf_alloc(size, NULL, &rctx);
> > > > > > +   if (!entry)
> > > > > > +           return 0;
> > > > > > +
> > > > > > +   entry->ip = entry_ip;
> > > > > > +   memset(&entry[1], 0, dsize);
> > > > > > +   store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > > > > > +   perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
> > > > > > +                         head, NULL);
> > > > > > +   return 0;
> > > > > > +}
> > > > > > +NOKPROBE_SYMBOL(fentry_perf_func);
> > > > > > +
> > > > > > +static void
> > > > > > +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > > > > > +           unsigned long ret_ip, struct pt_regs *regs)
> > > > > > +{
> > > > > > +   struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > > > > > +   struct fexit_trace_entry_head *entry;
> > > > > > +   struct hlist_head *head;
> > > > > > +   int size, __size, dsize;
> > > > > > +   int rctx;
> > > > > > +
> > > > > > +   if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs))
> > > > > > +           return;
> > > > >
> > > > > Same here.
> > > > > These two parts look like copy-paste from kprobes.
> > > > > I suspect this code wasn't tested at all.
> > > >
> > > > OK, I missed to test that bpf part. I thought bpf could be appended to
> > > > any "trace-event" (looks like trace-event), isn't it?
> > >
> > > No. We're not applying bpf filtering to any random event
> > > that gets introduced in a tracing subsystem.
> > > fprobe falls into that category.
> > > Every hook where bpf can be invoked has to be thought through.
> > > That mental exercise didn't happen here.
> >
> > OK. Just out of curiousity, where is the "tracepoint" filter applied?
> > In the kernel (verifier?) or the userspace?
> 
> Sorry. I don't understand the question.
> Are you talking about BPF_PROG_TYPE_TRACEPOINT or BPF_PROG_TYPE_RAW_TRACEPOINT ?

I thought that you filtered the available events by name, but I found
that perf_event_set_bpf_prog() checks TRACE_EVENT_FL_* flags and
its combinations. Yeah, in that case this new fprobe event introduced
TRACE_EVENT_FL_FPROBE and bpf will reject to use it.

OK, let me remove the BPF support from this series. I think the fprobe
event can be used as same as kprobe events, but I have a plan to change
it for supporting fprobe wider architectures. Thus it will require a bit
different way to get the register values.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
