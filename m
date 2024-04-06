Return-Path: <bpf+bounces-26097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABAC89AC5D
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F271C20BFE
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB03FBA2;
	Sat,  6 Apr 2024 16:59:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BA2137E
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422760; cv=none; b=uK7rqz00rJyqoy/8G9XIs5072OUfF5TVdCa8AMrzftkModx3Wmpvr6d60+m5pnRQK7CxTdxRKH6ihdIqVMSTAe0YVPvmL3OHvLMv1rEmmY2wAqaCND8XNFs0ZFRuaEpT1/RYInm3t9UcesBYM3erykO/ieFVNti2OoMw/JAfG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422760; c=relaxed/simple;
	bh=zsEqWQkVk4Cr2D8uh3GOTtBQ7gjJt79SjsrrYvRgtKs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fKjrcHi4R0i6/d37xG2RoD1IAtil9/xUrZDeECdoLAHvYeudgVbdvmNXmK1tUjtA3LQ9SD41NttS5GtsUud2LFeBau5dZ9HEI5TYlEHDI7whj6daKHx7bwPpJ3hynSz0+neRk+AOrnmRkoEKbEv6WEA2UMaDrVStynNXPmfRal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a1e4a5017so248015ab.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 09:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712422757; x=1713027557;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zv9BUdrmcvXndcHhtFT9TLeM3fSy66U/W1eBLLniaVk=;
        b=TDY3iA1i0C5LYUpGs31pdP0MmtaRf441bRO8K0A/vuHfayGCHjkacc9XB2RQ/1gXAF
         k0JuTKQVMPowX7GEGFrnAKr0VD2Y3g2WPnzV8ZLpN+QP1bXqXBw1NqxJDpi6HCuEASsd
         PJosTqWBvAN2kje3cdbN4YmAHi4Y9nROlfz+Mjfl4I+u/RwmP59BV1Jd0osKYqDUhR86
         wiqEHi8i84NRqC1cn/Fn3iEUuMw43d9+IVP2zqMKQd8Xu2eZVYMMRbcRyetWZKYLyDwf
         ihgHzqolwfRtU7DYnDSi3QfbNmRJ0EV1jwotdf0UqkZZIhJat9v4gEmT8VGTdMv8lK95
         wLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmZeqMmQGuaZpsbqsTsObcsr3eu41JtCrdMHyIoN1c4iFWKozydLaYFpm6f9HjHk0NlLCULo3m2li7LLq2W1GrasQt
X-Gm-Message-State: AOJu0YxYNA9vfm3ehUR+iMokMFzcw5zD7wl9J6JjbrFyzvVIz7I4gPag
	MLnfJ9DvXrTjw/SSBCorWHzv4l9mOofypMQ1NGfb3dPoJ2YRj1v0ZKSccfwUcqCdFZlXe/asHXj
	cUNnkj0grAJXxqhc+1mgi/sWBxGqSSPwMFIpYQ8KkQylLU9TpjKexkIE=
X-Google-Smtp-Source: AGHT+IHPpnShZ2xt3dJaVBMnP1fvTrl/XrU/ceyS4wYI0yGevfbK7U8UnIkhkiQEacW9760UTxEsY3iwPLM2fcNJ/pNUr7h5tHrS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4e:b0:366:b246:2f10 with SMTP id
 d14-20020a056e021c4e00b00366b2462f10mr359575ilg.2.1712422757733; Sat, 06 Apr
 2024 09:59:17 -0700 (PDT)
Date: Sat, 06 Apr 2024 09:59:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e2b130615707e3c@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_elem
From: syzbot <syzbot+b8d77b9bb107fa1bd641@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    026e680b0a08 Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=173c55e5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=b8d77b9bb107fa1bd641
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1495512d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143c2415180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b5659d2008c/disk-026e680b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fd1552fafde/vmlinux-026e680b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ba622b1b0ec4/bzImage-026e680b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8d77b9bb107fa1bd641@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
BUG: KMSAN: uninit-value in htab_lru_percpu_map_lookup_elem+0x39a/0x580 kernel/bpf/hashtab.c:2326
 __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
 htab_lru_percpu_map_lookup_elem+0x39a/0x580 kernel/bpf/hashtab.c:2326
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 kvfree+0x69/0x80 mm/util.c:680
 __bpf_prog_put_rcu+0x37/0xf0 kernel/bpf/syscall.c:2232
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
 __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
 flush_tlb_mm_range+0x294/0x320 arch/x86/mm/tlb.c:1036
 flush_tlb_page arch/x86/include/asm/tlbflush.h:254 [inline]
 ptep_clear_flush+0x166/0x1c0 mm/pgtable-generic.c:101
 wp_page_copy mm/memory.c:3329 [inline]
 do_wp_page+0x419d/0x66e0 mm/memory.c:3660
 handle_pte_fault mm/memory.c:5316 [inline]
 __handle_mm_fault mm/memory.c:5441 [inline]
 handle_mm_fault+0x5b76/0xce00 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1362 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x419/0x730 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623

Local variable stack created at:
 __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 1 PID: 5015 Comm: syz-executor232 Not tainted 6.9.0-rc2-syzkaller-00002-g026e680b0a08 #0
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

