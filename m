Return-Path: <bpf+bounces-27833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FE8B27C7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D766B2399C
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7914EC5D;
	Thu, 25 Apr 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giFL9PJq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42314E2F8;
	Thu, 25 Apr 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067672; cv=none; b=QaCOduFLmG15PwKtOG+k9G1Wgi55LUTK3nWRrjiL6O/9DebgUqyjmlllT0UCmBlHDCt9L2IFD/Qdu+WKzEMPyTKmkgbywUnnnP5SJfzdmIXRWwsZXMQ8fd/PyCqWwozMy9SFbpO6q1e8h4T2h6QWwJM49pxwAXmbyqEoQufbp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067672; c=relaxed/simple;
	bh=yVpjVKkZIJRfENJCjZjedcvfBPVyt4aQA7kriye5zPM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fofV7kYtpRvhewlw0EKEhmDJO8Ujo20yXZocqk/klM/O3eMe0E11/yjcfdhFUlhsQjPIE2AT/cEz/qpV34D9NNFGH3cAltgaQ+OhK5lJ79lsklwGcn+koRYpq4aGHuxpdvi8R6UJHj7uWuGYjM9ScuDV6paaV4rL9bAhjj3499M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giFL9PJq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so1587192a12.1;
        Thu, 25 Apr 2024 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714067669; x=1714672469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejeP9dXrfzEo4Kz+4ZR1u+AqeitnQxmje6orllnw+G0=;
        b=giFL9PJqEXYZAzooWANW5E3gygHG+Tbj/2eEJXPsQI47/zZAQV4fFWWNPRSvOe2zqa
         4JuMMx7uLH8VrqdyJVRLbiW+nNDf2Th1N1LWwJ42KVhdTTH3NxJV1iq/VhCdldw5BctZ
         +AJsYx36SD3DN5/WKWZcs3INp1wTk0PXATrRF8/LFhkfa7oDWOrrkNorEYZlUAhgTtDq
         n8WCs6Un+opg+8caMiWizaMMgbAcqp0yxahRsQuQAQ5rS4Grv4FP3MAqV0MXKHczPns7
         mgszo8CIHMxHRQ6BYCZuB3wJhKnmtBsM7GWy/nBUpZRet5eykmVhbas12paIx74Y/ATf
         vbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714067669; x=1714672469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejeP9dXrfzEo4Kz+4ZR1u+AqeitnQxmje6orllnw+G0=;
        b=QXxzSKhtdPvTqIeH21JhYm0GmWOI824opEdX/6JLva/Jg75anNr1Y1Db1wHvVLgfb9
         kHoKEKqNB7QTXvvDC6E044+tlkYo5kd6CRkA8poJdOd9I+LrK9Bx6Zwt4OlQfTCw+lEb
         jngan8MaNaAe8t/q1+ulTPDAr72Recgjpnz+th3I6nBscM9z8qndT8Dc7Brhr2z7VyIC
         r/Yw+BU2bGqUxQvwrJW6GQOYAahyhAx6jyeA1r6TTCYWkHOewlAbgyUKeTyZuuoCStIx
         R0+aLH0+PIsbnegtxvwvtAlqn3py8OSyQPtGibu3momK7PX/2zEdW3O+PClxRJqPSgYh
         FI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYVYnZDJDQs8EHHS66nH1Ul/I06hBUvnFaD7/0NHRKgpZdfSVCP7ja2llm6dyaGT4ndxUAfSef0FAx5XA3IK4DFYfMWb1wquxIsxDQ4DfLh9muxcz+HFI3AibG2fNO3T9/zJwX0FbscgjU2K53ocMPiTbTwblmJusXPkjlrPus79UcShxC
X-Gm-Message-State: AOJu0Yy5eskNLz/K4exgA2vOgrKAQo2QguNQSCOPjiS/+8MyFhIX7Q93
	xvvoYsTeyhfOtJ3d66anuKy691UAKIrj74PqkdhoLipjZFoIta5N
X-Google-Smtp-Source: AGHT+IECqaSSIV584frzrNrjTkUNt1d9IsYBrcrMa++x9CGGvnoHlQfzWYQitSlVi3nFIjEAaz+sPA==
X-Received: by 2002:a17:906:4bd0:b0:a56:ee1:5695 with SMTP id x16-20020a1709064bd000b00a560ee15695mr332036ejv.19.1714067668301;
        Thu, 25 Apr 2024 10:54:28 -0700 (PDT)
Received: from krava ([2a00:102a:4022:13b8:3d99:aea7:b18a:a8d7])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709062b4a00b00a58b1cf96bbsm1032475ejg.179.2024.04.25.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:54:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Apr 2024 19:54:24 +0200
To: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in
 force_sig_info_to_task
Message-ID: <ZiqY0OAHQlNUIrbD@krava>
References: <000000000000d5f4fc0616e816d4@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d5f4fc0616e816d4@google.com>

On Thu, Apr 25, 2024 at 02:05:31AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17080d20980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
> dashboard link: https://syzkaller.appspot.com/bug?extid=83e7f982ca045ab4405c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/549d1add1da9/disk-977b1ef5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3e8e501c8aa2/vmlinux-977b1ef5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d02f7cb905b8/bzImage-977b1ef5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0 Not tainted
> ------------------------------------------------------
> syz-executor.0/11241 is trying to acquire lock:
> ffff888020a2c0d8 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
> 
> but task is already holding lock:
> ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&rq->__lock){-.-.}-{2:2}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
>        raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
>        raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
>        _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1404 [inline]
>        rq_lock_irqsave kernel/sched/sched.h:1683 [inline]
>        class_rq_lock_irqsave_constructor kernel/sched/sched.h:1737 [inline]
>        sched_mm_cid_exit_signals+0x17b/0x4b0 kernel/sched/core.c:12005
>        exit_signals+0x2a1/0x5c0 kernel/signal.c:3016
>        do_exit+0x6a8/0x27e0 kernel/exit.c:837
>        __do_sys_exit kernel/exit.c:994 [inline]
>        __se_sys_exit kernel/exit.c:992 [inline]
>        __pfx___ia32_sys_exit+0x0/0x10 kernel/exit.c:992
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&sighand->siglock){-.-.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>        force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
>        force_sig_fault_to_task kernel/signal.c:1733 [inline]
>        force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
>        __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
>        handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>        exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>        strncpy_from_user+0x2c6/0x2f0 lib/strncpy_from_user.c:138
>        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
>        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
>        ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
>        bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
>        bpf_prog_e42f6260c1b72fb3+0x3d/0x3f
>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>        __bpf_prog_run include/linux/filter.h:657 [inline]
>        bpf_prog_run include/linux/filter.h:664 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>        bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
>        __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
>        trace_sched_switch include/trace/events/sched.h:222 [inline]
>        __schedule+0x2535/0x4a00 kernel/sched/core.c:6743
>        preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7068
>        irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
>        asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
>        force_sig_fault+0x0/0x1d0
>        __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
>        handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>        exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>        __put_user_handle_exception+0x0/0x10
>        __do_sys_gettimeofday kernel/time/time.c:147 [inline]
>        __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140
>        emulate_vsyscall+0xe23/0x1290 arch/x86/entry/vsyscall/vsyscall_64.c:247
>        do_user_addr_fault arch/x86/mm/fault.c:1346 [inline]
>        handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>        exc_page_fault+0x160/0x8e0 arch/x86/mm/fault.c:1563
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>        _end+0x6a9da000/0x0
> 

I tried and I can reproduce similar splat below, but no clue yet ;-)
I wonder the current->thread.sig_on_uaccess_err flag might affect the
second bpf fault behaviour

jirka


---
[  315.747916] [ BUG: Invalid wait context ]
[  315.748511] 6.9.0-rc1+ #60 Tainted: G           OE
[  315.749227] -----------------------------
[  315.749820] test_progs/1263 is trying to lock:
[  315.750463][ T1263] ffff888109f06f58 (&sighand->siglock){....}-{3:3}, at: force_sig_info_to_task+0x25/0x140
[  315.751630][ T1263] other info that might help us debug this:
[  315.752337][ T1263] context-{5:5}
[  315.752796][ T1263] 2 locks held by test_progs/1263:
[  315.753426][ T1263]  #0: ffff88846d808918 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x11b/0x1040
[  315.754531][ T1263]  #1: ffffffff839a3700 (rcu_read_lock){....}-{1:3}, at: trace_call_bpf+0x6d/0x4a0
[  315.755630][ T1263] stack backtrace: 
[  315.756133][ T1263] CPU: 2 PID: 1263 Comm: test_progs Tainted: G           OE      6.9.0-rc1+ #60 e3139236695c37204e0f43029c0efe69ab334496
[  315.757607][ T1263] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  315.758741][ T1263] Call Trace:
[  315.759208][ T1263]  <TASK>
[  315.759631][ T1263]  dump_stack_lvl+0x133/0x150
[  315.760252][ T1263]  __lock_acquire+0x98a/0x2420
[  315.760876][ T1263]  ? ring_buffer_lock_reserve+0x126/0x410
[  315.761623][ T1263]  lock_acquire+0x105/0x380
[  315.762216][ T1263]  ? force_sig_info_to_task+0x25/0x140
[  315.762892][ T1263]  ? kernelmode_fixup_or_oops+0x42/0x170
[  315.763577][ T1263]  ? trace_vbprintk+0x173/0x260
[  315.764191][ T1263]  _raw_spin_lock_irqsave+0x69/0xc0
[  315.764842][ T1263]  ? force_sig_info_to_task+0x25/0x140
[  315.765519][ T1263]  force_sig_info_to_task+0x25/0x140
[  315.766182][ T1263]  force_sig_fault+0x5a/0x80
[  315.766767][ T1263]  exc_page_fault+0x82/0x2a0
[  315.767382][ T1263]  asm_exc_page_fault+0x22/0x30
[  315.768018][ T1263] RIP: 0010:strncpy_from_user+0xe5/0x140 
[  315.768713][ T1263] Code: d8 48 89 44 15 00 48 b8 08 06 05 04 03 02 01 00 48 0f af d8 48 c1 eb 38 48 8d 04 13 0f 01 ca 5b 5d 41 5c 41 5d c3 cc cc cc cc <48> 85 db 74 20 48 01 d3 eb 09 48 83 c2 01 48 39 da 74 15 41 8a 44
[  315.770996][ T1263] RSP: 0000:ffffc90001947a40 EFLAGS: 00050002 
[  315.771780][ T1263] RAX: 0000000000000001 RBX: 0000000000000008 RCX: 0000000000000004
[  315.772834][ T1263] RDX: 0000000000000000 RSI: 8080808080808080 RDI: ffffc90001947aa8
[  315.773880][ T1263] RBP: ffffc90001947aa8 R08: fefefefefefefeff R09: 0000000000008a47
[  315.774965][ T1263] R10: 0000000000000011 R11: 000000000001600b R12: 0000000000000008
[  315.775830][ T1263] R13: 0000000000000001 R14: 0000000000000001 R15: ffffc90001633000
[  315.776698][ T1263]  strncpy_from_user_nofault+0x28/0x70
[  315.778139][ T1263]  bpf_probe_read_compat_str+0x51/0x90
[  315.778707][ T1263]  bpf_prog_9199568cec6305d9_krava+0x3c/0x40
[  315.779314][ T1263]  trace_call_bpf+0x127/0x4a0
[  315.779801][ T1263]  perf_trace_run_bpf_submit+0x4f/0xd0
[  315.786332][ T1263]  perf_trace_sched_switch+0x163/0x1a0
[  315.786885][ T1263]  __traceiter_sched_switch+0x3e/0x60
[  315.787427][ T1263]  __schedule+0x5eb/0x1040
[  315.787891][ T1263]  ? asm_sysvec_call_function_single+0x16/0x20
[  315.788503][ T1263]  ? preempt_schedule_thunk+0x16/0x30
[  315.789041][ T1263]  preempt_schedule_common+0x2c/0x70
[  315.789568][ T1263]  preempt_schedule_thunk+0x16/0x30
[  315.790096][ T1263]  _raw_spin_unlock_irqrestore+0x8e/0xa0
[  315.790654][ T1263]  force_sig_info_to_task+0xf3/0x140
[  315.791174][ T1263]  force_sig_fault+0x5a/0x80
[  315.791642][ T1263]  exc_page_fault+0x82/0x2a0
[  315.792108][ T1263]  asm_exc_page_fault+0x22/0x30
[  315.792589][ T1263] RIP: 0010:_copy_to_user+0x45/0x60
[  315.793116][ T1263] Code: 1b 9a ff 48 89 d8 48 01 e8 0f 92 c2 48 85 c0 78 28 0f b6 d2 48 85 d2 75 20 0f 01 cb 48 89 d9 48 89 ef 4c 89 e6 f3 a4 0f 1f 00 <0f> 01 ca 5b 48 89 c8 5d 41 5c c3 cc cc cc cc 48 89 d8 5b 5d 41 5c
[  315.794884][ T1263] RSP: 0000:ffffc90001947e50 EFLAGS: 00050246 
[  315.795476][ T1263] RAX: 0000000000000009 RBX: 0000000000000008 RCX: 0000000000000008
[  315.796256][ T1263] RDX: 0000000000000000 RSI: ffffffff85577050 RDI: 0000000000000001
[  315.797012][ T1263] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
[  315.797753][ T1263] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff85577050
[  315.798518][ T1263] R13: ffffc90001947f58 R14: ffff88817d51b6c0 R15: 0000000000000060
[  315.799287][ T1263]  __x64_sys_gettimeofday+0xc9/0xe0
[  315.799801][ T1263]  ? 0xffffffffff600000
[  315.800241][ T1263]  emulate_vsyscall+0x1be/0x420
[  315.800732][ T1263]  ? 0xffffffffff600000
[  315.801168][ T1263]  do_user_addr_fault+0x4d3/0x8b0
[  315.801651][ T1263]  ? 0xffffffffff600000
[  315.802067][ T1263]  ? 0xffffffffff600000
[  315.802460][ T1263]  exc_page_fault+0x82/0x2a0
[  315.802908][ T1263]  asm_exc_page_fault+0x22/0x30
[  315.803389][ T1263] RIP: 0033:__init_scratch_end+0x79200000/0xffffffffffa26000
[  315.804112][ T1263] Code: Unable to access opcode bytes at 0xffffffffff5fffd6.
[  315.804802][ T1263] RSP: 002b:00007ffc2bdaee98 EFLAGS: 00010246 
[  315.805352][ T1263] RAX: ffffffffffffffda RBX: 00007ffc2bdaf138 RCX: 0000000000000000
[  315.806099][ T1263] RDX: 0000000000000002 RSI: 0000000000000001 RDI: 0000000000000000
[  315.806863][ T1263] RBP: 00007ffc2bdaeef0 R08: 0000000000000064 R09: 0000000000000000
[  315.808206][ T1263] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
[  315.808929][ T1263] R13: 0000000000000000 R14: 00007f7ef5921000 R15: 0000000001402db0
[  315.809628][ T1263]  </TASK>

