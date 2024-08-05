Return-Path: <bpf+bounces-36400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E83947F93
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989D61C213B7
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71315B984;
	Mon,  5 Aug 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTaAUSM7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842313AD26;
	Mon,  5 Aug 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876601; cv=none; b=Iz4BwuHVdjfdBl9DtzKLN3JGHbq8GAQyuOaXsKWfvImz/4vSieHxxfQggXYCscOLwCnlRW/cic4aMt6txYTjOtCuKAgI/UvRu8u9k03EYtry/Giw9XTsyUXsciD7xtR8AuU+UP2T0EqyWCEhL4BhAAsXSo5MAY5chm7tchiGZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876601; c=relaxed/simple;
	bh=0yOG3d0og9XaPy3QFsEkDY3rEop4ZxL8fgJIN+HjmB0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMSg2owiPrXMgkx0VTPGKkOkMoCEGI+U4UXrCVD7YuufN8fo+sjgrgjqp9cu9Oc3x+/Gqldkyk0sLYePfI2SzQN07IfFS5UyBzoWa2rNUUawG+0qhhtDYTCyNgWKrl5AwBPP2qimHOUYAIH8OAjgVaYoYRe+pnE/vFLCP29839Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTaAUSM7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aada2358fso955614266b.0;
        Mon, 05 Aug 2024 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876598; x=1723481398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/vFhk95WDQeyS2VNuBAJSwyrV1m9Q2PPGsriqEWFvE=;
        b=TTaAUSM7oMIPuTmpPCdekGTIsCBjifn0sTmW/daYRlvpPYCMdcNupaTM3+3VIs9S2u
         5rJ20ulMF9alCT49QafmEHId+2bhJyuYvlvLvL143JivtZAADCq52wn55A1w5F/1t6hf
         kRB1F4a1iJmtFsV2FgMCEr75gxKNMU0ZU+YUslF/b8cy5ItvnFqHOB/5n6dCJGoPd+HA
         Emgl3mCRRIeNcP65SRMIqbKSc+3B+VJPhc4v1ykTnKVE9ikktcP0y2Bdz1ZiKbpjlCOG
         S9u3YbWPa7s3txsp/gi0vhT3IIWKJJBufcDHDBJ9pa0Z+xa1IYimD9hIVWMKo8DgkrgX
         nLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876598; x=1723481398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/vFhk95WDQeyS2VNuBAJSwyrV1m9Q2PPGsriqEWFvE=;
        b=kyaZEddFEfH0+QC5p6yHF42EneAdPMyJu+FW/4KhrVN1JLUvXjAETmdwQzBBDHK1sF
         Ssgd597rM4mPbI2YYPL+KxJK3SnEX7XhgvMUrNdX6BttN+0cOmK4e7qf4lCfy+Fj5/N3
         ZtiqJScFEx7XD8impwRAaExgBuAHI81tK05Sx5fpxBE0G8gu4yHqfmewBwARV6XJzPbQ
         Ambpe1b10I1VFwhuz4I2CMPB18enExwqXVZA2G0Xenp1+B/7IfZKFyPfNood7vfpN4xj
         N30Akd+ZIvRb+VlFPTJsFjGA+yxto8pOJjIcZC7LXV1lLrVJd9m367z9cvy2rHNbML43
         8mCg==
X-Forwarded-Encrypted: i=1; AJvYcCWX1gSIwT353pj/XySGcDkMxH0kkFuaSzYntSsy11vWzCLYiETJJWSn54WqYxR8GsqSTF80MWBM5hV2psHdIphq/1SagfjYOtSZyIbZ
X-Gm-Message-State: AOJu0YwD4yyw3fp1c4cOIPLbI8xdPxZOSw+a6iJu+k9BXATStdLn3wVS
	XkxvWjHOQmR3vbz5YnsYppbbqcXfUCLUppCjxq5JQOmwqtadSjPT1vcVuQ==
X-Google-Smtp-Source: AGHT+IE3L2FJunJVPBwQaAhvUVjotmG2qD5QKg3yjEh1KV7wOsaKFmbuQvQXq9PSVWkfJBc7AualTw==
X-Received: by 2002:a17:907:ea0:b0:a7a:acae:3419 with SMTP id a640c23a62f3a-a7dbe66b2b6mr1191801166b.28.1722876597276;
        Mon, 05 Aug 2024 09:49:57 -0700 (PDT)
Received: from krava (85-193-35-46.rib.o2.cz. [85.193.35.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb551sm468883166b.223.2024.08.05.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:49:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 5 Aug 2024 18:49:54 +0200
To: Juri Lelli <juri.lelli@redhat.com>
Cc: bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	asavkov@redhat.com
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZrECsnSJWDS7jFUu@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>

On Mon, Aug 05, 2024 at 11:20:11AM +0200, Juri Lelli wrote:

SNIP

> [  154.566882] BUG: kernel NULL pointer dereference, address: 000000000000040c
> [  154.573844] #PF: supervisor read access in kernel mode
> [  154.578982] #PF: error_code(0x0000) - not-present page
> [  154.584122] PGD 146fff067 P4D 146fff067 PUD 10fc00067 PMD 0
> [  154.589780] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  154.594659] CPU: 28 UID: 0 PID: 2234 Comm: thread0-13 Kdump: loaded Not tainted 6.11.0-rc1 #8
> [  154.603179] Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
> [  154.610744] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> [  154.618310] Code: cc cc cc cc cc cc cc cc 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
> [  154.637052] RSP: 0018:ffffabac60aebbc0 EFLAGS: 00010086
> [  154.642278] RAX: ffffffffc03fba5c RBX: ffffabac60aebc28 RCX: 000000000000001f
> [  154.649411] RDX: ffff95a90b4e4180 RSI: ffffabac4e639048 RDI: ffffabac60aebc28
> [  154.656544] RBP: ffffabac60aebc08 R08: 00000023fce7674a R09: ffff95a91d85af38
> [  154.663674] R10: ffff95a91d85a0c0 R11: 000000003357e518 R12: 0000000000000000
> [  154.670807] R13: ffff95a90b4e4180 R14: 0000000000000000 R15: 0000000000000001
> [  154.677939] FS:  00007ffa6d600640(0000) GS:ffff95c01bf00000(0000) knlGS:0000000000000000
> [  154.686026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  154.691769] CR2: 000000000000040c CR3: 000000014b9f2005 CR4: 00000000007706f0
> [  154.698903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  154.706035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  154.713168] PKRU: 55555554
> [  154.715879] Call Trace:
> [  154.718332]  <TASK>
> [  154.720439]  ? __die+0x20/0x70
> [  154.723498]  ? page_fault_oops+0x75/0x170
> [  154.727508]  ? sysvec_irq_work+0xb/0x90
> [  154.731348]  ? exc_page_fault+0x64/0x140
> [  154.735275]  ? asm_exc_page_fault+0x22/0x30
> [  154.739461]  ? 0xffffffffc03fba5c
> [  154.742780]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7

hi,
reproduced.. AFAICS looks like the bpf program somehow lost the booster != NULL
check and just load the policy field without it and crash when booster is rubbish

int handle__sched_pi_setprio(u64 * ctx):
; int handle__sched_pi_setprio(u64 *ctx)
   0: (bf) r6 = r1
; struct task_struct *boosted = (void *) ctx[0];
   1: (79) r7 = *(u64 *)(r6 +0)
; struct task_struct *booster = (void *) ctx[1];
   2: (79) r8 = *(u64 *)(r6 +8)
; if (booster->policy != SCHED_DEADLINE)

curious why the check disappeared, because object file has it, so I guess verifier
took it out for some reason, will check

jirka


> [  154.749737]  bpf_trace_run2+0x71/0xf0
> [  154.753405]  ? raw_spin_rq_lock_nested+0x19/0x80
> [  154.758023]  rt_mutex_setprio+0x1bf/0x3d0
> [  154.762035]  ? hrtimer_nanosleep+0xb1/0x190
> [  154.766221]  ? rseq_get_rseq_cs+0x1d/0x220
> [  154.770320]  mark_wakeup_next_waiter+0x85/0xd0
> [  154.774765]  __rt_mutex_futex_unlock+0x1c/0x40
> [  154.779211]  futex_unlock_pi+0x240/0x310
> [  154.783137]  do_futex+0x149/0x1d0
> [  154.786457]  __x64_sys_futex+0x73/0x1d0
> [  154.790294]  do_syscall_64+0x79/0x150
> [  154.793962]  ? update_process_times+0x8c/0xa0
> [  154.798319]  ? timerqueue_add+0x9b/0xc0
> [  154.802158]  ? enqueue_hrtimer+0x35/0x90
> [  154.806085]  ? __hrtimer_run_queues+0x141/0x2a0
> [  154.810616]  ? ktime_get+0x34/0xc0
> [  154.814021]  ? clockevents_program_event+0x92/0x100
> [  154.818901]  ? hrtimer_interrupt+0x129/0x240
> [  154.823174]  ? sched_clock+0xc/0x30
> [  154.826666]  ? sched_clock_cpu+0xb/0x190
> [  154.830591]  ? irqtime_account_irq+0x41/0xc0
> [  154.834865]  ? clear_bhb_loop+0x45/0xa0
> [  154.838702]  ? clear_bhb_loop+0x45/0xa0
> [  154.842542]  ? clear_bhb_loop+0x45/0xa0
> [  154.846381]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  154.851434] RIP: 0033:0x7ffa75a8e956
> [  154.855011] Code: 0f 86 26 fe ff ff 83 c0 16 83 e0 f7 0f 85 2d ff ff ff e9 15 fe ff ff 40 80 f6 87 45 31 d2 31 d2 4c 89 c7 b8 ca 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 86 5b fd ff ff 83 f8 92 0f 84 52 fd ff ff 83
> [  154.873757] RSP: 002b:00007ffa6d5ffb98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> [  154.881321] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa75a8e956
> [  154.888454] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 000000003357e518
> [  154.895587] RBP: 0000000000000002 R08: 000000003357e518 R09: 0000000000000000
> [  154.902718] R10: 0000000000000000 R11: 0000000000000246 R12: 000000003357e518
> [  154.909852] R13: 000000003357e510 R14: 0000000000000000 R15: 000000003357e8e8
> [  154.916983]  </TASK>
> [  154.919176] Modules linked in: qrtr rfkill vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal coretemp ipmi_ssif rapl iTCO_wdt iTCO_vendor_support dell_pc intel_cstate dell_smbios platform_profile mei_me i2c_i801 acpi_power_meter dcdbas intel_uncore dell_wmi_descriptor wmi_bmof pcspkr ipmi_si mei i2c_smbus lpc_ich acpi_ipmi intel_pch_thermal ipmi_devintf ipmi_msghandler xfs libcrc32c sr_mod sd_mod cdrom sg uas usb_storage mgag200 drm_shmem_helper drm_kms_helper ahci crct10dif_pclmul libahci crc32_pclmul i40e drm igb crc32c_intel libata dca megaraid_sas ghash_clmulni_intel i2c_algo_bit libie wmi dm_mirror dm_region_hash dm_log dm_mod fuse
> [  154.984673] CR2: 000000000000040c
> --->8---
> 
> Apologies for the rather long report, but I tried to provide hopefully
> enough information already for whoever might have time to take a look at
> this. Please let me know if I'm either wrong in what I'm trying to do or
> how to proceed (if you need more info, etc.).
> 
> Thank you in advance!
> 
> Best,
> Juri
> 
> 

