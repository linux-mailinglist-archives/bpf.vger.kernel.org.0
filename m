Return-Path: <bpf+bounces-49418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E9A187E7
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA0D169C11
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A751F8EE8;
	Tue, 21 Jan 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="SmUx8706"
X-Original-To: bpf@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCA1F8930;
	Tue, 21 Jan 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500133; cv=none; b=rfHbUaRf2EEC7I8w3uOPbWWBbMUf6Kni2hCqGYo87ZdowiWjubou34VAzEMCmXzhNx3ddl2DLuLCtFiiFPQ8Gv4cUDJJHMQetguE9H7cNXpLheDMEmostpDUuTQwI9Mhp98zKmp0gg0BbcXaEBmeNHcwl6MODk4JCD/Ng7IZCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500133; c=relaxed/simple;
	bh=S7iPPOulNe3UKpDamQIoMj9qwryjjy833P7v8T+tOVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jxt3CgFBZ8e198mcRy7v7IXFUAOgT2Sy84S5dsftZIur2AMXhlf8T3XW6c7tLGYfI0QljUkfVq3mnniLm72z5vozOkd1wOmYYVuUmcbzlcaqiLGgBxFRpYfzB8lsvX83oiGy+F3MRg4yM6JVuq1w4O2h5vqQQPLk6g9ZUmYRstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=SmUx8706; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e59556.dip0.t-ipconnect.de [217.229.149.86])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 1F7BF2FC0050;
	Tue, 21 Jan 2025 23:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1737500121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F/1eAlkVpsxUqtpQB5HD0pI7pNL1hL+20UQeVlx/hKY=;
	b=SmUx8706midt/mlP0vyB/8MigrXhZTVwOtXjhsPjLfQZS7p3hYMCuy9rZokxch4PDg8Vi0
	fRJpgY7ROkoor/pCOO+tG9oTU/3ZglD72S/d9aaxHhDcAyAMTIbDISSGoDnm4a8It/JPwW
	29675EPAAeIXCxR+vhb5t/rt6elUc1k=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	wse@tuxedocomputers.com,
	bentiss@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	jelle@vdwaa.nl,
	jikos@kernel.org,
	lee@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	onitake@gmail.com,
	pavel@ucw.cz,
	cs@tuxedo.de,
	platform-driver-x86@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 0/1] platform/x86/tuxedo: Add virtual LampArray for TUXEDO NB04 devices
Date: Tue, 21 Jan 2025 23:31:09 +0100
Message-ID: <20250121225510.751444-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
after some other work, picked this up again.
Only coding style changes vs v4.


I now got my feet a little wet with hid-bpf regarding something else, and
with that knowledge I would leave the long arrays in the beginning in the
kernel code for the time being:

sirius_16_ansii_kbl_mapping and sirius_16_iso_kbl_mapping are required
during initialization so they have to exist in the kernel code anyway.

report_descriptor will most likly not change even for future models and
afaik having report_descriptors in kernel drivers is not unheard of.

So the only things that could be meaningfully moved to a hid-bpf program
are the sirius_16_*_kbl_mapping_pos_* arrays. But for these is have to give
out some fallback value anyway for the case where a hid-bpf file is missing
or fails to load. So why not use real world values from my test device for
these values?

As soon as there is a future device that can use the same driver with just
these pos arrays different, then I would implement that change via a bpf
program instead of a change to the kernel driver.

Let me know if you too think this is a sensefull approach?


Another question: Would this patch need to wait for a userspace
implementation of lamp array before it can get accepted?


The folder structure and naming scheme with nb04 is im preparation for
other parts of tuxedo-drivers to be upstreamed. NB04 is one of the
board_vendor dmi strings on TUXEDO devices that aligns with which part of
tuxedo-drivers implements the features of that device. They are independent
of each other so I plan to put them in different subfolders to reflect
that.

Best regards,
Werner Sembach

Werner Sembach (1):
  platform/x86/tuxedo: Add virtual LampArray for TUXEDO NB04 devices

 MAINTAINERS                                   |   6 +
 drivers/platform/x86/Kconfig                  |   2 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/tuxedo/Kbuild            |   6 +
 drivers/platform/x86/tuxedo/Kconfig           |   6 +
 drivers/platform/x86/tuxedo/nb04/Kbuild       |   9 +
 drivers/platform/x86/tuxedo/nb04/Kconfig      |  14 +
 .../platform/x86/tuxedo/nb04/wmi_ab_init.c    | 103 +++
 .../platform/x86/tuxedo/nb04/wmi_ab_init.h    |  18 +
 .../x86/tuxedo/nb04/wmi_ab_virt_lamparray.c   | 772 ++++++++++++++++++
 .../x86/tuxedo/nb04/wmi_ab_virt_lamparray.h   |  18 +
 .../platform/x86/tuxedo/nb04/wmi_xx_util.c    |  97 +++
 .../platform/x86/tuxedo/nb04/wmi_xx_util.h    | 112 +++
 13 files changed, 1166 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb04/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nb04/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_init.c
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_init.h
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_virt_lamparray.c
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_virt_lamparray.h
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_xx_util.c
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_xx_util.h

-- 
2.43.0


