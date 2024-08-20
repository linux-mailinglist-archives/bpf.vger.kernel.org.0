Return-Path: <bpf+bounces-37640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E571958B75
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C029282CE7
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D519408C;
	Tue, 20 Aug 2024 15:38:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A718193081
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168303; cv=none; b=tYzMr7ZokvbrwZluQUI9Zep4FF+l+U3RUMsbofBeE0VmJdpeZVeXGYj37Lo4kxlxzqjo4JL9ytxos1SgRl+ai8NUQ0c4cPOKGJt3EA8LoqELpBOmDZ2xn9xcluun7KphpVOiRp95iQf01stY24utFyrTVB/4lPhH8slafTVxv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168303; c=relaxed/simple;
	bh=HFninlDYYxWEK0O7pWLELafox3vgaZU9uucGiyRHlg4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sAyy+n1Q7wC7xI2cVd/L1AbadPH0BVyCqaPI3fmtGpgp6yCrejIEGyUQMLDwvw49P28kyiibL66+TLeUyCCKeWv7gAN12I16pMGJkDck1WudcbKyw6xLdvzMAwA6idkjKopVP9NDjEkQio9a8osqke9LdxpA90HcB50YTYbtao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso556445039f.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 08:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724168301; x=1724773101;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmjhxlYv+6k0VIVTkSeuqdNA5u/e9VvDQXfjlhydIwg=;
        b=lU4XWiCJ7rkPBj+kHgI7/K2FeqTBgafcNWs7EL1GQFrEmdL3tPQ7bJ3Mas4xTSYQkt
         6ubFsqtEGsK6BV4qAzTpjoQj8C5hwrmzd47knF1JDz/v0+eKBXZqFCBfhFgZ68Ubv9pL
         y0Q23yPmRZ41YHk4HkP+rQa67vBN6C4B1QD5qw6qtFc6m1GHy427LZpt/cDhr02j32vo
         qbIfdS6GzIER4PwJfBgw09+6oUtWXkK+zM3Lyu62kuUQfRG4o+Aam8NXayFspyWllq3z
         0R+VovU4dmNOaE7DXFUVTa9NFnz8vZAc5zM7mRLSrZ+z+i9HWP2GWWAfFqrZm1hfFw40
         Nhxg==
X-Forwarded-Encrypted: i=1; AJvYcCWlwJJUKHF9Cp8iCjEpO1oxBaQm9kqk90485lbvKjAFHIoih1U9/8yy0pqAOjgW+Ux8rHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhPiKvDrQFcFp4rt74B5DpxbZBJQ6/2TAAFgCnjYqMe+ap2QL
	eXJlvlsVTD7AK+3V+YtD/I3zbmpYgwJwHqVMUx32n6u100LoTBoSqI+hLouj5g7Rp5Hmcg4YAWs
	rbYCPH8B1ty3BksYZdXfsMZr1Lk7lI5zbvlv7TvEukE2WgcEFYH81S4k=
X-Google-Smtp-Source: AGHT+IGiIwzuFWDslcsmkMmsM0MX793o3Xig61GdHTAuWbA0xHEFmnImsSZrEE3/DnjMZSIEi5KB2v5q63VSs0KHWDJGFgxJkzBL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9827:b0:4c2:31f5:3137 with SMTP id
 8926c6da1cb9f-4ce519a18a1mr192043173.0.1724168300836; Tue, 20 Aug 2024
 08:38:20 -0700 (PDT)
Date: Tue, 20 Aug 2024 08:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001acac206201f3799@google.com>
Subject: [syzbot] [bpf?] WARNING: bad unlock balance in search_bpf_extables
From: syzbot <syzbot+474a2013b471c709388f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb1b0acdcd66 Add linux-next specific files for 20240820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=139e8bc5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49406de25a441ccf
dashboard link: https://syzkaller.appspot.com/bug?extid=474a2013b471c709388f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebc2ae824293/disk-bb1b0acd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f62bd0c0e25/vmlinux-bb1b0acd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddf6d0bc053d/bzImage-bb1b0acd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+474a2013b471c709388f@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.11.0-rc4-next-20240820-syzkaller #0 Tainted: G        W         
-------------------------------------
syz.0.777/8282 is trying to release lock (rcu_read_lock) at:
[<ffffffff81a2bae6>] rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
[<ffffffff81a2bae6>] rcu_read_lock include/linux/rcupdate.h:849 [inline]
[<ffffffff81a2bae6>] search_bpf_extables+0x26/0x3f0 kernel/bpf/core.c:788
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.0.777/8282:
 #0: ffffffff8e7f6780 (sched_map-wait-type-override){+.+.}-{2:2}, at: sched_submit_work kernel/sched/core.c:6710 [inline]
 #0: ffffffff8e7f6780 (sched_map-wait-type-override){+.+.}-{2:2}, at: schedule+0x90/0x320 kernel/sched/core.c:6768

stack backtrace:
CPU: 1 UID: 0 PID: 8282 Comm: syz.0.777 Tainted: G        W          6.11.0-rc4-next-20240820-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5202
 __lock_release kernel/locking/lockdep.c:5439 [inline]
 lock_release+0x5cb/0xa30 kernel/locking/lockdep.c:5783
 rcu_lock_release include/linux/rcupdate.h:347 [inline]
 rcu_read_unlock include/linux/rcupdate.h:880 [inline]
 search_bpf_extables+0x39b/0x3f0 kernel/bpf/core.c:797
 fixup_exception+0xaf/0x1cc0 arch/x86/mm/extable.c:320
 kernelmode_fixup_or_oops+0x66/0xf0 arch/x86/mm/fault.c:728
 __bad_area_nosemaphore+0x118/0x770 arch/x86/mm/fault.c:785
 </TASK>
BUG: unable to handle page fault for address: fffff91f94aa1658
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe5067 P4D 23ffe5067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 8282 Comm: syz.0.777 Tainted: G        W          6.11.0-rc4-next-20240820-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 7380:vprintk_emit+0x387/0x7c0
Code: 00 00 00 fa 41 bf 00 02 00 00 be 00 02 00 00 48 21 de 31 ff e8 1a f5 1f 00 49 21 df 75 27 e8 30 f0 1f 00 eb 2a e8 29 f0 1f 00 <48> 8b 5c 24 08 e9 d6 02 00 00 e8 1a f0 1f 00 c6 05 c3 5c 84 13 01
RSP: 3e16:0000000000000000 EFLAGS: 1ffff92001342e48 ORIG_RAX: ffffc90009a17310
RAX: ffffffff8e0428e9 RBX: ffffc90009a17320 RCX: ffffffff8e7d1aa0
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8173d087 R08: 0000000045e0360e R09: ffffffff8c051300
R10: 0000000000000000 R11: 1ffff92001342e3c R12: ffffc90009a172b0
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00005555889b6500(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  7380 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff91f94aa1658 CR3: 000000002f8fc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 </TASK>
Modules linked in:
CR2: fffff91f94aa1658
---[ end trace 0000000000000000 ]---
RIP: 7380:vprintk_emit+0x387/0x7c0
Code: 00 00 00 fa 41 bf 00 02 00 00 be 00 02 00 00 48 21 de 31 ff e8 1a f5 1f 00 49 21 df 75 27 e8 30 f0 1f 00 eb 2a e8 29 f0 1f 00 <48> 8b 5c 24 08 e9 d6 02 00 00 e8 1a f0 1f 00 c6 05 c3 5c 84 13 01
RSP: 3e16:0000000000000000 EFLAGS: 1ffff92001342e48 ORIG_RAX: ffffc90009a17310
RAX: ffffffff8e0428e9 RBX: ffffc90009a17320 RCX: ffffffff8e7d1aa0
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8173d087 R08: 0000000045e0360e R09: ffffffff8c051300
R10: 0000000000000000 R11: 1ffff92001342e3c R12: ffffc90009a172b0
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00005555889b6500(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  7380 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff91f94aa1658 CR3: 000000002f8fc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 fa                	add    %bh,%dl
   4:	41 bf 00 02 00 00    	mov    $0x200,%r15d
   a:	be 00 02 00 00       	mov    $0x200,%esi
   f:	48 21 de             	and    %rbx,%rsi
  12:	31 ff                	xor    %edi,%edi
  14:	e8 1a f5 1f 00       	call   0x1ff533
  19:	49 21 df             	and    %rbx,%r15
  1c:	75 27                	jne    0x45
  1e:	e8 30 f0 1f 00       	call   0x1ff053
  23:	eb 2a                	jmp    0x4f
  25:	e8 29 f0 1f 00       	call   0x1ff053
* 2a:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx <-- trapping instruction
  2f:	e9 d6 02 00 00       	jmp    0x30a
  34:	e8 1a f0 1f 00       	call   0x1ff053
  39:	c6 05 c3 5c 84 13 01 	movb   $0x1,0x13845cc3(%rip)        # 0x13845d03


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

