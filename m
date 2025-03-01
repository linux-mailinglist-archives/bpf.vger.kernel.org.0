Return-Path: <bpf+bounces-52979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DCA4AC2F
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C75F1899507
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A81F12F1;
	Sat,  1 Mar 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBWNO6Sn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790641E25F2;
	Sat,  1 Mar 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839284; cv=none; b=YbjkIALbT7cOa5BdB3AIdQMiDi1haQvmYK8/i8Q8598FIQvg8DoW2rkWw14QAGaxwran+e8ai1Le25svcnD61Q5U4IW4+h5uxjVW+iKZxRdriswXCznQ9MlwUhsi+Yvcz3qApNP3zuyAh3zK3UBkM/h75OW+0NA+ALbEKoAp3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839284; c=relaxed/simple;
	bh=AY7VWX2z+11go+VbveW5z1yOms0/k4EYUoJbq8u7HBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmV5xQsF4zZG0fCcEY76Zt/ibVpBfr4hTm0VJXBAWq2gEGzpiGQj2nqEQMT8tlDtImJfJAKDOoJFK1a9hrjPF01il4mGFn8ahBUfGGyjXss6WU1Fv207YP+BlE6I6qCgBmyY4wa2241gSaK3vMApArLHyT9hEymlnymc/N5Tbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBWNO6Sn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234bec7192so28697235ad.2;
        Sat, 01 Mar 2025 06:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839282; x=1741444082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rykqQnwPkGRFwR5KILLeuUxXhWjh1d/Lo2VO4W9LQtQ=;
        b=FBWNO6Snx1vvsry+rVvOfIyQbzzZnOjmni9i+glnNRpdJvh33Mjk+Y+RTU07G29bxj
         N/5TG565se8UPSfjkXAxBlaH6jERY+A0S3YMyTrC4z2BO+CC9gS96Uf5fhMJbcG7rQ+T
         US3DPw51Gl0TtMp9hnXltNiNMasrDzM4B+Pb2ppPAdPZOuKEryuIv/c0EH6iMUVXp4Hl
         dlOJ831EOP/mAikyGv946yjNJsXlVaVO/mWjGUxEsJvvXVqKVPwaTxM1gi/Py/loXY3t
         XN29wYhzq0HRp75ZZzNfgYKhaLK4J23fF6h5YqSXUtQyatt6/uquLYW+LoNyAP66RnOi
         DQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839282; x=1741444082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rykqQnwPkGRFwR5KILLeuUxXhWjh1d/Lo2VO4W9LQtQ=;
        b=GVsmuhk8V67ujAiIuG/rS92kBmiZJfdZkX2lrMKbI5ahZxX/Ug6n0Br/Zl/+SCSspQ
         rf5ftFJlZcqOkA6gWMxNn1nS0P331cthb2fwIIiDrUs8mBfVIeI3FlqApEwrzJiIoqjE
         yHoI8Nvkgtu8aTrt7wjfvmei9/bPriixCBKhFHWu7NVtVdsNlukAab4QZztXWdKRlOCr
         9/yTPSF4arllqDw2xnbnTYiyE2zDHrpxSsy0GXfpLFdX5JetTWu6aBFe8SVJ48Ve4DV8
         Yhq5LD8Pmmx7P4KhjGQuG9iXto9CHHu7P4b7mh7veDAhg0O/bDrCFhAmtWVr7jrQHYEl
         eiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPz/qKndcWnW41ckcQVGG4uC1rPclfChvMMihHeW8q1NXBPvsiryrCLCqhRqP3AZs4gCbGWbbVPe1qZD4=@vger.kernel.org, AJvYcCVXLJUNy5kUKbeUxiHDayJwlHCqfRAzvvJqhnGZ7SyCdjtgidUa7CLREKQ9eRc2TEWWiHP2Sry1HDwoZ+OA@vger.kernel.org, AJvYcCVxM0J62c3AVclPOWPRHOPg+SYR+HDZ0Ly89ld4Qr1lcFbw+TX3aTUhJRNX6k9R2yY7/IQ=@vger.kernel.org, AJvYcCW9F59PgRnCSplwJYv5XekjI4k2VpM+98VpKud4lXj1Pq3dNFBIAOp1a2WamGoy7SGKS1gftUho@vger.kernel.org, AJvYcCXAetSclNVb9C79IUUyUDSYYWsOsfeke9pYn621yIIlZrExYKbzW6mL0IlQC2Fl8Ifwqqe6qlUaB3TyW4jd@vger.kernel.org, AJvYcCXUfBsi2vVWD3YBAqcniEUwgDF6N6Ui5xb2Evu3C480Et1I+QqMYIGy2/ADY7JRXvYnJdTmmfnCbR/zrAq9PZU=@vger.kernel.org, AJvYcCXzF4BPjaHCkeQR+J2qodKuCpgsJshiuPm9qkrSAHXefhdp4kFfydVUNH1ee25Lk5btKtZGtRxERQYi/BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwys9yZVcUWSOxDUpe8EyShdlsNrPH4hkX58T/LAPC5ZwDIRH
	l9uaDJFOkBxjRNCXeT1i8L1IVaQcCkI20h+AYNbWv1f/r2KUR5Mv
X-Gm-Gg: ASbGncsHhXXVrkwgbc7kUUygyzwHuHHAi2I4POhNjQMfjEesTDdtHzX3+IOcpnrZwyn
	4k5PqXkGO1wAVM76TcTo30BOdgiTwtAmYtmHLEl/s0hcL0ggma+4vKA6G+9JIxja5wuucU+vWX2
	qo4x9aPHL+Oh8M7gT1sWEqGmgR/hEhkBc+0r6b2KzAn6zzsQeSudqMJswRVfnOOjufMk/Arv7rT
	nKpovdZtjLVr3q24kky2uEPwLlFSA+iYdzl9CDcMV1UoO+EXL7pVlBkPPjH5ZRG/veSHv2a+x5N
	XVcRHYKKG1ntoaLpEhqaZ0XtNhDGHTFzc1D47FL9B8jbptywSbFm/2QhYH9QwqgQOPNz1LopY04
	=
X-Google-Smtp-Source: AGHT+IE6Wlnx/zKBNSK8vHDH90VpNnFUcC/6AIsKwE//R5+rZAZsk6Mdwf+K5eJJM57bLHOOu0BXag==
X-Received: by 2002:a17:903:f86:b0:223:536d:f67b with SMTP id d9443c01a7336-2236920780dmr123851985ad.38.1740839281880;
        Sat, 01 Mar 2025 06:28:01 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:28:01 -0800 (PST)
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
Subject: [PATCH v2 16/18] Input: joystick - Replace open-coded parity calculation with parity64()
Date: Sat,  1 Mar 2025 22:24:07 +0800
Message-Id: <20250301142409.2513835-17-visitorckw@gmail.com>
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


