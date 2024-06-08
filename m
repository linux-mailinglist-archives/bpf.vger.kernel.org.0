Return-Path: <bpf+bounces-31656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A8901341
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6532815F1
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2E1CD2D;
	Sat,  8 Jun 2024 18:46:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE21865A
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717872386; cv=none; b=gwbY/HklxoGt1CV1zrB+nC39Wsflov3amYtLrJHlgtFBfnzuzLEb2jIciTWh0o+Vws0c7vGstv7BCw8A+SIuS8hsUjVXgCpnhSCuQTKkKJxnl4QsAT11HdkySPnb+r/+GAsWsZZqO/ZXY6yDkjmIQvSyxn7QgGxibkv83wKLpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717872386; c=relaxed/simple;
	bh=FTsEzVY//d7md9QNRchU+SR97aMGSsZHiNUNXTDniYA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hlDjGbod0i1SBbYOGjK4SMVmWslxDveuMFO1ApuRN+EMf2BFt0prGen/Qz4EAjMyUx3t1ngtJFCadGAx9YdoluS0hEtAA/6Bu9AaiudCjOHK2iplJkGZoUVctdYoVBpirqwJxBzFNwplCOmLwYLAvIetddinRJ7oAyg9MI7G7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso333596339f.1
        for <bpf@vger.kernel.org>; Sat, 08 Jun 2024 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717872384; x=1718477184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3hCt9io7wd14ZV/rqVycTDv82Iixo5e/5LYZfu/3ew=;
        b=Hjf1uz4Rd+akeqk34YqJj3mV0M+e+B2QDL+gZqguxhTD7FEmnxXcU5xFkItPj2qeU7
         wJZIg6GMeAyYgaVZ7tChn7Xp9RAfgLBbVeVLnHO6hS9vmX/9WM6LUlInWuR5NiqGWmPH
         uQdgVcec+yiAqe5nb6u5I5A+OmwW5DradrbbtO8qAoWtnYInbKsByLXI1HB9ULWuN7vs
         nYI58Do0jrQ5E5zj++eVF/St+XjugAuHDCZADgoYU/ZAfaeRXypgV/f/588UVZ3aZklU
         1/jCXWWnojdgOeBOQV6ecws1sb1Z083s9GCAJv3LdXqxLHC0gMtg91TzzVzVUjEVLJdB
         ugMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWVDZ7d9ivxPMpdIBYCg06qbVhEQfeywknP7dT4j3EgM2Dm2Lzo9tsll1gosHtAr1eJzSkx2LrUekz9X7wKyWQ3oC3
X-Gm-Message-State: AOJu0YxhTuxbnYhzpf5/vjrrRfGvPEBt/FZzmDM62UD0KA7b1MpELVGn
	LC6mGrSoef1H1+4G2pJR5qB9gdMe+nNL1MpT1QUay8Hh+VyYGInuktIQ6BOT3Nf7T2HI+pOMpVr
	UTX1/E6AjcKObtcbOF3SuPTUEyxiB6yJUHSynt7+iOAgIgJfdk3jc1oY=
X-Google-Smtp-Source: AGHT+IEVK4W5Nb1TYvUdWpQN+xS2zF4T97HCWd1Niuy5IUFg3CZraESdaOLnJfZCOch9d3QDhnPuUQgsx8a/2k7d8NNKJb1N/0OV
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3790:b0:4b9:942:8f30 with SMTP id
 8926c6da1cb9f-4b90942968amr41609173.3.1717872383737; Sat, 08 Jun 2024
 11:46:23 -0700 (PDT)
Date: Sat, 08 Jun 2024 11:46:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033d195061a6555c8@google.com>
Subject: [syzbot] [bpf?] INFO: task hung in bpf_prog_dev_bound_destroy
From: syzbot <syzbot+638395cff1c05c4a0128@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8a92980606e3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e0f5ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=638395cff1c05c4a0128
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa5a3bdc8575/disk-8a929806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f37ced39a44/vmlinux-8a929806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/604ed8ab462f/bzImage-8a929806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+638395cff1c05c4a0128@syzkaller.appspotmail.com

INFO: task kworker/0:5:5177 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:20752 pid:5177  tgid:5177  ppid:2      flags:0x00004000
Workqueue: events bpf_prog_free_deferred
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 bpf_prog_dev_bound_destroy+0x76/0x590 kernel/bpf/offload.c:386
 bpf_prog_free_deferred+0x3c5/0x710 kernel/bpf/core.c:2784
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.2:12871 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc2-syzkaller-00235-g8a92980606e3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:24912 pid:12871 tgid:12870 ppid:12213  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077


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

