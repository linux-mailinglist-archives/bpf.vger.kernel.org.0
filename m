Return-Path: <bpf+bounces-52277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B11A4101D
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684F517955B
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9D1A83ED;
	Sun, 23 Feb 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRhAXjA7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD11531C1;
	Sun, 23 Feb 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329073; cv=none; b=OueqQ6RorAyDLuhAdVwG0RiB8xX1OUNr2xYDq7b6CfbD4K0mG8IEmfaOOvLnfC8kIHiGqIjU8UaE0dQB3leX1rqiVmP1r0Udarzb15t9u2Z5RdQJhWo+IIWAF10ammFKHuTKF97dHLEfFy0XC9GkzT8NCFr3ksNRR79YA7QY7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329073; c=relaxed/simple;
	bh=1i40o1s3Vqdk2RW0JIo3piubrRjz0Cy5aa5u5siB9VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkYtLeQFPDppvDtWI+YL3eQl0EM9nVbjll91kFCR420UyXJ0nYep0jvKpgVCrver4l8oG97wlX+wBLOITu+DJ02TamoG6FFmXiAMseFG0b7Mfuc7XuwZhlZ2Ew5FyY16IffldNwjN6riEn5rs+ALoebkulW2MP2Wusr0dksxJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRhAXjA7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-221050f3f00so80332535ad.2;
        Sun, 23 Feb 2025 08:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329071; x=1740933871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Bkihj4DGACHQctYAnhtp6nEz1RGAPDBfirVsTzUzk=;
        b=XRhAXjA7GIIjo/so54SLubNoMOdOEZ9HRBxyABKpkrXMVKgpv9J/qMsgDkdSrvWsQq
         z8X6Xw2Fr4BmTw7yjknPdPBPLvRVFaS4OeVxbaUHTyH5CoqhOP3kuROPkc5r5wbtkBsl
         m8+dnb5aoREz+oD+KweFJ87ZwyvwN3pJKCUKd/wFc1KqGilDubXqe2pc3yeh8KUi3/uD
         qX2KOds14Q4KWM+V8BwawX9RkHfbQDKWeIg2QNWfAShfPHEyqbvd1RJ2k6SSlwSYio67
         aY/3QyVeWPFvWLilP9nDXHz07e2YSNRBwoHQGi3K/F+I2Q/J++QNMV1Jmn0PnwBcIcSu
         m0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329071; x=1740933871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4Bkihj4DGACHQctYAnhtp6nEz1RGAPDBfirVsTzUzk=;
        b=IKEuV4CHwzfntAWgP5fENz4d5bwZrx/7rjkGUN8zItkJhVdM33T9EvBvcIBRExNiXx
         AHXGMIY/8JyWV6+rAWvOPhNzaabAhdJsQjzJWmC9cipnlOcdSr79hUp/ooe+FagE6nXH
         JO2rxftBmyCpxfdkkS/ehoIB/8V2JXCYWja9/Te5UGdhABr4wNELhoHXHpMIZRG4FTBN
         68Gpno9u7Fyxk4SVLKo+wXMuMwuVqPZCIl2/mja/r6LGZLRcBGlw7+j6bq9IIzyR7HXw
         vNac2dHND1ZaD3h7LLo+qtjhrKTbpfk5iTFH9ujYr1W1+aoTsPvFawyPaX0/9WZdcGno
         cL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDomqQnCRtSw/qLI9ZKpSp0r3A580v4t3okMU22EY5YZzfmVKVP7sMSmRW+OKjI11raDs=@vger.kernel.org, AJvYcCUuQRBqo3tjVDbfPJ/Q2uk5ovCEdrBXS0tDER8/+G+gcTZfdSyuWfrUeF4fg2ojE/gljWMU4lW4@vger.kernel.org, AJvYcCVIZDq7Ar3DDY+H2MWNtvhBikMQRZGPS6oEIfKdjLMC5JzQ6tUZkrOHZ8RPy7c+Vqhxa3A6cg1M5C+hIXCU@vger.kernel.org, AJvYcCVhjCxSGJaAYWzhavLlabHvIS7dXz/MJc3tcsipfJcTJL3wxk4MA0RB5sZe8FoUfjw/so7ryaPkwuKffCk=@vger.kernel.org, AJvYcCWJ/Lc4Abzimi0d4PElNWrrG1kGVNi9ntpoPfIpVN7uMDus6fBqiYAW5cxn8ryW8XEn7znOqJI/sMYHxfPd@vger.kernel.org, AJvYcCWwwUWLiGEJFVjv1Rac9ItWtBRS+mT0/n/TN6y3XkeZtxRJJBxkMpRgYJcU3rIDj7Wx72t1YE1nTGmbhwaqcpA=@vger.kernel.org, AJvYcCXdCxQUmPw3lTjpuxypsr/RhhxlS8leRjY/JRLiguRW3S5BR3DRuwMajlMyXCtKu4J62p0LzsUHtyH6IIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynK9uJnyb2pOVQxvq/Jafk8DqnLRk7TjWJL7ePvSof9Nv8OiWw
	YoBDwefppytUvwOD9vx+oen3kUOnTu4RdmhN04PfPQTQNe7tgoL3
X-Gm-Gg: ASbGnctnXnCvn/Qz7lWFOjRrM8YNXxT6cGVOxK1D0BJv+U/bcN3VuRtqwtmL7kOCRRA
	NrYf6dXQ0ti9LfPqzuAZWgacs4apEZ550Mmm7HaV0RpAVG+NBQSB0WP1ttS2aFJKnUFCBt+XaDb
	ZuhUpTvAF1vgJuNPPJeVb4hLDV+oKjHsqsYWw7ceucAbPBsdCP95CBwUvr/6DHUbI+HMh3LI1S5
	R1QFhu5ZPO2ugdnThFxSz2SxV3zmlJlA9RMrNWNbKoXEILY8NCJi3JCB6A393BzqKWawBf3TTGm
	GyMrkPvYqlhH2ov5eiGaaVNTlG0r2fLilGSEHf8GwJnKiMY6GSiYCSfp
X-Google-Smtp-Source: AGHT+IFqMPtN+gPmr77Z5+UXqcepcxQO5H8AaDoUEcywHGCumZ53dM6PMFmuD7xMrlzO6YmaaybKmg==
X-Received: by 2002:a17:903:2286:b0:220:cd9f:a186 with SMTP id d9443c01a7336-2219fdc2dfcmr186405365ad.0.1740329071014;
        Sun, 23 Feb 2025 08:44:31 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:44:30 -0800 (PST)
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
Subject: [PATCH 09/17] Input: joystick - Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:09 +0800
Message-Id: <20250223164217.2139331-10-visitorckw@gmail.com>
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


