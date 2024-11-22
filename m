Return-Path: <bpf+bounces-45440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604B9D5705
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 02:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA3728299A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6123012DD8A;
	Fri, 22 Nov 2024 01:19:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A432309AE
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732238363; cv=none; b=pJxgZJPDWubYE6p5tlzRn0qp/6Ig/POZzLR8WBk84u8pFYBmc/JhMzmA3co7RQQ6D4JPZI2lounHQBLMnvdct7U/YAMPsipsLNV1LLGiOgUR0neQ1/lJed5lg81n6ziejpbWUX5P0yyXSAz/aQnSmVNWfssJaZJuckfDR416l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732238363; c=relaxed/simple;
	bh=3yM4ZOJY7AtwuH4aoEJds8fPwMcb0g/YXV6S0Nta21c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fSjNFgXDdUOMLQ+dC5qCdFtH2XeWSJADshz4cgh/78aHY0z6IVTTdsaS0RwD17T3LcO+mWVSvNBd1UWzB7w+daHdp1Ebfo3m0DEcElRLChkJZBCqyH+5peRfrj52Z4Tt5lp+Id+VY+zsJHnvjcTn7M3aW253bN+Oh8IjzQ+6ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so24594405ab.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 17:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732238360; x=1732843160;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gk9tRWyOe5FSXArH3AfkB6aGo3YEqQ7WCHU90eIMM6U=;
        b=reNZnIIO+T242kRCossHVL/2uYy/LvFaOeFfRuOv1pdSQ+9v0Rrl1KPRHuyK4lpg16
         FaQygJTJD/Cfswp3J1HJCbVKs4YlAbtk04GCL/rKWzWRu5+C8YERLL09c5jNoYG9cXIf
         C0FchXY79fu1ZfeRXBUd96H5Ps2DC17B2T4ElO4UmObqvjrZ6aw1DGFCDYx8BFXz2/IV
         Jgqpq1Zgow9sIvXv9z78Ie9KejWIENb70OEjnJqMpDg2zEcQnvpTe7tbFjlkG7lM9hwk
         XFm+aOT9AhtxdmKxdag90p6kRJhYJ+SYtqCSNiCqDh3Hc+Q30+c6CpEhu1QhlyxQyckJ
         lLxg==
X-Forwarded-Encrypted: i=1; AJvYcCXZYQBzV2S4J9b5X2MnAsjdgZgiTw19iwoOFQIsqpf0iTbZKh9fag51amCmJ8jP1IjFoiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ek6Oh2leerFmAg2QG65M3nQhbJdc3v9AH12vQpzhWtBYpgrs
	QQ+QL4qgVNtqrDMyyVwzmUFlUk2gOSFtQNKHDJ03geDP5sWCOuYKJVNLzaTtBuX/hYdJN607TwN
	nBYe7Cju8XFxyKQuGju3y6nUu49nWvrSfTTrIpQrrnJ23fISwuFYT3A8=
X-Google-Smtp-Source: AGHT+IG56go/ezunuM27WUB2j2aWR5RukLObitwIZ9bsV93qgOmI3IOfE3hqnOzwBNy1jmQp0S2EsqXPRvSbwLAE8+yYPKHRu1p5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2195:b0:3a7:6e6f:d04 with SMTP id
 e9e14a558f8ab-3a79a614c63mr13917315ab.5.1732238360500; Thu, 21 Nov 2024
 17:19:20 -0800 (PST)
Date: Thu, 21 Nov 2024 17:19:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673fdc18.050a0220.363a1b.012c.GAE@google.com>
Subject: [syzbot] [bpf?] INFO: rcu detected stall in security_file_ioctl (9)
From: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b785f4c787 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148914c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f8640465bdf47ca708
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2eb65d2a03c1/disk-f1b785f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70c538f32a8e/vmlinux-f1b785f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79fc36f9a44b/bzImage-f1b785f4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P14575/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=63037, q=305 ncpus=2)
task:syz-executor    state:R  running task     stack:26048 pid:14575 tgid:14575 ppid:5814   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6693
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7015
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:61 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:130 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x4d/0x1a0 mm/kasan/generic.c:189
Code: ff ff ff ff ff 7f ff ff 48 39 f8 0f 83 b3 00 00 00 4c 8d 54 37 ff 48 89 fd 48 b8 00 00 00 00 00 fc ff df 4d 89 d1 48 c1 ed 03 <49> c1 e9 03 48 01 c5 49 01 c1 48 89 e8 49 8d 59 01 48 89 da 48 29
RSP: 0018:ffffc90003ab7698 EFLAGS: 00000a02
RAX: dffffc0000000000 RBX: ffffc90003ab7728 RCX: ffffffff813d6ebe
RDX: 0000000000000001 RSI: 0000000000000060 RDI: ffffc90003ab7728
RBP: 1ffff92000756ee5 R08: 0000000000000001 R09: ffffc90003ab7787
R10: ffffc90003ab7787 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90003ab77e8 R14: ffffc90003ab7728 R15: ffffc90003ab7750
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 __unwind_start+0x2e/0x7f0 arch/x86/kernel/unwind_orc.c:688
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x74/0x100 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 save_stack+0x162/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x8d/0x400 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1112 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2642
 __put_partials+0x14c/0x170 mm/slub.c:3145
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x199/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x19d/0x720 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x245/0x590 security/tomoyo/file.c:723
 security_file_ioctl+0x9b/0x240 security/security.c:2910
 __do_sys_ioctl fs/ioctl.c:901 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0xbb/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f496817e31b
RSP: 002b:00007fff5d2dd2a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f496817e31b
RDX: 0000000000040000 RSI: ffffffff80086301 RDI: 00000000000000d8
RBP: 00007f4968336018 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10538 jiffies! g63037 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25616 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6693
 __schedule_loop kernel/sched/core.c:6770 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6785
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2247
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.12.0-rc7-syzkaller-00042-gf1b785f4c787 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x70/0xf0 arch/x86/kernel/unwind_orc.c:102
Code: ec 72 4e 4c 89 e2 48 29 ea 48 89 d6 48 c1 ea 3f 48 c1 fe 02 48 01 f2 48 d1 fa 48 8d 5c 95 00 48 89 da 48 c1 ea 03 0f b6 34 0a <48> 89 da 83 e2 07 83 c2 03 40 38 f2 7c 05 40 84 f6 75 4b 48 63 13
RSP: 0018:ffffc900001e6958 EFLAGS: 00000a02
RAX: ffffffff918e78be RBX: ffffffff90d866c8 RCX: dffffc0000000000
RDX: 1ffffffff21b0cd9 RSI: 0000000000000000 RDI: ffffffff90d866c4
RBP: ffffffff90d866c4 R08: ffffffff918e78f4 R09: ffffffff918e7b74
R10: ffffc900001e6a08 R11: 000000000008f938 R12: ffffffff90d866d0
R13: ffffffff89f9389f R14: ffffffff90d866c4 R15: ffffffff90d866c4
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557ffcb06ca3 CR3: 000000007a814000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000097 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x2be/0x20c0 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x95/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x152/0x4b0 mm/slub.c:4681
 kfree_skbmem+0x1a4/0x1f0 net/core/skbuff.c:1148
 __kfree_skb net/core/skbuff.c:1205 [inline]
 sk_skb_reason_drop+0x136/0x1a0 net/core/skbuff.c:1242
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 kfree_skb include/linux/skbuff.h:1271 [inline]
 ip6_mc_input+0x7af/0xfd0 net/ipv6/ip6_input.c:587
 dst_input include/net/dst.h:460 [inline]
 dst_input include/net/dst.h:458 [inline]
 ip6_rcv_finish+0x3a2/0x5b0 net/ipv6/ip6_input.c:79
 ip_sabotage_in+0x21b/0x290 net/bridge/br_netfilter_hooks.c:1018
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xbb/0x200 net/netfilter/core.c:626
 nf_hook.constprop.0+0x42e/0x750 include/linux/netfilter.h:269
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ipv6_rcv+0xa4/0x680 net/ipv6/ip6_input.c:309
 __netif_receive_skb_one_core+0x12e/0x1e0 net/core/dev.c:5670
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5783
 netif_receive_skb_internal net/core/dev.c:5869 [inline]
 netif_receive_skb+0x13f/0x7b0 net/core/dev.c:5928
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 br_pass_frame_up+0x346/0x490 net/bridge/br_input.c:70
 br_handle_frame_finish+0xdcf/0x1c80 net/bridge/br_input.c:221
 br_nf_hook_thresh+0x303/0x410 net/bridge/br_netfilter_hooks.c:1195
 br_nf_pre_routing_finish_ipv6+0x76a/0xfb0 net/bridge/br_netfilter_ipv6.c:154
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x3ce/0x8c0 net/bridge/br_netfilter_ipv6.c:184
 br_nf_pre_routing+0x860/0x15b0 net/bridge/br_netfilter_hooks.c:533
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
 br_handle_frame+0x9eb/0x1490 net/bridge/br_input.c:424
 __netif_receive_skb_core.constprop.0+0xa3d/0x4330 net/core/dev.c:5564
 __netif_receive_skb_one_core+0xb1/0x1e0 net/core/dev.c:5668
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5783
 process_backlog+0x443/0x15f0 net/core/dev.c:6115
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6779
 napi_poll net/core/dev.c:6848 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6970
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:927 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:919
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
net_ratelimit: 34076 callbacks suppressed
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)


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

