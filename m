Return-Path: <bpf+bounces-23076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53786D32E
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C88B21C76
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0113C9D8;
	Thu, 29 Feb 2024 19:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8EC12FB0B;
	Thu, 29 Feb 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234969; cv=none; b=erHn7tS2ZFt93cMmWEz90B2mkVUFgskC7Yl70RTvmZoKAh3GFStSbdxO4GALTU+5nPlDg795MVHabO7zhPuQD6NT0br4cEtPTNOLA0XqSLtlcbYHi9pVmPsnvRpgxGZTT/fia2HjjxnUeamzg3+FxbSV8cPzGQdoH+5Q9AkQYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234969; c=relaxed/simple;
	bh=ER8jFkTX8fHxUe0ER9VhE+YF/WbM+QuUTTWQrzqyZ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9h1kVawz2QcXXI1n6ppivHm/rPxRNnFfntxurXcJsbxUrbuA1Rplw20f1FAuOdhwStFPbmDNeKpvTAsr5libi5ClIgmmbbSF1Y+3QY/1QrF8oyY2gTYcC3860hIALIQrO5UJJEn6r12V0dtaNNb3Orjjbrb8SbUPD3wCamGuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e495e7d697so286041a34.1;
        Thu, 29 Feb 2024 11:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234966; x=1709839766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSo0N+coBNcRok/KrBy9V2vlVmSI+dcsaCeZh4GtHeQ=;
        b=DK9fsy326QKRN2WrozV7u3zxeg07LUac7Ph5cY/XoCeyJrd6TdAhKsfcF7OlgEiNNq
         5y/KdFusqVR0EtO2rf9Xhl2osGKc6nvpZEOFFCVXVBQe1CcC5ptsbrjZkNZo1QS3Da23
         6I59zmFMAcWSo0x1yEXnF28Y8lnvCNyi8H2dyTSx5AM0ocAuUU9NpwcMYp5riJNIAjME
         Dq5CGHPyGiLSi7RbVY2afMNUxlmhn2zhR9ItqJQ13XLJBlhnNo5wfgzDLOHEcDspO8we
         xw2Cqll4na+8dJ3+R09DUnVnnZ+jUxSEwOW6+OzakCxS323VGWYRnviwLXZIoLtoRs+7
         7ASg==
X-Forwarded-Encrypted: i=1; AJvYcCUNk396YZjm776DP3tpZFwoUDhIIFvwVpiMcIIqYwBL4xYdHhTC9KpmuG0duyJNxkm/aEttoSfr2q/VBmJS6F8xb9BXSllct+EfiKHcEuVvXxM1Ks7vQvwpjyomeHG3sWHn9uF6Yik7qC+SM98JOHOI1lA6XB7Hvsd1NunIP0fHirE5J3vFBPjDExql6ja1ZFdpxgo28DE3qzFKT/yg
X-Gm-Message-State: AOJu0YwsnoMGJ3fs3HUCKnn2TC4LXt151BE6Tlm7JzYav8rpdXMpRSsQ
	s5vrXY87zTzRvc3TOfWS8aWndK75aW/3rzyrM12ZVUDJbsW5aczQSqxtC54ElcjFbWNDWYenn4w
	mQMNP0KjDv90j21xeF8ZX7i/BRzg=
X-Google-Smtp-Source: AGHT+IEEzU4wkhZS54XDatEAIQZw9n2MvS0+AjIaHP6d+h7+WzJ6I8hgIA+9f8MJGlKVk+aVIzv0DN31yBoy7aXBXm0=
X-Received: by 2002:a4a:b902:0:b0:5a0:c62a:72b3 with SMTP id
 x2-20020a4ab902000000b005a0c62a72b3mr3040562ooo.0.1709234966026; Thu, 29 Feb
 2024 11:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229062201.49500-1-kai.heng.feng@canonical.com> <20240229192141.GA342851@bhelgaas>
In-Reply-To: <20240229192141.GA342851@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:29:14 +0100
Message-ID: <CAJZ5v0if-g-pPQEWdSq_vOXsp=rheSBzk-hnyOv5oJwGzMPxPw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 8:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+to Rafael, can you comment on whether this is the right fix for the
> .remove() vs .runtime_idle() race?]

It doesn't seem so.

pm_runtime_get_sync() is expected to cancel pending pm_runtime_idle()
in all cases, so this looks like PM-runtime core issue.

Let me have a look at it.

> On Thu, Feb 29, 2024 at 02:22:00PM +0800, Kai-Heng Feng wrote:
> > When inserting an SD7.0 card to Realtek card reader, the card reader
> > unplugs itself and morph into a NVMe device. The slot Link down on hot
> > unplugged can cause the following error:
> >
> > pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > BUG: unable to handle page fault for address: ffffb24d403e5010
> > PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4=
, BIOS P3.40 10/25/2018
> > Workqueue: pm pm_runtime_work
> > RIP: 0010:ioread32+0x2e/0x70
> > Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 54 01 b8 ff=
 ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b> 07 c3 cc =
cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
> > RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
> > RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000000007f
> > RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403e5010
> > RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000000000000
> > R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000000007f
> > R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000000009003
> > FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 00000000003706e0
> > Call Trace:
> >  <TASK>
> >  ? show_regs+0x68/0x70
> >  ? __die_body+0x20/0x70
> >  ? __die+0x2b/0x40
> >  ? page_fault_oops+0x160/0x480
> >  ? search_bpf_extables+0x63/0x90
> >  ? ioread32+0x2e/0x70
> >  ? search_exception_tables+0x5f/0x70
> >  ? kernelmode_fixup_or_oops+0xa2/0x120
> >  ? __bad_area_nosemaphore+0x179/0x230
> >  ? bad_area_nosemaphore+0x16/0x20
> >  ? do_kern_addr_fault+0x8b/0xa0
> >  ? exc_page_fault+0xe5/0x180
> >  ? asm_exc_page_fault+0x27/0x30
> >  ? ioread32+0x2e/0x70
> >  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> >  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> >  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> >  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> >  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> >  pci_pm_runtime_idle+0x34/0x70
> >  rpm_idle+0xc4/0x2b0
> >  pm_runtime_work+0x93/0xc0
> >  process_one_work+0x21a/0x430
> >  worker_thread+0x4a/0x3c0
> >  ? __pfx_worker_thread+0x10/0x10
> >  kthread+0x106/0x140
> >  ? __pfx_kthread+0x10/0x10
> >  ret_from_fork+0x29/0x50
> >  </TASK>
> > Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_sof_pci_intel_=
cnl snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_codec_generic sn=
d_soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 soundwire_generi=
c_allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof_intel_hda sn=
d_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core snd_soc=
_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_compress ac97=
_bus snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd_intel_sdw_ac=
pi intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core x86_pkg_temp=
_thermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel drm_buddy tt=
m mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_event cec crct1=
0dif_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd rc_cor=
e cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cstate i2c_algo_=
bit joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_timer sysfillrec=
t input_leds snd ee1004 sysimgblt mei_me soundcore
> >  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_codel msr parpo=
rt_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_tables x_tabl=
es autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul ahci e1000e i=
2c_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas video wmi
>
> The module list is a big distraction and isn't relevant to this issue.
>
> > CR2: ffffb24d403e5010
> > ---[ end trace 0000000000000000 ]---
> >
> > This happens because scheduled pm_runtime_idle() is not cancelled.
>
> I think it would be useful to include a little more background about
> how we got here.  In particular, I think we got here because
> .runtime_idle() raced with .remove():
>
>   - rtsx_pci_runtime_idle() did iowrite32(pcr->remap_addr + RTSX_HAIMR)
>     in rtsx_pci_write_register() successfully
>
>   - rtsx_pci_remove() iounmapped pcr->remap_addr
>
>   - rtsx_pci_runtime_idle() did ioread32(pcr->remap_addr + RTSX_HAIMR)
>     in rtsx_pci_write_register(), which faulted
>
> The write and the read access the same register, but the write was
> successful and we faulted on the *read* (see [1]), which means
> rtsx_pci_runtime_idle() started execution first, and rtsx_pci_remove()
> raced with it and happened to unmap pcr->remap_addr (see [2]) between
> the write and the read.
>
> It looks like this kind of race between .runtime_idle() and .remove()
> could happen with any driver.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/misc/cardreader/rtsx_pcr.c?id=3Dv6.7#n164
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/misc/cardreader/rtsx_pcr.c?id=3Dv6.7#n1633
>
> > So before releasing the device, stop all runtime power managements by
> > using pm_runtime_barrier() to fix the issue.
> >
> > Link: https://lore.kernel.org/all/2ce258f371234b1f8a1a470d5488d00e@real=
tek.com/
> > Cc: Ricky Wu <ricky_wu@realtek.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >   Move the change the device driver core.
> >
> > v2:
> >   Cover more cases than just pciehp.
> >
> >  drivers/base/dd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 85152537dbf1..38c815e2b3a2 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -1244,6 +1244,7 @@ static void __device_release_driver(struct device=
 *dev, struct device *parent)
> >
> >       drv =3D dev->driver;
> >       if (drv) {
> > +             pm_runtime_barrier(dev);
> >               pm_runtime_get_sync(dev);
> >
> >               while (device_links_busy(dev)) {
> > --
> > 2.34.1
> >

