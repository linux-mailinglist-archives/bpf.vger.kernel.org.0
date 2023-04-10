Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614906DC282
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDJCCp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Apr 2023 22:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDJCCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Apr 2023 22:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814DC3593;
        Sun,  9 Apr 2023 19:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A05260C16;
        Mon, 10 Apr 2023 02:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A22EC433D2;
        Mon, 10 Apr 2023 02:02:41 +0000 (UTC)
Date:   Sun, 9 Apr 2023 22:02:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230409220239.0fcf6738@rorschach.local.home>
In-Reply-To: <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
        <20230321101711.625d0ccb@gandalf.local.home>
        <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
        <20230323083914.31f76c2b@gandalf.local.home>
        <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
        <20230323230105.57c40232@rorschach.local.home>
        <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
        <20230409075515.2504db78@rorschach.local.home>
        <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
        <20230409225414.2b66610f4145ade7b09339bb@kernel.org>
        <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 9 Apr 2023 22:44:37 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > You can use ftrace_test_recursion_trylock() before using migrate_disable()
> > if you ensure the callback is only for fentry. Can you prepare a fentry
> > specific callback?
> >  
> 
> fentry uses both ftrace-based probe and text-poke-based probe.
> ftrace_test_recursion_trylock() can avoid the recursion in the
> ftrace-based probe. Not sure if we can split bpf_trampoline_enter into
> two callbacks, one for ftrace and another for text poke. I will
> analyze it. Thanks for your suggestion.

ftrace_test_recusion_trylock() works with anything. What it basically
is doing is to make sure that you do not pass that same location in the
same context.

That is, it sets a specific bit to which context it is in (normal,
softirq, irq or NMI). If you call it again in the same context, it will
return false (recursion detected).

That is,

  normal:
    ftrace_test_recursion_trylock(); <- OK

    softirq:
       ftrace_test_recursion_trylock() <- OK

       hard-irq:
          ftrace_test_recusion_trylock() <- OK
          [ recusion happens ]
          ftrace_test_recursion_trylock() <- FAIL!

That's because it is perfectly fine for the same code path to enter
ftrace code in different contexts, but if it happens in the same
context, that has to be due something calling back into itself.

Thus if you had:

	bit = ftrace_test_recursion_trylock();
	if (bit < 0)
		return;
	migrate_disable();
	ftrace_test_test_recursion_unlock(bit);

It would prevent migrate_disable from recursing.

    bpf_func()
	bit = ftrace_test_recursion_trylock() <<- returns 1
	migrate_disable()
	    preempt_count_add()
		bpf_func()
		    bit = ftrace_test_recusion_trylock() <<- returns -1
		    if (bit < 0)
			return;

It would prevent the crash.

-- Steve

