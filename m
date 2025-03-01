Return-Path: <bpf+bounces-52972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B68A4ABFF
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FC166C6C
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B71EB9E5;
	Sat,  1 Mar 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqOVUYIa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580411E1A17;
	Sat,  1 Mar 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839211; cv=none; b=JW64SOVPmrTzZdQZaYZHniZ5ATmnFGf621hD1NCKg2gHBZ5DbnhRLNZXE9pGWzJtR9723HyUabe8Q6TzxG24T4L3xxbxD99jUFuptcCfk9WcMicwnzrtM6kC+w+oAZChIY4RfWjEZ1pF+bJfu5lVW0gfhlKKlzKFZaM2pdEHvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839211; c=relaxed/simple;
	bh=1i40o1s3Vqdk2RW0JIo3piubrRjz0Cy5aa5u5siB9VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oca3wzNcyQeW6mSPqnd5wN+7/pjiu2JFC7u+J8qgPPBOTbK+77sqgpU5Kxonc/Nr8pV9NYAUUzulg/FBP3KswaFPN638AqgROtZxZo7QCRnB/ByYc2QIRPZFTENsrTxnhSdo5ae4tkFU9ssXwvJ+Nc0TOjtl0HRWXpRupfCScKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqOVUYIa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22359001f1aso67247295ad.3;
        Sat, 01 Mar 2025 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839209; x=1741444009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Bkihj4DGACHQctYAnhtp6nEz1RGAPDBfirVsTzUzk=;
        b=EqOVUYIae3gMpaGYvOBKkUlHYkUTqwad9THvO6MgAXPVm1mLvahNKYCAN+pKq5jLEO
         xjakz7OXMSvZFrtd/O+0DwBZDC/7561ydpV0OssDU+MVdiKOkgQ/AkG1Lo8PS6USzZ58
         C21BqmTXtSbE9VFw55mosgguh94Ri6/xXG9v1DlosQ7F5Yu+m1YpOGuzB+FKR4HmfXgl
         cCCrP0auRgHw/lIlzi9IosDALf6Y0uzyDss0oYJ/VeaHZWkSQ6X0bJU+d8ySTAD4JdP3
         ItLKAQwkjpc8AUDxjwPFI6VoD6DZTKpzpy0rqG3zCyzmvHLRTLAfUNWvoL5ES/M/lvTn
         TIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839209; x=1741444009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4Bkihj4DGACHQctYAnhtp6nEz1RGAPDBfirVsTzUzk=;
        b=D/eXUQjuGoJSN3zUq7Ys8nZOgl1Dy2bZAlmesa+AMQIn8ATwFth3tn06R0GWJ9UlRt
         uV0EbDCUerb2mRTK+lLhGloylRnVs1aSlRO1chG+CnBpUabE6rEHpyh3aIr/60kkU/Za
         ogsgv95IXdTBR19JeliKUM5W5EWBgCHoWYvRvBosHkSWGSBB+fDp8VstnZ7IztsHswOb
         YFnEPV3j+ysHB8X5E8aUlrMZcpa7VtBr9uUGCxWwmpOt8WKDgZMwA5NEsKko22JJZ39B
         QRyo6x+/eEQxJlmKjGlhZu8t7PAF7a22iJ15n+Xeh5RXtwhndrk/n3ga8DCUb+47BIyD
         nefw==
X-Forwarded-Encrypted: i=1; AJvYcCUiSLlUEXRXsPB6ilHN4nCssop1pItraaLuXHguNWs4DYo/VAgZ5RktB3tCBc8qxF7U//E=@vger.kernel.org, AJvYcCV5UcxIG0ynh/TO/OsieaywzpBav4rCo4dE2Be01Iu72P6bBFI/X6u2jeSGDtckFiMD60NRlQdX/+vJp9ps@vger.kernel.org, AJvYcCVRqtgjQK3nFr1FTWldtYO1Z5si6Z36TghBm+S1sfUId1WdyxGGHW+YmBICvTAz+OhMRTDXM/MkGb/A/n0=@vger.kernel.org, AJvYcCWBNeqt8xdshuvAAfbqXc6MbN6jqkZiAAO8XLdXZZ2pzciqZN9w9VWWxi+MPHixi/HRL895fUwuihYmOjk=@vger.kernel.org, AJvYcCWV9LN1J0X4M68+Lyc1qW0j9o5slpLw2SiYf8FOc4ILTioLyi8G8mlZ7oxLbj/zW+z1wy3CWpZrepLWDhH6OKQ=@vger.kernel.org, AJvYcCWoMYPi5Gv9XV8OMwpxmf7cd8TdUKFmviQsUO2j1Zs7bj1XFoKfL86eai2q3IeDWZlQXLstiwkGQL8XSE/4@vger.kernel.org, AJvYcCX+gOJYUAyfkaxTPvuJ3CYbu7mxsFjAztoVXBPZROt6U3GKhvbZ4VhYHacHRWHKuoqIyLaAFpVp@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKhtgrp5t2yLHMdQSaB2G/JFXbd3cY6XxeklgODTPB96xw8TR
	z6yUDR+oDiAJhMFpGzT9kD9MIXBq1WatvdsdIM8zNnXqriPhm5Ep
X-Gm-Gg: ASbGncu4lmAkc3XGyGhs51X8jk8XD7cAgSGJ//VIEoAjtYjsUJJdJUxPJ8ooDOUnG7r
	Jpu2FeRAF5atL56N/NCu3qZGapX527Hp/xlEYwSg5Qx7QaTC9tWl80MarGKYeYj88AxPgvKEwBp
	wuHszy31Lt8hIOTJ+O0K1loEBpfHzI34rV4AocpfCBFHFr1d5oVfY4XekQGSc3NUyETmJBzrjs9
	wvbe6ahveuXJWK/Z9vXayrWhUpQJ+tvIEo3Mo2+/yNr/UJ2IN4QnDyDDBiU07h+2FDadZ8DM/4V
	XFSgYmY1/g4SPwhIFIinN4+lljhP8MSi5ayfi/uLGRWpF4Ifc0QjgGyjXaoz/XdVD6XxzZMANDg
	=
X-Google-Smtp-Source: AGHT+IFGrjgDJrSlPcepaZbcj3TRgBvaEfqqC0e6onE8P6bMgkRDhKKNubsynOimmjCrDvdqjeVQ6w==
X-Received: by 2002:a17:902:cccd:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-22368fa8f6fmr116510795ad.20.1740839209574;
        Sat, 01 Mar 2025 06:26:49 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:26:49 -0800 (PST)
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
Subject: [PATCH v2 09/18] Input: joystick - Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:24:00 +0800
Message-Id: <20250301142409.2513835-10-visitorckw@gmail.com>
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
 drivers/input/joystick/grip_mp.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
index 5eadb5a3ca37..897ce13753dc 100644
--- a/drivers/input/joystick/grip_mp.c
+++ b/drivers/input/joystick/grip_mp.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/jiffies.h>
+#include <linux/bitops.h>
 
 #define DRIVER_DESC	"Gravis Grip Multiport driver"
 
@@ -112,20 +113,6 @@ static const int axis_map[] = { 5, 9, 1, 5, 6, 10, 2, 6, 4, 8, 0, 4, 5, 9, 1, 5
 
 static int register_slot(int i, struct grip_mp *grip);
 
-/*
- * Returns whether an odd or even number of bits are on in pkt.
- */
-
-static int bit_parity(u32 pkt)
-{
-	int x = pkt ^ (pkt >> 16);
-	x ^= x >> 8;
-	x ^= x >> 4;
-	x ^= x >> 2;
-	x ^= x >> 1;
-	return x & 1;
-}
-
 /*
  * Poll gameport; return true if all bits set in 'onbits' are on and
  * all bits set in 'offbits' are off.
@@ -236,7 +223,7 @@ static int mp_io(struct gameport* gameport, int sendflags, int sendcode, u32 *pa
 		pkt = (pkt >> 2) | 0xf0000000;
 	}
 
-	if (bit_parity(pkt) == 1)
+	if (parity32(pkt) == 1)
 		return IO_RESET;
 
 	/* Acknowledge packet receipt */
-- 
2.34.1


