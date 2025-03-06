Return-Path: <bpf+bounces-53476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0699A550FD
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526263AEC05
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA123371C;
	Thu,  6 Mar 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H58Scw1b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522F230D01;
	Thu,  6 Mar 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278411; cv=none; b=MB14X9MRlBsrPzi7Z1r9rt4HqENkaTIppIkTnXi5ENmgB3e4IUYVTALnex41ib0hLwAu6j5CjZkwbXzanfOmEgp8QRjy35veXBWaClAxro8QQc2P1fpGmPmnNumNmpm1s+dY4zn2VxFJVeoLlRBWkuPa5f1FvcslcscsMTHunpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278411; c=relaxed/simple;
	bh=j2/wDG0L2QiKPBmNCWrxOGnHtFWO5kAL6+5E33WSh7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTDJ3aMyMEl1KQOd/IrnpYF+yKcCz7DLclnIYy4aVTTKMcPCSuVNBTQ2iQqVLMWg5uKxPETuvhsPoE8+0dSSjGqAL0Hs1xvq+Spmoxp2LA+LxMITnq9tZ3Sl3HRE0UdPxuVt2q/kI+WuO2cIWpbntsH61ugAjzTVY0t99uJd4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H58Scw1b; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so2026957a91.2;
        Thu, 06 Mar 2025 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278409; x=1741883209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZw0QJRtM6IhR4KZmh2KNqroHre3ebnX5GDU+1y6qXk=;
        b=H58Scw1bouuOgTd7tuh66ss/DHrPgkcl5EsYdICgTxYOMTsChGCKmz+bSvdU+W2RzV
         o2GPqlJqnMYSLpFkHavAAU1yoYKW4JXb+vj5SVT5qgg9SVfuEvh3/Rx54cbXlKn6hSrp
         wo3dfl5jKlW17NPsWAUCk0GwqnxPyKM59pcgQbN9g6uPoQNhEKchiJCwSpuRGKdrwDRH
         R19VWAYQ1UQbqN7hPgO+vmQt+IkpWfBmMHQHolyCWbnRQanukWj6OZRwnV19Tfe5fuf2
         PsxtughFY/Edk/TbueDkIwy5i4amUryNgVZkuxc3QHnqD7mxCD9uGlxNwgF7SSSnXyuv
         CXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278409; x=1741883209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZw0QJRtM6IhR4KZmh2KNqroHre3ebnX5GDU+1y6qXk=;
        b=OlGsq/VkSGNfnwJWvojdly0Ihvhc8Od+Li/0zshvOK768hTL6qSxCWyeReB29ZZ2bk
         NYeiY8DZK7jFBotEOwSa1dCTViW9/02NWzqjf8LJ66aOm42W8K60MJEBbql7sbbJvWjK
         DX9yrungq79l/wTI3nJb7ZHT+SIE/EeaGEy2OMCLoOg4gRjtcNqLRqKryqzD4yr9mMGX
         O9FeUNHe1NOQObHmeR7SBpS3OtQ4z0wtHN007KXQODqw9l6Vlm5TpUdApe4vG3djeD18
         kLrxyLTQ/tGv9byY8/gCKZoNrNN6OY1MmInYiceU2prpwy9o5+fugsnlNTBCArHTtYyF
         5cKA==
X-Forwarded-Encrypted: i=1; AJvYcCUpFP3GRxPm9D2v4NKGliECl6wYnnyZLoOJlYvzLC+g6JnoNfiqOpaGdRv55QjiPHerra3zMKzgaJ6C4mH4hHM=@vger.kernel.org, AJvYcCUpFxXiJFiydZOmsA6c7NuixrZ8vnMsMLjrKJfXG7aoAfx7VxZZcpF/o0E01e4x9Hf3w1w=@vger.kernel.org, AJvYcCWMpqFQdLs1kwnjZjtCrlYImGLKP7i8+w5sMOA8UxufSyEYBdjMXKLoUC0y9gTUX0f3SKrjTp+3K5trnig=@vger.kernel.org, AJvYcCWrkbWgAzd8olPS9bshHy4D9x8czjABRP6xqIiEXpEv1ZezK5mNDqvL30JnxOe5DYspN20NQdQm/2K7vPhE@vger.kernel.org, AJvYcCXL/F2G1JIV0VQdrOb6MhEoyTUkx/DcobaBkDPB9uGx5CpRjd/+xiucUWTz0abIQ0pb5SsbZAFS@vger.kernel.org, AJvYcCXVBc3hNBF5c/l853WcaQNvwd0m3u+IquzE+NjTD2rZ8SjviyKbQxbhgwX/xThrC+8mXOxdZOcG6yEvqS0=@vger.kernel.org, AJvYcCXX7LzwLilIl6p736G9o3/FJUrzvmzT4aJDit4jABnSeMnj7Tqi0wOKtqC3VGmxY246SpJWfmJYSfbC5biA@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLAOE4ubKzcNubhPuNaU+CyzOLB5W/vZ4S6XiLbWUuHl6NDV8
	XG/K1oli8QxNAqSSHxQAdFQmmTXlW8CZmnlyOJQ4KSSagXnhd/iR
X-Gm-Gg: ASbGnctEYJE5lsWNTOygZ89lAwXvSFuhyr2s04pdR+ErySqlQJFoyvH972g0DwUueSG
	y21ndbi9DkXwT7wWsk/A3taB9bJbYIIpW20HCtvvzp6rtLEguhvolnGKwV5wG7+NQ6/1R60Ae4x
	X4590rHUmugW5tO78srwBr1LfgxB2Z1gkpvEDlNutttaK/CqDPT2aPnBADyW0a/5PSTLucu4+XL
	FCIkakF7D6H3VxdhYfwn1NY0Q8Le+MzzvWfZqNmywoiPj2CYK2uNwFLudJukcbGDMjNIhvcBAV/
	H8STh8X/1jpb+Y7sv+Y3GOUzKq2F0anRR06Sd/NvVY6j28HVStqn8Db9uDdUURkushtuDdcMl0s
	=
X-Google-Smtp-Source: AGHT+IE6epbCXvOg8cIc3QqWkrmaal2XvyOtsnANvbKq/mA/VIWvo3NmMHOwXwWdALV1bmHV/eFsdg==
X-Received: by 2002:a17:90b:4b44:b0:2ff:7b28:a51c with SMTP id 98e67ed59e1d1-2ff7b28a652mr262212a91.34.1741278408658;
        Thu, 06 Mar 2025 08:26:48 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:26:48 -0800 (PST)
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
Subject: [PATCH v3 05/16] media: saa7115: Replace open-coded parity calculation with parity8()
Date: Fri,  7 Mar 2025 00:25:30 +0800
Message-Id: <20250306162541.2633025-6-visitorckw@gmail.com>
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
 drivers/media/i2c/saa7115.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/saa7115.c b/drivers/media/i2c/saa7115.c
index a1c71187e773..b8b8f206ec3a 100644
--- a/drivers/media/i2c/saa7115.c
+++ b/drivers/media/i2c/saa7115.c
@@ -25,6 +25,7 @@
 
 #include "saa711x_regs.h"
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -664,15 +665,6 @@ static const unsigned char saa7115_init_misc[] = {
 	0x00, 0x00
 };
 
-static int saa711x_odd_parity(u8 c)
-{
-	c ^= (c >> 4);
-	c ^= (c >> 2);
-	c ^= (c >> 1);
-
-	return c & 1;
-}
-
 static int saa711x_decode_vps(u8 *dst, u8 *p)
 {
 	static const u8 biphase_tbl[] = {
@@ -1227,7 +1219,7 @@ static int saa711x_decode_vbi_line(struct v4l2_subdev *sd, struct v4l2_decode_vb
 		vbi->type = V4L2_SLICED_TELETEXT_B;
 		break;
 	case 4:
-		if (!saa711x_odd_parity(p[0]) || !saa711x_odd_parity(p[1]))
+		if (!parity8(p[0]) || !parity8(p[1]))
 			return 0;
 		vbi->type = V4L2_SLICED_CAPTION_525;
 		break;
-- 
2.34.1


