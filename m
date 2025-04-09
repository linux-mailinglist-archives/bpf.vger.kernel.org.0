Return-Path: <bpf+bounces-55544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1934A82B62
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4113E1BA2C21
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC26276047;
	Wed,  9 Apr 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDv9E7Pu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910F1C5F23;
	Wed,  9 Apr 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213568; cv=none; b=HUDADSkK7qjQdLP7DnmfpVPIqIJttvdTRxaLFe6p9pt8EtrncNuFXtgHAyd/sTIouQMNpcBmHDWWe2AEdhdGapHmKEF0inVLGgTVKYhBlCvCUFUQsbZ7LBLc47AJwusbxeiZGnJ+cUU9LgU8d9PsQ6J3ETvllsHtussabdmG+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213568; c=relaxed/simple;
	bh=D6aTyRfVYrEdl/DsEoiOfCh6E66jdqjJl29yHOL9VgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdrU3JUuEx+jHe+Xh3Y4sxvWTPbEFPAvyFSQBInkWUJE6O3x/tmthAhFTEUzvYYs4cLJWKavAMKCf1zZMKUw17mZ/0BnLAGKA5FOusUVYE43a4LUpQGzRvHcKPZCx5CYZAvN8u7WP9VWku03KMxErGW4+njeOkJWq6lX8xMth2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDv9E7Pu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af93cd64ef3so4766933a12.2;
        Wed, 09 Apr 2025 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213566; x=1744818366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXLi2SRJHleL6i4thZNOgy64MnVVDpLvymelzP4O5VU=;
        b=bDv9E7PuxvXT6/dsXmq1QPzuWk5qwvyqVLFjfL9bfeNNe7eo5Rp4ofeOScB7PMIgKl
         3EXVJfHWfDGMgdAW+voPFuqaB4l9SdhlmLuLaV5Ce6bq1QoeXb/F0J8RBSqimup3zVFK
         dJsDmRMIleoN63U0Q96ib3BHYt7L2WVQGn3xeFFz1kng54LVkg8FQQOY3Mh2SSMUc3x+
         xXqjsdeeQunzodZzIGCgCU1sDLNQO5s9m5621b7FynqSh/KVUvzwfBCmdndx29lU/FTl
         GgjFldXKo5ibCqbFIGKbEUFMe0IiJdbgr8zBVV0zHpp7gwqjlsi+eJBC/XgnpdhxC1B4
         3FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213566; x=1744818366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXLi2SRJHleL6i4thZNOgy64MnVVDpLvymelzP4O5VU=;
        b=MowtzzzkRq7gvsgblEs5gs7BSy4OwyWmxLV4SF+GjgIlFBH/2WvRF3dhYpbL4K4dKl
         ipiXl0erCcy/ZzvmMwlY4aZXjRyoSQAUKEUWSmOUBDs/UU14x3WDCylD8w21ocJ5pocn
         9r/RnZQMKNF816fkN1gfpkdeVlgTEWr/D6nTFrr0s8YDi1MRKsaRzUN0hfd8ttEuY/+S
         y1bDlvyw/OYWV8Hnxn1VqTH5ziRzFil5LES81KwJanNSYtUaf2yzF8C9BzzgIj3nAxAk
         Atsx49RJQQ54XbGoKvViWJh/zV7lmY0Lt3yKANysKKsBE8GJoTLsxhmG8R6oi0yqnjJE
         gK4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+oTD+UWLQ7bcbpMR98jlmPsPbnUmm1+FusdxEkRJrtflzZt0sMysezXH0La0yZT/AXjB6CILRHA6WfOo=@vger.kernel.org, AJvYcCWJZcnpVfDLu3MMTvMeJ6cEUZHN52ljAueEBnu7pYA90KuEr4rC2ImVipuD16rq2BLCONH+jogskWKmduzZ32k=@vger.kernel.org, AJvYcCWS1ip4JqIxXv/Cw47jks3YPPw267/2N8M9f8qXT8lGHrJre2HA6GlywZFfDBYbkS6lPdBoiTC3h/kxdIao@vger.kernel.org, AJvYcCWVacpAEVyhEUCTW0/Mo899XplJOEVAfKmfynFVqkwrC/WiynJ4sB0qcwVi0WSweeaugiwOWEajJmKTUEU=@vger.kernel.org, AJvYcCWVg3owHDZdtADMz9Rxb3uTFysagV8fs80IN7RnEDK9P1TyDZcoNAx6ogOAsl5XW7hoeLQ=@vger.kernel.org, AJvYcCX9psm/s8VPqLhGmsN6XZ8t2tRbSr8iDofBuN9uRef7G3u6lRoj4h54MQTw1g3ER6BtPcSxNKNKbLRGMdYM@vger.kernel.org, AJvYcCXNtF9F2BmIxc5E/QZF2fscNojEq8drGz9pAC4vip8Pfzqdz558CzBcOAuXX6javmDOiDyMmqOz9FNQTEc=@vger.kernel.org, AJvYcCXjkb7gz0cD4GNiFi0tIrvHITWZgUz6YKoTJZIeoHNy9zvQuNoYJb/Ly3tt+dlB/KUeD6/iMg/s@vger.kernel.org
X-Gm-Message-State: AOJu0YyvN50yDWHoSia7hWLyuEM3dtwjSJ2g5jsMMRkJDR0eQjqRXP+C
	doL73a6AjilcUYqKeski6TI/dvIgPkiOTwVqgfbGD8f7LXYnShHN
X-Gm-Gg: ASbGnct3uXE//gY84ylElNIu2yy70iXQmP0u1LMEvDKrnZsoUL/boTzj9zBP8uOZ8qb
	f5oxK7OVRHksHrJIOMXoT4EY037wsNLT4ievI6KI2bC3f3RlWINqwjZp3dC5DcBqWVsK/caRAiX
	AE4HU6okM4iIVP7OmuNVk7BpIGUTvv254dP1sm8K+vAtjazuB/LjCgQ2H5nD0XSxW4E9kFAlFmN
	NtxlGSq26fnzw02FtJcuYquRMP+SHKz6CK2cEMlk4p8drkMu/GV44akU08mv2YZ+onSZQQkZZST
	xGic4Jm1D4LaTRUNgn3clzUdpnyMHz7NIkT/7hz1zFRNKdD/dtAU8zhnvSBKU8NPKw3/aMA=
X-Google-Smtp-Source: AGHT+IGweN+KZRMZ3CYcrqcq5iC29qaxOJUe/Q8yFuoByE0YY1D6tXNucvOC/QvWbivmYcNL8OhrUw==
X-Received: by 2002:a17:90b:584b:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-306dd52eaadmr4119633a91.20.1744213565972;
        Wed, 09 Apr 2025 08:46:05 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:46:05 -0700 (PDT)
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
	akpm@linux-foundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	alexandre.belloni@bootlin.com,
	pgaj@cadence.com
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
	Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com,
	andrew.cooper3@citrix.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v4 08/13] net: ethernet: oa_tc6: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:51 +0800
Message-Id: <20250409154356.423512-9-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409154356.423512-1-visitorckw@gmail.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity_odd() helper.
This change eliminates redundant implementations.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/net/ethernet/oa_tc6.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index db200e4ec284..6734b49357e7 100644
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
+			     !parity_odd(header));
 
 	return cpu_to_be32(header);
 }
@@ -940,8 +928,7 @@ static __be32 oa_tc6_prepare_data_header(bool data_valid, bool start_valid,
 		     FIELD_PREP(OA_TC6_DATA_HEADER_END_BYTE_OFFSET,
 				end_byte_offset);
 
-	header |= FIELD_PREP(OA_TC6_DATA_HEADER_PARITY,
-			     oa_tc6_get_parity(header));
+	header |= FIELD_PREP(OA_TC6_DATA_HEADER_PARITY, !parity_odd(header));
 
 	return cpu_to_be32(header);
 }
-- 
2.34.1


