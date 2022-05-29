Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF85372FB
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 01:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiE2Xpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 19:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiE2Xpt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 19:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112454EDFD
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 16:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 930CD60F9D
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 23:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD7BC385A9;
        Sun, 29 May 2022 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653867946;
        bh=dLACW2KUNWPv5YuGz51F5ceixxxwKq3nW5qBsEH2Kn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dWi51YhomD73EVkelwwEO+JNLWcjECB+gH07VNMX+cn6yTNozzsesP//z9uZZQrfn
         Wtgo40p82W5/usAiwisa8JdZB/+stcCU7BtXIOLdRgnWq6wIRlM8J1cYZ3eT6BxvW+
         vgnpSrBzNsQExDELxOL+BwsFm6UKWBla2GSvUYhJhdV76u6FAWIbnTDSKbcoOaSUZf
         TpKBqH286f/8ta41kz92R9sPA/6kBcsaesV1aD2TVBpVXLKDPb0jYeYLc57aWDu1iT
         1xeHXkkfpLdaNDwT+3FCIBvAX5JWeMaIQhHljpIuntdhI/ntRP9KljDHXVymNwr0GM
         M2B1jL10qfhmQ==
Date:   Mon, 30 May 2022 08:45:42 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: help to debug a kretprobe_dispatcher issue with 5.12
Message-Id: <20220530084542.efcc18255a1cf8733cf2e0b6@kernel.org>
In-Reply-To: <73ec8d7e-07dc-fbc0-8a27-2a5b212b39d3@fb.com>
References: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
        <20220527210940.93c0ee60838ada827c177ada@kernel.org>
        <73ec8d7e-07dc-fbc0-8a27-2a5b212b39d3@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 27 May 2022 09:45:11 -0700
Yonghong Song <yhs@fb.com> wrote:

> 
> 
> On 5/27/22 5:09 AM, Masami Hiramatsu (Google) wrote:
> > On Thu, 26 May 2022 12:48:41 -0700
> > Yonghong Song <yhs@fb.com> wrote:
> > 
> >> Hi, Masami,
> >>
> >> In our production servers, with 5.12, we hit an oops like below:
> >>
> >> Backtrace:
> >> #0  kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1744:2)
> >> #1  __kretprobe_trampoline_handler (kernel/kprobes.c:1960:4)
> >> #2  kretprobe_trampoline_handler (include/linux/kprobes.h:219:8)
> >> #3  trampoline_handler (arch/x86/kernel/kprobes/core.c:846:2)
> >> #4  __kretprobe_trampoline+0x2a/0x4b
> >> #5  0xffffffff810c91e0
> >> Dmesg:
> >> ...
> >> [1435716.133501] BUG: kernel NULL pointer dereference, address:
> >> 00000000000000a0
> >> [1435716.147783] #PF: supervisor read access in kernel mode
> >> [1435716.158411] #PF: error_code(0x0000) - not-present page
> >> [1435716.169039] PGD 6df216067 P4D 6df216067 PUD 6aad80067 PMD 0
> >> [1435716.180714] Oops: 0000 [#1] SMP
> >> [1435716.187343] CPU: 19 PID: 3139400 Comm: tupperware-agen Kdump:
> >> loaded Tainted: G S         O  K   5.12.0-0_fbk5_clang_4818_g9939bf8c1268 #1
> >> [1435716.212570] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive
> >> MP, BIOS YMM16 05/24/2021
> >> [1435716.229803] RIP: 0010:kretprobe_dispatcher+0x16/0x70
> >> [1435716.240089] Code: b5 3d 00 48 8b 83 d8 00 00 00 8b 00 eb d8 31 c0
> >> 5b 41 5e c3 41 57 41 56 53 49 89 f6 48 89 fb 48 8b 47 18 48 8b 00 4c 8d
> >> 78 e8 <48> 8b 88 a0 00 00 00 65 48 ff 01 48 8b 80 c0 00 00 00 8b 00 a8 01
> >> [1435716.278001] RSP: 0018:ffffc90001d77db8 EFLAGS: 00010286
> >> [1435716.288797] RAX: 0000000000000000 RBX: ffff8884b586fa00 RCX:
> >> 0000000000000000
> >> [1435716.303416] RDX: 0000000000000001 RSI: ffffc90001d77e30 RDI:
> >> ffff8884b586fa00
> >> [1435716.318037] RBP: ffff8884b586fa10 R08: 0000000000000078 R09:
> >> ffff888450a944b0
> >> [1435716.332659] R10: 0000000000000013 R11: ffffffff82c56d38 R12:
> >> ffff888765e5ae00
> >> [1435716.347278] R13: ffff8884b586fa10 R14: ffffc90001d77e30 R15:
> >> ffffffffffffffe8
> >> [1435716.361896] FS:  00007f3897afd700(0000) GS:ffff88885fcc0000(0000)
> >> knlGS:0000000000000000
> >> [1435716.378427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [1435716.390264] CR2: 00000000000000a0 CR3: 0000000674c5f003 CR4:
> >> 00000000007706e0
> >> [1435716.404882] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> >> 0000000000000000
> >> [1435716.419502] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> >> 0000000000000400
> >> [1435716.434121] PKRU: 55555554
> >> [1435716.439876] Call Trace:
> >>
> >> Our 5.12 is not exactly the upstream stable 5.12, which contains some
> >> additional backport. But I checked kernel/trace, kernel/events and
> >> arch/x86 directory, we didn't add any major changes except some bpf
> >> changes which I think should not trigger the above oops.
> >>
> >> Further code analysis (through checking asm codes) find the issue
> >> is below:
> >>
> >> static nokprobe_inline struct kretprobe *get_kretprobe(struct
> >> kretprobe_instance *ri)
> >> {
> >>           RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> >>                   "Kretprobe is accessed from instance under preemptive
> >> context");
> >>
> >>           return READ_ONCE(ri->rph->rp);
> >> }
> >>
> >> static int
> >> kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
> >> {
> >>           struct kretprobe *rp = get_kretprobe(ri);
> >>               <=== rp is a NULL pointer here
> >>           struct trace_kprobe *tk = container_of(rp, struct trace_kprobe,
> >> rp);
> >>
> >>           raw_cpu_inc(*tk->nhit);
> >>           ...
> >> }
> >>
> >> It looks like 'rp' is a NULL pointer at the time of failure. And the
> >> only places I found 'rp' could be NULL is in unregister_kretprobes.
> >>
> >> void unregister_kretprobes(struct kretprobe **rps, int num)
> >> {
> >>           int i;
> >>
> >>           if (num <= 0)
> >>                   return;
> >>           mutex_lock(&kprobe_mutex);
> >>           for (i = 0; i < num; i++) {
> >>                   if (__unregister_kprobe_top(&rps[i]->kp) < 0)
> >>                           rps[i]->kp.addr = NULL;
> >>                   rps[i]->rph->rp = NULL;
> >>           }
> >>           mutex_unlock(&kprobe_mutex);
> >>           ...
> >> }
> >>
> >> So I suspect there is a race condition between kretprobe_dispatcher()
> >> (or higher level kretprobe_trampoline_handler()) and
> >> unregister_kretprobes(). I looked at kernel/trace code and had not
> >> found an obvious race yet. I will continue to check.
> >> But at the same time, I would like to seek some expert advice to see
> >> whether you are aware of any potential issues in 5.12 or not and where
> >> are possible places I should focus on to add debug codes for experiments.
> > 
> > Thanks for reporting! Yes, it could happen.
> > 
> > __kretprobe_trampoline_handler() checks that the get_kretprobe(ri) returns
> > not NULL, but since that is not locked, it is possible to be NULL afterwards.
> > I think this has been introduced when we make kretprobe lockless. I think
> > this is not a bug but a specification change (all kretprobe handler must
> > check the return value of get_kretprobe(ri) or get kretprobe from current
> > kprobe.) Anyway, trace_kprobe.c should be updated to solve this issue.
> > 
> > 	CPU0					CPU1
> > 
> > __kretprobe_trampoline_handler()
> > 	rp = get_kretprobe(ri);
> > ...						unregister_kretprobe()
> > 	rp->handler(ri, regs);		rps[i]->rph->rp = NULL;
> > -> kretprobe_dispatcher()
> > 	rp = get_kretprobe(ri)
> 
> In __kretprobe_trampoline_handler, I see:
> 
>                  rp = get_kretprobe(ri);
>                  if (rp && rp->handler) {
>                          struct kprobe *prev = kprobe_running();
> 
>                          __this_cpu_write(current_kprobe, &rp->kp);
>                          ri->ret_addr = correct_ret_addr;
>                          rp->handler(ri, regs);
>                          __this_cpu_write(current_kprobe, prev);
>                  }
> 
> So it is possible get_kretprobe(ri) could be NULL. But it may not
> be NULL at that point, but may become NULL inside kretprobe_dispatcher() 
> due to the above race.

Yes, and get_kretprobe(ri) == NULL in the rp->handler() doesn't mean
the kretprobe is already freed, but it means that the kretprobe is under
unregistration (the rp->kp is disarmed, but not reclaimed).
We can continue to use it while this RCU critial section, but it is
safer to quit earler.

> 
> Thanks for analysis. I am looking forward to the patch to solve
> this problem.

Thank you!

> 
> > 
> > 
> > Thank you,
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
