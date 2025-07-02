Return-Path: <bpf+bounces-62026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C904EAF0828
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B973B4221B5
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 01:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CE194C86;
	Wed,  2 Jul 2025 01:55:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB966F2F2
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421331; cv=none; b=o+8SReu6/YxixpQdAxEjLYZz+c2KCycyJ89KlnbwbjB1NEExeN7B3A7KEI0wM+lxpmLCMI5/a1gpv//puK+QALDLVKWHPnz0elidtR04YfVe2P29xRVNKHQaQwXqUDHhjdojeClKsbFtWRCv2FZqKowaAkX8F4nZCjKHW4UTT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421331; c=relaxed/simple;
	bh=wU0uAqSERWaULjgXjCPjSAo+g9aZqdrRoNycpKfVcFg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ikYxre9iFspVMDhnJSrOmJrrLj2RPKvptlb5t2K+wm+WirWytyD3bmMXWJjZmabY/OEuDCqD3qcHswwE7671WO5zJxz3Oo+7MOK4pThOUnqFn6qCY+jAQW3v3OxerDF+HtwJiuA0IAPNQtEdTqQohNfwFAuTFVS7xKrZXQaF2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df2e89fc8aso51715405ab.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 18:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421329; x=1752026129;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Onkd7o2/cbYDMjrYISpEERTdApVmoTNyGmJeUEY8dmQ=;
        b=sv+z2XJPQ1bBtb/i8xPWU75/up9egPc7RV7olW5BMk7n/k3g2FNWUhWsvGIsXoyqtD
         wBZsFG7ZZc1FFclPMXqt3b7zwDDkVPAs+Atzj2v5W4lq9y48Cis7/DGob4K0kXLjVKCa
         akeFfqgDYiuxxE8RLITsx/VWQIXltUzZsX2svordavNEoFSzkqYiJTcupnbhEMuNI0Jb
         lWYGd9UzOEoISIR8o6cYLYsULvIZKmaedEbh5HobIg4eurkY4ZmGrjYiFxbKPWjkhfGM
         lIUWVefzQBN9UaxTjBZ/3xdnz6CtHDyfKGnkd7INaKsfPwW4JQAlWfXefU3ym7Oq0PUo
         lf2A==
X-Forwarded-Encrypted: i=1; AJvYcCWdAhna3NEpK1EPCkC93+QJEHRL/uGKpJCWD6zekjZFEwz36EZfPcdp+HR6Wapvc7fnMxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8Z4neVKS7ReF1YRlFW3DuQVyp7TlsvF0Pv4X4sATV0XxdYbH
	fL5IG7Cdz5FMNA48i/6Z+1XzHxj9/G5aaKNAsCOMm4YesxQlaXmYN4TQ27WYvcRJaBYKdrC/w3P
	I1Ay5Kbrh2KyVLEazzlPtTT19OLcR1brQN+QZGmRBU2enSJ19okLHdaMqyyY=
X-Google-Smtp-Source: AGHT+IFa3zsLyTqW3kgAZxNJiDIQLEEbhCgdLAPhixNbMJut/f3gvntmA0vV6ufE60CJpZSMtIh/M46gkrgUX93m6f/fgdjUqFtT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:3df:3ad6:bfb2 with SMTP id
 e9e14a558f8ab-3e0549c756amr14437125ab.17.1751421328864; Tue, 01 Jul 2025
 18:55:28 -0700 (PDT)
Date: Tue, 01 Jul 2025 18:55:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147793d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1594e48c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1159388c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef4940/disk-cce3fee7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/vmlinux-cce3fee7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3070663778/bzImage-cce3fee7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0] var_off=(0x0, 0x0)(1)
WARNING: CPU: 1 PID: 5833 at kernel/bpf/verifier.c:2688 reg_bounds_sanity_check+0x6e6/0xc20 kernel/bpf/verifier.c:2682
Modules linked in:
CPU: 1 UID: 0 PID: 5833 Comm: syz-executor346 Not tainted 6.16.0-rc3-syzkaller-gcce3fee729ee #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:reg_bounds_sanity_check+0x6e6/0xc20 kernel/bpf/verifier.c:2682
Code: 24 20 4c 8b 44 24 60 4c 8b 4c 24 58 41 ff 75 00 53 41 57 55 ff 74 24 38 ff 74 24 70 ff 74 24 40 e8 8f 86 aa ff 48 83 c4 38 90 <0f> 0b 90 90 48 bb 00 00 00 00 00 fc ff df 4d 89 f7 4c 8b 74 24 08
RSP: 0018:ffffc90003f6ec08 EFLAGS: 00010282
RAX: 2c2acf8a45b1bf00 RBX: 0000000000000000 RCX: ffff888029235a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa04 R12: ffff888025056000
R13: ffff888025056020 R14: ffff888025056038 R15: 0000000000000000
FS:  00005555860e1380(0000) GS:ffff888125d4d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000002a1000 CR3: 00000000749a0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reg_set_min_max+0x264/0x300 kernel/bpf/verifier.c:16262
 check_cond_jmp_op+0x159b/0x2910 kernel/bpf/verifier.c:16705
 do_check_insn kernel/bpf/verifier.c:19882 [inline]
 do_check+0x665b/0xe080 kernel/bpf/verifier.c:20017
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
RIP: 0033:0x7f37dffe23a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6bb80468 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fff6bb80648 RCX: 00007f37dffe23a9
RDX: 0000000000000045 RSI: 00002000002a0fb8 RDI: 0000000000000005
RBP: 00007f37e0055610 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff6bb80638 R14: 0000000000000001 R15: 0000000000000001
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

