Return-Path: <bpf+bounces-53485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD76A5513F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EF16C10B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145C3242920;
	Thu,  6 Mar 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngXGqIxt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59D24169B;
	Thu,  6 Mar 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278489; cv=none; b=rxEC6YOouXNYaOBjbhtNG4RcN2XeHwWZjvuuIkScDUiHX3gbpSH5rUPOrC3L30nr4eitSQNs8g7rJskB3b0uie/JBPNZVWSbPCWS5JVSYHPQu/1M4qkwYqqUzV5/FIvW+VTAzL/Hsy4DgO3YQRMIC7q7y+MhrMKH5tudWubxhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278489; c=relaxed/simple;
	bh=Qq1cropLpjjfwJogO3hvfUuoIiyYZmalJxfQDmrzPKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9kpZzOqss5ln/wzOrNsqw16zQEHeu906XtaCD+j861ZbjEfN17bsaXGBdHMoZCWOjJb4IBvKeUrchYsN2/H44hBM/W4BSdpwpo4zLMqL6gt3elgZA2AWLzgWlHpDGy+/Hki1Cn1lQl27g3rhnHOEVWx2I76MIBonaj+uoqZSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngXGqIxt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso1373747a91.3;
        Thu, 06 Mar 2025 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278487; x=1741883287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVzC5eNDjiMbvhvqlOK1r/73KNx64ddnKPcxwil96xE=;
        b=ngXGqIxt1qZdGMNKLgTzsFd7FveVzn2qCzDCvfuZgnjszpFrR1/bGL57+6bRgG/Zi4
         QFKU8zFZisfuuL+NmEL4JyRzNpNWFLaj0LDVClrKoYzTnvoj29q9SVAngmEwSdV7WREg
         z9OHgHPKy7WwgQdKpfjFOM3fb6fGuAs9vgh1ujltlA12axClNYBRcJsiDVHq+ij7IUZC
         mY0RiazFvmBqLzv7oZ9VOSTwRMCl7jba2ftmIL8+22WLiE1BsDql5XbMJD9k/exXB2q+
         5FJA2Gi8DaSXOESBKKT5MwWKnAkQYejNXbG+xl+CUuz2pBMU9K4axXng1EBm43vKjvy8
         BaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278487; x=1741883287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVzC5eNDjiMbvhvqlOK1r/73KNx64ddnKPcxwil96xE=;
        b=ZCCAEENeGJow3teoLeE068f/n7bUBVZ9MVac/ErZyAGti64OFTuxDGK9vfSUi3U+rP
         WfpNu6RV+a53kcQd/L5XbxpJg6OZwAsaxYaHxAJ45QxByeHrVg4HKkDZsBZsysuJNs8P
         bv56H4s4VlQFJAmWFTBVTe4hOPcplrtFQomQ3WibNsCy/nfwail89xwVhyatVYMHUjLp
         gs/xuWMw6o2F9F4sfj7OaEviVAehLUSsEiDmTnDGKWgKyu/prItm9mqXWkxbKFpSsbZr
         rHPHqznK2vIzVu1FTW1C8ThKHopM2Ixp0/OuWWXsq5Hf/hMoA80IjQDixntPy79h8JgG
         uHFw==
X-Forwarded-Encrypted: i=1; AJvYcCUYj4Z0C20mWIEkzBOF5SZoAiVm6v92sbYbJfQHvgN8ka+pSJLjhJP5mL3A3tq7IHTQBBTG3Z3LN8q/zb8=@vger.kernel.org, AJvYcCVanSNHZCN69k6Lpc5UgOTY011ywoXys6+vQ73C9JnumEqhJrELWyRKMztZXIchlfI7lKIwPPNqDXzRWYM=@vger.kernel.org, AJvYcCWHkMCeNdSG9DX3ebNRwgNt6afs/PsOwUZqCcvHhyVSE2IkRWJACkcOfGeF9Z7+5t3eZBcFUC1z@vger.kernel.org, AJvYcCWQSA0Bg+/xQMY9ao5y769wfObadxJYlcgqGorAyHvBE0gkhIx/WKPNDIA4Uw99e/NDtMT22Pz9Afh60L61@vger.kernel.org, AJvYcCXHHyNGjYy6Sp4l4X2vuwvP4Hqi733P5PyiF6ud/RxSTAHM1Jpv5GbkpS8H1wu7V0gyPis2I/aqZkaRHfwldQg=@vger.kernel.org, AJvYcCXW3htD9NmasCUzd54uW9EKScI3PxoDQQPbFSDgEF2EyLWc8r2uw/mLgBNPkhu04ljBtFc=@vger.kernel.org, AJvYcCXeX+A0dPxnp/IOREP6aNkp9ixrqPn2LLOZ0Y7iJgExEEX285RNwkv3fXdLu7TvNnJDlgih9dWBeuwzv/Nb@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIzQFo/LUXwjp+swDGGHSL+2GDE2KUwhYXP5zsqPL4/lRyidP
	0QFLmqAFIVMAwuf9iZxU2vSu2NcHEjxxyFfc4n0cFV2LzFOoj4ku
X-Gm-Gg: ASbGncse/DjEZIpU0YuwsDwQ9KqZLSoKI9MOVXZYc2edAfn0xixGim6BKXHv62oNBFP
	qMgFteqtPJNuWr18KrQ+hh7EczaLahiNEGIDL4zzOa0ePBqAInx+CkP9pYg+VxwRlinfjFyFkam
	+Z23g115Vokzo8hRZk4mPALmrwPbp/Q7ZPZLspOgcrrWefsn+FFpn+tJAgeUHXhsCEqZj4dyaAK
	7b08ldPUYG3ae/zdWlyx5lJPXjth77TpRx2nz5z31ZvZ134OM6tL8J/3tpWxMwsHYfDShb4ybTP
	LMK4Y/7u0F6KlsoBSQJASzepuLLlmIKiYCx2qCZBWJbeI4voEAYIpN2N/CrBpd4uY4wVy6Z8FQI
	=
X-Google-Smtp-Source: AGHT+IG1hUiIY04WmIWjSTraivZtBZJVGW/maYZ4w8gjs57Y/NbYWELqgVEzi3PK9/fk5EW05X3DDQ==
X-Received: by 2002:a17:90a:c108:b0:2ff:5357:1c7e with SMTP id 98e67ed59e1d1-2ff53571ccbmr8979955a91.20.1741278486674;
        Thu, 06 Mar 2025 08:28:06 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:28:06 -0800 (PST)
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
Subject: [PATCH v3 13/16] fsi: i2cr: Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:38 +0800
Message-Id: <20250306162541.2633025-14-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Change parity ^= parity32(v) to parity != parity32(v).

 drivers/fsi/fsi-master-i2cr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e5..46511236bbca 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) IBM Corporation 2023 */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/i2c.h>
@@ -38,14 +39,7 @@ static const u8 i2cr_cfam[] = {
 
 static bool i2cr_check_parity32(u32 v, bool parity)
 {
-	u32 i;
-
-	for (i = 0; i < 32; ++i) {
-		if (v & (1u << i))
-			parity = !parity;
-	}
-
-	return parity;
+	return parity != parity32(v);
 }
 
 static bool i2cr_check_parity64(u64 v)
-- 
2.34.1


