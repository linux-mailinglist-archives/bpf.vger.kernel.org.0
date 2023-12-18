Return-Path: <bpf+bounces-18217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E8817402
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742351F23CAA
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666CC3D566;
	Mon, 18 Dec 2023 14:44:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D73A1CD
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b738d08e3bso350745339f.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 06:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910667; x=1703515467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4doMgNiRAG0oY64YZBGbw9i5anbFAngH6k0NEAjhqo=;
        b=XBZ46DqDRCfzOgvpsbE1OjaNgvl93OVUe88Qk4MpW7vmZTiHur+aO6SbblbDmHTtXR
         p4nrcVu7fe+rZdgtdfC52CgiVPDBDSwRfUYgoePzVsjxwrJe6tJ2qBhdJjWkAU3Nnit/
         RNED03MqQniFem/iqOLKqPQvJHe3NZNSD2OTJBntVnY57zzO3jZyFXNWOxBjpwcGau6x
         o+MbF6ZfD1VZLPbxOSODKlA45t3L6tI0nJ7vAO5n1s2/+L9tmqrxko7/bdYvDuILuJOy
         BKU6ihWpsA6T0ARQBcdJ+jKCZsfslyEf5XN3NXb8+DiGMx6u+J5x3jZz9Wm3YGqJ0kb1
         h+pQ==
X-Gm-Message-State: AOJu0YxDde3//znqb+cvCB2UVuN7hHTYI/wQUYE4otbQt0Qdg/iuYSzh
	Sgt0YhkBPzw8brQcqFGpf9CjX5ijUEKbzOxi6PHbMWLEaE36
X-Google-Smtp-Source: AGHT+IF+8OhGLaiuZnCCoA2uK6/w0OxH5geCmM5R01yRSiNAdaXlgQLnnE2pkdQ4gJgKxExnUfLz9P5sAVWuSRqxMffEzZUXxVhB
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:b0:44a:fe65:d743 with SMTP id
 l5-20020a056638144500b0044afe65d743mr647000jad.0.1702910667748; Mon, 18 Dec
 2023 06:44:27 -0800 (PST)
Date: Mon, 18 Dec 2023 06:44:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f7cb5060cc9c9ac@google.com>
Subject: [syzbot] [bpf?] UBSAN: shift-out-of-bounds in adjust_reg_min_max_vals
From: syzbot <syzbot+46700eea57ecc7f84776@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	martin.lau@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1dfc0f76231 net: phy: skip LED triggers on PHYs on SFP mo..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d0331ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=46700eea57ecc7f84776
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c8ad1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12456fb6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fcd0802bfd92/disk-b1dfc0f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3d9e5ecc7f0/vmlinux-b1dfc0f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b04f82a5ed6/bzImage-b1dfc0f7.xz

The issue was bisected to:

commit f63181b6ae79fd3b034cde641db774268c2c3acf
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Fri Nov 4 16:36:47 2022 +0000

    bpf: stop setting precise in current state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10eed821e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12eed821e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14eed821e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46700eea57ecc7f84776@syzkaller.appspotmail.com
Fixes: f63181b6ae79 ("bpf: stop setting precise in current state")

================================================================================
UBSAN: shift-out-of-bounds in kernel/bpf/verifier.c:13571:63
shift exponent 1073741824 is too large for 32-bit type 'int'
CPU: 0 PID: 5069 Comm: syz-executor200 Not tainted 6.7.0-rc5-syzkaller-00167-gb1dfc0f76231 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a6/0x480 lib/ubsan.c:387
 scalar32_min_max_arsh kernel/bpf/verifier.c:13571 [inline]
 adjust_scalar_min_max_vals kernel/bpf/verifier.c:13759 [inline]
 adjust_reg_min_max_vals.cold+0x162/0x221 kernel/bpf/verifier.c:13860
 check_alu_op+0x498/0x3a60 kernel/bpf/verifier.c:14092
 do_check kernel/bpf/verifier.c:17517 [inline]
 do_check_common+0x1b30/0xd690 kernel/bpf/verifier.c:20177
 do_check_main kernel/bpf/verifier.c:20240 [inline]
 bpf_check+0x77d9/0xa5e0 kernel/bpf/verifier.c:20877
 bpf_prog_load+0x1531/0x2200 kernel/bpf/syscall.c:2716
 __sys_bpf+0xbf7/0x4920 kernel/bpf/syscall.c:5383
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7ff0c7237af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff01650e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff0c7237af9
RDX: 0000000000000048 RSI: 00000000200054c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000003a28
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
================================================================================


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

