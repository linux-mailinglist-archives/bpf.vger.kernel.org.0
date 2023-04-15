Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85B76E3227
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDOPqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDOPqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 11:46:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ACA2D59;
        Sat, 15 Apr 2023 08:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886C160AEE;
        Sat, 15 Apr 2023 15:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7182EC433D2;
        Sat, 15 Apr 2023 15:46:37 +0000 (UTC)
Date:   Sat, 15 Apr 2023 11:46:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] tracing: Add generic test_recursion_try_acquire()
Message-ID: <20230415114635.15d9eda8@rorschach.local.home>
In-Reply-To: <CALOAHbB9VvOAuA5kG3YpS-XMqX9AFGxbuOQWerJTQYgsqU182A@mail.gmail.com>
References: <20230414221702.554c44fe@rorschach.local.home>
        <CALOAHbDUkvyu0hWXfcveJBW_dxDkqUTVBmwXt5Y-ERBv9GksbQ@mail.gmail.com>
        <CALOAHbB9VvOAuA5kG3YpS-XMqX9AFGxbuOQWerJTQYgsqU182A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 15 Apr 2023 22:33:17 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> 
> I don't have a clear idea why TRACE_CTX_TRANSITION must be needed, but
> it seems we have to do below code for the fentry test case,

The issue is that there's still cases that we can trace when
preempt_count hasn't been updated to the new context. That is,
preempt_count is used to determine if we are in softirq, hardirq or NMI
context. But there's some places that have:

 normal context:
 func_a() --> traced
   --> interrupt
    func_b() --> traced
    preempt_count_add(HARDIRQ_OFFSET)

Now we drop the second trace because it is flagged as a recursion when
in reality it is in a new context, but the preempt_count has not been
updated yet.

We are currently fixing these locations, but it's not there yet. And
since there's tools that relies on not dropping these locations, the
transition bit needs to be there until this situation is dealt with.

Can you change the tests to allow a single recursion?

-- Steve

> 
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index d48cd92d2364..f6b4601dd604 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -163,21 +163,8 @@ static __always_inline int
> trace_test_and_set_recursion(unsigned long ip, unsign
>   return -1;
> 
>   bit = trace_get_context_bit() + start;
> - if (unlikely(val & (1 << bit))) {
> - /*
> - * If an interrupt occurs during a trace, and another trace
> - * happens in that interrupt but before the preempt_count is
> - * updated to reflect the new interrupt context, then this
> - * will think a recursion occurred, and the event will be dropped.
> - * Let a single instance happen via the TRANSITION_BIT to
> - * not drop those events.
> - */
> - bit = TRACE_CTX_TRANSITION + start;
> - if (val & (1 << bit)) {
> - do_ftrace_record_recursion(ip, pip);
> - return -1;
> - }
> - }
> + if (unlikely(val & (1 << bit)))
> + return -1;
> 
>   val |= 1 << bit;
>   current->trace_recursion = val;
> 
> 
> > The reason is that the bpf_map_delete_elem() in this fentry SEC()[2]
