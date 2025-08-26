Return-Path: <bpf+bounces-66495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52053B35186
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 04:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CEE189355C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F6821A453;
	Tue, 26 Aug 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5fWtuSJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4217D346;
	Tue, 26 Aug 2025 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174831; cv=none; b=lLw3h1HJnIUpKGnz/6nOa4og7eU7mwBsc1dycm8XobUHAhdIxbcJrGwIn3j1oEUaArg1Xp/yX7eMpve8C629/FSGMbqVMPTvQjpQUdG/OPajzwAF4kBpc8AuEm3CAR2degwZ8O5z62zG+0uxbrCp9nXoD01fPibsX42yyS59Gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174831; c=relaxed/simple;
	bh=yhyhBJZ8an92NwZquksAIn+3HR+0XiI4x39ZNerlgos=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Am/CC4BNYfiLGyT9V2HmX9uzfLIsM7mXsI5ZXCUeSm+eqecKQX6HDyJO8+qUKZ/4+D7v2LAPMZFZ3AcxGF0L+2sZZlsapR07W3nDQivPYOaNw6kzpTdxVH0xJuvw88QBQTus/YeBltTgNGOEiTgoFAxkoow4vQyfJQqY2cK3RM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5fWtuSJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4382159b3a.1;
        Mon, 25 Aug 2025 19:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756174829; x=1756779629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9ek+HZbe+gsnEPjYWtEpoSUN8IgCGiWo1TmZClvgGY=;
        b=T5fWtuSJBBPXgN3FwkqGAq3yZG0fA9dp8Gq2782lasmcbkpYBwlW3N9fqhQ8vrNa6C
         4hrDTrEDZy84RVaTrBdHmpsSoG+J2lEl1UsDCiJt/jY+r2dQrgPQT35yiiAfvhDQ0GBH
         Ogliej37W33XYf31LegJ7GyUGAFFyRL2uS82q9Uj8RappOiknomgZP9rfcX9PEvp6M8Z
         vGPKsfqiEoGile5qAbkCMdVEvVWOFd+bR/mkOFQNvXLpiNAc2Tb0QOmFu7CuotFmMreB
         XlGFitf1L9H3/wyIvh+CoPpyzGkqNBTfdpFYlC7XfAa3s1IJl7t1PqQIAcS+9qgDPA7j
         oVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756174829; x=1756779629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9ek+HZbe+gsnEPjYWtEpoSUN8IgCGiWo1TmZClvgGY=;
        b=ZQ1GseWoohCiggJmMRwWeAnblbSBMNnlluhjIE4++pZyCvHpp/o2bz7QkzXrVZT9h9
         4/HoWdnHr6dqWPKiWnjTqqHcIaz7dU57Ph6aZ0kvfqqtER3voVUfxvIB1LlnZsOKYLEd
         o9V1A6sRUc9qRuv7nkV0Y6RapunUVwd5dazyNKo6EhQpKlfYwaNetOzqwdlluowrYbHW
         4aOg7jVEX4Lge0VFBSkRQQ1kA19QsNeWMBVj5JfpBoJ1fXFm3pfjo8SlAPcPPTeBKZy6
         YZpEDOB9b+IY9ry4alVivGhlkMnOnTlhdXHg1ZYIoc8eWF+i+1BL80exK9cTHTfeG1Gn
         SLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjgFa8VIsSa8TZkLvHF7eSb9DougcaQJtZsTeYp+26icoG5qCmRCgQkq6fnEaGi/H8iK9ap4pD@vger.kernel.org, AJvYcCVB0dt8kNb/SZGtbwKbx7B9mFyupr3/lhw2GY9Gcllpvl+c32hE1+NOZ7EUU2LsmC5OzDbGmhVqlEQoQsAv@vger.kernel.org, AJvYcCX7zyFRY8hkDGgTGsXcZ7bf0z6evFF85ppyI2l7ow1XKnJGc2jY6QhRBpRnyHeGBIHmlZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtDMQmQ/UIANAOgvlOHmQzHfzDV1Cvy1PsCUkxVgKQszeuZkg
	zQE4vI+YPs+sZxmY5esLBeLdYubsBSgNLXYI0UJfWtecwgdpiVzbRDko
X-Gm-Gg: ASbGncu1VlW2LY7wOu5SDH8QN50Cz3QIJhbV0W7gePQ79lqSa0g3xXnjjWWH1s7u0Xa
	nnLS9mPegSTenI3dD0VKTaLv4lSzANh2OvvZFrblx/hSVjxJ860cK1GR5Rf1JEnGtX/cRExFQAE
	et7nKQQ2Qfo3OpspT2biutuRodQxWkaGijXuEUOB4xBnHkNuk71rPJO+DFX9/EpmnalIYVwoiye
	NVVHAZdvkaaY6/FM8bEs9K4UX5vWhGjVSJ/XASSlTcfRctAM3Rbjm726hrYA3wysy8sTNFs9pQ6
	sjGXq6UPamnKhxNvxaQ9d6RRV7uhBKiU+3WABi6muJZpVNIlxliNPiXfmyao8/olB6neNtZUQXD
	7ToByf2wFY1FyXGrwuglXR3uUktFugQ8zlgU=
X-Google-Smtp-Source: AGHT+IHvyonvwrRIBLOu/LcIBwh/zI5hJBucNlOEAqNruRFfQGTS5TlWU4fNzB/4cMPL3eS3CuaBoA==
X-Received: by 2002:a05:6a20:1588:b0:204:432e:5fa4 with SMTP id adf61e73a8af0-24340b5b6ddmr20363524637.23.1756174828433;
        Mon, 25 Aug 2025 19:20:28 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f045b687sm1958500b3a.109.2025.08.25.19.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 19:20:27 -0700 (PDT)
Message-ID: <50f069c5-d962-4743-a8b0-dc1bc4811599@gmail.com>
Date: Tue, 26 Aug 2025 10:20:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
To: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
References: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/8/25 01:39, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dd9de524183a xsk: Fix immature cq descriptor production
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=102da862580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa5c2814795b5adca240
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142da862580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588aef0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5a3389c1558f/disk-dd9de524.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c97133192a27/vmlinux-dd9de524.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3ae5a1a88637/bzImage-dd9de524.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz-execprog/5866 is trying to acquire lock:
> ffffc900048c10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
> 
> but task is already holding lock:
> ffffc900048e90d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&rb->spinlock);
>   lock(&rb->spinlock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation

Confirmed.

I can reproduce this deadlock issue and will work on a fix.

Thanks,
Leon

> 
> 6 locks held by syz-execprog/5866:
>  #0: ffff88807e021588 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0x19f/0x3d0 mm/mmap_lock.c:147
>  #1: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #1: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: ___pte_offset_map+0x29/0x250 mm/pgtable-generic.c:286
>  #2: ffff8880787b60d8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #2: ffff8880787b60d8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: __pte_offset_map_lock+0x13e/0x210 mm/pgtable-generic.c:401
>  #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2256 [inline]
>  #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2298
>  #4: ffffc900048e90d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
>  #5: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #5: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #5: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: trace_call_bpf+0xb7/0x850 kernel/trace/bpf_trace.c:-1
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5866 Comm: syz-execprog Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
>  check_deadlock kernel/locking/lockdep.c:3093 [inline]
>  validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
>  __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
>  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:474 [inline]
>  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:466
>  bpf_prog_df2ea1bb7efca089+0x36/0x54
>  bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  bpf_prog_run_array include/linux/bpf.h:2292 [inline]
>  trace_call_bpf+0x326/0x850 kernel/trace/bpf_trace.c:146
>  perf_trace_run_bpf_submit+0x78/0x170 kernel/events/core.c:10911
>  do_perf_trace_contention_end include/trace/events/lock.h:122 [inline]
>  perf_trace_contention_end+0x253/0x2f0 include/trace/events/lock.h:122
>  __do_trace_contention_end include/trace/events/lock.h:122 [inline]
>  trace_contention_end+0x111/0x140 include/trace/events/lock.h:122
>  __pv_queued_spin_lock_slowpath+0x9f9/0xb60 kernel/locking/qspinlock.c:374
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:557 [inline]
>  queued_spin_lock_slowpath+0x43/0x50 arch/x86/include/asm/qspinlock.h:51
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x21f/0x290 kernel/locking/spinlock_debug.c:116
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>  _raw_spin_lock_irqsave+0xb3/0xf0 kernel/locking/spinlock.c:162
>  __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
>  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:474 [inline]
>  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:466
>  bpf_prog_6979e45824a16319+0x36/0x66
>  bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
>  bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2298
>  __bpf_trace_tlb_flush+0xf5/0x150 include/trace/events/tlb.h:38
>  __traceiter_tlb_flush+0x76/0xd0 include/trace/events/tlb.h:38
>  __do_trace_tlb_flush include/trace/events/tlb.h:38 [inline]
>  trace_tlb_flush+0x115/0x140 include/trace/events/tlb.h:38
>  native_flush_tlb_multi+0x78/0x140 arch/x86/mm/tlb.c:-1
>  __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
>  flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
>  flush_tlb_mm_range+0x6b1/0x12d0 arch/x86/mm/tlb.c:1451
>  flush_tlb_page arch/x86/include/asm/tlbflush.h:324 [inline]
>  ptep_clear_flush+0x120/0x170 mm/pgtable-generic.c:101
>  wp_page_copy mm/memory.c:3618 [inline]
>  do_wp_page+0x1bc2/0x5800 mm/memory.c:4013
>  handle_pte_fault mm/memory.c:6068 [inline]
>  __handle_mm_fault+0x1033/0x5440 mm/memory.c:6195
>  handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
>  do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
>  handle_page_fault arch/x86/mm/fault.c:1476 [inline]
>  exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> RIP: 0033:0x410964
> Code: b9 01 00 00 00 90 e8 3b 36 06 00 84 00 48 8d 50 10 83 3d be 5f d9 02 00 74 10 e8 87 d9 06 00 49 89 13 48 8b 48 10 49 89 4b 08 <48> 89 50 10 48 89 c1 48 8b 54 24 20 48 8b 1a 66 89 59 18 83 3d 92
> RSP: 002b:000000c0000e7608 EFLAGS: 00010246
> RAX: 000000c0080e0000 RBX: 0000000000000070 RCX: 0000000007b2a8a0
> RDX: 000000c0080e0010 RSI: 000000000b1130e1 RDI: 0000000009e14d67
> RBP: 000000c0000e7638 R08: 00007f16e8ad96e0 R09: 7fffffffffffffff
> R10: 0000000000000001 R11: 00007f16e8a2e000 R12: 000000c0080e0000
> R13: 0000000000000049 R14: 000000c0026156c0 R15: 000000c0080c1c20
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


