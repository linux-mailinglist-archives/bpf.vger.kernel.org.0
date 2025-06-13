Return-Path: <bpf+bounces-60580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD79AD83D4
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A18189A51D
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29C2749D6;
	Fri, 13 Jun 2025 07:12:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E825393B
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798760; cv=none; b=cFCQ/uuroxJggGOC7KAKRyEcVzrNPtOLXLNP5YQG408uFsqvKlQZhADv3Ck0Q/qKFgd5L1y0LZQDjW7YBLscjnLj63Oa+NdUhHnrxuKeeempCdr5nQSzv2X+pw+FgD2z6Kg7j6A1HxSb+sMxOaHtRaSvXNZtjOGaJUn8Cm9Z3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798760; c=relaxed/simple;
	bh=sWyWIfwI7kTzqivc7bTrOqy9Tj8LyGdscPOXHhGCi4s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UibB96kfYdnchSMh6neqap9R/HABGerAxCzVfi3hAorewYaJMKf53g/NIWYZwWT/pDpJNWrsvLa4gcuS3cAIdBssDuICyDnbusdXzhC106Uov91sALhJeK9jlt2yZ35U0uPbtGit/b/gs2MDXBN9MuuUgnyWPT978GW076nzTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc9ee4794so31771945ab.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749798757; x=1750403557;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juhYk1wKYKfUnaUV/pQ8ZEVYMZB94Oi+kC5HvDlYkTc=;
        b=Qc9QZSWMmrHccSll6DnhMsK7i6gZ+wcK+O3nrKmnwHAbC4CAzmkEqPf3k270jE9JOU
         DEJK+sU7S4VFVrQT+5AGKe1uJRPeUYq6bW2OFeha+kL/yrBle/CiqRgMVleLOiGrTPX6
         F6CJgxiaHIm2gZtXN2hMjqKddXhLzBzVB0Ve8a7njYn3AS7z05qKW/LBMY3beuJ2C3DR
         3Ge/r/hY0wWXZPOvoceT+EbSn3oNGcNkFBaLM+qJM3Gn7in0CcY1ORGFAw6ivIOXe8GT
         sOs7Qr7PBrUMz3zCqRM7GLY4eunPMtpJva/gCw559LZj3VkFwSZXXBdAsTsyoxJcZsDw
         vGOw==
X-Forwarded-Encrypted: i=1; AJvYcCV/J2Fc3cU/WHgcMxFpm2Cc5PQapX44oj4vzhVqE7SRneJuTwasrZretCEil8AAYFBTdqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAKixHYloJeylS80CNtG8+tbVx2V62TX5ApC1cH9VJv21x3pf
	v0jYukew1DRsoYc3LpB5RPer/SunHREtIaRIexdoOEnjx4poGBiU6Wgp/7lenbJfbFY6sN4VyDJ
	glU7Pv4a/5Md3LRs3rc1Qkw1ljB3LKFCfDK3/WdQR2GtQ6ccs/RwbKQdJKSg=
X-Google-Smtp-Source: AGHT+IGBwD/2/C4kc9h6TIClenfR5iYoIenohZ5RomSbIQ0maGl/dTNKfi63zAkyRk+LR/aAQ38VdNauGcbMCQtdfWzn00FnCnPE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:3dd:ecc8:9773 with SMTP id
 e9e14a558f8ab-3de00c0951fmr18522855ab.19.1749798757590; Fri, 13 Jun 2025
 00:12:37 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:12:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684bcf65.050a0220.be214.029b.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in do_check
From: syzbot <syzbot+a36aac327960ff474804@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1c66f4a3612c bpf: Fix state use-after-free on push_stack()..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1346ed70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=a36aac327960ff474804
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1392610c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a9ee0c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ddb1df1c757/disk-1c66f4a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a318fc92af0/vmlinux-1c66f4a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76c58dddcb6c/bzImage-1c66f4a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a36aac327960ff474804@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: add backedge: no SCC in verification path, insn_idx 9(1)
WARNING: CPU: 1 PID: 5838 at kernel/bpf/verifier.c:1970 add_scc_backedge kernel/bpf/verifier.c:1969 [inline]
WARNING: CPU: 1 PID: 5838 at kernel/bpf/verifier.c:1970 is_state_visited kernel/bpf/verifier.c:19417 [inline]
WARNING: CPU: 1 PID: 5838 at kernel/bpf/verifier.c:1970 do_check+0xda21/0xdba0 kernel/bpf/verifier.c:19861
Modules linked in:
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor286 Not tainted 6.15.0-syzkaller-g1c66f4a3612c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:add_scc_backedge kernel/bpf/verifier.c:1969 [inline]
RIP: 0010:is_state_visited kernel/bpf/verifier.c:19417 [inline]
RIP: 0010:do_check+0xda21/0xdba0 kernel/bpf/verifier.c:19861
Code: 01 90 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 2b 01 00 00 41 8b 75 00 48 c7 c7 20 49 91 8b e8 d0 05 ad ff 90 <0f> 0b 90 90 e9 27 fe ff ff e8 11 5d e9 ff e8 3c 10 4d 00 ba 38 00
RSP: 0018:ffffc900043eeec0 EFLAGS: 00010246
RAX: 53f7659fb2f02200 RBX: ffffc900043ef180 RCX: ffff8880257d1e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc900043ef2c8 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa44 R12: ffff88801c7a4b00
R13: ffff88801c7a4b54 R14: 1ffff110038f496a R15: 0000000000000000
FS:  000055556bd6a380(0000) GS:ffff888125d54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000ebea398 CR3: 00000000713fa000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_check_common+0x18fa/0x2460 kernel/bpf/verifier.c:23086
 do_check_main kernel/bpf/verifier.c:23177 [inline]
 bpf_check+0x110e2/0x1a240 kernel/bpf/verifier.c:24530
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
 __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5978
 __do_sys_bpf kernel/bpf/syscall.c:6085 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6083 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6083
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f37a741f569
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3011bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe3011c0d8 RCX: 00007f37a741f569
RDX: 0000000000000094 RSI: 0000200000000840 RDI: 0000000000000005
RBP: 00007f37a7492610 R08: 00007ffe3011c0d8 R09: 00007ffe3011c0d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe3011c0c8 R14: 0000000000000001 R15: 0000000000000001
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

