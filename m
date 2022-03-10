Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C704D439B
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiCJJhB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 04:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCJJhB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 04:37:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D1813A1ED;
        Thu, 10 Mar 2022 01:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=irYEUP1LT5nKyhqvu9/7+diZD18yg6h9RclMUqCTiQc=; b=N0t7WEhdE6u1lZitiQcVOtvC6R
        L38cospM2R9+1sl5T4IcUHRAckeRgvvSsw6rKbwkO31ku+d9bN+F2sGfE7LqJ5awdeq77cGgZ7o94
        T5/F1X7nn77kYNEuIlmo+bKxLhO+totKRMvaQDOrzDUqX5v0aOsiwSpZ2dfIJ4YA9sujVUa3CKMcL
        rO2+Y9lVnP+4iqNEyNMqVI5BC5P2DUYnrU8nYpoTnIbtezeFfb63GFPlcVq9arMHV3N+G7qJgXyPO
        HHPTUy+jCjd60hWnbcBCqw7Ukcb4nmeLFWeLw1J5LnRRuMDLD9Wyp8IVhwpLAglzqTQ8v5+a3hqLY
        xP2KazhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSFCo-000ODF-8c; Thu, 10 Mar 2022 09:35:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A26ED300268;
        Thu, 10 Mar 2022 10:35:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F120264E62B7; Thu, 10 Mar 2022 10:35:32 +0100 (CET)
Date:   Thu, 10 Mar 2022 10:35:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 09, 2022 at 11:09:17AM -0800, Alexei Starovoitov wrote:
> Pulled above and it got even worse.
> With kasan and lockdep during qemu boot I see:
> [    1.147498] rcu_scheduler_active = 1, debug_locks = 1
> [    1.147498] 2 locks held by kthreadd/2:
> [    1.147498]  #0: ffff888100362b80 (&p->pi_lock){....}-{2:2}, at: task_rq_lock+0x71/0x380
> [    1.147498]  #1: ffff8881f6a3a218 (&rq->__lock){-...}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x40
> [    1.147498]
> [    1.147498] stack backtrace:
> [    1.147498] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc7-02289-gc958c6aae879 #1
> [    1.147498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [    1.147498] Call Trace:
> [    1.147498]  <TASK>
> [    1.147498]  dump_stack_lvl+0x48/0x5b
> [    1.147498]  cpuacct_charge+0x2b3/0x390
> [    1.147498]  update_curr+0x33e/0x7d0
> [    1.147498]  dequeue_entity+0x28/0xdf0
> [    1.147498]  ? rcu_read_lock_bh_held+0xa0/0xa0
> [    1.147498]  dequeue_task_fair+0x1fa/0xd60
> [    1.147498]  __do_set_cpus_allowed+0x253/0x620
> [    1.147498]  __set_cpus_allowed_ptr_locked+0x25f/0x450
> [    1.147498]  __set_cpus_allowed_ptr+0x7c/0xa0
> [    1.147498]  ? __set_cpus_allowed_ptr_locked+0x450/0x450
> [    1.147498]  ? _raw_spin_unlock_irqrestore+0x34/0x60
> [    1.147498]  ? lockdep_hardirqs_on+0x7d/0x100
> [    1.147498]  kthreadd+0x48/0x610
> [    1.147498]  ? _raw_spin_unlock_irq+0x28/0x50
> [    1.147498]  ? kthread_is_per_cpu+0xc0/0xc0
> [    1.147498]  ret_from_fork+0x1f/0x30

Yeah, sorry about that, currently arguing with Paul about that one.
Should go away if you disable the RCU lockdep thing. The warning itself
is a false positive and more harmful than anything else due to it
generating a possible printk deadlock.

> Most of the time it hangs during the boot.
> I'm using gcc 8.5 and qemu -smp 8

> With qemu -smp 1 it luckly boots.
> Then I run test_progs and see:
> Summary: 215/1115 PASSED, 4 SKIPPED, 18 FAILED
> All trampoline tests fail.
> Here is one:
> $ test_progs -t fentry
> test_fentry_fexit:PASS:fentry_skel_load 0 nsec
> test_fentry_fexit:PASS:fexit_skel_load 0 nsec
> test_fentry_fexit:PASS:fentry_attach 0 nsec
> test_fentry_fexit:FAIL:fexit_attach unexpected error: -1 (errno 19)
> #54 fentry_fexit:FAIL
> 
> or
> 
> ./test_progs -t xdp_bpf
> test_xdp_bpf2bpf:PASS:test_xdp__open_and_load 0 nsec
> test_xdp_bpf2bpf:PASS:test_xdp_bpf2bpf__open 0 nsec
> test_xdp_bpf2bpf:PASS:test_xdp_bpf2bpf__load 0 nsec
> libbpf: prog 'trace_on_entry': failed to attach: Device or resource busy
> libbpf: prog 'trace_on_entry': failed to auto-attach: -16
> test_xdp_bpf2bpf:FAIL:test_xdp_bpf2bpf__attach unexpected error: -16 (errno 16)
> #225 xdp_bpf2bpf:FAIL

Urgh.. I totally missed that in flood of output. Let me go try and
figure out what's happening there.
