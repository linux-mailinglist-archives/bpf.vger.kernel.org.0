Return-Path: <bpf+bounces-52278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8FA41022
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A1E176369
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6A1C8627;
	Sun, 23 Feb 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADZ7gxID"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C8131E2D;
	Sun, 23 Feb 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329083; cv=none; b=QMKR1f3dns8YWh67aCOoH7jTLD63FuLeoFRi36ZtgMvjsU0r9ALv6WGEMZf85QTmPsFyQ3s9Y+Y2oo+l1S+7JREbaoCw/ftMOQO+9BdKmObxYlXhhbIulqcvmV1vOR/RDGnPxzI0z+mAtS5cK2yzXu7axp/C5UhrEbrzJJMpkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329083; c=relaxed/simple;
	bh=WDPrYaKj7s26kse115+qww0IFHKFhkIMhznNoEr7JrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH68+igD1+43EbmOW+GL+FfWsjF5jU7a/zqRtm416Q3uHd2NLfdCcUEu8WjZ5ahIgtx9cQ4VHUUI7Y+eEwzLOdhRRAMX2V0N/RgDfDQZY022dPDJQ6j0cDQ7DkJ0LPPIx5SzydW35JPtRqPLs/YWXSiNnS1pkkn+Qi+qgis/b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADZ7gxID; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso104724335ad.0;
        Sun, 23 Feb 2025 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329082; x=1740933882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqxvpgZHoGiLr6YH8sD6RZa4e3r1mx+K51Pz7JFmQwA=;
        b=ADZ7gxIDL709u0YQSMQHvULAQ8Ucdzp0AT3lw5q6S60FTdYGoVIumGyrbroMSUIEh7
         qqVG9ugCVZkYnQr3XaRflEy6sLwpXPzjyA6xswL0ean/g4PGblZ5RuN9STLpo8Vm7KmY
         V+rEBkYn/4cUp98RS2OkCBDGvs0jYq5zVta2w6KtDKWJCwL6SWPGdkjWYkC9ufV5pFON
         FQC3LrK9O1mgBAmO+acQ9KcvIXH7OIffXNlJEaX49uL6M7YaUSxiFqCpoP2LCvjkf5Oo
         rk3S5yFqR6DfqsxmgMdWiixX2iZlbLCKaby7NHB8qbwigeGovmPLLS7AqsjFk1xLYs4L
         fqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329082; x=1740933882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqxvpgZHoGiLr6YH8sD6RZa4e3r1mx+K51Pz7JFmQwA=;
        b=RjWbFNGHXgqAGbx0Jd0+bmcHoBb/4YSqj3EIA4Xi86HDMM1N+Ez0hraCkB/mdwKW6T
         yIK00qpXIPqThO25puVpJeQVbr30t6L7X/Wu/nCv1dxv8Lwbh1avTIYOrzmlwJacD8T/
         ACsQ8c7KxVqAKtYde6x6QOZf/7Qfyea8grgcP1qrd38NunyNmxlPgMPnhNwqFdBWYZY/
         btVyB6/VqBeIW5DQ3Hr6/QXhdypbx4dW63FLB5pVpbTe/aWTmK44CemrykHn7p0ejFuB
         2DYTuCN/zXSgvxrre6QC5cSyClykimVRvplxjye5pU7rOPAVnF8TUW75l5o/KnOSWXQZ
         y3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUZnpCcrbtVCU6K17P3J6pvQeT7f3mQjKlPG6UbPbiVkifZ5XjBy88bgXoNQFMvxMzJWF6707rKwlmhLDsA@vger.kernel.org, AJvYcCUqNzaUaXrobg82XZ6Z6QZRXuo/ur6JeeBuYyiM+Jp12pX4HGMv2Hom5sjX/yqv4nvfzRSKnel1LtcOjI0x@vger.kernel.org, AJvYcCVX1r4X1YLRJE4Rl9XjBu7+HB4y7eQFZ9HZgXet6oXGvkJVUTs7Ja5cc1O5G6G0cbr1jqg=@vger.kernel.org, AJvYcCWRstbOcQmjUtR3OStu1LxylsBMtq3Y8OuYx4h8+vHcaRHrgV5teqPo4GLGQn3Yq2WgawytI7nvU/esXWUySsI=@vger.kernel.org, AJvYcCWVz5NRAyVfPXxrms71Ha7Hv1ZoF32UMyFEeWQwTsF+o4p8sh5bLlr36Rg9wKLANdx4nq8twJ3QfmdOW/s=@vger.kernel.org, AJvYcCWhlaZVZZSlXvgd2ZA0/5ep6lRFXHV4CS/Eh795sG0jX5nsBkdG2aUUd+zT5vnKUd7wKxlLmhco@vger.kernel.org, AJvYcCWktI3G0JIVlLBcm9DA793sngVWTGeobwPvuJ9cmNd1cdZMXOD5W0Tyy9Rj46+kOuLgyrn0MWvkAaCH3rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqcRTYRA2ibYL5iuVx3eEKygpFWpvZRbQZwDfUQtlTpOJBMAR
	uyXnAC1cr7VIZAaR4XzlIYPtkdzTfK6Uhz05pNmVbbeT49T0CC1g
X-Gm-Gg: ASbGncs8I//+CcjnqJ5R5msYctnDkgMd6qwKPHfAdtcY6/RsDiy+rzx32fSUOeu+KAX
	vpVmXDae2I3EwZ5UjR5Fk4f7twByZ4Zx6WCvFoTvFgTUc8Y1WyM6UYsNvVM6oRgAWlP/c8pFARD
	ZdrcrcUyQrucbrFTA4oJBfsDCPdEVZIuddy5v8ybXmMxSnlXIuZeOUpnNGlzxiXX6immwkgo8iB
	kf0a+b9M5J0Q3hj15aZvDp76yHdYBHOeYbdn1S2QKIoVOfJmDOPWX638JVF3kGpvvxx7bAXu20b
	ccvYuhT7w1Y+CxNNbHqmwbAk8gFBZ3RjECaqoNpxD3FOtEDOY8GQnrbt
X-Google-Smtp-Source: AGHT+IGsE1LtqpOiLzBH/xsJP0qffWffejZOaFdgJ8XT2KOaHV87U7eq24SL1hIn8uNFPIxHHHWZ4w==
X-Received: by 2002:a17:902:d54c:b0:220:e023:8fa6 with SMTP id d9443c01a7336-2219ffd8556mr169735225ad.50.1740329081702;
        Sun, 23 Feb 2025 08:44:41 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:44:41 -0800 (PST)
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
Subject: [PATCH 10/17] net: ethernet: oa_tc6: Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:10 +0800
Message-Id: <20250223164217.2139331-11-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223164217.2139331-1-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/net/ethernet/oa_tc6.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index db200e4ec284..f02dba7b89a1 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
@@ -177,19 +178,6 @@ static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
 	return spi_sync(tc6->spi, &msg);
 }
 
-static int oa_tc6_get_parity(u32 p)
-{
-	/* Public domain code snippet, lifted from
-	 * http://www-graphics.stanford.edu/~seander/bithacks.html
-	 */
-	p ^= p >> 1;
-	p ^= p >> 2;
-	p = (p & 0x11111111U) * 0x11111111U;
-
-	/* Odd parity is used here */
-	return !((p >> 28) & 1);
-}
-
 static __be32 oa_tc6_prepare_ctrl_header(u32 addr, u8 length,
 					 enum oa_tc6_register_op reg_op)
 {
@@ -202,7 +190,7 @@ static __be32 oa_tc6_prepare_ctrl_header(u32 addr, u8 length,
 		 FIELD_PREP(OA_TC6_CTRL_HEADER_ADDR, addr) |
 		 FIELD_PREP(OA_TC6_CTRL_HEADER_LENGTH, length - 1);
 	header |= FIELD_PREP(OA_TC6_CTRL_HEADER_PARITY,
-			     oa_tc6_get_parity(header));
+			     !parity32(header));
 
 	return cpu_to_be32(header);
 }
@@ -940,8 +928,7 @@ static __be32 oa_tc6_prepare_data_header(bool data_valid, bool start_valid,
 		     FIELD_PREP(OA_TC6_DATA_HEADER_END_BYTE_OFFSET,
 				end_byte_offset);
 
-	header |= FIELD_PREP(OA_TC6_DATA_HEADER_PARITY,
-			     oa_tc6_get_parity(header));
+	header |= FIELD_PREP(OA_TC6_DATA_HEADER_PARITY, !parity32(header));
 
 	return cpu_to_be32(header);
 }
-- 
2.34.1


