Return-Path: <bpf+bounces-52967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF6A4ABDB
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E357A7AC2
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278021E5B66;
	Sat,  1 Mar 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJKxB9Zv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B41E22E9;
	Sat,  1 Mar 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839159; cv=none; b=mBE3ud01N8U8GhNsqtVTxXr0crBoRx7OPp6qxPx8e8wt2dmOczdz+/8ea8wqpB6dvaFnlczleGGRPagCrkljMykCVMD+9qZhn6A5NJrsFxs0SrMt361lYVrTBNLn0m+CadQASexVhK1HOHKIyFipbPpc1nY5mxugV/6ccjC4VVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839159; c=relaxed/simple;
	bh=rTA+nqUh4NnBYzrIs97e5P2aMLuYYBuIh+2ppv71b2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9JNEpwZyB6NeXNgFSQbkCQR5ENDSkKpIeRA/6xwReky2twlTe1a7z1coPnIVZlNNWJ5lPi08yQb//a9vdarteMwhHTw773fkugpugIzzvBDjWzIWLTZBBCfE8K+KXigifMW6cA1m3LyUvg0HsIiC9jMeqJh07yqszKV9IPOU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJKxB9Zv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2237cf6a45dso15931215ad.2;
        Sat, 01 Mar 2025 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839157; x=1741443957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nutb7MJ9eZ82YUrFszN8Vow0UKyoKuoqD2og5G/xi8M=;
        b=BJKxB9Zv199AacJJDPOfJY59V2iVe9PR4WGIJxde5YXxX+B0EUh2izRZmooUJYDUtB
         KaEO+F2ROJBt2Mn3CeK92UwXkRGHXzmSeEA+ZCrmhXspzckbgbw30STWaA5zy0nFADu2
         31IOtHlFsw28yPtMudn9ZLGaUqO7+/9mBmaBS7v/86+XTFRXTH64QnH59s1tc0xxiYIM
         /GZpYID/BsmUrNFPsES9hrg1o0FCFugYBcacxcA7TZr0Mb8VAlDWEA7Ex5+cNq7r6cuo
         ThhpGSvpOwmoSaTANiZCbaPNxcfjRw3wBP39RvJUQos/B2qICWFOTmftkcJ4a4zkbCB0
         Ua5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839157; x=1741443957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nutb7MJ9eZ82YUrFszN8Vow0UKyoKuoqD2og5G/xi8M=;
        b=BIHLNPgbT7fbwwTdn60XkZj3nU7KHEulyHujXBVBAAO4idYyaLyzO44fSUcQIbE8Vn
         t2dPF+f7oIhl3gh9/pk0vCGzNoLgOjpT50Ot1/5NAwN288Rbqhpd9P7SKqNYkIGEdR6S
         T4jL71HafwVKMq+76NO4VAj9H4ed8LARIGXpYe09pwrrr4D1iOqnXKGxceIomOAR2gba
         V4GzfjiCZzHgySGB3rbfaCG4EephVp7wesBKt0mBTa9kXHmi3EILVX71r2YstLiRJJ6B
         g+obfOST9ckxfDer5EprmrxmSo/VU4AzKeatX76kFnJ6Qx/oiR2fpjxtp6BR7hUYOEar
         Mh4w==
X-Forwarded-Encrypted: i=1; AJvYcCUEkVayjgvICduQw6KjUvEGZSWvxGeRTk7DSYXtqO3Jlf9FFJbT3cWZ1FRCOx0bvkRUM1ZyzlFJAdJ5mFe5@vger.kernel.org, AJvYcCUPxmXYMupY3NF+WGw15AmpPFfpgzKFMWVIwAEgIb08r+Y0n80F3Kd/PFgLUcON2ep4g9JEcNS3c7a5dsSi@vger.kernel.org, AJvYcCUVhq1Q51GDRFfiGwVq+HmajHP0b37sFEfx+NUx/f3UNsbTUZ1SxZiwC2i3UwRkQk92FZZn2kxNKBakiQU=@vger.kernel.org, AJvYcCX8nEjD54aqEGgTZtcDCXsodUB5nUVlHfJOGHRHLHqJuy1QahJOFBqExA9hkXd5pajoHYZlxS0o5mYpzBPdjHg=@vger.kernel.org, AJvYcCXWBGLrNvbo/6RKuV2zMaEnGSZI0lmsXS25stYt/ieFNCgGCGQnG0PYRWH4bpF0QMWKYzo=@vger.kernel.org, AJvYcCXrW5OLSVa5IR0i3+ICqy7weHyJR87U+8b8Y8p560TzOTqmFm+HzHHQaqCjsaV7cepfv+HJPmzt@vger.kernel.org, AJvYcCXtUmBS9laDot0cc1k+F/xyUXZUxmmKvMuMiXQH8uYdzkVi/UihvU1Vq/H9PjzYkWk049550wFD6WL7YX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydp/Vn1fDmHhu7q4t8ieFBBLXhNQCHym1TX+4H9rIPS/WfqaaL
	YIlHIxCpcWxyNIqINO8sbZ+tzFIR4H/Opj8MVCkhx8p31vEgpoNx
X-Gm-Gg: ASbGncuzvbtKOupV2mdklK5vfSr8/8b9RWcHEvHmGcQt6ULJt4/6pBPdqBkPebDYeH9
	Qg8s3Alj1K9yYWR/s3793VUNZ+zhYzQCbECmVhb4u0zy10CWwMpEnJQhAjaVyaBHpMHQ3ntvAuO
	zWD/ri2v5WoiwbqmzDDP4uApu4gGYgBd0edz4/zsDJQbIABdVbJIVb4AQyKIaeF15NeOmz2kUTA
	G/NOyIg7RF4AjucHX1f5/6AqE7iD5QwH25NM2MAgHNndS/NhgMq0VeChABJi4h4DgcxRH+nQVvN
	T4cjOf3h+Q0qh+cYS9bd4jqxwfvjq074WOn3s8XY1oUAnK7S6S3TemyxmjKNvT8c6+CaCptGWAo
	=
X-Google-Smtp-Source: AGHT+IGPradnOrYoMR1IanWjYjFo3KQDnHNjL2IS+TgfZGmLy7jDODNM73AvbKhXyZC7rWPMMIa78g==
X-Received: by 2002:a17:902:d507:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-22368bc6ae3mr104323495ad.0.1740839157468;
        Sat, 01 Mar 2025 06:25:57 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:25:56 -0800 (PST)
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
Subject: [PATCH v2 04/18] media: media/test_drivers: Replace open-coded parity calculation with parity8()
Date: Sat,  1 Mar 2025 22:23:55 +0800
Message-Id: <20250301142409.2513835-5-visitorckw@gmail.com>
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
 drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
index 70a4024d461e..e0f4151bda18 100644
--- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
+++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
@@ -5,6 +5,7 @@
  * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
  */
 
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
@@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
 
 static u8 calc_parity(u8 val)
 {
-	unsigned i;
-	unsigned tot = 0;
-
-	for (i = 0; i < 7; i++)
-		tot += (val & (1 << i)) ? 1 : 0;
-	return val | ((tot & 1) ? 0 : 0x80);
+	return val | (parity8(val) ? 0 : 0x80);
 }
 
 static void vivid_vbi_gen_set_time_of_day(u8 *packet)
-- 
2.34.1


