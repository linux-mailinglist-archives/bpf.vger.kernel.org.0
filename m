Return-Path: <bpf+bounces-31721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960D902576
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B5A1F2106E
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222F1552F5;
	Mon, 10 Jun 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfbF9L6q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5714532C;
	Mon, 10 Jun 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032660; cv=none; b=p9S/SQK1xH4i0JWL7425UujEmxUl9oB96imiH6I2UmQSBkEkopPlzsNvn0MbUksBzgqIRJkPrT6iynWPWAaGGp0PBfVt1/ITLYP2Miz9TMZYxXsmaqKcstUwlSiwlE1xlD0kewemXnpa1I8cNYH+WBKyh/ROqZdTQqnwNOluYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032660; c=relaxed/simple;
	bh=Tdtqib5LHMViVt4cUpFEK2fjp1qN5cOoyKP6PM/xiMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fRS25QayneifsbGuGMIrIsNdjEMa7LRgPrx+NNnUZdwo4SJfgg018NgkAXmF/HhxfJmTU/NRxJBZZRNcxv9+HTnLL4VglIgxO9UOHUFbIDPGirR8w5bkILbzSO7wVtuHyoRhxbHcNtCeDhY1YyEYhuLxMT4/RRBTWy4qOzhQkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfbF9L6q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f1c4800easo147793266b.3;
        Mon, 10 Jun 2024 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718032657; x=1718637457; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fymq8SwQCYCfB365IAB5NgGdsT8hiwbArITfskToqFA=;
        b=JfbF9L6qzTimm8lP+HAE99p7EafCaxocPHmzctpQMvsSQpzIn+6C4KwYeUDoxTxxf9
         aKYFjFOGdchlR1zTLZFSaJKVHSqPfOmHWGsXcIimCfZznPAB5QOTTDjQq91I7FR6GY4G
         5zsrgCrI9b5hB5HKURsEF8oLBr8MUZVBdKCv9VbtLHVfxF67H1E4YVS0rfVI5CyTBiUn
         KDJpxl4BrA2+vph4ZM9pQJMeWrCEM1y+4wn3mVpO5fdMwaRMpBjzi77rCTVE0MMaa+vJ
         M1fvN+1PfD6LwogK+G1WtHBM9MBbOKF5vKic57JkEjWPXzkaNw9kOHx55LitF/n7GzsM
         3PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032657; x=1718637457;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fymq8SwQCYCfB365IAB5NgGdsT8hiwbArITfskToqFA=;
        b=MmYDzjSAEmkLccfEqE4OOqh233haVT/acnEgMiyaRFe2A0Y1jrXL3p/PzlJD5HO67x
         1/K8K2WOfkVj6B3sSc1O6e8HkdnYQt+nZ+3Fqo+3SktgfUymjPm3P8rW0SiuCqtv8opa
         6Sgrc+d09GAsxDinL40KsmMpdl46IxnjzCKH5enUwG6BbA4QYwIXGW1KRp9nxAuN0pkD
         BIaGnfllzT0UtvBbF7IFGtNmPKzlgKVmgYMz+VJaAKm4dYdUdB1Xt6/JGbuyMTzOj3df
         WCEOuwHduFyTXZRgypBGWecLG35JUYB9H1tu15q0eTLIgDs6uh+1klVY7Ew9NZhk+xP3
         fl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL/nhgUDB45Jda0p+cD52jUn+sGsqK9Un88DS7JxfeYJIcMd4Z3fEtlgLgXvGQj45GhZe+Xlgx1veTdf0acMDe3/OBmJORzACxiwmkS6U=
X-Gm-Message-State: AOJu0YwBDqj9wKV2lYKonPBdAnLeN2FmUs/Mtz+GmYCbMlrDxHKm0+8G
	085ej0LD2zKXxBC2cHSBQtkV+Rwvff/9Yw4fCsKKVCFeQr0SOmRtVPsoKA==
X-Google-Smtp-Source: AGHT+IG06XUcvlk9bCYu4wSI8vpzjcPs4+rkG+K/1JsbJfRtjnQe1VpwZPZ4QDfUBMAcDzjKUYF5vw==
X-Received: by 2002:a17:906:d189:b0:a6e:f66a:e0d7 with SMTP id a640c23a62f3a-a6ef66ae1eamr483806566b.15.1718032657027;
        Mon, 10 Jun 2024 08:17:37 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-178-012-035-234.178.012.pools.vodafone-ip.de. [178.12.35.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eab0asm647169666b.134.2024.06.10.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 08:17:36 -0700 (PDT)
Date: Mon, 10 Jun 2024 17:17:35 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: bpf_ringbuf_reserve deadlock on rt kernels
Message-ID: <jxkyec5jd54r3cmel4e3pep4ebo3pd4xgedwtb7gj65fntf4s7@om5r3mowjknb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we're facing an interesting issue with a BPF program that writes into a
bpf_ringbuf from different CPUs on an RT kernel. Here is my attempt to
reproduce on QEMU:

    ======================================================
    WARNING: possible circular locking dependency detected
    6.9.0-rt5-g66834e17536e #3 Not tainted
    ------------------------------------------------------
    swapper/4/0 is trying to acquire lock:
    ffffc90006b4d118 (&lock->wait_lock){....}-{2:2}, at: rt_spin_lock+0x6d/0x100

    but task is already holding lock:
    ffffc90006b4d158 (&rb->spinlock){....}-{2:2}, at: __bpf_ringbuf_reserve+0x5a/0xf0

    which lock already depends on the new lock.


    the existing dependency chain (in reverse order) is:

    -> #3 (&rb->spinlock){....}-{2:2}:
           lock_acquire+0xc5/0x300
           rt_spin_lock+0x2a/0x100
           __bpf_ringbuf_reserve+0x5a/0xf0
           bpf_prog_abf021cf8a50b730_sched_switch+0x281/0x70d
           bpf_trace_run4+0xae/0x1e0
           __schedule+0x42c/0xca0
           preempt_schedule_notrace+0x37/0x60
           preempt_schedule_notrace_thunk+0x1a/0x30
           rcu_is_watching+0x32/0x40
           __flush_work+0x30b/0x480
           n_tty_poll+0x131/0x1d0
           tty_poll+0x54/0x90
           do_select+0x490/0x9b0
           core_sys_select+0x238/0x620
           kern_select+0x101/0x190
           __x64_sys_select+0x21/0x30
           do_syscall_64+0xbc/0x1d0
           entry_SYSCALL_64_after_hwframe+0x77/0x7f

    -> #2 (&rq->__lock){-...}-{2:2}:
           lock_acquire+0xc5/0x300
           _raw_spin_lock_nested+0x2e/0x40
           raw_spin_rq_lock_nested+0x15/0x30
           task_fork_fair+0x3e/0xb0
           sched_cgroup_fork+0xe9/0x110
           copy_process+0x1b76/0x2fd0
           kernel_clone+0xab/0x3e0
           user_mode_thread+0x5f/0x90
           rest_init+0x1e/0x160
           start_kernel+0x61d/0x620
           x86_64_start_reservations+0x24/0x30
           x86_64_start_kernel+0x8c/0x90
           common_startup_64+0x13e/0x148

    -> #1 (&p->pi_lock){-...}-{2:2}:
           lock_acquire+0xc5/0x300
           _raw_spin_lock+0x30/0x40
           rtlock_slowlock_locked+0x130/0x1c70
           rt_spin_lock+0x78/0x100
           prepare_to_wait_event+0x1a/0x140
           wake_up_and_wait_for_irq_thread_ready+0xc3/0xe0
           __setup_irq+0x374/0x660
           request_threaded_irq+0xe5/0x180
           acpi_os_install_interrupt_handler+0xb7/0xe0
           acpi_ev_install_xrupt_handlers+0x22/0x90
           acpi_init+0x8f/0x4d0
           do_one_initcall+0x73/0x2d0
           kernel_init_freeable+0x24a/0x290
           kernel_init+0x1a/0x130
           ret_from_fork+0x31/0x50
           ret_from_fork_asm+0x1a/0x30

    -> #0 (&lock->wait_lock){....}-{2:2}:
           check_prev_add+0xeb/0xd80
           __lock_acquire+0x113e/0x15b0
           lock_acquire+0xc5/0x300
           _raw_spin_lock_irqsave+0x3c/0x60
           rt_spin_lock+0x6d/0x100
           __bpf_ringbuf_reserve+0x5a/0xf0
           bpf_prog_abf021cf8a50b730_sched_switch+0x281/0x70d
           bpf_trace_run4+0xae/0x1e0
           __schedule+0x42c/0xca0
           schedule_idle+0x20/0x40
           cpu_startup_entry+0x29/0x30
           start_secondary+0xfa/0x100
           common_startup_64+0x13e/0x148

    other info that might help us debug this:

    Chain exists of:
      &lock->wait_lock --> &rq->__lock --> &rb->spinlock

     Possible unsafe locking scenario:

           CPU0                    CPU1
           ----                    ----
      lock(&rb->spinlock);
                                   lock(&rq->__lock);
                                   lock(&rb->spinlock);
      lock(&lock->wait_lock);

     *** DEADLOCK ***

    3 locks held by swapper/4/0:
     #0: ffff88813bd32558 (&rq->__lock){-...}-{2:2}, at: __schedule+0xc4/0xca0
     #1: ffffffff83590540 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x6c/0x1e0
     #2: ffffc90006b4d158 (&rb->spinlock){....}-{2:2}, at: __bpf_ringbuf_reserve+0x5a/0xf0

    stack backtrace:
    CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.0-rt5-g66834e17536e #3
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x6f/0xb0
     print_circular_bug.cold+0x178/0x1be
     check_noncircular+0x14e/0x170
     check_prev_add+0xeb/0xd80
     __lock_acquire+0x113e/0x15b0
     lock_acquire+0xc5/0x300
     ? rt_spin_lock+0x6d/0x100
     _raw_spin_lock_irqsave+0x3c/0x60
     ? rt_spin_lock+0x6d/0x100
     rt_spin_lock+0x6d/0x100
     __bpf_ringbuf_reserve+0x5a/0xf0
     bpf_prog_abf021cf8a50b730_sched_switch+0x281/0x70d
     bpf_trace_run4+0xae/0x1e0
     __schedule+0x42c/0xca0
     schedule_idle+0x20/0x40
     cpu_startup_entry+0x29/0x30
     start_secondary+0xfa/0x100
     common_startup_64+0x13e/0x148
     </TASK>
    CPU: 1 PID: 160 Comm: screen Not tainted 6.9.0-rt5-g66834e17536e #3
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x6f/0xb0
     __might_resched.cold+0xcc/0xdf
     rt_spin_lock+0x4c/0x100
     ? __bpf_ringbuf_reserve+0x5a/0xf0
     __bpf_ringbuf_reserve+0x5a/0xf0
     bpf_prog_abf021cf8a50b730_sched_switch+0x281/0x70d
     bpf_trace_run4+0xae/0x1e0
     __schedule+0x42c/0xca0
     preempt_schedule_notrace+0x37/0x60
     preempt_schedule_notrace_thunk+0x1a/0x30
     ? __flush_work+0x84/0x480
     rcu_is_watching+0x32/0x40
     __flush_work+0x30b/0x480
     n_tty_poll+0x131/0x1d0
     tty_poll+0x54/0x90
     do_select+0x490/0x9b0
     ? __bfs+0x136/0x230
     ? do_select+0x26d/0x9b0
     ? __pfx_pollwake+0x10/0x10
     ? __pfx_pollwake+0x10/0x10
     ? core_sys_select+0x238/0x620
     core_sys_select+0x238/0x620
     kern_select+0x101/0x190
     __x64_sys_select+0x21/0x30
     do_syscall_64+0xbc/0x1d0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

The BPF program in question is attached to sched_switch. The issue seems
to be similar to a couple of syzkaller reports [1], [2], although the
latter one is about nested progs, which seems to be not the case here.
Talking about nested progs, applying a similar approach as in [3]
reworked for bpf_ringbuf, elliminates the issue.

Do I miss anything, is it a known issue? Any ideas how to address that?

[1]: https://lore.kernel.org/all/0000000000000656bf061a429057@google.com/
[2]: https://lore.kernel.org/lkml/0000000000004aa700061379547e@google.com/
[3]: https://lore.kernel.org/bpf/20240514124052.1240266-2-sidchintamaneni@gmail.com/

