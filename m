Return-Path: <bpf+bounces-45885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4D9DEB47
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 17:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788AA1632AB
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960BC19E7D0;
	Fri, 29 Nov 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtrZV5wI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E613BAEE;
	Fri, 29 Nov 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898875; cv=none; b=Tug41jAbBLi+vlPtO9gfNmzDoikdtgrkM67mWrkpgeaERwBgyZvA9Ycox1+ZTNJhxqvyQsciJoRZCJ2z9VkIP+VyOFPxO71eu1pmAuea4miLnG609d2CcKWMuHTvpMn/c1aMoXUNPqscV6Zr6lIRWCyFfzqhbs5xjjPjGzaT3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898875; c=relaxed/simple;
	bh=myi8u3L0S2X9u2wt6lQz/yzhSURCuPbYSNCaK+PFc+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv9n3jCPwjWw30hTJqp4QO0lQdh3Ra2MwoHBYmdmp/SBgYT8/2+iPoDOEvPPPmcCWDyZWqPSUkpZ5+ALq9z3zOkIgATsM6xlw20MUe3o0WSF+1Ruw83zpnhBGn6A1qU5WiXZZfxEl+/hSVog7OLkM/79XG2XlZ/877Qp9AJdehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtrZV5wI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso18853585e9.2;
        Fri, 29 Nov 2024 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732898871; x=1733503671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njiWLUqhzSqEsvpT1b5ZOQ0Wocbv4YgfWcfu80dicKM=;
        b=FtrZV5wIv0wIQ2yb5hhUWHvf7rP3nhvejDg6hiJF5quAgl/9QJsvyrhhUZdrOErx/u
         1AQtwhrgbKs3TTOpRnb8Iprh+vm/PINKXYvYpYN+AxUWpB0LfJPtG/87yZzByquEi+28
         Be7j9lqEVHSibFIREjKAo/DQl13+AdpvPP3jIopCk77I090SpEcm1VDBmWejGv6w9b5K
         LKOlxKYVwvzd/fJCc/FHQAAG/KD9RuR13i3FEGdY+bmSL/jQWxeeO7MwNCHwsBnTnYmI
         iZ8lYJ6Dzj2Cfg76BlkDomHMs5MOGupcxTBBw/BSXbDoULHRvVdMTpWJk9FP1/yAaoxV
         NfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898871; x=1733503671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njiWLUqhzSqEsvpT1b5ZOQ0Wocbv4YgfWcfu80dicKM=;
        b=wstqMQEsjP5MVavlvjXyqeXCSOdGaxPkcNojNFqJD0VKe6COVYI4J+JWKGNCCTfn5v
         WWO8JgG9LNwM0XxM1ktwztHgAqYWkNyF3EOxaoVGDCeeDjwpjDk0TjYupvZEFpxwuRBF
         vGp0EeAodoOBL2ZZYooaVJ5SY0uAyKgHlrUB+F1IDyF/9/0sidmn1BMpN5LQmMXdh7ng
         ki/bQmeY4UNb6pcppLqe3bCT8DLWMImacdWj5aSVl/MiQpaVoQbdAJe4UFgmrMVDokj/
         /t0djZlezq1GbMk0GsujMkFacyj+8/KSXvUTkRvOPqspAM3B3aTxbUfTP9yOtmknYmnr
         LJeA==
X-Forwarded-Encrypted: i=1; AJvYcCU3BVy6cWTs3Twq8sNLx7OEZWgaXH2O1xW78TC6fPP+Gl8Vc3ozkBbG4vG1iU5XSL+DwZ7JrzYhSpWZaSk5ZkCyYbjJ@vger.kernel.org, AJvYcCUyXg6eQ7VrjiozmsbbA663amS80uyn3uZs9bKOrhBM4d4uDwWGu04W6rvbkz8YdWrghBw=@vger.kernel.org, AJvYcCWNczCeMXSPdwpiNE54Q5z5r34SvdbNYITkFNp0yzyrRIUL9JTK8TxuMHiN5Xdt2h+BrvERCDMCP9GuTIxh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo+Hbj44hnT1J+DYfMalxJZ9UL0EJoo6v3kKDWCjstHhDk50I2
	hbV2oxnyEDB+wOQug62GOti6HpAJGWyK7lQe5xVbE33V+exN3SCrnKEXCCkDpeeUCpt+xTyt1yI
	9UwfqucfW3kzOe5mWnKG21FeAp/w=
X-Gm-Gg: ASbGncsqJGzxsSMySiPl0wVu+vYe+IN/udBrNj2RH5RRRaRh+Gb5ovBL/mEoTzevoAv
	7ru/avL/hOOd42QT5bfkb9svoWKAutg==
X-Google-Smtp-Source: AGHT+IEugmqdzq7u8eYGM7hj4mgchAkSwFwnEcPqAc1HS4LqPwRfGqwVsbF1x49xPBKCghubzcj8NXM0ZqNlvrMndS0=
X-Received: by 2002:a05:600c:4f08:b0:434:a179:71b8 with SMTP id
 5b1f17b1804b1-434a9dbbc2cmr97208355e9.1.1732898871158; Fri, 29 Nov 2024
 08:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67486b09.050a0220.253251.0084.GAE@google.com>
In-Reply-To: <67486b09.050a0220.253251.0084.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Nov 2024 08:47:40 -0800
Message-ID: <CAADnVQKdRWA1zG6X4XNwOWtKiUHN-SRREYN_DCNU59LsK8S5LA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
To: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Puranjay, Andrii and All,

looks like if (irqs_disabled()) is not enough.
Should we change it to preemptible() ?

It will likely make it async all the time,
but in this it's an ok trade off?


On Thu, Nov 28, 2024 at 5:07=E2=80=AFAM syzbot
<syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2c22dc1ee3a1 Merge tag 'mailbox-v6.13' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f2bee858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8df9bf3383f59=
70
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D97da3d7e0112d59=
971de
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9137c3e19e21/dis=
k-2c22dc1e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1aad80837d89/vmlinu=
x-2c22dc1e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d7979d71d6d2/b=
zImage-2c22dc1e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ BUG: Invalid wait context ]
> 6.12.0-syzkaller-09435-g2c22dc1ee3a1 #0 Not tainted
> -----------------------------
> iou-wrk-9958/9967 is trying to lock:
> ffff88802744ae58 (&sighand->siglock){-.-.}-{3:3}, at: __lock_task_sighand=
+0x149/0x2d0 kernel/signal.c:1379
> other info that might help us debug this:
> context-{5:5}
> 3 locks held by iou-wrk-9958/9967:
>  #0: ffff88814d2870c0 (&acct->lock){+.+.}-{2:2}, at: io_acct_run_queue io=
_uring/io-wq.c:260 [inline]
>  #0: ffff88814d2870c0 (&acct->lock){+.+.}-{2:2}, at: io_wq_worker+0x44b/0=
xed0 io_uring/io-wq.c:654
>  #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:337 [inline]
>  #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:849 [inline]
>  #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run ke=
rnel/trace/bpf_trace.c:2350 [inline]
>  #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1=
fc/0x540 kernel/trace/bpf_trace.c:2392
>  #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:337 [inline]
>  #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:849 [inline]
>  #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: __lock_task_sighan=
d+0x29/0x2d0 kernel/signal.c:1362
> stack backtrace:
> CPU: 1 UID: 0 PID: 9967 Comm: iou-wrk-9958 Not tainted 6.12.0-syzkaller-0=
9435-g2c22dc1ee3a1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
>  check_wait_context kernel/locking/lockdep.c:4898 [inline]
>  __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>  __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1379
>  lock_task_sighand include/linux/sched/signal.h:743 [inline]
>  do_send_sig_info kernel/signal.c:1267 [inline]
>  group_send_sig_info+0x274/0x310 kernel/signal.c:1418
>  bpf_send_signal_common+0x3c4/0x630 kernel/trace/bpf_trace.c:881
>  ____bpf_send_signal kernel/trace/bpf_trace.c:886 [inline]
>  bpf_send_signal+0x1d/0x30 kernel/trace/bpf_trace.c:884
>  bpf_prog_631417f49dd64198+0x25/0x48
>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>  bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2392
>  trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
>  __pv_queued_spin_lock_slowpath+0xb7e/0xdb0 kernel/locking/qspinlock.c:55=
7
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline=
]
>  queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
>  io_acct_run_queue io_uring/io-wq.c:260 [inline]
>  io_wq_worker+0x44b/0xed0 io_uring/io-wq.c:654
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

