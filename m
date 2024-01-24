Return-Path: <bpf+bounces-20218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01883A7BC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EE51C20DB6
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F21B274;
	Wed, 24 Jan 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9CyT7/z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE792C684;
	Wed, 24 Jan 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095630; cv=none; b=JZJ2CiStkme3egp0naAN+aBSeLf9FIdYstvb7D95YzDgqsrfoMymdVVeWZKYPKdJF8F85hNKxjXJHi7GTsOdVOEEAMlGUas/Ce3RreMg60slGSU6D/ybvaWo/9xi8nPj/9A6a94Q9lTNX2l+BVhReeG1f+oLnsE4eGQb4jF5P8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095630; c=relaxed/simple;
	bh=alQWMBFXA1hw7IIWXSpJ6i4inmySS5LtlbuTmaNyvl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CiR4wt/Uch6WAgfDwe4Yhw66szMwDjBmP2OzxvZZGNnlw8V4XQMV7r11eBSKvIU5uWAPId00EnXrmdW/zUsIZjbF6QFKQA7ga1fsfuiepNDGVsGe8vZGQggG8eDYHJI6JgJaZlApmQSE05MyFH7Nfpr3XQPOT8mK7rLmda86BQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9CyT7/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A84C433C7;
	Wed, 24 Jan 2024 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706095630;
	bh=alQWMBFXA1hw7IIWXSpJ6i4inmySS5LtlbuTmaNyvl4=;
	h=From:Subject:Date:To:Cc:From;
	b=Y9CyT7/zJOgHijuFWNtRE5BK0H0gmMJs7J47B3RhKobd0Cdg95Ffr0gwjegsbTJo9
	 l5jFT2D0k8Wyf1dZoIrlgwJABziL/uMh7EqvOQiCy+6H9e0FbnL78Ek/1NQrXTTBFz
	 Yi+KDg63/QF6strX05Jg1NdW6DyP8VWGmY+t6rcCnEPltwieHTEDnB/ORgwltAMHQt
	 4rw7g0q9i+7z20mO68w9Ez+/gi8Fu2qEXqr+W8u7p4E6jUeBuUZJ0xAn0Zlv0I2WPD
	 x52l2BtjQTejwsCFKqIkqM15PYksEtxlrVS+kzYNrgUpw05Xu/ypl++kRvycDZC1ph
	 dnwJ8F4Z5hbfA==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 0/3] HID: bpf: couple of upstream fixes
Date: Wed, 24 Jan 2024 12:26:56 +0100
Message-Id: <20240124-b4-hid-bpf-fixes-v2-0-052520b1e5e6@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAD0sGUC/32NQQ6CMBBFr0Jm7Zh22lB1xT0MiwJTOtEAaQ3RE
 O5u5QAu3/95/2+QOQlnuFUbJF4lyzwVoFMFffTTyChDYSBFVmky2FmMMmC3BAzy5ox1TVd1CUx
 kLBRtSXwUxbq3haPk15w+x8Oqf+mfsVWjQu918L0z1jjXPDhN/DzPaYR23/cvIfSokbEAAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706095628; l=2390;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=alQWMBFXA1hw7IIWXSpJ6i4inmySS5LtlbuTmaNyvl4=;
 b=j5lHHgQgLoXVZiipVjKowReOGI8kG/sxaAYoHUCxIixkXKDGr6uZidECS+6mEjacbAFlkw3y8
 0leuu0JRJH5Bdo74vBNHfnY00B3a2snuwqLxHwVesgj3F0kFQKh3wI/
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Hi,

This is the v2 of this series of HID-BPF fixes.
I have forgotten to include a Fixes tag in the first patch
and got a review from Andrii on patch 2.

And this first patch made me realize that something was fishy
in the refcount of the hid devices. I was not crashing the system
even if I accessed the struct hid_device after hid_destroy_device()
was called, which was suspicious to say the least. So after some
debugging I found the culprit and realized that I had a pretty
nice memleak as soon as one HID-BPF program was attached to a HID
device.

The good thing though is that this ref count prevents a crash in
case a HID-BPF program attempts to access a removed HID device when
hid_bpf_allocate_context() has been called but not yet released.

Anyway, for reference, the cover letter of v1:

---

Hi,

these are a couple of fixes for hid-bpf. The first one should
probably go in ASAP, after the reviews, and the second one is nice
to have and doesn't hurt much.

Thanks Dan for finding out the issue with bpf_prog_get()

Cheers,
Benjamin

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:  <linux-input@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <bpf@vger.kernel.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---
Changes in v2:
- add Fixes tags
- handled Andrii review (use of __bpf_kfunc_start/end_defs())
- new patch to fetch ref counting of struct hid_device
- Link to v1: https://lore.kernel.org/r/20240123-b4-hid-bpf-fixes-v1-0-aa1fac734377@kernel.org

---
Benjamin Tissoires (3):
      HID: bpf: remove double fdget()
      HID: bpf: actually free hdev memory after attaching a HID-BPF program
      HID: bpf: use __bpf_kfunc instead of noinline

 drivers/hid/bpf/hid_bpf_dispatch.c  | 101 ++++++++++++++++++++++++++----------
 drivers/hid/bpf/hid_bpf_dispatch.h  |   4 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c |  39 +++++++-------
 include/linux/hid_bpf.h             |  11 ----
 4 files changed, 95 insertions(+), 60 deletions(-)
---
base-commit: fef018d8199661962b5fc0f0d1501caa54b2b533
change-id: 20240123-b4-hid-bpf-fixes-662908fe2234

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


