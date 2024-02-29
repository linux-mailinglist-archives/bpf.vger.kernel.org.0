Return-Path: <bpf+bounces-23075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C086D2FC
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A84B22259
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81913C9E8;
	Thu, 29 Feb 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J//fa1EN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4257A140;
	Thu, 29 Feb 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234503; cv=none; b=drH1uaF3zNv/VhQE/4YVcrKHVBRDEURYNI/ZQ6R32ln/4UYqY0kCVv6haH7Rkkdu51voorTAj8mGWzaBXH4aP58fl53S1Edttv687Ne3u0+AY0mkbVQZtrzZWO6UeIarAILNnGhcn0Et3Tg18RwmBLgH8qiUbzG2GuTkLnLKpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234503; c=relaxed/simple;
	bh=GCWCeqhm4LZf/5l3dD8UzJw4yhk96djI2q+ZTnr4omM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XlzVBO5z3dvGCX4FwAPeyYeKfqs031tZf3zdAF+uFVXsrMqlZldkLASX/Bx8fVuy+UBn5BT4DHzRDOJOVkiqhgyTe6/KusVej67FamG1kcDFn52vlyvdTlw6dNsmSn0DPb+Fk4fRwuZIn4gGDiBtXaqintFIJu+qMThRCA67ubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J//fa1EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFF6C433F1;
	Thu, 29 Feb 2024 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709234503;
	bh=GCWCeqhm4LZf/5l3dD8UzJw4yhk96djI2q+ZTnr4omM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J//fa1ENXzUizJNH88cEPo1CGuloy2jsYmWq2XdCwen/umG6+yuHmdEsHxUlRv2zv
	 Eofd3Dg7icI4hG5kINpL+qeNXX2khLN6WcRm/BBQvdMlTyJj4GsmD0ovvnMVd0bNtD
	 DO1cx0/ZUte+iiw5YILsurewgvHQpkv8eLs3s0UcaoI3x95Hp9DOhPQCQ9UOp7Yp/b
	 eY/MFQFQFBLACYsmEszokCbNAUkuUogPRt35hFW7j3c7egCZ2Vh9o9hhZa2MoXlwCs
	 oGjIwYIzXjtXZVRXiiO1VaAH8PR909NB09aKEEAhPKWPzXwqvFDXfOR10qDpsVJu9W
	 uJn3DDhjHOJJg==
Date: Thu, 29 Feb 2024 13:21:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
Message-ID: <20240229192141.GA342851@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229062201.49500-1-kai.heng.feng@canonical.com>

[+to Rafael, can you comment on whether this is the right fix for the
=2Eremove() vs .runtime_idle() race?]

On Thu, Feb 29, 2024 at 02:22:00PM +0800, Kai-Heng Feng wrote:
> When inserting an SD7.0 card to Realtek card reader, the card reader
> unplugs itself and morph into a NVMe device. The slot Link down on hot
> unplugged can cause the following error:
>=20
> pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> BUG: unable to handle page fault for address: ffffb24d403e5010
> PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, =
BIOS P3.40 10/25/2018
> Workqueue: pm pm_runtime_work
> RIP: 0010:ioread32+0x2e/0x70
> Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 54 01 b8 ff f=
f ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b> 07 c3 cc cc=
 cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000000007f
> RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403e5010
> RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000000000000
> R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000000007f
> R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000000009003
> FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 00000000003706e0
> Call Trace:
>  <TASK>
>  ? show_regs+0x68/0x70
>  ? __die_body+0x20/0x70
>  ? __die+0x2b/0x40
>  ? page_fault_oops+0x160/0x480
>  ? search_bpf_extables+0x63/0x90
>  ? ioread32+0x2e/0x70
>  ? search_exception_tables+0x5f/0x70
>  ? kernelmode_fixup_or_oops+0xa2/0x120
>  ? __bad_area_nosemaphore+0x179/0x230
>  ? bad_area_nosemaphore+0x16/0x20
>  ? do_kern_addr_fault+0x8b/0xa0
>  ? exc_page_fault+0xe5/0x180
>  ? asm_exc_page_fault+0x27/0x30
>  ? ioread32+0x2e/0x70
>  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
>  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
>  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
>  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
>  ? __pfx_pci_pm_runtime_idle+0x10/0x10
>  pci_pm_runtime_idle+0x34/0x70
>  rpm_idle+0xc4/0x2b0
>  pm_runtime_work+0x93/0xc0
>  process_one_work+0x21a/0x430
>  worker_thread+0x4a/0x3c0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x106/0x140
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x29/0x50
>  </TASK>
> Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_sof_pci_intel_cn=
l snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_codec_generic snd_=
soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 soundwire_generic_=
allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof_intel_hda snd_=
sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core snd_soc_a=
cpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_compress ac97_b=
us snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd_intel_sdw_acpi=
 intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core x86_pkg_temp_t=
hermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel drm_buddy ttm =
mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_event cec crct10d=
if_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd rc_core =
cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cstate i2c_algo_bi=
t joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_timer sysfillrect =
input_leds snd ee1004 sysimgblt mei_me soundcore
>  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_codel msr parport=
_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_tables x_tables=
 autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul ahci e1000e i2c=
_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas video wmi

The module list is a big distraction and isn't relevant to this issue.

> CR2: ffffb24d403e5010
> ---[ end trace 0000000000000000 ]---
>=20
> This happens because scheduled pm_runtime_idle() is not cancelled.

I think it would be useful to include a little more background about
how we got here.  In particular, I think we got here because
=2Eruntime_idle() raced with .remove():

  - rtsx_pci_runtime_idle() did iowrite32(pcr->remap_addr + RTSX_HAIMR)
    in rtsx_pci_write_register() successfully

  - rtsx_pci_remove() iounmapped pcr->remap_addr

  - rtsx_pci_runtime_idle() did ioread32(pcr->remap_addr + RTSX_HAIMR)
    in rtsx_pci_write_register(), which faulted

The write and the read access the same register, but the write was
successful and we faulted on the *read* (see [1]), which means
rtsx_pci_runtime_idle() started execution first, and rtsx_pci_remove()
raced with it and happened to unmap pcr->remap_addr (see [2]) between
the write and the read.

It looks like this kind of race between .runtime_idle() and .remove()
could happen with any driver.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/misc/cardreader/rtsx_pcr.c?id=3Dv6.7#n164
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/misc/cardreader/rtsx_pcr.c?id=3Dv6.7#n1633

> So before releasing the device, stop all runtime power managements by
> using pm_runtime_barrier() to fix the issue.
>=20
> Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@realte=
k.com/
> Cc: Ricky Wu <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>   Move the change the device driver core.
> =20
> v2:
>   Cover more cases than just pciehp.
>=20
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 85152537dbf1..38c815e2b3a2 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1244,6 +1244,7 @@ static void __device_release_driver(struct device *=
dev, struct device *parent)
> =20
>  	drv =3D dev->driver;
>  	if (drv) {
> +		pm_runtime_barrier(dev);
>  		pm_runtime_get_sync(dev);
> =20
>  		while (device_links_busy(dev)) {
> --=20
> 2.34.1
>=20

