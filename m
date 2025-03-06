Return-Path: <bpf+bounces-53483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD6A5512C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E87A9572
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C08241676;
	Thu,  6 Mar 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSOch9Gh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AF21ABD3;
	Thu,  6 Mar 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278479; cv=none; b=lrhMnKmAPr4DGidCwtR+vE6hpUiO/KaKa9CDIiNgaaKmM3fGuM9MGoINj1COQwzbKPSP/2zl9qKcCNId0z7s6W+9XLqIrCwoVpOE6ZYionre0I61O9eDfCzgNQI4gPBKTdFE/SBIS6RgWPDtrKHdDzb1syaFgd/W6Rm1JdwTvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278479; c=relaxed/simple;
	bh=QiMst4KG8nw5lbncH+WStoqZ0M1Swh/bMRY1iwVqAwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TinAK7Yw95ZGnTmFfA8nMRNEagkpXUkRJutwSt19xC70dT2Q9ul7+x6BMHQgO7cDGGoOuTjsybZgaRoJG0gs6YgfQ9a/iWoVs6in4tEVTEIRujCbwjyIkpnvLrs7IsIu/AjkkYb/2tcopMfa5Ko2LuvFMRaVjONa2wv2fsa9nFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSOch9Gh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso4098889a91.1;
        Thu, 06 Mar 2025 08:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278477; x=1741883277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAZ6yehSc4MEYrK/rteyLhLjWQGTSbLYrKbJr1roEME=;
        b=gSOch9GhNDfuUe9oP4mbLMeYVbxbgdfQPn8H7PPm6oC5eIPGX3jwFAHTR9Ilxhfh97
         Albc6yBB5kDMD9h5V/FCnIzMDp0/Del8KcwVLKWf/G9p1iE1QpnQKDkqF27jGfa6yVS6
         jRK2yOWXsNA1Nw893Nji2Ld48Y3UOKcMMSVUC1n98vBSir00E/S2o5pbiqBrBe2QBzAb
         PvvmKcxG6aX4zd2cyI0wk9n0sR2Yz0yQUnoeht3kVeJBKpWxZZ8Pnmm/DG6Ijxvv0LDs
         7ZxC5hyYDPqBAb87UMOiIeHHnP0nUFw04/3023iDdNYVDe/rY4EQJx9/BWnkUPqwtWiu
         7tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278477; x=1741883277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAZ6yehSc4MEYrK/rteyLhLjWQGTSbLYrKbJr1roEME=;
        b=Y2tVkwFK1UT3/vbPEgFVBmMkCIAhFKS2m/qzKCSLvFkvASR5enpmfspqBhPyUrdd8p
         RiEuEop4n5BgWwHkmLr0W5ofUc0A1USslFWk6IT3RGFGyv/pEmbPsRrZcIzcg5S1etbZ
         gmzfIlaNDrsKc5ivxElalgMQ2PpdeNDXxGXh5AICkE9KhxpcjZbtdGk9acH/hNDC4rDT
         gJZBFlv59WGnFJWJQZ7M+xOzsdas+hHy0RHHP4HjstDspfVJj194rmv51HvBXAH3Rq3g
         zWFbsrnmclni5DIQdKGFlHYTZiy6C//Bv5wb8qQZt6cXCoNXsfiM+w5Wgz6EHGvEHvt0
         SSnA==
X-Forwarded-Encrypted: i=1; AJvYcCV8TpWyx7HrPzC0I56Pw3fZYTuvDgyS56VRkWKD3WvwzNwvBsLCl6woLpll7lpdCijRgXNocTjm@vger.kernel.org, AJvYcCVAwhH+aqyPEz5IYhmetCuikzJCLyNgT0EbRQetaMZTkaGeV+3oafEuZ5EcVx9yvj0dj/VQ7wozoSDTJF4J@vger.kernel.org, AJvYcCVaYQpdJjefpgWq/F4N5dFEmQbA0GSx/UnIZkMAFrp/6szxMRVuX7zwGQyGu5iCsgFJG6Y=@vger.kernel.org, AJvYcCW/CC5jX0pKbCDmqPwhT4XG2hfItrUE3gGpudEPFwblsEPUJRGX2asH79RgVJV8GekY+HoTTPP7hfv88YE=@vger.kernel.org, AJvYcCWLL5x8/oF3do9PTTMQNrgRNwbKPlKJzpiYZkOw8my6dbhg+ynUoqxWI0B4XOcciCdXl2tTcozuWVQz38D++HY=@vger.kernel.org, AJvYcCXUMY20HG+xy9I9+L91tHDk5TtwQkFM3VHzzdM3KVftUtC0R5TStzJiDWWPppyOhqfmjAGMVZ5dIXs7t/Hi@vger.kernel.org, AJvYcCXdPl9BqXbHcXNG0msws2vLTJRaI9vGxbnxUdals3VvlnlotV0+pi3C4aDdN0YikumvCSORCxL8hR1T6gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWirgaM6ELHRHTQXEC0CevgfnW4SWA8KAy5EFZp5M1yj85l9u
	h13gtjAZq61rVXVU3iK/SlSNrxqyg4bC5+nXPPLgDlc3qXjnakL7
X-Gm-Gg: ASbGnctpxORcZSUR2fsZH2xqGjbjTnBsFZvfRWgSmgswVzp6ZMOf9T1ng//qFBhX3/a
	MQxFpSrOP0/ldP//KuUvweB74preE71iuDIq3Rf9Er/xqJzT0me8FE96DlREECAPtCDJehhDSAa
	5j3+/nDw9vaVJI8DlYb1jHzFHae/eD0kcvG+n+Y/UlTSphds/RU5Sv+XXLm6A/GHv/CPPv6VZOY
	+cOxDo4AJXdSSwtYpAXdke3D7RgjMP3iOmB0oRBGx7cQqeQGUaLQHvzkjSHmXeWo8t+X+NEcaxS
	LVUFTYelW/Bo3gdJPuCYoDojV47Ndbi34kVG+Qlhdb48ZdLqintvab+JUtxPwHg+qRw6wdaWN3Q
	=
X-Google-Smtp-Source: AGHT+IGSTp6IoXEU2YpG6BXR34TKK6tsBmlfHVAOxv0eBhCn0t3RdyPBa0hZZRnTXXw4e83qNulrtA==
X-Received: by 2002:a17:90a:e707:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-2ff618003c5mr6206329a91.17.1741278477310;
        Thu, 06 Mar 2025 08:27:57 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:27:56 -0800 (PST)
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
Subject: [PATCH v3 12/16] mtd: ssfdc: Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:37 +0800
Message-Id: <20250306162541.2633025-13-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Change variable 'parity' type from int to bool.

 drivers/mtd/ssfdc.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 46c01fa2ec46..53a72576a646 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -7,6 +7,7 @@
  * Based on NTFL and MTDBLOCK_RO drivers
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -178,24 +179,11 @@ static int read_raw_oob(struct mtd_info *mtd, loff_t offs, uint8_t *buf)
 	return 0;
 }
 
-/* Parity calculator on a word of n bit size */
-static int get_parity(int number, int size)
-{
- 	int k;
-	int parity;
-
-	parity = 1;
-	for (k = 0; k < size; k++) {
-		parity += (number >> k);
-		parity &= 1;
-	}
-	return parity;
-}
-
 /* Read and validate the logical block address field stored in the OOB */
 static int get_logical_address(uint8_t *oob_buf)
 {
-	int block_address, parity;
+	int block_address;
+	bool parity;
 	int offset[2] = {6, 11}; /* offset of the 2 address fields within OOB */
 	int j;
 	int ok = 0;
@@ -215,7 +203,7 @@ static int get_logical_address(uint8_t *oob_buf)
 			block_address &= 0x7FF;
 			block_address >>= 1;
 
-			if (get_parity(block_address, 10) != parity) {
+			if (parity32(block_address & 0x3ff) == parity) {
 				pr_debug("SSFDC_RO: logical address field%d"
 					"parity error(0x%04X)\n", j+1,
 					block_address);
-- 
2.34.1


