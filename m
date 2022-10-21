Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA66606CFC
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJUBWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJUBWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:22:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B90224AB2;
        Thu, 20 Oct 2022 18:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51C76B8238D;
        Fri, 21 Oct 2022 01:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8094BC433C1;
        Fri, 21 Oct 2022 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666315316;
        bh=LHAlyK7C766gQD7MA+ITm7BwYNTeQxCUrvZJ03FXrGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OloGXklgmOhfnv9PhmeJB2JNScKKANPGoKdAxxzXrMtV1ueoaQ37yfkxIW51UNwvr
         HHae9g1vV+KlgVR8Z7Dlgndf3WCdKCUT6PNU4OTeqMPSuiZyi3fuLz/cZbiaH0KRq3
         IYM7ltxb8bfKwBOv/XzZksWhRYFNKS9KSDdQX1+0=
Date:   Thu, 20 Oct 2022 18:21:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com>
Cc:     bigeasy@linutronix.de, bpf@vger.kernel.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 vm_area_dup
Message-Id: <20221020182155.ecd44ee984b1aeb2e5a2e8ed@linux-foundation.org>
In-Reply-To: <00000000000031aec805eb76a2d4@google.com>
References: <0000000000009fa63105eb7648d8@google.com>
        <00000000000031aec805eb76a2d4@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 20 Oct 2022 05:40:43 -0700 syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:

Thanks.


> HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=170a8016880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
> dashboard link: https://syzkaller.appspot.com/bug?extid=b910411d3d253dab25d8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e0372880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1770d752880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274

This is happening under dup_anon_vma_name().

I can't spot preemption being disabled on that call path, and I assume
this code has been exercised for some time.

I wonder if this could be fallout from the KSM locking error which
https://lkml.kernel.org/r/8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com
addresses.  Seems quite unlikely.

> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3602, name: syz-executor107
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 3602 Comm: syz-executor107 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
>  might_alloc include/linux/sched/mm.h:274 [inline]
>  slab_pre_alloc_hook mm/slab.h:727 [inline]
>  slab_alloc_node mm/slub.c:3323 [inline]
>  slab_alloc mm/slub.c:3411 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3418 [inline]
>  kmem_cache_alloc+0x2e6/0x3c0 mm/slub.c:3427
>  vm_area_dup+0x81/0x380 kernel/fork.c:466
>  copy_vma+0x376/0x8d0 mm/mmap.c:3216
>  move_vma+0x449/0xf60 mm/mremap.c:626
>  __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd090fa5b29
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc2e90bd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd090fa5b29
> RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
> RBP: 00007fd090f69cd0 R08: 00000000202ef000 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 00007fd090f69d60
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
