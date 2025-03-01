Return-Path: <bpf+bounces-52969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7895A4ABEA
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FFE189838D
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28661E9900;
	Sat,  1 Mar 2025 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgLlbKBB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C661E0E0D;
	Sat,  1 Mar 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839179; cv=none; b=O+gyTdVxFsOH5C5F34uaE0bqDeZhJ2fp7kNhq11isRIgvLi/TiE/bEj+ZFc+8hvMH/+0ReExzXmpRzGNN/WKkMePJeovfT4GjCMT8YVluKSgkNTRnrJ2GLajhcmYXKxnBB6hS+hC2U4Gdv6PEEm2UADR20Wi/yXOwcmbjDgONzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839179; c=relaxed/simple;
	bh=j2/wDG0L2QiKPBmNCWrxOGnHtFWO5kAL6+5E33WSh7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiP0vD2szERpusFgDsl9wuW0gIN6zVX/08RP2zW/pTPWuNX84lsne6kMYUno0BhiCZmQKEZdgiGMX082HH1qzjHfXb/pCaPpAHWKgBNF+wmBvTPf1vaT5LeJ4g3Yvd/JWy91B1e1zYPDtLZyy07kkRrdp777mxLd3Mz/1FcYRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgLlbKBB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2232aead377so58821925ad.0;
        Sat, 01 Mar 2025 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839177; x=1741443977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZw0QJRtM6IhR4KZmh2KNqroHre3ebnX5GDU+1y6qXk=;
        b=JgLlbKBB3nbI9hHp3Y5fsVUs7zPWqywqLmdnoLCJ8CjJA45ydDoKSXPcvmPKxYKE/5
         u1IYJmUKgV8BwUfbqThi/HiUVAPL2DK8XrH/j92EKd2kCd2hA5c6NJQmCqjelMY6D1e0
         mFKt3Ry46Ha4jmNGBidKhJY2HXDXABheSAu3/MQttruFZ844b7D9mknDpJ538BzDfd66
         C0WmVfKLut7CHXwURJPpBHttmEz5V31CJhzRlbw77d6d24NIPf+xCZU0p0BvtR+J36L8
         GgEHRQo87k7eHD5HlwviXRPlDE8UInEoyr2JXnYqKM938j3X0FN6pumZUOeQo3JgWDUu
         0Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839177; x=1741443977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZw0QJRtM6IhR4KZmh2KNqroHre3ebnX5GDU+1y6qXk=;
        b=xT/IgXLyqg4hdARL47xLLJYECtTiv4Cl71GHRcC1y8sxpc2K4i3LFte5H7E6ZkcJZb
         EQ30W3dB483UoLwIBH1CU6dnJLha7CzcWLN1uqViwaIdPF8YPhqHdQrTZCWeEBy5XudY
         dPpwfxfEvKkf/iswxUCTfUo5rhIJNAQKhD3WviVjyfm/CuPs18h8hTlShn220UnkC2ed
         oRuQumIVA7LtWiXdCHqQ2rTJv0tJeF2U5ilIzfhkjLWSQznOZ+7b3tLl0QOhy+Y2Q0Sm
         eMubfp9Dc9k4uJwaUMzlnFUy4evrPBNzZ7Tac84dcwzF/Rx9s/Ku0p0WAOtEyn0d9Iae
         sWnw==
X-Forwarded-Encrypted: i=1; AJvYcCU4pGSPb1RW22DD2E8DC+vh6ILFBdWRMXTbZYGSgvaxe2BSBGARbdvEwa3pc1cWwP/wC2HhNo9vPme5RnY=@vger.kernel.org, AJvYcCU61SXQOqFY0uOwzemuokOgxnWvsiU/fYLKs7X/l8KwOpZU/vxNQKdMLQM8rMuGmZ3U2e0e+EN2A1qM66l4@vger.kernel.org, AJvYcCUF+nUosCRKsvLQpKrxQaRhxpnPH/H5P4SAI2baBBwrJumhmPWM1wTawP/HN6SfMs+ujFZuBrS2iqb8woQ=@vger.kernel.org, AJvYcCUabT+1m3J1jQMLhYfRPNjjI7wFUZWTjpC9Fq4xr7gtgDad+9LfjPp5VQqmpbLDU+tFu/HM3Iko2obZBE4eky8=@vger.kernel.org, AJvYcCV/RPjBMnhY5TXzBgORrnTamj+tg/H2DkWVt/AXLB5Nwqw1U2JzrgCTeCoXEV6AofKG/rk=@vger.kernel.org, AJvYcCW9iXLZVkj7PYO7ec9CekoImiuekB9WOj5j0eO/sL026EoOus5xveNsfb1FGYqxtDiTA+qjCRJoJvCV20KJ@vger.kernel.org, AJvYcCWN9eOnfX3Byr3RL2I3vKqbFJ9rF2cWJ3aYDGrsRSXyeA5IKNGVtbW16zlOjlsvfXYmaOCRH8Y7@vger.kernel.org
X-Gm-Message-State: AOJu0YyyL14cSqUdApuB6iemDqODVgfwd8HWUYlFytPY/SxhZWXjJNhk
	7r30rYdu/WpP4gxCDF8VeieMUIJZVEehTNlPx86hHiHwpLHAgZve
X-Gm-Gg: ASbGncvhCDDY3kiqy0mnIni9q9BUxWYHGUjAXbsJxGZY99HPcixAHGSXInyEQEbkbFJ
	sEwC6H0WNvw12PimQV9RMS6qpGghuf1Tu+ZGPk2LU8ICpTmGTPwMeQ4TebusuZlZJTCFe8oFNU4
	r0PdC0d/PO8vsxIB3I0dg2k870pUF+jPY1H7i0U62ocJm7H3WE+mZ0qZB3EJrSyuMMPPeA/AJTI
	z0NGLplMGt6e1KlllsZ348WaaIK4BZhev4Ey+xy685A2ok6W4sFVwEOoOqyPgoVxtetQdthVsjB
	mdpAUfi4kvYDiG3auzFs6Xq2OjQiXodM3z3PpPmU6xUgLqIDdBQPyZVqNzplDbmVd7BHO0d1uaw
	=
X-Google-Smtp-Source: AGHT+IHr7/bNocCASgkhvMFxO0zdSkmZKMBxSgSw4TIYugdqe+gxkfqzHvRXHP0fkW72YV0RkO2YNg==
X-Received: by 2002:a17:903:2ca:b0:223:4b88:780f with SMTP id d9443c01a7336-22368f7558dmr109533355ad.17.1740839177198;
        Sat, 01 Mar 2025 06:26:17 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:26:16 -0800 (PST)
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
Subject: [PATCH v2 06/18] media: saa7115: Replace open-coded parity calculation with parity8()
Date: Sat,  1 Mar 2025 22:23:57 +0800
Message-Id: <20250301142409.2513835-7-visitorckw@gmail.com>
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


