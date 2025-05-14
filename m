Return-Path: <bpf+bounces-58187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58772AB6ABC
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 13:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064A47A764D
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27232750F6;
	Wed, 14 May 2025 11:58:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D021770D
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223918; cv=none; b=aG0BA5UUfyutjHDQoqPA2rJK6eR6+pe2he6RNEFoX0cZqjuN79QfvCYTw1yYykq48x4iK+QpZ6LcYUENvA8I0ypvmInRkZ1cgryGS72WQuFIMCYBI+dt0IzyeuSqevtRRYmwbwW6+g5w/8Rh/+yZMF6QxHcyFx0Q8MxXWS9hYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223918; c=relaxed/simple;
	bh=VsIVw4xokloDRCGfjLe0h2WbmfHH9FiXqip0fmR9Lng=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YOxDJTur21oYJV1nueAJBLFudfNTR6kuq6PAqWPgsVc7k2zkekNvQe8itp9QoqycvLM5H69dYZsiC3VkONdAcF3dGHuwHoKynDvzSCcrcKmxeX8ZZmjKsBlkcVZqnGddsdxe01Dao0RqcOB5fdsxPdL1jwa+NojeaA8CxIhecOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3da76423ba1so136064805ab.0
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 04:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747223915; x=1747828715;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xanK211PDjhttY7lq/HHASWhl8OC9jDCyANHlbZueGM=;
        b=e6WJKMlL+97h6du48NMrT5Y9JUP0u+y+m650KY5RDH0d9/A47TX937TQADRQmr0X08
         2Xp/Mx6WXwi7CjkVT9T7V/rBsTnZkuY7ijyT+bYFr/ZMyMwCXoExCyCSB1qxYMISuYl3
         tCJz7+rvurtBvLzPEFa9gD4AllijrDojmVhfr/XI5TJvpcjQ09V9IiFB0Ka9jZ4BWIxj
         GmLGpcJCXd0//VOBn6sdjFmFoYjszgWkWIN/q6U372unT+tAtakG04klKedP9YtCIzyz
         rR8f/BbfFbg6iQfKaTS46ZY/cUth3cG+jE9anpzJx9qDv0GrIYBEgVz6qk/TSghxvR63
         FDGg==
X-Forwarded-Encrypted: i=1; AJvYcCXt92jkegK87LjN8Z0kDfnT4afvC3tu0sbSs8VaW+/ferwjHAoqwWjcUkQTqRGCXvwrrI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGKzhLrd6Q6w2ONW8bM+805SJ4N9epDSbKgQ6+RfbBhlrSx+K
	uwb9yUTTkX4x+aW/mKPiD2ENtmgWpirhB8UcNMj5w1BszjyYtePtTAOO1vc+lMBXVICH5GP/Pac
	OZuqqhzRHLIS6pYRzG9Sxwu72ACosbJTJ0PRB/KHUdFDeJl/7C+UFa+0=
X-Google-Smtp-Source: AGHT+IEPrc90FBj7HM1zAUyIsfyFsUxNNlVwmdhMdT1v4h8Dqc1PEvr7OAn65L0BvdUk58lmsjPwc9y2b/KNVlPv8oq3l7zt+CGj
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3db6f7f465dmr30634785ab.15.1747223914791; Wed, 14 May 2025
 04:58:34 -0700 (PDT)
Date: Wed, 14 May 2025 04:58:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824856a.a00a0220.104b28.000c.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in free_mem_alloc_no_barrier
From: syzbot <syzbot+ba09f1d8f92da05bd539@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c32f8dc5aaf9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15a66cf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4635ffd6ad5b4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ba09f1d8f92da05bd539
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b921498959d4/disk-c32f8dc5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04e6ad946c4b/vmlinux-c32f8dc5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4f0d8db50ee/Image-c32f8dc5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba09f1d8f92da05bd539@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 113 at kernel/bpf/memalloc.c:649 check_mem_cache kernel/bpf/memalloc.c:649 [inline]
WARNING: CPU: 1 PID: 113 at kernel/bpf/memalloc.c:649 check_leaked_objs kernel/bpf/memalloc.c:667 [inline]
WARNING: CPU: 1 PID: 113 at kernel/bpf/memalloc.c:649 free_mem_alloc_no_barrier+0x204/0x514 kernel/bpf/memalloc.c:683
Modules linked in:
CPU: 1 UID: 0 PID: 113 Comm: kworker/u8:4 Not tainted 6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound free_mem_alloc_deferred
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_mem_cache kernel/bpf/memalloc.c:649 [inline]
pc : check_leaked_objs kernel/bpf/memalloc.c:667 [inline]
pc : free_mem_alloc_no_barrier+0x204/0x514 kernel/bpf/memalloc.c:683
lr : check_mem_cache kernel/bpf/memalloc.c:649 [inline]
lr : check_leaked_objs kernel/bpf/memalloc.c:667 [inline]
lr : free_mem_alloc_no_barrier+0x204/0x514 kernel/bpf/memalloc.c:683
sp : ffff80009b427a10
x29: ffff80009b427a20 x28: ffffffffffffffff x27: 0000000000000000
x26: ffff80008ec24258 x25: ffff80008ec24258 x24: dfff800000000000
x23: fffffdffbf6e0ce8 x22: fffffdffbf6e0c40 x21: 1ffff00011d8484b
x20: ffff0000f0b02f08 x19: ffff0000f0b02f00 x18: 1fffe00033871676
x17: ffff80010d12e000 x16: ffff80008adb421c x15: 0000000000000001
x14: 1ffff00013684f24 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013684f25 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c55d1e80 x7 : ffff80008adc3498 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008adc37ac
x2 : 0000000000000001 x1 : 0000000000000003 x0 : 0000000000000000
Call trace:
 check_mem_cache kernel/bpf/memalloc.c:649 [inline] (P)
 check_leaked_objs kernel/bpf/memalloc.c:667 [inline] (P)
 free_mem_alloc_no_barrier+0x204/0x514 kernel/bpf/memalloc.c:683 (P)
 free_mem_alloc kernel/bpf/memalloc.c:706 [inline]
 free_mem_alloc_deferred+0x2c/0x1a4 kernel/bpf/memalloc.c:713
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
irq event stamp: 254062
hardirqs last  enabled at (254061): [<ffff80008add4c80>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (254061): [<ffff80008add4c80>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:202
hardirqs last disabled at (254062): [<ffff80008adaf5e0>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
softirqs last  enabled at (253980): [<ffff800086383a80>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (253980): [<ffff800086383a80>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
softirqs last  enabled at (253980): [<ffff800086383a80>] nsim_dev_trap_report_work+0x67c/0x9fc drivers/net/netdevsim/dev.c:851
softirqs last disabled at (253978): [<ffff8000863839f8>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (253978): [<ffff8000863839f8>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:816 [inline]
softirqs last disabled at (253978): [<ffff8000863839f8>] nsim_dev_trap_report_work+0x5f4/0x9fc drivers/net/netdevsim/dev.c:851
---[ end trace 0000000000000000 ]---


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

