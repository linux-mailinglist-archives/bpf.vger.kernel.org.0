Return-Path: <bpf+bounces-56482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7747A981A9
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E880D17F728
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F172749DB;
	Wed, 23 Apr 2025 07:51:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183626E162
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394692; cv=none; b=hUu9Wajr/1F0ENZTCwfMJ2Wu3JBpxF79tyPhlfNaAY7ImOW7x48cJiEacQtaYnieQ3bdp6hBlOcJiocVNeHIDc5Jc5TE9+PseehSx1gw6Diqf3hxalVKgywut4Eeh/dmzcUdwYpntyFhiDxa+SAwxHlVi0O6F2Aj9uGWh0eQoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394692; c=relaxed/simple;
	bh=J8Fs71luRr8KhUe1LAp6yjGQa0X1Nc0rtcBKDrtCVtY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FMG00qc5hsly2X8/O3WabWZKSFJAJ9lHkWGxndeKFxR1pcguwXw/dZMA1MAWKI9gYc/mZGkd4Jh1013N4VgHyhADDji9czADdH7OK4GKl1tvv3qgPy5Uc+f/NjY2PpHGZT95UWkDwyp/KnCXD1Cor/Ul1kb2aJV22jrQKvOtIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d922570570so17439715ab.3
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 00:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394690; x=1745999490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eHhupB9Pify40e1x6TOcLKy8t+HWMiNUu9yz3MjVIk=;
        b=uwoCCjRaZhjhny2A/UmoLOpVHm7A0Jep74QVxvB34tA9a+hQ+RhEoQUEYIW6NMF1d8
         hNieYqemPs5+AcHTUioXhdnWKqOvk83bGh1vg4m6JTM7j7ZAbKJlvGRIC+tbGr5a0yB6
         Hr97GNmFTB1xZnE5UuqCORPrADLdIvGebjEmhoHDn9fKxyVnLMPEgZB6PajPK8o057VR
         a5BvtUGzRGKqMQJR469gMg/batTPjjLMqjH91+CYpJqK45j9WQGC8A78UXs7Lk/2mceV
         /hLy5q3nT453qrfw6sBqj0EOU59f1jKZ9HUEYXnHMmardfCm1/2Mx+3qv0dA2WhS7NVB
         M9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLj6c0pQmoolj2ZQ28hV4ZR1mxP/TLqUJukWpBm9cC65NuSzAC4a26jcuvmL8LLWQE3aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOqVfUYfyIO0C3o6Qf4C6ZOA8NGnvneED/OeJ15JCSY1pKUtR
	wvxKdYcu6r7W1mQkfZyCT9zbCUGVeF3s9GvoibuktD2ZpvnRU5uqiLE5Pcy9ma9+L2VY6DXFZJ1
	HvhB0sRKIg+mtfx3N14u3pYH6uU07hMAhFR9eZebuw17QkpxpedswaVU=
X-Google-Smtp-Source: AGHT+IFHLRbVAEneCANcOZV/aA7LcvE8Y0aQLqO81V6JRZjO8/Wdgy3sDFUMJe3lEaQ+m4z7KIfrcL74Gv6V2ScEnOJp4H5Og25P
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:3d3:eeec:89f3 with SMTP id
 e9e14a558f8ab-3d88edc338cmr169082615ab.13.1745394689843; Wed, 23 Apr 2025
 00:51:29 -0700 (PDT)
Date: Wed, 23 Apr 2025 00:51:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68089c01.050a0220.36a438.0010.GAE@google.com>
Subject: [syzbot] [bpf?] BUG: soft lockup in hsr_announce (3)
From: syzbot <syzbot+6c68a0400c33951a023c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8582d9ab3efd libbpf: Verify section type in btf_find_elf_s..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c7a4cc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b209dc5439043d2
dashboard link: https://syzkaller.appspot.com/bug?extid=6c68a0400c33951a023c
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee77ac023e33/disk-8582d9ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebe52a30453e/vmlinux-8582d9ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6868f9db2e2e/bzImage-8582d9ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c68a0400c33951a023c@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 120s! [syz.8.880:9468]
Modules linked in:
irq event stamp: 12256237
hardirqs last  enabled at (12256236): [<ffffffff8c2ee163>] irqentry_exit+0x63/0x90 kernel/entry/common.c:357
hardirqs last disabled at (12256237): [<ffffffff8c2ebcae>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (12053392): [<ffffffff8183e77b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (12053392): [<ffffffff8183e77b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (12053392): [<ffffffff8183e77b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
softirqs last disabled at (12053395): [<ffffffff8183e77b>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (12053395): [<ffffffff8183e77b>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (12053395): [<ffffffff8183e77b>] __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
CPU: 0 UID: 0 PID: 9468 Comm: syz.8.880 Not tainted 6.14.0-syzkaller-g8582d9ab3efd #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:lock_acquire+0x167/0x2f0 arch/x86/include/asm/irqflags.h:-1
Code: c7 44 24 10 00 00 00 00 9c 8f 44 24 10 f7 44 24 10 00 02 00 00 0f 85 fd 00 00 00 41 f7 c6 00 02 00 00 74 01 fb 65 48 8b 45 00 <48> 3b 44 24 38 0f 85 72 01 00 00 48 83 c4 40 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90000007328 EFLAGS: 00000206
RAX: 03fdb0660b923e00 RBX: ffffffff8ed3df60 RCX: 03fdb0660b923e00
RDX: 0000000000000000 RSI: ffffffff8e4d9324 RDI: ffffffff8ca1af60
RBP: ffffffff93681020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000246 R15: 0000000000000000
FS:  00007f7c5e4dd6c0(0000) GS:ffff888124f9f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000d000 CR3: 000000006a3f0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 is_bpf_text_address+0x46/0x2a0 kernel/bpf/core.c:772
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xff/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2389 [inline]
 slab_free mm/slub.c:4646 [inline]
 kmem_cache_free+0x197/0x410 mm/slub.c:4748
 hsr_forward_skb+0x1e71/0x2d20 net/hsr/hsr_forward.c:-1
 send_hsr_supervision_frame+0x63f/0xd30 net/hsr/hsr_device.c:358
 hsr_announce+0x1fa/0x3a0 net/hsr/hsr_device.c:415
 call_timer_fn+0x189/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66e/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:__schedule+0x4/0x5240 kernel/sched/core.c:6646
Code: b2 39 fd f5 e9 02 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <55> 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec 00 02
RSP: 0018:ffffc90003fbdd98 EFLAGS: 00000282
RAX: 03fdb0660b923e00 RBX: 1ffff920007f7bbc RCX: 0000000000000007
RDX: 0000000000000007 RSI: ffffffff8e64727b RDI: 0000000000000001
RBP: ffffc90003fbde60 R08: ffffffff905fce77 R09: 1ffffffff20bf9ce
R10: dffffc0000000000 R11: fffffbfff20bf9cf R12: dffffc0000000000
R13: 1ffff920007f7bb4 R14: 1ffff920007f7bb8 R15: ffffc90003fbddc0
 preempt_schedule_irq+0xfe/0x1c0 kernel/sched/core.c:7090
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_stack_walk+0x104/0x150 arch/x86/kernel/stacktrace.c:27
Code: ff ff 4c 89 e6 4c 89 fa e8 b9 eb 09 00 83 bd 70 ff ff ff 00 74 37 48 8d 9d 70 ff ff ff 48 89 df e8 51 c1 09 00 48 85 c0 74 23 <4c> 89 f7 48 89 c6 4d 89 eb 41 ff d3 66 90 84 c0 74 11 48 89 df e8
RSP: 0018:ffffc90003fbdf20 EFLAGS: 00000282
RAX: ffffffff81ae614a RBX: ffffc90003fbdf20 RCX: ffffffff91bf7000
RDX: ffffffff91db3501 RSI: ffffffff8e4d9324 RDI: ffffffff81ae614a
RBP: ffffc90003fbdfb0 R08: ffffffff81f5842b R09: 0000000000000000
R10: ffffc90003fbd9c8 R11: fffff520007f7b3b R12: ffff8880312b8000
R13: ffffffff81ae6210 R14: ffffc90003fbe000 R15: 0000000000000000
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfc/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x93/0x530 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1717
 prep_new_page mm/page_alloc.c:1725 [inline]
 get_page_from_freelist+0x352b/0x36c0 mm/page_alloc.c:3652
 __alloc_frozen_pages_noprof+0x211/0x5b0 mm/page_alloc.c:4934
 alloc_pages_mpol+0x339/0x690 mm/mempolicy.c:2301
 folio_alloc_mpol_noprof mm/mempolicy.c:2320 [inline]
 vma_alloc_folio_noprof+0x12d/0x260 mm/mempolicy.c:2355
 folio_prealloc+0x2e/0x170 mm/memory.c:-1
 alloc_anon_folio mm/memory.c:4943 [inline]
 do_anonymous_page mm/memory.c:5000 [inline]
 do_pte_missing mm/memory.c:4158 [inline]
 handle_pte_fault+0x2e45/0x61c0 mm/memory.c:5997
 __handle_mm_fault mm/memory.c:6140 [inline]
 handle_mm_fault+0x1129/0x1bf0 mm/memory.c:6309
 do_user_addr_fault arch/x86/mm/fault.c:1388 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x2bb/0x920 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:74
Code: cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 c3 cc cc cc cc 48 89 c8 48 c1 e9 03 83 e0 07 f3 48 a5 89 c1
RSP: 0018:ffffc90003fbef70 EFLAGS: 00050206
RAX: ffffffff8503d701 RBX: 000020000000d04b RCX: 000000000000004b
RDX: 0000000000000000 RSI: ffff8880619e86bb RDI: 000020000000d000
RBP: 0000000000000062 R08: ffff8880619e8705 R09: 1ffff1100c33d0e0
R10: dffffc0000000000 R11: ffffed100c33d0e1 R12: 0000000000000062
R13: 00007ffffffff000 R14: ffff8880619e86a4 R15: 000020000000cfe9
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
 _inline_copy_to_user include/linux/uaccess.h:197 [inline]
 _copy_to_user+0x8b/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:225 [inline]
 bpf_verifier_vlog+0x4c6/0x900 kernel/bpf/log.c:127
 verbose+0x112/0x190 kernel/bpf/verifier.c:367
 print_verification_stats kernel/bpf/verifier.c:22891 [inline]
 bpf_check+0x1700c/0x1d1c0 kernel/bpf/verifier.c:24087
 bpf_prog_load+0x17ee/0x2250 kernel/bpf/syscall.c:2971
 __sys_bpf+0x5dd/0x8b0 kernel/bpf/syscall.c:5834
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7c5d58e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7c5e4dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f7c5d7b5fa0 RCX: 00007f7c5d58e169
RDX: 0000000000000048 RSI: 000020000000e000 RDI: 0000000000000005
RBP: 00007f7c5d610a68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7c5d7b5fa0 R15: 00007ffe6461b138
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1301 Comm: aoe_tx0 Not tainted 6.14.0-syzkaller-g8582d9ab3efd #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:check_wait_context kernel/locking/lockdep.c:-1 [inline]
RIP: 0010:__lock_acquire+0x4c5/0xd80 kernel/locking/lockdep.c:5185
Code: 41 80 c6 03 4c 89 64 24 38 45 3b bd e8 0a 00 00 0f 8d ed 00 00 00 49 63 df 48 8d 04 9b 4c 8d 24 c5 10 0b 00 00 4d 01 ec eb 20 <44> 89 f0 48 ff c3 49 63 8d e8 0a 00 00 49 83 c4 28 41 ff c7 41 89
RSP: 0018:ffffc9000402ecc0 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff9410af58
RDX: 0000000000000003 RSI: 0000000000000003 RDI: 0000000000080000
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888028016588
R13: ffff888028015a00 R14: 0000000000000003 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88812509f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd507ce8740 CR3: 0000000044770000 CR4: 00000000003526f0
DR0: 0000200000000300 DR1: 0000200000000300 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 lock_acquire+0x116/0x2f0 kernel/locking/lockdep.c:5866
 trace_call_bpf+0xda/0x8a0 kernel/trace/bpf_trace.c:-1
 perf_trace_run_bpf_submit+0x82/0x180 kernel/events/core.c:10807
 do_perf_trace_preemptirq_template include/trace/events/preemptirq.h:14 [inline]
 perf_trace_preemptirq_template+0x2d4/0x400 include/trace/events/preemptirq.h:14
 __do_trace_irq_disable include/trace/events/preemptirq.h:36 [inline]
 trace_irq_disable+0xf5/0x120 include/trace/events/preemptirq.h:36
 console_emit_next_record kernel/printk/printk.c:3131 [inline]
 console_flush_all+0x760/0xec0 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0x151/0x3b0 kernel/printk/printk.c:3325
 vprintk_emit+0x761/0xa40 kernel/printk/printk.c:2450
 dev_vprintk_emit+0x358/0x420 drivers/base/core.c:4891
 dev_printk_emit+0xdf/0x130 drivers/base/core.c:4902
 __netdev_printk+0x3e0/0x4d0 net/core/dev.c:12392
 netdev_warn+0x12d/0x180 net/core/dev.c:12445
 ieee802154_subif_start_xmit+0x134/0x190 net/mac802154/tx.c:232
 __netdev_start_xmit include/linux/netdevice.h:5201 [inline]
 netdev_start_xmit include/linux/netdevice.h:5210 [inline]
 xmit_one net/core/dev.c:3780 [inline]
 dev_hard_start_xmit+0x2d4/0x840 net/core/dev.c:3796
 sch_direct_xmit+0x2b2/0x600 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4022 [inline]
 __dev_queue_xmit+0x1a9c/0x3f60 net/core/dev.c:4599
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 tx+0x6b/0x180 drivers/block/aoe/aoenet.c:62
 kthread+0x23c/0x470 drivers/block/aoe/aoecmd.c:1237
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

