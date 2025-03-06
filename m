Return-Path: <bpf+bounces-53474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12932A550E8
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DF83B3062
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B522576A;
	Thu,  6 Mar 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPujuuXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE38221F12;
	Thu,  6 Mar 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278389; cv=none; b=QiDcMZ2Tt8VAA/FRzwZ0b0FqUhm422gGyFL73H3R2eFxUZ4YDrOEe5YixvWR24fUNXoru9f5KlmBFr/lPIybW5TE+GPAm9urT3T1qNLbgFdKNheWJv+pEqSk/kKyMWzREod1upespzT6vB5IassLQgMqW4gByG6c3d0srW6r5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278389; c=relaxed/simple;
	bh=rTA+nqUh4NnBYzrIs97e5P2aMLuYYBuIh+2ppv71b2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5THudaDnCWAJBJC+rw7pSFtvpsn/IXI1HP4usz+IcCT/Z4/UyN4Ks00wOTOWr0RgZY0coTSXBRzby93eXKBwIHRAj7hjrwyvgN8jHAJS5tx8SrdPUI+Coyqn+Otl7c8qqRAv06aNKugwfXcWy3vj6FvoqHtlTTiDa3RXQdCGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPujuuXQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso1491476a91.1;
        Thu, 06 Mar 2025 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278387; x=1741883187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nutb7MJ9eZ82YUrFszN8Vow0UKyoKuoqD2og5G/xi8M=;
        b=hPujuuXQKMYzEJcsFdZxZvReMknAUcJ7HKgqifYK6VkhCt/Bv9Za8/t6Dsf/mNqmeP
         0838wqms/qO6iyh6JCO1t193vGazv+6zp6imSmMHSdI0kZXsj4yRvZv2ca50VFXxZEsB
         P/7DfjNXmdJJdSEC1it2RfEbFH1JlyvnNgOERQO38uWOqPgdJ2N/hyK7M1r2Cikur0M5
         Ng0BwIsYGTUWWxjAnRon1bEPoMt27Ioo/rVnbRdt8QBiKnq5CX9Xc9jf4hOSBVGJ30nn
         CseYmn3C/u+SwN6edWOjxphAtqYiD19N8FpznpZOosXLbRfVxw6hrNzgWe76u9ceszKk
         i9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278387; x=1741883187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nutb7MJ9eZ82YUrFszN8Vow0UKyoKuoqD2og5G/xi8M=;
        b=t1IUlgCFm4nkxFKS2k03XbQTMNkTA5b9WQNotXNapamRPzpUZ0Po2N4BhT6MSB5cHM
         gNmiluK6CpFEw4NpgOUq+3KvlDQ3XTrdh/ZHYbxlOm5x9UkpwmuzQ5999Jk7F3ydgJtU
         p7eZhnt2ez6C5V87BsC/FQzQ5JcPgvyz6tGljema4xTmuITL+BkJKGCi+XDGFEcBKWiP
         2429aOAnoha+OlG4RhhxQr1CFUh6G1ddIZABja3k3g4XRJzSKjEkfcasFC1aKl5/j6GX
         T8vSPRYhgT8GV/RxIKe7unBI8otRmD1btn0ML6G4Wc9K7uari63DhW1HoFpFBdF22Ko+
         CxUg==
X-Forwarded-Encrypted: i=1; AJvYcCURiUj+37islrzfumP27Cr90DrjhzeKzcFkqPGmiU3mJa31V5jjo5A0vb9qMuq2Gtq9oE0yYlaX@vger.kernel.org, AJvYcCW/8Foo91i4xqe+hmFggdqWCKWXbrut79nCffALZOBNVWC85ugm5Gl/uy+SCvARLL/uUQo=@vger.kernel.org, AJvYcCWTsI5v8qw6+H2RSR7TnmS9EFZL+xq7OzWQ9Wp4N/VwHcyxqtzKRR7oNiaZesSYxMeO2tF2TXnRZ98DuA0=@vger.kernel.org, AJvYcCWUUweWtO6NA2i7hzCIbI4ZkjvEMGE5W441JYW8mJQOun84t6CK43xEhdf7UuUqCuG8i0V5wl4ZktW8mum+4Og=@vger.kernel.org, AJvYcCX++bZesjBecAueszDZU+7gZyCncQRx1VnuJHTMIPCo8VhIfLd5lwERFWeDSRHVD7P71WQ7DNKCVwaAGiEd@vger.kernel.org, AJvYcCX7AUoR3ZL28zY08+S5g07Xs8E5x0P0hvOxK0cFQ3m4qHlBYFQqwS26MgIep2nhDVsuE7XPOdltGEwjs7I=@vger.kernel.org, AJvYcCXFXqcqRsgXSb0Wo0pSjabWaWrRz4iK+m2I3tTAbUmQHiBWB1EEYwvWpM8LIs3wVQQXR/mZmPxLxY/5VkqG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1VBwylzfxIEkm3IQY1XysiWxLPxFxXWg5KLWk7iOU9qD67G4
	//Ko+aYyPhaTb8zWt/JoO7OdLeULPWhoLLEbNr8uyiJrNjiN+hKG
X-Gm-Gg: ASbGnctmjg6VL6xLnUNTeET/vqQhsG8OV5nD9/KcPmzLymJcvY1QmmMA19eWXhDaQAU
	d8LEEDroCMjUPY3wxqq3k5O529u0XmgGVZwi9fq8TsEdnzFn1GIBv8FXPfSGWDbQ70mViL4CUgX
	rcNK/9HGEmMDtInS+oHh80lUxMOVHC/gc+w5Vmbt/OWlRpCJIe/4FMVSE7WuV+pnZki6KlfmtZK
	1a0+8QKg4hhUu2CLFv+AO1OSSlq0wHCWy7iI0r+2hoIQJF5ezt94g6gHFK80JmrO+6kRsk1xkDB
	W7+8hBWxROj+3iBMEDibOXTeGjfwEnI8mM11cR7Gmyd3XkPa9cYTP3PjN6GsPUzEw7K3nor0/as
	=
X-Google-Smtp-Source: AGHT+IGnAbA7Y19sbet7/e0FnFCoTVhlFvSe7Bxbq8+Kkwl3FpD5fIN6ErN6a+dRmXJdCrcvBmbfjw==
X-Received: by 2002:a17:90b:4c07:b0:2ff:6ac2:c5a6 with SMTP id 98e67ed59e1d1-2ff6ac2c770mr3503350a91.31.1741278386628;
        Thu, 06 Mar 2025 08:26:26 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:26:26 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jk@ozlabs.org,
	joel@jms.id.au,
	eajames@linux.ibm.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.torokhov@gmail.com,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	louis.peens@corigine.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	parthiban.veerasooran@microchip.com,
	arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	yury.norov@gmail.com,
	akpm@linux-foundation.org
Cc: hpa@zytor.com,
	alistair@popple.id.au,
	linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-serial@vger.kernel.org,
	bpf@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v3 03/16] media: media/test_drivers: Replace open-coded parity calculation with parity8()
Date: Fri,  7 Mar 2025 00:25:28 +0800
Message-Id: <20250306162541.2633025-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306162541.2633025-1-visitorckw@gmail.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
index 70a4024d461e..e0f4151bda18 100644
--- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
+++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
@@ -5,6 +5,7 @@
  * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
  */
 
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
@@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
 
 static u8 calc_parity(u8 val)
 {
-	unsigned i;
-	unsigned tot = 0;
-
-	for (i = 0; i < 7; i++)
-		tot += (val & (1 << i)) ? 1 : 0;
-	return val | ((tot & 1) ? 0 : 0x80);
+	return val | (parity8(val) ? 0 : 0x80);
 }
 
 static void vivid_vbi_gen_set_time_of_day(u8 *packet)
-- 
2.34.1


