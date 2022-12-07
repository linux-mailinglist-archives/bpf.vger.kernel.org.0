Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24E64531B
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 05:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLGEj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 23:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLGEj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 23:39:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AF56EDD;
        Tue,  6 Dec 2022 20:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C0A2B81CD2;
        Wed,  7 Dec 2022 04:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C926AC433D6;
        Wed,  7 Dec 2022 04:39:48 +0000 (UTC)
Date:   Tue, 6 Dec 2022 23:39:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-ID: <20221206233947.4c27cc9d@gandalf.local.home>
In-Reply-To: <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
        <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
        <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
        <20221206162035.97ae19674d6d17108bed1910@kernel.org>
        <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 6 Dec 2022 20:01:46 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:


> >   
> > > At this point crash dump might be necessary to debug.  
> > 
> > Yes. So the TAINT flag can help. Please consider that the TAINT flag
> > doesn't mean you are guilty, but this is just a hint for debugging.
> > (good for the first triage)  
> 
> I think you misunderstand the reason behind 'tainted' flags.
> It's 'hint for debugging' only on the surface.
> See Documentation/admin-guide/tainted-kernels.rst
> "... That's why bug reports
> from tainted kernels will often be ignored by developers, hence try to reproduce
> problems with an untainted kernel."

You conveniently left out the first part of that paragraph. Showing just a
portion of a statement can be very misleading. Let me add the whole
paragraph here:

   The kernel will mark itself as 'tainted' when something occurs that
   might be relevant later when investigating problems. Don't worry too much about this,
   most of the time it's not a problem to run a tainted kernel; the information is
   mainly of interest once someone wants to investigate some problem, as its real
   cause might be the event that got the kernel tainted. That's why bug reports
   from tainted kernels will often be ignored by developers, hence try to reproduce
   problems with an untainted kernel.

Let me stress the very first sentence above:

   The kernel will mark itself as 'tainted' when something occurs that
   might be relevant later when investigating problems.

I think you are the one that is misunderstanding what a taint is. It most
definitely is about giving hints for debugging. That's why the very first
sentence of that paragraph, as well as the entire document, explicitly
states "might be relevant later when investigating problems".


> 
> When 'error injection' finds a kernel bug the kernel developers need to
> look into it regardless whether it's syzbot error injection
> or whatever other mechanism.
> 

And this is a very useful taint. Just like:

  2  _/S       4  kernel running on an out of specification system
  5  _/B      32  bad page referenced or some unexpected page flags
  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
 10  _/C    1024  staging driver was loaded
 11  _/I    2048  workaround for bug in platform firmware applied
 14  _/L   16384  soft lockup occurred 
 17  _/T  131072  kernel was built with the struct randomization plugin

Any of the above should not be ignored by developers, but they are useful
hints for debugging the issue.


> To change the topic to something ... else...
> 
> We've just hit this panic using rethook.
> [   49.235708] ==================================================================
> [   49.236243] BUG: KASAN: use-after-free in rethook_try_get+0x7e/0x380
> [   49.236693] Read of size 8 at addr ffff888102e62c88 by task test_progs/1688
> [   49.240398]  kasan_report+0x90/0x190
> [   49.240934]  rethook_try_get+0x7e/0x380
> [   49.244885]  fprobe_handler.part.1+0x119/0x1f0
> [   49.245505]  arch_ftrace_ops_list_func+0x17d/0x1d0
> [   49.246544]  ftrace_regs_call+0x5/0x52
> [   49.247411]  bpf_fentry_test1+0x5/0x10
> 
> [   49.262578] Allocated by task 1692:
> [   49.262804]  kasan_save_stack+0x1c/0x40
> [   49.263059]  kasan_set_track+0x21/0x30
> [   49.263335]  __kasan_kmalloc+0x7a/0x90
> [   49.263624]  rethook_alloc+0x2c/0xa0
> [   49.263879]  fprobe_init_rethook+0x6d/0x170
> [   49.264154]  register_fprobe_ips+0xae/0x130
> 
> [   49.265938] Freed by task 0:
> [   49.266153]  kasan_save_stack+0x1c/0x40
> [   49.266440]  kasan_set_track+0x21/0x30
> [   49.266705]  kasan_save_free_info+0x26/0x40
> [   49.266995]  __kasan_slab_free+0x103/0x190
> [   49.267282]  __kmem_cache_free+0x1b7/0x3a0
> [   49.267559]  rcu_core+0x4d8/0xd50
> 
> [   49.268181] Last potentially related work creation:
> [   49.268565]  kasan_save_stack+0x1c/0x40
> [   49.268898]  __kasan_record_aux_stack+0xa1/0xb0
> [   49.269260]  call_rcu+0x47/0x360
> [   49.269526]  unregister_fprobe+0x47/0x80
> 
> [   49.281382] general protection fault, probably for non-canonical address 0x57e006e00000000: 0000 [#1] PREEMPT SMP KASAN
> [   49.282226] CPU: 6 PID: 1688 Comm: test_progs Tainted: G    B      O       6.1.0-rc7-01508-gf0c5a2d9f234 #4343
> [   49.283751] RIP: 0010:rethook_trampoline_handler+0xff/0x1d0
> [   49.289900] Call Trace:
> [   49.290083]  <TASK>
> [   49.290248]  arch_rethook_trampoline_callback+0x6c/0xa0
> [   49.290631]  arch_rethook_trampoline+0x2c/0x50
> [   49.290964]  ? lock_release+0xad/0x3f0
> [   49.291245]  ? bpf_prog_test_run_tracing+0x235/0x380
> [   49.291609]  trace_clock_x86_tsc+0x10/0x10
> 
> This is just running bpf selftests in parallel mode on 16-cpu VM on bpf-next.
> Notice 'Tained' flags.
> Please take a look.
> 

"G - Proprietary module" - "O - out of tree module"

Can you reproduce this without those taints?

-- Steve
