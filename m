Return-Path: <bpf+bounces-55539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9DA82B02
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CEE7B2A8B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4D26B2CA;
	Wed,  9 Apr 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcJpXe3Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4C1A3159;
	Wed,  9 Apr 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213506; cv=none; b=FkYA7zzk8M46re+MIFEzmbt+92iMw3AlRnARIm84OEE2vnpE3yLRf4t9/SFOa0x55U2p9ghbpOenxsqWjCG+vD//macxDxrgYZh3pgX1RinipsvI34bmiS8qfV+leFIinpVaDGT1dhosiezZq4HPty43dbYGO3q7I2FfXFf8/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213506; c=relaxed/simple;
	bh=E5jMKv5zKLA8UMnazOfvbwFC+s6I1bdXfA7VFgo9u8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emSZ58D2OCYf8zYKaiWbHoykA38Z1MKXaSTbHAmtUDSLJWHtuLScOCpwjT56LdW70S5lLhGjf8gF5SjTo1QssEXIT9ZDfaytmcnMvOo0U82zh+S7STFalQWr7/eLAHHnT61aM1PZcEyuQzxJ4VhKVUpaMrAHl988R/vlHo7xr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcJpXe3Z; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af59512c64fso4705893a12.0;
        Wed, 09 Apr 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213503; x=1744818303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU43UpH11wLCdsjhsyHst5iurlQ+ThcWcqMooUtxxjY=;
        b=bcJpXe3Zc3g/0KJD7Bz5m+pEDnJKrvPsVX1yzuPUT2uiQ8VbHF0YD6MlJmDYs5FEO0
         1siEnzjP0wH+1bcwP0aiYbQBHpLOVyI+n+3i+Pmbi151u5ssv1iyOtX6J57s89Mh8ik2
         WSo59pmAZdMu5VqpB8BrB6ChSLjjqU60vqWnd5I7KDWq47Jh1xMx7zRG6OWXZZ/YMStS
         cyEcrFgzZHFTF7O02URPhPs8kft4cML4WyGze0QIPSQ+rYW2Q4dH3DaDNM8FEJagQBf8
         7xpIRekzNjF42OYiMQafkZ3GOVjZzxsA6bmNMEFWEUui+ZSOUzeo0X7YVTSl28d9bCc7
         waNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213503; x=1744818303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU43UpH11wLCdsjhsyHst5iurlQ+ThcWcqMooUtxxjY=;
        b=gcI6wO9D8+znfRX4wnXEYTEJcWlsW7nb6mAuuAFWvjHdSCjH3kcPpm+DLiFd4wlEOn
         X0HkM8lHmA8CWOuo3abnvZWmtP7BcnTOyOVarmX5IpR+8rBHpUTSsvhABmMPSvyOSaEO
         tUrbL0AsotewVijpDWOBJBfFR6tP3UI3auSWExvpAYPh8zqwAyNsJ1fnampAQekf9mUd
         GRMQ3zVqjXJVTDtdJ3jJ6QR4KgMqdW2GMg0s/HHQx+/VR/IaQoQ+5h5/zb4irnttPnhw
         RjQQuDdrelCRel4y0978fzFPhW3U/y5c3rdhoeijznpvO6xlyg/4YZGhcblTeY0Q5J8C
         jqWA==
X-Forwarded-Encrypted: i=1; AJvYcCUMP3bvYepFr3tqYycC4wepIQoJbj89LmFPdosp8bMuS6numXyRSHzPMLQvdhZ9QYb6b9A=@vger.kernel.org, AJvYcCUgVtRR7pgwrTCS2TtHNAoKdez73YP+UsSx/ua2O23qwgZ5kFAo6e2obNv8v9fxAhvgv2ZrzCK/Tpbun9E=@vger.kernel.org, AJvYcCUsvnpeiMp+CnYlSx0rg/Uc83q/A28ivdk/VnxdfP7RknntXQpIlmxDGmfgcjgCEsNZg40f5yvv6HC6hycY@vger.kernel.org, AJvYcCWJqDCIH9GtirD6KdYSXNa/NSuBi2vMM5qBUJSBxnVJksGyRO0INA7bCzUk6126KkatRYe0yia9jwZMnUU=@vger.kernel.org, AJvYcCWW/eH/iZwYVwbWaU1dIpN7exBjjE/rifSa/n1ezG3J1/eNnt2eziVrkJ1ILWnS3ufMyBfHtzc7ogpIR7l4bsM=@vger.kernel.org, AJvYcCXOO+oQIsBCgY8pbA91WKYq83q3C3TIjAb9rz/tDq2AOqowcGOROmAFSn087Y4kYfeBkYsFJY4XFTANLCQ=@vger.kernel.org, AJvYcCXiePU7vrr9Lt3uAKb0igqzeAUp/eVAHKDEWocFy0uhv16/AgyzZHawBnyjJ5uCjwZGYRGgKIry4tNanNWe@vger.kernel.org, AJvYcCXrE6Qo6h+7CmoRKokutOKWvDht1WJ8jPFMn5LwX6lny37ybMtdCqmTSmKTfXGCOHxlx21k5/RE@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLBAtS5F1pYUv2xfAp2nAMzMJoxkZXAOcVMpZ3jaSFhp/dSvg
	7wVlFdzwvRI+DVPK2gzCxxkUNm6avTJeBXSYwFKNe5leTlkjFVp/
X-Gm-Gg: ASbGncsakD7qS+gsh9wgMbQuuftEJLnu/mgAqbu1Ju6zqiQEPzppIMPEWtGXnwaLwxw
	DVsVpE90mXYg71cDdKHzz11K3jkuWwMQnnkiKbhqD9hrOh5N0GSszLMJrij03Y52snuZab9HO38
	MXdJE5SZIW3p0bj5TLRml2Kc6r9qWjxco3ExHLfcMcRZZB4MCNzUoiJUrzxRdNT3QbOWzQY5ElY
	z056slq8eJiMQJvzxF31dhCyVOHktNv7p/LiTyJfSEsRtTO9eExUlAd9JKxFf+8Ph/t+I9OO9Ib
	Pn4k3oWz5XrhXFjMFLnZbkXwjhzHbU5fgj8Hv80mOtHdCMnoGKtq4+zA6mLwr+Du5tWP44E=
X-Google-Smtp-Source: AGHT+IEs9q8P41yMEf/AWjN7idtRUGM7Z4tfe1JBSuODcHBz5h8hVFHXITrRQEV2h0IxkqA/pyunWg==
X-Received: by 2002:a17:90b:4a47:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-306dd52d43amr4827521a91.17.1744213503051;
        Wed, 09 Apr 2025 08:45:03 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:45:02 -0700 (PDT)
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
	akpm@linux-foundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	alexandre.belloni@bootlin.com,
	pgaj@cadence.com
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
	Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com,
	andrew.cooper3@citrix.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:46 +0800
Message-Id: <20250409154356.423512-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409154356.423512-1-visitorckw@gmail.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity_odd() helper.
This change eliminates redundant implementations.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/pci/cx18/cx18-av-vbi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
index 65281d40c681..15b515b95956 100644
--- a/drivers/media/pci/cx18/cx18-av-vbi.c
+++ b/drivers/media/pci/cx18/cx18-av-vbi.c
@@ -8,6 +8,7 @@
  */
 
 
+#include <linux/bitops.h>
 #include "cx18-driver.h"
 
 /*
@@ -56,15 +57,6 @@ struct vbi_anc_data {
 	/* u8 fill[]; Variable number of fill bytes */
 };
 
-static int odd_parity(u8 c)
-{
-	c ^= (c >> 4);
-	c ^= (c >> 2);
-	c ^= (c >> 1);
-
-	return c & 1;
-}
-
 static int decode_vps(u8 *dst, u8 *p)
 {
 	static const u8 biphase_tbl[] = {
@@ -278,7 +270,7 @@ int cx18_av_decode_vbi_line(struct v4l2_subdev *sd,
 		break;
 	case 6:
 		sdid = V4L2_SLICED_CAPTION_525;
-		err = !odd_parity(p[0]) || !odd_parity(p[1]);
+		err = !parity_odd(p[0]) || !parity_odd(p[1]);
 		break;
 	case 9:
 		sdid = V4L2_SLICED_VPS;
-- 
2.34.1


