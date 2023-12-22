Return-Path: <bpf+bounces-18589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A981C3AC
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 04:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081591C23AE5
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 03:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2022023D0;
	Fri, 22 Dec 2023 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YBpyXSoK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A58185D
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 582313F45F
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703217221;
	bh=3n5HcK2uQmpAjUZ64ZVHzprx+T7M7J4g9fiVj26FvqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YBpyXSoKoSfnA9hU4A+p1UeiHHvIU+LLnrrOd8sa9d3e6sqjwN6njYqAVSlEXGJkD
	 9MsxDUfmAPDgnJG66F1yQISxO3wiCy+g4doQoK3ex8uuAN+9jb1fCbobGmyer+XnpC
	 SRBWSRLKrr3Q8C3RRtltfl+th7KBSa5JX8Ti/kpZchp5AjYUNC/2QV7ZRd5LAfapO6
	 eGefi5ZHqeC8cZJOj1Yc7wn7JRCi/JBWm9RF2u/97k6mPwMOCYPKMtWBMxoJUFFbxG
	 WyuPjWCETaY9ACKuxT472vpWL92BMAnMGQfWVSuzApGxmdyBHqhCoKrib+pSoO1dzb
	 tnCBInj46D2GQ==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-591129c72d6so1600186eaf.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217220; x=1703822020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n5HcK2uQmpAjUZ64ZVHzprx+T7M7J4g9fiVj26FvqE=;
        b=eI3lUX5Pg3PZyYV8Y6Db/HDJtcupE6BvLFPFf5kV/jaDdyWU6DwDaU0zvCUJhIbLPW
         MVWGyJznfROLzYy5WoiqD9X3ZY4OPb6SXX0hG6MHkX0IjemV/y5yAVfUashh6vGnkmDJ
         dAYD+Z173ps8oE6pQKIczXvN5zjrx1Dg+geQUKHBz+6E62CalK4Z+h1pApk/Js/txIhx
         3/ULmgogGU0/rB5YtqzUR2uhYU2VNG1owGwEoie105C/lu/khX/mmF8uR+thb6BPOOhR
         ZMjcSIfiQixM0kowhsHYErbbChFuARZxF5BkojRCCaQicsKshI6EEKMUIbSh64S+gR+v
         lKXw==
X-Gm-Message-State: AOJu0YwcLrK1J0aaaMt5IYYCpmEoeH0fboQYwfZ3dM5Nd/kG9z4O4HoF
	17yVZHyd292uaec1i3WAphT+URzUNXioXWPgM0lQD7j9WD7TNh/F0M+keJQE5nGOn3nPAxnCeFJ
	1txYrJwAGdOrYmUIHnU+i6L/4d1DzboDg4cvrJf2JiRTjEidE+RmN
X-Received: by 2002:a05:6358:c111:b0:170:6eb2:783 with SMTP id fh17-20020a056358c11100b001706eb20783mr734920rwb.28.1703217219957;
        Thu, 21 Dec 2023 19:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvqhDZRQUN/hg72OwgTMmGzTS46reHueZpGQDjyK0WgMSs1Y1WyTdHlq47S50amaqFLLeg1oCkBZXvrRIg0yg=
X-Received: by 2002:a05:6358:c111:b0:170:6eb2:783 with SMTP id
 fh17-20020a056358c11100b001706eb20783mr734909rwb.28.1703217219558; Thu, 21
 Dec 2023 19:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212043808.212754-1-kai.heng.feng@canonical.com> <20231214171622.GA1023469@bhelgaas>
In-Reply-To: <20231214171622.GA1023469@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 22 Dec 2023 11:53:27 +0800
Message-ID: <CAAd53p7Y+YMBuAx5f=mFxtQw+TUryLD6iqQYXpfe70L2mu_mLg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Prevent device from doing RPM when it's unplugged
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Dec 15, 2023 at 1:16=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Rafael, runtime PM expert :)]
>
> On Tue, Dec 12, 2023 at 12:38:07PM +0800, Kai-Heng Feng wrote:
> > When inserting an SD7.0 card to Realtek card reader, the card reader
> > unplugs itself and morph into a NVMe device. The slot Link down on hot
> > unplugged can cause the following error:
>
> A page fault in a driver following a link down event sounds like
> either a driver defect or a PCI core defect that could affect any
> driver.  The rtsx power and ASPM management is very unusual, so I
> don't feel super confident in it.
>
> I guess the theory here is that while we're running
> rtsx_pci_runtime_idle(), the link down event happens and we run
> rtsx_pci_remove(), which unmaps the pcr->remap_addr page, and then
> rtsx_pci_readl(RTSX_HAIMR) in the rtsx_pci_runtime_idle() path
> references that unmapped page?
>
> I looked through other drivers that use runtime PM.  The typical
> pattern is:
>
>   *_probe()
>     pm_runtime_put
>     pm_runtime_allow
>
>   *_remove()
>     pm_runtime_forbid
>     pm_runtime_get
>
> rtsx does the put/allow and forbid/get in the reverse order:
>
>   rtsx_pci_probe()
>     pm_runtime_allow
>     pm_runtime_put
>
>   rtsx_pci_remove()
>     pm_runtime_get_sync
>     pm_runtime_forbid
>     iounmap(pcr->remap_addr)               # <-- unmap the page
>
>   rtsx_pci_runtime_idle()
>     ...
>       ioread32(pcr->remap_addr + reg)      # <-- read from unmapped page
>
> I don't know whether this is an issue, and isp_probe() and nhi_probe()
> also use this reverse order, so maybe it's all fine.  But I do wonder
> whether there's a reason to do it differently.
>
> > [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   63.912118] BUG: unable to handle page fault for address: ffffb24d40=
3e5010
> > [   63.912122] #PF: supervisor read access in kernel mode
> > [   63.912125] #PF: error_code(0x0000) - not-present page
> > [   63.912126] PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 =
PTE 0
> > [   63.912131] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   63.912134] CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > [   63.912137] Hardware name: To Be Filled By O.E.M. To Be Filled By O.=
E.M./H370M Pro4, BIOS P3.40 10/25/2018
> > [   63.912138] Workqueue: pm pm_runtime_work
> > [   63.912144] RIP: 0010:ioread32+0x2e/0x70
> > [   63.912148] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08=
 d9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc=
 <8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> > [   63.912150] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> > [   63.912152] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 0000000=
00000007f
> > [   63.912153] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24=
d403e5010
> > [   63.912155] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000=
000000000
> > [   63.912156] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 0000000=
00000007f
> > [   63.912158] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000=
000009003
> > [   63.912159] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) kn=
lGS:0000000000000000
> > [   63.912161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   63.912162] CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 0000000=
0003706e0
> > [   63.912164] Call Trace:
> > [   63.912165]  <TASK>
> > [   63.912167]  ? show_regs+0x68/0x70
> > [   63.912171]  ? __die_body+0x20/0x70
> > [   63.912173]  ? __die+0x2b/0x40
> > [   63.912175]  ? page_fault_oops+0x160/0x480
> > [   63.912177]  ? search_bpf_extables+0x63/0x90
> > [   63.912180]  ? ioread32+0x2e/0x70
> > [   63.912183]  ? search_exception_tables+0x5f/0x70
> > [   63.912186]  ? kernelmode_fixup_or_oops+0xa2/0x120
> > [   63.912189]  ? __bad_area_nosemaphore+0x179/0x230
> > [   63.912191]  ? bad_area_nosemaphore+0x16/0x20
> > [   63.912193]  ? do_kern_addr_fault+0x8b/0xa0
> > [   63.912195]  ? exc_page_fault+0xe5/0x180
> > [   63.912198]  ? asm_exc_page_fault+0x27/0x30
> > [   63.912203]  ? ioread32+0x2e/0x70
> > [   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> > [   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> > [   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> > [   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> > [   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> > [   63.912246]  pci_pm_runtime_idle+0x34/0x70
> > [   63.912248]  rpm_idle+0xc4/0x2b0
> > [   63.912251]  pm_runtime_work+0x93/0xc0
> > [   63.912254]  process_one_work+0x21a/0x430
> > [   63.912258]  worker_thread+0x4a/0x3c0
> > [   63.912261]  ? __pfx_worker_thread+0x10/0x10
> > [   63.912263]  kthread+0x106/0x140
> > [   63.912266]  ? __pfx_kthread+0x10/0x10
> > [   63.912268]  ret_from_fork+0x29/0x50
> > [   63.912273]  </TASK>
>
> Can you strip out the call trace stuff that's not relevant so the call
> path is clear?  I'm guessing we're in ioread32(), and nothing above
> do_kern_addr_fault() or below worker_thread() is relevant.

Sure.

>
> > [   63.912274] Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd=
_sof_pci_intel_cnl snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_c=
odec_generic snd_soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 s=
oundwire_generic_allocation soundwire_cadence snd_sof_intel_hda_mlink snd_s=
of_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_e=
xt_core snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core sn=
d_compress ac97_bus snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg s=
nd_intel_sdw_acpi intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_co=
re x86_pkg_temp_thermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_int=
el drm_buddy ttm mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_=
event cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel cry=
pto_simd rc_core cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_c=
state i2c_algo_bit joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_t=
imer sysfillrect input_leds snd ee1004 sysimgblt mei_me soundcore
> > [   63.912324]  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_=
codel msr parport_pc ppdev lp ramoops drm parport reed_solomon efi_pstore i=
p_tables x_tables autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmu=
l ahci e1000e i2c_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas=
 video wmi
>
> The module list doesn't look relevant here.  Nor the timestamps.
>
> > [   63.912346] CR2: ffffb24d403e5010
> > [   63.912348] ---[ end trace 0000000000000000 ]---
> >
> > This happens because scheduled pm_runtime_idle() is not cancelled.
> >
> > So before releasing the device, stop all runtime power managements by
> > using pm_runtime_barrier() to fix the issue.
> >
> > Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@real=
tek.com/
> > Tested-by: Ricky Wu <ricky_wu@realtek.com>
> > ---
> > v2:
> >   Cover more cases than just pciehp.
> >
> >  drivers/pci/remove.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index d749ea8250d6..c69b4ce5dbfd 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/pci.h>
> >  #include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> >  #include "pci.h"
> >
> >  static void pci_free_resources(struct pci_dev *dev)
> > @@ -18,6 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
> >       pci_pme_active(dev, false);
> >
> >       if (pci_dev_is_added(dev)) {
> > +             pm_runtime_barrier(&dev->dev);
>
> If pm_runtime_barrier() is really the solution, it seems like this
> should go somewhere in pci-driver.c where we call the driver PM
> callbacks.

What makes pm_runtime_barrier() work is because it calls
'cancel_work_sync(&dev->power.work);' to cancel the pm_runtime_idle()
work, while pm_runtime_forbid() doesn't.
So should pm_runtime_forbid() also use cancel_work_sync()?

Kai-Heng

>
> >               device_release_driver(&dev->dev);
> >               pci_proc_detach_device(dev);
> > --
> > 2.34.1
> >

