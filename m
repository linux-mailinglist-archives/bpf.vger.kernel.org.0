Return-Path: <bpf+bounces-73945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95BC3EC1D
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 08:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D944EB87E
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8B3081B1;
	Fri,  7 Nov 2025 07:31:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA1266B72
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500690; cv=none; b=BqO9yyPNFYnK3fboALRxyGXVBGB4Q056WDEQ6Un6mINU8Pu9M3+7i89mdHHNl9IZb1rWXSoAjbJnsQEGQnlUiipnRsCF9Pr090LGM4fB/Oh1FliOcHJR5pHf6AAZLriLwbmLY28DJhbHI5YL+i3f2mnv+nTctalQbiO0AaL0XKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500690; c=relaxed/simple;
	bh=hmBQunOCM5ZmhF1k490t04BJn11l0BugsBMHywhEaok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WdIsO+x/yPyaJ8iI5ZFLKI4poX1PwOsTJhbUPgBcurb2fpjf3razv0amZoymHpEKafHPaeyiHMog+8ungfBLklNGUOYRPFxljV5k8gvbEEiiLI74CTuGjWcPrxPg6qpfZ/9Op9sEAx8xybOwyUqQtcy66tBaYahRLOI/YERpYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e86696b5fso38745339f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 23:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500688; x=1763105488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC5whZ6xjAg9orncDEXG9Mf4Zikpjttx0BkeAU8vHTQ=;
        b=YIJM3ac6CG+wRum9AYBLnlV5X6lJhOD9ku1sHeGfJgL8cBVhRnJwBkKELTEsGW/UYD
         nX87ssK70m1ldPpKZuptd1UyQhDcXGOBEO6b/VcYfAwJOXDsnyhA0YiglRFnyM7FyD/2
         RE6Yz6EuKcgolUWR8M1KQXe0qxEGObVu6QCzgtLmykru7fiqO0nub/f2jObFqOvC3N81
         i/NRXZeJYqMd57kpElVs8OIn6CW+jUAla3nYQn36NPslGjswz8KEJqyMEuMWg1KHqItQ
         Nu39NAWgr3zLjryxgViYC2o+dUzTBAJQNQ+cmXn8BOPs4BCCAkqct/30LSV5qLBBigZJ
         7q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0GoJRoSaQLvzX3diKtUr+c44gwNLNpD0wP8QW94vAGHoxaJ0CN4zz0nJaRd8iGObG42w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG912TQtskRxTic4FiRG9WTkq2oIj1e0AKMWbLSuJVK76Uo5gI
	va9/GP0VZ6jSBKqjoJCx1Z08a6PpSiCjPl/si3iqmlW2GsNGnyQnbjrldO0blndXXgI9Hcg6SAa
	aiJJT80iwuPCHdPuE8sQ3YgTkTqHzxhNSoru7rWajjjsOjawVR3lfLNaSx30=
X-Google-Smtp-Source: AGHT+IF1mWmFU+QuzP+6G0raJVSuUbhvWf35rIhwvg/7kKBEsHrx+TEWgqipXwdks6Tvvg+v62pf8jfuYyIcJq7AP3kS3CRjzES2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:433:290f:c201 with SMTP id
 e9e14a558f8ab-4335f3d0389mr32665345ab.11.1762500687581; Thu, 06 Nov 2025
 23:31:27 -0800 (PST)
Date: Thu, 06 Nov 2025 23:31:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da04f.a70a0220.22f260.0027.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	anna-maria@linutronix.de, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, cgroups@vger.kernel.org, david@redhat.com, 
	dietmar.eggemann@arm.com, frederic@kernel.org, hannes@cmpxchg.org, 
	jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, mjguzik@gmail.com, mkoutny@suse.com, oleg@redhat.com, 
	paul@paul-moore.com, peterz@infradead.org, rostedt@goodmis.org, 
	rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    982312090977 Add linux-next specific files for 20251103
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b2932f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1347817c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40058f8a830c/disk-98231209.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d7f42e8639f/vmlinux-98231209.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8bb0284f393/bzImage-98231209.xz

The issue was bisected to:

commit 3c9820d5c64aeaadea7ffe3a6bb99d019a5ff46a
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Oct 29 12:20:24 2025 +0000

    ns: add active reference count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101e9bcd980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121e9bcd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=141e9bcd980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Fixes: 3c9820d5c64a ("ns: add active reference count")

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:229 at __ns_ref_put include/linux/ns_common.h:229 [inline], CPU#0: kworker/0:6/6108
WARNING: ./include/linux/ns_common.h:229 at put_user_ns include/linux/user_namespace.h:189 [inline], CPU#0: kworker/0:6/6108
WARNING: ./include/linux/ns_common.h:229 at destroy_super_work+0x15c/0x1a0 fs/super.c:280, CPU#0: kworker/0:6/6108
Modules linked in:
CPU: 0 UID: 0 PID: 6108 Comm: kworker/0:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events destroy_super_work
RIP: 0010:__ns_ref_put include/linux/ns_common.h:229 [inline]
RIP: 0010:put_user_ns include/linux/user_namespace.h:189 [inline]
RIP: 0010:destroy_super_work+0x15c/0x1a0 fs/super.c:280
Code: 90 63 ff 48 81 c3 a8 fc ff ff 48 89 df e8 ec 90 63 ff 4c 89 f7 5b 41 5c 41 5d 41 5e 41 5f 5d e9 8a 91 e1 ff e8 45 df 86 ff 90 <0f> 0b 90 e9 6d ff ff ff e8 37 df 86 ff 4c 89 e7 be 03 00 00 00 e8
RSP: 0018:ffffc900030d7a48 EFLAGS: 00010293
RAX: ffffffff823a294b RBX: ffff88805639c898 RCX: ffff88802ab59e80
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffff88807477565b R09: 1ffff1100e8eeacb
R10: dffffc0000000000 R11: ffffed100e8eeacc R12: ffff888074775658
R13: dffffc0000000000 R14: ffff88805639c000 R15: ffff8880747754c8
FS:  0000000000000000(0000) GS:ffff888125eda000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008044000 CR3: 0000000077ad4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3350 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x52d/0xa70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

