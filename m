Return-Path: <bpf+bounces-41152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F2399364B
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F4284748
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120E1DDC3A;
	Mon,  7 Oct 2024 18:35:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AC1D7E52
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326136; cv=none; b=Xax3iLSQiohzen2xeBmQzPrt+lXSO1MXxqNk3Nnxy+3bT/pxpARbJx13WXJ7mgx17ner4zsPVfbnuLp5t7qQRxDdu0mwPK+Lu8eQoB+Fxf9VRsUeQ5813f55HSDVntGL/E4/fcxfEEu9Y1M6VDZ/G4OrMaQiFYtu2OZUXyxwHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326136; c=relaxed/simple;
	bh=ui84LHJ7V2MPndNlQZi16Q2g1mkF+wiIlqZkiMB0dq8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hnyA3HwofjI/pvTf5INU3As9S5WDVotiCojWO2tucwXN3/4LtplW0QR3BlqJs5jTYnnwTKSgtvPWv5OZ6bWMjY05oU2ZVPSYpFXpISUOjCTm5p5UTfbwvPdO6wM9XihfBODY/5c/kF7WpAv6R1qte5e3lun/jC8J8ITD3RDG6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a2762bfcbbso76542875ab.3
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2024 11:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326134; x=1728930934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSkxKQJV4Cou1kKVASSDVARvILCeYBsEr0cEZZIICr8=;
        b=IcbG0VLXCRS2j+5NJV0m49mLWrPu19aDlvxg/KefmDlJgTXtG2oaQ3M1mkpaLpea0M
         TQh/3myhcymWkZJsm7Nt/oYBQN7+pxaSL+pZrbeiDay9VNV458sxrveGDp3bWRM+Xmxm
         OrzSHVuWrQFNQy+1GkYABBgIwvV1VHHBul9Hx4fa5RhRw4qjVUlOiQuZG46gvRGUp2qa
         3nv7znRyl+sJLkWmjizCbSzZtGDp7B2PE4qNh2vOA5FpNm9SYwbZHXuHrTC09AavIpcs
         s5hc/P2S6h12eccskHyK7YGzgftlQDdZHUKyqhcNJaLXd6JT4r2dSV2tks+J8+hsPTcd
         x3sg==
X-Forwarded-Encrypted: i=1; AJvYcCXbgQtN01Hg+XZMUbNJIPZhppUx5g/v5MskS4m1G7MknWgtL5oH7biTkfQ1i6v+XaMjb3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzYPqUUU/4HsEtNkFW9OMBDmrav3PtC0LZdUI7ymnFZrDxnb9
	cnV+XpZemQq88FJjm6p+adwwxneZJFfyo2XhFMETV4bj7Q3xAVAt+opDfhFDD8LieotyYwfiav3
	v8hG8hXMZM+ZjwcauUZiSO4D1zZbsXoD88/h0jx6rWo5wSYNmn1YVqP0=
X-Google-Smtp-Source: AGHT+IGvrO4tEXhzvh+AgETbW2DNS1KBSMgWQ5+HzHJTzW+7zW0bIP+twvXYMs18lyVwkHfLlAFHk8NZ3ioglW1u9XMz4h7y6lXw
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:3a0:abec:da95 with SMTP id
 e9e14a558f8ab-3a375bd1f54mr111730985ab.22.1728326134302; Mon, 07 Oct 2024
 11:35:34 -0700 (PDT)
Date: Mon, 07 Oct 2024 11:35:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670429f6.050a0220.49194.0517.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in push_jmp_history
From: syzbot <syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17382707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=7e46cdef14bf496a3ab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b82707980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4c327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com

------------[ cut here ]------------
virt_to_cache: Object is not a Slab page!
WARNING: CPU: 0 PID: 5232 at mm/slub.c:4655 virt_to_cache mm/slub.c:4655 [inline]
WARNING: CPU: 0 PID: 5232 at mm/slub.c:4655 __do_krealloc mm/slub.c:4753 [inline]
WARNING: CPU: 0 PID: 5232 at mm/slub.c:4655 krealloc_noprof+0x1b3/0x2e0 mm/slub.c:4838
Modules linked in:
CPU: 0 UID: 0 PID: 5232 Comm: syz-executor250 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:virt_to_cache mm/slub.c:4655 [inline]
RIP: 0010:__do_krealloc mm/slub.c:4753 [inline]
RIP: 0010:krealloc_noprof+0x1b3/0x2e0 mm/slub.c:4838
Code: 45 31 ff 45 31 f6 45 31 ed e9 21 ff ff ff c6 05 4e 2a 14 0e 01 90 48 c7 c7 24 f2 0b 8e 48 c7 c6 44 f2 0b 8e e8 3e 19 63 ff 90 <0f> 0b 90 90 e9 d9 fe ff ff f3 0f 1e fa 41 8b 45 08 f7 d0 a8 88 0f
RSP: 0018:ffffc90003c36ba8 EFLAGS: 00010246
RAX: 3f2bb101b90db800 RBX: 0000000000000000 RCX: ffff88802bb01e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807849c000 R08: ffffffff8155d412 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: 0000000000004000
R13: 0000000000000201 R14: 0000000000100cc0 R15: dffffc0000000000
FS:  0000555587952380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005594dac5c5d8 CR3: 00000000786d6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 push_jmp_history+0x13c/0x5c0 kernel/bpf/verifier.c:3497
 do_check+0x6716/0xfe40 kernel/bpf/verifier.c:18352
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:21618
 do_check_main kernel/bpf/verifier.c:21709 [inline]
 bpf_check+0x18a25/0x1e320 kernel/bpf/verifier.c:22421
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2846
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5634
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc05a9603e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd106d44d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffd106d46b8 RCX: 00007fc05a9603e9
RDX: 0000000000000048 RSI: 00000000200054c0 RDI: 0000000000000005
RBP: 00007fc05a9d4610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd106d46a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

