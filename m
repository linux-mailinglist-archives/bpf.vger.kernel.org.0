Return-Path: <bpf+bounces-18677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568DD81E840
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8866D1C21676
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793054F888;
	Tue, 26 Dec 2023 15:59:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AE4F5F2
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fe6d256eso637592139f.1
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 07:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703606359; x=1704211159;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKqABHvkxI9tRyf7K59TFrJ0M3NEAQM3qHeXYjfCyOc=;
        b=ZTyJAcmqR1eiMO26YX9iZ4ZXAls9NHlBJ6ValH9Pai2lGkws5Tdmw8Fw3wCbRRwX0I
         Py/277bTBdhvnKFGUHbiZuhzpoYu/FaVDYJT6sMQS3LIqwXxttTHFXZY20TZqmw33F2v
         1tCbeLFdalEc+VPtwoYX8dSU9FktpkuCHA9Ulff0bpbv6SCtNe8SId8SPB0kk3uqrWiA
         kht0Jq+L4offdcTo3gp/y0E0oIjV5dmzRQJQOgaB+b39ceFhhJRcWkWMJ8h8du1Jas3K
         IZ9P6nu6vF6F9X43UilAK5Q+gTGlHNtZWsRBnHeGnhkZ4/bQ/Q2LESx10QCiL/QAYhJ4
         Xsqw==
X-Gm-Message-State: AOJu0Yyix7rRGkaW/wnfmEz0SWwD4JZrEbxBVHGWeL4TAEwwjjSSltwv
	1Ee6ZNZ8uFF534D3o8ePL+dQEBTmA1pOYQZyPBwdBQlfBStJ
X-Google-Smtp-Source: AGHT+IFYdVQOgeJNL01WZvVJm0kp2LoIHqrruHZ5LRJl9WCkA4ny8esb0VoDSz0n2XB3QJvEym4hfLsGwi2X00TF6f4CH5+AXXiL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:35f:d4dc:1b1d with SMTP id
 m8-20020a056e021c2800b0035fd4dc1b1dmr774874ilh.1.1703606359070; Tue, 26 Dec
 2023 07:59:19 -0800 (PST)
Date: Tue, 26 Dec 2023 07:59:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dea025060d6bc3bc@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in ___bpf_prog_run (4)
From: syzbot <syzbot+853242d9c9917165d791@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1275e59ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a65fa9f077ead01
dashboard link: https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab88d88fa1d1/disk-55cb5f43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/587fd1186192/vmlinux-55cb5f43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7bbb5741191/bzImage-55cb5f43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ___bpf_prog_run+0x8a26/0xdb80 kernel/bpf/core.c:2037
 ___bpf_prog_run+0x8a26/0xdb80 kernel/bpf/core.c:2037
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ___bpf_prog_run+0x8567/0xdb80
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run512+0x45/0xe0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423

CPU: 1 PID: 13775 Comm: syz-executor.3 Not tainted 6.7.0-rc6-syzkaller-00022-g55cb5f43689d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


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

