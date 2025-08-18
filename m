Return-Path: <bpf+bounces-65861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D9B29B4D
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDF0C4E2064
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B2286D77;
	Mon, 18 Aug 2025 07:53:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004E26B942
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503615; cv=none; b=GbROXiPl9HmSwP4J1PTd+YO2hHvpt3g4XhIUlEe0bo/N4Pnf4PUPbG1Gzh9sqhxKeqLsvhF557MKOaNi84DjrTWc4COMNZWcQSjJl7dV91uvy2eB16oCuoETSG6xFPpzAb5L0ezstkKPaHDkfEgG6sXISUsqKApPDV0z7x7gDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503615; c=relaxed/simple;
	bh=Qm98CsKiZssJ89VPl287AmugGSc7bt8qYP2C0hgs4Ns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WQS76FOywu/nCxr29jPaY/hSRmjjmXUTWFIbUUUl+w1nQb/t9NvmFC1f9dmGtGw6LVLnuOidtXT/oNoWvbap1db7m3Tbnfpa+YEsSC7C581MBWPgNje547kC29lPG805SOtkh3+C7oOkkiUofhyLOpDggfaIM6Tsuv7QAicfIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-884418a2614so669324539f.3
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 00:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503613; x=1756108413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xErwOmLK+upZ5SztH45fHWHRLrfJkU1Tu5wxEcT0Jo=;
        b=JTcTxfVyUAtxqrnfPj3ao36RZsiEAoQQRm9r+/c0r9yK2uM8XDN+FS7Mr7X0Qj5aFF
         bT2MRKfjtL1tvK1R6Agsa2y/GUmdoGUEo2p6eFK/cov806dUGhog8JT5/p2o70RnLdT/
         uK/lZkwER7HLBnVS7S0U48z9wdjGAzeneqPtY02EMjjkJrziXuP2ztxUqznmNrbIXhjV
         DTbAf5VY+FJ/MmWiJ27d4wABQNS/f8YmmGk1TShZB6bKOxkYMfOki2+3YOQCbcwOaAd6
         /8SYlmrsimkyRJ/175y15+PyCuF0n5gXbAwH2hT6pGNFenxQA7JhGO/K1TDYBCvZt9gf
         H+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0PQFtP8GvB/a5PyLXAPC/naasj9dajI6girj/0k/OerDMRgtS6p7QFCQnD1ONg0QcTZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vfSyPHk0m1jwX79YntsjvNrCCkdYOQH7xz4GmbWXfU/btGAz
	h5DvC2sDQj+ret50ZyA17DqMKceH0UgXeu1kkKdbyhWIoc+Cy8p+6rlCrU2voEwyliKfE8lWGo4
	ANgt5W8BO8OnJCLX2cT8p356IsmGt4htZ8RpXEtMBHvZMgowWiYyUqkUrun0=
X-Google-Smtp-Source: AGHT+IEKNm0dujcvmxcJQ1bwMG7c3CsIBMnei11YBxoOAkeqZE0BYc10q9fxiOU8HId8YCHUs5B7SRHWAb0d7m6XPn+QQBJrxf1Z
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6705:b0:881:758b:802c with SMTP id
 ca18e2360f4ac-8843e4dc512mr1429380739f.10.1755503613348; Mon, 18 Aug 2025
 00:53:33 -0700 (PDT)
Date: Mon, 18 Aug 2025 00:53:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2dbfd.050a0220.e29e5.0094.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in __pcpu_freelist_pop
From: syzbot <syzbot+331f5bebb641724ff1f0@syzkaller.appspotmail.com>
To: andrii@kernel.org, arighi@nvidia.com, ast@kernel.org, bpf@vger.kernel.org, 
	bsegall@google.com, changwoo@igalia.com, daniel@iogearbox.net, 
	dietmar.eggemann@arm.com, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sched-ext@lists.linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, vincent.guittot@linaro.org, void@manifault.com, 
	vschneid@redhat.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e4414b01c1cd bpf: Check the helper function is valid in ge..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd4442580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=331f5bebb641724ff1f0
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d2e3a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bd0ba2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf622f58cf3e/disk-e4414b01.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8947767e2701/vmlinux-e4414b01.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a73aee74e9c/bzImage-e4414b01.xz

The issue was bisected to:

commit c68ea8243c5cc901cea62f695504bec73195d906
Author: Andrea Righi <arighi@nvidia.com>
Date:   Wed Jun 4 14:33:11 2025 +0000

    sched_ext: idle: Remove unnecessary ifdef in scx_bpf_cpu_node()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d7aba2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1037aba2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d7aba2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+331f5bebb641724ff1f0@syzkaller.appspotmail.com
Fixes: c68ea8243c5c ("sched_ext: idle: Remove unnecessary ifdef in scx_bpf_cpu_node()")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5867 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller-ge4414b01c1cd #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:___pcpu_freelist_pop kernel/bpf/percpu_freelist.c:114 [inline]
RIP: 0010:__pcpu_freelist_pop+0x6b7/0x8c0 kernel/bpf/percpu_freelist.c:125
Code: 10 48 3b 8c 24 80 00 00 00 0f 85 b4 01 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 89 f8 48 c1 e8 03 <80> 3c 18 00 48 89 7c 24 20 74 0a e8 29 3f 41 00 48 8b 7c 24 20 48
RSP: 0018:ffffc90000a08820 EFLAGS: 00010046
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffe8ffffd6e308
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90000a088f0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000141110 R12: 1ffffd1ffffadc60
R13: ffffe8ffffd6e300 R14: 0000000000000001 R15: 0000000000000000
FS:  0000555583dc4500(0000) GS:ffff888125d1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555622ed5c8 CR3: 00000000769d6000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 pcpu_freelist_pop+0xca/0x170 kernel/bpf/percpu_freelist.c:134
 __bpf_get_stackid+0x574/0xcf0 kernel/bpf/stackmap.c:259
 ____bpf_get_stackid_raw_tp kernel/trace/bpf_trace.c:1810 [inline]
 bpf_get_stackid_raw_tp+0x196/0x210 kernel/trace/bpf_trace.c:1799
 bpf_prog_b724608cae728045+0x27/0x2f
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x284/0x4b0 kernel/trace/bpf_trace.c:2298
 __do_trace_kfree include/trace/events/kmem.h:94 [inline]
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x3a0/0x440 mm/slub.c:4866
 slab_free_after_rcu_debug+0x60/0x2a0 mm/slub.c:4717
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 lock_sock include/net/sock.h:1667 [inline]
 tcp_sendmsg+0x21/0x50 net/ipv4/tcp.c:1392
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:729
 sock_write_iter+0x258/0x330 net/socket.c:1179
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe78c18d660
Code: 40 00 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 01 af 1f 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc45dccfb8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000179a7b00 RCX: 00007fe78c18d660
RDX: 0000000000000108 RSI: 00007fe789c3fef8 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000007 R09: 000000000003fde8
R10: 1a917aa2f8ade145 R11: 0000000000000202 R12: 0000000000000108
R13: 0000555583ddd6d0 R14: 00007ffc45dcd480 R15: 00007fe789c3fef8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:___pcpu_freelist_pop kernel/bpf/percpu_freelist.c:114 [inline]
RIP: 0010:__pcpu_freelist_pop+0x6b7/0x8c0 kernel/bpf/percpu_freelist.c:125
Code: 10 48 3b 8c 24 80 00 00 00 0f 85 b4 01 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 89 f8 48 c1 e8 03 <80> 3c 18 00 48 89 7c 24 20 74 0a e8 29 3f 41 00 48 8b 7c 24 20 48
RSP: 0018:ffffc90000a08820 EFLAGS: 00010046
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffe8ffffd6e308
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90000a088f0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000141110 R12: 1ffffd1ffffadc60
R13: ffffe8ffffd6e300 R14: 0000000000000001 R15: 0000000000000000
FS:  0000555583dc4500(0000) GS:ffff888125d1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555622ed5c8 CR3: 00000000769d6000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	10 48 3b             	adc    %cl,0x3b(%rax)
   3:	8c 24 80             	mov    %fs,(%rax,%rax,4)
   6:	00 00                	add    %al,(%rax)
   8:	00 0f                	add    %cl,(%rdi)
   a:	85 b4 01 00 00 48 8d 	test   %esi,-0x72b80000(%rcx,%rax,1)
  11:	65 d8 5b 41          	fcomps %gs:0x41(%rbx)
  15:	5c                   	pop    %rsp
  16:	41 5d                	pop    %r13
  18:	41 5e                	pop    %r14
  1a:	41 5f                	pop    %r15
  1c:	5d                   	pop    %rbp
  1d:	c3                   	ret
  1e:	cc                   	int3
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	cc                   	int3
  22:	cc                   	int3
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
  33:	74 0a                	je     0x3f
  35:	e8 29 3f 41 00       	call   0x413f63
  3a:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  3f:	48                   	rex.W


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

