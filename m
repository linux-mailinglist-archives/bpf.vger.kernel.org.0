Return-Path: <bpf+bounces-58010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11ACAB382C
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CCC189FA90
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A0293B70;
	Mon, 12 May 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI35Xj+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6EF522F;
	Mon, 12 May 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055593; cv=none; b=tq2lx5hGZfNwYdOdheGaOmGCfrhzXP1XfXw0axz+5gA43vU4BewK9K2AlIrNB6u6ow0mOfUZfBy3VE4HbnWQFw1Bz+HX8NSTrhl/XS3tMxPw9/Jy7zon0rFGXvW8wlU3D0GgF24q/fePKwcLyAM4NV+mElaXnnRf8bXMnbV0I5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055593; c=relaxed/simple;
	bh=4sdXaze78xVODbXPwkA0+vaOobz/AcyGBoFj/F6R3EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cn/jYV/ek6ZRVC62/SzwzCxfeBR+EO5cYoCoA9EWlV95VnCmtNH3nwE1kqdEu5mzJZAWIJDFeHtGiRWS0ZRkM7GIXur48mk61WoUl+xqcuVLdIw5VV0JZmhiILIIMcY7UhV4bK10SZ8Gs+v/V37zv2OkecXG+2ajBESNdZby46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI35Xj+w; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30828fc17adso4067074a91.1;
        Mon, 12 May 2025 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747055590; x=1747660390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lyys4qIkiwUXjXxowx3WSgskbdbmlOhizczEBjaQx8=;
        b=SI35Xj+w3Kht2xaOUu7KLLiy/PgAetSjitPUcpMEgfXc+i5V+IIm0cIolmgOeY32CX
         t2UF5fGvqc1Pyi1ZqUbV1Ruax7oQaoplrjg5QqnJ03QBvpqdjZF6dhj4lbNtT2Ij+BkD
         V60ljbXEBXZzsMKFX6s2Ww0UMrCHRm6i0eYejqAlIxVK09lOEoq4LC1j0R7bDxWAFY32
         3P+A9cDIpPTjy1a5oWOrL6jJHHM0U1r0gFsnxuxR11zQjZFV7OFGbp11lPUMvapGWVuL
         zo6cD3r4Mu97Gmt4cBrQAAApBVJOuJmqLAUdvdcLcUAhzTrQMN1gSCOAdbP/j4TX5VjB
         B21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055590; x=1747660390;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lyys4qIkiwUXjXxowx3WSgskbdbmlOhizczEBjaQx8=;
        b=ACoIAubtDfR4tTFOGf6jKh5q7j+imqb0TBhx1YoRtry17f8jPotM6df7AJJ7oHuOpA
         NtOi9Hub0OCUYMqianks9T09Bh0FT6ktXrWaojqeH0+/9UmDkbxm9Kms89vLfBgT9RHo
         55kaqVUxTLNedGgHt7TL6H1i+r4MG36nGamMRQWgBDWOnpV1sX4WrrPGLwZ4Q5kJARrg
         F3ryhFXBMsM/vg4B6II9GbDJnlG/qt2thDXqTKfAYAy0xLL99xGiyqO913WEdu9OmzsF
         gdP5wETYmXl7SxsHH9DRqKqNumISu9b8zn5MLlahk7vsNUi155K+wptw4EwS+VCAnie0
         hd6g==
X-Forwarded-Encrypted: i=1; AJvYcCVDEojLgle215cy+QUaqVJ/oj/intATcJZAjCujr1jTysEZcVkhBzLcYEkDvz6dMVFnptYBZ6FHAL+o6Z5dFQ4fCo6p@vger.kernel.org, AJvYcCVhF+SAyPZ5eurhI+3sDPkFafW11y016Y7wtYUkL2P+jwe72IIFR1ZHQzAi8xc4xGB6yXA=@vger.kernel.org, AJvYcCWZfVNXcViFM+ugRQ3LyUOyKr9y3SqNyZHhZjbwrqSxspVnbQQpyY4wKgiTT6Wr4fmDbRSXLnr04Ph8LcCN@vger.kernel.org
X-Gm-Message-State: AOJu0YwSS9b7JhZiZPZamgDj4hdGcFh87DSRwFe/Q6Ke/3QBQTUACuJO
	lfp9VplRIVKyZ4Mm+aMEH1yyWWQsLT3lpmJQGMXLHTlElYZLPfOP
X-Gm-Gg: ASbGncv1CyySvuKtV2PXQIbIpNvRKhjkPW7k8+WiuXRkUF0mON6MzAZtx1ws21bNnmh
	9zTLXkLSCG+guVE4CY6sf0SNAcqJ0ld15Vt2Uo6LtE3IWR5q0L3071ZiHJZea8uVmlUj0+q4NPV
	oC+9hqFxMjnkXzKbeL9Z/4LR85yrgnNYoqF2rn0GW7OnWkUV/WSjDug4h1yHzeq5MP0ShnNtCMG
	e3S0vkQJYQxhdP0wnNYQ0msrJhmj71mmssYSmbeVZ6qEi68DDUQlCSZ6wWee8JzRXB1rYQzrTkN
	Z1Qnm/HN/lS7s28mk5J9u0LWnRuFZogBZekqmRTUHqxQ+FKzdPDchqnCoOwnFlikWn+KZw==
X-Google-Smtp-Source: AGHT+IEB7ZoBJaG95Q+I2EFvNwFfHqmT0PkDWgvJLTp3debLHQXk7Mb8DEGSva9cwGheYFCgdoOZrg==
X-Received: by 2002:a17:90a:dfd0:b0:30c:52c5:3dc5 with SMTP id 98e67ed59e1d1-30c52c54135mr14118512a91.26.1747055590156;
        Mon, 12 May 2025 06:13:10 -0700 (PDT)
Received: from [172.23.161.33] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e76055sm6500641a91.42.2025.05.12.06.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:13:09 -0700 (PDT)
Message-ID: <8bc2554d-1052-4922-8832-e0078a033e1d@gmail.com>
Date: Mon, 12 May 2025 21:13:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [trace?] WARNING in get_bpf_raw_tp_regs
To: syzbot <syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@linux.dev, mathieu.desnoyers@efficios.com,
 mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev
References: <6821716e.050a0220.f2294.004a.GAE@google.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <6821716e.050a0220.f2294.004a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/5/12 11:56, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    707df3375124 Merge tag 'media/v6.15-2' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15010768580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
> dashboard link: https://syzkaller.appspot.com/bug?extid=45b0c89a0fc7ae8dbadc
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b28670580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159698f4580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-707df337.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f71d162685b9/vmlinux-707df337.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/940cb473e515/bzImage-707df337.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 5971 at kernel/trace/bpf_trace.c:1861 get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
> Modules linked in:
> CPU: 3 UID: 0 PID: 5971 Comm: syz-executor205 Not tainted 6.15.0-rc5-syzkaller-00038-g707df3375124 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
> Code: 48 83 fb 03 77 64 48 8d 04 9b 48 8d 04 83 48 8d 5c c5 00 e8 7e 76 f4 ff 48 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 6d 76 f4 ff 90 <0f> 0b 90 65 ff 0d b2 5b de 11 e8 5d 76 f4 ff 48 c7 c3 f0 ff ff ff
> RSP: 0018:ffffc90003636fa8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81c6bc4c
> RDX: ffff888032efc880 RSI: ffffffff81c6bc83 RDI: 0000000000000005
> RBP: ffff88806a730860 R08: 0000000000000005 R09: 0000000000000003
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
> R13: 0000000000000001 R14: ffffc90003637008 R15: 0000000000000900
> FS:  0000000000000000(0000) GS:ffff8880d6cdf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7baee09130 CR3: 0000000029f5a000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1934 [inline]
>   bpf_get_stack_raw_tp+0x24/0x160 kernel/trace/bpf_trace.c:1931
>   bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>   __bpf_prog_run include/linux/filter.h:718 [inline]
>   bpf_prog_run include/linux/filter.h:725 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>   bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>   __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>   __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>   __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>   mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
>   stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
>   __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
>   ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
>   bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
>   ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
>   bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
>   bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>   __bpf_prog_run include/linux/filter.h:718 [inline]
>   bpf_prog_run include/linux/filter.h:725 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>   bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>   __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>   __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>   __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>   mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
>   stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
>   __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
>   ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
>   bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
>   ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
>   bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
>   bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>   __bpf_prog_run include/linux/filter.h:718 [inline]
>   bpf_prog_run include/linux/filter.h:725 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>   bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>   __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>   __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>   __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>   mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
>   stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
>   __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
>   ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
>   bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
>   ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
>   bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
>   bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>   __bpf_prog_run include/linux/filter.h:718 [inline]
>   bpf_prog_run include/linux/filter.h:725 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>   bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>   __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>   __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>   __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>   __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>   __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>   mmap_read_lock include/linux/mmap_lock.h:185 [inline]
>   exit_mm kernel/exit.c:565 [inline]
>   do_exit+0xf72/0x2c30 kernel/exit.c:940
>   do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
>   __do_sys_exit_group kernel/exit.c:1113 [inline]
>   __se_sys_exit_group kernel/exit.c:1111 [inline]
>   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
>   x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7baed8cfb9
> Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
> RSP: 002b:00007ffd9d933998 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7baed8cfb9
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007f7baee082b0 R08: ffffffffffffffb8 R09: 0000000000000000
> R10: 0000000000000012 R11: 0000000000000246 R12: 00007f7baee082b0
> R13: 0000000000000000 R14: 00007f7baee08d20 R15: 00007f7baed5e160
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

Hi，

The issue seems to arise because a bpf_prog is used to trace the 
trace_mmap_lock_acquire_returned tracepoint. Within this BPF program, 
the bpf_get_stack function is called. If it collects user-space call 
stacks, it will go here:
       if (user_build_id)
                 stack_map_get_build_id_offset(buf, trace_nr, user, 
may_fault);

and in stack_map_get_build_id_offset, it will call mmap_read_trylock, 
which will call trace_mmap_lock_acquire_returned again.

So can we replace mmap_read_trylock with 
down_read_trylock(&mm->mmap_lock) to avoid calling 
__mmap_lock_trace_acquire_returned

-- 
Best Regards
Tao Chen

