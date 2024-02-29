Return-Path: <bpf+bounces-22993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D8186C0A9
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A83283FAF
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 06:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D223D541;
	Thu, 29 Feb 2024 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Py5BOV+C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF93C482;
	Thu, 29 Feb 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188206; cv=none; b=fAVLJ0299qXp/0oc4zecb7hrsuYSDD9zjQ/HaOgckXXgdNcTh3DSxO9v+kGyWlYOzj+Go2/p9oiAyg8rqLDiNFzaJbE619bhEVl0OONYrLC5J8/6f5DhNXcSmEdQp2m2ztS4PYn3fBePVP/PwHxj4uMMxJZsyLvTBmiVZloBNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188206; c=relaxed/simple;
	bh=WVuqvTOEQ6pYEpNxVPfaI9ms3Fa4vc/Kgpc6dbIhRII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqyDUlQplu3DY/KcZJDCDiu/1H5Vbg/MeDttkXLK6lZDWHzGiBeIWHN2Al7iKosBZNjSe4tfQQxguKbh1811Sl3+RcY7+3dNjcxkcQSU9uHaCx0b0Wh45G9J6qtnR08TdEMC6dSW8mueFwrrfjx4sAlME5MFlAptw2jHOAijO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Py5BOV+C; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A73813F201;
	Thu, 29 Feb 2024 06:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709187772;
	bh=UHhKDh3X5z3R9YB/4OvFCQo1lCDQTCu4OguuN5U9shg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Py5BOV+Cq38XtZYzUo9GvgcmuwMisj8LnXjIDD/i5vu+/U4zcLKZpoOtcjTnZipRn
	 ZlieYODemFTDxUMBkRKsTnJnHLTQTTrphiAoQV9uRsJsrWob5s6IrUML326iJOX310
	 bsmO0FgYHDtlCVdHaEvZOy0Oqn7f29RNBCTnHMF0ahpPZkJKnSz/GV0+0ZgytzGjei
	 sMjZya6ufrcSB+dwanpo+DMs8+9US8DJ8OFGHEhKyMObkWNFEJjMLi14DmteL5mWeA
	 qAkrbB8wyAB5YWH8oUrDxGShDTQ1W6Vbzpo8MersXgQg5yDzk6m8fTsp7a/5C2hpVO
	 QHvgj+LP3rpOg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on device removal
Date: Thu, 29 Feb 2024 14:22:00 +0800
Message-Id: <20240229062201.49500-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When inserting an SD7.0 card to Realtek card reader, the card reader
unplugs itself and morph into a NVMe device. The slot Link down on hot
unplugged can cause the following error:

pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
BUG: unable to handle page fault for address: ffffb24d403e5010
PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, BI=
OS P3.40 10/25/2018
Workqueue: pm pm_runtime_work
RIP: 0010:ioread32+0x2e/0x70
Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 54 01 b8 ff ff =
ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b> 07 c3 cc cc c=
c cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000000007f
RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403e5010
RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000000000000
R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000000007f
R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000000009003
FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 00000000003706e0
Call Trace:
 <TASK>
 ? show_regs+0x68/0x70
 ? __die_body+0x20/0x70
 ? __die+0x2b/0x40
 ? page_fault_oops+0x160/0x480
 ? search_bpf_extables+0x63/0x90
 ? ioread32+0x2e/0x70
 ? search_exception_tables+0x5f/0x70
 ? kernelmode_fixup_or_oops+0xa2/0x120
 ? __bad_area_nosemaphore+0x179/0x230
 ? bad_area_nosemaphore+0x16/0x20
 ? do_kern_addr_fault+0x8b/0xa0
 ? exc_page_fault+0xe5/0x180
 ? asm_exc_page_fault+0x27/0x30
 ? ioread32+0x2e/0x70
 ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
 rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
 rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
 rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
 ? __pfx_pci_pm_runtime_idle+0x10/0x10
 pci_pm_runtime_idle+0x34/0x70
 rpm_idle+0xc4/0x2b0
 pm_runtime_work+0x93/0xc0
 process_one_work+0x21a/0x430
 worker_thread+0x4a/0x3c0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x106/0x140
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x29/0x50
 </TASK>
Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_sof_pci_intel_cnl =
snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_codec_generic snd_so=
c_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 soundwire_generic_al=
location soundwire_cadence snd_sof_intel_hda_mlink snd_sof_intel_hda snd_so=
f_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core snd_soc_acp=
i_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_compress ac97_bus=
 snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd_intel_sdw_acpi i=
ntel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core x86_pkg_temp_the=
rmal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel drm_buddy ttm me=
i_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_event cec crct10dif=
_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd rc_core cr=
yptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cstate i2c_algo_bit =
joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_timer sysfillrect in=
put_leds snd ee1004 sysimgblt mei_me soundcore
 mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_codel msr parport_p=
c ppdev lp ramoops drm parport reed_solomon efi_pstore ip_tables x_tables a=
utofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul ahci e1000e i2c_i=
801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas video wmi
CR2: ffffb24d403e5010
---[ end trace 0000000000000000 ]---

This happens because scheduled pm_runtime_idle() is not cancelled.

So before releasing the device, stop all runtime power managements by
using pm_runtime_barrier() to fix the issue.

Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@realtek.=
com/
Cc: Ricky Wu <ricky_wu@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
  Move the change the device driver core.
=20
v2:
  Cover more cases than just pciehp.

 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 85152537dbf1..38c815e2b3a2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1244,6 +1244,7 @@ static void __device_release_driver(struct device *de=
v, struct device *parent)
=20
 	drv =3D dev->driver;
 	if (drv) {
+		pm_runtime_barrier(dev);
 		pm_runtime_get_sync(dev);
=20
 		while (device_links_busy(dev)) {
--=20
2.34.1


