Return-Path: <bpf+bounces-66692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A31B38828
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EEA188CC0F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8570B2E888F;
	Wed, 27 Aug 2025 17:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE7166F1A
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314036; cv=none; b=Q9yPrWQ8SWSsSWpcLDby7w47R7A6E/Z537jdS5WF1rJ9xlbLBbhMX7+3YqmnZ0zTDqRshaL6TsSuJCazHKZTgc0ecFEeVvDF10QHcikmPllmWJrz+fzr2DI6HkkPlaOaMIc44gXwyxYz2FUyZ+rZs/vDO95x7gXPiZgR4q7ZFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314036; c=relaxed/simple;
	bh=ecbNrh3gAkHhs0nqu+5SPQJJyt95NCljejpX4+7MoQQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P0xdihA7m97ByDKxPz8Qpakw3cz1YQz2uFjWg7cNM6u9jSVnC4g8744OCuAvHwOWfVKZAJQtMG2fAcQ1MI2ouqogatBPUFgZR8zQQsuX4WkmC3dSrmqeRKyTJJwRXXc7xetPawT0ubZda8znliOM9EE4Z8PPa8VgVotacROGL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-886ff73eacbso19736939f.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 10:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756314034; x=1756918834;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybv4LIIvMAT3Eoq2aTEAvOM1ieIsoRgZnCI/tNEIGZ8=;
        b=k52CkZSf6JYK807/+dGubjAXpkQ4ppLR31/fFcy4EO33//If4A78sAb/kXZe3zABPP
         OQC866ORvg0wG8qs3l1NYG2ZBAvWol9zevAFGfqbZmrfd0LCRfMs4++T3GfqKzVKCtEW
         lC7ynPex5xju1sEOTj9sJ2HQRAsOLu4xQPUBQpeY57XuYEMxDSOtiCdmui2VMMuXXH1M
         h1dYmwQ7SSo5eV5TTdVwgB8ZxMnHDrIV2/+A59IqQZlUIywXoKTPaU4Mx0PGvTu0gVYB
         MsAKYjuM4pmKQGmSrOIpZ86G+KuQT8seA2+hLRCK30XOHUJR1tQa3Jzu23811fFYHF+d
         favQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1P3lZv6WIq4d0T5d0rXMGtORJATvYg9hWiDLzbgJh5RfX/5DEwO1RGoNwGmE93dnJKqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IJyARab9lza/CYCYxJsYo3ftTYK885B2KnTe2bRhF85nQUyA
	w6umCIAEsKdTMqk3DqyDJB5ZbIJVk0amJYlrES3/FBqy9OUKGvfcAbiqtZwIcO3vrukJI9xqJYF
	sHKDHCWRq4vNDBrW9TXyCq8kvBUhN92fVLv7Qh+7c3tuHIN3N1mk7l0XubE4=
X-Google-Smtp-Source: AGHT+IFTaM5B1uw90IYiFhY0ljaYzaOpTyCWJM1NuXIMJUat2baLWHnMrfLCCBb9RyBrFEjcFv5sBCvdXLNx++WR308rFmyDrKXU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:3e5:4b2e:3afd with SMTP id
 e9e14a558f8ab-3e9201fcc4amr275163535ab.8.1756314030129; Wed, 27 Aug 2025
 10:00:30 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af39ae.a70a0220.3cafd4.002c.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] WARNING: ODEBUG bug in handle_softirqs
From: syzbot <syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4774cfe3543a Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140f4e82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a936e3316f9e2dc
dashboard link: https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/202021f78569/disk-4774cfe3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/694d0f540b2c/vmlinux-4774cfe3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3c1a8d42953/bzImage-4774cfe3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888055e82a78 object type: timer_list hint: br_ip6_multicast_port_query_expired+0x0/0x20 net/bridge/br_multicast.c:1682
WARNING: CPU: 0 PID: 15 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.16.0-rc1-syzkaller-00203-g4774cfe3543a #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 17 37 5c fd 4d 8b 0f 48 c7 c7 a0 90 e2 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 4a 6a bc fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 77 9d d9 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0000:ffffc90000147758 EFLAGS: 00010282
RAX: bfb6a7e7ba7ad600 RBX: dffffc0000000000 RCX: ffff88801cef3c00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa9e4 R12: ffffffff8a423ca0
R13: ffffffff8be29220 R14: ffff888055e82a78 R15: ffffffff8b8ce020
FS:  0000000000000000(0000) GS:ffff888125c52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8371b71d60 CR3: 000000005b468000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x3a2/0x470 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2312 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x112/0x440 mm/slub.c:4842
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

