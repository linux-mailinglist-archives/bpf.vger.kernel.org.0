Return-Path: <bpf+bounces-67522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E8B44ABE
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 02:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F705A4648
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE09156F20;
	Fri,  5 Sep 2025 00:35:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055D11713
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032534; cv=none; b=nxC4qgy6Ecy3KXYywrTK4TdkuIjkqW5t9dDEPuVg+HYRETf5hxsLK8nkXvO8XrVceytISBX6vpWtNbKwc9VK7cT/GkhrTSzALvK9jH6rZXVYvLGaaj+DJw7WEFJ3ni0Md8C080x7BST96Ujuyf+gcagi1NTfRrGX1ryP9hBndXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032534; c=relaxed/simple;
	bh=v/akApDlGGOqK8uAGprvYhO8VvcL9dL5wARhbYq6gIA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EtV0Tzcxdzgjn3leGoiTJPjFh9J7OcqEYJT+e0wc+TCazEp7XZCYpNp2Ien2SM6tfECMwgVLoMzLVboRYXEG9SDaDWCAm7Hesc2102aQcVyNSsi/m1UgMhfNwMEVDi6jAqqt2igd3tb4+Wi3gq639fweXT6iN3oUflB/KDjsL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f12be6bc4aso20656365ab.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 17:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032532; x=1757637332;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQebWqrQS/vuHGoUec1e5AUeo3sRTqvdv3VwkjMGftc=;
        b=jiv/U30F1dFr6gmyGQRX4PnNwMfGcLDNq5kE8WCvuAElkuXEn8rYNPKH1gPGu+gmpr
         HLKJWVoBUJ+QLeK6eVtMg6DLSo5yL0lU2FAB5wkQJkiKmzQyZ8OUn02gXCzpuVdmBvwn
         7yy/AIkvezCbvi5QPpKq3o4jaUCOrrMbYhHkbG+BOmz75d8jrrRn055VDQleHNZzkOi7
         b9lfQy0zNiKDkLc8Abd7sKcSvh6FnZWj7E0MnQ4GSmfH1T5C1uyQJZbEhNCw5sFzW4k2
         +XoLh5CdSC0ftvbg7IsQcmvVeP1BzlswpQk96IhxqXd+rgFjrEirrJiqobiJBrx//xf3
         CKyw==
X-Forwarded-Encrypted: i=1; AJvYcCXFEaCQGhrOHaPV2ic18wwPr+/XC+J7M2I+1BtENOB9Jw/57mPzKt6rWjWS5MK551viTOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsc8gZ+D9tYToBrK/vbaCsG+d8UJ8D8Ntk9q4ul9sVYdDw4Frm
	NjPjtxTq8hBABUjHXeTlyCVLKCuMDAuBOKwq9HHmwKYdykbS53gAIQigNYRLRdz3PJuYRAlfJcm
	NOM2NhSZ/Tzu9BCtaT2ItYZ3Lz8636Axnq6TicgQxzi1g6pgfe0JueSjvUCw=
X-Google-Smtp-Source: AGHT+IHIrHGI0tUZHV17IPfNIAysOGLLEpfXQmFriD7vpN/XuqFjBgj3NoThcKG1jMtsKpE7l+qXl3rwGXDiMwHv9JnQryG2BPFH
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:3ee:3ac4:deed with SMTP id
 e9e14a558f8ab-3f40028afd9mr326177505ab.9.1757032531928; Thu, 04 Sep 2025
 17:35:31 -0700 (PDT)
Date: Thu, 04 Sep 2025 17:35:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ba3053.a00a0220.eb3d.000d.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_check (5)
From: syzbot <syzbot+27689b73d9cffb8c6bca@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10dc087c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=27689b73d9cffb8c6bca
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16342134580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e75a42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27689b73d9cffb8c6bca@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: not inlined functions bpf_perf_event_read#22 is missing func(1)
WARNING: CPU: 1 PID: 6725 at kernel/bpf/verifier.c:22840 do_misc_fixups kernel/bpf/verifier.c:22838 [inline]
WARNING: CPU: 1 PID: 6725 at kernel/bpf/verifier.c:22840 bpf_check+0x1559c/0x15d8c kernel/bpf/verifier.c:24742
Modules linked in:
CPU: 1 UID: 0 PID: 6725 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : do_misc_fixups kernel/bpf/verifier.c:22838 [inline]
pc : bpf_check+0x1559c/0x15d8c kernel/bpf/verifier.c:24742
lr : do_misc_fixups kernel/bpf/verifier.c:22838 [inline]
lr : bpf_check+0x1559c/0x15d8c kernel/bpf/verifier.c:24742
sp : ffff8000a7e87480
x29: ffff8000a7e87980 x28: dfff800000000000 x27: 0000000000000006
x26: 1ffff00012f83c13 x25: ffff800097c1e09c x24: ffff0000c8050008
x23: ffff800097c1e098 x22: ffff80008b142d60 x21: ffff800092df4000
x20: ffff800097c1e09c x19: 1ffff00012f83c13 x18: 1fffe000337a0688
x17: ffff80008f7be000 x16: ffff80008b007230 x15: 0000000000000001
x14: 1fffe000337a3108 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337a3109 x10: 0000000000000003 x9 : 962cacbf6519a100
x8 : 962cacbf6519a100 x7 : ffff800080491074 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000010
x2 : ffff8000a7e87040 x1 : ffff80008b6577c0 x0 : 0000000000000001
Call trace:
 do_misc_fixups kernel/bpf/verifier.c:22838 [inline] (P)
 bpf_check+0x1559c/0x15d8c kernel/bpf/verifier.c:24742 (P)
 bpf_prog_load+0xec8/0x13fc kernel/bpf/syscall.c:2979
 __sys_bpf+0x450/0x628 kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:6137
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 1566
hardirqs last  enabled at (1565): [<ffff800080491108>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1531 [inline]
hardirqs last  enabled at (1565): [<ffff800080491108>] finish_lock_switch+0xb0/0x1c0 kernel/sched/core.c:5105
hardirqs last disabled at (1566): [<ffff80008b001bfc>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (1274): [<ffff80008080b8c4>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (1274): [<ffff80008080b8c4>] bpf_map_alloc_id+0x98/0x1a8 kernel/bpf/syscall.c:451
softirqs last disabled at (1270): [<ffff80008080b864>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (1270): [<ffff80008080b864>] bpf_map_alloc_id+0x38/0x1a8 kernel/bpf/syscall.c:447
---[ end trace 0000000000000000 ]---


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

