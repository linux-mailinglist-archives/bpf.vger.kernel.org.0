Return-Path: <bpf+bounces-77316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E7CD70B0
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E40D0301412C
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AEA33C52D;
	Mon, 22 Dec 2025 20:11:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327E2C029D
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434281; cv=none; b=mhoDjTvoACI8rel2CCHtHwko+z3XkO4QhE6wh2alv+dmn07O80kn73GCtAULiyY2azbLtHkw8R7BwW8oHz6d4h+tLQ3re1Ty8+WOJAhtSzIY6DueXNrskHxlK245AlBd6JC4Ylg9ynZAJe2TUqcdPda8mqA3wBmBbIu6XMC0Oq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434281; c=relaxed/simple;
	bh=vHzLS/9zpsc5xlZbl/PiLRhzA4Wbck2bZOPAXwnurBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q1iW5hJWcccGzc6Q7cVsdQphCcDkPZg8/t54GD01L1rAsPrt5OFdZZix9OEEbRBQyPaVFlj2biKcSUn5aS84C8SQDqpeLT8urbxvJWYilFr9Z8EoVkZD3lRxDaFmF+ci1/7tJ7+jAcv18t9LNpGW23Q0m1lBwq4M2udanIHjktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-3ec31d72794so5447778fac.0
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 12:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766434279; x=1767039079;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+j1PlSoz4EejoOYf4kPWYdli/9ahG7Es5vlO2BYAao=;
        b=CBqx4DKFlyXqdhslv0lF/YMB7VyPVid1j8J+1lEz50bc28acGWIvV3OIBrJZChHdYY
         yzlcGy+PIsOOgHgXs5pNDwsd1ysSKhu7DvIZWuNOim48cjgKAaIa5dHc3azEPIBTSZLm
         4+QCLKCLWar3LAZjgb2IDt4ERpmlInQC0tce5zE9VC5gupxpBYIVootZkYeBSokGkUoP
         18MMVEaPlyfR2zZSq5/UgZQxlfwIXEkZGm8MjaHPg5SV0xK6yaXYjjX+4hpRIBpvmcUK
         RG6A8NNGreVps8ySx4LY3FcKGMenaYJHrO8PstBKpN5tXsugrrivAguwiTeCkk08qmKV
         twQg==
X-Forwarded-Encrypted: i=1; AJvYcCWAJlY4Nu2x0spIOGlN87B3DwIvQMcKFIaiXlMakv1GXAUfRH+V3H8+M/6PuC/r42EGbUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1HxuNAKNeEGRdFbBqlHvxCJF7XzcraBz2Ky8easRkj24w94M
	lQCf11yv0E7glzk+q41C9lUcdXJcEIxOe/3t/SO61aFc54h29IwxDRl6rKihB01QpA4yTRMYRAR
	ZgeEuIIP+yWqKjcY2LBaD9qETH6RxMM6Qrbx3XUOYZbBUien6PS/kdh2uYU0=
X-Google-Smtp-Source: AGHT+IFHro4iAiAWe8c5b2en98rChoZk6C5ciSy2BVS2NtRIXeaameMIwqdINsbkjaOlSWgVyeAPakL024Gw3AjyaXQ3WYukXgvf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4289:b0:659:9a49:8e21 with SMTP id
 006d021491bc7-65cfe748da1mr4818438eaf.19.1766434279036; Mon, 22 Dec 2025
 12:11:19 -0800 (PST)
Date: Mon, 22 Dec 2025 12:11:19 -0800
In-Reply-To: <694995bf.050a0220.2fb209.01a1.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6949a5e7.050a0220.19928e.0011.GAE@google.com>
Subject: Re: [syzbot] [bpf?] inconsistent lock state in bpf_lru_push_free
From: syzbot <syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    22cc16c04b78 riscv, bpf: Fix incorrect usage of BPF_TRAMP_..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=106c3db4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=c69a0a2c816716f1e0d5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b4808a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c3db4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43a53493cb5f/disk-22cc16c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9726fb9e1980/vmlinux-22cc16c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efd2bc050ab6/bzImage-22cc16c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
syzkaller #0 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
syz.0.140/6455 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffffe8ffffd582d8 (&l->lock#2){....}-{2:2}, at: bpf_lru_push_free+0x13e/0x520 kernel/bpf/bpf_lru_list.c:-1
{INITIAL USE} state was registered at:
  lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
  bpf_percpu_lru_pop_free kernel/bpf/bpf_lru_list.c:407 [inline]
  bpf_lru_pop_free+0xcb/0x19b0 kernel/bpf/bpf_lru_list.c:494
  prealloc_lru_pop kernel/bpf/hashtab.c:299 [inline]
  htab_lru_map_update_elem+0x168/0x8a0 kernel/bpf/hashtab.c:1215
  bpf_map_update_value+0x751/0x920 kernel/bpf/syscall.c:294
  generic_map_update_batch+0x5a9/0x810 kernel/bpf/syscall.c:2038
  bpf_map_do_batch+0x39b/0x630 kernel/bpf/syscall.c:5647
  __sys_bpf+0x690/0x860 kernel/bpf/syscall.c:-1
  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 19630
hardirqs last  enabled at (19629): [<ffffffff8b5b313e>] syscall_enter_from_user_mode include/linux/entry-common.h:108 [inline]
hardirqs last  enabled at (19629): [<ffffffff8b5b313e>] do_syscall_64+0xbe/0xf80 arch/x86/entry/syscall_64.c:90
hardirqs last disabled at (19630): [<ffffffff8b5b7058>] exc_debug_kernel+0x68/0x150 arch/x86/kernel/traps.c:1233
softirqs last  enabled at (18324): [<ffffffff81858cca>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (18324): [<ffffffff81858cca>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (18324): [<ffffffff81858cca>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
softirqs last disabled at (18267): [<ffffffff81858cca>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (18267): [<ffffffff81858cca>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (18267): [<ffffffff81858cca>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&l->lock#2);
  <Interrupt>
    lock(&l->lock#2);

 *** DEADLOCK ***

no locks held by syz.0.140/6455.

stack backtrace:
CPU: 1 UID: 0 PID: 6455 Comm: syz.0.140 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <#DB>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_usage_bug+0x28b/0x2e0 kernel/locking/lockdep.c:4042
 lock_acquire+0x1f8/0x340 kernel/locking/lockdep.c:5859
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 bpf_lru_push_free+0x13e/0x520 kernel/bpf/bpf_lru_list.c:-1
 htab_lru_push_free kernel/bpf/hashtab.c:1183 [inline]
 htab_lru_map_delete_elem+0x3a3/0x410 kernel/bpf/hashtab.c:1464
 bpf_prog_464bc2be3fc7c272+0x43/0x4b
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 bpf_overflow_handler kernel/events/core.c:10303 [inline]
 __perf_event_overflow+0x39c/0xe70 kernel/events/core.c:10402
 perf_swevent_overflow kernel/events/core.c:10536 [inline]
 perf_swevent_event+0x4f8/0x5e0 kernel/events/core.c:10574
 perf_bp_event+0x251/0x300 kernel/events/core.c:11395
 hw_breakpoint_handler arch/x86/kernel/hw_breakpoint.c:556 [inline]
 hw_breakpoint_exceptions_notify+0x244/0x680 arch/x86/kernel/hw_breakpoint.c:587
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 notify_die+0x130/0x180 kernel/notifier.c:588
 notify_debug+0x2e/0x50 arch/x86/kernel/traps.c:1208
 exc_debug_kernel+0xbe/0x150 arch/x86/kernel/traps.c:1270
 asm_exc_debug+0x1e/0x40 arch/x86/include/asm/idtentry.h:654
RIP: 0010:rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:74
Code: 48 04 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 e9 8f 48 04 00 48 8b 06 48 89 07 48 8d 47 08 48 83 e0 f8 48
RSP: 0018:ffffc9000b9ffcf8 EFLAGS: 00050202
RAX: 00007ffffffff001 RBX: 0000000000000050 RCX: 000000000000000f
RDX: 0000000000000001 RSI: 0000200000000301 RDI: ffffc9000b9ffda1
RBP: ffffc9000b9ffea8 R08: ffffc9000b9ffdaf R09: 1ffff9200173ffb5
R10: dffffc0000000000 R11: fffff5200173ffb6 R12: 1ffff9200173ffa8
R13: 0000000000000050 R14: ffffc9000b9ffd60 R15: 00002000000002c0
 </#DB>
 <TASK>
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:185 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:223 [inline]
 copy_from_bpfptr_offset include/linux/bpfptr.h:53 [inline]
 copy_from_bpfptr include/linux/bpfptr.h:59 [inline]
 __sys_bpf+0x1e3/0x860 kernel/bpf/syscall.c:6137
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdde098f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdde190d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fdde0be5fa0 RCX: 00007fdde098f749
RDX: 0000000000000050 RSI: 00002000000002c0 RDI: 000000000000000a
RBP: 00007fdde0a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdde0be6038 R14: 00007fdde0be5fa0 R15: 00007ffde82e83d8
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 04 00             	rex.W add $0x0,%al
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00
   d:	0f 1f 00             	nopl   (%rax)
  10:	48 8b 06             	mov    (%rsi),%rax
  13:	48 89 07             	mov    %rax,(%rdi)
  16:	48 83 c6 08          	add    $0x8,%rsi
  1a:	48 83 c7 08          	add    $0x8,%rdi
  1e:	83 e9 08             	sub    $0x8,%ecx
  21:	74 db                	je     0xfffffffe
  23:	83 f9 08             	cmp    $0x8,%ecx
  26:	73 e8                	jae    0x10
  28:	eb c5                	jmp    0xffffffef
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	e9 8f 48 04 00       	jmp    0x448c0
  31:	48 8b 06             	mov    (%rsi),%rax
  34:	48 89 07             	mov    %rax,(%rdi)
  37:	48 8d 47 08          	lea    0x8(%rdi),%rax
  3b:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

