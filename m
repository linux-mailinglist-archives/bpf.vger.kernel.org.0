Return-Path: <bpf+bounces-17339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B680BA94
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 13:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23366B20AD4
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28FC8C11;
	Sun, 10 Dec 2023 12:09:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0CFF
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 04:09:23 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d9dc6718f4so4823474a34.1
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 04:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702210163; x=1702814963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AQNLUSllWnJ3zCwLiGh03/cl64/JUNSMwCGcq9aVe4=;
        b=szKvrtAGnL3zKhErmG7lrFxKF8k7T29HeU51ve2vrC8vLVIZRjAm/KbANMLWWljQFC
         6GQdixRgAf5YEHzuqTIEhYltHlq+GUfGtpKiVPqQy+txdQ/2GwmPd1bjMzAZrqCTuP4a
         nuoK7OOvzPKVSA6/QEWEH85DCTOW6g6ulnK6kcruzFl4L5H7oLCFqiCEd1eHDyQwQqkn
         zydEXPMPl1dTmqyd94q2E7D7lh5GMZFg98i+t7+zN2CDvuyrbLBi8phKOnri21VWq9Ge
         WrkiKqRyYctkkf6RZbxKSV0aMsVZfEdQDVcjtg3YTUlcOO4w+DUfj4WFvNbcv+Frn+3j
         72mA==
X-Gm-Message-State: AOJu0YyfxeC6afCB4zJMOkNSUCV0VkekLVIhypW/uQnrvmxKhvM8XvY6
	4NXOAsm1hVf1xQmWcgM4Iloj+E48R6QF6UTPPFUK1JgLwkDf
X-Google-Smtp-Source: AGHT+IFejoOVXeW/TEX4EoGjoqnEUS7KKIZmKe0oR7QxnUakzBn4WXTvt0jUv/M6JRggZRi/Ngce2RhdcKonPzC/KfdRfVPex7l+
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:913:b0:6d9:d4d1:1610 with SMTP id
 v19-20020a056830091300b006d9d4d11610mr3009284ott.2.1702210162848; Sun, 10 Dec
 2023 04:09:22 -0800 (PST)
Date: Sun, 10 Dec 2023 04:09:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016fb59060c26b03e@google.com>
Subject: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
From: syzbot <syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

Hello,

syzbot found the following issue on:

HEAD commit:    577a4ee0b96f Add linux-next specific files for 20231206
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16eee286e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3081237da77b539
dashboard link: https://syzkaller.appspot.com/bug?extid=4d6330e14407721955eb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a19474e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11abb46ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14bcd8d77be7/disk-577a4ee0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f03a87f3ac1/vmlinux-577a4ee0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c655bc6a307/bzImage-577a4ee0.xz

The issue was bisected to:

commit 41f6f64e6999a837048b1bd13a2f8742964eca6b
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Dec 5 18:42:39 2023 +0000

    bpf: support non-r10 register spill/fill to/from stack in precision tracking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a03302e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a03302e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a03302e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com
Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from stack in precision tracking")

------------[ cut here ]------------
verifier backtracking bug (stack slot out of bounds)
WARNING: CPU: 0 PID: 5066 at kernel/bpf/verifier.c:4266 __mark_chain_precision+0x2a84/0x4d60 kernel/bpf/verifier.c:4266
Modules linked in:
CPU: 0 PID: 5066 Comm: syz-executor245 Not tainted 6.7.0-rc4-next-20231206-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__mark_chain_precision+0x2a84/0x4d60 kernel/bpf/verifier.c:4266
Code: ff 89 de e8 8e e5 ec ff 84 db 0f 85 2c e1 ff ff e8 51 ea ec ff c6 05 60 54 88 0d 01 90 48 c7 c7 a0 4b d4 8a e8 2d d9 b2 ff 90 <0f> 0b 90 90 e9 09 e1 ff ff e8 2e ea ec ff 48 8d 7b 04 48 b8 00 00
RSP: 0018:ffffc90003abf2e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814e05d9
RDX: ffff888024c3bb80 RSI: ffffffff814e05e6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801b2e0000
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000555556ba0380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c37df1b10 CR3: 0000000074a2e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_chain_precision kernel/bpf/verifier.c:4314 [inline]
 check_cond_jmp_op+0xea0/0x72b0 kernel/bpf/verifier.c:14724
 do_check kernel/bpf/verifier.c:17516 [inline]
 do_check_common+0x8cbc/0xe8e0 kernel/bpf/verifier.c:19955
 do_check_main kernel/bpf/verifier.c:20046 [inline]
 bpf_check+0x5129/0xa420 kernel/bpf/verifier.c:20683
 bpf_prog_load+0x1533/0x2200 kernel/bpf/syscall.c:2742
 __sys_bpf+0xbf7/0x49d0 kernel/bpf/syscall.c:5414
 __do_sys_bpf kernel/bpf/syscall.c:5518 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5516 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5516
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f3f5a049af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd0ae5d58 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3f5a049af9
RDX: 0000000000000048 RSI: 00000000200017c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

