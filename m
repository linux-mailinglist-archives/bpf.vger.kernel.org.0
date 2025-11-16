Return-Path: <bpf+bounces-74672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A3C61460
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 13:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E037D3628F1
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FF283FEA;
	Sun, 16 Nov 2025 12:03:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5E1DBB3A
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294609; cv=none; b=TLBFUihtvouWe7McOpV22jOMYiKDA17Q/Sjl2yFOyQEg7EdJx2E1LzTVzt/TiGZpKsArlQ9XESazAM/tK2Yv+TNERYYB7OxFbvqla0rszJ6E8LoPvbBxevn6vJiNq3wqKItwrKX3CKDrj+3gXVn78qHqUahSajWRbfiJXrvEFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294609; c=relaxed/simple;
	bh=iU4fsQ6VXXIHVpCE7SngPaKYTBvhx61IcdoZtbiB49Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EEUp2whPhKcSnADhRCx+3SgE8n9dTMu7xw2obZihsKInnexD/9sCtOn9sXCDaXQiXoKGGf2sntYT0H95eceeyFr6Jnvxqsz1HoTMbrBZ9bM8ZL7uLo13RRbWj1XiQc5YvUWJmmX2TBlBOX7G0xp6txW/YlH/5AS6cwwFI9bWM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9489a3f6e3dso766623739f.0
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 04:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763294607; x=1763899407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xxlYloHdXaJPlC5I1JghqAqnx4gwZzh/w0P3NgrzLo=;
        b=R7+G6xkbIXX9azdfwlVihNlnygJJmSXa6b2YYZRI8qvN+jf0ILH860UoZumEAUTJIN
         s/t5HMUtK4OwNxL0XtRCgt2aA7lIFj0oJkYSzXrH1dDBk83sr5PeuWmWREPdQ5JUfKm1
         WQ4jRM9nHTvJ0h4ENT45pk5LECTwsqPsqJzD/gej/YAWLFr6xG2xaoq2VpMIro1PwLaE
         Gwb2kcwILqX/iCePxZ0NNpHidW5fKj6CI4WC41ZsLRau6mygTc6TSSRXCIB4je1HLJKo
         MUA5Uf0vjIbUOuwtWngeYBvkqdNpeWkN6/HUDgtx3CPNKW7VlRZHrp/sBDEiWxZaLdCR
         DIqA==
X-Forwarded-Encrypted: i=1; AJvYcCXbbEwGUquLIRFiuGNp2dH8uyCWdPAJQdpPO7m0ULJZG/GHG+CKQ9YQ86KfVfkp6tW1RyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx919Rt/dvqmjjYg6BeZOjJbdbT9JkSLt4I2ZURm8dATrzInReT
	MBbawuD/HOL5Em07NiGdY6j5tpg/reZtSLc8Gw7dzrggV4wY8IGKWwLJUSptMGLLBWYMpMhFb8l
	piuMshgBjdIUxW8Dql/sRNa+6eO7/5PR8NwwhxsAro7wUxm/ASO217Uv+0VY=
X-Google-Smtp-Source: AGHT+IGNMGx8OKBT12rjDmZ3AJAHp6nFJx0sXbrMN46ekGRzNV1mRfte+JKDBeVsa21ZNqFliC9GhwPUmsHQPLJ3MCUpQwbKim6Q
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:433:68f0:bdbe with SMTP id
 e9e14a558f8ab-4348c93d4dbmr143149585ab.31.1763294607028; Sun, 16 Nov 2025
 04:03:27 -0800 (PST)
Date: Sun, 16 Nov 2025 04:03:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6919bd8f.a70a0220.3124cb.007d.GAE@google.com>
Subject: [syzbot] [bpf?] memory leak in map_create
From: syzbot <syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24172e0d7990 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17818692580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=cf08c551fecea9fd1320
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a64658580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac3c12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ded911fa4408/disk-24172e0d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1f3e61cb784/vmlinux-24172e0d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b92fd0e25cb7/bzImage-24172e0d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com

2025/11/12 11:58:15 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888125a64000 (size 1024):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 7b9fb9b4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __do_kmalloc_node mm/slub.c:5649 [inline]
    __kmalloc_node_noprof+0x3b4/0x6c0 mm/slub.c:5656
    kmalloc_node_noprof include/linux/slab.h:987 [inline]
    __bpf_map_area_alloc+0x17a/0x1a0 kernel/bpf/syscall.c:395
    htab_map_alloc+0x67/0x950 kernel/bpf/hashtab.c:489
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object (percpu) 0x607e4d6674b0 (size 8):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 8 bytes on cpu 0):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    pcpu_alloc_noprof+0x83a/0xd80 mm/percpu.c:1890
    bpf_map_alloc_percpu+0x7b/0x190 kernel/bpf/syscall.c:575
    bpf_map_init_elem_count include/linux/bpf.h:2532 [inline]
    htab_map_alloc+0x165/0x950 kernel/bpf/hashtab.c:527
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888125a64400 (size 1024):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 2cb93737):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __do_kmalloc_node mm/slub.c:5649 [inline]
    __kmalloc_node_noprof+0x3b4/0x6c0 mm/slub.c:5656
    kmalloc_node_noprof include/linux/slab.h:987 [inline]
    __bpf_map_area_alloc+0x17a/0x1a0 kernel/bpf/syscall.c:395
    htab_map_alloc+0x18c/0x950 kernel/bpf/hashtab.c:532
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object (percpu) 0x607e4d6674b8 (size 208):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 32 bytes on cpu 0):
    e0 f7 2c 27 81 88 ff ff 00 00 00 00 00 00 00 00  ..,'............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ee549e23):
    pcpu_alloc_noprof+0x83a/0xd80 mm/percpu.c:1890
    bpf_mem_alloc_init+0x2fe/0x540 kernel/bpf/memalloc.c:525
    htab_map_alloc+0x6ce/0x950 kernel/bpf/hashtab.c:579
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881272cf4e0 (size 96):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __do_kmalloc_node mm/slub.c:5649 [inline]
    __kmalloc_node_noprof+0x3b4/0x6c0 mm/slub.c:5656
    kmalloc_node_noprof include/linux/slab.h:987 [inline]
    __alloc+0x92/0xd0 kernel/bpf/memalloc.c:155
    alloc_bulk+0x242/0x3a0 kernel/bpf/memalloc.c:246
    prefill_mem_cache kernel/bpf/memalloc.c:499 [inline]
    bpf_mem_alloc_init+0x471/0x540 kernel/bpf/memalloc.c:546
    htab_map_alloc+0x6ce/0x950 kernel/bpf/hashtab.c:579
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881272cf720 (size 96):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 32 bytes):
    e0 f4 2c 27 81 88 ff ff 00 00 00 00 00 00 00 00  ..,'............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6bfb1ae8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __do_kmalloc_node mm/slub.c:5649 [inline]
    __kmalloc_node_noprof+0x3b4/0x6c0 mm/slub.c:5656
    kmalloc_node_noprof include/linux/slab.h:987 [inline]
    __alloc+0x92/0xd0 kernel/bpf/memalloc.c:155
    alloc_bulk+0x242/0x3a0 kernel/bpf/memalloc.c:246
    prefill_mem_cache kernel/bpf/memalloc.c:499 [inline]
    bpf_mem_alloc_init+0x471/0x540 kernel/bpf/memalloc.c:546
    htab_map_alloc+0x6ce/0x950 kernel/bpf/hashtab.c:579
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881272cf660 (size 96):
  comm "syz.0.17", pid 6096, jiffies 4294942817
  hex dump (first 32 bytes):
    20 f7 2c 27 81 88 ff ff 00 00 00 00 00 00 00 00   .,'............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ebf498a1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __do_kmalloc_node mm/slub.c:5649 [inline]
    __kmalloc_node_noprof+0x3b4/0x6c0 mm/slub.c:5656
    kmalloc_node_noprof include/linux/slab.h:987 [inline]
    __alloc+0x92/0xd0 kernel/bpf/memalloc.c:155
    alloc_bulk+0x242/0x3a0 kernel/bpf/memalloc.c:246
    prefill_mem_cache kernel/bpf/memalloc.c:499 [inline]
    bpf_mem_alloc_init+0x471/0x540 kernel/bpf/memalloc.c:546
    htab_map_alloc+0x6ce/0x950 kernel/bpf/hashtab.c:579
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
    __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
    __x64_sys_bpf+0x22/0x30 kernel/bpf/syscall.c:6257
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

