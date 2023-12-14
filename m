Return-Path: <bpf+bounces-17865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A35E81383A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 18:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98182B21A38
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13F675A2;
	Thu, 14 Dec 2023 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApmZLNNP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499D65EB5;
	Thu, 14 Dec 2023 17:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8915EC433C7;
	Thu, 14 Dec 2023 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574184;
	bh=bwu2w4zW//jHMjIvWeXohjLIYznHWt798OK1QLHQP+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ApmZLNNPCWjt45Cil7/WhQKoCwSbzsvi+W1c94IM9h7LaLjgspNrA4/TR6wyhetnE
	 NJbG7FZmQSKfYb6swKJgX336iWnfWym7mgtpNkiC20NVCsmZIssdB36Y2mvKyC6adK
	 DaB/nskKji6OUqWtqRAzVlwSXAViL+YcT/f/x/JZ9lt6uJEJGmNxfmE4pna+KcP+BE
	 ZHcfY5qd3B0kj8AYbWLcDa3rLEBmUytLP8/KvA5tSgZ76hRXZ/wBkX3S8aVjEZx75T
	 bqMz3p+Y+p2eTbk02i/6RdSTLotxxvKOOV5IGfAkU4N5bgft7fCo/RkDXHtc2a/CpW
	 sv38fX7s2KGDg==
Date: Thu, 14 Dec 2023 11:16:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org, Ricky Wu <ricky_wu@realtek.com>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PCI: Prevent device from doing RPM when it's unplugged
Message-ID: <20231214171622.GA1023469@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231212043808.212754-1-kai.heng.feng@canonical.com>

[+cc Rafael, runtime PM expert :)]

On Tue, Dec 12, 2023 at 12:38:07PM +0800, Kai-Heng Feng wrote:
> When inserting an SD7.0 card to Realtek card reader, the card reader
> unplugs itself and morph into a NVMe device. The slot Link down on hot
> unplugged can cause the following error:

A page fault in a driver following a link down event sounds like
either a driver defect or a PCI core defect that could affect any
driver.  The rtsx power and ASPM management is very unusual, so I
don't feel super confident in it.

I guess the theory here is that while we're running
rtsx_pci_runtime_idle(), the link down event happens and we run
rtsx_pci_remove(), which unmaps the pcr->remap_addr page, and then
rtsx_pci_readl(RTSX_HAIMR) in the rtsx_pci_runtime_idle() path
references that unmapped page?

I looked through other drivers that use runtime PM.  The typical
pattern is:

  *_probe()
    pm_runtime_put
    pm_runtime_allow

  *_remove()
    pm_runtime_forbid
    pm_runtime_get

rtsx does the put/allow and forbid/get in the reverse order:

  rtsx_pci_probe()
    pm_runtime_allow
    pm_runtime_put

  rtsx_pci_remove()
    pm_runtime_get_sync
    pm_runtime_forbid
    iounmap(pcr->remap_addr)               # <-- unmap the page

  rtsx_pci_runtime_idle()
    ...
      ioread32(pcr->remap_addr + reg)      # <-- read from unmapped page

I don't know whether this is an issue, and isp_probe() and nhi_probe()
also use this reverse order, so maybe it's all fine.  But I do wonder
whether there's a reason to do it differently.

> [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   63.912118] BUG: unable to handle page fault for address: ffffb24d403e=
5010
> [   63.912122] #PF: supervisor read access in kernel mode
> [   63.912125] #PF: error_code(0x0000) - not-present page
> [   63.912126] PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PT=
E 0
> [   63.912131] Oops: 0000 [#1] PREEMPT SMP PTI
> [   63.912134] CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> [   63.912137] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./H370M Pro4, BIOS P3.40 10/25/2018
> [   63.912138] Workqueue: pm pm_runtime_work
> [   63.912144] RIP: 0010:ioread32+0x2e/0x70
> [   63.912148] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d=
9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <=
8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> [   63.912150] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> [   63.912152] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000=
000007f
> [   63.912153] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d4=
03e5010
> [   63.912155] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 000000000=
0000000
> [   63.912156] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000=
000007f
> [   63.912158] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 000000000=
0009003
> [   63.912159] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlG=
S:0000000000000000
> [   63.912161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   63.912162] CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 000000000=
03706e0
> [   63.912164] Call Trace:
> [   63.912165]  <TASK>
> [   63.912167]  ? show_regs+0x68/0x70
> [   63.912171]  ? __die_body+0x20/0x70
> [   63.912173]  ? __die+0x2b/0x40
> [   63.912175]  ? page_fault_oops+0x160/0x480
> [   63.912177]  ? search_bpf_extables+0x63/0x90
> [   63.912180]  ? ioread32+0x2e/0x70
> [   63.912183]  ? search_exception_tables+0x5f/0x70
> [   63.912186]  ? kernelmode_fixup_or_oops+0xa2/0x120
> [   63.912189]  ? __bad_area_nosemaphore+0x179/0x230
> [   63.912191]  ? bad_area_nosemaphore+0x16/0x20
> [   63.912193]  ? do_kern_addr_fault+0x8b/0xa0
> [   63.912195]  ? exc_page_fault+0xe5/0x180
> [   63.912198]  ? asm_exc_page_fault+0x27/0x30
> [   63.912203]  ? ioread32+0x2e/0x70
> [   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> [   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> [   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> [   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> [   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> [   63.912246]  pci_pm_runtime_idle+0x34/0x70
> [   63.912248]  rpm_idle+0xc4/0x2b0
> [   63.912251]  pm_runtime_work+0x93/0xc0
> [   63.912254]  process_one_work+0x21a/0x430
> [   63.912258]  worker_thread+0x4a/0x3c0
> [   63.912261]  ? __pfx_worker_thread+0x10/0x10
> [   63.912263]  kthread+0x106/0x140
> [   63.912266]  ? __pfx_kthread+0x10/0x10
> [   63.912268]  ret_from_fork+0x29/0x50
> [   63.912273]  </TASK>

Can you strip out the call trace stuff that's not relevant so the call
path is clear?  I'm guessing we're in ioread32(), and nothing above
do_kern_addr_fault() or below worker_thread() is relevant.

> [   63.912274] Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_s=
of_pci_intel_cnl snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_cod=
ec_generic snd_soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 sou=
ndwire_generic_allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof=
_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext=
_core snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_=
compress ac97_bus snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd=
_intel_sdw_acpi intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core=
 x86_pkg_temp_thermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel=
 drm_buddy ttm mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_ev=
ent cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypt=
o_simd rc_core cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cst=
ate i2c_algo_bit joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_tim=
er sysfillrect input_leds snd ee1004 sysimgblt mei_me soundcore
> [   63.912324]  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_co=
del msr parport_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_=
tables x_tables autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul =
ahci e1000e i2c_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas v=
ideo wmi

The module list doesn't look relevant here.  Nor the timestamps.

> [   63.912346] CR2: ffffb24d403e5010
> [   63.912348] ---[ end trace 0000000000000000 ]---
>=20
> This happens because scheduled pm_runtime_idle() is not cancelled.
>=20
> So before releasing the device, stop all runtime power managements by
> using pm_runtime_barrier() to fix the issue.
>
> Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@realte=
k.com/
> Tested-by: Ricky Wu <ricky_wu@realtek.com>
> ---
> v2:
>   Cover more cases than just pciehp.
> =20
>  drivers/pci/remove.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..c69b4ce5dbfd 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include "pci.h"
> =20
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -18,6 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>  	pci_pme_active(dev, false);
> =20
>  	if (pci_dev_is_added(dev)) {
> +		pm_runtime_barrier(&dev->dev);

If pm_runtime_barrier() is really the solution, it seems like this
should go somewhere in pci-driver.c where we call the driver PM
callbacks.

>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
> --=20
> 2.34.1
>=20

