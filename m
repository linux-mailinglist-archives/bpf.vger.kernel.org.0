Return-Path: <bpf+bounces-36485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF18949797
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 20:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5E1C216C0
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7F75817;
	Tue,  6 Aug 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ghpys+yy"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2C80025
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969089; cv=none; b=LL0LbqiBf79/4A1jiItunAjdYHdudPZ/G+XJfDONhG53HyutA4UXQtKUYqYbut368xhWrQB4YhQypqUjUI+/bo6nGev0zu/7hmGQbPaaMYcxjAE+HaEOughN6BSaowXamQKhpg8lUgt+MP4wrZKr+5XeFJUs3nJ0y4YunwAjgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969089; c=relaxed/simple;
	bh=gDFa+FKa5f3vrHKuqvFzBtyjVbQxMNl64L/P91eLMdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y3ZW6WpEvLnO4x3hRNd6S+W0/YU4GQLnJm8dHPGX0F3Q27qmXSHoOxHSHlk7paBOqi+v7RxOQMX0L0aVZBwwyF+kB/FLbmFdjQLwpOjIYwTfjHLzXXBY6M69mBHUh+cHr1d6f2f8NeAK9kwaGIXb7wG2pMVR0Xzkj9eQLZiKtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ghpys+yy; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7591a8b-f546-4742-a24c-6fefa876cf4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722969084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6CrD7owATAmOySky9OSR3ONjlv0xP6/AXzwWJC+46A=;
	b=Ghpys+yySSdYNwrxrxpK/Qnah0Oo7xOivfxEKaJiSOsmLT1ky4kVS5SHe1nNh9JnghJUEf
	pK/kZLmjIuuOpwUOOFtSZSponIqTQF121eUr4nB+mVvxNsPB43wo5Yvo8D68MHzNcHQgKg
	e1Zdvi47h/0nw7v5pULsJSkHL6sQEHw=
Date: Tue, 6 Aug 2024 11:31:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] BUG: spinlock recursion in bpf_lru_push_free
Content-Language: en-GB
To: syzbot <syzbot+d6fb861ed047a275747a@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000b3e63e061eed3f6b@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <000000000000b3e63e061eed3f6b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/5/24 3:36 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3d650ab5e7d9 selftests/bpf: Fix a btf_dump selftest failure

The failure is not due to this patch.

> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a4c1a1980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6fb861ed047a275747a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/630e210de8d9/disk-3d650ab5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3576ca35748a/vmlinux-3d650ab5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5b33f099abfa/bzImage-3d650ab5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d6fb861ed047a275747a@syzkaller.appspotmail.com
>
> BUG: spinlock recursion on CPU#1, syz.4.1173/11483

Actually this is a known issue and has been reported a few times in the past.

>   lock: 0xffff888046908300, .magic: dead4ead, .owner: syz.4.1173/11483, .owner_cpu: 1
> CPU: 1 UID: 0 PID: 11483 Comm: syz.4.1173 Not tainted 6.10.0-syzkaller-12666-g3d650ab5e7d9 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:93 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>   debug_spin_lock_before kernel/locking/spinlock_debug.c:87 [inline]
>   do_raw_spin_lock+0x227/0x370 kernel/locking/spinlock_debug.c:115
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>   _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
>   bpf_lru_list_push_free kernel/bpf/bpf_lru_list.c:318 [inline]
>   bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:538 [inline]
>   bpf_lru_push_free+0x1a7/0xb60 kernel/bpf/bpf_lru_list.c:561
>   htab_lru_map_delete_elem+0x613/0x700 kernel/bpf/hashtab.c:1475
>   bpf_prog_6f5f05285f674219+0x43/0x4c
>   bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
>   __bpf_prog_run include/linux/filter.h:691 [inline]
>   bpf_prog_run include/linux/filter.h:698 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
>   bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
>   trace_contention_begin+0x117/0x140 include/trace/events/lock.h:95

The tracepoint trace_contention_begin is the reason for spinlock recursion.
The trace_contention_begin is in
   queued_spin_lock_slowpath(...) {
     ...
     trace_contention_begin(lock, LCB_F_SPIN);
     ...
   }

And the bpf prog attached to trace_contention_begin() will go though spin_lock path again
and this may cause dead lock.


>   __pv_queued_spin_lock_slowpath+0x114/0xdc0 kernel/locking/qspinlock.c:402
>   pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
>   queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
>   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>   lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:143
>   graph_lock kernel/locking/lockdep.c:169 [inline]
>   lookup_chain_cache_add kernel/locking/lockdep.c:3803 [inline]
>   validate_chain+0x21d/0x5900 kernel/locking/lockdep.c:3836
>   __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>   htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
>   htab_lru_map_delete_node+0x161/0x840 kernel/bpf/hashtab.c:817
>   __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:225 [inline]
>   __bpf_lru_list_shrink+0x156/0x9d0 kernel/bpf/bpf_lru_list.c:271
>   bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:345 [inline]
>   bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:452 [inline]
>   bpf_lru_pop_free+0xd84/0x1a70 kernel/bpf/bpf_lru_list.c:504
>   prealloc_lru_pop kernel/bpf/hashtab.c:308 [inline]
>   __htab_lru_percpu_map_update_elem+0x242/0x9b0 kernel/bpf/hashtab.c:1355
>   bpf_percpu_hash_update+0x11a/0x200 kernel/bpf/hashtab.c:2421
>   bpf_map_update_value+0x347/0x540 kernel/bpf/syscall.c:181
>   generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1889
>   bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5218
>   __sys_bpf+0x377/0x810
>   __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fed319779f9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fed327ee048 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fed31b05f80 RCX: 00007fed319779f9
> RDX: 0000000000000038 RSI: 0000000020000580 RDI: 000000000000001a
> RBP: 00007fed319e58ee R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fed31b05f80 R15: 00007ffcf9a1d7f8
>   </TASK>
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

