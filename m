Return-Path: <bpf+bounces-52284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A0A41048
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1033C189BD98
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80420E028;
	Sun, 23 Feb 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8AppjX1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB6137930;
	Sun, 23 Feb 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329150; cv=none; b=sMjG86hZ5lDwKeHYpc/tOGsq3SYTStzQzzgbPF0kNQM7I0lw+uCSbn6qgf1ObssRVDrHMNvn6LLjColZHAwjjiChkoe0/+KCdYhWoDZ+E3fdID5GPa8T0C/Ahty6XFeac9ZfRZNP6CK0vrmsW5JS3lCawfq10mgYoRLFo6if74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329150; c=relaxed/simple;
	bh=AY7VWX2z+11go+VbveW5z1yOms0/k4EYUoJbq8u7HBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adpufmmXG8C3XdI+e8/g/3QT8UWr32r7d3jiDZ22GmARMOC4mB6IJXfXRQpneC4Z6qu/ENO/iWEJii9Sw/EXwXpeQr39OQB7HETXlRyiwRL73LPhDHt6w8T90yycsINGLU4OrrGGgB1NvGph7o/v7I66LbtK5C6VN4IC2OYZIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8AppjX1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so5837975a91.2;
        Sun, 23 Feb 2025 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329148; x=1740933948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rykqQnwPkGRFwR5KILLeuUxXhWjh1d/Lo2VO4W9LQtQ=;
        b=g8AppjX1q7orQDA+2QKzU3q7cWnXKqgNb0wIbRdzynsL5tsiw8tseGPc26/YAWKwQW
         gpyfFFt77Jxih32U1zytNghaN+NkZLdXbzZgjiNJJpiKhzAxHIywImsNbrjGEZN0l9iS
         ss+dnkXKn1NnFjh/oyBB6FJz49L0dYBiSppy0lHVWMGIf7CzSE8KJ382KbHfsOxDySYH
         h/oHNjtdoMWVWz4RriaMY42Xk5abn0rd2c/XjZy7JBzfazux74dnzzGxkvr9c2xBSQMQ
         tBHce7g8v/7UGy7hEw0JSBmei0pmnVpGW43jM0IJcv5YIo4GDjH8ccCdinu680tmuf2z
         kWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329148; x=1740933948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rykqQnwPkGRFwR5KILLeuUxXhWjh1d/Lo2VO4W9LQtQ=;
        b=c9Hj8ATAU9JOCi1wfP/st6dQhwgCmWyGiwTjfAzm6BwfDunvZAB5ZyABbNbqohJfNw
         hjI2+3veGR0D3eQwj44As64PdH3yxp6JMDY+naZeG0BFjsrtpR0VUgpR1Roy08aBqXDY
         xnoZTtVZHNzyuaoOweOdAYXWvJNwG6gRtloxWOV3CPsza400Rwf8XKp8Mk27TUUvVdpF
         rLmBYsuqW0abEBnNuVlYJlsZV+cNHDldKZxZZn+YO+qZkYL6dc50NjkJ1vE01saylCht
         ksZ9VIOCqtIdaC6/+TUgQrpaxSeYT6Bof9D79ZuXDTm0zSS77NHB9NcthrMDJNr9o19S
         881w==
X-Forwarded-Encrypted: i=1; AJvYcCU35m9qzcX/gJX9mKiHpZYjI+846ytMaEt9bpd3vubk1oqBre+PAgOwJU4+g9SyHwSN5BXoWucm@vger.kernel.org, AJvYcCURuXKfFqgS4ngPhla33efARqpxb15U8lcK/tjbR4+uf2baJRL5q7rUaN4kzOv7Z0rnDteI76ykkWnRTwc=@vger.kernel.org, AJvYcCVbw20TAQTMJC+Y0btKxAAthvvV+57A4P4fj/3ICDffKkAPc+Df+yJfMnuH/1jTDLyrTWI=@vger.kernel.org, AJvYcCVq2bydlecAZYAFkpsCqipRqm515D/y+JLAtKi3FHy+KjrWAcrHGwdooyfRTYPaMrABO5Fxr2QqASbDeAk=@vger.kernel.org, AJvYcCWJiFv35jBPq8WW9o8/Coa/VTaKaCojxlMGd//niWRgoY+9ObyZJNVx2OWtBWeWZh5D0TRzQhbfhF7R9453@vger.kernel.org, AJvYcCX6YNFdtLYBoJY1wQMyV1D/b2g5xylM2KgQFdvPF+HRMJzWwVyQZxy/ZqSl6OCRGw6wK6rplT2ngUpTKs3K@vger.kernel.org, AJvYcCXpPh5qVHV6cqRgxGXlhzRc1uLCXsBWfMiH9SLRfTbG/1zpSeyqzsL7i/GMpmR7oRxJxiyTKrMaeoaDjSWhPgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7ogc5cXaB24k8UUMzJR8PZd1joNMpVKxS3A6vkqdqaoQWxrX
	q06IoPUmcui+FKuOXwgElrNR7D9Lu+S0zwPWaROPlhF+eoVEQWiu
X-Gm-Gg: ASbGncue435tB+uzrGzQ+M6U/FRUBUztXnnvxtHQJImnN1aP0O5eMFaNZ0CEGF5+bqd
	0owCpuDy4E+6H9zTZpuud7KYaoPhsiSW+RWJVyzq+UmD2I/b8Hbdo47ugL3ehcqUNS4Bol22b24
	hyawPXOXcTjHdR8l56Cyr9Z41JIk3U8ret7+qq5TUionyqwUMK+1ozcALmBcO442Yxczqi6qLHB
	HP2apy5hfG7oYbJ5FPRhk609byF0r2deyCXkCq6KrsZLJ+9KxcWeMoAwGhO6r6+jva1cw7Arhq7
	W7tDciTXhIeXlbA2NRnRqhXEvNFKZ+AJgtS1PgiBFjj8OeTpUyfj+6C1
X-Google-Smtp-Source: AGHT+IH16ghKmcmHU0dMEzazIh6n32euSF7ezcTZFrtw55Mtl4npk2uitkdtvmkXgShJlJHnv8p1XQ==
X-Received: by 2002:a17:90b:3c03:b0:2fa:12be:f16a with SMTP id 98e67ed59e1d1-2fce7b43488mr17785880a91.29.1740329147892;
        Sun, 23 Feb 2025 08:45:47 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:45:47 -0800 (PST)
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
Subject: [PATCH 16/17] Input: joystick - Replace open-coded parity calculation with parity64()
Date: Mon, 24 Feb 2025 00:42:16 +0800
Message-Id: <20250223164217.2139331-17-visitorckw@gmail.com>
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


