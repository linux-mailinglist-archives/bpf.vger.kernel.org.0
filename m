Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD896DC7AA
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDJOMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDJOM3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 10:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36620211E;
        Mon, 10 Apr 2023 07:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C17A261CAD;
        Mon, 10 Apr 2023 14:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EB9C433D2;
        Mon, 10 Apr 2023 14:12:26 +0000 (UTC)
Date:   Mon, 10 Apr 2023 10:12:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230410101224.7e3b238c@gandalf.local.home>
In-Reply-To: <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
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
        <20230410063046.391dd2bd@rorschach.local.home>
        <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 10 Apr 2023 21:56:16 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> Thanks for your explanation again.
> BPF trampoline is a little special. It includes three parts, as follows,
> 
>     ret = __bpf_prog_enter();
>     if (ret)
>         prog->bpf_func();
>      __bpf_prog_exit();
> 
> migrate_disable() is called in __bpf_prog_enter() and migrate_enable()
> in __bpf_prog_exit():
> 
>     ret = __bpf_prog_enter();
>                 migrate_disable();
>     if (ret)
>         prog->bpf_func();
>      __bpf_prog_exit();
>           migrate_enable();
> 
> That said, if we haven't executed migrate_disable() in
> __bpf_prog_enter(), we shouldn't execute migrate_enable() in
> __bpf_prog_exit().
> Can ftrace_test_recursion_trylock() be applied to this pattern ?

Yes, it can! And in this you would need to not call migrate_enable()
because if the trace_recursion_trylock() failed, it would prevent
migrate_disable() from being called (and should not let the bpf_func() from
being called either. And then the migrate_enable in __bpf_prog_exit() would
need to know not to call migrate_enable() which checking the return value
of ftrace_test_recursion_trylock() would give the same value as what the
one before migrate_disable() had.


> 
> > Note, the ftrace_test_recursion_*() code needs to be updated because it
> > currently does disable preemption, which it doesn't have to. And that
> > can cause migrate_disable() to do something different. It only disabled
> > preemption, as there was a time that it needed to, but now it doesn't.
> > But the users of it will need to be audited to make sure that they
> > don't need the side effect of it disabling preemption.
> >  
> 
> disabling preemption is not expected by bpf prog, so I think we should
> change it.

The disabling of preemption was just done because every place that used it
happened to also disable preemption. So it was just a clean up, not a
requirement. Although the documentation said it did disable preemption :-/

 See ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")

I think I can add a ftrace_test_recursion_try_aquire() and release() that
is does the same thing without preemption. That way, we don't need to
revert that patch, and use that instead.

-- Steve
