Return-Path: <bpf+bounces-9161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06AF790DD3
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEC4280F5B
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1074BA29;
	Sun,  3 Sep 2023 19:55:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6D2F49
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 19:55:02 +0000 (UTC)
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D416EDA
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 12:55:00 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-68bec4380edso888933b3a.1
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 12:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693770900; x=1694375700;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWa3iwwkzdPY4YildIzHGcIx9uOwREDiHAagNULjXhs=;
        b=S7tz7DKk0JYu+ARDmYcNXz8eJvanXm9v09lbsjx4hty56ObvyvpuyG+MMuXQfzDmA+
         Lo4ymNgzjczNDmHon3W7TBAXWEcgRNkb1qCdqkh7xdCzqnGxYABhJ7DJ0gtC5kFpGZBh
         XbcFR7FYA5JqafwjypuyZkx5Un2+q2Gt32NQYarvQowg8y5/iQQF9LFUTehx/t3ZZS5b
         PQkO9gfWQH94w6inIUj9VV6oPSfOWl5MflOEZ+OT4QQtyDNJl2fqbwkvjchH7QZFO7nM
         EobqZ6IX+3Adt3oYwWZ0hYRhHeFybaN6rSe95gK+MCcmcXwvPy37RU1VKHW47IHDE3/j
         AbjQ==
X-Gm-Message-State: AOJu0Yy9zktfwFi58Iz/y4HuL6vUhLNw1FH4b1RLZ4rUcoonCBl9X9JY
	pmyPUbpwRoI3ROwiu0Ujv1tLEuBAq0FPumlFDqZfmPXa4Joo
X-Google-Smtp-Source: AGHT+IEkIjg2R/lH3aIeSKcj8ZfWkzZLtK0sefjowJVjw++uev0i4Xd3oKIQOd84JTflLcP94YlaiBFNWxE7ewL0Qeag+qvpqhvf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:4c11:b0:68a:6787:8413 with SMTP id
 ea17-20020a056a004c1100b0068a67878413mr2744479pfb.3.1693770900403; Sun, 03
 Sep 2023 12:55:00 -0700 (PDT)
Date: Sun, 03 Sep 2023 12:55:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d97f3c060479c4f8@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_prog_offload_verifier_prep
From: syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    fa09bc40b21a igb: disable virtualization features on 82580
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13382fa8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=291100dcb32190ec02a8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529c448680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db0248680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7ab461d84992/disk-fa09bc40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ac6d43ab2db/vmlinux-fa09bc40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/778d096a134e/bzImage-fa09bc40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5055 Comm: syz-executor625 Not tainted 6.5.0-syzkaller-04012-gfa09bc40b21a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.c:295
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_check+0x52f3/0xabd0 kernel/bpf/verifier.c:19762
 bpf_prog_load+0x153a/0x2270 kernel/bpf/syscall.c:2708
 __sys_bpf+0xbb6/0x4e90 kernel/bpf/syscall.c:5335
 __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7c0df78ea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde3592128 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7c0df78ea9
RDX: 0000000000000090 RSI: 0000000020000940 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_prog_offload_verifier_prep+0xaa/0x170 kernel/bpf/offload.c:295
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a1 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc900039ff7f8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc9000156e000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a8cf76 RDI: ffff888021b25f10
RBP: ffff888021b25f00 R08: 0000000000000001 R09: fffffbfff195203d
R10: ffffffff8ca901ef R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000005 R14: 0000000000000003 R15: ffffc9000156e060
FS:  0000555556071380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 0000000022f6b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 a1 00 00 00    	jne    0xb3
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	4c 8b 65 10          	mov    0x10(%rbp),%r12
  20:	4c 89 e2             	mov    %r12,%rdx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2b:	0f 85 93 00 00 00    	jne    0xc4
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df
  3b:	4d                   	rex.WRB
  3c:	8b                   	.byte 0x8b


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

