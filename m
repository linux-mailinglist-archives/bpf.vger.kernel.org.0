Return-Path: <bpf+bounces-52977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20AA4AC23
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D821899168
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC21F03CD;
	Sat,  1 Mar 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QowTIWH2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529911E5018;
	Sat,  1 Mar 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839263; cv=none; b=DJNvGCbmdTEQ2oNssYRoZtq0DLlGHszefwxvsAb118mvUKeQz6zai9JNB5yf5UKeYe5p+gSbnh7v7WKH5xWdscShqJTtM/ZZldk15djgIz1Pe/yxfnwY06N5hij1Hmg90SNQD1KJwdVqwD83EXgrKRb2puFgLTlRsjenCE+zVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839263; c=relaxed/simple;
	bh=6rZCyADuBKXQMtzY8frtZm7r8BeFGku217x/vpm4MWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R73n9yVWVlZ983hQidGqJI6Nl9JGw+ks3oeUN61ux9GTu8CV+cDrjVg6nKACVE5yaKIdywV5QUGhW26gkskXbPhz5PmfQJhpiR+xapC7khosHBof24odSZe9lKHN2DBrqLATqIk+7esFnGbRztzFJOOQ6cAf1qUVa/HuHTbjcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QowTIWH2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239aa5da08so1672965ad.3;
        Sat, 01 Mar 2025 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839261; x=1741444061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCIStMwChzl4Z+E/b6UIovNeeE8MF3lkiK/lI/bZwfc=;
        b=QowTIWH27/KYzozdoUkPzsqiNS8QmQnL3QbWfPr3ZcpU7a3xt2Nn0/eHcze4sna64X
         Jh1JvIPtyv2tcuo6RUeDmx8d98h7uNfIqxeTESv4KMVwKaHnfLDCBT/hwMp2feu08+9R
         YTUj4JajsdLQlH7wJXl+Afsp1JiM/RT+DvuuQG5VORsZZfNd/CWJnIjFuSpKQ/ITkqQr
         29gN8yxVquVeq2aA53nRVIlfV0M1k5kzCUOMhS9Gue6Phc0H7l5nCsAT+Y8HuzVlfFyu
         hz9lps3VRtH8Vl/s8k33a+LlQQiB7GEME3+mnuDoEYnY5rCCfVQhycy+GO/yPVVNqxBx
         bk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839261; x=1741444061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCIStMwChzl4Z+E/b6UIovNeeE8MF3lkiK/lI/bZwfc=;
        b=gc2v5vzV5JpKJ0dYHToUClwr1PQCIIxCMYscirDLO0HBQfGmwZU+QRPgmOlcS621Lv
         0cx1aBF1j0S0u0inOmTYopZfJLuOg5hHk38Yj4TyOIViydZhQOTuqbh5R3WxM6VIKMFm
         gMS6SYgJLg4yeuPFMfBrxik5tjW+uwk+H4WovHv8TCmQMQXgAYCGXEty8p678NgUr8+Y
         +ZcDJS9tynxkWn+Sw0FdfIA/hf/6ZT5U4MqLD441a8iY9XmrGh2fTTMut3CkKLzLd2Kb
         u0WDVuO8Y3SgQu6KpcL6zVsWcjiNUb/DwTVPdxvHiGfXJ+hDhdvmg0+FCZNe6s/oD/tI
         3yXA==
X-Forwarded-Encrypted: i=1; AJvYcCUDOLE9/2wCf5tWlj06we6gZj79qvoQeO20DMt8JJ02Hn+Xqzddn1PogN8D5LH1O7j6AH7vQLjIneKudiea@vger.kernel.org, AJvYcCULs/MK6YTrbliTUi6kQWTVKZ5SGNWFsQCTrH8DBlGd34YJmldA/YqJ1d0ckNlnFxUk0Ey7G023@vger.kernel.org, AJvYcCUeWNP92bGQj7VGCzHN8nDMeTEXLZQBXQ5i3GOm1SjMfLWxRyZNZ3zJLRHYdCJn+27Wnbycuf19K0pR6uLnDqQ=@vger.kernel.org, AJvYcCVskVgMgUCbfHEVCxc5ei76aUvwOOJNGEEzcdn3wR9n+gpufx2LK3sq6InH/JfmgPhrY1ocJe+ST0q6CSc=@vger.kernel.org, AJvYcCWKeKpd7KI6erhJSnt+CvBACH9meTE0PRwsGAY97X/9YH9PqIojdi0YMI/Q1MN3ppoDyhm4eTSZWDhBK+o=@vger.kernel.org, AJvYcCXCZ9OQimG+9eUUDnvMe2dkjP4IvYJbr4pIJLgqZllcRPieBiossiFyhZjORuWgqEo/Bek=@vger.kernel.org, AJvYcCXRmB87RHh6Z6A6/u4as34LSk6oyz+QPJBmlCnluuUID9RY1YSu/7tDeDxKjztzRYtCoTW4daZJJL6y+nxt@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6yXUEKJ1h17vUz14Me2BnQDrEopTTk2nzBT4W4h0V7joHe7w
	xNectguts0R5X0VGhRmj/JhR85lWbJzbeNfQ0RC1w7+wMVCQ46YV
X-Gm-Gg: ASbGncvoAmfEM0xrU79EYaNA2KLIaAQJWYd/4R+/RVsUbABU4ERcaTCpl2GwKfSVMxl
	Yg19rug7YVzCraCqWf1e5WMLqyBZSmi+APYLgVCArCDPb27Rl3pkp7sTSde0UJecyjk3cglx8/R
	iZVhWrKqf+l30t1E4fBjBLGMOt3qEA3AP317Yboz217lz542WhcH5H8lqP9yc/fg8AiLT1sajDc
	YmKMFeVVjtvVvLA/8pU2FuSDe2G+RnOXq0MYH524DTp4/I19MTTiYb4spoZnAloGq6f9RPku2kk
	lx8KD97CjvMLdzVUKbGATOwPKK6W7YNTSxRqze6aWBVHxtCtpybHdmSDZ3U1bj1P+U4yKduRHrU
	=
X-Google-Smtp-Source: AGHT+IFiFnyov77ut9ZE0KvFExTJSaeHLpVxCuPiHzGuQy81Az6d7l02LfGDhYVm8qdT93KSy9qqzw==
X-Received: by 2002:a17:902:ce91:b0:223:64bb:f657 with SMTP id d9443c01a7336-2236922352bmr101615155ad.46.1740839261506;
        Sat, 01 Mar 2025 06:27:41 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:27:40 -0800 (PST)
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
Subject: [PATCH v2 14/18] fsi: i2cr: Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:24:05 +0800
Message-Id: <20250301142409.2513835-15-visitorckw@gmail.com>
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
 drivers/fsi/fsi-master-i2cr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e5..8212b99ab2f9 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) IBM Corporation 2023 */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/i2c.h>
@@ -38,14 +39,7 @@ static const u8 i2cr_cfam[] = {
 
 static bool i2cr_check_parity32(u32 v, bool parity)
 {
-	u32 i;
-
-	for (i = 0; i < 32; ++i) {
-		if (v & (1u << i))
-			parity = !parity;
-	}
-
-	return parity;
+	return parity ^ parity32(v);
 }
 
 static bool i2cr_check_parity64(u64 v)
-- 
2.34.1


