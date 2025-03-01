Return-Path: <bpf+bounces-52973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0BDA4AC10
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78333A1435
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50A1EDA0B;
	Sat,  1 Mar 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZJlecBM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816F1E0B66;
	Sat,  1 Mar 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839221; cv=none; b=n1ARHgxbOjz39FsHrkekHVtt7Nti5OeiiswJoYEKgcE/XXkGVRZE9HhaOPbBYV40PQhDOvWgk3QZHmXIKLZrZ7yOuh9fJCHyvG2Z6pvrVQFZRt9P43vOPvUQIiM3l8Biskpul32Rdr6wAKOiprcq/dIpFTJv17BUxSmZfYNKgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839221; c=relaxed/simple;
	bh=WDPrYaKj7s26kse115+qww0IFHKFhkIMhznNoEr7JrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mi+Jf01wRHJDwmF5JcGp3fNxkmLbfa7TAEq9MjpIDSpDMb5kjsrkRkFiZUr1enNIYrgzXRZWz3EJXmAO/b8MI6GkUTQ3hGRyj+iqC+v4TkRO68hglxFgIcbqUfg9iSSYA7OHB/+DCIFCFvfdpJ3buH74d8OwY/gRzIcwX1F56Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZJlecBM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2234e4b079cso57664785ad.1;
        Sat, 01 Mar 2025 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839219; x=1741444019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqxvpgZHoGiLr6YH8sD6RZa4e3r1mx+K51Pz7JFmQwA=;
        b=jZJlecBMPhcFdsyXTB/kS7QI6XQBhULerc10Oe6PdaOjsKgqZwuLklR0QHy8PgeIou
         SQ4CYs3XFcYg/hxMsDKwliQ75mUN7IK0okU1l5ajtrmqgcgSbFLpo9vPjHQCTIsCXRwh
         yUYQ+0BQ9V3LULMwNCRLm55+kdfydBX8sLqv1ms963PspEg6tlpLsO61/lKWhw5v5RYy
         uwRLrMP0hd7eTenhchMMzNvvfZlUVA4/IXiwFkRizNQCRUi4X0Wh1DTBlR5+gjneds1j
         DVA2DoVZ0tTHEY9QfiLzc1BLvlf3JwS1FNdaB6HF5OCuCa5KptZ03KZxKZueCCiyLusy
         vb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839219; x=1741444019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqxvpgZHoGiLr6YH8sD6RZa4e3r1mx+K51Pz7JFmQwA=;
        b=AicBfBSS2ANEdV7h/XhZoWi4e5fiTQ4G5UoDOkWzOxhlZv0AjaY56KFXbsZPnzGNdz
         hWEj2x+IAgN7s8fyf8yI60fe7oHqGraOVLweGN4Od6EgU0AnDK/36cI3y5TY5aYdtkzJ
         yK0OphMPwvS0oQWrEj1eji60/juIxB4a3I6+7FZnyoWZdfTsubWdyJeMR3AbNI/ihh6M
         4qZYjxYOrXsxNcC27Jikuzeo2gh+5JBY+dENL1tA58YSCeXVoaZvMQ7hm3vi8FBVtXJ1
         5xzR+hkUm8Rn7Bd5YfsuAUzjpSJI8D06jSUQu64KB4g7xOVssLWw09o6XTNvedSC2WWR
         5g4w==
X-Forwarded-Encrypted: i=1; AJvYcCU3N+2phYllVrFnPJMP0kLSRw3QdUHrqCpOUUcpPfwFALAWlTp89PLsvWKLMT06ej0Ly4QL+k5PlhfnqGpYdFU=@vger.kernel.org, AJvYcCUxP25ZilagEnNYRF1UrC5nWL8N7sBwX59Cr7thq9RzHRatqZF8pndjQ/TutIqpgcxoTAo=@vger.kernel.org, AJvYcCV+MKcJJF8wn+7N5dCW0sLKuVqK7/RKuTBIC384tEMwwNaJy208+a8HxjHDYsbyhX2J5wKXRau06AXMFVYw@vger.kernel.org, AJvYcCW8pnXEYKbWOGEOxfihCUqkbChnVoLAUUqcFcSGd0GpwMB/+U8ZdVIKX2HwMx9kjShHGBq2vjJw@vger.kernel.org, AJvYcCWH5YJghYh98R7C2DbKqSKX7x1QDtupPzIWpBp4YOqEP9H6OwkE9jcV8ibJQhO/MtH51uJGGW17WjTHpN+q@vger.kernel.org, AJvYcCWSgnt9CWgg1AfvKPAjaRNNs8jEiY5PjH3D/OgAcezPlfiBhu8VBReNsIGavMBmlMcfMY66jgbzYViQif4=@vger.kernel.org, AJvYcCXk+NHwgSATFOikPHxlvBuOxtv0TmJ6mZzHNMJO5KeH8KtJlxMCs2HU+4XVwrFOW1vjaaKxGbxVFF0/UN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv37HU4LDnSwM7jJEfR0bf73Kw1Nj54i0HjeGjQnMONIt6MBPG
	VI6uh4GJ+inLd8Z5/dOScQ/Zo76Kt8idQrqq0aK0/egGDqUtpr4b
X-Gm-Gg: ASbGncu+/2I74YihVQmPlRd006vLUQ1hs5amVAVhEtcOdyAFvqQujk4Q3XCjVFzPRFB
	W7bUm90Lzf0K7yUCOmtyJ15cjQhq16uXcyO/HA2Sd3+NypPmnt7OPm5CWjEZ2NXnbJNe09KMBou
	MNhx79jh6sTb2AjtNET7hsDHbn810sDjTrki11LE9dHQnpI5dRxW29UbevVyN9CIsJrVtLG27gg
	Z4PHWdQL8OyBx4TQ1pMztsQArC84GEJ2/k4hBZsUGudKuRKU3r3SuROiSDJ7sfMVyWZgD9aZjzv
	mTgbU+XClwxoviNX9ZoozX+6VsvZSDQQbLOkVjajQOV/WYvRh3kj+dIJf/Mxt5Vimr8csI7sUuQ
	=
X-Google-Smtp-Source: AGHT+IGwTX1zwhWAXU1AZVXFy1OzhL7kB0zYwA4xHDy3bfQBeELXGyOD8jSe52YiMtbVSQB6FlE4Fg==
X-Received: by 2002:a17:902:ce0d:b0:223:4b8d:32f7 with SMTP id d9443c01a7336-22368fa9062mr110269565ad.19.1740839219506;
        Sat, 01 Mar 2025 06:26:59 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:26:58 -0800 (PST)
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
	david.laight.linux@gmail.com,
	andrew.cooper3@citrix.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v2 10/18] net: ethernet: oa_tc6: Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:24:01 +0800
Message-Id: <20250301142409.2513835-11-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301142409.2513835-1-visitorckw@gmail.com>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
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


