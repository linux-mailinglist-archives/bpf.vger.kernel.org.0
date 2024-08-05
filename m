Return-Path: <bpf+bounces-36359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FE947834
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC811F21146
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4BC15250F;
	Mon,  5 Aug 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGFeQl0l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24C14E2FD
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849621; cv=none; b=NPLeGw5ixAVy8AC6JeGcWEaoVcNiTWXkd005bgGQZouXv7gJbH6oD4aYuzBcbbaePBwpZb1KifhmvMA6ccHEuPO93ZhKT0eCDdXZ26vKalmcJJrkJhadCTriitFV54B5780/YPnO7Y0LspFgyzyP+Niej/twLGJAkZwZR7NrTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849621; c=relaxed/simple;
	bh=LIr5slU6UtAZYjpwtv5xLVAL9cxTh6OWJty1RVzElns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QFahbmXKI4p+x3w4m/kYFTOU140xMV7VJuroHm22p/wrtCuJnVFpM1Cdv2vdWhXPPQkiV346BSsAluWMmAu21H7yNpm6khA/EDpNU7pvHdlFoZA8h7yzNQeIYcMWaeIrnagBx/El4JIpW6SygI7s4E40Kk5TawSeDnGfxWAHhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGFeQl0l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722849618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QLSNo8/23L5kw8TvwXFMPifd7C4UhpX4Z1lj0UxKDko=;
	b=hGFeQl0lx651WIr7mWfuzC3STLUU9suvBkacfe75ecnrXWfp3GvIRNUkuAMBWmWO4x8n3Y
	CBOWa+1WrsKe0UQpMqQ3X8aQs5tQie3B1t2P3uTdPLZRRpnfsslRS4+Bk9im9zS5jxdkTt
	CowbnkDReUesnCjC+IH9lIUH1IZRrog=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-TWkW8tqtOqKM4lXkOMLs1g-1; Mon, 05 Aug 2024 05:20:16 -0400
X-MC-Unique: TWkW8tqtOqKM4lXkOMLs1g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3687faecea0so5099872f8f.2
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849615; x=1723454415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLSNo8/23L5kw8TvwXFMPifd7C4UhpX4Z1lj0UxKDko=;
        b=IMsoNKyOeur8K3+YxfokjiGRgHaJUocYFqLccnXVNde6bu0dfYItudwHql9FTpWUUb
         aY5QjvYbr8FyzktS/oQCKSaw/9QnJXggMbLd1rZNv0qFLTQEpxEWvgk718swqN3g7XKx
         BmoHT55M+rAjzSX9/uuifW/r/tcO1E7gJGxWNf/LASpNZkuZUr+WAlXrNkJu35TMGEFY
         aC2IW/ngUcf0v5PMbhF09i9GDzKyAU0ICMJmMQwH8LqYy7m26aSx3hVqdB8pgkSXwAbc
         dVUs3f1DF2MyGpCbNZ+UumQYh0kgG6k2hr1ph8AHiqve3qZUGVky2KYQEVcRw6NNw/HU
         8m3g==
X-Gm-Message-State: AOJu0YxCVumYZ7xSYRuwEx1eoriyO9PfDp7NKDeldRcH02rFp1rzvcik
	lZDYwvrIa4Pj6k4fm0woVMjVpCAJkqbXyJXKrQQie+lPy4ihtYCUEliEfgnNfAGRbEdwjStVYFO
	+cQXSy8Y+IUaonQXkx++q87PX7X+DixfJsCVF51sAXDffmZIsReoFXPJJLxCihNQxRGlwEHXttt
	PXWFPxuCufsmxMoRWM9cXa6TuQ8oDZ9mwYn16Q
X-Received: by 2002:a5d:4389:0:b0:368:4638:add0 with SMTP id ffacd0b85a97d-36bbc11d668mr6583029f8f.35.1722849614446;
        Mon, 05 Aug 2024 02:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Bv+cK+3pEFZR7AcsgWTTXDHP/DbQoDhWv/UOVRtYXX4CKgY5khMRU1xo9wiX8R/nDHo29g==
X-Received: by 2002:a5d:4389:0:b0:368:4638:add0 with SMTP id ffacd0b85a97d-36bbc11d668mr6582998f8f.35.1722849613779;
        Mon, 05 Aug 2024 02:20:13 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.21.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06e0f5sm9177062f8f.104.2024.08.05.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:20:13 -0700 (PDT)
Date: Mon, 5 Aug 2024 11:20:11 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: bpf@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, asavkov@redhat.com
Subject: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am experimenting with using BPF to monitor and verify SCHED_DEADLINE
behavior when dealing with priority inheritance and it looks like I'm
reliably hitting the following NULL pointer dereference. I am under the
assumption this shouldn't be possible with BPF thanks to the verifier,
so I'm reaching out to understand if the problem is in the operator
(myself, doing something obviously wrong) or if I might be hitting a
genuine issue.

The BPF program is available at

https://gitlab.com/jlelli/dlmon/-/blob/main/src/dlmon.bpf.c?ref_type=heads

I am pretty sure it has issues in itself, but again I didn't expect it
could crash my system.

First occurrence comes from starting this simple kernel module that creates
a bunch of SCHED_DEADLINE tasks locking an rt_mutex:

https://gitlab.com/jlelli/dlmon/-/blob/main/module/pit.c?ref_type=heads

After loading the pit module, start the dlmon BPF program and it should
crash (maybe restart it a few times in case it doesn't right away).

--->8---
[  330.621728] Initializing PIT
[  330.624625] pit module --- lock=rtmutex
[  338.233883] BUG: kernel NULL pointer dereference, address: 000000000000040c
[  338.240852] #PF: supervisor read access in kernel mode
[  338.245990] #PF: error_code(0x0000) - not-present page
[  338.251129] PGD 0 P4D 0
[  338.253670] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  338.258550] CPU: 123 UID: 0 PID: 4213 Comm: low Tainted: G           OE      6.11.0-rc1 #1
[  338.266810] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  338.272121] Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS 2.14.1 12/17/2023
[  338.279773] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x2a/0xe3
[  338.287339] Code: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
[  338.306084] RSP: 0018:ffffb7fb4ed37d00 EFLAGS: 00010086
[  338.311312] RAX: ffffffffc012ec8c RBX: ffffb7fb4ed37d68 RCX: ffff88e5df9b5900
[  338.318446] RDX: ffff88dea5cb99c0 RSI: ffffb7fb4a5f5048 RDI: ffffb7fb4ed37d68
[  338.325579] RBP: ffffb7fb4ed37d48 R08: 0000004ec048f000 R09: 00000000000003d7
[  338.332711] R10: 000000000000c8f4 R11: 0000007b00001075 R12: 0000000000000000
[  338.339843] R13: ffff88dea5cb99c0 R14: 0000000000000000 R15: 0000000000000001
[  338.346976] FS:  0000000000000000(0000) GS:ffff88e5df980000(0000) knlGS:0000000000000000
[  338.355062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  338.360807] CR2: 000000000000040c CR3: 0000000657022000 CR4: 0000000000350ef0
[  338.367940] Call Trace:
[  338.370396]  <TASK>
[  338.372498]  ? srso_return_thunk+0x5/0x5f
[  338.376514]  ? show_trace_log_lvl+0x255/0x2f0
[  338.380875]  ? show_trace_log_lvl+0x255/0x2f0
[  338.385234]  ? bpf_trace_run2+0x89/0x110
[  338.389158]  ? __die_body.cold+0x8/0x12
[  338.392998]  ? page_fault_oops+0x146/0x160
[  338.397097]  ? exc_page_fault+0x73/0x160
[  338.401022]  ? asm_exc_page_fault+0x26/0x30
[  338.405211]  ? 0xffffffffc012ec8c
[  338.408536]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x2a/0xe3
[  338.415497]  ? srso_return_thunk+0x5/0x5f
[  338.419509]  ? srso_return_thunk+0x5/0x5f
[  338.423521]  ? sysvec_irq_work+0xe/0x90
[  338.427359]  ? srso_return_thunk+0x5/0x5f
[  338.431372]  ? srso_return_thunk+0x5/0x5f
[  338.435387]  ? srso_return_thunk+0x5/0x5f
[  338.439399]  bpf_trace_run2+0x89/0x110
[  338.443152]  rt_mutex_setprio+0x1d3/0x3d0
[  338.447170]  mark_wakeup_next_waiter+0x80/0xd0
[  338.451622]  rt_mutex_unlock+0xea/0x130
[  338.455456]  ? __trace_bprintk+0x90/0xa0
[  338.459387]  ? periodic_run+0x122/0x360 [pit]
[  338.463745]  ? periodic_run+0x75/0x360 [pit]
[  338.468017]  periodic_run+0x29b/0x360 [pit]
[  338.472202]  ? periodic_run+0x75/0x360 [pit]
[  338.476477]  ? __pfx_periodic_run+0x10/0x10 [pit]
[  338.481182]  kthread+0xd2/0x100
[  338.484328]  ? __pfx_kthread+0x10/0x10
[  338.488079]  ret_from_fork+0x34/0x50
[  338.491659]  ? __pfx_kthread+0x10/0x10
[  338.495412]  ret_from_fork_asm+0x1a/0x30
[  338.499342]  </TASK>
[  338.501530] Modules linked in: pit(OE) vfat fat ipmi_ssif intel_rapl_msr amd_atl intel_rapl_common amd64_edac edac_mce_amd kvm_amd ice kvm dell_pc platform_profile dell_wmi bnxt_en sparse_keymap rfkill tg3 video mgag200 acpi_power_meter ipmi_si gnss acpi_ipmi dcdbas dell_smbios i2c_piix4 libie ipmi_devintf i2c_algo_bit dell_wmi_descriptor ipmi_msghandler rapl pcspkr ptdma acpi_cpufreq k10temp wmi_bmof i2c_smbus fuse loop nfnetlink xfs sd_mod ahci crct10dif_pclmul libahci crc32_pclmul crc32c_intel ghash_clmulni_intel libata ccp megaraid_sas sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod
[  338.501607] Unloaded tainted modules: pit(OE):3 [last unloaded: pit(OE)]
[  338.560682] CR2: 000000000000040c
[  338.564003] ---[ end trace 0000000000000000 ]---
--->8---

Wondering if maybe my module was the culprit, I also then verified that
I could hit the crash simply by starting a similar type of workload
completely from userspace by the use of rt-app with the following
taskset:

https://gitlab.com/jlelli/dlmon/-/blob/main/samples/rt-app/multi_lock.json?ref_type=heads

This script should help with installing rt-app:

https://gitlab.com/jlelli/dlmon/-/blob/main/samples/rt-app/install_fedora.sh?ref_type=heads

Starting rt-app with the above taskset and then starting dlmon (again
maybe several times) should eventually trigger the following crash.

--->8---
[  154.566882] BUG: kernel NULL pointer dereference, address: 000000000000040c
[  154.573844] #PF: supervisor read access in kernel mode
[  154.578982] #PF: error_code(0x0000) - not-present page
[  154.584122] PGD 146fff067 P4D 146fff067 PUD 10fc00067 PMD 0
[  154.589780] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  154.594659] CPU: 28 UID: 0 PID: 2234 Comm: thread0-13 Kdump: loaded Not tainted 6.11.0-rc1 #8
[  154.603179] Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
[  154.610744] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
[  154.618310] Code: cc cc cc cc cc cc cc cc 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
[  154.637052] RSP: 0018:ffffabac60aebbc0 EFLAGS: 00010086
[  154.642278] RAX: ffffffffc03fba5c RBX: ffffabac60aebc28 RCX: 000000000000001f
[  154.649411] RDX: ffff95a90b4e4180 RSI: ffffabac4e639048 RDI: ffffabac60aebc28
[  154.656544] RBP: ffffabac60aebc08 R08: 00000023fce7674a R09: ffff95a91d85af38
[  154.663674] R10: ffff95a91d85a0c0 R11: 000000003357e518 R12: 0000000000000000
[  154.670807] R13: ffff95a90b4e4180 R14: 0000000000000000 R15: 0000000000000001
[  154.677939] FS:  00007ffa6d600640(0000) GS:ffff95c01bf00000(0000) knlGS:0000000000000000
[  154.686026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  154.691769] CR2: 000000000000040c CR3: 000000014b9f2005 CR4: 00000000007706f0
[  154.698903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  154.706035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  154.713168] PKRU: 55555554
[  154.715879] Call Trace:
[  154.718332]  <TASK>
[  154.720439]  ? __die+0x20/0x70
[  154.723498]  ? page_fault_oops+0x75/0x170
[  154.727508]  ? sysvec_irq_work+0xb/0x90
[  154.731348]  ? exc_page_fault+0x64/0x140
[  154.735275]  ? asm_exc_page_fault+0x22/0x30
[  154.739461]  ? 0xffffffffc03fba5c
[  154.742780]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
[  154.749737]  bpf_trace_run2+0x71/0xf0
[  154.753405]  ? raw_spin_rq_lock_nested+0x19/0x80
[  154.758023]  rt_mutex_setprio+0x1bf/0x3d0
[  154.762035]  ? hrtimer_nanosleep+0xb1/0x190
[  154.766221]  ? rseq_get_rseq_cs+0x1d/0x220
[  154.770320]  mark_wakeup_next_waiter+0x85/0xd0
[  154.774765]  __rt_mutex_futex_unlock+0x1c/0x40
[  154.779211]  futex_unlock_pi+0x240/0x310
[  154.783137]  do_futex+0x149/0x1d0
[  154.786457]  __x64_sys_futex+0x73/0x1d0
[  154.790294]  do_syscall_64+0x79/0x150
[  154.793962]  ? update_process_times+0x8c/0xa0
[  154.798319]  ? timerqueue_add+0x9b/0xc0
[  154.802158]  ? enqueue_hrtimer+0x35/0x90
[  154.806085]  ? __hrtimer_run_queues+0x141/0x2a0
[  154.810616]  ? ktime_get+0x34/0xc0
[  154.814021]  ? clockevents_program_event+0x92/0x100
[  154.818901]  ? hrtimer_interrupt+0x129/0x240
[  154.823174]  ? sched_clock+0xc/0x30
[  154.826666]  ? sched_clock_cpu+0xb/0x190
[  154.830591]  ? irqtime_account_irq+0x41/0xc0
[  154.834865]  ? clear_bhb_loop+0x45/0xa0
[  154.838702]  ? clear_bhb_loop+0x45/0xa0
[  154.842542]  ? clear_bhb_loop+0x45/0xa0
[  154.846381]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  154.851434] RIP: 0033:0x7ffa75a8e956
[  154.855011] Code: 0f 86 26 fe ff ff 83 c0 16 83 e0 f7 0f 85 2d ff ff ff e9 15 fe ff ff 40 80 f6 87 45 31 d2 31 d2 4c 89 c7 b8 ca 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 86 5b fd ff ff 83 f8 92 0f 84 52 fd ff ff 83
[  154.873757] RSP: 002b:00007ffa6d5ffb98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
[  154.881321] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa75a8e956
[  154.888454] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 000000003357e518
[  154.895587] RBP: 0000000000000002 R08: 000000003357e518 R09: 0000000000000000
[  154.902718] R10: 0000000000000000 R11: 0000000000000246 R12: 000000003357e518
[  154.909852] R13: 000000003357e510 R14: 0000000000000000 R15: 000000003357e8e8
[  154.916983]  </TASK>
[  154.919176] Modules linked in: qrtr rfkill vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal coretemp ipmi_ssif rapl iTCO_wdt iTCO_vendor_support dell_pc intel_cstate dell_smbios platform_profile mei_me i2c_i801 acpi_power_meter dcdbas intel_uncore dell_wmi_descriptor wmi_bmof pcspkr ipmi_si mei i2c_smbus lpc_ich acpi_ipmi intel_pch_thermal ipmi_devintf ipmi_msghandler xfs libcrc32c sr_mod sd_mod cdrom sg uas usb_storage mgag200 drm_shmem_helper drm_kms_helper ahci crct10dif_pclmul libahci crc32_pclmul i40e drm igb crc32c_intel libata dca megaraid_sas ghash_clmulni_intel i2c_algo_bit libie wmi dm_mirror dm_region_hash dm_log dm_mod fuse
[  154.984673] CR2: 000000000000040c
--->8---

Apologies for the rather long report, but I tried to provide hopefully
enough information already for whoever might have time to take a look at
this. Please let me know if I'm either wrong in what I'm trying to do or
how to proceed (if you need more info, etc.).

Thank you in advance!

Best,
Juri


