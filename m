Return-Path: <bpf+bounces-10244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE57A4061
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101C42813FB
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 05:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3C4C87;
	Mon, 18 Sep 2023 05:16:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB121FD0
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 05:16:01 +0000 (UTC)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FE811C
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:16:00 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1d6d06d37ebso1937235fac.2
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695014157; x=1695618957;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1ItRi5jKTmhwOVx6QlQ/dcqMcK3lZjIo74/O9TFpE8=;
        b=axlqdJPiQSZiRcgMtix3eEKd9DiettJsJgQFOyV2XNeP2AzstA9y8EvhSAb4JxsZou
         XonWM9YLjPJ42JLC0vrzUrOVUvIcyAGZdJuHgr3jaqKxx/saMsNn6Ew/SvFc4wQWrkO0
         0JephpDs8bUpZO0dS9woe/zSX/mQFQkrOqUdW/SNS0jKYiEwpSkMuIwE4y+jzqCRVQH/
         b1HnxncbGhiu+37ev3Hc/AuJA5eKxRz8Vxs03zJsLKkUAH6tIjTS8u9iUqVh6jdJJaDa
         8jIHaAxGDlzsD/MV3CXkEgSCgPSTdSHKpmUIT7DvxzFRPa/6SSizGd4NukLlZjfB1kZh
         3Tkg==
X-Gm-Message-State: AOJu0Yx2I2i7fwEJlSK4cZ0rK2zvlrh92geLADy7pOik758nL7CE3YqP
	jkAeaMjWjOUgidR3BN0oso1Yo+hYgtDHc8qmgWFKBLlciE3R
X-Google-Smtp-Source: AGHT+IF7mAyVIHV6YnGModzlYH0POb+0lxli3uAArJRWyyKInpRNbqwzru/TIaqBALOx4uHh0DvMAeBC+ox7qzLUN2qkIj4mKHX9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c79a:b0:1c8:e107:4193 with SMTP id
 dy26-20020a056870c79a00b001c8e1074193mr3142395oab.3.1695014157501; Sun, 17
 Sep 2023 22:15:57 -0700 (PDT)
Date: Sun, 17 Sep 2023 22:15:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf4d0c06059b3c95@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_mprog_pos_after
From: syzbot <syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com>
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

HEAD commit:    ca5ab9638e92 Merge branch 'selftests-classid'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110ef2c2680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=2558ca3567a77b7af4e3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3410dfa76b34/disk-ca5ab963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/993bfbc60422/vmlinux-ca5ab963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40dff86d8c81/bzImage-ca5ab963.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv38
------------[ cut here ]------------
WARNING: CPU: 0 PID: 14695 at include/linux/bpf_mprog.h:198 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
WARNING: CPU: 0 PID: 14695 at include/linux/bpf_mprog.h:198 bpf_mprog_pos_after+0x194/0x2b0 kernel/bpf/mprog.c:216
Modules linked in:
CPU: 0 PID: 14695 Comm: syz-executor.3 Not tainted 6.5.0-syzkaller-12718-gca5ab9638e92 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
RIP: 0010:bpf_mprog_pos_after+0x194/0x2b0 kernel/bpf/mprog.c:216
Code: e8 03 42 80 3c 38 00 0f 85 f2 00 00 00 4d 3b 65 00 0f 85 26 ff ff ff e8 3a 55 e3 ff 8d 43 01 89 44 24 14 eb 48 e8 2c 55 e3 ff <0f> 0b e9 36 ff ff ff e8 20 55 e3 ff 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffffc90004d87ac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888043c88000 RSI: ffffffff81a47c94 RDI: 0000000000000005
RBP: 0000000000000040 R08: 0000000000000005 R09: 000000000000003f
R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888042c89418 R14: ffffc90004d87b98 R15: dffffc0000000000
FS:  00007f51b80af6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30823000 CR3: 0000000026678000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_mprog_attach+0x433/0xfe0 kernel/bpf/mprog.c:266
 tcx_prog_attach+0x2bd/0xbd0 kernel/bpf/tcx.c:39
 bpf_prog_attach kernel/bpf/syscall.c:3848 [inline]
 __sys_bpf+0x413e/0x4e90 kernel/bpf/syscall.c:5344
 __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51b727cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51b80af0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f51b739bf80 RCX: 00007f51b727cae9
RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000008
RBP: 00007f51b72c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f51b739bf80 R15: 00007ffe27bee9b8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

