Return-Path: <bpf+bounces-60136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D79AD2F63
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3044E1893E1D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CDD280019;
	Tue, 10 Jun 2025 08:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9043AA4
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542500; cv=none; b=S2Q6EJN/AesUsnfHy9z2jwGxLpG1ZYZdU3R51iLdUvPAlUzPq/6DZaNPlwDylzH66O7+BfrY1ynK+dCGxDWtbqhZI3cZ7DmOep8z9vJ8WNtGoKa5HBbEBg9TDtOPOKfCra+wqMt97JNsBgxykWWz5ctcUbTK6+cGqUBoMTZb+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542500; c=relaxed/simple;
	bh=wJUWElaP7lcT2sBOjoZLQjZYb5cvIapVOResVZ3CSbw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dtsl7oCuyGlXNFrgFwPLDY5LdaiwW/H9XQrvfR/oAwo973jEN3pJzU37oIodWy0ZDOop4Lo4Eidp2lYfookw0vriaPSCCD1IB9sdZGGEiEkTJB2BiW7NZMfHWuuzBbvKSVhxJhxfXToZf8EXobd3DzjykYQToT7ER7lJywzkZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so551264739f.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 01:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749542497; x=1750147297;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DdGHycmsqX2oM/bFsngL53fYf5TvlLXbFnupxabLvU=;
        b=RPItyVwKxqEDFCTSscyxizrNJXiC5Jovb2vi9ivQWqcckNbUa+1AyBSO6/WL+jsUNp
         tLlCHdblAHxo6u0iAz9zATLR1X7btWfsOGExqCct7s1Rc86Khm0l7FLzQEljeaybY3q4
         b8Z2mN1uDw9SILoNXLjA3KvmlVxXgeWuYoBy1HEnSO5lA3NL5k6trAqN5Hxuwxvoltj1
         3ka2AayLSN/+YGEvIS0tJvSE6w6ysaxm4pkhYje52cPYZUjaWPuwD7DfS3P9YanH30mF
         ubUqDFb+Vpvef2AVlVz0vqsUhGzpT+ruEA+/3m4SFwkRSxIxDui5U64EWPLJkEKEu3xa
         kKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0udD1dbMu+8u3xhjhHCITlBGINUBpEuo8AOchXWn2aSTtBJ8IofuoPxQb4SLdx+Zn9Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3IkEx7oio291FU8SZai04FCFqy0KES8rB+9515vA+SLnAv/0
	IsHPN97Ss3SUpefCCQ7+SzEgrCw1bPg7Z0JAIM5ueJ6AKs8Yc5mxceRNguZvWvEpdM4gHvu3S3u
	NJ3QJ2kvLBEHzJIKuNeNifOift3/l1iXDBUKm1dXmnibFYyx/cOBkgjjBQd4=
X-Google-Smtp-Source: AGHT+IEAATIAcqcJMSi8e+TuBwUZV5pMG4We3cX3hfAJEhvZTLo0+1YiBeVNSclSnNkuKGZ6GpSxW4RHo0rVoku3PQ8dlCgtOVm0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3dd:b569:6448 with SMTP id
 e9e14a558f8ab-3ddce3e4cd3mr184401605ab.6.1749542497583; Tue, 10 Jun 2025
 01:01:37 -0700 (PDT)
Date: Tue, 10 Jun 2025 01:01:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6847e661.a70a0220.27c366.005d.GAE@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free
From: syzbot <syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    19272b37aa4f Linux 6.16-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101f5a0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f437300db311c188
dashboard link: https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab33a6ff9377/disk-19272b37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5cfaf818a35/vmlinux-19272b37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/186f6b167a3a/bzImage-19272b37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free

write to 0xffff8881042a62e8 of 4 bytes by task 22653 on cpu 0:
 __local_list_add_pending kernel/bpf/bpf_lru_list.c:358 [inline]
 bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:457 [inline]
 bpf_lru_pop_free+0xbd4/0xcb0 kernel/bpf/bpf_lru_list.c:504
 prealloc_lru_pop kernel/bpf/hashtab.c:303 [inline]
 __htab_lru_percpu_map_update_elem+0xea/0x600 kernel/bpf/hashtab.c:1349
 bpf_percpu_hash_update+0x61/0xa0 kernel/bpf/hashtab.c:2408
 bpf_map_update_value+0x297/0x3a0 kernel/bpf/syscall.c:266
 generic_map_update_batch+0x3f5/0x540 kernel/bpf/syscall.c:1982
 bpf_map_do_batch+0x255/0x380 kernel/bpf/syscall.c:5344
 __sys_bpf+0x2e0/0x790 kernel/bpf/syscall.c:-1
 __do_sys_bpf kernel/bpf/syscall.c:5943 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:5941
 x64_sys_call+0x2478/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881042a62e8 of 4 bytes by task 22637 on cpu 1:
 lookup_nulls_elem_raw kernel/bpf/hashtab.c:643 [inline]
 __htab_map_lookup_elem+0xab/0x150 kernel/bpf/hashtab.c:673
 htab_lru_percpu_map_lookup_elem+0x20/0xb0 kernel/bpf/hashtab.c:2342
 bpf_prog_1592a6279ab44e8a+0x48/0x50
 bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2258 [inline]
 bpf_trace_run2+0x107/0x1c0 kernel/trace/bpf_trace.c:2299
 __traceiter_kfree+0x2e/0x50 include/trace/events/kmem.h:94
 __do_trace_kfree include/trace/events/kmem.h:94 [inline]
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x27b/0x320 mm/slub.c:4829
 ___sys_recvmsg+0x135/0x370 net/socket.c:2829
 do_recvmmsg+0x1ef/0x540 net/socket.c:2923
 __sys_recvmmsg net/socket.c:2997 [inline]
 __do_sys_recvmmsg net/socket.c:3020 [inline]
 __se_sys_recvmmsg net/socket.c:3013 [inline]
 __x64_sys_recvmmsg+0xe5/0x170 net/socket.c:3013
 x64_sys_call+0x1c6a/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x3dd8f34f -> 0x7cc9e3a7

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22637 Comm: syz.3.6512 Tainted: G        W           6.16.0-rc1-syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
==================================================================


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

