Return-Path: <bpf+bounces-46317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C854E9E786C
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B50287496
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0B1F3D5B;
	Fri,  6 Dec 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X85CUSIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD1194A63;
	Fri,  6 Dec 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511575; cv=none; b=nvNr7OjMBT2GIBYxT/wiaxhkDILwHC/01uf+gbNMbgQ9UlySJ5gDAVwruzDMZm8mQabs6Qx7jnEi+KgF8GU5DTsQBPHcIyTgnuxc899cLpZRg8JwA289LH2PSEoEbo4yJHc2Tl90/fC0VNXwiYpZJXvE8iGYNQ0p+VJP8n0H+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511575; c=relaxed/simple;
	bh=mG32b1snqLGPXYx2SPHkihGUBJaFvDrpwdV8i4JjyO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNYpzptN2HXBoqLFtIJUv28X0mgjH7ki2A5xQwpHtdhhz5p37Zkyu53m2QnREJZASBUK0f21bBMjObI7s5Xmi/Iuq9xgxVe1ghrDIjqYbqv41Cbny3ulh/SK2KXCWJroSIkOqelI0BQrxL1Z9NZZihsIVqgr4acgHjoJMW7suOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X85CUSIQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434e669342eso1064005e9.1;
        Fri, 06 Dec 2024 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733511572; x=1734116372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEGEeIp0p7xkMoeyhruxjGU/UMioepaX8K+P4hmeEMw=;
        b=X85CUSIQViyj2HyjyyfPQ/xzrGthTyJvxOF0iNJcCIsyoAoXKHVvMILQdLXhdNDtbl
         Il7Ikn+vYEEqATCodbzIlN32oTRoPxSyO3cxpcVPnBsmRU2gflbVpxV3Rs5SlOj3e6U8
         BAGpBZg2It/Pts2M0e3zEi3ePIu12y+xyoubcIwsnF/FXJHvAY0HCyziwBg63G8ltju6
         NRG2926sJEFe6Qdu+km/TJ4SW7PVTOUcBPxN17gxpEH5t0q4WSK9nuy6AxZnj/vczCzG
         ATg36o4KwOtPMBpg32QkK39RESXZQbeXJhRYoht8JLY3e33TltRdCKq3UbAWxU+U/BsX
         2DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511572; x=1734116372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEGEeIp0p7xkMoeyhruxjGU/UMioepaX8K+P4hmeEMw=;
        b=bo35/aHoEonWr6aybhcqeAOr8Jr027KHmiJ7HHCdNJUEeQoqGpZUfUtZK2jekLkMsy
         v0VOnnCBog671ze5jFDPD26sGbaswZeQkhkqnmQKTX9uPHhUoca0Ob069qC36mNXdx+F
         shgYlq2RayAdVFvkWmUy7WrBTO0EkJ2Yn3U3fhIVGEELJnpRjs4xJdVx8xCGatMb9E0N
         XIoA84L1uuipzqc1Wlg3aZDs/EOJBUEqRlYGwoVNxrHPBejyYinWiQPG/JHC6ML4RNyf
         DpCg9bBvbg67zfK/33SFj3RExmrXD9nDDbMe1IIgddjnFJTkR/gWQJ25kx5MNw/s6mLo
         0fLA==
X-Forwarded-Encrypted: i=1; AJvYcCX36enmUdkhJE4JUPefweblKQTxhub7MKDfzcKMPSgCB/VAvkQYSZAjIm4eIC6v7wQ6Ftc=@vger.kernel.org, AJvYcCXrGTm4lVtPSRWOqzFoAmAc6hD5ElREVO726ZCgcLYc/GR1OSelMd+OS1wHvtEfYLnK1M979HNkondA0VGp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xyfQRwSi/B24ACMX8kTSikAWeYKZpTIM/5HvVc8wqSCQVJWK
	InrWrG6OsebF69G/K7ziwJRKf8VFVi4aB3phmHzWs5FJczuUS0jgPE1lUD66m9ZMSsCqDvfMahY
	fSSZlYzD1BltL7n1ixU6Pn8TW7Us=
X-Gm-Gg: ASbGncusHsals51A6xQN2oQyWH4yQuKqJaT2oVjcY2mxGykvr/um9OHyjR4WbEqN9rP
	IwBZqcQBXOkvaJAHJvy02PUX0P5ICMyQUSrDCxyxRg1usgL0=
X-Google-Smtp-Source: AGHT+IFKmEkyO1hlok5HRV16FAhpzcyfVGw+FBhgRTgdJd/0MTfqXq4Bjd7RKHnUdSzn3Sq7zz+RUR7CemFF7X83K5I=
X-Received: by 2002:a05:6000:2c6:b0:386:3262:cd7d with SMTP id
 ffacd0b85a97d-3863262d11dmr960404f8f.45.1733511571372; Fri, 06 Dec 2024
 10:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675302fd.050a0220.2477f.0004.GAE@google.com>
In-Reply-To: <675302fd.050a0220.2477f.0004.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 10:59:20 -0800
Message-ID: <CAADnVQJVJADKw0KC6GzhSOjA8DJFammARKwVh+TeNAD7U3h91A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in htab_lru_map_delete_elem
To: syzbot <syzbot+0a26db48dcd6d80be6c0@syzkaller.appspotmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kumar,

check out this ABBA deadlock that your upcoming resilient
spin lock should address.
There are two hash maps and though we have htab->map_locked
recursion protection it doesn't help here.

On Fri, Dec 6, 2024 at 5:58=E2=80=AFAM syzbot
<syzbot+0a26db48dcd6d80be6c0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ke=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1476e0f858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6851fe4f61792=
030
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0a26db48dcd6d80=
be6c0
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17d9c8df980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1276e0f858000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e9751e7030ea/vmlinu=
x-feffde68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f7bf928b44d6/b=
zImage-feffde68.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0a26db48dcd6d80be6c0@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0 Not tainted
> ------------------------------------------------------
> syz-executor207/6807 is trying to acquire lock:
> ffff88802632eca0 (&htab->lockdep_key#434){....}-{2:2}, at: htab_lock_buck=
et kernel/bpf/hashtab.c:167 [inline]
> ffff88802632eca0 (&htab->lockdep_key#434){....}-{2:2}, at: htab_lru_map_d=
elete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>
> but task is already holding lock:
> ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lock_buck=
et kernel/bpf/hashtab.c:167 [inline]
> ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lru_map_d=
elete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&htab->lockdep_key#435){....}-{2:2}:
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
>        htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>        bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>        bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>        __bpf_prog_run include/linux/filter.h:701 [inline]
>        bpf_prog_run include/linux/filter.h:708 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>        bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
>        __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.=
h:95
>        __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h=
:95
>        __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [in=
line]
>        class_preempt_notrace_destructor include/linux/preempt.h:481 [inli=
ne]
>        trace_contention_begin.constprop.0+0xf3/0x170 include/trace/events=
/lock.h:95
>        __pv_queued_spin_lock_slowpath+0x10b/0xc90 kernel/locking/qspinloc=
k.c:402
>        pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [=
inline]
>        queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inl=
ine]
>        queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>        do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
>        htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
>        htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>        bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>        bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>        __bpf_prog_run include/linux/filter.h:701 [inline]
>        bpf_prog_run include/linux/filter.h:708 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>        bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
>        __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.=
h:95
>        __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h=
:95
>        trace_contention_begin+0xd2/0x140 include/trace/events/lock.h:95
>        __mutex_lock_common kernel/locking/mutex.c:587 [inline]
>        __mutex_lock+0x1a8/0xa60 kernel/locking/mutex.c:735
>        futex_cleanup_begin kernel/futex/core.c:1070 [inline]
>        futex_exit_release+0x2a/0x220 kernel/futex/core.c:1122
>        exit_mm_release+0x19/0x30 kernel/fork.c:1660
>        exit_mm kernel/exit.c:543 [inline]
>        do_exit+0x88b/0x2d70 kernel/exit.c:925
>        do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
>        __do_sys_exit_group kernel/exit.c:1098 [inline]
>        __se_sys_exit_group kernel/exit.c:1096 [inline]
>        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
>        x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls=
_64.h:232
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&htab->lockdep_key#434){....}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain kernel/locking/lockdep.c:3904 [inline]
>        __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
>        lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
>        htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>        bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>        bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>        __bpf_prog_run include/linux/filter.h:701 [inline]
>        bpf_prog_run include/linux/filter.h:708 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>        bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
>        __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.=
h:95
>        __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h=
:95
>        __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [in=
line]
>        class_preempt_notrace_destructor include/linux/preempt.h:481 [inli=
ne]
>        trace_contention_begin.constprop.0+0xf3/0x170 include/trace/events=
/lock.h:95
>        __pv_queued_spin_lock_slowpath+0x10b/0xc90 kernel/locking/qspinloc=
k.c:402
>        pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [=
inline]
>        queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inl=
ine]
>        queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>        do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
>        htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
>        htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>        bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>        bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>        __bpf_prog_run include/linux/filter.h:701 [inline]
>        bpf_prog_run include/linux/filter.h:708 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>        bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
>        __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.=
h:95
>        __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h=
:95
>        trace_contention_begin+0xd2/0x140 include/trace/events/lock.h:95
>        __mutex_lock_common kernel/locking/mutex.c:587 [inline]
>        __mutex_lock+0x1a8/0xa60 kernel/locking/mutex.c:735
>        uprobe_clear_state+0x4b/0x1a0 kernel/events/uprobes.c:1771
>        __mmput+0x79/0x4c0 kernel/fork.c:1349
>        mmput+0x62/0x70 kernel/fork.c:1375
>        exit_mm kernel/exit.c:570 [inline]
>        do_exit+0x9bf/0x2d70 kernel/exit.c:925
>        do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
>        __do_sys_exit_group kernel/exit.c:1098 [inline]
>        __se_sys_exit_group kernel/exit.c:1096 [inline]
>        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
>        x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls=
_64.h:232
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&htab->lockdep_key#435);
>                                lock(&htab->lockdep_key#434);
>                                lock(&htab->lockdep_key#435);
>   lock(&htab->lockdep_key#434);
>
>  *** DEADLOCK ***
>
> 4 locks held by syz-executor207/6807:
>  #0: ffffffff8e2d69e8 (delayed_uprobe_lock){+.+.}-{4:4}, at: uprobe_clear=
_state+0x4b/0x1a0 kernel/events/uprobes.c:1771
>  #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:337 [inline]
>  #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:849 [inline]
>  #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run ke=
rnel/trace/bpf_trace.c:2350 [inline]
>  #1: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1=
c2/0x590 kernel/trace/bpf_trace.c:2392
>  #2: ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lock=
_bucket kernel/bpf/hashtab.c:167 [inline]
>  #2: ffff888031440e20 (&htab->lockdep_key#435){....}-{2:2}, at: htab_lru_=
map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>  #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:337 [inline]
>  #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:849 [inline]
>  #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run ke=
rnel/trace/bpf_trace.c:2350 [inline]
>  #3: ffffffff8e1bb500 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1=
c2/0x590 kernel/trace/bpf_trace.c:2392
>
> stack backtrace:
> CPU: 3 UID: 0 PID: 6807 Comm: syz-executor207 Not tainted 6.13.0-rc1-syzk=
aller-00025-gfeffde684ac2 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain kernel/locking/lockdep.c:3904 [inline]
>  __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
>  htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>  bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
>  __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
>  __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
>  __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
>  class_preempt_notrace_destructor include/linux/preempt.h:481 [inline]
>  trace_contention_begin.constprop.0+0xf3/0x170 include/trace/events/lock.=
h:95
>  __pv_queued_spin_lock_slowpath+0x10b/0xc90 kernel/locking/qspinlock.c:40=
2
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline=
]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
>  htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
>  htab_lru_map_delete_elem+0x1c8/0x790 kernel/bpf/hashtab.c:1484
>  bpf_prog_2c29ac5cdc6b1842+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
>  bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2392
>  __bpf_trace_contention_begin+0xca/0x110 include/trace/events/lock.h:95
>  __traceiter_contention_begin+0x5a/0xa0 include/trace/events/lock.h:95
>  trace_contention_begin+0xd2/0x140 include/trace/events/lock.h:95
>  __mutex_lock_common kernel/locking/mutex.c:587 [inline]
>  __mutex_lock+0x1a8/0xa60 kernel/locking/mutex.c:735
>  uprobe_clear_state+0x4b/0x1a0 kernel/events/uprobes.c:1771
>  __mmput+0x79/0x4c0 kernel/fork.c:1349
>  mmput+0x62/0x70 kernel/fork.c:1375
>  exit_mm kernel/exit.c:570 [inline]
>  do_exit+0x9bf/0x2d70 kernel/exit.c:925
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
>  __do_sys_exit_group kernel/exit.c:1098 [inline]
>  __se_sys_exit_group kernel/exit.c:1096 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
>  x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe3838cedf9
> Code: Unable to access opcode bytes at 0x7fe3838cedcf.
> RSP: 002b:00007ffd9c887888 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe3838cedf9
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007fe38395b390 R08: ffffffffffffffb0 R09: 00007ffd9c887910
> R10: 00007ffd9c887910 R11: 0000000000000246 R12: 00007fe38395b390
> R13: 0000000000000000 R14: 00007fe38395bf20 R15: 00007fe38389c900
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

