Return-Path: <bpf+bounces-52978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D51A4AC28
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D063F7A8E7F
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBACB1F0E23;
	Sat,  1 Mar 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvVkLMEv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF71E5018;
	Sat,  1 Mar 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839274; cv=none; b=CYP9VECH9bl7336rPnLI02Q45gDNlAZxPzlPCVHBaLcYP32L3jOIQqFu9/dDRl/02zRhYqDIPsdQT8UMqAOwsY2Y2FTz/TNdLRarb1L1guPGvGbunWnv7BXX+NQWCW8au18FKA/+hb72+ZzpKjU2umvaCQZXu+dSq1MjEEecUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839274; c=relaxed/simple;
	bh=9MLeZfNC/T6rZivDo76ukvYaafOdf3Bq52OJ1FPtYmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZwkU5IxOKJvuoIMPXqcSe4u2d75uI3z7P8L3hFYF0F/dm21g4+aTw45rhtR+u053hTPq4eU19QGymq7q75iMZqV5/JzF467uUh9vJFFve0jD8Czi1T4Z6UHeRMHY+wj+LDY7LMRbKDX9a5QWa7pBiOp7aCQxLTLqERLc9q+d3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvVkLMEv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2232aead377so58833485ad.0;
        Sat, 01 Mar 2025 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839272; x=1741444072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H92cNXD8ivdLBJu7PZvS/WlFHsCPSxa0jaZByFXEmx4=;
        b=QvVkLMEvgJlyLtx3shCr6LLrRTsJbCBYR4G8EmZtrChZe4cgb4oslHhp9s/UjTBRlQ
         fTmDJK0vY/9HvdZcaGrwwUthXhid9T49IYFLwVuyXtO95wZxy3BUVU9JayIvMgrBa9tL
         TWFASl/XznOsjbnAz8hEZHwH/AQ0wL5/3x32JWx3Jj0I971Fp1RK6yFI8yJOgjXjlt4o
         RaW04JX1f+b4ABJ3Y4gfNVt54v+u+Hov3O2hBlh/ChgpvGJSjG9uGsoZ/UO99fRauAa2
         Vbe3BtKNrH0tzRM97mc2Iyw9Z2sqk7sx6Xabs8Bp9XXdCNAlAtMGkC+4QQqaWDVZQZ83
         o3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839272; x=1741444072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H92cNXD8ivdLBJu7PZvS/WlFHsCPSxa0jaZByFXEmx4=;
        b=h/SIfdWMPLqPVW8ji/eQgpbsGbw82PcnMQzmZyaw4UiMK2ooLWFxGHLO9zZSZbMqpC
         6OCmN/g89uOF2IvPD07wqZ8fv6Z/0SNzhawN1NxHc0YD6L3eXUNFK1Y/U6D3SYPIWJin
         0f1+0jNBaqeo3+UJCWX14oiMzpjgnqJR531r18cc3qbuJ7/wh/a+Bgx0lhUvw6oRNHrl
         PQROkcpI5omGwTKYCBph+EQ8muJIV6rzPmcs/dyP6xjePlXywpWv3n+v+Aoj/lpgZC4U
         +sh5sO9k0h9fU/QY/Xg+DQjiRbmYgJ5c1ATrOTH5G0K3DKcdGHrEoZHNnecJ0i90Cgt/
         /5hg==
X-Forwarded-Encrypted: i=1; AJvYcCVal4iWnpU5gzCL8Pv6qeiB7ISxo5AKVI2oCKgBo6xBBj/FUYFNrTiCnTCiC9JQmOa+1RoF/3x/EZauGPY=@vger.kernel.org, AJvYcCWrVHarMCHD58cPLlq+BokPHua2oJyFLohsDCDyUVeRT64ZLabJsbF4gXbAJvgHq+eCJTqMxXSXWSGPkPGJ@vger.kernel.org, AJvYcCX5xCkWd2ZK5dvd8MOww3kAHkcjbPbQ5qW/wtCgDDgCZW7gXYByMJqjnBdlf0JOC4KGFaVZ2T/R@vger.kernel.org, AJvYcCXMC+rFarXTlwGEGaSoSDNDGYdWjZPM1+dHiisIR8kliY8akWCx3vogjHh+esXkPJo457UTGliak+xMyPVCnHI=@vger.kernel.org, AJvYcCXSzIQfqnKmrpZggmSDyK9QVYNvse2Lw8ULvOmiJrfGEnCdiiZiXtWFwa1PIppMn5U084KerEyro0NnlfAo@vger.kernel.org, AJvYcCXV1r+4geeBLkEYET42QxMjjbsH9BycydvROu++7wbhWFh4x23kGXkbirEtTb/asiNBYy8=@vger.kernel.org, AJvYcCXhdF4vVq3Msw+EVYcPyFknH+mZlQrM/RyMWlUFOoI5+U+pLbcBQOeL56jfbapw1tsjahtuu3iCx/c15WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcUNB5tp0/GBBRi7HXCNrIw573XSmoUfBrXomYSCJ27rs7C2B
	RwHWYlA40VbXAAcuWhHkasyqJIuvqcxCOvOeWP6snLX5cPBKqrHz
X-Gm-Gg: ASbGncvlsyv68J0dvPUxgluqsdGjR9DwBv8qMQ6jOP0bR2xMdHiGR3bbE8yC8bves+C
	c+vCfQKiIapOh1VyZZQHS+un5mcrw1fAjC/eKNEHQPVV/q3aE+WcWlUyJl7fwsEJE7TQaevM91h
	3111X3D6qMnB/W/txGTgcLanRdXQ254vbb7/1QyNn8cXbk/PZSMpGoFT89fKseGkeLt0NMmMK2H
	25bGp3v5m2kr2G315xEcAUTijnDjbAP93dtxpVoy2ZAvjXQVKJ8Z+YsM0VS9A2YRC7RlLepaQ7s
	E3Sk/sJMF2WSA8Aka52+J9nYr5ysKACJQnTNZYm2gQncEOtnwGLKEOFMPrqe7ICkJesq7L2OexI
	=
X-Google-Smtp-Source: AGHT+IFJ7v56//ubfe5SZfIgarRaf2kt414B71bZC0lL5Jm/hhEy1S8FPvdkgRl1jpN6UW8NLO4j1Q==
X-Received: by 2002:a17:902:e5ca:b0:223:894e:4376 with SMTP id d9443c01a7336-223894e454dmr21360135ad.43.1740839272112;
        Sat, 01 Mar 2025 06:27:52 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:27:51 -0800 (PST)
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
Subject: [PATCH v2 15/18] fsi: i2cr: Replace open-coded parity calculation with parity64()
Date: Sat,  1 Mar 2025 22:24:06 +0800
Message-Id: <20250301142409.2513835-16-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity64() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/fsi/fsi-master-i2cr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 8212b99ab2f9..8f558b7c6dbc 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -44,15 +44,9 @@ static bool i2cr_check_parity32(u32 v, bool parity)
 
 static bool i2cr_check_parity64(u64 v)
 {
-	u32 i;
 	bool parity = I2CR_INITIAL_PARITY;
 
-	for (i = 0; i < 64; ++i) {
-		if (v & (1llu << i))
-			parity = !parity;
-	}
-
-	return parity;
+	return parity ^ parity64(v);
 }
 
 static u32 i2cr_get_command(u32 address, bool parity)
-- 
2.34.1


