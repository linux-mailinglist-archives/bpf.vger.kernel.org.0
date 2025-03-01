Return-Path: <bpf+bounces-52968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA2A4ABE2
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4AC189567B
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AB1E3793;
	Sat,  1 Mar 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfMxiw7A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9E1E0E0D;
	Sat,  1 Mar 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839169; cv=none; b=E3ml4ecgTeF3lchlGi18702Vw0RKiyGAiVtvb+dAl/0jrSt6A2CQV4Zjp3DoL42yr61c0zi4thIvu7RKdS3Wc+Rc+icT87uXKk+a6wmXrXdtYWDh/YV19AW6e9xEwTMSfJgzTm7pDfsMVaU7FI6GrJQOEiFaqipXJX3UeU48qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839169; c=relaxed/simple;
	bh=JIGbdj519hBofglwm1x6Wa4PWHJoF7xJSHZGDTpyM6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyMkD9ARmK1eJNItUVzTAk2CZk/LSWz78ShhE5kP+v7fbHLWB0dgSvZwlAthO0NV8RBWFpUF+ULIwjYeaEfmoLpWYu55XEzPOUD2dkPeB0+pIcEn+uUfvSY5+sc4ZbjO9gtHkkhjKtwGoASMVm+Mxz/ZxTETzEcmkXVhcB2rQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfMxiw7A; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223378e2b0dso44908215ad.0;
        Sat, 01 Mar 2025 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839167; x=1741443967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Ho2aCKNYfg5T/o22fFzxZ+UyjSx6Fm0wn6W8o8Gr8=;
        b=nfMxiw7A6eBAG/6id1Gu8ZeAT4PW3mnHIZb4/nvo7+Bo2JVVnl0s+JZEKekzh9dbBb
         cSd9Zf9ZjqdwCuhdNS/yIDCCSBycxCKs/lBAYPaNkdKLDFT6nM3wt8y6MH4nrv3+quN3
         ggMYzg5wFsbuVdOAFgL3gGPeaKCiGf4lfhdSiGZxpgA1nWjRwcOTo31f8p5B7IfOk4iz
         GFveQf2B/ddgch6H3+eF4HlnP/vuWo7SQHIhiZ7n/P3R94ZGNw/SuR6JzQhMmGf2psPK
         8k9w0+0nvAadUDp49syY3Od5Ky+vOquzeIqite25jwYkaEd43jaSFTVPsbKIlmgATeOH
         7KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839167; x=1741443967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Ho2aCKNYfg5T/o22fFzxZ+UyjSx6Fm0wn6W8o8Gr8=;
        b=FYfPO3hy47f2aVwB+D7QRKKltYMRVGDwiXDTBJGR5bcTB3sIBkERSQchXiLkRp6Imp
         aUSEjEvAu5LmxNAqoznVlELszWAukkejF1rMcvVSqFXwhQZokfdX11kf1dSTCejxKkdg
         7KuilEQ9r9Wd88AiMNyAsGhRaFMzVV/t2HupHqGlsgARZ1Mw3ytsjRC832bfNWzqkus2
         lwU9ICcSTk5yBz1csSBjXGZ4w+Lt8UfCa2V3C25kt0syMcVkf6Y4Wbd8eMLQNIbIo/3q
         +csHqHIQXOVifc1ZSUFAD4kUE0xUDrOcGe620IN9AHsXi2H2kCacd1a4kYRHBpwCF8Jj
         T5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUSqheUYDnTgSThS1KV6u4PvsO5qQfuntXz+kvbM2ru1NRURX3QkjiBErJD+IobOy3ZaxR+2q3H5kmX8NM=@vger.kernel.org, AJvYcCUdhVHi8jnIyuMtrFZmFAg8nFavai5PoskqVPqCm/g2++RVEbn4PuttEDadpxnAzhtSREwN4uefn8x/1j8=@vger.kernel.org, AJvYcCUrLM1j7ywN1Ue0XgX1uu6GVEAW3wIEFNztV1kPfzPnPVPmmWOi39ps1gMZ3FnHTVpnHYdtbW/A@vger.kernel.org, AJvYcCVtdak7p4Dp2o+qvPLbckLsl9Hp3JVuTr7QFda2DB0+2ixeYfcObyCnlvnpNzpg3iJR/eaQwY19oc2mbGlm@vger.kernel.org, AJvYcCW/NpnEB4OzQpIgTQwBTeyPlBrTmEWKhz0BmXyvANwwr+iWZNshmv4awBdQDqKRB7gT+/c=@vger.kernel.org, AJvYcCXsjaQ8Vmw2A7pmHN7p5Ixm8eBF1flDojD30Nv4uoUhDDX7u7lE1Mc4yOJKhuiVCgF/GSdgMJZN8opz3OFE@vger.kernel.org, AJvYcCXzLA6poHH+A8sc8x1GqZtyjYuritTxBagjpA3IvXR3MFahM1nf1E6cy8puMDPoICTvM6fX/Pst2jFHvVonbh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8DPpZi2SK9Ogmm74e+zpNd/WijD4+T1SvJ8g5csxEWUM0dHv
	+f5QvY6r4lHhdE444tbYQA1wsuA7xXV/PLZ8R+QEoJCXfbdF0YA+
X-Gm-Gg: ASbGncu2cLa95eURmesHsUvziYuWAxeye5KJgmzNuBDHAvyQ92X+dVLIXQRU19KW/v+
	uGwSbepy2W0XOGGDYkEiRUCFLCn3ZE7t4k5F1tT/f4av4rS94rqbkNh+7K6kUWU+Lr4aqH0/Hjg
	1Ro2PXFJWYzSkbf26FXiMy0ACiWhn6OsunORkj9cMtlP8m1q2vML4VNXHad7M1hn7gw1KBYyPdp
	dfUwbgNeNEJxgM7WjUZ9fDyyFUNvyYyxDoFDuo63XsA9nB8O/7pCk72k3JsqG0xdxD0J726J9CM
	nabw1UcmUR/1rAIEiKh+xBp9toIA5EVKK9w+nHF2E2GQE1NfmXajo5ZCcC4JqRwGDUNGxt5m3gs
	=
X-Google-Smtp-Source: AGHT+IFTfohTxN61KiiUMR75yyegIVFtOgTpaXboBycWTn/wkpOLO86TKXx34bh6gLZ1DoKzx8tYbQ==
X-Received: by 2002:a17:903:fb0:b0:220:e7ae:dbcf with SMTP id d9443c01a7336-22368fc9332mr106296855ad.23.1740839167480;
        Sat, 01 Mar 2025 06:26:07 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:26:06 -0800 (PST)
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
Subject: [PATCH v2 05/18] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity8()
Date: Sat,  1 Mar 2025 22:23:56 +0800
Message-Id: <20250301142409.2513835-6-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/pci/cx18/cx18-av-vbi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
index 65281d40c681..1a113aad9cd4 100644
--- a/drivers/media/pci/cx18/cx18-av-vbi.c
+++ b/drivers/media/pci/cx18/cx18-av-vbi.c
@@ -8,6 +8,7 @@
  */
 
 
+#include <linux/bitops.h>
 #include "cx18-driver.h"
 
 /*
@@ -56,15 +57,6 @@ struct vbi_anc_data {
 	/* u8 fill[]; Variable number of fill bytes */
 };
 
-static int odd_parity(u8 c)
-{
-	c ^= (c >> 4);
-	c ^= (c >> 2);
-	c ^= (c >> 1);
-
-	return c & 1;
-}
-
 static int decode_vps(u8 *dst, u8 *p)
 {
 	static const u8 biphase_tbl[] = {
@@ -278,7 +270,7 @@ int cx18_av_decode_vbi_line(struct v4l2_subdev *sd,
 		break;
 	case 6:
 		sdid = V4L2_SLICED_CAPTION_525;
-		err = !odd_parity(p[0]) || !odd_parity(p[1]);
+		err = !parity8(p[0]) || !parity8(p[1]);
 		break;
 	case 9:
 		sdid = V4L2_SLICED_VPS;
-- 
2.34.1


