Return-Path: <bpf+bounces-12255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E191B7CA431
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91BEB20DA5
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD91CA8F;
	Mon, 16 Oct 2023 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410938482;
	Mon, 16 Oct 2023 09:32:14 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5497;
	Mon, 16 Oct 2023 02:32:13 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8AC352800A290;
	Mon, 16 Oct 2023 11:32:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7C3D82ED8B5; Mon, 16 Oct 2023 11:32:10 +0200 (CEST)
Date: Mon, 16 Oct 2023 11:32:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org, Ricky Wu <ricky_wu@realtek.com>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Message-ID: <20231016093210.GA22952@wunner.de>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016040132.23824-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 12:01:31PM +0800, Kai-Heng Feng wrote:
> When inserting an SD7.0 card to Realtek card reader, it can trigger PCI
> slot Link down and causes the following error:

Why does *inserting* a card cause a Link Down?


> [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   63.912118] BUG: unable to handle page fault for address: ffffb24d403e5010
[...]
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

This looks like pcr->remap_addr is accessed after it has been iounmap'ed
in rtsx_pci_remove() or before it has been iomap'ed in rtsx_pci_probe().

Is the card reader itself located below a hotplug port and unplugged here?
Or is this about the card being removed from the card reader?

Having full dmesg output and lspci -vvv output attached to a bugzilla
would help to understand what is going on.

Thanks,

Lukas

