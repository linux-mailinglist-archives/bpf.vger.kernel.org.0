Return-Path: <bpf+bounces-53480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6BA5510D
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15BE1898C6E
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FA23BF8F;
	Thu,  6 Mar 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F63Tc11C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6421518C;
	Thu,  6 Mar 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278450; cv=none; b=F9zX3BG3gTqeUQ/lq1yLCSZjRdO/Tn6F1wE3NeGc5007Pcl0+MIXFGNrZySQGFEpiFQGStzC7ocIse1S284XaMcft6lzDNJ+MERIf8tZi4SKF3APga5okcp+u7k3mxjGoKJIyHLdn2KAloANt5zSK+zBiWW9akth01SREPv//3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278450; c=relaxed/simple;
	bh=WDPrYaKj7s26kse115+qww0IFHKFhkIMhznNoEr7JrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+XXMRbeCHw7eCWt99/yRpXf4lBRugwkTRqAcG1h0IqUQK+lWBHngbLAXpiM2cR07aWaAzctf4Trx1M62Iw99iVT17ufr/kYr+1A7SbK/xkoHYSSW/2/wq+EFCPmBfIxoChgs2QwHeOtSjsuJlndETQXhe6xtSm6rCbhTZS0FqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F63Tc11C; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so1506832a91.2;
        Thu, 06 Mar 2025 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278448; x=1741883248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqxvpgZHoGiLr6YH8sD6RZa4e3r1mx+K51Pz7JFmQwA=;
        b=F63Tc11CLgc4K5Hr6SkhBlDGc/YPfrsnlqPrGBwrXEAa9yUBMRtQAKnYZVAc0x5W6d
         l/DwY0GjDtdcZoQxa3eOwscyVcc++4DA0u9XNseIIMelKL+PVjn1GY3QphYlT/k6XzvB
         BaojvexIE3t/ZuFma6bwcDl1R0dmV4KNl2IdwDaiR9FKqTk7BR5OEtSdDD29T6G/JGTE
         g/iRIqgRNTan3Elk+rbf9C+LwP28slK36ws9MCs8zls8hPHtFdGllpAUKNMVBTDt6NK7
         6XBaARDixvSGBmHpzGTHg5GuP/z7brYdvKyZI9yxRoZJX+xa1vIaL6YrdMyQlq226fQO
         SyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278448; x=1741883248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqxvpgZHoGiLr6YH8sD6RZa4e3r1mx+K51Pz7JFmQwA=;
        b=DLmyzuvDhVhEKzBJaSRd0diTUD7O6yfIiZPsZwF7QM3NmlMt/ncYyJWXcwNHvehao+
         vpJBaBpjryP1Hx3399KojHb5URYpGvC7J5o+LyG+6R+kJVCS/uOPyqS9KnFEjee2oZSe
         2piy7QrOTQNCfJ5ftmOIvuWcJy8aTb0Zpe104WgRSkty5p3bFMVnZ7vlAfCBm/5F+4Bq
         czdpZtWY3PAdJAnevws5yUqy2InEXSTOi7BEhCiGCYUsFd2yY2fhr0bSBQ9by0xh+OsP
         n4xpzouSLGZokC3Pk3z0cLT9pw9LcEXzHlrpuksg5fLFKvxJGryRljL8suhmjy2Trxub
         c0AA==
X-Forwarded-Encrypted: i=1; AJvYcCU9+zfMnV43v5AfHALvRa3JuqD0cP4PAU+VxLznBROLmgspGG109L5tNpBTXsJnmIhnVkyqPcE/dcTJM4g=@vger.kernel.org, AJvYcCUwG3P0fZWV8/hW4QbYjPv1o/H99BwSBHELufX7NI5OWyXKRhkL3alAn0UJuik93he37dv/gk3u@vger.kernel.org, AJvYcCV4QXRqfFuqp99Ax+pikmrjYM6Ooy3LLI/KOMaY4bFeeYprdE4v5+qL6wabD8fkDXdvX1a8JBO4l7+HzFQ=@vger.kernel.org, AJvYcCVYalcw8Ozhn9KeNOyJFp+5H1C1zb3EXz0IvpxwUSu8APMCLcWZmK6LW13vjiAKBY/4zyzfazVQgfoVd40c@vger.kernel.org, AJvYcCVmObMmngV9K4rxyMyWXy3UexaARpdft9638zIt0F2FjxdCa9C2jEzGnhhmxwuV6Np0YOtb5TlmwrXNZlaS@vger.kernel.org, AJvYcCVqjoW9fL5rp9W2UPK8SWrUvDn4xYo8yBLNHnSIAh/ipm+x6I1X+8Rc6KBM1r4PuCPpD5w=@vger.kernel.org, AJvYcCWpnPWj2k8wm11u7GKVK3yQjz0PVVB6N8r3fJX7IdR41jI594Zw4lFY1HktOmlEzv/c96EwwRB5vRjM7POKZvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YST24+kPl836unfUbh2u0VYBMM+s6Ds497evM2+L/TnoTv73
	ousvVToHd5n5h6DB+WJtponJpAWAlzbznb1bzGx0B7SwvKpvnstz
X-Gm-Gg: ASbGncsBpYKIKspPuQBQCHMEUzJF9p92fZid4azYY69644Ddq6UMSwxVCL8oCQzRcXj
	fxHdXhDKUqw+NHkE5ew+Mfe7mc9YS1nZItMQR6wRWSDdFAfgUdoiIEeBl0NYiCobwDX0vljV4+g
	5IWdPdQ4LWnXsaZrg5Jn79ZpFm4sAmtgM6iGHvhitQSrEcoXBMrl1BwGUS8Le8u9hgu6DHSvPX6
	Rfr38YsQpskq+PDhGrbwXY0vvXOQHeY65JUgPJgR31XnrdZXFNTRMydj29ep/aVT14NsSBHSujz
	ea/RRIEfiKrlixI4UWCcUzGqivCJk/B4AIipdiOLppUjJmDvjsJ/qbUuWeybUB6kV5p0m85+9+0
	=
X-Google-Smtp-Source: AGHT+IHUo1VQ1LAiyQ9UXLap7uh1jhPtCUcmwdFlNac3xPKGa9S5gSb9W1skAcfvxZCU/ssK4wuDpg==
X-Received: by 2002:a17:90b:17d1:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2ff497cd4b3mr11755081a91.15.1741278448219;
        Thu, 06 Mar 2025 08:27:28 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:27:27 -0800 (PST)
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
Subject: [PATCH v3 09/16] net: ethernet: oa_tc6: Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:34 +0800
Message-Id: <20250306162541.2633025-10-visitorckw@gmail.com>
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


