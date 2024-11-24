Return-Path: <bpf+bounces-45520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7F9D6F45
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FB7280EA5
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B060C1D3566;
	Sun, 24 Nov 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+aX0PId"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1ED19D089;
	Sun, 24 Nov 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452568; cv=none; b=tsE1AX8nv4bH2deg3E8l/D8b3QZi5a06ok+upCB8mazdIboye3lXoi8mu06SFAhLxJw1OGtoI+UPePFrZqAv2n/CdeAw7jY8y1obtpfNCUKYnKCjHSREZ/fs2ppKWLLsxWZXPZsRSj5OJHX2Nt4dGe3SUpxhPAa2OVxkjPOBI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452568; c=relaxed/simple;
	bh=XyTJIgl/CdCWyIRGBODczdwowRviB1LScjxqhMcCsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVFduUZ/SWtHnLPSclcqAl1A+9juFTG/czPwrWjNmoe03p4hF2HMGA5aMoK49jC5tAHjgc+g0QsXTFGLFlZIiTbIK1z+i06bR6Zbt0wxgLmPas4xmQFHEZxocyYxLYC7CUufW4uoEn0CpGemgmeQciZB9T2V8ihv7gzOHS6wjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+aX0PId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF83C4CEDB;
	Sun, 24 Nov 2024 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452566;
	bh=XyTJIgl/CdCWyIRGBODczdwowRviB1LScjxqhMcCsng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+aX0PId57z9i4vyZXOqjvXY1A2YVlp/nwRAjDuv1aTxHl+pAzUzAUEwiV3jaLMtO
	 GGC/yCWssd2hVI/3T1Ej392Y72VT+PSBwWcctEDwK+fZYyuKuxf4HFJq1QRJITxnvV
	 PueRYxkJWtblJLXPpSpwPxtoiXZFk/WHuLo/Q3prUOVopU2jzXl4LtRm9r1V4IxLoU
	 oufWjdEGYVZfulRenQOvT+bsedz0PTZU6lJp2rq24NqzpSY+5jG6g2ohQ10gxRILCt
	 3lu35WmrByITktsZ2yhoW6QL7cfrpTNR4pofw40D3U5w0384HbgOtydo+4bP5yecn4
	 kKW5Po6/MpB0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/23] HID: add per device quirk to force bind to hid-generic
Date: Sun, 24 Nov 2024 07:48:15 -0500
Message-ID: <20241124124919.3338752-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124919.3338752-1-sashal@kernel.org>
References: <20241124124919.3338752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 582fd234eec78..935ccc38d1295 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2674,9 +2674,10 @@ static bool hid_check_device_match(struct hid_device *hdev,
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
index d2439399fb357..9e04c6d0fcc87 100644
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
index 121d5b8bc8675..a7d60a1c72a09 100644
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


