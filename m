Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59446ACB1E
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 18:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCFRqq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 12:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCFRqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 12:46:32 -0500
Received: from mail-il1-x147.google.com (mail-il1-x147.google.com [IPv6:2607:f8b0:4864:20::147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB96BC22
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 09:45:56 -0800 (PST)
Received: by mail-il1-x147.google.com with SMTP id i7-20020a056e021b0700b0031dc4cdc47cso3263823ilv.23
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 09:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124677;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcOCBhima2UyyDq7VB/1E9koaBdwududHylkHfonubs=;
        b=MPO40zPXL41qJoK9OSpv8KdGuPII+gxXtZh9wD4NJ00d9n8nzeiu5j4DcUbkd7jb7L
         YrmZQtR12m1Fm8ZlN1Zh7jr/9rX51za1FcFZ3NKQMTOo+253GZ30NQKOCwDhClUviCA2
         MaGDMABxwTQh5GJ1P517ZsX48zSEJrBSCs266Ccf/yaZPdbTzrTvVIiOLP/vQhSxpPCl
         ZooYi1E/KhSR51EssBjxSPxQuXODZpUiGGGtKtT8ML8XTusQKviOn321PZMqCrYimsJq
         uD4lqkU7/SHOSn7TnXY9MgRiGRBvC/H7ujQDKEF46KVBeVbDKbNxUMUlxKf6aCBAm2Vy
         Q5DA==
X-Gm-Message-State: AO0yUKWBW1iJ1Kma07lochZzKvdqNZb35cFWea/lTYB4Y+LvwKb/1Cec
        /Z+jIKiZmedNYRJGbQ5ICBpO58dMJ9mpj/pT5Zd170ax9IPG
X-Google-Smtp-Source: AK7set88Bw0d2XTFKUme34XJrkWaccDVs1augIVNYRXEzj+MP9c2PxF+jZE8nNJpCZSojpb7/bgKCrAGpjgg40YIwZT8CPf9Sczt
MIME-Version: 1.0
X-Received: by 2002:a02:23cc:0:b0:3be:81d3:5af3 with SMTP id
 u195-20020a0223cc000000b003be81d35af3mr5918807jau.3.1678124677684; Mon, 06
 Mar 2023 09:44:37 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:44:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d661705f63ed958@google.com>
Subject: [syzbot] [hfs?] kernel BUG in __block_write_full_page
From:   syzbot <syzbot+3aa7a6b7eb0d5536abaf@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, martin.petersen@oracle.com, mcgrof@kernel.org,
        mhocko@kernel.org, njavali@marvell.com, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, yzaikin@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b01fe98d34f3 Merge tag 'i2c-for-6.3-rc1-part2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d58468c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc0f7cfe5b32efe2
dashboard link: https://syzkaller.appspot.com/bug?extid=3aa7a6b7eb0d5536abaf
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a80092c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c4f138c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1d37240ef5e/disk-b01fe98d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3727e84b1762/vmlinux-b01fe98d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d45494f57a4/bzImage-b01fe98d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ff4c7574ee40/mount_0.gz

The issue was bisected to:

commit 4dc48a107a146cade61097958ff2366c13da1f60
Author: Nilesh Javali <njavali@marvell.com>
Date:   Tue Jun 7 04:46:27 2022 +0000

    scsi: qla2xxx: Update version to 10.02.07.500-k

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eb900ac80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101b900ac80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17eb900ac80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3aa7a6b7eb0d5536abaf@syzkaller.appspotmail.com
Fixes: 4dc48a107a14 ("scsi: qla2xxx: Update version to 10.02.07.500-k")

------------[ cut here ]------------
kernel BUG at fs/buffer.c:1829!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9252 Comm: syz-executor382 Not tainted 6.2.0-syzkaller-13534-gb01fe98d34f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:__block_write_full_page+0xfb2/0x16a0 fs/buffer.c:1829
Code: 02 e9 16 f2 ff ff e8 6d 60 89 ff 48 8b 3c 24 e8 b4 32 00 00 48 89 c7 48 c7 c6 20 96 17 8b e8 05 6a c8 ff 0f 0b e8 4e 60 89 ff <0f> 0b f3 0f 1e fa 48 8b 2c 24 48 89 ee 48 81 e6 ff 0f 00 00 31 ff
RSP: 0018:ffffc9000bde6ff0 EFLAGS: 00010293
RAX: ffffffff82035c92 RBX: 00fff0000000a02f RCX: ffff888026c03a80
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 0000000000000000
RBP: 0000000000008000 R08: ffffffff820354d8 R09: fffff9400007d819
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: 1ffff11002d73d01 R14: dffffc0000000000 R15: ffffea00003ec0c0
FS:  00007fe61c1db700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002af1e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 writeout mm/migrate.c:907 [inline]
 fallback_migrate_folio mm/migrate.c:931 [inline]
 move_to_new_folio+0x7a1/0x14d0 mm/migrate.c:981
 migrate_folio_move mm/migrate.c:1295 [inline]
 migrate_pages_batch mm/migrate.c:1827 [inline]
 migrate_pages+0x4c0b/0x6670 mm/migrate.c:1979
 compact_zone+0x2bc9/0x45a0 mm/compaction.c:2420
 compact_node+0x216/0x420 mm/compaction.c:2717
 compact_nodes mm/compaction.c:2730 [inline]
 sysctl_compaction_handler+0xab/0x150 mm/compaction.c:2774
 proc_sys_call_handler+0x545/0x8a0 fs/proc/proc_sysctl.c:604
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 vfs_writev fs/read_write.c:934 [inline]
 do_writev+0x27f/0x470 fs/read_write.c:977
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe61c22f659
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe61c1db2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fe61c2b47a0 RCX: 00007fe61c22f659
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007fe61c281700 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe61c2810e0
R13: 0073756c70736668 R14: 6d656d5f74636170 R15: 00007fe61c2b47a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__block_write_full_page+0xfb2/0x16a0 fs/buffer.c:1829
Code: 02 e9 16 f2 ff ff e8 6d 60 89 ff 48 8b 3c 24 e8 b4 32 00 00 48 89 c7 48 c7 c6 20 96 17 8b e8 05 6a c8 ff 0f 0b e8 4e 60 89 ff <0f> 0b f3 0f 1e fa 48 8b 2c 24 48 89 ee 48 81 e6 ff 0f 00 00 31 ff
RSP: 0018:ffffc9000bde6ff0 EFLAGS: 00010293
RAX: ffffffff82035c92 RBX: 00fff0000000a02f RCX: ffff888026c03a80
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 0000000000000000
RBP: 0000000000008000 R08: ffffffff820354d8 R09: fffff9400007d819
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: 1ffff11002d73d01 R14: dffffc0000000000 R15: ffffea00003ec0c0
FS:  00007fe61c1db700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2061aeb8 CR3: 000000002af1e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
