Return-Path: <bpf+bounces-36388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC539479F2
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C2B1C20EB8
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A71547F3;
	Mon,  5 Aug 2024 10:36:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E86152E02
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854187; cv=none; b=LCrurJkKRWNmt+XjGobLVHOIquHbiZVu93aDn3bhoVnVQOmBH7ifBb9+lT8mzEUB2spiqBzkhjf344jG9mco6oXkUqtdV78K426SMO9M0iWn/RdyksuUnbvOvTmF7w7+Be7SEkdhyo8KQBWhi6bJmlA4cEMJgam8Eb2FE+IXCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854187; c=relaxed/simple;
	bh=09xIWUUbCIfPCgwFvCyNajtJTFh115YN9IntR+f31Ps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aNTiLqFEdL2SArsGZ2P5SdBZXr+j0bsuObgs7YM22NA7+zHLQUuohgoGCG+1n3XpeJbr9QZ5/3UonXif/Q+2yIN4NJQMp3wRMkigOkZtxV1TBawqqbRdL+zh96td1FHhc4ugq5oR4Vco8L/IWe8TKQj0vKoQ0nj0G9dGhJiY2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f81da0972so1539757639f.1
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 03:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722854185; x=1723458985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHsAQDnbHN39bib66hk3EdMrTvNQUrabc32Jkwldir0=;
        b=i3YZGGaPZp02Lg+MwZdb3xbTXp5qb5s7L4mR7k92DC/978fSoxScJyCg7mV3AfcAdd
         0zVpEk5T6YDJTc5gGxhl4GDpMypj7fz/qBbXS/RYga6r44fqjdVYizBlVbP7G91qHP0U
         Zq6pVfSUbfk9Jd3CYhplckoEqAF59azDBgpWUuAEM7O4IrtXbXPsLh/KTQQg4XPbCjxy
         yr5cDuH59b6DhSIiu+mG+QGjDVShruQWOx7Zk5y2r4oyad9EW7MSR2EgewnYKF/XwCQr
         ldZ41zYGCtR8HHp9FqUzWptpq61WKWPCEVjxQUZAnYtnDPcg3hw+Q4GTpddahIvvPiew
         GPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfg2o29CK2FWGrjUV8lq6TaOHz7k2ntl+bCIPU4AQyAlRGWYV9ygnHWnkiRUU/XrJbhKZMlGlUFtZgmjvdG0LhFVve
X-Gm-Message-State: AOJu0YyVg+yhOQGZoETvgsZtsgbp+VWHJejAb+25WyyjGdiaox/sZ5WL
	cjzfgFfRLDpN+JqzbkyP9yMryO2EZvyH0Vn27HPiVcIvBKF0nsHVyPpP5LUkzNHuUcFVJseImmK
	57A6FYtFzMkvMm6aZE7+P5RyHlgHdMahqoWfu8PwZbuWSj/C+yQmWz0Q=
X-Google-Smtp-Source: AGHT+IG6G7otkSxeg7x+HWPj9fBF+IVbbcVkNK147qwDFYeiCLxik3hEUwkFUoULCK5957NsxRdNfstqyWvOtGJ+wO0oCtzaSoQx
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:396:2d57:b1cb with SMTP id
 e9e14a558f8ab-39b1f78607dmr8504345ab.0.1722854185095; Mon, 05 Aug 2024
 03:36:25 -0700 (PDT)
Date: Mon, 05 Aug 2024 03:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3e63e061eed3f6b@google.com>
Subject: [syzbot] [bpf?] BUG: spinlock recursion in bpf_lru_push_free
From: syzbot <syzbot+d6fb861ed047a275747a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d650ab5e7d9 selftests/bpf: Fix a btf_dump selftest failure
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4c1a1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=d6fb861ed047a275747a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/630e210de8d9/disk-3d650ab5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3576ca35748a/vmlinux-3d650ab5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b33f099abfa/bzImage-3d650ab5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6fb861ed047a275747a@syzkaller.appspotmail.com

BUG: spinlock recursion on CPU#1, syz.4.1173/11483
 lock: 0xffff888046908300, .magic: dead4ead, .owner: syz.4.1173/11483, .owner_cpu: 1
CPU: 1 UID: 0 PID: 11483 Comm: syz.4.1173 Not tainted 6.10.0-syzkaller-12666-g3d650ab5e7d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 debug_spin_lock_before kernel/locking/spinlock_debug.c:87 [inline]
 do_raw_spin_lock+0x227/0x370 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 bpf_lru_list_push_free kernel/bpf/bpf_lru_list.c:318 [inline]
 bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:538 [inline]
 bpf_lru_push_free+0x1a7/0xb60 kernel/bpf/bpf_lru_list.c:561
 htab_lru_map_delete_elem+0x613/0x700 kernel/bpf/hashtab.c:1475
 bpf_prog_6f5f05285f674219+0x43/0x4c
 bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
 trace_contention_begin+0x117/0x140 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x114/0xdc0 kernel/locking/qspinlock.c:402
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:143
 graph_lock kernel/locking/lockdep.c:169 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3803 [inline]
 validate_chain+0x21d/0x5900 kernel/locking/lockdep.c:3836
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
 htab_lru_map_delete_node+0x161/0x840 kernel/bpf/hashtab.c:817
 __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:225 [inline]
 __bpf_lru_list_shrink+0x156/0x9d0 kernel/bpf/bpf_lru_list.c:271
 bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:345 [inline]
 bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:452 [inline]
 bpf_lru_pop_free+0xd84/0x1a70 kernel/bpf/bpf_lru_list.c:504
 prealloc_lru_pop kernel/bpf/hashtab.c:308 [inline]
 __htab_lru_percpu_map_update_elem+0x242/0x9b0 kernel/bpf/hashtab.c:1355
 bpf_percpu_hash_update+0x11a/0x200 kernel/bpf/hashtab.c:2421
 bpf_map_update_value+0x347/0x540 kernel/bpf/syscall.c:181
 generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1889
 bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5218
 __sys_bpf+0x377/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed319779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed327ee048 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fed31b05f80 RCX: 00007fed319779f9
RDX: 0000000000000038 RSI: 0000000020000580 RDI: 000000000000001a
RBP: 00007fed319e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fed31b05f80 R15: 00007ffcf9a1d7f8
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

