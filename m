Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C76DBFB6
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDILzV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Apr 2023 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDILzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Apr 2023 07:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C123594;
        Sun,  9 Apr 2023 04:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14BA760B86;
        Sun,  9 Apr 2023 11:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CE1C433D2;
        Sun,  9 Apr 2023 11:55:17 +0000 (UTC)
Date:   Sun, 9 Apr 2023 07:55:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230409075515.2504db78@rorschach.local.home>
In-Reply-To: <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
        <20230321101711.625d0ccb@gandalf.local.home>
        <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
        <20230323083914.31f76c2b@gandalf.local.home>
        <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
        <20230323230105.57c40232@rorschach.local.home>
        <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
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

On Sun, 9 Apr 2023 13:32:12 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> Hi Steven,
> 
> When I was trying to attach fentry to preempt_count_{sub,add}, the
> kernel just crashed. The crash info as follows,
> 
> [  867.843050] BUG: TASK stack guard page was hit at 0000000009d325cf
> (stack is 0000000046a46a15..00000000537e7b28)
> [  867.843064] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
> [  867.843067] CPU: 8 PID: 11009 Comm: trace Kdump: loaded Not tainted 6.2.0+ #4
> [  867.843071] RIP: 0010:exc_int3+0x6/0xe0
> [  867.843078] Code: e9 a6 fe ff ff e8 6a 3d 00 00 66 2e 0f 1f 84 00
> 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89
> e5 41 55 <41> 54 49 89 fc e8 10 11 00 00 85 c0 75 31 4c 89 e7 41 f6 84
> 24 88
> [  867.843080] RSP: 0018:ffffaaac44f1c000 EFLAGS: 00010093
> [  867.843083] RAX: ffffaaac44f1c018 RBX: 0000000000000000 RCX: ffffffff98e0102d
> [  867.843085] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffaaac44f1c018
> [  867.843086] RBP: ffffaaac44f1c008 R08: 0000000000000000 R09: 0000000000000000
> [  867.843087] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  867.843089] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  867.843092] FS:  00007f8af6fbe740(0000) GS:ffff96d77f800000(0000)
> knlGS:0000000000000000
> [  867.843094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  867.843096] CR2: ffffaaac44f1bff8 CR3: 0000000105a9c002 CR4: 0000000000770ee0
> [  867.843097] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  867.843098] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  867.843099] PKRU: 55555554
> [  867.843100] Call Trace:
> [  867.843101]  <TASK>
> [  867.843104]  asm_exc_int3+0x3a/0x40
> [  867.843108] RIP: 0010:preempt_count_sub+0x1/0xa0
> [  867.843112] Code: c7 c7 40 06 ff 9a 48 89 e5 e8 8b c6 1d 00 5d c3
> cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 cc <1f> 44 00 00 55 8b 0d 2c 60 f0 02 48 89 e5 85 c9 75 1b 65 8b
> 05 4e
> [  867.843113] RSP: 0018:ffffaaac44f1c0f0 EFLAGS: 00000002
> [  867.843115] RAX: 0000000000000001 RBX: ffff96d77f82c380 RCX: 0000000000000000
> [  867.843116] RDX: 0000000000000000 RSI: ffffffff9947d6fd RDI: 0000000000000001
> [  867.843117] RBP: ffffaaac44f1c108 R08: 0000000000000020 R09: 0000000000000000
> [  867.843118] R10: 0000000000000000 R11: 0000000040000000 R12: ffff96c886c3c000
> [  867.843119] R13: 0000000000000009 R14: ffff96c880050000 R15: ffff96c8800504b8
> [  867.843128]  ? preempt_count_sub+0x1/0xa0
> [  867.843131]  ? migrate_disable+0x77/0x90
> [  867.843135]  __bpf_prog_enter_recur+0x17/0x90
> [  867.843148]  bpf_trampoline_6442468108_0+0x2e/0x1000
> [  867.843154]  ? preempt_count_sub+0x1/0xa0
> [  867.843157]  preempt_count_sub+0x5/0xa0
> [  867.843159]  ? migrate_enable+0xac/0xf0
> [  867.843164]  __bpf_prog_exit_recur+0x2d/0x40
> [  867.843168]  bpf_trampoline_6442468108_0+0x55/0x1000
> ...
> [  867.843788]  preempt_count_sub+0x5/0xa0
[..]
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 17 e0 2c 00 f7 d8 64 89
> 01 48
> [  867.845543] RSP: 002b:00007ffcf51a64e8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000141
> [  867.845546] RAX: ffffffffffffffda RBX: 00007ffcf51a65d0 RCX: 00007f8af60f8e29
> [  867.845547] RDX: 0000000000000030 RSI: 00007ffcf51a6500 RDI: 000000000000001c
> [  867.845549] RBP: 0000000000000018 R08: 0000000000000020 R09: 0000000000000000
> [  867.845550] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> [  867.845551] R13: 0000000000000006 R14: 0000000000922010 R15: 0000000000000000
> [  867.845561]  </TASK>
> 
> The reason is that we will call migrate_disable before entering bpf prog
> and call migrate_enable after bpf prog exits. In
> migrate_disable, preempt_count_{add,sub} will be called, so the bpf prog
> will end up with dead looping there. We can't avoid calling
> preempt_count_{add,sub} in this procedure, so we have to hide them
> from ftrace, then they can't be traced.
> 
> So I think we'd better fix it with below change,  what do you think ?

Sounds like a bug in BPF. ftrace has recursion protection (see
ftrace_test_recursion_trylock()).

> 
> ---
>  kernel/sched/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index af017e0..b049a07 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5758,7 +5758,7 @@ static inline void preempt_latency_start(int val)
>   }
>  }
> 
> -void preempt_count_add(int val)
> +void notrace preempt_count_add(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>   /*
> @@ -5778,7 +5778,6 @@ void preempt_count_add(int val)
>   preempt_latency_start(val);
>  }
>  EXPORT_SYMBOL(preempt_count_add);
> -NOKPROBE_SYMBOL(preempt_count_add);
> 
>  /*
>   * If the value passed in equals to the current preempt count
> @@ -5790,7 +5789,7 @@ static inline void preempt_latency_stop(int val)
>   trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
>  }
> 
> -void preempt_count_sub(int val)
> +void notrace preempt_count_sub(int val)

NACK!

I attach to these functions all the time, I'm not going to make them
hidden because one new user of ftrace is broken.

The fix is either to block bpf from attaching to these functions
(without stopping all other users that can safely trace it)

Or use something similar to the ftrace_test_recursion_trylock() that
prevents this and can be wrapped around the migrate_disable/enable()
callers.

Or maybe we can make migrate_disable() use preempt_disable_notrace() if
it's proven not to take disable preemption for a long time.

-- Steve


>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>   /*
> @@ -5810,7 +5809,6 @@ void preempt_count_sub(int val)
>   __preempt_count_sub(val);
>  }
>  EXPORT_SYMBOL(preempt_count_sub);
> -NOKPROBE_SYMBOL(preempt_count_sub);
> 
>  #else
>  static inline void preempt_latency_start(int val) { }

