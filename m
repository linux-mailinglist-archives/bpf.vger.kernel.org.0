Return-Path: <bpf+bounces-77162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE955CD0D3D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B20A43009FDD
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1562FFDE2;
	Fri, 19 Dec 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j1qiJ9e/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v7Yd9rrU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j1qiJ9e/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v7Yd9rrU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0F35A92D
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160668; cv=none; b=RnEsTkBz7PKxlzl7TPxZmiGxgDC1+R/HDptl+4EwInVgZaJSrwa2XboBfZo1uhjFGzSa3seMbb4VNyAsNTWHF02MFsGaY81PK1U4EckScCO9SOBGv2vYa8ayjsRHPEhNbk8hngumlls2x9qfU3Ywqv7WaHMLcwO9Oph0zluwVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160668; c=relaxed/simple;
	bh=uZC8uybpHo7xIlaatsAcfB0qsCJxU/ti5WYcvJrp+y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MurXIHWhBAfFq2b2dZxM5MLsRNmAK/vCYOC2ybylIJNk1hxhtJc1Nm5nG97pvz6HJwVXdhdh617boelFkZSziPK83P0oQerMg1+IwPdcf8eeKVe5xlNkgig9EV3hOgorLv0eZGGdTb8+nVrHSyMfEEGPrWQc1ze8nhrnlgewEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j1qiJ9e/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v7Yd9rrU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j1qiJ9e/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v7Yd9rrU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C09E33718;
	Fri, 19 Dec 2025 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766160661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W+ya9Tiz1Acq30/pt3C8J4nG1BOc+IVb80yBucnwraw=;
	b=j1qiJ9e/iskFpIcDAW+y4+igVxJQNCLAD4mzJUZa3NbrKhFTr1XzyVHintUAIVmaSYJDWY
	QG07NiRfV9Q01jHWj0LLjmgznoL1Sz1chfQ6LUCyCmZMJUFYsh2ooVYNZNdw/XfnsN57h/
	2SRYoPpcdrcefO5Yzwk+FfSRHYk7Q+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766160661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W+ya9Tiz1Acq30/pt3C8J4nG1BOc+IVb80yBucnwraw=;
	b=v7Yd9rrUcfcTLUFlhDS6/x8SZxsefWHmldH5m+3W7XsCAgcosqQ2yBabq7wadOlec7q/cN
	SeVbuqeABOVP+MDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766160661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W+ya9Tiz1Acq30/pt3C8J4nG1BOc+IVb80yBucnwraw=;
	b=j1qiJ9e/iskFpIcDAW+y4+igVxJQNCLAD4mzJUZa3NbrKhFTr1XzyVHintUAIVmaSYJDWY
	QG07NiRfV9Q01jHWj0LLjmgznoL1Sz1chfQ6LUCyCmZMJUFYsh2ooVYNZNdw/XfnsN57h/
	2SRYoPpcdrcefO5Yzwk+FfSRHYk7Q+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766160661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W+ya9Tiz1Acq30/pt3C8J4nG1BOc+IVb80yBucnwraw=;
	b=v7Yd9rrUcfcTLUFlhDS6/x8SZxsefWHmldH5m+3W7XsCAgcosqQ2yBabq7wadOlec7q/cN
	SeVbuqeABOVP+MDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29DE83EA63;
	Fri, 19 Dec 2025 16:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t2aBCBV5RWlkTgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 19 Dec 2025 16:11:01 +0000
Message-ID: <fb41c7e1-c8de-40fc-9470-2e742e358ba9@suse.cz>
Date: Fri, 19 Dec 2025 17:11:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from
 invalid context in __bpf_stream_push_str
Content-Language: en-US
To: syzbot <syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com>,
 ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, houtao1@huawei.com,
 jkangas@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 sgarzare@redhat.com, syzkaller-bugs@googlegroups.com,
 virtualization@lists.linux.dev, wangfushuai@baidu.com,
 Linux-RT-Users <linux-rt-users@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 RCU <rcu@vger.kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>
References: <6936b4b4.a70a0220.38f243.00a2.GAE@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <6936b4b4.a70a0220.38f243.00a2.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=74c2ec4187efdce];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_RCPT(0.00)[b1546ad4a95331b2101e];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On 12/8/25 12:21, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    559e608c4655 Merge tag 'ntfs3_for_6.19' of https://github...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164fdcc2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=74c2ec4187efdce
> dashboard link: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1446301a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112c3f42580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7d28798cb263/disk-559e608c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/239e800627b8/vmlinux-559e608c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e89da2cc9887/bzImage-559e608c.xz

> The issue was bisected to:
> 
> commit 0db4941d9dae159d887e7e2eac7e54e60c3aac87
> Author: Fushuai Wang <wangfushuai@baidu.com>
> Date:   Tue Oct 7 07:40:11 2025 +0000
> 
>     bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c

(came here because reviewing a proposed fix:
https://lore.kernel.org/all/20251219085755.139846-1-swarajgaikwad1925@gmail.com/
)

The bisection result seem weird to me, it changes some usages of
migrate_disable(); + rcu_read_lock(); to  rcu_read_lock_dont_migrate();
However with CONFIG_PREEMPT_RCU=y which the syzbot .config has, this should
be equivalent? (Also I'm not sure the affected paths are even in the backtrace?)

In either case with CONFIG_PREEMPT_RCU=y, rcu_read_lock() should not be
disabling preemption?

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cd3c1a580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12cd3c1a580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14cd3c1a580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
> Fixes: 0db4941d9dae ("bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c")
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128, name: syz.3.73
> preempt_count: 2, expected: 0
> RCU nest depth: 1, expected: 1
> 3 locks held by syz.3.73/6128:
>  #0: ffff8880493da398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
>  #0: ffff8880493da398 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x152/0xd40 net/vmw_vsock/af_vsock.c:1546
>  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
>  #1: ffffffff8d5aeba0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run9+0x1ec/0x510 kernel/trace/bpf_trace.c:2123
>  #2: ffff8880b893fd48 (&s->lock_key#14){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  #2: ffff8880b893fd48 (&s->lock_key#14){+.+.}-{3:3}, at: ___slab_alloc+0x12f/0x1400 mm/slub.c:4516
> Preemption disabled at:
> [<ffffffff82179f5a>] class_preempt_constructor include/linux/preempt.h:468 [inline]
> [<ffffffff82179f5a>] __migrate_enable include/linux/sched.h:2378 [inline]
> [<ffffffff82179f5a>] migrate_enable include/linux/sched.h:2429 [inline]
> [<ffffffff82179f5a>] __slab_alloc+0xea/0x1f0 mm/slub.c:4777

Wait, so it's slab code itself disabling preemption, in migrate_enable()?
But there's guard(preempt)(); so it should be enabled again.

Or is it the limitation of the reporting, that it doesn't know which
preemptions were re-enabled and which not?


> CPU: 1 UID: 0 PID: 6128 Comm: syz.3.73 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  __might_resched+0x44b/0x5d0 kernel/sched/core.c:8830
>  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>  rt_spin_lock+0xc7/0x3e0 kernel/locking/spinlock_rt.c:57
>  spin_lock include/linux/spinlock_rt.h:44 [inline]
>  ___slab_alloc+0x12f/0x1400 mm/slub.c:4516
>  __slab_alloc+0xc6/0x1f0 mm/slub.c:4774
>  __slab_alloc_node mm/slub.c:4850 [inline]
>  kmalloc_nolock_noprof+0x1be/0x440 mm/slub.c:5729
>  bpf_stream_elem_alloc kernel/bpf/stream.c:33 [inline]
>  __bpf_stream_push_str+0xa8/0x2b0 kernel/bpf/stream.c:50
>  bpf_stream_stage_printk+0x14e/0x1c0 kernel/bpf/stream.c:306
>  bpf_prog_report_may_goto_violation+0xc4/0x190 kernel/bpf/core.c:3203
>  bpf_check_timed_may_goto+0xaa/0xb0 kernel/bpf/core.c:3221
>  arch_bpf_timed_may_goto+0x21/0x40 arch/x86/net/bpf_timed_may_goto.S:40
>  bpf_prog_262a74d054ad2993+0x53/0x5f
>  bpf_dispatcher_nop_func include/linux/bpf.h:1376 [inline]
>  __bpf_prog_run include/linux/filter.h:723 [inline]
>  bpf_prog_run include/linux/filter.h:730 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
>  bpf_trace_run9+0x2de/0x510 kernel/trace/bpf_trace.c:2123
>  __bpf_trace_virtio_transport_alloc_pkt+0x2d7/0x340 include/trace/events/vsock_virtio_transport_common.h:39
>  __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
>  trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
>  virtio_transport_alloc_skb+0x10af/0x1110 net/vmw_vsock/virtio_transport_common.c:311
>  virtio_transport_send_pkt_info+0x694/0x10b0 net/vmw_vsock/virtio_transport_common.c:390
>  virtio_transport_connect+0xa7/0x100 net/vmw_vsock/virtio_transport_common.c:1072
>  vsock_connect+0xaca/0xd40 net/vmw_vsock/af_vsock.c:1611
>  __sys_connect_file net/socket.c:2080 [inline]
>  __sys_connect+0x323/0x450 net/socket.c:2099
>  __do_sys_connect net/socket.c:2105 [inline]
>  __se_sys_connect net/socket.c:2102 [inline]
>  __x64_sys_connect+0x7a/0x90 net/socket.c:2102
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0c4d91f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd8ed26ac8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00007f0c4db75fa0 RCX: 00007f0c4d91f749
> RDX: 0000000000000010 RSI: 0000200000000080 RDI: 0000000000000003
> RBP: 00007f0c4d9a3f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0c4db75fa0 R14: 00007f0c4db75fa0 R15: 0000000000000003
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


