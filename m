Return-Path: <bpf+bounces-26266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2A89D6ED
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DF51C21D83
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74184811E9;
	Tue,  9 Apr 2024 10:26:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE76FE35
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658367; cv=none; b=uEs0Wkyzjsjm+l4m5EWoLttpAwgW0KAgrz4W3ARi3tvMJRLbUiBPMJZCBbnFNeNco+kPhg4vt/t3jFbeuUY437ISpk+wHDqjJ7iG3Gw2EoRb1VLyv/Q//7li6OJHyrAnTeOVkvw76WDnvfVl5o3nCGQ87Wfi+HuH9u6CTUWsxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658367; c=relaxed/simple;
	bh=n2v7fR+Jyhgjm+IFCWhc7giMxVyZDVb4mQ8uvWR1v8U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GQk1nLYpwIv4hfxPDETzzI7UvabovB1XhHQndjQJ6UOOG9q/YInIX0t21+NfIEsYILErT2EMP2FbOoH2f/4j/LyGrD7Yeqqk7cJ61GjJHcg3Q40kf5vE7B8aGFGX660tDRy5OokFrQU2vI0OMfpEzuKXljip2T0vEeowpN9CCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5ee546b46so192526239f.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 03:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712658364; x=1713263164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1D5yhHUARUAudToc171TZTr7sNWcOnmQRrx/zEhzA0=;
        b=afZqblKdvJH5u+Ar8g4ZWjBL1V3kK/4muhDYrXor+Q3dBr+I4WMslOXDUGThPqK8sH
         uEXHByZLq0icr0bW/WuAD/FOuTr9vlOY9y4o51jt3bmfO4sf/fq4Ei09zFacY8Pa6EUn
         xsnEN+sdUsgmIOst26NRMK4kJO/1BOCOZJI4A61F77RWLVPdVhYXcnVUuurllMpXMpMD
         H7846A0fm1uUeh82NTptDVJlGxjSTdCxIGLf3TyWF75UJ1LGU8F1kaZPy1MGvr91ElFf
         X/4NzFN0HAFXKspxf43Lbo2Q4HAanEvWyiKRg0BpmLM5Puxi0ID2/tKJd44WqHiKDBsz
         Z3sg==
X-Forwarded-Encrypted: i=1; AJvYcCUsimIr3yZicjx/Rh4OzaJFe7M5VlVXXh9QuMwuOTrdCUug3zRxAkUFDUhPgfT7SZvvEJ9CLcxs+b+wcrC9UJT1BbqC
X-Gm-Message-State: AOJu0YwfoTA/dzudjJI3egSs2xb+bCJ/5ZXyM8ppTN+JgFoA5f6lkCoc
	6vBMVHjcLDqopS8Qkolkast0b6A04Fi7OR36OXgg3IjwpF2LVVsgTLcRRDlfqKCfKRRv1RqGS8f
	iCrzOeHXhi450MotCSoE+krC11BsMz8tWve9I486RigEd2PaOz6BSKo8=
X-Google-Smtp-Source: AGHT+IH0XDoJXnMtrZY4c/1Kx7OwSCDhku7LlC6ldkDuANuxpY5XTXOA/fA3tnOVqXUyo2n7GqRakqMVOTLHEAzHzVH0Ww3epnS+
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2607:b0:482:8cc1:4eaf with SMTP id
 m7-20020a056638260700b004828cc14eafmr416910jat.5.1712658363808; Tue, 09 Apr
 2024 03:26:03 -0700 (PDT)
Date: Tue, 09 Apr 2024 03:26:03 -0700
In-Reply-To: <mb61pa5m2yht6.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065955e0615a759ab@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
From: syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, alexei.starovoitov@gmail.com, 
	andrii.nakryiko@gmail.com, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux@armlinux.org.uk, mark.rutland@arm.com, 
	puranjay12@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in _vm_unmap_aliases

INFO: task kworker/0:1:8 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:0     pid:8     tgid:8     ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:df839d94 r5:82e2d400
 r4:82e2d400
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:82e2d400 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:df839e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eb4f80
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eb4f80
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:82e2d400 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f02d000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfb13000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84eebf54 r4:84eebc00
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:84eebf54 r4:82c0bf00
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:82e2d400 r9:82c0bf2c r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:82c0bf00
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df835e90 r8:82cad880 r7:82c0bf00 r6:802672c4 r5:82e2d400
 r4:82cad140
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf839fb0 to 0xdf839ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:82cad140
INFO: task kworker/1:6:3904 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:0     pid:3904  tgid:3904  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16205 r9:00000000 r8:82714be8 r7:00000002 r6:e0741d94 r5:83efd400
 r4:83efd400
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:83efd400 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16205 r9:e0741e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eb4300
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eb4300
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:83efd400 r8:00000180 r7:00000000 r6:82c16200 r5:00001000 r4:7f00b000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:df98f000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84ee9754 r4:84ee9400
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:ddde40c0 r6:82c16200 r5:84ee9754 r4:84603500
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:83efd400 r9:8460352c r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:84603500
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df879e90 r8:84e34440 r7:84603500 r6:802672c4 r5:83efd400
 r4:84cc58c0
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xe0741fb0 to 0xe0741ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84cc58c0
INFO: task kworker/0:55:4238 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:55    state:D stack:0     pid:4238  tgid:4238  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:dfb09d94 r5:84e8c800
 r4:84e8c800
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e8c800 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:dfb09e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eb8640
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eb8640
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e8c800 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f057000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dffb3000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84e08b54 r4:84e08800
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:84e08b54 r4:84e60000
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e8c800 r9:84e6002c r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:84e60000
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df9bde90 r8:84616fc0 r7:84e60000 r6:802672c4 r5:84e8c800
 r4:84e5b940
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfb09fb0 to 0xdfb09ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84e5b940
INFO: task kworker/0:57:4264 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:57    state:D stack:0     pid:4264  tgid:4264  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:dfd11d94 r5:844e5400
 r4:844e5400
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:844e5400 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:dfd11e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eb4d80
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eb4d80
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:844e5400 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f02f000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfb49000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84eeaf54 r4:84eeac00
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:84eeaf54 r4:84e60100
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:844e5400 r9:84e6012c r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:84e60100
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfb09e90 r8:84ea8b80 r7:84e60100 r6:802672c4 r5:844e5400
 r4:84ea8b00
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfd11fb0 to 0xdfd11ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84ea8b00
INFO: task kworker/1:59:4286 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:59    state:D stack:0     pid:4286  tgid:4286  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16205 r9:00000000 r8:82714be8 r7:00000002 r6:dfe89d94 r5:84e96000
 r4:84e96000
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e96000 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16205 r9:dfe89e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eb8040
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eb8040
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e96000 r8:00000180 r7:00000000 r6:82c16200 r5:00001000 r4:7f055000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dff77000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:82ceb354 r4:82ceb000
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:ddde40c0 r6:82c16200 r5:82ceb354 r4:84e69480
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e96000 r9:84e694ac r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:84e69480
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfdcde90 r8:84ea8840 r7:84e69480 r6:802672c4 r5:84e96000
 r4:84ea8e40
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfe89fb0 to 0xdfe89ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84ea8e40
INFO: task kworker/1:63:4298 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:63    state:D stack:0     pid:4298  tgid:4298  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16205 r9:00000000 r8:82714be8 r7:00000002 r6:dfee5d94 r5:84e91800
 r4:84e91800
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e91800 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16205 r9:dfee5e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eba380
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eba380
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e91800 r8:00000180 r7:00000000 r6:82c16200 r5:00001000 r4:7f00d000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:df9d3000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84e18b54 r4:84e18800
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:ddde40c0 r6:82c16200 r5:84e18b54 r4:84e69680
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e91800 r9:84e696ac r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:84e69680
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfe89e90 r8:84e53340 r7:84e69680 r6:802672c4 r5:84e91800
 r4:84e532c0
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfee5fb0 to 0xdfee5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84e532c0
INFO: task kworker/1:64:4299 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:64    state:D stack:0     pid:4299  tgid:4299  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16205 r9:00000000 r8:82714be8 r7:00000002 r6:dff41d94 r5:84e74800
 r4:84e74800
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e74800 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16205 r9:dff41e20 r8:00000000 r7:ffffffff r6:00000000 r5:84e53640
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84e53640
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e74800 r8:00000180 r7:00000000 r6:82c16200 r5:00001000 r4:7f033000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfbd7000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84ee8f54 r4:84ee8c00
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:ddde40c0 r6:82c16200 r5:84ee8f54 r4:84e69780
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e74800 r9:84e697ac r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:84e69780
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfe89e90 r8:84eb4000 r7:84e69780 r6:802672c4 r5:84e74800
 r4:84e53900
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdff41fb0 to 0xdff41ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84e53900
INFO: task kworker/0:58:4308 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:58    state:D stack:0     pid:4308  tgid:4308  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:dff71d94 r5:84e76c00
 r4:84e76c00
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e76c00 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:dff71e20 r8:00000000 r7:ffffffff r6:00000000 r5:84eb8d00
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eb8d00
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e76c00 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f031000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfb8f000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84c30b54 r4:84c30800
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:84c30b54 r4:84e60180
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e76c00 r9:84e601ac r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:84e60180
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfd11e90 r8:84eb4a40 r7:84e60180 r6:802672c4 r5:84e76c00
 r4:84eb4e00
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdff71fb0 to 0xdff71ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84eb4e00
INFO: task kworker/0:59:4311 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:59    state:D stack:0     pid:4311  tgid:4311  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:dfb8dd94 r5:84e75400
 r4:84e75400
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e75400 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:dfb8de20 r8:00000000 r7:ffffffff r6:00000000 r5:84e5b5c0
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84e5b5c0
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e75400 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f03b000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfcc9000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84e19b54 r4:84e19800
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:84e19b54 r4:84e60280
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e75400 r9:84e602ac r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:84e60280
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dff71e90 r8:84eb8c00 r7:84e60280 r6:802672c4 r5:84e75400
 r4:84eb4380
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfb8dfb0 to 0xdfb8dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84eb4380
INFO: task kworker/0:60:4312 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:60    state:D stack:0     pid:4312  tgid:4312  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189be20>] (__schedule) from [<8189ca5c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189be20>] (__schedule) from [<8189ca5c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:dffb1d94 r5:84e90c00
 r4:84e90c00
[<8189ca30>] (schedule) from [<8189d06c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e90c00 r4:82714be4
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189d054>] (schedule_preempt_disabled) from [<8189f94c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189f664>] (__mutex_lock.constprop.0) from [<818a0218>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:dffb1e20 r8:00000000 r7:ffffffff r6:00000000 r5:84e5b640
 r4:00000000
[<818a0204>] (__mutex_lock_slowpath) from [<818a0258>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<818a021c>] (mutex_lock) from [<8049c734>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c6d4>] (_vm_unmap_aliases) from [<804a05b8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84e5b640
 r4:00000000
[<804a0448>] (vfree) from [<802edb3c>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e90c00 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f03f000
[<802edb0c>] (module_memfree) from [<803916e0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfd63000
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916d0>] (bpf_jit_free_exec) from [<803918a0>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391838>] (bpf_jit_free) from [<80392988>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:84ef0754 r4:84ef0400
[<8039283c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:84ef0754 r4:84e60300
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e90c00 r9:84e6032c r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:84e60300
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfb8de90 r8:84eb8f40 r7:84e60300 r6:802672c4 r5:84e90c00
 r4:84eb4300
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdffb1fb0 to 0xdffb1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84eb4300
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
NMI backtrace for cpu 0
CPU: 0 PID: 31 Comm: khungtaskd Not tainted 6.9.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<8187a69c>] (dump_backtrace) from [<8187a798>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:00000013 r5:60000093 r4:81fc48fc
[<8187a780>] (show_stack) from [<81897f54>] (__dump_stack lib/dump_stack.c:88 [inline])
[<8187a780>] (show_stack) from [<81897f54>] (dump_stack_lvl+0x70/0x7c lib/dump_stack.c:114)
[<81897ee4>] (dump_stack_lvl) from [<81897f78>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:00000001
[<81897f60>] (dump_stack) from [<81867a74>] (nmi_cpu_backtrace+0x160/0x17c lib/nmi_backtrace.c:113)
[<81867914>] (nmi_cpu_backtrace) from [<81867bc0>] (nmi_trigger_cpumask_backtrace+0x130/0x1d8 lib/nmi_backtrace.c:62)
 r7:00000000 r6:8260c590 r5:8261a88c r4:ffffffff
[<81867a90>] (nmi_trigger_cpumask_backtrace) from [<802105b4>] (arch_trigger_cpumask_backtrace+0x18/0x1c arch/arm/kernel/smp.c:851)
 r9:8260c6f4 r8:000076c2 r7:8289dfe0 r6:00007d59 r5:8514be04 r4:850f5d24
[<8021059c>] (arch_trigger_cpumask_backtrace) from [<8034ec78>] (trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline])
[<8021059c>] (arch_trigger_cpumask_backtrace) from [<8034ec78>] (check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline])
[<8021059c>] (arch_trigger_cpumask_backtrace) from [<8034ec78>] (watchdog+0x480/0x594 kernel/hung_task.c:380)
[<8034e7f8>] (watchdog) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df819e58 r8:82e98340 r7:00000000 r6:8034e7f8 r5:82ee8c00
 r4:82f41200
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf8ddfb0 to 0xdf8ddff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:82f41200
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6890 Comm: syz-executor.0 Not tainted 6.9.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at kmap_local_sched_in kernel/sched/core.c:5189 [inline]
PC is at finish_task_switch+0x8c/0x298 kernel/sched/core.c:5291
LR is at __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
LR is at _raw_spin_unlock+0x2c/0x50 kernel/locking/spinlock.c:186
pc : [<8027cd4c>]    lr : [<818a4f88>]    psr: 20000113
sp : eb539ab8  ip : eb539aa8  fp : eb539afc
r10: 00000402  r9 : 8514bc00  r8 : 82e33000
r7 : a3e9c050  r6 : 8189c228  r5 : ddde4440  r4 : 00000000
r3 : 8514bc00  r2 : 00000001  r1 : 81fc48fc  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 851ca6c0  DAC: 00000000
Call trace: 
[<8027ccc0>] (finish_task_switch) from [<8189c228>] (context_switch kernel/sched/core.c:5412 [inline])
[<8027ccc0>] (finish_task_switch) from [<8189c228>] (__schedule+0x408/0xc10 kernel/sched/core.c:6746)
 r10:00000000 r9:84df6400 r8:a69b624b r7:a3e9c050 r6:8514bc00 r5:ddde4440
 r4:82e33000
[<8189be20>] (__schedule) from [<8189d0b8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7068)
 r10:eb539db0 r9:8514bc00 r8:80200b9c r7:eb539bbc r6:ffffffff r5:8514bc00
 r4:00000000
[<8189d078>] (preempt_schedule_irq) from [<80200bb4>] (svc_preempt+0x8/0x18)
Exception stack(0xeb539b88 to 0xeb539bd0)
9b80:                   000f1b1e 003ff40e 0000071f 00000000 00000000 8514bc00
9ba0: 00000598 0000071f 000f1b1e 00000000 eb539db0 eb539bf4 eb539bf8 eb539bd8
9bc0: 80479eb8 8027f380 60000113 ffffffff
 r5:60000113 r4:8027f380
[<8027f354>] (migrate_disable) from [<80479eb8>] (__kmap_local_pfn_prot+0x20/0x1ac mm/highmem.c:548)
 r7:0000071f r6:00c00000 r5:dedf605c r4:00000000
[<80479e98>] (__kmap_local_pfn_prot) from [<8047a0b4>] (__kmap_local_page_prot mm/highmem.c:581 [inline])
[<80479e98>] (__kmap_local_pfn_prot) from [<8047a0b4>] (__kmap_local_page_prot+0x70/0x74 mm/highmem.c:564)
 r8:00000001 r7:828584e8 r6:00000001 r5:dedf605c r4:00000000
[<8047a044>] (__kmap_local_page_prot) from [<804a23ec>] (kmap_local_page include/linux/highmem-internal.h:73 [inline])
[<8047a044>] (__kmap_local_page_prot) from [<804a23ec>] (clear_highpage_kasan_tagged include/linux/highmem.h:246 [inline])
[<8047a044>] (__kmap_local_page_prot) from [<804a23ec>] (kernel_init_pages+0x3c/0x60 mm/page_alloc.c:1080)
[<804a23b0>] (kernel_init_pages) from [<804a52d4>] (post_alloc_hook+0x88/0xc0 mm/page_alloc.c:1532)
 r9:00000000 r8:827e21bc r7:00000001 r6:00000001 r5:dedf6038 r4:00000000
[<804a524c>] (post_alloc_hook) from [<804a7968>] (prep_new_page mm/page_alloc.c:1541 [inline])
[<804a524c>] (post_alloc_hook) from [<804a7968>] (get_page_from_freelist+0x28c/0x13d8 mm/page_alloc.c:3317)
 r7:8514bc00 r6:827e1f00 r5:00000000 r4:00540dc2
[<804a76dc>] (get_page_from_freelist) from [<804a8fe4>] (__alloc_pages+0xe0/0x1168 mm/page_alloc.c:4575)
 r10:00000000 r9:84df6400 r8:20000000 r7:8514bc00 r6:00440dc2 r5:00540dc2
 r4:00000000
[<804a8f04>] (__alloc_pages) from [<8047b688>] (__alloc_pages_node include/linux/gfp.h:238 [inline])
[<804a8f04>] (__alloc_pages) from [<8047b688>] (alloc_pages_node include/linux/gfp.h:261 [inline])
[<804a8f04>] (__alloc_pages) from [<8047b688>] (alloc_pages include/linux/gfp.h:274 [inline])
[<804a8f04>] (__alloc_pages) from [<8047b688>] (pagetable_alloc include/linux/mm.h:2862 [inline])
[<804a8f04>] (__alloc_pages) from [<8047b688>] (__pte_alloc_one include/asm-generic/pgalloc.h:68 [inline])
[<804a8f04>] (__alloc_pages) from [<8047b688>] (pte_alloc_one+0x24/0xf8 arch/arm/include/asm/pgalloc.h:99)
 r10:00000040 r9:84df6400 r8:20000000 r7:84db6000 r6:20000000 r5:85268800
 r4:84df6400
[<8047b664>] (pte_alloc_one) from [<8047cc70>] (__pte_alloc+0x2c/0x108 mm/memory.c:440)
 r5:85268800 r4:84df6400
[<8047cc44>] (__pte_alloc) from [<80481b10>] (do_anonymous_page mm/memory.c:4402 [inline])
[<8047cc44>] (__pte_alloc) from [<80481b10>] (do_pte_missing mm/memory.c:3878 [inline])
[<8047cc44>] (__pte_alloc) from [<80481b10>] (handle_pte_fault mm/memory.c:5300 [inline])
[<8047cc44>] (__pte_alloc) from [<80481b10>] (__handle_mm_fault mm/memory.c:5441 [inline])
[<8047cc44>] (__pte_alloc) from [<80481b10>] (handle_mm_fault+0xfac/0x12b8 mm/memory.c:5606)
 r5:8514bc00 r4:00000255
[<80480b64>] (handle_mm_fault) from [<80215d94>] (do_page_fault+0x148/0x3a8 arch/arm/mm/fault.c:333)
 r10:00000002 r9:84df6400 r8:20000000 r7:00000a06 r6:00000255 r5:20000000
 r4:eb539fb0
[<80215c4c>] (do_page_fault) from [<80216174>] (do_translation_fault+0xfc/0x12c arch/arm/mm/fault.c:444)
 r10:7ee33670 r9:7ee33670 r8:80216078 r7:eb539fb0 r6:20000000 r5:00000a06
 r4:8261d0d0
[<80216078>] (do_translation_fault) from [<802161dc>] (do_DataAbort+0x38/0xa8 arch/arm/mm/fault.c:565)
 r9:7ee33670 r8:80216078 r7:eb539fb0 r6:20000000 r5:00000a06 r4:8261d0d0
[<802161a4>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/arm/kernel/entry-armv.S:427)
Exception stack(0xeb539fb0 to 0xeb539ff8)
9fa0:                                     00000000 00000000 00000001 20000000
9fc0: 00000004 00000000 00000000 00000000 fffffffe 7ee33670 7ee33670 7ee33630
9fe0: 01068590 7ee333a8 0001d150 0001d4ac 40000010 ffffffff
 r8:824a9044 r7:8514bc00 r6:ffffffff r5:40000010 r4:0001d4ac


Tested on:

commit:         2929be95 arm32, bpf: Fix sign-extension mov instruction
git tree:       https://github.com/puranjaymohan/linux.git arm32_movsx_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=11362cf3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10acd270ef193b93
dashboard link: https://syzkaller.appspot.com/bug?extid=186522670e6722692d86
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Note: no patches were applied.

