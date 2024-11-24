Return-Path: <bpf+bounces-45524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C336C9D7040
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3E3B33107
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72661DFD97;
	Sun, 24 Nov 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkAkrakP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161801DF995;
	Sun, 24 Nov 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452796; cv=none; b=isakSFDv93fh68a+05hwv0hR3KwLy0ojhHnG7sk/82kUALRvf6Qa93kp39sewRL9wrXRVIFXXv1cSw+MhIeQOWtGx2mWUfSx2zfQ7eZ9tBH85PTmSMy3fIxHxhdYUyEEjfBZqK+l4SXMPCtp9BFlRFzJgGgNcYzP+8OVJukzbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452796; c=relaxed/simple;
	bh=u+V4ZwMWattHbE2lijblnBZNyGlEbljdrTzGLrj4FCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElyqDXhH6LTYr2J1kt3RTSGiGj5kGlhrxK1MeTnyaD4UM8wruFQWaLAPt9tcu6hxcsnY6U+QYetjO/uZr2AX88/s54+TbxIwQ5sFWRBaAdxa5feXXum3+zw4mQpfFCvzbVYTbkKqAujr6K0R3PheOYIw9e2a46iNd3ngirE4Vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkAkrakP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BD6C4CECC;
	Sun, 24 Nov 2024 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452795;
	bh=u+V4ZwMWattHbE2lijblnBZNyGlEbljdrTzGLrj4FCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkAkrakPXYW6meXXhgSMKB602vi7wyScgZrGaqpfQMKg+CUWVKWeutE2z+/R9966P
	 RyN3uicgIGVTdmQB9gXUooMzOz2A/vLNuK+lu3Nr/CTYsXS1JBGLkPw/2KfHwyrNMN
	 3Mf/57q/mf6i1Hrd2r4h8r25Cn/eD4IcI9oWMwHK9+A63IfsC16LEHUkAl3vgwkAM5
	 Gsa6OrvTimkC6jA1yGNSQODxD57i/0p5ebvAFwtyt/H5TeVfjpdEYL4xipmSL5aQ22
	 QQZE/nm22u8IsEkdOjrxjbt/wqJMnj3rdeFktnZfStLkQ/zfgVtgc/tDTbKtA2lcq0
	 c5ughLpqs15xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/16] HID: add per device quirk to force bind to hid-generic
Date: Sun, 24 Nov 2024 07:52:20 -0500
Message-ID: <20241124125311.3340223-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125311.3340223-1-sashal@kernel.org>
References: <20241124125311.3340223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Benjamin Tissoires <bentiss@kernel.org>

[ Upstream commit 645c224ac5f6e0013931c342ea707b398d24d410 ]

We already have the possibility to force not binding to hid-generic and
rely on a dedicated driver, but we couldn't do the other way around.

This is useful for BPF programs where we are fixing the report descriptor
and the events, but want to avoid a specialized driver to come after BPF
which would unwind everything that is done there.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Link: https://patch.msgid.link/20241001-hid-bpf-hid-generic-v3-8-2ef1019468df@kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c    | 5 +++--
 drivers/hid/hid-generic.c | 3 +++
 include/linux/hid.h       | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1467c5a732db4..558f3988fb2cf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2607,9 +2607,10 @@ static bool hid_check_device_match(struct hid_device *hdev,
 	/*
 	 * hid-generic implements .match(), so we must be dealing with a
 	 * different HID driver here, and can simply check if
-	 * hid_ignore_special_drivers is set or not.
+	 * hid_ignore_special_drivers or HID_QUIRK_IGNORE_SPECIAL_DRIVER
+	 * are set or not.
 	 */
-	return !hid_ignore_special_drivers;
+	return !hid_ignore_special_drivers && !(hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER);
 }
 
 static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index f9db991d3c5a2..88882c1bfffe7 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -40,6 +40,9 @@ static bool hid_generic_match(struct hid_device *hdev,
 	if (ignore_special_driver)
 		return true;
 
+	if (hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER)
+		return true;
+
 	if (hdev->quirks & HID_QUIRK_HAVE_SPECIAL_DRIVER)
 		return false;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3b08a29572298..af55a25db91b0 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -359,6 +359,7 @@ struct hid_item {
  * | @HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP:
  * | @HID_QUIRK_HAVE_SPECIAL_DRIVER:
  * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
+ * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
  * | @HID_QUIRK_FULLSPEED_INTERVAL:
  * | @HID_QUIRK_NO_INIT_REPORTS:
  * | @HID_QUIRK_NO_IGNORE:
@@ -384,6 +385,7 @@ struct hid_item {
 #define HID_QUIRK_HAVE_SPECIAL_DRIVER		BIT(19)
 #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
 #define HID_QUIRK_NOINVERT			BIT(21)
+#define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)
-- 
2.43.0


