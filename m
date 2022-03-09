Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3724D3992
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 20:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiCITKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 14:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiCITKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 14:10:30 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00691405FD;
        Wed,  9 Mar 2022 11:09:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q13so2778949plk.12;
        Wed, 09 Mar 2022 11:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/nVY7Pv0jOp1vE8P2rLSzVj8Q/vteoulCeG/Iqc/qo0=;
        b=fs9AQdUqAMDAgQxlCnTIwCd/kC/S8fOKLkoWKRx6jhTp65OiAG5qwAib95SE2OGZj6
         nH+0FojPkjHntv34O76aevt/ZzjBvB7Hu6JkBvBiXa4WSz+eDUxGzb1bbGagNqNwzEMp
         EqjE7z9Ea3atmJISfGLwWhTZxCFLHhn3Ezn1haslV1EnD7FHrw2lxW02f0DN4InGoMLc
         //Rv2YkLBmJKwgEMaKJlI+odrPCDZhEsPuJIFC2+VVWXXy+bXbvixpk62RMBZuLAtTYb
         yRcx/EN4QeAWP5SArZS5LcsvzSg7n0vLHw08MAr6bozZsz3q1Ff5xpi4uV/LM+EvveOH
         Rxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/nVY7Pv0jOp1vE8P2rLSzVj8Q/vteoulCeG/Iqc/qo0=;
        b=OW2gXmwEX6ZczeBc2nTgB8desbyy5ntO8v5awadDpJQrZbfB6nBhuLZ0f2vnBoDxWZ
         9jRvuq7yIB00MYsGHeh3JqbhP4WlSIkuYZ3vPpJllrqW6jk6tFsCj5u7BrPOu1UNHl6n
         iQjzCdRJt59wuQJef4hS/ktZDTJFzzu4vyF8ElKA90Al3CV4Wf0rJIgO1PVXHIB6QSL5
         n9SzY6gcTva6+VJ9mpVcVRkhOXKAjhrOrTdE09OHwZt+eO1fj8lBm1474woHiHqBcwiO
         MXW59oIxAm2BG+LkemxiB5OYjnw+2DiuZ1Job7NkQs5R5ruZZOmtHGD/ie04FPYCxOXs
         pO8A==
X-Gm-Message-State: AOAM530M4+NxBUKkkvyfzjxMbYON5BuIgjx1ezwKjzCLcj3pEs5SNL+b
        XUip+B0sLdQO2e1e2xMZkSlPTeo702g=
X-Google-Smtp-Source: ABdhPJzqbJ+3ZPvgt8XUva6AZh6mj0Ha7NHPXhdAi5NJNBMM9ZgzXXRGIeMWAceiG1AJV7MRKhR0/Q==
X-Received: by 2002:a17:902:be14:b0:14f:ce67:d0a1 with SMTP id r20-20020a170902be1400b0014fce67d0a1mr950100pls.29.1646852963052;
        Wed, 09 Mar 2022 11:09:23 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:db4e])
        by smtp.gmail.com with ESMTPSA id g7-20020a056a000b8700b004e1bed5c3bfsm3968629pfj.68.2022.03.09.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:09:22 -0800 (PST)
Date:   Wed, 9 Mar 2022 11:09:17 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 09, 2022 at 02:02:20AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 08, 2022 at 11:32:37PM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 08, 2022 at 11:01:04PM +0100, Peter Zijlstra wrote:
> > > On Tue, Mar 08, 2022 at 12:00:52PM -0800, Alexei Starovoitov wrote:
> > > > On Tue, Mar 08, 2022 at 04:30:11PM +0100, Peter Zijlstra wrote:
> > > > > Hopefully last posting...
> > > > > 
> > > > > Since last time:
> > > > > 
> > > > >  - updated the ftrace_location() patch (naveen, rostedt)
> > > > >  - added a few comments and clarifications (bpetkov)
> > > > >  - disable jump-tables (joao)
> > > > >  - verified clang-14-rc2 works
> > > > >  - fixed a whole bunch of objtool unreachable insn issue
> > > > >  - picked up a few more tags
> > > > > 
> > > > > Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> > > > > 
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
> > > > 
> > > > I've tried to test it.
> > > 
> > > I could cleanly do:
> > > 
> > > git checkout tip/master
> > > git merge bpf-next/master
> > > git merge queue/x86/wip.ibt
> > > 
> > > You want me to push out that result somewhere?
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt
> > 
> > includes bpf-next/master.
> 
> I just managed to run bpf selftests with that kernel on a tigerlake
> platform.  Seems to still work.

Pulled above and it got even worse.
With kasan and lockdep during qemu boot I see:
[    1.147498] rcu_scheduler_active = 1, debug_locks = 1
[    1.147498] 2 locks held by kthreadd/2:
[    1.147498]  #0: ffff888100362b80 (&p->pi_lock){....}-{2:2}, at: task_rq_lock+0x71/0x380
[    1.147498]  #1: ffff8881f6a3a218 (&rq->__lock){-...}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x40
[    1.147498]
[    1.147498] stack backtrace:
[    1.147498] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc7-02289-gc958c6aae879 #1
[    1.147498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    1.147498] Call Trace:
[    1.147498]  <TASK>
[    1.147498]  dump_stack_lvl+0x48/0x5b
[    1.147498]  cpuacct_charge+0x2b3/0x390
[    1.147498]  update_curr+0x33e/0x7d0
[    1.147498]  dequeue_entity+0x28/0xdf0
[    1.147498]  ? rcu_read_lock_bh_held+0xa0/0xa0
[    1.147498]  dequeue_task_fair+0x1fa/0xd60
[    1.147498]  __do_set_cpus_allowed+0x253/0x620
[    1.147498]  __set_cpus_allowed_ptr_locked+0x25f/0x450
[    1.147498]  __set_cpus_allowed_ptr+0x7c/0xa0
[    1.147498]  ? __set_cpus_allowed_ptr_locked+0x450/0x450
[    1.147498]  ? _raw_spin_unlock_irqrestore+0x34/0x60
[    1.147498]  ? lockdep_hardirqs_on+0x7d/0x100
[    1.147498]  kthreadd+0x48/0x610
[    1.147498]  ? _raw_spin_unlock_irq+0x28/0x50
[    1.147498]  ? kthread_is_per_cpu+0xc0/0xc0
[    1.147498]  ret_from_fork+0x1f/0x30

[    6.698206] ======================================================
[    6.698209] WARNING: possible circular locking dependency detected
[    6.698211] 5.17.0-rc7-02289-gc958c6aae879 #1 Not tainted
[    6.698213] ------------------------------------------------------
[    6.698214] scsi_eh_1/401 is trying to acquire lock:
[    6.698216] ffff888100360900 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb6/0x1570
[    6.698241]
[    6.698241] but task is already holding lock:
[    6.698241] ffffffff854439f8 ((console_sem).lock){-...}-{2:2}, at: up+0x1b/0xe0
[    6.698253]
[    6.698253] which lock already depends on the new lock.
[    6.698253]
[    6.698254]
[    6.698254] the existing dependency chain (in reverse order) is:
[    6.698255]
[    6.698255] -> #2 ((console_sem).lock){-...}-{2:2}:
[    6.698259]        _raw_spin_lock_irqsave+0x3c/0x60
[    6.698270]        down_trylock+0x17/0x70
[    6.698274]        __down_trylock_console_sem+0x23/0x90
[    6.698278]        console_trylock+0x17/0x70
[    6.698281]        vprintk_emit+0x72/0x290
[    6.698288]        _printk+0x9a/0xb4
[    6.698296]        lockdep_rcu_suspicious+0x60/0x158
[    6.698299]        cpuacct_charge+0x2b3/0x390
[    6.698302]        update_curr+0x33e/0x7d0
[    6.698306]        dequeue_entity+0x28/0xdf0
[    6.698308]        dequeue_task_fair+0x1fa/0xd60

Most of the time it hangs during the boot.
I'm using gcc 8.5 and qemu -smp 8

With qemu -smp 1 it luckly boots.
Then I run test_progs and see:
Summary: 215/1115 PASSED, 4 SKIPPED, 18 FAILED
All trampoline tests fail.
Here is one:
$ test_progs -t fentry
test_fentry_fexit:PASS:fentry_skel_load 0 nsec
test_fentry_fexit:PASS:fexit_skel_load 0 nsec
test_fentry_fexit:PASS:fentry_attach 0 nsec
test_fentry_fexit:FAIL:fexit_attach unexpected error: -1 (errno 19)
#54 fentry_fexit:FAIL

or

./test_progs -t xdp_bpf
test_xdp_bpf2bpf:PASS:test_xdp__open_and_load 0 nsec
test_xdp_bpf2bpf:PASS:test_xdp_bpf2bpf__open 0 nsec
test_xdp_bpf2bpf:PASS:test_xdp_bpf2bpf__load 0 nsec
libbpf: prog 'trace_on_entry': failed to attach: Device or resource busy
libbpf: prog 'trace_on_entry': failed to auto-attach: -16
test_xdp_bpf2bpf:FAIL:test_xdp_bpf2bpf__attach unexpected error: -16 (errno 16)
#225 xdp_bpf2bpf:FAIL

