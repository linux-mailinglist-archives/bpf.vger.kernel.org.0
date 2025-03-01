Return-Path: <bpf+bounces-52981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E45A4AC3E
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E36518852F0
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7C1F2360;
	Sat,  1 Mar 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3tuGt4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3721E25EF;
	Sat,  1 Mar 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839305; cv=none; b=L+yGH+GFizU0QP5FA3LlaBfWwzNLv7g3nf0vLzkTxcTNKGqJLdv5jB/PD/e6zxxdQtiio13q/9hl3SYLkuL+aJmijr+odAwUi4LKA1uQvXvs0lIdrjzll8wdoolAGZ7oHLlt5pZgjQHk4lQ/9R6685kjqYzQjorjJ1zaEiQahDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839305; c=relaxed/simple;
	bh=wv6ajOFVKcvTUlaSn3pgXaNKGIdVIim/LCFNOWca2tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlUh9CKR48nrvz3Qmgr36ItRQvNYMj91+57RzX05T0oSsTTeGmup5IY+EldyxGCKxDlkf7UTev5DSMOgZ8jV02UVmfGpBSZqLVZKL6sUewFX5SKpazF8fP1lkeWrowJYeRuj8C1wVHLeiWS5wjgbtpp6QA+1aU06bGKZOHvHbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3tuGt4W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235908a30aso28682805ad.3;
        Sat, 01 Mar 2025 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839303; x=1741444103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+YDx3nsS23nFYRYOsOtDL2pw2M9KWSnqwRamUvuzKU=;
        b=J3tuGt4WusOwpDTr/68d86e2jtux6vfI2+v2wtPK7Jsx3EH7CqDy3ywlnV3dNou49k
         zwzk6DOan2l0xXDJttHoOFobD1qRwhm2s4KBY/4hU8vcufDSc7CJB0L9Jc6OM+gI3UmZ
         C1NCBId8QTT/M7jFDRKilaqsEb06bprXtZygXUw6+Z9MOrrJizb3urjWeymrWSKjXwEX
         2otRuYtdGtgGlX9hyi1GHhFRw05C/f+MqPs5TQeztbzbVU0Ou5K/bIy60u9sxMiQEyfF
         CilkXYeC6COXPoYW8EEN+FLCCP+guYBFpY9ADJTn3RlTZlS4Rl7AESV2KJW6omgbaiDd
         VEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839303; x=1741444103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+YDx3nsS23nFYRYOsOtDL2pw2M9KWSnqwRamUvuzKU=;
        b=aRG+k5jCdtIemLzSobBYlbNKdWGrgg4DnylDyOTzyDwO6Y6jCQ3cZ7lF4TWSp6V7Rs
         zNWylzDeWuUyU9F39fCwitTF2fqsfvuJfoutB42w0S00qmOjzbfbCJeN6ylMYrafzXeq
         U8zYpaQ0Oy0ecNjSKXdLBadZJstp09eZznPjb4RAR4+i9NfQ2wufl2XJG6wgQdBBrgfu
         6KCq9o7dEAwqbi8f6st+86fnsOBS+H6fz04ifquNR9ZSxoYz/SHPiB3sHLTysyEnskEm
         jCc9S2EOjitR1S6Jny9o/r05EQ8lzQaqb3MYOgOn1yiBvTVgMvDzEO0YE/G23tfvjaTQ
         aXTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOR1/kUkOP4Sr4G90j6lzzmOcHqVbiiwngMl025UOBnGddb1Zz2e9/QQDHH9ov/kKal/Hi8MLv@vger.kernel.org, AJvYcCVqEHG/p7Fs0aUthBcuuQMYJSYsqePGrDQozwj+BckJV6KFM3bhzft70+6zM+hr+IiI0IrstPyKfMGMaX5J@vger.kernel.org, AJvYcCVuk4eRBlVOSv8qJ8WGh/66Vpb9pgzrZXAsg2Etk3meaoHjSaWJgwuQlXa7YVNs5j7CYL2cYNbN3qKkj2I=@vger.kernel.org, AJvYcCVwpcvEwLRpFCtjY8cqBLJ/cswY0duq4oXRPDVP9AgQRJGk8DHURvofQR5j6fkYXOMj/OmiVgvLT2WGkJFZ2/4=@vger.kernel.org, AJvYcCWDSqefjCOJB80lbdbFS+wPq992JAc9lzHSW+pbe0qK8HDt8MVySCV+IHK1FFDBPPo8MfiU4dvMY7pk8JfD@vger.kernel.org, AJvYcCWc0PxkpcQW5NdVHxwIskHOEEojHlJidMi7XByhfgOOGNOsk8qgER4rez9tiZGdCrgE0c0=@vger.kernel.org, AJvYcCXlOSC6Z8XRoU3+5ZQwUbw3ATEyO3yU9gcAdaKWVqBmse6K3JUGWFVlMwd7i/wSdhhDM/C5R6R2m+c+350=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEqnLrbkeAEbUxCZ0RzFjwKytSmv7QVC3oJQYhiAiODmU5FZc
	QTD7ZOcmiuCwyvTJyTRDyioIW5ZJEvVDRxi9EKllwvQiBg20CiSm
X-Gm-Gg: ASbGncuKLSJeWKaFKl1jCnx4Qkzi7nrFBrYZTetTr1Qr30rGBwMkTrDkI4olOpZ91Xw
	llOeXTqPXD/BR7t0YkmNcMpxsUBxen/2co34NaPvPrf7a6mSUPrdtvaadVJCG5+ppEAJ9tM6O1X
	nsYKf90z6EvllJ3eQ+3E58bwaUeIFO5iAt93OhabEwcadEjwE/BUduVfnmLnoB+VwB9fAaSysmU
	v7sH6i3/uK4fvmDfyJDgGV2Si/tFtumty2HTvcW6GSGU8sMl/jCyhCIekxcI4qncXT/loXVRWUl
	o5w6mZana30b8x4NSXBdQD2fU+2m4pfIA8sDmP4a+JgLaOvD7h8DdxY2d4d+Yfogq9kUIsV+JFs
	=
X-Google-Smtp-Source: AGHT+IGhHD61bMoj/kNCGfxuoRIMfZUbm2G8Vzi7r2Cl3xtga31v9ygF/WbFM3AD1XuJUCHC8w75/Q==
X-Received: by 2002:a17:903:41cf:b0:21f:164d:93fe with SMTP id d9443c01a7336-2236922174bmr117354565ad.53.1740839303516;
        Sat, 01 Mar 2025 06:28:23 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:28:22 -0800 (PST)
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
Subject: [PATCH v2 18/18] bitops: Add parity() macro for automatic type-based selection
Date: Sat,  1 Mar 2025 22:24:09 +0800
Message-Id: <20250301142409.2513835-19-visitorckw@gmail.com>
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

Introduce the parity() macro, which selects the appropriate parity
function (parity8(), parity16(), parity32(), or parity64()) based on
the size of the input type. This improves usability by allowing a
generic parity calculation without requiring explicit function
selection.

If the input type does not match the supported sizes, BUILD_BUG() is
triggered to catch invalid usage at compile time.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Place this patch last in the series to avoid compilation errors.

 include/linux/bitops.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 41e9e7fb894b..fa4e45741dff 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -339,6 +339,28 @@ static inline __attribute_const__ int parity64(u64 val)
 	return __builtin_constant_p(val) ? _parity_const(val) : _parity64(val);
 }
 
+#define parity(val)			\
+({					\
+	int __ret;			\
+	switch (BITS_PER_TYPE(val)) {	\
+	case 64:			\
+		__ret = parity64(val);	\
+		break;			\
+	case 32:			\
+		__ret = parity32(val);	\
+		break;			\
+	case 16:			\
+		__ret = parity16(val);	\
+		break;			\
+	case 8:				\
+		__ret = parity8(val);	\
+		break;			\
+	default:			\
+		BUILD_BUG();		\
+	}				\
+	__ret;				\
+})
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
-- 
2.34.1


