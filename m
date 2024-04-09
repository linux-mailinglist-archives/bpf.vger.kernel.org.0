Return-Path: <bpf+bounces-26274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3111E89D7C7
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8197284DD7
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CEC128362;
	Tue,  9 Apr 2024 11:23:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20F85C73
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661786; cv=none; b=TPVXj+CEOFRBxjqZ8IK6GtUcOImqeXTqtlAW5ow9rvhSWdVbP0ujNPIaWvfcwveOU/1Xi3PdpQeI6JsNJ1OpEarPIkNGcYvi7llPqsRkGd6pI0EOJBOvMak1gkXqsE88ekQ5lvQp7KiT/zBpdzH2zsiB7f5qhhy3XcsNUQXTQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661786; c=relaxed/simple;
	bh=5ROrTILwgwtu1eXXfrHz9C0PXdud03zposetsXGc5ak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WXEl/pUECtoD2+4BAhemJCjgdBp6tHtwk7zq+CqO5t0refDMgWS9C7qcDxmKkJNVsVXoMJLv72tpCRZ5GezapB07rPE9bHOEuJc2dfp7wFAoYWglVAA4S6TO887qevG2n1ltaxs7nfyY7n/lLqrwfsGWfQQfundWVafmWBF65F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5da88bb06so286325139f.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 04:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712661784; x=1713266584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB80314w848NyGVGFY4b6hjNT5h98IQxWV7Umez7X3Q=;
        b=pKu9ay78QVcU004knJ5whIgfGQbEy+TR0Im1I+I3WDhcwR+j1uovuCnyqyAZBkKBmL
         /nDed1fN0g3m93NAuj/FL3nKjzMLZbxko4Wg9fKq1xfAWDYOLeKB3Do8td5Hyxb3Lbtq
         TZTh6jUbZlGpf/dnCMQe/cVGA/ooStoqQyktHZfH5LYx7qsW4Y3xwPSWxoWddwMZKJ2+
         gNSgKKSKxuLTIA4nSyssFYbe/aMDPFztFUER2VEgx4Jz3c7tyxLLaFeIaOlo81r9SwqX
         mvYuP30Qgl3UHaoYmoQ8XlkD8MLoiWZq7/xxedcjRMcAuCqzSvAuiyur0TwtCO9akKIj
         fVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrm3aNYOsHtdBjiRcaoNwAkkn8PJE3bvntVM1j4q+til5nJEfFFf+l2yFrSCv5fTlxqa7/QUd6xMahuKMpUTVfzDhG
X-Gm-Message-State: AOJu0YxEKpAvEIyB5isSADvXY4CuBrqrMVhHflwMm0wvulxWoyGgXIyQ
	TUG3Y0ScYAc2BsGTmRvrbSHcU+OMnr4XQWW/UGdM31XtNpM1siBmjQcN3N3K+Hq8FTgKWrbb/31
	B4Xby6MTLQEqc5x6zVgPOdvIUKW3ohNbtwVXbYdbSwqJE9dSmqNPVkCo=
X-Google-Smtp-Source: AGHT+IHr18O2m/tzwk1iXt7dCCE48nS0UEL87GUWrTVOq5kDDDpdnf+wWM1vRkG92aePc2Vtonr8qPfHLlxx/2kPpJ0pEodBMWQ0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3792:b0:47e:e557:ba45 with SMTP id
 w18-20020a056638379200b0047ee557ba45mr411925jal.0.1712661784225; Tue, 09 Apr
 2024 04:23:04 -0700 (PDT)
Date: Tue, 09 Apr 2024 04:23:04 -0700
In-Reply-To: <mb61p7ch6yetx.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044fca50615a82595@google.com>
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

INFO: task kworker/0:41:4201 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:41    state:D stack:0     pid:4201  tgid:4201  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189ad40>] (__schedule) from [<8189b97c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189ad40>] (__schedule) from [<8189b97c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16005 r9:00000000 r8:82714be8 r7:00000002 r6:dfd0dd94 r5:84dd1800
 r4:84dd1800
[<8189b950>] (schedule) from [<8189bf8c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84dd1800 r4:82714be4
[<8189bf74>] (schedule_preempt_disabled) from [<8189e86c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189bf74>] (schedule_preempt_disabled) from [<8189e86c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189e584>] (__mutex_lock.constprop.0) from [<8189f138>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16005 r9:dfd0de20 r8:00000000 r7:ffffffff r6:00000000 r5:84c7a680
 r4:00000000
[<8189f124>] (__mutex_lock_slowpath) from [<8189f178>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<8189f13c>] (mutex_lock) from [<8049c624>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c5c4>] (_vm_unmap_aliases) from [<804a04a8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c5c4>] (_vm_unmap_aliases) from [<804a04a8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16005 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84c7a680
 r4:00000000
[<804a0338>] (vfree) from [<802edb08>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84dd1800 r8:00000080 r7:00000000 r6:82c16000 r5:00001000 r4:7f055000
[<802edad8>] (module_memfree) from [<803916b0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfe91000
[<803916a0>] (bpf_jit_free_exec) from [<80391870>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916a0>] (bpf_jit_free_exec) from [<80391870>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391808>] (bpf_jit_free) from [<80392958>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:845b0754 r4:845b0400
[<8039280c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:dddd00c0 r6:82c16000 r5:845b0754 r4:84d7cb00
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84dd1800 r9:84d7cb2c r8:61c88647 r7:dddd00e0 r6:82604d40 r5:dddd00c0
 r4:84d7cb00
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfa55e90 r8:845d8e80 r7:84d7cb00 r6:802672c4 r5:84dd1800
 r4:84c66500
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfd0dfb0 to 0xdfd0dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84c66500
INFO: task kworker/1:55:4229 blocked for more than 430 seconds.
      Not tainted 6.9.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:55    state:D stack:0     pid:4229  tgid:4229  ppid:2      flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<8189ad40>] (__schedule) from [<8189b97c>] (__schedule_loop kernel/sched/core.c:6823 [inline])
[<8189ad40>] (__schedule) from [<8189b97c>] (schedule+0x2c/0xfc kernel/sched/core.c:6838)
 r10:82c16205 r9:00000000 r8:82714be8 r7:00000002 r6:dfe39d94 r5:84e83c00
 r4:84e83c00
[<8189b950>] (schedule) from [<8189bf8c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6895)
 r5:84e83c00 r4:82714be4
[<8189bf74>] (schedule_preempt_disabled) from [<8189e86c>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<8189bf74>] (schedule_preempt_disabled) from [<8189e86c>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<8189e584>] (__mutex_lock.constprop.0) from [<8189f138>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c16205 r9:dfe39e20 r8:00000000 r7:ffffffff r6:00000000 r5:84c7a240
 r4:00000000
[<8189f124>] (__mutex_lock_slowpath) from [<8189f178>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<8189f13c>] (mutex_lock) from [<8049c624>] (_vm_unmap_aliases+0x60/0x2e8 mm/vmalloc.c:2788)
[<8049c5c4>] (_vm_unmap_aliases) from [<804a04a8>] (vm_reset_perms mm/vmalloc.c:3235 [inline])
[<8049c5c4>] (_vm_unmap_aliases) from [<804a04a8>] (vfree+0x170/0x1e4 mm/vmalloc.c:3314)
 r10:82c16205 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84c7a240
 r4:00000000
[<804a0338>] (vfree) from [<802edb08>] (module_memfree+0x30/0x50 kernel/module/main.c:1189)
 r9:84e83c00 r8:00000180 r7:00000000 r6:82c16200 r5:00001000 r4:7f053000
[<802edad8>] (module_memfree) from [<803916b0>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1058)
 r5:00001000 r4:dfe73000
[<803916a0>] (bpf_jit_free_exec) from [<80391870>] (bpf_jit_binary_free kernel/bpf/core.c:1104 [inline])
[<803916a0>] (bpf_jit_free_exec) from [<80391870>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1228)
[<80391808>] (bpf_jit_free) from [<80392958>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2783)
 r5:845b2b54 r4:845b2800
[<8039280c>] (bpf_prog_free_deferred) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r7:ddde40c0 r6:82c16200 r5:845b2b54 r4:845d9f80
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:84e83c00 r9:845d9fac r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:845d9f80
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:dfde5e90 r8:84640600 r7:845d9f80 r6:802672c4 r5:84e83c00
 r4:84c66300
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdfe39fb0 to 0xdfe39ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:84c66300
NMI backtrace for cpu 0
CPU: 0 PID: 31 Comm: khungtaskd Not tainted 6.9.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<818795bc>] (dump_backtrace) from [<818796b8>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:00000113 r5:60000193 r4:81fc4768
[<818796a0>] (show_stack) from [<81896e70>] (__dump_stack lib/dump_stack.c:88 [inline])
[<818796a0>] (show_stack) from [<81896e70>] (dump_stack_lvl+0x70/0x7c lib/dump_stack.c:114)
[<81896e00>] (dump_stack_lvl) from [<81896e94>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:00000001
[<81896e7c>] (dump_stack) from [<81866994>] (nmi_cpu_backtrace+0x160/0x17c lib/nmi_backtrace.c:113)
[<81866834>] (nmi_cpu_backtrace) from [<81866ae0>] (nmi_trigger_cpumask_backtrace+0x130/0x1d8 lib/nmi_backtrace.c:62)
 r7:00000000 r6:8260c590 r5:8261a88c r4:ffffffff
[<818669b0>] (nmi_trigger_cpumask_backtrace) from [<802105b4>] (arch_trigger_cpumask_backtrace+0x18/0x1c arch/arm/kernel/smp.c:851)
 r9:8260c6f4 r8:00007b4d r7:8289dfe0 r6:00007d59 r5:8500ee04 r4:850d4b24
[<8021059c>] (arch_trigger_cpumask_backtrace) from [<8034ec48>] (trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline])
[<8021059c>] (arch_trigger_cpumask_backtrace) from [<8034ec48>] (check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline])
[<8021059c>] (arch_trigger_cpumask_backtrace) from [<8034ec48>] (watchdog+0x480/0x594 kernel/hung_task.c:380)
[<8034e7c8>] (watchdog) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:df819e58 r8:82e98440 r7:00000000 r6:8034e7c8 r5:82ee8c00
 r4:82f42100
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xdf8ddfb0 to 0xdf8ddff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:82f42100
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5655 Comm: kworker/1:259 Not tainted 6.9.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: wg-crypt-wg0 wg_packet_encrypt_worker
PC is at poly1305_final_arch+0x0/0x80 arch/arm/crypto/poly1305-glue.c:189
LR is at poly1305_final include/crypto/poly1305.h:94 [inline]
LR is at chacha20poly1305_crypt_sg_inplace+0x43c/0x4b4 lib/crypto/chacha20poly1305.c:320
pc : [<80232f80>]    lr : [<807fa0e4>]    psr: 60000113
sp : eafa1990  ip : eafa1990  fp : eafa1bb4
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : eafa19e0  r6 : 00000000  r5 : 00000000  r4 : eafa19f0
r3 : 00000000  r2 : 00000000  r1 : eafa19f0  r0 : eafa1a68
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 8461dec0  DAC: 00000000
Call trace: 
[<807f9ca8>] (chacha20poly1305_crypt_sg_inplace) from [<807fa188>] (chacha20poly1305_encrypt_sg_inplace+0x2c/0x34 lib/crypto/chacha20poly1305.c:338)
 r10:00000000 r9:00000000 r8:00000074 r7:00000001 r6:84dca018 r5:00000000
 r4:00000074
[<807fa15c>] (chacha20poly1305_encrypt_sg_inplace) from [<80bfb0f8>] (encrypt_packet+0x194/0x230 drivers/net/wireguard/send.c:216)
 r5:00000000 r4:00000074
[<80bfaf64>] (encrypt_packet) from [<80bfb8d0>] (wg_packet_encrypt_worker+0xbc/0x270 drivers/net/wireguard/send.c:297)
 r10:846c86e8 r9:82f2a540 r8:00000000 r7:846c86a0 r6:8260eea8 r5:00000000
 r4:82f2a540
[<80bfb814>] (wg_packet_encrypt_worker) from [<8026678c>] (process_one_work+0x1b8/0x508 kernel/workqueue.c:3254)
 r10:84032e05 r9:85156000 r8:00000180 r7:ddde40c0 r6:84032e00 r5:ff7ffcf4
 r4:8505ff00
[<802665d4>] (process_one_work) from [<802674b0>] (process_scheduled_works kernel/workqueue.c:3335 [inline])
[<802665d4>] (process_one_work) from [<802674b0>] (worker_thread+0x1ec/0x418 kernel/workqueue.c:3416)
 r10:85156000 r9:8505ff2c r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:8505ff00
[<802672c4>] (worker_thread) from [<802701c4>] (kthread+0x104/0x134 kernel/kthread.c:388)
 r10:00000000 r9:eaeb1e90 r8:84ed1a40 r7:8505ff00 r6:802672c4 r5:85156000
 r4:847e7040
[<802700c0>] (kthread) from [<80200104>] (ret_from_fork+0x14/0x30 arch/arm/kernel/entry-common.S:134)
Exception stack(0xeafa1fb0 to 0xeafa1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802700c0 r4:847e7040


Tested on:

commit:         7deb8d88 arm32, bpf: Fix sign-extension mov instruction
git tree:       https://github.com/puranjaymohan/linux.git arm32_movsx_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=175200cb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43f1e0cbdb852271
dashboard link: https://syzkaller.appspot.com/bug?extid=186522670e6722692d86
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Note: no patches were applied.

