Return-Path: <bpf+bounces-20555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0BF84013C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 10:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D49F1F23407
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33255C3C;
	Mon, 29 Jan 2024 09:18:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC654F85;
	Mon, 29 Jan 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519903; cv=none; b=d6tRtksmV3jY0bQ+hkcq6WebxyTqgGVQZR7XNklM15nrX5uvmieBTGeRr6rZ1TT7Qu8NpAKTjxXkNfGTtVdNyIa+Jz/M1CoqDcIhFSqHfdCIQDMOLe0+Xp76KqAIPMM2QvrHM3RI1pRkQu1qh9OEGRWNzOt/JGsHhu4AepT8eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519903; c=relaxed/simple;
	bh=pegDcFvpeDmA2S8lEI/5yY9EQEQQacSqxB56edI44eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ir+XhbiBDZ709lxXWp/EaBv+vMb+bs/oo7ZWlhanMXSFCxAf439rirRoQS4riGizEcj+p+1Fu025FrMq7SUEA7liTt9U6xHZbhBcVGBXtMWc+odWJdlqdw0fRybU5eIqVmwLXYjoC4QbszYEClykrPYODF7g1Rs+pavTSSUnN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 856162F2024D; Mon, 29 Jan 2024 09:18:17 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 59B662F20231;
	Mon, 29 Jan 2024 09:18:13 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yhs@fb.com,
	songliubraving@fb.com,
	kafai@fb.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	oficerovas@altlinux.org,
	dutyrok@altlinux.org
Subject: [PATCH 5.10.y 0/1] bpf: fix warning ftrace_verify_code
Date: Mon, 29 Jan 2024 12:17:45 +0300
Message-Id: <20240129091746.260538-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller hit 'WARNING in ftrace_verify_code' bug.

This bug is not a vulnerability and is reproduced only when running
with root privileges on stable 5.10 kernel.

journalctl -k (v5.10.206):
... 
bpfilter: Loaded bpfilter_umh pid 2732
Started bpfilter
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4107 at arch/x86/kernel/ftrace.c:97 ftrace_verify_code+0x3e/0x80
WARNING: CPU: 1 PID: 4107 at arch/x86/kernel/ftrace.c:97 ftrace_verify_code+0x3e/0x80
Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter bridge stp llc qrtr bnep hid_generic usbhid uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm btintel videodev bluetooth mc ecdh_generic ecc nls_utf8 nls_cp866 vfat fat coretemp hwmon x86_pkg_temp_thermal intel_powerclamp mei_hdcp kvm_intel kvm rtsx_pci_sdmmc mmc_core irqbypass crct10dif_pclmul wmi_bmof crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd xhci_pci mei_me ucsi_acpi ideapad_laptop cryptd xhci_pci_renesas glue_helper pcspkr typec_ucsi tiny_power_button rtsx_pci sparse_keymap xhci_hcd mei thermal typec wmi i2c_hid button fan rfkill hid acpi_pad intel_pmc_core battery video ac sch_fq_codel vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) vboxvideo
Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter bridge stp llc qrtr bnep hid_generic usbhid uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm btintel videodev bluetooth mc ecdh_generic ecc nls_utf8 nls_cp866 vfat fat coretemp hwmon x86_pkg_temp_thermal intel_powerclamp mei_hdcp kvm_intel kvm rtsx_pci_sdmmc mmc_core irqbypass crct10dif_pclmul wmi_bmof crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd xhci_pci mei_me ucsi_acpi ideapad_laptop cryptd xhci_pci_renesas glue_helper pcspkr typec_ucsi tiny_power_button rtsx_pci sparse_keymap xhci_hcd mei thermal typec wmi i2c_hid button fan rfkill hid acpi_pad intel_pmc_core battery video ac sch_fq_codel vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) vboxvideo
 drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec rc_core vboxsf vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device snd_timer snd soundcore drm msr fuse dm_mod efi_pstore efivarfs ip_tables x_tables autofs4 evdev input_leds serio_raw
 drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec rc_core vboxsf vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device snd_timer snd soundcore drm msr fuse dm_mod efi_pstore efivarfs ip_tables x_tables autofs4 evdev input_leds serio_raw
CPU: 1 PID: 4107 Comm: repro5 Tainted: G           OE     5.10.206-std-def-alt1 #1
CPU: 1 PID: 4107 Comm: repro5 Tainted: G           OE     5.10.206-std-def-alt1 #1
Hardware name: LENOVO 82X8/LNVNB161216, BIOS LTCN30WW 11/08/2023
Hardware name: LENOVO 82X8/LNVNB161216, BIOS LTCN30WW 11/08/2023
RIP: 0010:ftrace_verify_code+0x3e/0x80
RIP: 0010:ftrace_verify_code+0x3e/0x80
Code: 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d 7c 24 03 e8 56 f9 1b 00 48 85 c0 75 3e 8b 03 39 44 24 03 74 28 48 89 1d e2 1d 05 03 <0f> 0b b8 ea ff ff ff 48 8b 4c 24 08 65 48 2b 0c 25 28 00 00 00 75
Code: 25 28 00 00 00 48 89 44 24 08 31 c0 48 8d 7c 24 03 e8 56 f9 1b 00 48 85 c0 75 3e 8b 03 39 44 24 03 74 28 48 89 1d e2 1d 05 03 <0f> 0b b8 ea ff ff ff 48 8b 4c 24 08 65 48 2b 0c 25 28 00 00 00 75
RSP: 0018:ffffc90003aa7c88 EFLAGS: 00010212
RSP: 0018:ffffc90003aa7c88 EFLAGS: 00010212
RAX: 0000000000441f0f RBX: ffffffff82005684 RCX: 0000000000000010
RAX: 0000000000441f0f RBX: ffffffff82005684 RCX: 0000000000000010
RDX: 000000000f9dbb1f RSI: 0000000000000005 RDI: ffffffff8183d240
RDX: 000000000f9dbb1f RSI: 0000000000000005 RDI: ffffffff8183d240
RBP: ffff8881000607a0 R08: 0000000000000001 R09: 0000000000000000
RBP: ffff8881000607a0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffffffff840b9f40 R14: ffffffff82005684 R15: ffffffff82a6a760
R13: ffffffff840b9f40 R14: ffffffff82005684 R15: ffffffff82a6a760
FS:  00007f671d1c2640(0000) GS:ffff8882a7840000(0000) knlGS:0000000000000000
FS:  00007f671d1c2640(0000) GS:ffff8882a7840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efd44003490 CR3: 000000013e3f2000 CR4: 0000000000750ee0
CR2: 00007efd44003490 CR3: 000000013e3f2000 CR4: 0000000000750ee0
PKRU: 55555554
PKRU: 55555554
Call Trace:
Call Trace:
 ? __warn+0x80/0x100
 ? __warn+0x80/0x100
 ? ftrace_verify_code+0x3e/0x80
 ? ftrace_verify_code+0x3e/0x80
 ? report_bug+0x9e/0xc0
 ? report_bug+0x9e/0xc0
 ? handle_bug+0x32/0xa0
 ? handle_bug+0x32/0xa0
 ? exc_invalid_op+0x14/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x12/0x20
 ? asm_exc_invalid_op+0x12/0x20
 ? sk_lookup_convert_ctx_access+0x280/0x280
 ? sk_lookup_convert_ctx_access+0x280/0x280
 ? ftrace_verify_code+0x3e/0x80
 ? ftrace_verify_code+0x3e/0x80
 ? ftrace_verify_code+0x2a/0x80
 ? ftrace_verify_code+0x2a/0x80
 ftrace_replace_code+0xa6/0x190
 ftrace_replace_code+0xa6/0x190
 ftrace_modify_all_code+0xd8/0x170
 ftrace_modify_all_code+0xd8/0x170
 ftrace_run_update_code+0x13/0x70
 ftrace_run_update_code+0x13/0x70
 ftrace_startup.part.0+0xe9/0x160
 ftrace_startup.part.0+0xe9/0x160
 register_ftrace_function+0x52/0x90
 register_ftrace_function+0x52/0x90
 perf_trace_event_init+0x60/0x2b0
 perf_trace_event_init+0x60/0x2b0
 perf_trace_init+0x69/0xa0
 perf_trace_init+0x69/0xa0
 perf_tp_event_init+0x1b/0x50
 perf_tp_event_init+0x1b/0x50
 perf_try_init_event+0x42/0x130
 perf_try_init_event+0x42/0x130
 perf_event_alloc+0x5e3/0xdf0
 perf_event_alloc+0x5e3/0xdf0
 ? __alloc_fd+0x44/0x170
 ? __alloc_fd+0x44/0x170
 __do_sys_perf_event_open+0x1cd/0xec0
 __do_sys_perf_event_open+0x1cd/0xec0
 do_syscall_64+0x30/0x40
 do_syscall_64+0x30/0x40
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
RIP: 0033:0x7f671d2c0d49
RIP: 0033:0x7f671d2c0d49
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f671d1c1df8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RSP: 002b:00007f671d1c1df8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f671d2c0d49
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f671d2c0d49
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007f671d1c1e20 R08: 0000000000000000 R09: 0000000000000000
RBP: 00007f671d1c1e20 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd562f62de
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd562f62de
R13: 00007ffd562f62df R14: 0000000000000000 R15: 00007f671d1c2640
R13: 00007ffd562f62df R14: 0000000000000000 R15: 00007f671d1c2640
---[ end trace 74a81e537b634ec5 ]---
---[ end trace 74a81e537b634ec5 ]---
------------[ ftrace bug ]------------
------------[ ftrace bug ]------------
ftrace failed to modify
ftrace failed to modify
[<ffffffff8183d240>] bpf_dispatcher_xdp_func+0x0/0x10
[<ffffffff8183d240>] bpf_dispatcher_xdp_func+0x0/0x10
 actual:   ffffffe9:ffffffbb:ffffff9d:0f:1f
 actual:   ffffffe9:ffffffbb:ffffff9d:0f:1f
 expected: 0f:1f:44:00:00
 expected: 0f:1f:44:00:00
Setting ftrace call site to call ftrace function
Setting ftrace call site to call ftrace function
ftrace record flags: 10000001
ftrace record flags: 10000001
 (1)
 (1)
                                  expected tramp: ffffffff81068ac0
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4107 at kernel/trace/ftrace.c:2075 ftrace_bug+0x22c/0x256
WARNING: CPU: 1 PID: 4107 at kernel/trace/ftrace.c:2075 ftrace_bug+0x22c/0x256
Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter bridge stp llc qrtr bnep hid_generic usbhid uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm btintel videodev bluetooth mc ecdh_generic ecc nls_utf8 nls_cp866 vfat fat coretemp hwmon x86_pkg_temp_thermal intel_powerclamp mei_hdcp kvm_intel kvm rtsx_pci_sdmmc mmc_core irqbypass crct10dif_pclmul wmi_bmof crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd xhci_pci mei_me ucsi_acpi ideapad_laptop cryptd xhci_pci_renesas glue_helper pcspkr typec_ucsi tiny_power_button rtsx_pci sparse_keymap xhci_hcd mei thermal typec wmi i2c_hid button fan rfkill hid acpi_pad intel_pmc_core battery video ac sch_fq_codel vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) vboxvideo
Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter bridge stp llc qrtr bnep hid_generic usbhid uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm btintel videodev bluetooth mc ecdh_generic ecc nls_utf8 nls_cp866 vfat fat coretemp hwmon x86_pkg_temp_thermal intel_powerclamp mei_hdcp kvm_intel kvm rtsx_pci_sdmmc mmc_core irqbypass crct10dif_pclmul wmi_bmof crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd xhci_pci mei_me ucsi_acpi ideapad_laptop cryptd xhci_pci_renesas glue_helper pcspkr typec_ucsi tiny_power_button rtsx_pci sparse_keymap xhci_hcd mei thermal typec wmi i2c_hid button fan rfkill hid acpi_pad intel_pmc_core battery video ac sch_fq_codel vboxnetadp(OE) vboxnetflt(OE) vboxdrv(OE) vboxvideo
 drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec rc_core vboxsf vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device snd_timer snd soundcore drm msr fuse dm_mod efi_pstore efivarfs ip_tables x_tables autofs4 evdev input_leds serio_raw
 drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec rc_core vboxsf vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device snd_timer snd soundcore drm msr fuse dm_mod efi_pstore efivarfs ip_tables x_tables autofs4 evdev input_leds serio_raw
CPU: 1 PID: 4107 Comm: repro5 Tainted: G        W  OE     5.10.206-std-def-alt1 #1
CPU: 1 PID: 4107 Comm: repro5 Tainted: G        W  OE     5.10.206-std-def-alt1 #1
Hardware name: LENOVO 82X8/LNVNB161216, BIOS LTCN30WW 11/08/2023
Hardware name: LENOVO 82X8/LNVNB161216, BIOS LTCN30WW 11/08/2023
RIP: 0010:ftrace_bug+0x22c/0x256
RIP: 0010:ftrace_bug+0x22c/0x256
Code: ff 84 c0 74 d0 eb b4 48 c7 c7 36 4b 30 82 e8 0b c5 ff ff 48 89 ef e8 2a df 7a ff 48 c7 c7 47 4b 30 82 48 89 c6 e8 f4 c4 ff ff <0f> 0b c7 05 0f a5 2c 01 01 00 00 00 5b c7 05 14 a5 2c 01 00 00 00
Code: ff 84 c0 74 d0 eb b4 48 c7 c7 36 4b 30 82 e8 0b c5 ff ff 48 89 ef e8 2a df 7a ff 48 c7 c7 47 4b 30 82 48 89 c6 e8 f4 c4 ff ff <0f> 0b c7 05 0f a5 2c 01 01 00 00 00 5b c7 05 14 a5 2c 01 00 00 00
RSP: 0018:ffffc90003aa7c88 EFLAGS: 00010246
RSP: 0018:ffffc90003aa7c88 EFLAGS: 00010246
RAX: 0000000000000022 RBX: 00000000ffffffea RCX: ffff8882a7860808
RAX: 0000000000000022 RBX: 00000000ffffffea RCX: ffff8882a7860808
RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8882a7860800
RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8882a7860800
RBP: ffff8881000607a0 R08: 0000000000000000 R09: ffffc90003aa7ac8
RBP: ffff8881000607a0 R08: 0000000000000000 R09: ffffc90003aa7ac8
R10: ffffc90003aa7ac0 R11: ffffffff82ae22e8 R12: ffffffff8183d240
R10: ffffc90003aa7ac0 R11: ffffffff82ae22e8 R12: ffffffff8183d240
R13: ffffffff840b9f40 R14: ffffffff82005684 R15: ffffffff82a6a760
R13: ffffffff840b9f40 R14: ffffffff82005684 R15: ffffffff82a6a760
FS:  00007f671d1c2640(0000) GS:ffff8882a7840000(0000) knlGS:0000000000000000
FS:  00007f671d1c2640(0000) GS:ffff8882a7840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efd44003490 CR3: 000000013e3f2000 CR4: 0000000000750ee0
CR2: 00007efd44003490 CR3: 000000013e3f2000 CR4: 0000000000750ee0
PKRU: 55555554
PKRU: 55555554
Call Trace:
Call Trace:
 ? __warn+0x80/0x100
 ? __warn+0x80/0x100
 ? ftrace_bug+0x22c/0x256
 ? ftrace_bug+0x22c/0x256
 ? report_bug+0x9e/0xc0
 ? report_bug+0x9e/0xc0
 ? handle_bug+0x32/0xa0
 ? handle_bug+0x32/0xa0
 ? exc_invalid_op+0x14/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x12/0x20
 ? asm_exc_invalid_op+0x12/0x20
 ? sk_lookup_convert_ctx_access+0x280/0x280
 ? sk_lookup_convert_ctx_access+0x280/0x280
 ? ftrace_bug+0x22c/0x256
 ? ftrace_bug+0x22c/0x256
 ? ftrace_bug+0x22c/0x256
 ? ftrace_bug+0x22c/0x256
 ftrace_replace_code+0xbb/0x190
 ftrace_replace_code+0xbb/0x190
 ftrace_modify_all_code+0xd8/0x170
 ftrace_modify_all_code+0xd8/0x170
 ftrace_run_update_code+0x13/0x70
 ftrace_run_update_code+0x13/0x70
 ftrace_startup.part.0+0xe9/0x160
 ftrace_startup.part.0+0xe9/0x160
 register_ftrace_function+0x52/0x90
 register_ftrace_function+0x52/0x90
 perf_trace_event_init+0x60/0x2b0
 perf_trace_event_init+0x60/0x2b0
 perf_trace_init+0x69/0xa0
 perf_trace_init+0x69/0xa0
 perf_tp_event_init+0x1b/0x50
 perf_tp_event_init+0x1b/0x50
 perf_try_init_event+0x42/0x130
 perf_try_init_event+0x42/0x130
 perf_event_alloc+0x5e3/0xdf0
 perf_event_alloc+0x5e3/0xdf0
 ? __alloc_fd+0x44/0x170
 ? __alloc_fd+0x44/0x170
 __do_sys_perf_event_open+0x1cd/0xec0
 __do_sys_perf_event_open+0x1cd/0xec0
 do_syscall_64+0x30/0x40
 do_syscall_64+0x30/0x40
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
RIP: 0033:0x7f671d2c0d49
RIP: 0033:0x7f671d2c0d49
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f671d1c1df8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RSP: 002b:00007f671d1c1df8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f671d2c0d49
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f671d2c0d49
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007f671d1c1e20 R08: 0000000000000000 R09: 0000000000000000
RBP: 00007f671d1c1e20 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd562f62de
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd562f62de
R13: 00007ffd562f62df R14: 0000000000000000 R15: 00007f671d1c2640
R13: 00007ffd562f62df R14: 0000000000000000 R15: 00007f671d1c2640
---[ end trace 74a81e537b634ec6 ]---
---[ end trace 74a81e537b634ec6 ]---


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE 

#include <endian.h>
#include <errno.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static void sleep_ms(uint64_t ms)
{
	usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
	struct timespec ts;
	if (clock_gettime(CLOCK_MONOTONIC, &ts))
	exit(1);
	return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
	pthread_t th;
	pthread_attr_t attr;
	pthread_attr_init(&attr);
	pthread_attr_setstacksize(&attr, 128 << 10);
	int i = 0;
	for (; i < 100; i++) {
		if (pthread_create(&th, &attr, fn, arg) == 0) {
			pthread_attr_destroy(&attr);
			return;
		}
		if (errno == EAGAIN) {
			usleep(50);
			continue;
		}
		break;
	}
	exit(1);
}

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len) *(type*)(addr) = htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

typedef struct {
	int state;
} event_t;

static void event_init(event_t* ev)
{
	ev->state = 0;
}

static void event_reset(event_t* ev)
{
	ev->state = 0;
}

static void event_set(event_t* ev)
{
	if (ev->state)
	exit(1);
	__atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
	syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
	while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
		syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
	return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
	uint64_t start = current_time_ms();
	uint64_t now = start;
	for (;;) {
		uint64_t remain = timeout - (now - start);
		struct timespec ts;
		ts.tv_sec = remain / 1000;
		ts.tv_nsec = (remain % 1000) * 1000 * 1000;
		syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
		if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
			return 1;
		now = current_time_ms();
		if (now - start > timeout)
			return 0;
	}
}

struct thread_t {
	int created, call;
	event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
	struct thread_t* th = (struct thread_t*)arg;
	for (;;) {
		event_wait(&th->ready);
		event_reset(&th->ready);
		execute_call(th->call);
		__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
		event_set(&th->done);
	}
	return 0;
}

static void loop(void)
{
	int i, call, thread;
	for (call = 0; call < 3; call++) {
		for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0])); thread++) {
			struct thread_t* th = &threads[thread];
			if (!th->created) {
				th->created = 1;
				event_init(&th->ready);
				event_init(&th->done);
				event_set(&th->done);
				thread_start(thr, th);
			}
			if (!event_isset(&th->done))
				continue;
			event_reset(&th->done);
			th->call = call;
			__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
			event_set(&th->ready);
			event_timedwait(&th->done, 50 + (call == 0 ? 500 : 0));
			break;
		}
	}
	for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
		sleep_ms(1);
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_call(int call)
{
		intptr_t res = 0;
	switch (call) {
	case 0:
*(uint32_t*)0x20000000 = 6;
*(uint32_t*)0x20000004 = 3;
*(uint64_t*)0x20000008 = 0x200000c0;
*(uint8_t*)0x200000c0 = 0x18;
STORE_BY_BITMASK(uint8_t, , 0x200000c1, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x200000c1, 0, 4, 4);
*(uint16_t*)0x200000c2 = 0;
*(uint32_t*)0x200000c4 = 0;
*(uint8_t*)0x200000c8 = 0;
*(uint8_t*)0x200000c9 = 0;
*(uint16_t*)0x200000ca = 0;
*(uint32_t*)0x200000cc = 0;
*(uint8_t*)0x200000d0 = 0x95;
*(uint8_t*)0x200000d1 = 0;
*(uint16_t*)0x200000d2 = 0;
*(uint32_t*)0x200000d4 = 0;
*(uint64_t*)0x20000010 = 0x20000100;
memcpy((void*)0x20000100, "syzkaller\000", 10);
*(uint32_t*)0x20000018 = 0;
*(uint32_t*)0x2000001c = 0;
*(uint64_t*)0x20000020 = 0;
*(uint32_t*)0x20000028 = 0;
*(uint32_t*)0x2000002c = 0;
memset((void*)0x20000030, 0, 16);
*(uint32_t*)0x20000040 = 0;
*(uint32_t*)0x20000044 = 0x1b;
*(uint32_t*)0x20000048 = -1;
*(uint32_t*)0x2000004c = 8;
*(uint64_t*)0x20000050 = 0;
*(uint32_t*)0x20000058 = 0;
*(uint32_t*)0x2000005c = 0x10;
*(uint64_t*)0x20000060 = 0;
*(uint32_t*)0x20000068 = 0;
*(uint32_t*)0x2000006c = 0;
*(uint32_t*)0x20000070 = 0;
*(uint32_t*)0x20000074 = 0;
*(uint64_t*)0x20000078 = 0;
		res = syscall(__NR_bpf, 5ul, 0x20000000ul, 0x80ul);
		if (res != -1)
				r[0] = res;
		break;
	case 1:
*(uint32_t*)0x20000280 = r[0];
*(uint32_t*)0x20000284 = 0;
*(uint32_t*)0x20000288 = 0;
*(uint32_t*)0x2000028c = 0;
*(uint64_t*)0x20000290 = 0;
*(uint64_t*)0x20000298 = 0;
*(uint32_t*)0x200002a0 = 0xffffff7f;
*(uint32_t*)0x200002a4 = 0;
*(uint32_t*)0x200002a8 = 0;
*(uint32_t*)0x200002ac = 0;
*(uint64_t*)0x200002b0 = 0;
*(uint64_t*)0x200002b8 = 0;
*(uint32_t*)0x200002c0 = 0;
*(uint32_t*)0x200002c4 = 0;
		syscall(__NR_bpf, 0xaul, 0x20000280ul, 0x48ul);
		break;
	case 2:
*(uint32_t*)0x200000c0 = 2;
*(uint32_t*)0x200000c4 = 0x80;
*(uint8_t*)0x200000c8 = 1;
*(uint8_t*)0x200000c9 = 0;
*(uint8_t*)0x200000ca = 0;
*(uint8_t*)0x200000cb = 0;
*(uint32_t*)0x200000cc = 0;
*(uint64_t*)0x200000d0 = 0;
*(uint64_t*)0x200000d8 = 0;
*(uint64_t*)0x200000e0 = 0;
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 0, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 1, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 2, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 3, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 4, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 5, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 6, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 7, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 8, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 9, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 10, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 11, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 12, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 13, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 14, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 15, 2);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 17, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 18, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 19, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 20, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 21, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 22, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 23, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 24, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 25, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 26, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 27, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 28, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 29, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 30, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 31, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 32, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 33, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 34, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 35, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 36, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 37, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000e8, 0, 38, 26);
*(uint32_t*)0x200000f0 = 0;
*(uint32_t*)0x200000f4 = 2;
*(uint64_t*)0x200000f8 = 0;
*(uint64_t*)0x20000100 = 0;
*(uint64_t*)0x20000108 = 0;
*(uint64_t*)0x20000110 = 4;
*(uint32_t*)0x20000118 = 0;
*(uint32_t*)0x2000011c = 0;
*(uint64_t*)0x20000120 = 0;
*(uint32_t*)0x20000128 = 0;
*(uint16_t*)0x2000012c = 0;
*(uint16_t*)0x2000012e = 0;
*(uint32_t*)0x20000130 = 0;
*(uint32_t*)0x20000134 = 0;
*(uint64_t*)0x20000138 = 0;
		syscall(__NR_perf_event_open, 0x200000c0ul, 0, 0ul, -1, 0ul);
		break;
	}

}
int main(void)
{
		syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
			loop();
	return 0;
}


The following adapted patch is proposed to fix the bug on the 5.10.y kernel:
[PATCH 5.10.y 1/1] bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)


