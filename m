Return-Path: <bpf+bounces-12397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7F7CC0A5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A7DB21119
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6A41752;
	Tue, 17 Oct 2023 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F34123D;
	Tue, 17 Oct 2023 10:26:16 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7D120;
	Tue, 17 Oct 2023 03:26:13 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39HAPeE724097804, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39HAPeE724097804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 18:25:40 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 17 Oct 2023 18:25:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Oct 2023 18:25:39 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Tue, 17 Oct 2023 18:25:39 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng
	<kai.heng.feng@canonical.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Tony Luck
	<tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe Link Down
Thread-Topic: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Thread-Index: AQHZ/+WX29Sx+yjN7keHtkFSV38Z/LBLoV4AgAIjnlA=
Date: Tue, 17 Oct 2023 10:25:39 +0000
Message-ID: <263982e90fc046cf977ecb8727003690@realtek.com>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de>
In-Reply-To: <20231016093210.GA22952@wunner.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, Oct 16, 2023 at 12:01:31PM +0800, Kai-Heng Feng wrote:
> > When inserting an SD7.0 card to Realtek card reader, it can trigger
> > PCI slot Link down and causes the following error:
>=20
> Why does *inserting* a card cause a Link Down?
>=20
>=20
> > [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   63.912118] BUG: unable to handle page fault for address:
> ffffb24d403e5010
> [...]
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
>=20
> This looks like pcr->remap_addr is accessed after it has been iounmap'ed =
in
> rtsx_pci_remove() or before it has been iomap'ed in rtsx_pci_probe().
>=20
> Is the card reader itself located below a hotplug port and unplugged here=
?

Yes it is card reader unplug itself, because sd7.0 card is not used rtsx_pc=
r, it use nvme driver=20

Ricky

> Or is this about the card being removed from the card reader?
>=20
> Having full dmesg output and lspci -vvv output attached to a bugzilla wou=
ld
> help to understand what is going on.
>=20
> Thanks,
>=20
> Lukas

