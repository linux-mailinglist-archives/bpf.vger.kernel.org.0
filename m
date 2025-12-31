Return-Path: <bpf+bounces-77550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3106CEAF5E
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3CBA3016EC8
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6446B19A288;
	Wed, 31 Dec 2025 00:27:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D578F3E
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140846; cv=none; b=uvPHXTNN5IKSw+NDn7jdBIGtLsTdMSJgR6waQ94OfUz2HMXv2C3F0j0hN7w1jzx3g2YNWzyQ1v4Dd3bV4tDhu6vrfcGTyMlQtinIT4Ca1hUUeZqCBpsoNI7I4X5wVmey9z4boUB1btPZIfif6s0UPhxryMQnVyj3h8dm63cgiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140846; c=relaxed/simple;
	bh=RViHGzJ1kbiNtabXdZxq8szQ5nYHkHU5xdLw/FEUX4w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JFyjkPVyHOEtdQsec8pnGwMiq1D6ClLfLPWuKmREq+ybyijCFAmrzCPYirNPbNdXcZ+LrAFZHa5G2oyAJRNWiHMw1DfggDrC8qj76JNj43I/J+z6cCqRCBh2H8Jfej2ih1e7wDMDPl7S7a57G2YWOzDW/hE7hXPVVd6V9xFnGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7caf66b2866so24850143a34.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 16:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767140842; x=1767745642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4ypBja/CZzAxwX9MeRgqWZyZAuQqnyq1l8AYSzoSdE=;
        b=IBu7tnUQwiV+nnQJJXbFnHUY6KcutuEfkmHUFfGBXBNn+bVQoRoYq953eHqOB1xEgQ
         vqSPSJ0diRQ8xfd47GO9Ewk5nY3wqndbdZhwNU0Ay8jAHYSLFb4C7lDGDcVtts0sc8Q7
         +YG7Aa6WQT53sEjDmXATQQrMC1SsPMtp1UD8glyvffOicMemZtAA0l3RnekdnCdV4Lct
         fEDmpHgAn5WLX9l28vrz7ebtQuoN35QTrJ4NkfL2Z7jxTP7nD/lx9EtM77Y+/ysB6Jvc
         4vyRVCcDpZNutBy0ypxlXhFW963iE0bQHbfMDvIPrJHy+Y/gdWOuKwdfM08IYWEXhaOu
         LXEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+PiR+83sLh0qZoZK0hOe0g6bItVstX5sOpBzmuTmK3XwSFKbgeBBm5bnpNUdqrP3jPxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYD/n/ZviyRY/VZSwIgxM7QOFSDWzrFZZBweEdA2XKZcdlC4Y+
	rQGRJIK5lXfhlyWiy1s6cXLLj1OhZ1NorQ0a6FpF73CNF4aH0so2rQRFPmAFqzDb7YGyOmx0bJ7
	isv6NbCN4/1pefnCrsyFjHfAmV320iiD306sto86hdpsVGrGz5GrRbFJMNmc=
X-Google-Smtp-Source: AGHT+IHuPPRg0C0XXcGkQfgSIry1aWa4Dev17rkfCArzBQnbnUYQkSHkaF3laHyWdV0rbU7vYYecowERF8zb+sAKxt5KIAJSbzGm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:602:b0:65c:f3ac:2206 with SMTP id
 006d021491bc7-65d0ebf2924mr16547588eaf.73.1767140842698; Tue, 30 Dec 2025
 16:27:22 -0800 (PST)
Date: Tue, 30 Dec 2025 16:27:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69546dea.050a0220.a1b6.0306.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
From: syzbot <syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f0e9c8cefa9 Merge tag 'block-6.19-20251226' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11765022580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=4fe468a3f7fac86ea2c9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1071089a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11dd1bb4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3f0e9c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/275bd6cb3fb6/vmlinux-3f0e9c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5311a1a21c3/bzImage-3f0e9c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rcu_gp process_srcu
RIP: 0010:____bpf_get_local_storage kernel/bpf/cgroup.c:1774 [inline]
RIP: 0010:bpf_get_local_storage+0xbd/0x180 kernel/bpf/cgroup.c:1756
Code: e0 49 83 c6 08 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 a2 83 39 00 4d 8b 36 83 fb 15 75 5c 4c 89 f0 48 c1 e8 03 <42> 80 3c 38 00 74 08 4c 89 f7 e8 84 83 39 00 49 8b 1e e8 ec 7e 6c
RSP: 0018:ffffc900000072d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000015 RCX: 0000000000000100
RDX: ffff88801bef4980 RSI: 0000000000000015 RDI: 0000000000000015
RBP: ffffc90000007310 R08: 0000000000000003 R09: 0000000000000000
R10: ffffc90000007380 R11: ffffffffa0203ce4 R12: 0000000000000001
R13: ffff88801248d640 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001c40 CR3: 000000003701b000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 bpf_prog_e63b106389d7305a+0x2e/0x45
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 __bpf_prog_run_save_cb+0x127/0x370 include/linux/filter.h:980
 bpf_prog_run_array_cg kernel/bpf/cgroup.c:81 [inline]
 __cgroup_bpf_run_filter_skb+0x9e0/0xf40 kernel/bpf/cgroup.c:1612
 sk_filter_trim_cap+0xd42/0xf50 net/core/filter.c:150
 tcp_filter net/ipv4/tcp_ipv4.c:2117 [inline]
 tcp_v4_rcv+0x1f90/0x2f20 net/ipv4/tcp_ipv4.c:2304
 ip_protocol_deliver_rcu+0x221/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
 __netif_receive_skb+0x143/0x380 net/core/dev.c:6250
 process_backlog+0x54f/0x1340 net/core/dev.c:6602
 __napi_poll+0xae/0x320 net/core/dev.c:7666
 napi_poll net/core/dev.c:7729 [inline]
 net_rx_action+0x64a/0xe00 net/core/dev.c:7881
 handle_softirqs+0x22b/0x7c0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x60/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:delay_loop+0x20/0x30 arch/x86/lib/delay.c:44
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 f8 48 85 c0 74 19 eb 02 66 90 eb 0e 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 <48> ff c8 75 fb 48 ff c8 c3 cc cc cc cc cc 66 90 90 90 90 90 90 90
RSP: 0018:ffffc900001b78d0 EFLAGS: 00000216
RAX: 00000000000022ff RBX: 0000000000000001 RCX: 0000000008583a9c
RDX: 00000000000036b0 RSI: 0000000000000008 RDI: 00000000000036b1
RBP: 0000000000000001 R08: ffff88801fc42b47 R09: 1ffff11003f88568
R10: dffffc0000000000 R11: ffffffff8b5a31d0 R12: 0000000000000001
R13: 0000000000004fb8 R14: ffff88801fc42b60 R15: dffffc0000000000
 udelay include/asm-generic/delay.h:64 [inline]
 try_check_zero+0x412/0x470 kernel/rcu/srcutree.c:1182
 srcu_advance_state kernel/rcu/srcutree.c:1886 [inline]
 process_srcu+0x2d3/0x1220 kernel/rcu/srcutree.c:1995
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:____bpf_get_local_storage kernel/bpf/cgroup.c:1774 [inline]
RIP: 0010:bpf_get_local_storage+0xbd/0x180 kernel/bpf/cgroup.c:1756
Code: e0 49 83 c6 08 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 a2 83 39 00 4d 8b 36 83 fb 15 75 5c 4c 89 f0 48 c1 e8 03 <42> 80 3c 38 00 74 08 4c 89 f7 e8 84 83 39 00 49 8b 1e e8 ec 7e 6c
RSP: 0018:ffffc900000072d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000015 RCX: 0000000000000100
RDX: ffff88801bef4980 RSI: 0000000000000015 RDI: 0000000000000015
RBP: ffffc90000007310 R08: 0000000000000003 R09: 0000000000000000
R10: ffffc90000007380 R11: ffffffffa0203ce4 R12: 0000000000000001
R13: ffff88801248d640 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001c40 CR3: 000000003701b000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	e0 49                	loopne 0x4b
   2:	83 c6 08             	add    $0x8,%esi
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 a2 83 39 00       	call   0x3983bd
  1b:	4d 8b 36             	mov    (%r14),%r14
  1e:	83 fb 15             	cmp    $0x15,%ebx
  21:	75 5c                	jne    0x7f
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 84 83 39 00       	call   0x3983bd
  39:	49 8b 1e             	mov    (%r14),%rbx
  3c:	e8                   	.byte 0xe8
  3d:	ec                   	in     (%dx),%al
  3e:	7e 6c                	jle    0xac


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

