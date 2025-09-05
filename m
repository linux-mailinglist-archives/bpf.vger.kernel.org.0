Return-Path: <bpf+bounces-67555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E3B4567A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A3BA4304A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92F343D94;
	Fri,  5 Sep 2025 11:36:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C432F74D
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072192; cv=none; b=raBbBGqsniI+DYUmp4/TQO9rsJWUF+Q9hO5Om6gv5y6xO1kVGTK5GiGhn1RIWA2q7T/RUeDHaGoioNtmQIh4end2Ugd5JAjVwPx/FYS9KMv6uPoXxEfFvo5xyxAvMpTjcp7RZVD25S5bsq0DYQwIiDFNz6L35hh4kccVGlX95IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072192; c=relaxed/simple;
	bh=8/dYZPFAHybuwIngK/1nU7f4XK6RdJpQZBAPZYPrpxE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FBBd2IfugBNRJOmnXYYXh03vmtENOc9CHUX2gH6l4RPpQj1s1oLtN70VkGphUOHJF0IQjP06ZR+k4/gFPwjEqKMis+21SdzIyzv1Mq4mv0BNS1sTjUw9XZsvObS7eTUdthKX7/DE3x86G22D33/0uxFz94oy9mbLw0vtGRdXuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-886e347d26bso269638439f.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 04:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757072190; x=1757676990;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFiapAlrVHEQy2ivlKZ2LIVGEEf3WqTkF83SAR07AWU=;
        b=nHnDe5GL5WsdOz7CEtwM3IREnTsIJmvoUhThJ+n0XxLcydtuSHKRY19O+x4v3KSVT/
         Uoxb+rKAbZNiHrQv2+Sv0qXEx1PPdMv2VmJt7IUG4506DSwHV9JsbYbBK+BWaQavj8C2
         +mBNWnCIreXxttNguWMEN50X5fjzseUuZ8EDFGGBB5scsEPCdyHJL0B+jhFKVEeGAAv7
         vxAHzvrkS/h3dLsBtiMmlnpM6JyvRQ6qCYdupBkvNFjOOBZDC9qyfgzOimcjizf8UxiP
         /MshLFNaLtaOGyhFQ4q55tIr0SWGldL6V3Kj86tltfgSVeoYI611kMoFqsXRLzrHDevV
         DU0A==
X-Forwarded-Encrypted: i=1; AJvYcCWcsrhc0IfnDmdSlnTADYPpxH56piU59nPMdaPMYGJ/AX6H4Xfg8xVdZm3fsDgyOzgrEyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfB/mPkbLBvvZOBzKpGp/V/p1ziI/Lo08eXvDJfiHRJ6LZLRw1
	CVQCjVSZPFRqkoeS4okcxypB2LhfI5z4fCaRH3ODgm3HlceyGBwMzmNsfRF/uWbKq3cbcUKgjiC
	mt8GS0X1ITYX+CS7w2QuyH1tS33RhNhWUyy1yrpxUwUQyvH0ah+RIK/VvV28=
X-Google-Smtp-Source: AGHT+IHPw2UB4fSfIlURlt6brlCyV+QXzn0gvGLGb5d3QyYaPVyypZI7dq7K13QFQX5Mdtt1o7PCdqgExZ0TGrmhvRWI8Hl0p9Tm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:ed0a:0:b0:884:125c:6949 with SMTP id
 ca18e2360f4ac-88767ea9954mr426814039f.7.1757072190194; Fri, 05 Sep 2025
 04:36:30 -0700 (PDT)
Date: Fri, 05 Sep 2025 04:36:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bacb3e.050a0220.192772.018d.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b2c962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15921962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157da134580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1514db72e485/disk-d69eb204.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d9a4986a33d/vmlinux-d69eb204.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4182b32d3ada/bzImage-d69eb204.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com

verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xfffffffefffff630, 0xffffffff00000000] s64=[0xfffffffefffff630, 0xffffffff00000000] u32=[0x30, 0x8000050] s32=[0x30, 0x0] var_off=(0xfffffffe00000030, 0x10fffffc0)(1)
WARNING: CPU: 0 PID: 6017 at kernel/bpf/verifier.c:2722 reg_bounds_sanity_check+0x62b/0x1200 kernel/bpf/verifier.c:2722
Modules linked in:
CPU: 0 UID: 0 PID: 6017 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:reg_bounds_sanity_check+0x62b/0x1200 kernel/bpf/verifier.c:2722
Code: 45 ac 50 8b 45 b0 50 8b 45 b4 50 ff 75 b8 4c 8b 4d c0 4c 8b 45 c8 48 8b 95 58 ff ff ff 48 8b b5 60 ff ff ff e8 96 76 aa ff 90 <0f> 0b 90 90 48 8b 95 40 ff ff ff 48 83 c4 38 48 b8 00 00 00 00 00
RSP: 0018:ffffc900040272f8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: fffffffefffff630 RCX: ffffffff817a3388
RDX: ffff88807c9d4880 RSI: ffffffff817a3395 RDI: 0000000000000001
RBP: ffffc900040273f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807b5b8000
R13: ffff8880771591bc R14: ffff8880771591b4 R15: ffff888077159168
FS:  0000555583a7e500(0000) GS:ffff8881246b6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb2ddc7dac CR3: 0000000077c90000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 reg_set_min_max kernel/bpf/verifier.c:16336 [inline]
 reg_set_min_max+0x1dc/0x2c0 kernel/bpf/verifier.c:16308
 check_cond_jmp_op+0x19b0/0x72d0 kernel/bpf/verifier.c:16768
 do_check_insn kernel/bpf/verifier.c:19956 [inline]
 do_check kernel/bpf/verifier.c:20093 [inline]
 do_check_common+0xa13e/0xb410 kernel/bpf/verifier.c:23260
 do_check_main kernel/bpf/verifier.c:23343 [inline]
 bpf_check+0x869f/0xc670 kernel/bpf/verifier.c:24703
 bpf_prog_load+0xe41/0x2490 kernel/bpf/syscall.c:2979
 __sys_bpf+0x4a3f/0x4de0 kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb2db8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf04b3dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fcb2ddc5fa0 RCX: 00007fcb2db8ebe9
RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
RBP: 00007fcb2dc11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcb2ddc5fa0 R14: 00007fcb2ddc5fa0 R15: 0000000000000003
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

