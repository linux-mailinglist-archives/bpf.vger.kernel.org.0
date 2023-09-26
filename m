Return-Path: <bpf+bounces-10903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145987AF584
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 52369B20CA8
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBCE43A8A;
	Tue, 26 Sep 2023 20:47:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82708125C3
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 20:47:36 +0000 (UTC)
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBFC121
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 13:47:34 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6c4717c4745so19897599a34.0
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 13:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761254; x=1696366054;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ5a3zk1rHi4N82X3qGwLU8uWGH8yvH6bBrokHLs9o0=;
        b=tlVZxFm1udOB4aPRWxP6HJwORho8kVUs/qhaXzIldGgQN4laLywnYFMEpz7rpIfRgj
         QAxEvbpVhT/m0wtkWaOi0O7sfV8qQO+DKd0er5l0qmA6CL1QtYNzLQwt+7OvId828lZn
         ESbRT5rdxmVw98SCEWCO1RyNEhaokWdTrlRJL6u5XdfjdxAJAqDmOQ+5rO1YcPOaudC7
         qqQ7vHvgcgRcs/72NE5t0NznPHEx6s2o05WiIYaUL0B0JD0BPLr4Jxc51BF/b3++d4+x
         r911hTwtzt1ypf+IxefT93S092mXGAH+g7Lq+Hl6jslsVaNNDUevCP8r8qAOCeDXR9BI
         taHw==
X-Gm-Message-State: AOJu0YyKsoxwkrh608RH9E8sprjMMVcmMlaRwYSlHwgIc9zBACsbI63a
	A/uGfsq4a+5+VNQeLiT42yc2j5FMaWqve0XLHTZSuDc20jsR
X-Google-Smtp-Source: AGHT+IGZgqz85XcIEHVAoIFbsTTXwuT11bJzo5JFaYBR0VmJ3pBMeSTFPQi6zR14HqQowAAxRfYxIOOzL/RG+FAvKErLj9lYn44X
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0e:b0:3a8:74ff:6c01 with SMTP id
 bk14-20020a0568081a0e00b003a874ff6c01mr55641oib.5.1695761254082; Tue, 26 Sep
 2023 13:47:34 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:47:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c6cf80606492f14@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_mprog_pos_before
From: syzbot <syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    81335f90e8a8 bpf: unconditionally reset backtrack_state ma..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111d5132680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=b97d20ed568ce0951a06
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1570bfc1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126c6856680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/15d122573dad/disk-81335f90.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74edf542067b/vmlinux-81335f90.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22fa248ded38/bzImage-81335f90.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5108 at include/linux/bpf_mprog.h:198 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
WARNING: CPU: 0 PID: 5108 at include/linux/bpf_mprog.h:198 bpf_mprog_pos_before+0x18c/0x280 kernel/bpf/mprog.c:200
Modules linked in:
CPU: 0 PID: 5108 Comm: syz-executor123 Not tainted 6.6.0-rc1-syzkaller-00198-g81335f90e8a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
RIP: 0010:bpf_mprog_pos_before+0x18c/0x280 kernel/bpf/mprog.c:200
Code: 89 e8 48 c1 e8 03 42 80 3c 38 00 0f 85 d8 00 00 00 4d 3b 65 00 0f 85 26 ff ff ff e8 3e 50 e3 ff 83 eb 01 eb 38 e8 34 50 e3 ff <0f> 0b e9 3a ff ff ff e8 28 50 e3 ff 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffffc90003aafad0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801e873b80 RSI: ffffffff81a47e4c RDI: 0000000000000005
RBP: 0000000000000040 R08: 0000000000000005 R09: 000000000000003f
R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801fdb0418 R14: ffffc90003aafb98 R15: dffffc0000000000
FS:  0000555556eea380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8e2323b0d0 CR3: 00000000750ca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_mprog_attach+0x720/0xfe0 kernel/bpf/mprog.c:258
 tcx_prog_attach+0x2bd/0xbd0 kernel/bpf/tcx.c:39
 bpf_prog_attach kernel/bpf/syscall.c:3848 [inline]
 __sys_bpf+0x413e/0x4e90 kernel/bpf/syscall.c:5344
 __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8e231c3cb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc80795988 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e231c3cb9
RDX: 0000000000000020 RSI: 0000000020000080 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

