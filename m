Return-Path: <bpf+bounces-55765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A79A864D0
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE711B8489F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15384236A6B;
	Fri, 11 Apr 2025 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG7t/8fP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F861EE7DC;
	Fri, 11 Apr 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392755; cv=none; b=MYzJQI3gamv5ooaB2o9fNZOqnpOOAEWfHuZMX0zzH61ITJzRB5nEWLcQCLJ1D0f2XsdxOGe/VMiJQ6MjzRclkMeyb69OYMSQxFha03lXP1GGbEX1XfVIX3cD6j7BgMcvMhZ8XOVePi54j1ffOYg4l47MeJFjtIV58wubuJYA3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392755; c=relaxed/simple;
	bh=qEFwlwFU8JzVdNNkeYufW32qp80etZKdwBROax8UN6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkuvxoQUqyBlh4b4XcSrFZgmigUJGn4CLH1h0TJ9Koo3LAyfDaK7hwlLP5DWQaZatqH7y66TjdHdJCTXvaoGH1W7eTJ1vkSecfK4ZPg48CipGxq68boLdA0poEZn9oJ4KGRpmNdyydNrPjWit36ZcK1Gg0P9WxjXLVvx7fgq1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG7t/8fP; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso5822098a12.0;
        Fri, 11 Apr 2025 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744392752; x=1744997552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQWkltRQiXKa1eCWkClFhYuqHVMPhzVxPWnvXGgLhs4=;
        b=BG7t/8fPSP2oOGvFyXCGrx7LJzLygJ0FnNvEmYIzuxCd/lF88giQUkUStm++jCawvX
         mYtroWRcRKhJHyPtzs1YR/FkjsCjE0w3Gsm6NPwr0zNyBL0iuG1ywQUiFqpXVxCLVNiC
         0STkB6j5yJrAtwYXlYu57FyRWUGnbviW9ns8wkYE9Wd4+IdZHsuhoEIwh89VOk51diii
         vYFSLZSYYtt9SXdHPc+EVvCTgXMj/rOhTel2VvQOhPQwN5cRXj7UUg9Bhvk3AjAcOtNi
         ZuRG51H0dylESw+B83siEbLsV5wn73+sF2aGzzJENpDsZ+TOTYd6ZMahUK11Z1DxDE3D
         na/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392752; x=1744997552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQWkltRQiXKa1eCWkClFhYuqHVMPhzVxPWnvXGgLhs4=;
        b=XfHoy/ZmG+vcI0VoRYpDO592GybSlIKC+V41IB/kQ3L+/kl0peXWQp2zEdGwpLifxf
         sSdUiHSyVUxdUPLMxpRk1Hq4bL62R/SWW7A7X4KEWTPvJ0OYY1h7Re2aKNuPVp+gORTs
         W/pKoUX5sFX1KR82107o2UtWbNf4QuHN4N1XjxVJzYajc5saigkKex45DKrmzHT9rrCm
         Y9q+rl/IQkH6XD5xzMi9OOyAICTPTnDUOIfvznwuboFiKu2dx6J7a0Rihi4ek9Gd8qgN
         7zNy1T2GeFi8QVlUNrJQkx8xvuGqw+zgAMY7vCAGaCSFPKZwuDZ8BLLFm/sEes+3lXmM
         AyMg==
X-Forwarded-Encrypted: i=1; AJvYcCUK1NaGG3AFIl7Q7VBcGxijr2k0CtAepioFLCcepseeTCC3qlbEAKE6YG1wmrAK85ffvZU=@vger.kernel.org, AJvYcCVfEJMTMAfri1w5oZxnYQjpKiIkykhi7TadJKpRMFFGK4XJ4qAKV/KjasQUIazkyaQuaY17a0SRqzpsNsns@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKWdpOSZm6ZlPIC/0z9+HWO47GG010HWVoMx33fF9JPkzbVyi
	UaQoFngXMR2NYFOR4IqwDkgmhFEr/prJXEOGXUvPEWM+yiH+Jb8Bq6U8w6ykNGfIbkhezcs0gSA
	QG+MIUigd866EtAEu/2p1fajZfgI=
X-Gm-Gg: ASbGncvyl+wh/pmgYYkRGS0r5Wf7AL7ctJEGu4CbcTqYsQU3Zz2jOxfBBTPnezTYa4C
	ytvw1geO+vRxy0sMsZ+xnlhhzXOBl9LSan7yK0xSCFaQVxLNPim0sg0xrsrSpgr56HoLTFujZgu
	S6jjkx36tZcO+RPikwjtSv5E7a8KJb1fWjxd7DBwt9zME0tpAcURm97kM8
X-Google-Smtp-Source: AGHT+IGhPAu9n9VXjlg2RHiZRNKWBPAVLDUMWnZ2OaaXl0Ti6pCozccP+CBJZa9mwAJfUrRn4iQj3D07Zzhh1UZeIcI=
X-Received: by 2002:a05:6402:1d51:b0:5f3:4606:14c5 with SMTP id
 4fb4d7f45d1cf-5f3639f4267mr2980051a12.15.1744392751690; Fri, 11 Apr 2025
 10:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP01T76CVtC=z=JYP+HFtVrfkrZjuiR20xLWtHkshGjoA77MwA@mail.gmail.com>
 <67f94f0a.050a0220.2c5fcf.0003.GAE@google.com>
In-Reply-To: <67f94f0a.050a0220.2c5fcf.0003.GAE@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Apr 2025 19:31:55 +0200
X-Gm-Features: ATxdqUHzn-2AQVmIwGFxxAXqWLLaom16eXSWKUCzxwHi-ZpA9yS9jxukdZE-ip0
Message-ID: <CAP01T74p7xy9riqMYiaZ563p0xd=QUWyPseHkNe_037wAdnu3Q@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
To: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@meta.com, kkd@meta.com, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 19:19, syzbot
<syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> possible deadlock in __bpf_ringbuf_reserve
>
> ============================================
> WARNING: possible recursive locking detected
> 6.15.0-rc1-syzkaller-ge618ee89561b #0 Not tainted
> --------------------------------------------
> kworker/2:3/6044 is trying to acquire lock:
> ffffc90006f360d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x36e/0x4b0 kernel/bpf/ringbuf.c:423
>
> but task is already holding lock:
> ffffc900070410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x36e/0x4b0 kernel/bpf/ringbuf.c:423
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
>
> 6 locks held by kworker/2:3/6044:
>  #0: ffff88801b48ad48 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
>  #1: ffffc90004c1fd18 ((work_completion)(&(&ssp->srcu_sup->work)->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
>  #2: ffff88801ea8f158 (&ssp->srcu_sup->srcu_gp_mutex){+.+.}-{4:4}, at: srcu_advance_state kernel/rcu/srcutree.c:1701 [inline]
>  #2: ffff88801ea8f158 (&ssp->srcu_sup->srcu_gp_mutex){+.+.}-{4:4}, at: process_srcu+0x73/0x1920 kernel/rcu/srcutree.c:1861
>  #3: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #3: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #3: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2362 [inline]
>  #3: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1b6/0x590 kernel/trace/bpf_trace.c:2404
>  #4: ffffc900070410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x36e/0x4b0 kernel/bpf/ringbuf.c:423
>  #5: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #5: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #5: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2362 [inline]
>  #5: ffffffff8e3c15c0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1b6/0x590 kernel/trace/bpf_trace.c:2404
>
> stack backtrace:
> CPU: 2 UID: 0 PID: 6044 Comm: kworker/2:3 Not tainted 6.15.0-rc1-syzkaller-ge618ee89561b #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: rcu_gp process_srcu
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3042
>  check_deadlock kernel/locking/lockdep.c:3094 [inline]
>  validate_chain kernel/locking/lockdep.c:3896 [inline]
>  __lock_acquire+0xff7/0x1ba0 kernel/locking/lockdep.c:5235
>  lock_acquire kernel/locking/lockdep.c:5866 [inline]
>  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
>  __bpf_ringbuf_reserve+0x36e/0x4b0 kernel/bpf/ringbuf.c:423
>  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:474 [inline]
>  bpf_ringbuf_reserve+0x57/0x90 kernel/bpf/ringbuf.c:466
>  bpf_prog_385141c453c15099+0x36/0x5d
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>  bpf_trace_run2+0x230/0x590 kernel/trace/bpf_trace.c:2404
>  __bpf_trace_contention_begin+0xc9/0x110 include/trace/events/lock.h:95
>  __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
>  __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:95 [inline]
>  class_preempt_notrace_destructor include/linux/preempt.h:482 [inline]
>  __do_trace_contention_begin include/trace/events/lock.h:95 [inline]
>  trace_contention_begin.constprop.0+0xde/0x160 include/trace/events/lock.h:95
>  __pv_queued_spin_lock_slowpath+0x109/0xcf0 kernel/locking/qspinlock.c:219
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:572 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:116
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>  _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
>  __bpf_ringbuf_reserve+0x36e/0x4b0 kernel/bpf/ringbuf.c:423
>  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:474 [inline]
>  bpf_ringbuf_reserve+0x57/0x90 kernel/bpf/ringbuf.c:466
>  bpf_prog_385141c453c15099+0x36/0x5d
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>  bpf_trace_run2+0x230/0x590 kernel/trace/bpf_trace.c:2404
>  __bpf_trace_contention_begin+0xc9/0x110 include/trace/events/lock.h:95
>  __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
>  __do_trace_contention_begin include/trace/events/lock.h:95 [inline]
>  trace_contention_begin+0xc1/0x130 include/trace/events/lock.h:95
>  __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>  __mutex_lock+0x1a6/0xb90 kernel/locking/mutex.c:746
>  srcu_advance_state kernel/rcu/srcutree.c:1701 [inline]
>  process_srcu+0x73/0x1920 kernel/rcu/srcutree.c:1861
>  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c2/0x780 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
>
> Tested on:
>
> commit:         e618ee89 Merge tag 'spi-fix-v6.15-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10461c04580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=36c5de4d99134dda
> dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Note: no patches were applied.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

