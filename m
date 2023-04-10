Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CF6DC5C1
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 12:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjDJKaw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 06:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJKav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 06:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D61FF0;
        Mon, 10 Apr 2023 03:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7ACF60DDE;
        Mon, 10 Apr 2023 10:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF07C433D2;
        Mon, 10 Apr 2023 10:30:48 +0000 (UTC)
Date:   Mon, 10 Apr 2023 06:30:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230410063046.391dd2bd@rorschach.local.home>
In-Reply-To: <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
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
        <20230409220239.0fcf6738@rorschach.local.home>
        <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 10 Apr 2023 13:36:32 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> Many thanks for the detailed explanation.
> I think ftrace_test_recursion_trylock() can't apply to migreate_enable().
> If we change as follows to prevent migrate_enable() from recursing,
> 
>          bit = ftrace_test_recursion_trylock();
>          if (bit < 0)
>                  return;
>          migrate_enable();
>          ftrace_test_recursion_unlock(bit);
> 
> We have called migrate_disable() before, so if we don't call
> migrate_enable() it will cause other issues.

Right. Because you called migrate_disable() before (and protected it
with the ftrace_test_recursion_trylock(), the second call is guaranteed
to succeed!

[1]	bit = ftrace_test_recursion_trylock();
	if (bit < 0)
		return;
	migrate_disable();
	ftrace_test_recursion_trylock(bit);

	[..]

[2]	ftrace_test_recursion_trylock();
	migrate_enable();
	ftrace_test_recursion_trylock(bit);

You don't even need to read the bit again, because it will be the same
as the first call [1]. That's because it returns the recursion level
you are in. A function will have the same recursion level through out
the function (as long as it always calls ftrace_test_recursion_unlock()
between them).

	bpf_func()
	    bit = ftrace_test_recursion_trylock(); <-- OK
	    migrate_disable();
	    ftrace_test_recursion_unlock(bit);

	    [..]

	    ftrace_test_recursion_trylock(); <<-- guaranteed to be OK
	    migrate_enable() <<<-- gets traced

		bpf_func()
		    bit = ftrace_test_recursion_trylock() <-- FAILED
		    if (bit < 0)
			return;

	    ftrace_test_recursion_unlock(bit);


See, still works!

The migrate_enable() will never be called without the migrate_disable()
as the migrate_disable() only gets called when not being recursed.

Note, the ftrace_test_recursion_*() code needs to be updated because it
currently does disable preemption, which it doesn't have to. And that
can cause migrate_disable() to do something different. It only disabled
preemption, as there was a time that it needed to, but now it doesn't.
But the users of it will need to be audited to make sure that they
don't need the side effect of it disabling preemption.

-- Steve
