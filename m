Return-Path: <bpf+bounces-33965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E24928E4B
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 22:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FD2B26BA6
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE68313C9BD;
	Fri,  5 Jul 2024 20:34:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698213C681;
	Fri,  5 Jul 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211666; cv=none; b=Ch66PjPvyvIX8XvX5PKCRbmt+bY7fSAlLBJtCYou2A6nnmnUusdx66vxcsE66dfAP8A6HuPbv7qRoAb/Y+VCpRj20FcalITVkGi3u0nW4LcL61camh2g0ww1RF+8ePQv1OlTMEJHR0UanPR+ufFqBNgGj8x+JM7oj/HUY9sR5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211666; c=relaxed/simple;
	bh=tHjB+PnraxGCzDWJI125nIwVhGgqAWzKSn7lIxot2j0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dV+EREzgfIaSI8gxgjum1qCT3dsOaajOXkFpHxY8obgf1iKAWKR26fk//fXKxMXYu55PfQs1iuy8sqp8a5m+FFNNwLwBvnjJm9/27ewRuyvAGXRcVaWkSLuzuu9ageHW/r22IP6YUHOqAShw7n4/qOdTFL8/tdLE5MUB3vUzVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2A91B72C8CC;
	Fri,  5 Jul 2024 23:34:14 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id BEDB736D0174;
	Fri,  5 Jul 2024 23:34:13 +0300 (MSK)
Date: Fri, 5 Jul 2024 23:34:13 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>
Cc: ltp@lists.linux.it, stable@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Subject: WARNING&Oops in v6.6.37 on ppc64lea - Trying to vfree() bad address
 (00000000453be747)
Message-ID: <20240705203413.wbv2nw3747vjeibk@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi,

There is new WARNING and Oops on ppc64le in v6.6.37 when running LTP tests:
bpf_prog01, bpf_prog02, bpf_prog04, bpf_prog05, prctl04. Logs excerpt below. I
see there is 1 commit in v6.6.36..v6.6.37 with call to
bpf_jit_binary_pack_finalize, backported from 5 patch mainline patchset:

  f99feda5684a powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]

Log:

 [    8.822079] LTP: starting bpf_prog01
 [    8.841853] ------------[ cut here ]------------
 [    8.841946] Trying to vfree() bad address (00000000453be747)
 [    8.842024] WARNING: CPU: 6 PID: 689 at mm/vmalloc.c:2700 remove_vm_area+0xb4/0xf0
 [    8.842103] Modules linked in: virtio_rng rng_core virtio_net net_failover failover sd_mod ata_generic ata_piix libata scsi_mod scsi_common virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev 9pnet_virtio virtio_ring virtio 9p 9pnet netfs
 [    8.842323] CPU: 6 PID: 689 Comm: bpf_prog01 Not tainted 6.6.37-un-def-alt1 #1
 [    8.842396] Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,git-3a259d hv:linux,kvm pSeries
 [    8.842519] NIP:  c0000000004faf04 LR: c0000000004faf00 CTR: 0000000000000000
 [    8.842598] REGS: c000000009b6f250 TRAP: 0700   Not tainted  (6.6.37-un-def-alt1)
 [    8.842669] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28002822  XER: 00000000
 [    8.842748] CFAR: c00000000015df94 IRQMASK: 0 
 [    8.842748] GPR00: 0000000000000000 c000000009b6f4f0 c000000001ac7f00 0000000000000000 
 [    8.842748] GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.842748] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.842748] GPR12: 0000000000000000 c00000003fff7a00 0000000000000000 0000000000000000 
 [    8.842748] GPR16: 0000000000000012 0000000000000000 000000000000008c 0000000000000000 
 [    8.842748] GPR20: c008000000040a40 0000000000000002 c0000000022a7560 c008000000040a4c 
 [    8.842748] GPR24: c000000005716480 0000000000000000 c000000002155698 c0000000022a7680 
 [    8.842748] GPR28: c000000002155688 c008000000040a40 c008000000040a40 c008000000040a40 
 [    8.843347] NIP [c0000000004faf04] remove_vm_area+0xb4/0xf0
 [    8.843398] LR [c0000000004faf00] remove_vm_area+0xb0/0xf0
 [    8.843448] Call Trace:
 [    8.843484] [c000000009b6f4f0] [c0000000004faf00] remove_vm_area+0xb0/0xf0 (unreliable)
 [    8.843559] [c000000009b6f560] [c0000000004fb360] vfree+0x60/0x2a0
 [    8.843621] [c000000009b6f5e0] [c000000000269c6c] module_memfree+0x3c/0x60
 [    8.843685] [c000000009b6f600] [c00000000038cf60] bpf_jit_free_exec+0x20/0x40
 [    8.843759] [c000000009b6f620] [c00000000038f518] bpf_prog_pack_free+0x2f8/0x390
 [    8.843832] [c000000009b6f6b0] [c00000000038f878] bpf_jit_binary_pack_finalize+0x98/0xd0
 [    8.843906] [c000000009b6f6e0] [c000000000118240] bpf_int_jit_compile+0x2c0/0x710
 [    8.843979] [c000000009b6f830] [c00000000038ef64] bpf_prog_select_runtime+0x154/0x1b0
 [    8.844053] [c000000009b6f880] [c000000000398edc] bpf_prog_load+0x94c/0xe90
 [    8.844114] [c000000009b6f990] [c00000000039c878] __sys_bpf+0x418/0x2970
 [    8.844176] [c000000009b6fac0] [c00000000039f1a0] sys_bpf+0x30/0x50
 [    8.844237] [c000000009b6fae0] [c000000000030230] system_call_exception+0x190/0x390
 [    8.844312] [c000000009b6fe50] [c00000000000c7d4] system_call_common+0xf4/0x258
 [    8.844386] --- interrupt: c00 at 0x7fffb0839ad4
 [    8.844437] NIP:  00007fffb0839ad4 LR: 000000012a027fb4 CTR: 0000000000000000
 [    8.844524] REGS: c000000009b6fe80 TRAP: 0c00   Not tainted  (6.6.37-un-def-alt1)
 [    8.844596] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 22002240  XER: 00000000
 [    8.844690] IRQMASK: 0 
 [    8.844690] GPR00: 0000000000000169 00007fffd8534200 00007fffb0936d00 0000000000000005 
 [    8.844690] GPR04: 00007fffb06aff90 0000000000000070 000000012a0538a0 0000000000000001 
 [    8.844690] GPR08: 000000012a0801f4 0000000000000000 0000000000000000 0000000000000000 
 [    8.844690] GPR12: 0000000000000000 00007fffb09ea540 0000000000000000 0000000000000000 
 [    8.844690] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.844690] GPR20: 00007fffd85344b0 0000000000000000 0000000000000001 0000000000000000 
 [    8.844690] GPR24: 000000012a0801f4 00007fffb06ce000 0000000000000000 00000000000f4240 
 [    8.844690] GPR28: 00007fffb06aff90 00007fffb09e3550 0000000000000001 0000000000001118 
 [    8.845267] NIP [00007fffb0839ad4] 0x7fffb0839ad4
 [    8.845315] LR [000000012a027fb4] 0x12a027fb4
 [    8.845363] --- interrupt: c00
 [    8.845399] Code: 38000000 38800000 39200000 4e800020 60000000 60000000 60420000 3c62ffa2 7fe4fb78 3863e698 4bc62f8d 60000000 <0fe00000> 38210070 3bc00000 e8010010 
 [    8.845550] ---[ end trace 0000000000000000 ]---
 [    8.845603] ------------[ cut here ]------------
 [    8.845651] Trying to vfree() nonexistent vm area (00000000453be747)
 [    8.845714] WARNING: CPU: 6 PID: 689 at mm/vmalloc.c:2835 vfree+0x1d8/0x2a0
 [    8.845776] Modules linked in: virtio_rng rng_core virtio_net net_failover failover sd_mod ata_generic ata_piix libata scsi_mod scsi_common virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev 9pnet_virtio virtio_ring virtio 9p 9pnet netfs
 [    8.845989] CPU: 6 PID: 689 Comm: bpf_prog01 Tainted: G        W          6.6.37-un-def-alt1 #1
 [    8.846072] Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,git-3a259d hv:linux,kvm pSeries
 [    8.846177] NIP:  c0000000004fb4d8 LR: c0000000004fb4d4 CTR: 0000000000000000
 [    8.846248] REGS: c000000009b6f2c0 TRAP: 0700   Tainted: G        W           (6.6.37-un-def-alt1)
 [    8.846330] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28002222  XER: 00000000
 [    8.846408] CFAR: c00000000015df94 IRQMASK: 0 
 [    8.846408] GPR00: 0000000000000000 c000000009b6f560 c000000001ac7f00 0000000000000000 
 [    8.846408] GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.846408] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.846408] GPR12: 0000000000000000 c00000003fff7a00 0000000000000000 0000000000000000 
 [    8.846408] GPR16: 0000000000000012 0000000000000000 000000000000008c 0000000000000000 
 [    8.846408] GPR20: c008000000040a40 0000000000000002 c0000000022a7560 c008000000040a4c 
 [    8.846408] GPR24: c000000005716480 0000000000000000 c000000002155698 c0000000022a7680 
 [    8.846408] GPR28: c000000002155688 0000000000000000 c008000000040a40 0000000000000000 
 [    8.851030] NIP [c0000000004fb4d8] vfree+0x1d8/0x2a0
 [    8.851085] LR [c0000000004fb4d4] vfree+0x1d4/0x2a0
 [    8.851135] Call Trace:
 [    8.851160] [c000000009b6f560] [c0000000004fb4d4] vfree+0x1d4/0x2a0 (unreliable)
 [    8.851234] [c000000009b6f5e0] [c000000000269c6c] module_memfree+0x3c/0x60
 [    8.851297] [c000000009b6f600] [c00000000038cf60] bpf_jit_free_exec+0x20/0x40
 [    8.851371] [c000000009b6f620] [c00000000038f518] bpf_prog_pack_free+0x2f8/0x390
 [    8.851445] [c000000009b6f6b0] [c00000000038f878] bpf_jit_binary_pack_finalize+0x98/0xd0
 [    8.851529] [c000000009b6f6e0] [c000000000118240] bpf_int_jit_compile+0x2c0/0x710
 [    8.851602] [c000000009b6f830] [c00000000038ef64] bpf_prog_select_runtime+0x154/0x1b0
 [    8.851675] [c000000009b6f880] [c000000000398edc] bpf_prog_load+0x94c/0xe90
 [    8.851737] [c000000009b6f990] [c00000000039c878] __sys_bpf+0x418/0x2970
 [    8.851798] [c000000009b6fac0] [c00000000039f1a0] sys_bpf+0x30/0x50
 [    8.851860] [c000000009b6fae0] [c000000000030230] system_call_exception+0x190/0x390
 [    8.851934] [c000000009b6fe50] [c00000000000c7d4] system_call_common+0xf4/0x258
 [    8.852007] --- interrupt: c00 at 0x7fffb0839ad4
 [    8.852057] NIP:  00007fffb0839ad4 LR: 000000012a027fb4 CTR: 0000000000000000
 [    8.852128] REGS: c000000009b6fe80 TRAP: 0c00   Tainted: G        W           (6.6.37-un-def-alt1)
 [    8.852212] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 22002240  XER: 00000000
 [    8.852307] IRQMASK: 0 
 [    8.852307] GPR00: 0000000000000169 00007fffd8534200 00007fffb0936d00 0000000000000005 
 [    8.852307] GPR04: 00007fffb06aff90 0000000000000070 000000012a0538a0 0000000000000001 
 [    8.852307] GPR08: 000000012a0801f4 0000000000000000 0000000000000000 0000000000000000 
 [    8.852307] GPR12: 0000000000000000 00007fffb09ea540 0000000000000000 0000000000000000 
 [    8.852307] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.852307] GPR20: 00007fffd85344b0 0000000000000000 0000000000000001 0000000000000000 
 [    8.852307] GPR24: 000000012a0801f4 00007fffb06ce000 0000000000000000 00000000000f4240 
 [    8.852307] GPR28: 00007fffb06aff90 00007fffb09e3550 0000000000000001 0000000000001118 
 [    8.852889] NIP [00007fffb0839ad4] 0x7fffb0839ad4
 [    8.852938] LR [000000012a027fb4] 0x12a027fb4
 [    8.852986] --- interrupt: c00
 [    8.853022] Code: 4e800020 60420000 3949ffff 4bffff0c 38210080 ebe1fff8 4bfffd68 3c62ffa2 7fc4f378 3863e6f0 4bc629b9 60000000 <0fe00000> eba10068 4bffff8c 2c080000 
 [    8.853164] ---[ end trace 0000000000000000 ]---
 [    8.856619] kernel tried to execute exec-protected page (c008000000040a4c) - exploit attempt? (uid: 0)
 [    8.856717] BUG: Unable to handle kernel instruction fetch
 [    8.856763] Faulting instruction address: 0xc008000000040a4c
 [    8.856825] Oops: Kernel access of bad area, sig: 11 [#1]
 [    8.856875] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
 [    8.856937] Modules linked in: virtio_rng rng_core virtio_net net_failover failover sd_mod ata_generic ata_piix libata scsi_mod scsi_common virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev 9pnet_virtio virtio_ring virtio 9p 9pnet netfs
 [    8.857154] CPU: 6 PID: 689 Comm: bpf_prog01 Tainted: G        W          6.6.37-un-def-alt1 #1
 [    8.857236] Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,git-3a259d hv:linux,kvm pSeries
 [    8.857342] NIP:  c008000000040a4c LR: c000000000ed25d0 CTR: c008000000040a4c
 [    8.857413] REGS: c000000009b6f6f0 TRAP: 0400   Tainted: G        W           (6.6.37-un-def-alt1)
 [    8.857510] MSR:  8000000010009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28008286  XER: 00000000
 [    8.857588] CFAR: c000000000ed25cc IRQMASK: 0 
 [    8.857588] GPR00: c000000000ed25a8 c000000009b6f990 c000000001ac7f00 c000000006130400 
 [    8.857588] GPR04: c008000000920048 0000000000000001 0000000000000000 0000000000000000 
 [    8.857588] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.857588] GPR12: c008000000040a4c c00000003fff7a00 0000000000000000 0000000000000000 
 [    8.857588] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.857588] GPR20: 7fffffffffffffff 0000000000000000 0000000000000001 0000000000000000 
 [    8.857588] GPR24: c000000006130400 c000000006510a00 c000000006510f00 c0000000041a9000 
 [    8.857588] GPR28: 0000000000000001 c000000006130400 0000000000000000 c008000000920000 
 [    8.858184] NIP [c008000000040a4c] bpf_prog_2fb4fda3a3499517+0x0/0x8c
 [    8.858245] LR [c000000000ed25d0] sk_filter_trim_cap+0xc0/0x370
 [    8.858308] Call Trace:
 [    8.858333] [c000000009b6f990] [c000000000ed2574] sk_filter_trim_cap+0x64/0x370 (unreliable)
 [    8.858421] [c000000009b6fa10] [c000000001068b64] unix_dgram_sendmsg+0x214/0xb10
 [    8.858511] [c000000009b6fad0] [c000000000e4c59c] sock_write_iter+0x19c/0x1e0
 [    8.858586] [c000000009b6fb80] [c0000000005b1b58] vfs_write+0x258/0x4e0
 [    8.858648] [c000000009b6fc40] [c0000000005b21d4] ksys_write+0x114/0x170
 [    8.858711] [c000000009b6fc90] [c000000000030230] system_call_exception+0x190/0x390
 [    8.858785] [c000000009b6fe50] [c00000000000c7d4] system_call_common+0xf4/0x258
 [    8.858859] --- interrupt: c00 at 0x7fffb082b884
 [    8.858908] NIP:  00007fffb082b884 LR: 000000012a02ab70 CTR: 0000000000000000
 [    8.858979] REGS: c000000009b6fe80 TRAP: 0c00   Tainted: G        W           (6.6.37-un-def-alt1)
 [    8.859060] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28002281  XER: 00000000
 [    8.859153] IRQMASK: 0 
 [    8.859153] GPR00: 0000000000000004 00007fffd85341f0 00007fffb0936d00 0000000000000005 
 [    8.859153] GPR04: 00007fffb068fffa 0000000000000006 0000000000000001 0000000000000005 
 [    8.859153] GPR08: 00007fffb068fffa 0000000000000000 0000000000000000 0000000000000000 
 [    8.859153] GPR12: 0000000000000000 00007fffb09ea540 0000000000000000 0000000000000000 
 [    8.859153] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
 [    8.859153] GPR20: 00007fffd85344b0 0000000000000000 0000000000000001 0000000000000000 
 [    8.859153] GPR24: 000000012a053698 000000000000008b 0000000000000000 0000000000000001 
 [    8.859153] GPR28: 00007fffb068fffa 0000000000000005 0000000000000006 000000012a053698 
 [    8.859738] NIP [00007fffb082b884] 0x7fffb082b884
 [    8.859786] LR [000000012a02ab70] 0x12a02ab70
 [    8.859836] --- interrupt: c00
 [    8.859872] Code: 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 7fe00008 <7fe00008> 7fe00008 7fe00008 7fe00008 
 [    8.860013] ---[ end trace 0000000000000000 ]---
 [    8.863088] pstore: backend (nvram) writing error (-1)
 [    8.863141] 
 [    8.863166] note: bpf_prog01[689] exited with irqs disabled

And so on. Temporary build/test log is at
https://git.altlinux.org/tasks/352218/build/100/ppc64le/log

Other stable/longterm branches or other architectures does not exhibit this.

Thanks,


