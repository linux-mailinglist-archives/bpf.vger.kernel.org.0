Return-Path: <bpf+bounces-52281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D52A4103B
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644A918908CC
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9620C00F;
	Sun, 23 Feb 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kecdzp54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F4157E88;
	Sun, 23 Feb 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329117; cv=none; b=jrnJvHqZ6J295+2Digq06Y0ThOQif0axVvAvwFpmK/qV+N8+1vTpQ6r0Y/gidgEbVMlBmMAasmoVGx3nGWQOhil2GhJlkqykQoxx4zUM5t6mTevRz6kWMP/zdwdu/9YLLYsA85e9nPEVgeXtzeG3WcewTtdeaZyl3KkuB6zaqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329117; c=relaxed/simple;
	bh=ZR7k7WuXjWgoiKosaPdwElgny5Md8dRLy7kh+y/t7/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAcMZuvattZMnP1WsrCOrYkpAjrl+0b+vksnsPSvPlk4uVpbZFpVizsaMe/0kg93/Avnjfe8OLSDqivjdxH0KHSv9+c/J8hM1YaTShZGBGx5bzHyIKdRPFeaFs5RlS1n9AqnJHk5y9ncvWivB+77UWhgQXo+64IT9tTP3Bz4IN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kecdzp54; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so5518703a91.2;
        Sun, 23 Feb 2025 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329115; x=1740933915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0fPaIWjdscIdDk4T1YIhhdJwaKRFyAzbGum2CZXkTo=;
        b=Kecdzp54CjErVHVKs0eq0Kgpq0rNxPJpXict9Ak4VppT1lBU90wzThiO+kXKMaB/pO
         A35uUtjHme6ShFS9bMxNEe3RgWFs1nF4FaUcAtZxPereEt1u7v9jzwJHSppslI/Jt6kG
         oraiW1VOrizSR/+oDadm8NwH30/IgmtWUwAb/Oz+1bKCEcpOK/f5+xUHX96bOBj3PyNl
         oNmo5ENhg6jb2euY2/OskjCMkaFw1VzfXcO/EEy0L610YGWuyAWWihdE/wIgWXiXKND1
         IKE/rLUCtgwPkKl/0eBZK6vlRW9tNzI8HbxPhz3z2/GqL1crB3mZ/xjScxXzqKkb7uqe
         QtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329115; x=1740933915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0fPaIWjdscIdDk4T1YIhhdJwaKRFyAzbGum2CZXkTo=;
        b=xN7SZF+6QVyd0W9n9L4GtVSNVqMW1ukS9M42OV7BnJKUYOuynf8mAe52WVyfV5Ri6k
         Il3x3LB9LZS0GujxKxTBz8wZQ/EVX48wVZm92LYn1UKuzGtvnFByy7E5yBLsGvLvmK8+
         dZTdX9VewaYMbrIEKzI5U5Wpeza0tdD+SLvxip+KYytP+M/4NEaJa91w+XsnN6VM4UUM
         4IXZrduy0hB0IlEZ7t7bnN2InUVAOqv813EPEgFzOq8nUwF2zitYkil7t1OoY/1Exja1
         fDP4s6SgoLQJ/fmNLkY2dZmjGETdb3kALpxP1bs6R1Yi+T9UFp3hiXAoF0FgP+U9pQv5
         /TUA==
X-Forwarded-Encrypted: i=1; AJvYcCUNeZOShh4o3sTAQRwpHh3AolTt5M47WXrplGBE3h9zJ0N8jNQKf7RgnhEXvK6gryLE9qtNl35mheHAHAo=@vger.kernel.org, AJvYcCUjuL9UMJ8rFUhVqB6jpd+RalTOaMuLS3UK+FxlY+7NipqXy3I298T4tECiuXsGC1eN3S4TtQr+7gATD5hI@vger.kernel.org, AJvYcCV+J8NNC+rTIXBj2w0dyyLwejJL6l8KRsPsQdM74pDfkmuYaJOsODWC48UWss2CUr/0ien32y6y@vger.kernel.org, AJvYcCVESlNrh7bZPZuUmHrOiKhTddwVODBqXmRaAl0ynytSP4zCYl1vZGp9nXl4JtPWtmMz4TB7ms00Ue3BsQM3@vger.kernel.org, AJvYcCVKfkGgfXFG3V8ad6sH7pPR4pv7nYp3SiIUSmkGH7nKHtRApZhSTDxdMPWeVW+G5v2rzrl4eFynklFzwBI=@vger.kernel.org, AJvYcCVrpFDeVULZKkj7Gv7awRNPXO364bY1mGje5cI/nA9yCScnRmLV/1YP3yoDvcflM+bEBXM=@vger.kernel.org, AJvYcCWDsXh2ATtLgLxUnTuyqcKEZi4Leqg00Qj9Pln1Jy6wwM3C4odGO4uBEUF8G3/wz1qHSN4MjKbXUup61fvS/cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywznh54PHGrTVIPWIhy4FaJsJUgM+e65ltze5PJqynKzPok+2Nb
	moBu9TvbVszP8tdkR/qCP5sZ0BLDePnnWh7cTI3Ul99PxOYpFcdq
X-Gm-Gg: ASbGncvnwLVnhrNgwXBAXYHjxXA9AVWzFtqVTqgKiowBHjVKIzcczPhF7IvB3CeOplM
	o6aytYrMciR/HIQjYgr0zlX7ej0MJ/JcrIUebpMUfM17Hu4XvKPFmDcUFf6UQ8rZ8lBQWOR6lJS
	GbTZQGq+ALH5Hacegb27Rm/Y7bQ/LrC8QNbitZ9Sjkadg0LtZlmFGz82BeCjhP0PLCXHQOvRATF
	zhOb+m2n2R0QUO3yUPha9VnQSLLi0YNgawRTPlyXcFhSXaHeJ91A3zwPn7vxWV00qB/mvgq/xIr
	AHaEzu3cSDqKTvMemho56fdfV5iWQ2+axDlmmm9ib7zfT6aqJjPM9BFo
X-Google-Smtp-Source: AGHT+IGRfmJ1JykXVI/nOn1hWPryN6XcmSxHhj3JPmFZZoIcxcyuC/O0UeP8Z39VhK9JcSyFdzE6jQ==
X-Received: by 2002:a17:90b:548c:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2fce77a4863mr16234632a91.5.1740329114693;
        Sun, 23 Feb 2025 08:45:14 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:45:14 -0800 (PST)
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
Subject: [PATCH 13/17] mtd: ssfdc: Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:13 +0800
Message-Id: <20250223164217.2139331-14-visitorckw@gmail.com>
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
 drivers/mtd/ssfdc.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 46c01fa2ec46..e7f9e73da644 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -7,6 +7,7 @@
  * Based on NTFL and MTDBLOCK_RO drivers
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -178,20 +179,6 @@ static int read_raw_oob(struct mtd_info *mtd, loff_t offs, uint8_t *buf)
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
@@ -215,7 +202,7 @@ static int get_logical_address(uint8_t *oob_buf)
 			block_address &= 0x7FF;
 			block_address >>= 1;
 
-			if (get_parity(block_address, 10) != parity) {
+			if (parity32(block_address & 0x3ff) == parity) {
 				pr_debug("SSFDC_RO: logical address field%d"
 					"parity error(0x%04X)\n", j+1,
 					block_address);
-- 
2.34.1


