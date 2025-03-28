Return-Path: <bpf+bounces-54858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E816A74CD6
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 15:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257183A32AC
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5BD16BE3A;
	Fri, 28 Mar 2025 14:36:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB454409
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172587; cv=none; b=c/DZbREzLZCTQbE7RcgC9lIShzu+9E60HVd1aYM27ZJkB2gb/p2VfV29K1entxpGMPEeoCymX5RurEzPomuSGIvzEqJF9DDmwZq8zpSCE9GlFOH4uvVoNTverAm+TZGKvBgF30rbGnFYVD4JLpsnvAn3/Jaaq7fcU7FaY3rcOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172587; c=relaxed/simple;
	bh=EIIXHC2NFxPgg+Io+V7H8btYXcc7XcyxKpZgvWq7J74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eTS3IHS2ZOAlgxNtlZtFwRa3oJineDmNBNik0WD9hjeHeSOj4bGPDPTCuxjxJvHpTjY0D4q1Bqe2jgwqmCgxBHPbMHmhuGLIKqg7DJOUPtaUGGi1UYyBjaIQDrwOjWEnMimVhkjXJk74huAjC/0fTVDCRBmSWqlElQcBFNwehYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so24357835ab.1
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 07:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172584; x=1743777384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIKm42TvSRdzaWbLuv0fqXDtXO3rt9pAWpr+K+s9Bgo=;
        b=eKwZbqPdalyDy/nThmqRIL3G1NtBZ/dw94g8JzMtIPL7UJZA4iYVPA8pZ4BY+JzHaw
         Q/tvzoJ1WBGwJTbvYGu+1rkK3FJvpkKJsWnet21FhOeerQIGT31SsUT1aL0+C4kEN91X
         X8m9j+ofQG4z9DBrJ/bZrsC0FD8JMfyCfyys3SFwb/GH4AuxKh2I3iznTX/Qd3xDbLis
         eViBz19ki8Mjd56VDCHHvdUjG9zmbYrAyle7I/AiKWeG1UbOEPBFhUIPYj7to53n4ck5
         x30Ee7vF+T/btIfz50pgxqMlUnJcYXFpF1R/L3DNHW/dbVboRgnnaZlFLNAPo4JCB49p
         v2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUPF4l4pAjHPMQ9goTFLOEX3DA1hOv1UTHrWyu22zwJ7ravpgpR+HkA5kCTrAREL73gxKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANFiBF0boLLb9Nu/bptDZbGcyvr0EPp+YsCB9wuqG68n9nCmh
	GpNXEGP763XsS5xS7rhOvp05uCP2dme10Rnl7fLxLzK1aYrk2FFxc34cRtB99Bs0UxYY46Yz3Xs
	RxC3/W/wDfWdswzwrdwwbNKc+ArT42HnsJnLZ3GnM47aMXjtlQs9d3+o=
X-Google-Smtp-Source: AGHT+IGHAEccSOxt8fWz6pI0JI6sGDM3SpkJZPNXoGrHh7NiZL+Oqz4D0Lj8cYPB4yPgmIKBg2NbRvhjRjyk8dBgsmsKWwZ8CY3Z
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c8a:b0:3d3:f64a:38b9 with SMTP id
 e9e14a558f8ab-3d5cce18ccdmr84586275ab.15.1743172584404; Fri, 28 Mar 2025
 07:36:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 07:36:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6b3e8.050a0220.2f068f.0079.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in dev_xdp_install
From: syzbot <syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17989bb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d48017cf0c2458bf
dashboard link: https://syzkaller.appspot.com/bug?extid=08936936fe8132f91f1a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0795c9a2c8ce/disk-1a9239bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfe4e652ed32/vmlinux-1a9239bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34deb7756b26/bzImage-1a9239bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8456 at ./include/net/netdev_lock.h:54 netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
WARNING: CPU: 1 PID: 8456 at ./include/net/netdev_lock.h:54 dev_xdp_install+0x610/0x9b0 net/core/dev.c:9911
Modules linked in:
CPU: 1 UID: 0 PID: 8456 Comm: syz.5.847 Not tainted 6.14.0-syzkaller-05877-g1a9239bb4253 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
RIP: 0010:dev_xdp_install+0x610/0x9b0 net/core/dev.c:9911
Code: 8d bc 24 28 0d 00 00 be ff ff ff ff e8 69 c5 26 02 31 ff 89 c5 89 c6 e8 0e af 81 f8 85 ed 0f 85 59 fb ff ff e8 d1 b3 81 f8 90 <0f> 0b 90 e9 4b fb ff ff e8 c3 b3 81 f8 49 8d bc 24 28 0d 00 00 be
RSP: 0018:ffffc9001f13f950 EFLAGS: 00010287
RAX: 000000000000023c RBX: ffff888059e8ccbd RCX: ffffc9000da1b000
RDX: 0000000000080000 RSI: ffffffff89395ebf RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888059e8c000
R13: ffffffff870484d0 R14: ffffc9000ec3f000 R15: 0000000000000001
FS:  00007f6e99bf66c0(0000) GS:ffff888124b41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2f3eb0 CR3: 000000007f4ec000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 dev_xdp_attach+0x6d1/0x16a0 net/core/dev.c:10094
 dev_xdp_attach_link net/core/dev.c:10113 [inline]
 bpf_xdp_link_attach+0x2c5/0x680 net/core/dev.c:10287
 link_create kernel/bpf/syscall.c:5379 [inline]
 __sys_bpf+0x1bc7/0x4c80 kernel/bpf/syscall.c:5865
 __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5900
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e9bd8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e99bf6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f6e9bfa5fa0 RCX: 00007f6e9bd8d169
RDX: 0000000000000040 RSI: 0000200000000000 RDI: 000000000000001c
RBP: 00007f6e9be0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6e9bfa5fa0 R15: 00007fff0d50ed58
 </TASK>


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

