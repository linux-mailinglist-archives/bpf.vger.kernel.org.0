Return-Path: <bpf+bounces-62028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8FAF082F
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FA1C04548
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334B1A256E;
	Wed,  2 Jul 2025 01:56:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCD17A319
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421400; cv=none; b=EtFwkG9qFgbFmrLnd4pjKiQDbE+ZEpS6dzGGdw5Fh7VHYBtAV+IF3u1L5+IGrG/8m0ry9mscoMBm1G3lPmsqalurDuCPuxU9gBCz7MsVdj7MeSjT1Q2Idf+KePSgmiXLDaLwgPu12WiuBcjj9PxTL+/ZXUPqNhDigBSltqL5/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421400; c=relaxed/simple;
	bh=lf+W/XheVswP37bZGWyVHx0TjRCAvQU1dQGxBHJnjaw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZCXgfvzTGuVwcTEzCGqaDuEtk+gU7rK6nshRJcwYLG81OZb0CdALZGC4aCfB5X3PSq/ZaRiO3VnlSIjbuqk70KNQ4d14UAYyTcaz46AIm8UHow7rusKfwzrKzAEybT11uvZqcSfqXL1yUCLHBc7tIM8vjjod5D0UsdONPOCIpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e055be2288so1989095ab.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 18:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421398; x=1752026198;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9p2vmYIDQnjZYKhnWO08w7hs02+yCAMO55AhYPDySY=;
        b=KDWh8pva9fixo/c89SfE1dVKz5I6m+B4mb2z2AZ8Ktg4LCPxKDszCusXSuHLTffuB2
         SqTkCha6/DDDklP/QLE4+14sRlzkuirYW1Fsr+M2vkmbJVCLAK6JojFhe9Jqa13q436p
         IGnGWn2vLOoCpY2yvIcpPvEcxKylbpsNZfPuXcDGO22IXT0Qv7bE4QWvBEI6x/rkcxw4
         ilJ7a7xUI0DYDgkqXsLCx7ltq5gUvsJdlFVreqgNHFvDp2JSdw4R/QT3NLgkLOUaMMjj
         18/NSMi0eqBTC3fGBuEcp9Zr90kE0SviC9ouxgu61SXuOGBuptYF5qGwjTp4Fwvb0Y7Q
         yS+g==
X-Forwarded-Encrypted: i=1; AJvYcCV3IKzjniWWAi1ots2Vw+wpHRIH5p0dW83x91ngahoN93guo1K0Puu1grKQWwgfu9GzSKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYiplpVss55NQ4L0hiHn0Htnk3oRkNjKMQc4iBc3hljJp/vMZ
	MVNJW1kxNxFCV2If6WN+T6+hDpwo7fnv1zs3055zL2Hsue+l2ppdoosGzFAl77qhSb0mSq8DaJP
	10xGktS0oCr2SMLEsmpE6m5A5hinL7JbhIM4nBh6UqSqMpX58qinyTPKIm9I=
X-Google-Smtp-Source: AGHT+IEb9t007pvwN+7iqKRSqObiWGplA42eErhSjupvknzurqGmT7cb0jDTeUcnzmZgI2X7vy4fnBxX8BGeoAOoTw8hsHBBWLXS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3df:3222:278e with SMTP id
 e9e14a558f8ab-3e054934f08mr15804535ab.1.1751421398031; Tue, 01 Jul 2025
 18:56:38 -0700 (PDT)
Date: Tue, 01 Jul 2025 18:56:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686491d6.a70a0220.3b7e22.20ea.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in check_helper_call
From: syzbot <syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=104053d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=69014a227f8edad4d8c6
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144053d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d45770580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef4940/disk-cce3fee7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/vmlinux-cce3fee7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3070663778/bzImage-cce3fee7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: more than one arg with ref_obj_id R2 2 2(1)
WARNING: CPU: 1 PID: 5835 at kernel/bpf/verifier.c:9678 check_func_arg kernel/bpf/verifier.c:9676 [inline]
WARNING: CPU: 1 PID: 5835 at kernel/bpf/verifier.c:9678 check_helper_call+0x6052/0x6b60 kernel/bpf/verifier.c:11386
Modules linked in:
CPU: 1 UID: 0 PID: 5835 Comm: syz-executor386 Not tainted 6.16.0-rc3-syzkaller-gcce3fee729ee #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:check_func_arg kernel/bpf/verifier.c:9676 [inline]
RIP: 0010:check_helper_call+0x6052/0x6b60 kernel/bpf/verifier.c:11386
Code: 48 8b 44 24 18 48 8b 4c 24 38 8b 94 01 d4 00 00 00 8b 8c 24 20 01 00 00 48 c7 c7 e0 a3 91 8b 48 8b 74 24 60 e8 ef 56 ab ff 90 <0f> 0b 90 90 e9 15 d0 ff ff e8 d0 b3 e7 ff c6 05 73 64 b2 0d 01 90
RSP: 0018:ffffc90003f5ecc0 EFLAGS: 00010246
RAX: 9de7429615562e00 RBX: 1ffff1100488e229 RCX: ffff888011441e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90003f5eeb0 R08: ffffc90003f5e9e7 R09: 1ffff920007ebd3c
R10: dffffc0000000000 R11: fffff520007ebd3d R12: 0000000000000002
R13: 0000000000000004 R14: 0000000000000078 R15: 0000000000000002
FS:  0000555591931380(0000) GS:ffff888125d4d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000010cac398 CR3: 0000000075382000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_check_insn kernel/bpf/verifier.c:19850 [inline]
 do_check+0x95ec/0xe080 kernel/bpf/verifier.c:20017
 do_check_common+0x188f/0x23f0 kernel/bpf/verifier.c:23180
 do_check_main kernel/bpf/verifier.c:23263 [inline]
 bpf_check+0x10252/0x1a5d0 kernel/bpf/verifier.c:24619
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
 __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5978
 __do_sys_bpf kernel/bpf/syscall.c:6085 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6083 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6083
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b8c4cc4a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9d7aae88 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe9d7ab058 RCX: 00007f5b8c4cc4a9
RDX: 0000000000000090 RSI: 0000200000000840 RDI: 0000000000000005
RBP: 00007f5b8c53f610 R08: 0000000000000000 R09: 00007ffe9d7ab058
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe9d7ab048 R14: 0000000000000001 R15: 0000000000000001
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

