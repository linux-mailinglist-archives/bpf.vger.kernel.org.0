Return-Path: <bpf+bounces-27426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233858ACF39
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E4C2838DC
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7671514C9;
	Mon, 22 Apr 2024 14:21:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D191509BB
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795685; cv=none; b=FwDUr+jwdu406MiYa8kNR0ni2lXNZArg/Z/ZNX9b2VP0b7rMHurBBSU4tr4h0YObDfGb7ZeRQAHCcWusKfbevvJuzL2SlrROfw+5GfN9748odOjvfwH/NdKNtzx7/Z/J1MF+lRKNuNJxyBGuXz+avX9XisVhn+NCaO88TcBE14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795685; c=relaxed/simple;
	bh=Qy//AdmxEgHP3psLoUo+TYNKkRALUtkqAmoJKbj8rrQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cIXEjak9u7OofP8u9YJwRstUF9yvLVhbj4AoMvNOVaClrSfCQedwNWd9q04tmrkaq1EbEwPmeLRZDJ3bMxY2qic454xb4Aufv581A5YSmeKGmC/xB/js4QDA8lw07K6suvIzDIMr4zC3lb7EXW34IqErSWM06MagEIummZBo2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da42114485so494949139f.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 07:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795683; x=1714400483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yKoEUmreO/jxEhsqvfi/lpCnpHH8jnP+ZOdlyL7veY=;
        b=Fn5HJ0xT8K3Lv3kie9uEGv9pwH7DJTiUW0QS5cYursrkcS6y49CR5g4QFdQuqsxUqc
         Vig3HVFULckI3uGWkg/QycvvXkr7Be929IoZYTJNrFNxkRoKWtef4QIpdUQSPBiqUDYb
         NlPBZwvDT+7A/Dtd09EvoLQOUGnn2PZa0X757Oo95ry4ddZQTtUa0ZTK1oiDIbhcEwUD
         Auef5Ijr0fXRMDfDKyQK3sR7QfiXMjvdUgMezLMfyPaVWjLMHWsTy3g5vgJ2zkAwq9Ar
         fFRMa/UC1/r+vXiW+6YmXgqj1u/V0Bpn8KuM8sqaOXs5uTLN1IXzqqH2dE8qd1cFQ84/
         /uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXANSYzjjc2vjhQpGs+PrOk0EJn949JkDXwPzMfMNoZjPRw/eK8PSqiekjd5hZBZFzK/szJ1ktHaFy8HQS/z2mPUvgc
X-Gm-Message-State: AOJu0YxwWPzwPy9A0QOEY4e6umUqYwyWmwy153xaHLqgPVf6i13OGs97
	RPca9r+nFcepjd+hkBAkhfGQZ71ZPX4r6xMa98/XNJkPlCEAnzQ9YN/2dNHCUYi/hEOtVker3Ea
	0Qrzh+d7zII3y4cgBu59yinb7m4uPWyeQHbRNQN7ztoPdQQw+OTf4SDc=
X-Google-Smtp-Source: AGHT+IFx4XZUnDLRtz1C/Ng5arXiCpIa7t+/uscrSJudFp4Q7+OF/5yd8SHiEj/XxK3O44Hvn/K5fRyvioamZvbwXzLBhAdQqu5q
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c12:b0:7da:ce78:a1be with SMTP id
 ik18-20020a0566026c1200b007dace78a1bemr55003iob.3.1713795683234; Mon, 22 Apr
 2024 07:21:23 -0700 (PDT)
Date: Mon, 22 Apr 2024 07:21:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eac28e0616b026d1@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in skb_ensure_writable
From: syzbot <syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, fw@strlen.de, haoluo@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4ac828960a60 Merge branch 'eee-linkmode-bitmaps'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14710a54180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57c41f64f37f51c5
dashboard link: https://syzkaller.appspot.com/bug?extid=0c4150bff9fff3bf023c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cc49d8180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c88616180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1bd74942969/disk-4ac82896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c99cbac61b8b/vmlinux-4ac82896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa3d589c2a1c/bzImage-4ac82896.xz

The issue was bisected to:

commit 219eee9c0d16f1b754a8b85275854ab17df0850a
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Feb 16 11:36:57 2024 +0000

    net: skbuff: add overflow debug check to pull/push helpers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166b3a4c180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156b3a4c180000
console output: https://syzkaller.appspot.com/x/log.txt?x=116b3a4c180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5074 at include/linux/skbuff.h:2723 pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
WARNING: CPU: 1 PID: 5074 at include/linux/skbuff.h:2723 pskb_may_pull include/linux/skbuff.h:2739 [inline]
WARNING: CPU: 1 PID: 5074 at include/linux/skbuff.h:2723 skb_ensure_writable+0x2ef/0x440 net/core/skbuff.c:6103
Modules linked in:
CPU: 1 PID: 5074 Comm: syz-executor365 Not tainted 6.8.0-rc5-syzkaller-01654-g4ac828960a60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
RIP: 0010:pskb_may_pull include/linux/skbuff.h:2739 [inline]
RIP: 0010:skb_ensure_writable+0x2ef/0x440 net/core/skbuff.c:6103
Code: e8 b6 f7 57 f8 4c 89 ef 31 f6 31 d2 b9 20 08 00 00 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d e9 17 04 fe ff e8 92 f7 57 f8 90 <0f> 0b 90 e9 3e fd ff ff 44 89 f7 44 89 e6 e8 3e f9 57 f8 45 39 e6
RSP: 0018:ffffc900039ef8f8 EFLAGS: 00010293
RAX: ffffffff893b75de RBX: ffff88802c8a1000 RCX: ffff88802a155940
RDX: 0000000000000000 RSI: 00000000fb6014e4 RDI: 0000000000000000
RBP: 00000000fb6014e4 R08: ffffffff893b7317 R09: 1ffffffff1f0bcb5
R10: dffffc0000000000 R11: ffffffffa0000954 R12: 00000000fb6014e4
R13: ffff88802c8a1000 R14: ffffc90000b06030 R15: dffffc0000000000
FS:  0000555556fa9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001b7b398 CR3: 00000000241e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bpf_try_make_writable net/core/filter.c:1665 [inline]
 bpf_try_make_writable net/core/filter.c:1671 [inline]
 ____bpf_skb_pull_data net/core/filter.c:1862 [inline]
 bpf_skb_pull_data+0x7c/0x230 net/core/filter.c:1851
 bpf_prog_ca74b6b79e086095+0x1d/0x1f
 bpf_dispatcher_nop_func include/linux/bpf.h:1235 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x408/0x900 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0xaf9/0x13a0 net/bpf/test_run.c:1056
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4188
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5591
 __do_sys_bpf kernel/bpf/syscall.c:5680 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5678 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5678
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f6a0471c4a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdcead7e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffcdcead9b8 RCX: 00007f6a0471c4a9
RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f6a0478f610 R08: 0000000000000000 R09: 00007ffcdcead9b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcdcead9a8 R14: 0000000000000001 R15: 0000000000000001
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

