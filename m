Return-Path: <bpf+bounces-68417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9CB58493
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F091AA62F7
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71442E7BDA;
	Mon, 15 Sep 2025 18:28:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A22E8B90
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960912; cv=none; b=iUUyQcIbvA6Kx/JTRmoeDvicM0v+Ys1dKlkER+N4OyRqmwm4iVXIqAJE/P0u4qkv4IXJLdvNv/IsaYk2qPcrCrXdPasAgwlLWhPwaINBIG4RTXMksf1CAtl/WA+kwXQ0WzECIHSAyVf2Yzq66CIS185YwU7k51RhL1UFp5pxjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960912; c=relaxed/simple;
	bh=OL/0GKGewZF8kny8NXnh48JPLxV/0tjnh4Gpf7JLJi4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mRv3ha/NpM8UTSVw+Ccawu2EOwKApRbW/lgl7gzkxxLsIJ2uewWS+0fVJhI0UoPQWNcFnTk/eBOrZLZ/HQjnkXH0jP+Hwg9vGvvt996D90pXmKzbg7VIG0Snbx/irdcPe7stOSaVQYv63YC0G5Bd9BE+PKIeraaXLus22HWqO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-887777bd720so513326739f.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 11:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960910; x=1758565710;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5prtZSnPNFgkoL+HuvQB6GO4JGzUJWAuc41w9I8/Hk=;
        b=OpFWomWIzlEZAhsTuILYzRh+HYmqLEeq+S92zxpeJ4qZg6b8OXGsSrIqVBHTrT68BP
         rK2n03AC6F5NHas1CCTp+6HIpEV27ZPW/tvUWkaOI9PyEjJddnGPgOLEI56zllchmmkO
         RsFkMbEm/T4wrGanoF6pSZqvmSFJiNtfTLaKO/gI4wBN6F9yoQZvxlwcBLvi5E109QOR
         KuIyOIazy6AXfSI72hHfPk1CjgMzY21hLZkmo3K9had0z2ssIIppRQpumshhslCMNDBg
         jAp+SqxoybEoOYlOyMjlVXjuqzjFpNGQfHNJRg/Kv56wpoyljbpRvEXwucqvEA5MRIRZ
         n7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGPPadC1BQhPUUbFexdyyyvJgUS363Fj9kqEez/iaM+uye5ClsVOS4UNAVUadGQmNTNt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Qvovb5Tth+KJbt6eLey0O8dIYW+FCjauUGJ5CHSXNjH/47o0
	16WUVGXFGArg5ifU4D22zaX+dSpXT+FZMWaLAKcRRxumuMRL3Keqevi8wi6cZEumBVYh9Y5SpdB
	BobHogjIF1i5u20mS0nhKxW+VEz1v7fvmYE0xsULvWQW35I1hi8sB+Y75QF8=
X-Google-Smtp-Source: AGHT+IGEy/vfndE98rKOCai91YrvFiLwU0hLRS+adWf/d8RcSGMwyM+c8tJt8/GN4rWNGGMUXpCvpV2ysM43tIO7jsswlFUjjBuC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:424:b2c:a780 with SMTP id
 e9e14a558f8ab-4240b2caa21mr18286065ab.1.1757960909965; Mon, 15 Sep 2025
 11:28:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137d0e42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3afc814e8df1af64b653
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a947c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14467b62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be9b26c66bc1/disk-f83ec76b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53dc5627e608/vmlinux-f83ec76b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/398506a67fd8/bzImage-f83ec76b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: scc exit: no visit info for call chain (1)(1)
WARNING: CPU: 1 PID: 6013 at kernel/bpf/verifier.c:1949 maybe_exit_scc+0x768/0x8d0 kernel/bpf/verifier.c:1949
Modules linked in:
CPU: 1 UID: 0 PID: 6013 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:maybe_exit_scc+0x768/0x8d0 kernel/bpf/verifier.c:1949
Code: ff ff e8 cb 8e e7 ff c6 05 0a b5 bf 0e 01 90 48 89 ee 48 89 df e8 f8 41 fb ff 48 c7 c7 a0 9b b5 8b 48 89 c6 e8 59 33 a6 ff 90 <0f> 0b 90 90 e9 4e ff ff ff e8 0a ee 4d 00 e9 7f f9 ff ff 4c 8b 4c
RSP: 0018:ffffc900041bf500 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888079840000 RCX: ffffffff817a4388
RDX: ffff88807d3f8000 RSI: ffffffff817a4395 RDI: 0000000000000001
RBP: ffff888079846328 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff92000837ea7
R13: 0000000000000000 R14: ffff88805cf87400 R15: dffffc0000000000
FS:  000055557c9b5500(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557c9b5808 CR3: 0000000073b4d000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 update_branch_counts kernel/bpf/verifier.c:2040 [inline]
 do_check kernel/bpf/verifier.c:20135 [inline]
 do_check_common+0x20cc/0xb410 kernel/bpf/verifier.c:23264
 do_check_main kernel/bpf/verifier.c:23347 [inline]
 bpf_check+0x869f/0xc670 kernel/bpf/verifier.c:24707
 bpf_prog_load+0xe41/0x2490 kernel/bpf/syscall.c:2979
 __sys_bpf+0x4a3f/0x4de0 kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1d078eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee0400aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fd1d09d5fa0 RCX: 00007fd1d078eba9
RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
RBP: 00007fd1d0811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd1d09d5fa0 R14: 00007fd1d09d5fa0 R15: 0000000000000003
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

