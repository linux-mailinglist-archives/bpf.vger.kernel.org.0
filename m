Return-Path: <bpf+bounces-53487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF7A55161
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C881897301
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53B24BBF4;
	Thu,  6 Mar 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmapgEQa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A56213E73;
	Thu,  6 Mar 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278511; cv=none; b=XevklzkJIKA1f/rEN95kHrjDSV4wgA2h2Bv62h+DOmODKxdSayDe4uZ6g4IVVQWOIPcMw4dtIdFlGNDm+9rHo06q5g+Vvl/tjEAxl/+mmiJ8lyJsTxUtGHq42+qo11RoDObHKWcjAMddP6M0aZz2c5Qak8/MBuJ/efirhOVQiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278511; c=relaxed/simple;
	bh=AY7VWX2z+11go+VbveW5z1yOms0/k4EYUoJbq8u7HBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAIV/mFeMgUe/5YPHSV/U79PtfUnv7+RNQIFy9g1VM3BWc5L1Z7GY74MWaAqLyRkfHGqb1k4x+izmzqWf0CEic5w1cqeEu8hNFSpFVDkGuN0Rgplt1Uh3wpuTfZde6HdKxWvfD79MyTFCJBEayNYp1Dq4svRWOCS97WaGjOZ/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmapgEQa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1509220a91.0;
        Thu, 06 Mar 2025 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278509; x=1741883309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rykqQnwPkGRFwR5KILLeuUxXhWjh1d/Lo2VO4W9LQtQ=;
        b=cmapgEQaF5qEcEIHLXtKtyL33ei1GuzNMtrzbzqVTNVQ8DslmbKfyhPwr7utMSnEIp
         PueOlZ+45wYhMqqUjG6ZDT5s9o8IT7I83ToLTi8TYeCYGqOw3VijaEHbFMoJ8uSuUbly
         t+60PpYM1Jbf4ZltRa402jCb/8JrHvZD6qiMdlv5ne6Z+goSW6V33iDMBkWGF4zSm3H3
         q8dAuV6eMo4d47OsOKsJ+1I5y2hTSBbQtPzwQSsN1wW3SM0SpzdTp8NSWU3ITpS/aODv
         +m0DXHsjXHXqCyyk8gMu7urbDMC9u3PIQOP+6m0+9Kcg3PgZszH6VgfeOthKeNdGorF7
         I32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278509; x=1741883309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rykqQnwPkGRFwR5KILLeuUxXhWjh1d/Lo2VO4W9LQtQ=;
        b=nZbt9AiyQqEHVPfTLus+7/o5VJkEqJWkX65bd6dj5fz2/WMXz4Pxef94se7D0Zl0HZ
         gZDnPTwG3fj4VsXqcAl/Hcl+3VuqLFVcIprTdkJrBuO+Y9gNDkF3SFFRL7g2XORALaEA
         NK7+Gy0Nsf2kngC51q4rrhWnnahkTH5nCC0XtEwZpSnZwviZo4fdsIAeZSTKpx2lc0+E
         o9dBQUhdwVJkygHqaHwDNADCbRnnvBZunwCijU2AJCpX7eipP5bP7fUwjVFRzHmVlOsO
         526+f69gJTRyMFEth9Pxqb7eF5DhT/YooG2sf8ZGft1jyzXLkllDAxizPbGO6Ogpkhn1
         ZndA==
X-Forwarded-Encrypted: i=1; AJvYcCU1C8EPX2zJv7P1c/oi3JvLFlpzhsFhdiGWqcF9YLCWkr332wlBzaVOzxwWRpzw21v/+DF0UCszu2CuCtk8@vger.kernel.org, AJvYcCUgrY9Qz/4whB5ovMZ3lCMgW0FK84sE5IfT6RXClIYRZ2FLTKyRMZj+W9AoBvh5a3DFUggtvGEvNSuRG7WtZg8=@vger.kernel.org, AJvYcCUjD4Y/Ll39DM0hyIsfcZ9PCSmXEthECGjVz8/jMwAA4LsXPpq6KA88uR3I2XViCQxS5zifThU1X4s1/kRO@vger.kernel.org, AJvYcCV0xdZPoVuu+yj2y+JWFI0i/EeK1tZbOmq5Aqp4gjt/kLGBGNZ7OHIxlw7hF9q52X3bpyCkCLpntcrhBiw=@vger.kernel.org, AJvYcCWq0EoLrPfrEbK+MA17m2YQa5YXcvzMm7vgH/W4IQvVBQEB2Ex+BNXRjpFLMG4tDkA7UjmeGtgq@vger.kernel.org, AJvYcCXAed1tyaSouJH1saj0As+rVnSaKezOwJu1oYxlely5/GiH6TOmORJ+qdkt5DezDXrdxuk=@vger.kernel.org, AJvYcCXN+V2c42usC/gtq4YyNsYYeW4ZOAypPRhgUfsnKm9d7HMzdyHt/rSPA+Ul4cvN5poq+ff1Mm6EbJw0NDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLB73tnZPr3ZmLHdZUywvzPwsbHejXGhZsvARu+uVvchA/yA5
	RDbCaip7ai43mKnBJTlXs/79isJYNYOIU39FRYL6sapkepx2cdvG
X-Gm-Gg: ASbGnctxCH0Qu6Smhyxjz6aDyUQRfasSOuVs3R50lvkOWmaXnXQG0fzOmmvUvGPHDIf
	EaW4znBXEEXOpxoXm5HRca+H7z36TQ9ImZ7klTL86IkbUJZoiF3Xr/wva5UuzmWCq9WJm1OMgwn
	Ium/s7SLaj/K1la5d/dhbU3oNYnAzfa0SDblyaZieYzLbaaFnztDYSvmK7k1lTrNbgJ1zla3XQ6
	f3UNxB7FIJfDQmHjjXy1jWAmpliAT0+3R7ReQvHo0kbFZr+nrQc4RZ4MBsNQdgr6hTJT2QOC/5c
	o0I62T5fj6LjhcNPdTCzsZjnfl6Z/xxpmq5xILM0ljAwmA0m+eqxBu3hVhzOZT7b9Y4HQyDldbY
	=
X-Google-Smtp-Source: AGHT+IE7CMC10LMwovhBW4tB6jZafU5napSqaqhkL82rznmGKafZamE59+csgSshd0lW2KvQujLljw==
X-Received: by 2002:a17:90b:568b:b0:2f9:c139:b61f with SMTP id 98e67ed59e1d1-2ff49728389mr14240353a91.14.1741278507670;
        Thu, 06 Mar 2025 08:28:27 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:28:27 -0800 (PST)
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
Subject: [PATCH v3 15/16] Input: joystick - Replace open-coded parity calculation with parity64()
Date: Fri,  7 Mar 2025 00:25:40 +0800
Message-Id: <20250306162541.2633025-16-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity64() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/input/joystick/sidewinder.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 3a5873e5fcb3..9fe980096f70 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -7,6 +7,7 @@
  * Microsoft SideWinder joystick family driver for Linux
  */
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -240,21 +241,6 @@ static void sw_init_digital(struct gameport *gameport)
 	local_irq_restore(flags);
 }
 
-/*
- * sw_parity() computes parity of __u64
- */
-
-static int sw_parity(__u64 t)
-{
-	int x = t ^ (t >> 32);
-
-	x ^= x >> 16;
-	x ^= x >> 8;
-	x ^= x >> 4;
-	x ^= x >> 2;
-	x ^= x >> 1;
-	return x & 1;
-}
 
 /*
  * sw_ccheck() checks synchronization bits and computes checksum of nibbles.
@@ -316,7 +302,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 
 			for (i = 0; i < sw->number; i ++) {
 
-				if (sw_parity(GB(i*15,15)))
+				if (parity64(GB(i*15,15)))
 					return -1;
 
 				input_report_abs(sw->dev[i], ABS_X, GB(i*15+3,1) - GB(i*15+2,1));
@@ -333,7 +319,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 		case SW_ID_PP:
 		case SW_ID_FFP:
 
-			if (!sw_parity(GB(0,48)) || (hat = GB(42,4)) > 8)
+			if (!parity64(GB(0,48)) || (hat = GB(42,4)) > 8)
 				return -1;
 
 			dev = sw->dev[0];
@@ -354,7 +340,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 
 		case SW_ID_FSP:
 
-			if (!sw_parity(GB(0,43)) || (hat = GB(28,4)) > 8)
+			if (!parity64(GB(0,43)) || (hat = GB(28,4)) > 8)
 				return -1;
 
 			dev = sw->dev[0];
@@ -379,7 +365,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 
 		case SW_ID_FFW:
 
-			if (!sw_parity(GB(0,33)))
+			if (!parity64(GB(0,33)))
 				return -1;
 
 			dev = sw->dev[0];
-- 
2.34.1


