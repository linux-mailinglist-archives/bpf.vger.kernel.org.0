Return-Path: <bpf+bounces-76280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3AECACFA4
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 12:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F053B3012ED7
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B4313534;
	Mon,  8 Dec 2025 11:21:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443123101A3
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765192887; cv=none; b=BlTWCoyGiX//FIqa68Vdt7pewp7p2comnjYC70L6vSu2ugjtXJv2EkK0bYq6OpEnjHQWqgIDw67yJa01Q2N61WHkRDDe2v0OGIyo62HRSQR07RR2O22XCz5gjFFFnJ/BRAQJTRYj+JdbOROxlR/cSi0fjv68v1X496B/pJ/szQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765192887; c=relaxed/simple;
	bh=/aFtt90Az4pmsZ8iGym0ES0kZyqG19+Un08bBTYx2e0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rS+qC5dhM0hHMnpK2dvxbfiHAXE+bm/xx5+ZeUTCjbPZNxtXZkI7OaEZ4oIMtHSrdgKnc/POlQIlu87pLQ6eUnp0fTXPMC8S8TS9X2b1HOzPtLJeRB9QZhSyeU3dzsAnEgax8jt7GjCOZ1vTgyF6+o65cNsgSThObJDNCOGKouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6573d873f92so3034265eaf.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 03:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765192884; x=1765797684;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEYM2xG6zvxNmktooPVFzI3lRUI4aVQvufBVk+XlwKY=;
        b=lrpfzyafr0YKLqgXNDnJhpnc3qLoA80hckFfcSOFRRpBaoBoYszONkKKg8kjyrqiNY
         fzPHm4e0X3Yybs/J6aFx9cpg+lyH2+7mS19PDPCc4zTP+puU9DvSeIJu2GPej98/owEq
         svr8FNjFpbtOWnYipfWKZ1257PnwhmrxoJ7ZFxdllwVvYSmCfLg7i9NaidpeDVGL4jec
         kHFsB42wK3jc3qIL3kh6M4It9t5aqiGC85LWnH7ihhpUxVYVt4uGkTsjoO+feJ1cynVS
         ggZdx7XJAs/6SS/Zh3m9iOPjIUGSL71cD7QXbQQivePakPSOSFwT8P0ZFz/LZ6tZajRS
         7EFw==
X-Forwarded-Encrypted: i=1; AJvYcCUxloALn7S/l58r3VTviQcD+vdMzlpzjwapEbGTjuqBCh1jW/pfjBR4781F1scLJV7HdUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueC5byEHG23HYVjiS1FJIy9IdW0a+PvHmfXU8LMohz8Gf+4YA
	7F27/thKgzrg0aAMERjP309G4SOlrnJCYesMcJPhmFbcXqggkB6cFJSAguJFFndIj3F6Ptq3tbw
	XeCJPK8EjOJBEt6LQhgzbn8k01VuCNaDcJXMucFMsDpVHIqFE0B7f5W84bHY=
X-Google-Smtp-Source: AGHT+IHRm3ejNmfcW4LHNiAooQdI9hhnzIDedTnijxOW9l7hRpYkRtK1l5LXbaM2iTGlLgIpVC9FznyzKCfC/E6RHGE87LKdtgil
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:823:b0:659:9a49:8ddb with SMTP id
 006d021491bc7-6599a8e9e58mr3333218eaf.29.1765192884397; Mon, 08 Dec 2025
 03:21:24 -0800 (PST)
Date: Mon, 08 Dec 2025 03:21:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6936b4b4.a70a0220.38f243.00a2.GAE@google.com>
Subject: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid
 context in __bpf_stream_push_str
From: syzbot <syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, houtao1@huawei.com, jkangas@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	wangfushuai@baidu.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    559e608c4655 Merge tag 'ntfs3_for_6.19' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164fdcc2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74c2ec4187efdce
dashboard link: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1446301a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112c3f42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d28798cb263/disk-559e608c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/239e800627b8/vmlinux-559e608c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e89da2cc9887/bzImage-559e608c.xz

The issue was bisected to:

commit 0db4941d9dae159d887e7e2eac7e54e60c3aac87
Author: Fushuai Wang <wangfushuai@baidu.com>
Date:   Tue Oct 7 07:40:11 2025 +0000

    bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cd3c1a580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12cd3c1a580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd3c1a580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Fixes: 0db4941d9dae ("bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c")

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128, name: syz.3.73
preempt_count: 2, expected: 0
RCU nest depth: 1, expected: 1
3 locks held by syz.3.73/6128:
 #0: ffff8880493da398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
 #0: ffff8880493da398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x152/0xd40 net/vmw_vsock/af_vsock.c:1546
 #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
 #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run9+0x1ec/0x510 kernel/trace/bpf_trace.c:2123
 #2: ffff8880b893fd48 (&s->lock_key#14){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #2: ffff8880b893fd48 (&s->lock_key#14){+.+.}-{3:3}, at: ___slab_alloc+0x12f/0x1400 mm/slub.c:4516
Preemption disabled at:
[<ffffffff82179f5a>] class_preempt_constructor include/linux/preempt.h:468 [inline]
[<ffffffff82179f5a>] __migrate_enable include/linux/sched.h:2378 [inline]
[<ffffffff82179f5a>] migrate_enable include/linux/sched.h:2429 [inline]
[<ffffffff82179f5a>] __slab_alloc+0xea/0x1f0 mm/slub.c:4777
CPU: 1 UID: 0 PID: 6128 Comm: syz.3.73 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8830
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x3e0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 ___slab_alloc+0x12f/0x1400 mm/slub.c:4516
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 kmalloc_nolock_noprof+0x1be/0x440 mm/slub.c:5729
 bpf_stream_elem_alloc kernel/bpf/stream.c:33 [inline]
 __bpf_stream_push_str+0xa8/0x2b0 kernel/bpf/stream.c:50
 bpf_stream_stage_printk+0x14e/0x1c0 kernel/bpf/stream.c:306
 bpf_prog_report_may_goto_violation+0xc4/0x190 kernel/bpf/core.c:3203
 bpf_check_timed_may_goto+0xaa/0xb0 kernel/bpf/core.c:3221
 arch_bpf_timed_may_goto+0x21/0x40 arch/x86/net/bpf_timed_may_goto.S:40
 bpf_prog_262a74d054ad2993+0x53/0x5f
 bpf_dispatcher_nop_func include/linux/bpf.h:1376 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run9+0x2de/0x510 kernel/trace/bpf_trace.c:2123
 __bpf_trace_virtio_transport_alloc_pkt+0x2d7/0x340 include/trace/events/vsock_virtio_transport_common.h:39
 __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
 virtio_transport_alloc_skb+0x10af/0x1110 net/vmw_vsock/virtio_transport_common.c:311
 virtio_transport_send_pkt_info+0x694/0x10b0 net/vmw_vsock/virtio_transport_common.c:390
 virtio_transport_connect+0xa7/0x100 net/vmw_vsock/virtio_transport_common.c:1072
 vsock_connect+0xaca/0xd40 net/vmw_vsock/af_vsock.c:1611
 __sys_connect_file net/socket.c:2080 [inline]
 __sys_connect+0x323/0x450 net/socket.c:2099
 __do_sys_connect net/socket.c:2105 [inline]
 __se_sys_connect net/socket.c:2102 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2102
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c4d91f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8ed26ac8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f0c4db75fa0 RCX: 00007f0c4d91f749
RDX: 0000000000000010 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f0c4d9a3f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0c4db75fa0 R14: 00007f0c4db75fa0 R15: 0000000000000003
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

