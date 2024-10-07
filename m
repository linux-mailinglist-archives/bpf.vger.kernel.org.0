Return-Path: <bpf+bounces-41075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E69923DE
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538C51C2219F
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 05:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA0136672;
	Mon,  7 Oct 2024 05:24:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABE4C91
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278663; cv=none; b=kXn47kinKzZbvk2Lm9Mn2I5XofWyK3FRM133IJs6BZhkovIAH6tFrT1Kh+8NHPh0NBr992oTpUl4NlnuU/a17XieOWMWUenPClAPRN5TejCDdRrmBssypY7b1eXD+3etD8sDiG++6FBJGFHxEq/YCXbRy6Rn3clfV65gVno4Gpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278663; c=relaxed/simple;
	bh=BfXqHwKacYlyfKlsyU5jxlqJhyB67gpoXh95UTrlHNM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VNRjm+cFFjpA4ickkzwxR0ZRmdF6vyuoXy1tJc2w+7AHojC8u6C+GGfoYZT3g/1CdNGz0+vrSBuWeyEyqn6BzfYGGGyvPFopITTvqZVDr4zqxgbrgIq9PYRtdTCIAN/2YMp+69m3OckcwWcgNJKGewWN/Ad8wv5LFKo45GmnUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so45311315ab.0
        for <bpf@vger.kernel.org>; Sun, 06 Oct 2024 22:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728278661; x=1728883461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AIRQPHTgvdZ7jAuuFNBy85i0UfMXrmiIvbDH4nGzBI=;
        b=it9oaSHCMq4mSx0OHcKobAo00S5NmxjCGjkeBniEbtwhSw9YDmTgpkcT9BukHeuNJf
         kt/DtZ9EsNAbLnINZCJL4R5uNhUWqLCZpNNO/Ms4e4lOiJ6BvT30kcP4ONjnNev22SOB
         cf952vhZce1brcBtgazrmHC24RkxrjQEz3wZ1EqCNFubv2XkrNZLPakZZaJ3dMA8f2vZ
         ITgUXNOnlL4RtaWJfptK7YQ7spJQZbbwz+XFCSu36O3vUvsRp0YuF5uvQdlaXSufi1yW
         HlrTE4AppbxkJAmm8lW/+p1w7ZEQk/FNWoLp0gKMnDLnECsH5EHSCyUQkEMa+Xv9IxGn
         M7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWh7s4GeXKfEy3cKvF3kTSXo9JoGI2QU1GC692M2iwHbRo1qTObS8GLwoiwhvVNckolGxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1Zj+9toSwYLKxVMWn2xOYmNCjShmGEgvfDUuaw7BqTe467bu
	Lvp1kyKg57vTnnRcBoW6bWlyHLQ74YMUz/yrmNF4tBTYhG6wBZLl1SwogENbMbroBLY4cLLDo1J
	HP8UojwDQZWCFnudknDy4HH9YFv9+QGxPKyQhUdGvRTZMX85O+1oHbzY=
X-Google-Smtp-Source: AGHT+IF247V/nCJeF+xQvJQ+DDdGbioA32XPXJjCoMMHg41yI54GWh5WH0vmKJqok4i79rtevGel8jfCW0kQQzzUuKXf/PEH5nEK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:3a0:8e7c:b4ae with SMTP id
 e9e14a558f8ab-3a375c3b6f5mr74743345ab.2.1728278661144; Sun, 06 Oct 2024
 22:24:21 -0700 (PDT)
Date: Sun, 06 Oct 2024 22:24:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67037085.050a0220.49194.04fa.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in acquire_reference_state
From: syzbot <syzbot+b2f95ad40a2119295cc1@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, cl@linux.com, daniel@iogearbox.net, 
	eddyz87@gmail.com, feng.tang@intel.com, haoluo@google.com, 
	iamjoonsoo.kim@lge.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	martin.lau@linux.dev, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1113e307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=b2f95ad40a2119295cc1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bc33d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11772b9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz

The issue was bisected to:

commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
Author: Feng Tang <feng.tang@intel.com>
Date:   Wed Sep 11 06:45:34 2024 +0000

    mm/slub: Improve redzone check and zeroing for krealloc()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15191307980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17191307980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13191307980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2f95ad40a2119295cc1@syzkaller.appspotmail.com
Fixes: d0a38fad51cc ("mm/slub: Improve redzone check and zeroing for krealloc()")

------------[ cut here ]------------
virt_to_cache: Object is not a Slab page!
WARNING: CPU: 0 PID: 5236 at mm/slub.c:4655 virt_to_cache mm/slub.c:4655 [inline]
WARNING: CPU: 0 PID: 5236 at mm/slub.c:4655 __do_krealloc mm/slub.c:4753 [inline]
WARNING: CPU: 0 PID: 5236 at mm/slub.c:4655 krealloc_noprof+0x1b3/0x2e0 mm/slub.c:4838
Modules linked in:
CPU: 0 UID: 0 PID: 5236 Comm: syz-executor185 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:virt_to_cache mm/slub.c:4655 [inline]
RIP: 0010:__do_krealloc mm/slub.c:4753 [inline]
RIP: 0010:krealloc_noprof+0x1b3/0x2e0 mm/slub.c:4838
Code: 45 31 ff 45 31 f6 45 31 ed e9 21 ff ff ff c6 05 4e 2a 14 0e 01 90 48 c7 c7 24 f2 0b 8e 48 c7 c6 44 f2 0b 8e e8 3e 19 63 ff 90 <0f> 0b 90 90 e9 d9 fe ff ff f3 0f 1e fa 41 8b 45 08 f7 d0 a8 88 0f
RSP: 0018:ffffc900039ce958 EFLAGS: 00010246
RAX: d5f86d2e4537eb00 RBX: 0000000000000000 RCX: ffff88802bd81e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880276c0000 R08: ffffffff8155d412 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: 0000000000004000
R13: 00000000000002ac R14: 0000000000000cc0 R15: 00000000000002ac
FS:  000055555e044380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005564fc7f1000 CR3: 0000000079940000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 realloc_array kernel/bpf/verifier.c:1247 [inline]
 resize_reference_state kernel/bpf/verifier.c:1287 [inline]
 acquire_reference_state+0x136/0x460 kernel/bpf/verifier.c:1334
 check_helper_call+0x65cc/0x7660 kernel/bpf/verifier.c:10897
 do_check+0x9954/0xfe40 kernel/bpf/verifier.c:18529
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:21618
 do_check_main kernel/bpf/verifier.c:21709 [inline]
 bpf_check+0x18a25/0x1e320 kernel/bpf/verifier.c:22421
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2846
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5634
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f922052d669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc58143c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffc58143e08 RCX: 00007f922052d669
RDX: 0000000000000090 RSI: 0000000020000840 RDI: 0000000000000005
RBP: 00007f92205a0610 R08: 00007ffc58143e08 R09: 00007ffc58143e08
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc58143df8 R14: 0000000000000001 R15: 0000000000000001
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

