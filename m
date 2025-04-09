Return-Path: <bpf+bounces-55548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65012A82B88
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778261BA2190
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29FA279338;
	Wed,  9 Apr 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSLouCSY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CE267B15;
	Wed,  9 Apr 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213617; cv=none; b=ljnHNnrBYdUv1PHmVo+cBLwCoVrQ1IKajXr7P+Ec1oYEOq+1fR/kITmgDsuj5R8j9lo0K9vJZmm8BqPZjryNf4Ve2wkvw0wC7KyKg/MFVWJYyJLcaGlhpc1StwYyfojGLlaTlVvG0ueU+IJX4VVj5PUE09NsA4qsyrM2xiVJalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213617; c=relaxed/simple;
	bh=X8Vvsxqf+8EVtFmpaknjrToXsmDQI1ClPOYdeJUSaXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjYJiTKBh3NcfmapDDOo8BOAA8c5sTaKTHmWqxxRykXkZc0nJTpQVz5/LcvQHOzLCD45i/hMv+splIVlQxg5AXbblZ4XpIcN2TM1WCVr/Dlbk2Pa1SGih9V3+mzM2Im25ZsWVmnzJ66BAh3nlndXnuvKoa/QgFMZjhkikkc/YK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSLouCSY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ad51f427054so4793613a12.1;
        Wed, 09 Apr 2025 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213615; x=1744818415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmHMxU2w78+CVBOj7SKK51/xntQtWaTeeSMBQ6WnTFU=;
        b=iSLouCSYc7YlieviFnZjaNIJ8Oc4LB01ee2CDdQ8Jsk+OsDSXeBZnx0h5ql25Z2kQ7
         O/Xyz/pVv0NdZf2/Bug7HBEF5vHzbC8EAFP7gIGLer0wKf77iXaX6IXMxgd5I8RH/7jj
         TKWK1dDq2BN2iD0acfP8UhMnmKSzfwqYPUZjp+7aCvW3RDu3whXcNc+O70AHebk+hQoe
         5NSVz1fEpX6lYcSdasl10PVOvpAQcuuJ3dUg8zQLAQCNbISosS6hQ/zn3SB8eFrt88nT
         PQRo/VEWI+NlvkfPK0WQ13nlSygDLe5c5tPNDE/axMXHlmP2Y+qGxUGD8tOQ7gaPyxH9
         tg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213615; x=1744818415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmHMxU2w78+CVBOj7SKK51/xntQtWaTeeSMBQ6WnTFU=;
        b=aymmGej54usPaJmUjmXJhJ6XpXVjDmL7GEFv9BALeXolP4akLpfN7XemU0clBbbonq
         OytMhIzDgaWWshaEUSpP61S65/l87gFF71UuqfsPrBgEXEtCH7RZWklPVaaaSzIbSv1m
         xNig8Lh09dSBrqSAJZwdKUwbgXchJbnZeV/7eiPgwZx3RPsWRNsMblvD0rrOUGWoeJOg
         f87QKgn9Ytwoa+2NifsxpuT5tHUkbuCxLlQAN7byUs94rj1H9T/0y69JSe/xEYtCINda
         4pjSucBaqc5LptN3c5ZKxNvYj6xPAWeIUxYKegeKuYFhgJuIn5/ol4i2ho1HVmLzaLVf
         DeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI04uD5ZUGbVDI2Hmev89ydrbhwdBwaekIKRWAPF+9i72mNvLdNtGFcGpRHQO8g9qObgldAyLhZ7m0qbIe@vger.kernel.org, AJvYcCUXCpCkzX7co9m7GHmtZhuv+OVWHGaY6wKhiPsNccVKbf833rwsEb58dUYLlL/UdWVkLPJwHLkN0F0PtKo=@vger.kernel.org, AJvYcCUm+bqWWXl0WESGQZJa2e+YzbdZSMLTscqFf1jHxTN2rnl69yywYiUBY7RW2K/yqQOoTStD4SXj@vger.kernel.org, AJvYcCUt6BciCYQ4LGi3mgmiGNlFYywbzS08S98Livp4cRV0SNMJeYNbkAG5yr9UUOwla7aFcSI=@vger.kernel.org, AJvYcCV9st7Z7ex3aLCUna93NMaBH/LFnEjzPAB6RhlSs2HJYc7/mD0lM3XIwaGrJ8wdxTm7V+AHWHqfl7AH+rA1@vger.kernel.org, AJvYcCW+qTCLHhy1mNOzTvOerBPNruv7BNGsaA2xqG6gdVii6Y5AXZVSXRm9ihfCz84nt0ySCFD7qQ7BjyKpbIs=@vger.kernel.org, AJvYcCW6ue4jtk+jbn2x2oxfMsJUB5IsjOcusuBYLqKckVc4hIvuqKt3PLqGXKKdULJU4m8Qhzr81MnJ/x+qMBY=@vger.kernel.org, AJvYcCWH38XCgdGZxb2WKUs3NEcWbJWkdwbf28wTjHSnaY52AA9BrsMPrF+CpVAniunkYudGXeqqLpJXqwXOjOK0mVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCSpH0MypNXGTMfppU4nb2wq+EQlYpMG0E2HGDnYzunTl5FyH
	6xBg4326ub3YhkEqLJHygL4h0Ycyvi11ld//d3zIiupfiDg4GXPo
X-Gm-Gg: ASbGncvfpIsK8qXzUztMbVsWdKBffb6mxrbU3xriROWXMNPnx7P78Kw4cfLsiaJASWB
	dB6ZE8NL2CA0T29lVa3H5qFx/dUU3VJE1o7ACBt8PVQ9GpcE47T1TmN0fZbBou3FtG0v3P6ISjz
	temsyAG4rL4gxBs2aya2zITJ32gs86sm7BsL8XkFgRUFn2HxvqkX1ppcmvLvABEdvANJhlA8UmG
	JuPqZrd5hC4ZS0olGWFidi3NzwHGx74PrhMGYQNpYqH5ItqSxMuKTVtM6UD9cSa5HIMXei2AyGj
	vtRBMxOE3mTkCdE7uECidyGiKBjK/RRaf1iMktNNAFhigyl5sOtbcBDVyeRrFmF/8BGRlOs=
X-Google-Smtp-Source: AGHT+IFODj+q3bMay4dU940pWbrerSwhoQdYamKxEyheU1FRVVU9x2vDvw1G0LxNRVOTtBzOvt8phw==
X-Received: by 2002:a17:90b:2e4b:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-306dd3247b3mr3476749a91.1.1744213615281;
        Wed, 09 Apr 2025 08:46:55 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:46:54 -0700 (PDT)
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
Subject: [PATCH v4 12/13] fsi: i2cr: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:55 +0800
Message-Id: <20250409154356.423512-13-visitorckw@gmail.com>
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
 drivers/fsi/fsi-master-i2cr.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e5..692d73e892e3 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) IBM Corporation 2023 */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/i2c.h>
@@ -38,27 +39,12 @@ static const u8 i2cr_cfam[] = {
 
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
+	return parity != parity_odd(v);
 }
 
 static bool i2cr_check_parity64(u64 v)
 {
-	u32 i;
-	bool parity = I2CR_INITIAL_PARITY;
-
-	for (i = 0; i < 64; ++i) {
-		if (v & (1llu << i))
-			parity = !parity;
-	}
-
-	return parity;
+	return parity_odd(v) != I2CR_INITIAL_PARITY;
 }
 
 static u32 i2cr_get_command(u32 address, bool parity)
-- 
2.34.1


