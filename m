Return-Path: <bpf+bounces-47746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A59FF9CD
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 14:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61AA3A3799
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EE1B0F10;
	Thu,  2 Jan 2025 13:24:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D679D2
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824264; cv=none; b=e8gQYyo8QiJkIrD1uFee2wAEDPzF330GGontw+fLhhUduaUmND+wkbiXFUv90Fsxm5M2ahWkazhdc0F9/v1k3siaF1Y3zCVJn9z5gllA8dZBDXE/mFn9H250H2NL+2m7SnSyawtPitlGI/DENl4drpVQ0X9OpTRVTtbIbXHyE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824264; c=relaxed/simple;
	bh=KM1GqhastzOxcK6eawVb6ydlFlEO2qBvUMiT0yqLULg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UhLSONwit8p8/X/GH/WUSnpYG90S8XvbehleKOyTtfVC9wzirnaP5LpZM+LbilbeH8wvI1AAX/X9YOG5WY23+AFaeRoxyY4XQ0rnBuvNEjlTFfNPc8J3LzcCXtZj1EnkeEyLLiHaQLX4Y2PBvU0R2j0cUYoS2T3zsCKpQopJmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ae31bb8ee3so239060585ab.3
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 05:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735824262; x=1736429062;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AW298bTZy1oLm9DZRrny3aFl2qhKHH8shzWS+L/tVqk=;
        b=c4yHQGAY4j2x4KzW7BkAiPB1tulIO6tQSTG69fz7opWPF7+VZwdY/m+6d2T0c9zC5S
         5n47MjQnM0UQKonMC+f0qTQtpONDAkILGlJkdQVBEj1XK+QeEE43YDXtuOZcqgEHDwSM
         1I45YWHFnAcHfvkqwC03i4FTAd794q5Oyf3sjn/VUv7wbpxRfWbnvjrOceWo9sihn4CO
         1gMUqVRT6F6G9yulR03OIh9aeIa/MiaySaiiDM+qf+oJnMsBkSIN81VBbcMq5+uBt4hw
         3ES2jcgWdFnNT+mFXINNk4OcUpXkuGVe036cOftEjYYeeB+LV/g6NtKD2aCUpvbKzJDI
         vVtw==
X-Forwarded-Encrypted: i=1; AJvYcCU41PeSeDNyjqwxiZ9wI2EHun51FQhKAIPpYDFMhlE9GasDfzqRlIIK2y7IQ7DfBNCpXh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/v9kKPg04+ZmKLUn3CxVwfF6HzTwHYMBV1s4m0xX/g2VJamE4
	HET++q5uTYsAFqXzwPoenn8bKJIbXJHl3gxnlHoBwMV5QZ27sbd0Vdl2QNm5W5je84sc5CR9avU
	lm4MUCUKfIg/4bWT9ArQbtfnlxlrIJudPkUfYNAA75vqw7H3n/Go77rA=
X-Google-Smtp-Source: AGHT+IEtqZN03bp4/ziDi1KAhbE08d8Ugaqs1Abc7D4LF1QZEMgZjMqJzOUjtIDHSfnA6ZnxM0UzwH0YhEO3v1PzMsTeMx+eF1wO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3c2d25673f5mr356052595ab.8.1735824262350; Thu, 02 Jan 2025
 05:24:22 -0800 (PST)
Date: Thu, 02 Jan 2025 05:24:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67769386.050a0220.3a8527.003e.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING: held lock freed in process_one_work
From: syzbot <syzbot+091dd8c0495cc3c6b48d@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd0584d220fe Merge tag 'trace-tools-v6.13-rc4' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bf90b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=091dd8c0495cc3c6b48d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ecc75c8807ba/disk-fd0584d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d5d397df783/vmlinux-fd0584d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da7bfd7b8963/bzImage-fd0584d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+091dd8c0495cc3c6b48d@syzkaller.appspotmail.com

=========================
WARNING: held lock freed!
6.13.0-rc4-syzkaller-00071-gfd0584d220fe #0 Not tainted
-------------------------
kworker/1:2/28505 is freeing memory 0000000000000000-ffffffffffffefff, with a lock still held there!
ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12cd/0x1b30 kernel/workqueue.c:3204
2 locks held by kworker/1:2/28505:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12cd/0x1b30 kernel/workqueue.c:3204
 #1: ffffc900186f7d80 ((work_completion)(&aux->work)){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205

stack backtrace:
CPU: 1 UID: 0 PID: 28505 Comm: kworker/1:2 Not tainted 6.13.0-rc4-syzkaller-00071-gfd0584d220fe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events bpf_prog_free_deferred
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_freed_lock_bug kernel/locking/lockdep.c:6662 [inline]
 debug_check_no_locks_freed+0x208/0x2b0 kernel/locking/lockdep.c:6697
 remove_vm_area+0x128/0x3f0 mm/vmalloc.c:3240
 vfree+0x90/0x950 mm/vmalloc.c:3364
 bpf_prog_free_deferred+0x539/0x6f0 kernel/bpf/core.c:2820
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
------------[ cut here ]------------
ODEBUG: free active (active state 1) object: ffff88807a9a9100 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 28505 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:

CPU: 1 UID: 0 PID: 28505 Comm: kworker/1:2 Not tainted 6.13.0-rc4-syzkaller-00071-gfd0584d220fe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events bpf_prog_free_deferred

RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd e0 80 b1 8b 41 56 4c 89 e6 48 c7 c7 60 75 b1 8b e8 af 52 bc fc 90 <0f> 0b 90 90 58 83 05 f6 53 7f 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc900186f7a08 EFLAGS: 00010282

RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff815a1729
RDX: ffff8880655ebc00 RSI: ffffffff815a1736 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bb17c00
R13: ffffffff8b4e5e20 R14: 0000000000000000 R15: ffffc900186f7b18
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78f559790a CR3: 000000006b8b2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
 remove_vm_area+0x1ae/0x3f0 mm/vmalloc.c:3241
 vfree+0x90/0x950 mm/vmalloc.c:3364
 bpf_prog_free_deferred+0x539/0x6f0 kernel/bpf/core.c:2820
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

