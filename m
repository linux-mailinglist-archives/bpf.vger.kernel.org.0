Return-Path: <bpf+bounces-55538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA3A82B1F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4889444017
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675B26A1CD;
	Wed,  9 Apr 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbW6tiOt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C707267F4E;
	Wed,  9 Apr 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213495; cv=none; b=gfcHdLr+Z2dI49fANGNJKEZSBQR2ecYb8/awu7ZaX3ldD8A+BHmjdu+IknMD91U/pGp3Wuz5q5NuAK1F7CcLy7nidjjCU1mhS0DVAAHf99vShWKvqaT01rQV/7i1iaTPVkDh94JcQVWJbINgkXy1fkH1tHL0T6NLHPvycMhPos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213495; c=relaxed/simple;
	bh=gQX1tPtoBeVaDkfhW31RPjLez11EkdHuSuhYTxeIN6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvO3DYcYLqxXYq30oiDKGiuP1XnYaJBGL/l/G6+k3cR7XvyARCvs03qIlWc0/y5pWjQvTFnGrbGGzW5eTO386q5yAg1q1Ys7IPQYTtDCttu5s8vcoOg2MEkBGeEg765QCixFt2iUZZ09xrzPVnuYB8ykQxJktGMB6JRB2PLOrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbW6tiOt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af9a7717163so7052071a12.2;
        Wed, 09 Apr 2025 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213493; x=1744818293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v49ZwnZIj2AOJhsRco4puem3oLXi78jqbt8BbW57LpM=;
        b=fbW6tiOtkcyaGUAJ6Zq56/v3k8lpAdDxLgHIzFciv91C1L4uq36D/duXlzOZF1ZEUS
         XuVVLtlFVmTJqUf24xl7qOqPJ+Q3yknrxKuH7Nk8KhESYgxB9CkaQ5A7DVTZlDr/szrL
         RWR/w7qU3BUmVJQK9JcziexAm5kI04aBqU7b6LDN8I2wV8pw7nlfJMV0PEx4jmofj7lk
         FrQXpL5VmnFyvwElGi/hVx1HiA9EtBPaIPDnB0tn3jaBfw9Od1bg6ngQVa2Uord0/RuI
         fnC80+/pg0nNwI5sU2pyGUGIXK36gy6Dsx0KVZTdNaVWKDx9gADsfnTinVkanpVDzTkO
         aOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213493; x=1744818293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v49ZwnZIj2AOJhsRco4puem3oLXi78jqbt8BbW57LpM=;
        b=NyuU+X1O9qB8eXu+8E8+R1siRFA7ascEN566vPabjVFLWxQmkd9BiH5wMubk+5dusC
         505XEPxIoFdHY0xEdyPby8wOYywW3RZut2kxe+h8j0uzJO9to6hbD5BhtJXrSbpOED6y
         2S32761HWWn/bZqjIWXGIjUCU/Hpa0GF4JPA56XmBLfccuzilDDzz1lGGuMXgq0WolSm
         h+E8ByPuIulB2K+J0aO7C6ZiKdnluI8ePCWZcsydvTahAz9oKGxFnaD5T3P2u1KbbC/m
         c3yPtZoJIA9Ej1skVujUZghg/WXDh8XU5mofQwymmxch6GCffYpqQD5QGvM9MQrEP8BY
         GNdA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyCs3uAvSoJPxcnhC+FlP45lMIOEuK+Ot36mruDK8gJ4hal2x1IRFtZIAftuePgLuRHmPk4D8PeNI430=@vger.kernel.org, AJvYcCV3NwnJ3M5Rp/jorVIlPFH3waPiI9i4+8h9efpt5B/L8hbBAgzJkhu5F0ZOwW81pvIaj0Au05eTxVNOxI8=@vger.kernel.org, AJvYcCV8QC/05Knj54H6bSkf2SLWcfuTfvn1yn2sQ1H7kmVV+/NhwNWkC7d3ME5vMfPDMhN4KNSImBaE@vger.kernel.org, AJvYcCVGJeX3vqi5u2PW76Mnr+ya+0NuMbC5z7eEvKEtaYwIfyj1Co30tcWu+rSbqurkEEY+vjL9ICmqjOL9C7GN@vger.kernel.org, AJvYcCVWuB0TywOOvdNYl8SuhB/xc9ifigu6YhGJnV8bXRUXUN1t7UvXRWos4Lyq4eQIfnjkxVdXTLVK5oUBt7qA@vger.kernel.org, AJvYcCVeBmltF+G6jf8uAwXskX2lwqk/uX8mpetoB/ExvKjGjKmlOmnqSEU/GSofbBh9j7M+krt54Uq7SzOCXESksH0=@vger.kernel.org, AJvYcCWL2BhiI8jyHGDShxuPs5bSF7NOmG1SzUm+zvvdtllAcGyMVDjdcDcgICiiEmmKKUAMZ9I=@vger.kernel.org, AJvYcCWxxGa4sS3iYnxpSSxmFYAy2RUMv369y/OpETGRn1/fumkHq3iXpwMcSuOK6RA4Xclnod6M9d/NJjuMG6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJqB1Fh+C/eI8OqIc596Gn8jJE0+WBAe19bP13cygnbSYExKy
	ENjCVS+9DYmZ9n+O6iG3yePDYzVlTksVeTG9OGgSuyON4fnHF5yy
X-Gm-Gg: ASbGncuyfKT5Lm3u94VCnBhRhH9DzR43nxFdTlg+Wh4VOf+6Hl9EDoPQr00mKxgdzdT
	JBBwWWR8tT8qyyFuUF/0hDZ9bYVFA1b7IyuAT0FeDG6E7+0agsWWPgCPu0lBH+QrNKCYkRpdzLX
	hrKnreX+O8r4bLUm0nB+zmvArFTXFMF2po8o372Yq56BX7B5/D5SFwG9RIFNZ6Dfot59zoqdelL
	KPl9f841sdaPc054kTR2njozNuSDqVZKA/4r/frsq3FTb5FigKBfwmyI/PDsEeLL2601VBVA3yH
	DVda9o3W1hWMUHVAR7adPfrLKMyZAUalWp/XDP0fousOaDSDIf6uEHbNMo9VcrZjbNFB4WFKFxD
	E1eLVQw==
X-Google-Smtp-Source: AGHT+IHDjC6NZDKGKeJbiK4hibwKJCoZJOXppnGBHSYZ9kKUia5ispG3D8M0PIfVIJ8M4eMwylwt9g==
X-Received: by 2002:a17:90b:1f8f:b0:305:2d28:c8fd with SMTP id 98e67ed59e1d1-306dbc2bf43mr5380309a91.24.1744213492550;
        Wed, 09 Apr 2025 08:44:52 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:44:52 -0700 (PDT)
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
Subject: [PATCH v4 02/13] media: media/test_drivers: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:45 +0800
Message-Id: <20250409154356.423512-3-visitorckw@gmail.com>
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
 drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
index 70a4024d461e..5e1b7b1742e4 100644
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
+	return val | (parity_odd(val) ? 0 : 0x80);
 }
 
 static void vivid_vbi_gen_set_time_of_day(u8 *packet)
-- 
2.34.1


