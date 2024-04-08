Return-Path: <bpf+bounces-26185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC789C6E3
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9910328181A
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0943128394;
	Mon,  8 Apr 2024 14:20:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B5127B4E
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586042; cv=none; b=IM2Un6UVjnBrVqG9OhStar6M6ImRqm89c+i0q8yugYZGeuCxdeJYZepZXFbJLvSEsRYO0Th9eOJNPCIEcYo3SiNgQ0nLSIaNb3835x6T7z+yHgibuZmA1uT6txpkcaM3uBnVbX4XDXa7UZcPLXce1Hs4q71J4KcjC3R5aJ7gPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586042; c=relaxed/simple;
	bh=wHjZHYR3/8O8GuYPcxt1x8c3tVmjG7kKcy2Y0MmiRpM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RkPCOGnl6Pyd8g1KCnieRvmlZRozIL4VE8B/PJxNJnq90L2i9Df0XTIs7aZroh/1Sy+36wx57ohdG2imm7Agb1YDaeZz3S16wS/W6sDREIXrOtBwp/kC/af9bsi/OAtgrnzECZGPm5+EHLlvfIk4skf3gINj6t4CewEmN4pQ64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5e9c1232dso84796139f.0
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 07:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586039; x=1713190839;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DV+zzZ18HjL9UnlRbefaSkDDW4UVKzv6pk2khBr+yYU=;
        b=NogVdhyZUHcmE+3HijFQE3qqki6B7EI0W85EN7qCNbpMpK21Oiebcq6GF3Ob2Hw1G4
         igRCsO9jNGd5pb93rnuNPcrKY/rSM18rR1V6kc3Z/Yg0GfZ6Mz3xV2OUi9492uFIeyWj
         MSGR7EdNlxZwiRlIwxu023MYqPKXQdLr0qT/gYyghYaEF/FEquuutmu12LC4KaibTAsr
         v5dRwZOmWDYv18rNbGBRY84uQUFDr3e7g2EC8gLsmPVTm7+SZRvfiWbd52ZfMR9lFi7k
         cOdEGzn4eXqiARvGzu85EmEh4sLF8maOtdIvQpd28Xq/+prAWKxqdHcHqdg3qewH8nn3
         M7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWkMPF6J1qgdKgJb+OJJ8anDFRDdecZdXV7anf8dgenpYbf8xijtGzVObV0V4dDRUv8B7VvEV2uUCkm44Z4EOz+X8iZ
X-Gm-Message-State: AOJu0Yy7v2DlVS5iUa+wfN76yPuIqUhFuyPNxtrl5DeQVyNaT/mUjqeh
	nliUnkfZg9HIwy5VW4YuuNVoKDcAwHcBaxEi1Y6dQjTqZtpswnh94AfE0dPmxksHnUZfHQwL/Z+
	QFdHoaLYCbLgcOEF5VmtrnQVLznwXagdEncpm1U7WjFnADYYtHLyqMy8=
X-Google-Smtp-Source: AGHT+IFbKIY7V9lOGfkD/JpFzkz+BG36cIzrXfIu/CghYNaazAHp1lFkj5tSKXU0nPp9stNR9fEPUnH+6et5vurVHyQLxbCwyFHO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2713:b0:482:9be9:6fa3 with SMTP id
 m19-20020a056638271300b004829be96fa3mr50652jav.6.1712586039654; Mon, 08 Apr
 2024 07:20:39 -0700 (PDT)
Date: Mon, 08 Apr 2024 07:20:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a882a061596826d@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sock_map_unref
From: syzbot <syzbot+850ca6a3ba35c8699832@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1363aaa9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=850ca6a3ba35c8699832
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+850ca6a3ba35c8699832@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
------------------------------------------------------
syz-executor.4/21902 is trying to acquire lock:
ffff88804ec83bf0 (clock-AF_UNIX){++..}-{2:2}, at: sock_map_del_link net/core/sock_map.c:163 [inline]
ffff88804ec83bf0 (clock-AF_UNIX){++..}-{2:2}, at: sock_map_unref+0x442/0x5e0 net/core/sock_map.c:180

but task is already holding lock:
ffff888066451200 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888066451200 (&stab->lock){+.-.}-{2:2}, at: sock_map_update_common+0x1b6/0x5b0 net/core/sock_map.c:490

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&stab->lock){+.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       __sock_map_delete net/core/sock_map.c:414 [inline]
       sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
       0xffffffffa00048e6
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x291/0x380 mm/slub.c:4396
       __bpf_prog_put_noref+0xd7/0x310 kernel/bpf/syscall.c:2244
       bpf_prog_put_deferred+0x2f3/0x3e0 kernel/bpf/syscall.c:2270
       __bpf_prog_put kernel/bpf/syscall.c:2282 [inline]
       bpf_prog_put+0x264/0x2a0 kernel/bpf/syscall.c:2289
       psock_set_prog include/linux/skmsg.h:475 [inline]
       sk_psock_stop_strp net/core/skmsg.c:1156 [inline]
       sk_psock_drop+0xe0/0x500 net/core/skmsg.c:841
       sk_psock_put include/linux/skmsg.h:459 [inline]
       sock_map_close+0x209/0x2d0 net/core/sock_map.c:1648
       unix_release+0x85/0xc0 net/unix/af_unix.c:1048
       __sock_release net/socket.c:659 [inline]
       sock_close+0xbc/0x240 net/socket.c:1421
       __fput+0x429/0x8a0 fs/file_table.c:423
       __do_sys_close fs/open.c:1557 [inline]
       __se_sys_close fs/open.c:1542 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1542
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (clock-AF_UNIX){++..}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
       _raw_write_lock_bh+0x35/0x50 kernel/locking/spinlock.c:334
       sock_map_del_link net/core/sock_map.c:163 [inline]
       sock_map_unref+0x442/0x5e0 net/core/sock_map.c:180
       sock_map_update_common+0x4f0/0x5b0 net/core/sock_map.c:503
       sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:579
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&stab->lock);
                               lock(clock-AF_UNIX);
                               lock(&stab->lock);
  lock(clock-AF_UNIX);

 *** DEADLOCK ***

3 locks held by syz-executor.4/21902:
 #0: ffff88804ec85a58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
 #0: ffff88804ec85a58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_sk_acquire net/core/sock_map.c:117 [inline]
 #0: ffff88804ec85a58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x1cc/0x910 net/core/sock_map.c:575
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: sock_map_sk_acquire net/core/sock_map.c:118 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: sock_map_update_elem_sys+0x1d8/0x910 net/core/sock_map.c:575
 #2: ffff888066451200 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff888066451200 (&stab->lock){+.-.}-{2:2}, at: sock_map_update_common+0x1b6/0x5b0 net/core/sock_map.c:490

stack backtrace:
CPU: 1 PID: 21902 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
 _raw_write_lock_bh+0x35/0x50 kernel/locking/spinlock.c:334
 sock_map_del_link net/core/sock_map.c:163 [inline]
 sock_map_unref+0x442/0x5e0 net/core/sock_map.c:180
 sock_map_update_common+0x4f0/0x5b0 net/core/sock_map.c:503
 sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:579
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f9934c7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9935a7c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f9934dac120 RCX: 00007f9934c7de69
RDX: 0000000000000020 RSI: 0000000020000880 RDI: 0000000000000002
RBP: 00007f9934cca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f9934dac120 R15: 00007fffdd7d6668
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

