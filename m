Return-Path: <bpf+bounces-74462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B5C5BAE6
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 08:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752CA3B2D9E
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30FA2F1FD5;
	Fri, 14 Nov 2025 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DUdkTKjz"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45752E8B85
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104126; cv=none; b=aH/y/MGq7hIGaC9BQHDSkXYDFhX7lqnPX/dhmSRpcycrWymAMDAxLLW6evT3ayQiDQM3ue3I5h/zz1sh1jBkhgJBS6w5VLyFYMRVDxaqPJtn1+M7neFbZaqUFvyhBLDkThKe+k42zCQOXGc+ABut/YcPDSn8LRvh8kRq+DWA9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104126; c=relaxed/simple;
	bh=/qcYlwENVeYvbcM1VpIaxZh9+cVEEy4MhHefpFpCU0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re4RL8IbRTlDiEfmebNvznn+SK76evSaKZ00kMXdri1cJx4GidVtOJ49PDBzNXk+e2kodVSyxtwYJmBVqFFBqn2FQ7FFy7XyCSDnA8XDfx/Spv5LrRp+UYmqkX+lRsP0LqN2Myw59/+oTkStcJvaSLQbelLtTQnd+/vq6jCZoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DUdkTKjz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763104110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu6m0cM7Wk0S/o22e/Nj12lL6BNeo+hWa/283w36OyI=;
	b=DUdkTKjzmTujhVb+PSIYlrjQgx7RKXKI2Q7PIZJYAssOx7wiRqtkCVtGIDE+mfq7/EhvUh
	5aAbOOqaNfJTh30g0b4eNE+Blt0w2Y9bzO/9cYNm9a4NTflaNmxNuhpdatWcXPvHwhGSpV
	gf1Zd7QEfOfZPfS2TxBc84MjzDyU3es=
From: Menglong Dong <menglong.dong@linux.dev>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev,
 syzbot <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2)
Date: Fri, 14 Nov 2025 15:08:13 +0800
Message-ID: <9537276.CDJkKcVGEf@7950hx>
In-Reply-To: <69155df5.a70a0220.3124cb.0018.GAE@google.com>
References: <69155df5.a70a0220.3124cb.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/13 12:26, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e427054ae7bc Merge branch 'x86-fgraph-bpf-fix-orc-stack-un..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=136b70b4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=18b26edb69b2e19f3b33
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10013c12580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16541c12580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c1ac942fc5fb/disk-e427054a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be05ef12ba31/vmlinux-e427054a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c75604292a15/bzImage-e427054a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor149/10558 is trying to acquire lock:
> ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:514 [inline]
> ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_lru_push_free+0x33b/0xbb0 kernel/bpf/bpf_lru_list.c:553
> 
> but task is already holding lock:
> ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:440 [inline]
> ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x1ab/0x19b0 kernel/bpf/bpf_lru_list.c:496

I were working on this issue by using rqspinlock for LRU map:
https://lore.kernel.org/bpf/20251030030010.95352-1-dongml2@chinatelecom.cn/

However, the lock here is too complex. Take the
htab_lru_map_update_elem for example, it will pop a free node,
updating the hash table, and push the old node to the lru.

The pop and push are both using lock, which means that they
both can fail. For the failure of the pop, we can return the
errno directly. However, what we can do with the failure of
the pushing? In the batch updating, the situation become
much more worse.

Hmm...I have not figure out a good idea, and maybe we can
use some transaction process here. Is there anyone else
that working on this issue?

Thanks!
Menglong Dong

> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&loc_l->lock);
>   lock(&loc_l->lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by syz-executor149/10558:
>  #0: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #0: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: bpf_percpu_hash_update+0x2b/0x200 kernel/bpf/hashtab.c:2409
>  #1: ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:440 [inline]
>  #1: ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x1ab/0x19b0 kernel/bpf/bpf_lru_list.c:496
>  #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
>  #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2116
> 
> stack backtrace:
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
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
> 





