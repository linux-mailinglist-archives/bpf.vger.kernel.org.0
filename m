Return-Path: <bpf+bounces-27002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F68A7459
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 21:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513311F2146B
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFFF137933;
	Tue, 16 Apr 2024 19:07:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AB137766
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294442; cv=none; b=dURz54mftZNNfXSF5mWMZR89XDwtKNnwM32DVX59jRj0wnSuKe8XuIOgiRC1c/bImPRXx7NhxbCAIIniphN/AaS6ttvN6CtjiaP1H3oZuMD/hN051TzV2h/ajHr1qXPpaRrlA/jxCQsvEysaZMmi7QT77b65aJVgfL25Xqw6wqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294442; c=relaxed/simple;
	bh=LLiGBtrSxbvzMH3qbceGm1plgiO+v5WFSSgkT35pVoU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UBYEzo02/i7XNgfFtXYFpobEzVwHAppsP+HPRsHZpFzKOsvTf4eHp05PRs7XgKNCNUZoy1ZtxhjVSaMmAD/+RNYcqBerhDAKptdR7gFCFQAajlKMgMzm49IyUHKVV20z09Z5PXwWohKOJMf5GQDEYCilqVB+YDjmgyzgS9IJ4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d676654767so532702339f.3
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 12:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294440; x=1713899240;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1VcHZ4INMjp0zCuMH+FIZ5CsXArd0hgI2BAMVJG3no=;
        b=SUypc7glvBZAQCRh/jtM1mSHnwec8eEQTluc9PF0fMa9pGLpL3n5Wa5EmZ4/dYe0LC
         AQgRHDsbGV85K/2kogOq/6J4R/RHkIX5xpkHYyT0fUcyj5Mo2Y/6T4V7QJutLGWB6xE9
         C1nD3p1HMDaieI/umEvMoJDBnm9Kh6ZMx3LANX5EE9qi4HXH+4HLfMjKpd17AG461Sgi
         03yaU+Qj4fk9uGLeIqzO5mK5Z6lwjmRgJfNxQsY9rZ20dPFp5Geww5Jq6LZCjU1i6JAn
         xA5efRLztml1Qgb2SRsUQYd7f0GHrUwea00vwQ4DhsZESfCrWPaos8eSnzh2Q0ZOuMsV
         1W0g==
X-Forwarded-Encrypted: i=1; AJvYcCXuLXMHj+pgIDR2uDKuyCJ1Gw5W7G/0xEak2h5yXnaB6hyrWc1wp4ilLZ5mj3JoWzXasRD1TT1shnvD9CDoq7W7vfoc
X-Gm-Message-State: AOJu0YyeCBE1PmtdVEx1KiWvg4K3ZngeOwI7LogJIaMMXDT5hu6aLwD6
	fkh/LRJEDKaPyiLXnZ0O0r6Gf+GlgI3+X/6VIC2wKIPkWiW7V4Yrml5gYGEB6PfdVJwshC9bypy
	uhhiZoOeEAm3P1do3EMY8cKIbysId/i7O1gftSPeXMBtq+/plF8zEuTQ=
X-Google-Smtp-Source: AGHT+IFUKU8/iHzfO7+tKwtsMUVve55/lQeWydzqxxxSnV47Rf3/GqF46hwD3XfW5GJpHncOu1YlKV+LxlXHjj25HwGdyWqLtcPL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1496:b0:47f:1ad4:2c66 with SMTP id
 j22-20020a056638149600b0047f1ad42c66mr839461jak.5.1713294440332; Tue, 16 Apr
 2024 12:07:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 12:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008312ad06163b7225@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1492cb93180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bc506ebba90cbf
dashboard link: https://syzkaller.appspot.com/bug?extid=1971e47e5210c718db3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce7393180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155451eb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9fd81e15f087/disk-7efd0a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e4915d51565/vmlinux-7efd0a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/110eeae33f94/bzImage-7efd0a74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
BUG: KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x630 kernel/bpf/hashtab.c:2343
 __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
 htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x630 kernel/bpf/hashtab.c:2343
 ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:133 [inline]
 bpf_map_lookup_percpu_elem+0x67/0x90 kernel/bpf/helpers.c:130
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 security_task_free+0x115/0x150 security/security.c:3032
 __put_task_struct+0x17f/0x730 kernel/fork.c:976
 put_task_struct include/linux/sched/task.h:138 [inline]
 delayed_put_task_struct+0x8a/0x280 kernel/exit.c:229
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
 rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __msan_metadata_ptr_for_load_8+0x31/0x40 mm/kmsan/instrumentation.c:92
 filter_irq_stacks+0x60/0x1a0 kernel/stacktrace.c:397
 stack_depot_save_flags+0x2c/0x6e0 lib/stackdepot.c:609
 stack_depot_save+0x12/0x20 lib/stackdepot.c:685
 __msan_poison_alloca+0x106/0x1b0 mm/kmsan/instrumentation.c:285
 arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
 arch_local_irq_save arch/x86/include/asm/irqflags.h:103 [inline]
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
 _raw_spin_lock_irqsave+0x35/0xc0 kernel/locking/spinlock.c:162
 remove_wait_queue+0x36/0x270 kernel/sched/wait.c:54
 do_wait+0x34a/0x530 kernel/exit.c:1640
 kernel_wait4+0x2ab/0x480 kernel/exit.c:1790
 __do_sys_wait4 kernel/exit.c:1818 [inline]
 __se_sys_wait4 kernel/exit.c:1814 [inline]
 __x64_sys_wait4+0x14e/0x310 kernel/exit.c:1814
 x64_sys_call+0x6e6/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:62
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 0 PID: 5018 Comm: strace-static-x Not tainted 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

