Return-Path: <bpf+bounces-45522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75EF9D6F7E
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED17616102E
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7151DD0E1;
	Sun, 24 Nov 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDqjouV1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40891D9A56;
	Sun, 24 Nov 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452689; cv=none; b=uXmj7GuYD6oFTQiu3CFZJQRCHEBhZzOQEnlT3/VqOHCloOipnbw69RFdxqnMJMFo0wJ6Cg0wiYO0QKMHIeZU/cC2iq0FIRUTTK/d7WAfuqFOqiHyYYvk8RqfKeFREnWzsM0CqQcA44cEMNMto03TWAjSC2DMwwMyi/DupPyAE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452689; c=relaxed/simple;
	bh=Xxv5gIz4KuTZ8A+S6NdUUAYDcH1uP5tA7L8XsLb29Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1Z01jRXNtiXJCD+Mm35Z8GjgzdRhhIEJwxRnZdjqOZumOPVv6chQyLYRZPLiveMSqeGGODEpP6JmbC8OQET6oDo+vpt6N+SURaPKwc5tzD2I5DQoeNkkXTN4yXsS6VLLKYb6aADghg+P0jj0P2olI2xQ9M38+Elk4YI3i+bYO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDqjouV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE001C4CECC;
	Sun, 24 Nov 2024 12:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452689;
	bh=Xxv5gIz4KuTZ8A+S6NdUUAYDcH1uP5tA7L8XsLb29Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDqjouV1rv0Pw72L9qhdqc9gJfZELNf0m/EC78UXXjazCF6YCtQTSm52FMI4rcuJA
	 LBhgT7Y7r7FS7yLgbHyqZoCdEb1jW2pbrtgY0bc0n2NR6SrlLzLEQ5Z+yCR8Blc453
	 V8XMIdonZYLJf/cbkUovTGZvTN1E4bFPeyP206Gmg6EouO1jshQdaFpDbRAb357+lO
	 5krVw3sGnu3s6cZzq12qF6GUxp5zCWeXzsO2TVhdUrlZnhv48tOjKDEE3cN3PUzuSm
	 CIzE76URsn+j02iPLZIEUI5oE7trg0w8xBVTt7hPXDBYKM+ytdqdVOqoRadBp04wTj
	 MGah8oKpylBqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 03/20] HID: add per device quirk to force bind to hid-generic
Date: Sun, 24 Nov 2024 07:50:33 -0500
Message-ID: <20241124125124.3339648-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125124.3339648-1-sashal@kernel.org>
References: <20241124125124.3339648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 3fcf098f4f569..df78171e76d45 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2649,9 +2649,10 @@ static bool hid_check_device_match(struct hid_device *hdev,
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
index 1533c9dcd3a67..dc19b29c12683 100644
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


