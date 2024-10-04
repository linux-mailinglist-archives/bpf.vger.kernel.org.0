Return-Path: <bpf+bounces-40933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DC990230
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 13:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28861F22367
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292015A86A;
	Fri,  4 Oct 2024 11:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31615821A
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042026; cv=none; b=Zx2wipMO4Oz5t0o7Hz8QNrJerYX6kIBXdSI8G0vB5E+W5FsLpv/UiR16xrILqf850RumQXWCdBLRVFFwhoyXCprsKKqBjEfVLulRbNvlJwohIrKb14h2u+GNOpu2pqhpGImL2Jju2Noi25gXV2O2GzUALKVK0VpjhsgGAh5nT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042026; c=relaxed/simple;
	bh=lStMSKeFZnRbEIqJpj9x5Y6AdrxkvIhM9oeN1BkdSoI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nqqYHAMlV7gmKWVGw/8Wue7AOssI9DqK+oE6GV4cfMoxFMG8z0FuvlhCZj1OkE2dgDX0wOedkDSVhWjCJnfm0q7rgTmFf2VtIgRGmmeyilOK+JUQJQxU5rFGk6RnzSFnzwGpKnbBCCB7h02yiLj8UYdmpeGcXRMpRoxizgWd8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a343c444afso22779255ab.1
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 04:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042024; x=1728646824;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RH7XhbMlUbLbawgAsaJ/+d3DvzsgIfhNKAXRoNm7PyQ=;
        b=niBvjnkH8aU+/0IUcVQZoNlW1s0SmGvN7EoLrNotVl83gG7EfF2z2cOs5nKJFMvIL0
         aDB+phFNVVfZLL26rG2XsejgcrnNiqElE3+vjfX4e0M67WcZjkcwpgO4zSMVTs1EzFFu
         m2A7x0KbBaC5hm037OtTs0NRerXNalDJgkrLS4UlhCJ6EDFQQGDgx0J24FopUbvlOxXP
         sBR/Anu4wNASZhPTHv1xVINZAarwUo9QQbcffap8GtcJFKkQR1Dwl+ox4OxcMcwikIsO
         QspYzJcVOfcfMA3Ds8fwY73sdFnUZcKID9rX1TNJsCB7XdJ6mVUoDGihw5+JliTAcUI9
         N3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXcndOKCjTIFf43gr6PPLMRtVnDGXRVTvmO5UetQRgP05i1r619X9MpneSPd3d9Le0f1C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPLy7Hoz67SoXnAJiDC3wml5jAufuHdhzxWY1zL5m72sWdmXk
	TKO9hSpK5k2aBMvD7ajHMjfvs96w/rw4uRXDwzKIHBf+sQTNOiz5jSSnl0jN2+4sbg403UUUt3B
	EqgvryY7bTc+XzoLzmjakZW6KSusA5T41L6rs8G6pgouJFH5hegQXhqA=
X-Google-Smtp-Source: AGHT+IEXFY+p3aUX9Vdx4VsnV85b0tMFwKajA+xSKAUnK0VdlM7DhrzqLKFlD3rJ2s2PCsXgBXt1ZW6c0FU9FBagm1mG+ec34J8b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:3a0:aa15:3497 with SMTP id
 e9e14a558f8ab-3a375976e55mr21453585ab.1.1728042024133; Fri, 04 Oct 2024
 04:40:24 -0700 (PDT)
Date: Fri, 04 Oct 2024 04:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ffd428.050a0220.49194.048a.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in __put_partials
From: syzbot <syzbot+5a878c984150fad34185@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99a648c951ba selftests/bpf: Verify that sync_linked_regs p..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1668bd07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3e39725ec0dfcbc
dashboard link: https://syzkaller.appspot.com/bug?extid=5a878c984150fad34185
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e45f24c2d262/disk-99a648c9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48ad218fc65c/vmlinux-99a648c9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/691b40913107/bzImage-99a648c9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a878c984150fad34185@syzkaller.appspotmail.com

tun0: tun_chr_ioctl cmd 1074025681
======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-10550-g99a648c951ba #0 Not tainted
------------------------------------------------------
syz.0.924/9009 is trying to acquire lock:
ffff8881404006d8 (&n->list_lock){-.-.}-{2:2}, at: __put_partials+0x61/0x130 mm/slub.c:3126

but task is already holding lock:
ffff8880758dda00 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xc00 kernel/bpf/lpm_trie.c:333

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
       0xffffffffa00021b3
       bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
       trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0xb7e/0xdb0 kernel/locking/qspinlock.c:557
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
       _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
       __put_partials+0x61/0x130 mm/slub.c:3126
       put_cpu_partial+0x17c/0x250 mm/slub.c:3221
       __slab_free+0x2ea/0x3d0 mm/slub.c:4450
       qlink_free mm/kasan/quarantine.c:163 [inline]
       qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
       kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
       __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
       kasan_slab_alloc include/linux/kasan.h:247 [inline]
       slab_post_alloc_hook mm/slub.c:4086 [inline]
       slab_alloc_node mm/slub.c:4135 [inline]
       kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4187
       perf_event_alloc+0x166/0x2310 kernel/events/core.c:12147
       __do_sys_perf_event_open kernel/events/core.c:12767 [inline]
       __se_sys_perf_event_open+0xb1f/0x3870 kernel/events/core.c:12658
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&n->list_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __put_partials+0x61/0x130 mm/slub.c:3126
       ___slab_alloc+0x4f7/0x14b0 mm/slub.c:3776
       __slab_alloc+0x58/0xa0 mm/slub.c:3909
       __slab_alloc_node mm/slub.c:3962 [inline]
       slab_alloc_node mm/slub.c:4123 [inline]
       __do_kmalloc_node mm/slub.c:4264 [inline]
       __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4271
       kmalloc_array_node_noprof include/linux/slab.h:995 [inline]
       alloc_slab_obj_exts mm/slub.c:1969 [inline]
       account_slab mm/slub.c:2542 [inline]
       allocate_slab+0xb6/0x2f0 mm/slub.c:2597
       new_slab mm/slub.c:2632 [inline]
       ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
       __slab_alloc+0x58/0xa0 mm/slub.c:3909
       __slab_alloc_node mm/slub.c:3962 [inline]
       slab_alloc_node mm/slub.c:4123 [inline]
       __do_kmalloc_node mm/slub.c:4264 [inline]
       __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4271
       kmalloc_node_noprof include/linux/slab.h:905 [inline]
       bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
       generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1849
       bpf_map_do_batch+0x39a/0x660 kernel/bpf/syscall.c:5143
       __sys_bpf+0x377/0x810
       __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&n->list_lock);
                               lock(&trie->lock);
  lock(&n->list_lock);

 *** DEADLOCK ***

2 locks held by syz.0.924/9009:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff8880758dda00 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xc00 kernel/bpf/lpm_trie.c:333

stack backtrace:
CPU: 0 UID: 0 PID: 9009 Comm: syz.0.924 Not tainted 6.11.0-syzkaller-10550-g99a648c951ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __put_partials+0x61/0x130 mm/slub.c:3126
 ___slab_alloc+0x4f7/0x14b0 mm/slub.c:3776
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4271
 kmalloc_array_node_noprof include/linux/slab.h:995 [inline]
 alloc_slab_obj_exts mm/slub.c:1969 [inline]
 account_slab mm/slub.c:2542 [inline]
 allocate_slab+0xb6/0x2f0 mm/slub.c:2597
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4271
 kmalloc_node_noprof include/linux/slab.h:905 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
 trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1849
 bpf_map_do_batch+0x39a/0x660 kernel/bpf/syscall.c:5143
 __sys_bpf+0x377/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea6a97dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea6b756038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fea6ab35f80 RCX: 00007fea6a97dff9
RDX: 0000000000000038 RSI: 0000000020000480 RDI: 000000000000001a
RBP: 00007fea6a9f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fea6ab35f80 R15: 00007ffd21039768
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

