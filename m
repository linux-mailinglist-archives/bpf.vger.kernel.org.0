Return-Path: <bpf+bounces-12249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E8F7C9E18
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 06:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C4B20CC7
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 04:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCC7488;
	Mon, 16 Oct 2023 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LfIysylX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676091FA9;
	Mon, 16 Oct 2023 04:02:26 +0000 (UTC)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D93AD;
	Sun, 15 Oct 2023 21:02:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 43BAB3F0C6;
	Mon, 16 Oct 2023 04:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697428940;
	bh=vkafOmpdBRmco3tsD/n12uXh8EE6SvdVyF3TIx5/KiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=LfIysylXk+F/ROUKC4Q2wqhQ4OOd9ajiuEdPBqVJGauGHJvWmlqKOeZmm65H1SF/j
	 vIMAB7Gy1QXMiqXzVw9WUTS+6YYX1LUkUvfsuTgXYaH9e5NhbCvLfifOw9lgfpw5r5
	 GtRNW0QyiXlngsXfBskskWvZ7zPGr+ftxfSKO9l75QBT7NR5opLaTvYqAWwkgfo/uO
	 bAU+ks79D38JYUaLBLfePH5ruoU5teDcpLHvebA8pX6XvqmbBmZNda7bMVOUOYNiWe
	 AaDVs0IUhO/k2VBEh3qpNdn+8jXX16DE4hOb8ozay72KmpyBM7+4fVosGKGRlqWt+H
	 CC8dVJiH3EWOw==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe Link Down
Date: Mon, 16 Oct 2023 12:01:31 +0800
Message-Id: <20231016040132.23824-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When inserting an SD7.0 card to Realtek card reader, it can trigger PCI
slot Link down and causes the following error:
[   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
[   63.912118] BUG: unable to handle page fault for address: ffffb24d403e50=
10
[   63.912122] #PF: supervisor read access in kernel mode
[   63.912125] #PF: error_code(0x0000) - not-present page
[   63.912126] PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
[   63.912131] Oops: 0000 [#1] PREEMPT SMP PTI
[   63.912134] CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
[   63.912137] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/H370M Pro4, BIOS P3.40 10/25/2018
[   63.912138] Workqueue: pm pm_runtime_work
[   63.912144] RIP: 0010:ioread32+0x2e/0x70
[   63.912148] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 =
54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b=
> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
[   63.912150] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
[   63.912152] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 00000000000=
0007f
[   63.912153] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403=
e5010
[   63.912155] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 00000000000=
00000
[   63.912156] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 00000000000=
0007f
[   63.912158] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 00000000000=
09003
[   63.912159] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:=
0000000000000000
[   63.912161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.912162] CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 00000000003=
706e0
[   63.912164] Call Trace:
[   63.912165]  <TASK>
[   63.912167]  ? show_regs+0x68/0x70
[   63.912171]  ? __die_body+0x20/0x70
[   63.912173]  ? __die+0x2b/0x40
[   63.912175]  ? page_fault_oops+0x160/0x480
[   63.912177]  ? search_bpf_extables+0x63/0x90
[   63.912180]  ? ioread32+0x2e/0x70
[   63.912183]  ? search_exception_tables+0x5f/0x70
[   63.912186]  ? kernelmode_fixup_or_oops+0xa2/0x120
[   63.912189]  ? __bad_area_nosemaphore+0x179/0x230
[   63.912191]  ? bad_area_nosemaphore+0x16/0x20
[   63.912193]  ? do_kern_addr_fault+0x8b/0xa0
[   63.912195]  ? exc_page_fault+0xe5/0x180
[   63.912198]  ? asm_exc_page_fault+0x27/0x30
[   63.912203]  ? ioread32+0x2e/0x70
[   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
[   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
[   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
[   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
[   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
[   63.912246]  pci_pm_runtime_idle+0x34/0x70
[   63.912248]  rpm_idle+0xc4/0x2b0
[   63.912251]  pm_runtime_work+0x93/0xc0
[   63.912254]  process_one_work+0x21a/0x430
[   63.912258]  worker_thread+0x4a/0x3c0
[   63.912261]  ? __pfx_worker_thread+0x10/0x10
[   63.912263]  kthread+0x106/0x140
[   63.912266]  ? __pfx_kthread+0x10/0x10
[   63.912268]  ret_from_fork+0x29/0x50
[   63.912273]  </TASK>
[   63.912274] Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_sof=
_pci_intel_cnl snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_codec=
_generic snd_soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 sound=
wire_generic_allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof_i=
ntel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_c=
ore snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_co=
mpress ac97_bus snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd_i=
ntel_sdw_acpi intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core x=
86_pkg_temp_thermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel d=
rm_buddy ttm mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_even=
t cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_=
simd rc_core cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cstat=
e i2c_algo_bit joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_timer=
 sysfillrect input_leds snd ee1004 sysimgblt mei_me soundcore
[   63.912324]  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_code=
l msr parport_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_ta=
bles x_tables autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul ah=
ci e1000e i2c_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas vid=
eo wmi
[   63.912346] CR2: ffffb24d403e5010
[   63.912348] ---[ end trace 0000000000000000 ]---

This happens because scheduled pm_runtime_idle() is not cancelled.

So use pm_runtime_barrier() to ensure all devices on the bus stops
runtime power management actions.

Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@realtek.=
com/
Tested-by: Ricky Wu <ricky_wu@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_=
pci.c
index ad12515a4a12..9ae4fa95c8c1 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -18,9 +18,18 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "../pci.h"
 #include "pciehp.h"
=20
+int pci_dev_disconnect(struct pci_dev *pdev, void *unused)
+{
+	pm_runtime_barrier(&pdev->dev);
+	pci_dev_set_disconnected(pdev, NULL);
+
+	return 0;
+}
+
 /**
  * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
  * @ctrl: PCIe hotplug controller
@@ -98,7 +107,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, =
bool presence)
 		 __func__, pci_domain_nr(parent), parent->number);
=20
 	if (!presence)
-		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+		pci_walk_bus(parent, pci_dev_disconnect, NULL);
=20
 	pci_lock_rescan_remove();
=20
--=20
2.34.1


