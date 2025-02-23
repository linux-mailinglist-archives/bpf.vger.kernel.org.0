Return-Path: <bpf+bounces-52271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C4A40FDD
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8CB3B5CE7
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4F71547E3;
	Sun, 23 Feb 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak9knMFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38975132111;
	Sun, 23 Feb 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329005; cv=none; b=ZiuRa4QYt+yNu/S5VAG7FzQ/PS+Sk09ZgdD4ZLZbuyIUKBm2h3iEVp0z6h4eiwKeO0jz5cBaRE/W1GsqJD5v2wH7hbPW2jgib3P83OPpgrR/oaM2MtdiyT0p2XUvhfbs1tnhhCFG5lKqmDg4gvv0aErP4T25SKENQ9rdYhsezHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329005; c=relaxed/simple;
	bh=gsZPsEY5OYQwjaN0ui4KqvGSNWWg5CZ6i/qi0o892U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQnK4oGMA8U9BT7Fhl5iLfU8lHl7XNrIX+4nz0iTPFmB/2F1XTGF/YdR8XYkmch4IbbS3CO+4XVsYX2XV9zclX8JOkbj1QX+a/AO6aA2HuE6tm53G06234j+tvOi/JaMSBlBH0TpwUa1jvKvFB56JybMaBmxqhet481VQd6fr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak9knMFT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so5702225a91.0;
        Sun, 23 Feb 2025 08:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329003; x=1740933803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmrxQyU7jDRE4tATauCMPx/rjxqRJrbj6hI/X9rAOQs=;
        b=Ak9knMFTDdjozMwvBJ86ijEXQhZNRB4q78kk+4l4vpZWYegA2AdY2NOpTAj/t+nFN3
         OTB3S7ZNuQoiKOQx+bTGr1WOJ+9yyJupfA1hmUO8JSd/38NcdHnZVONYgsNKnp15tCpt
         yjgBhgIQ8V0gJgOIvST/SUcL799cyENuuJYsUuI2TmefYUL8ouTXD7ygdFxj+8h6Bgq0
         Jm13Oxp1dlKIUvTaNuR25swljuRRrDkUA6euJt3a1QMqH3oKK6qh8UlLutPxEW24G32Q
         8TUOmWbFF6en06QS+YzUVV1bwlcvbVERm9rSOuIuHp4Np6NFXY2ClMj0LzMGihv4oT06
         2y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329003; x=1740933803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmrxQyU7jDRE4tATauCMPx/rjxqRJrbj6hI/X9rAOQs=;
        b=JNJ1XBkXpeVZq2LFlMSNFoCHDMsSd/BU3hHWnoMsVKOVqKLoqLJEbLq5qwe/pjLiON
         N8+xqfahqIWFLkwKHkOFM/7uZ5g7Aik1x4xZ0Hq0n85DtkAoQMO+jsS35O3WdADiwg3E
         kSU2M6Bq+wg8GcAhrvDoaPEHWot5uX3eaTuP+8/8FpQaLMgNGl83sgwcR1zSSTs26YNt
         dKDcAnazTXz/DjeSobEozYEtxOieCFj010nLWY9Jsq2bmkF3pIsBJPk9yJoGUOxMQ8mD
         zV1ferDtC5Qq1EmhwBtzr6fMenpNpB62Y0Y/sFZ0jCxYY54lACdosRj+OinQPlQ8Vpch
         kwGA==
X-Forwarded-Encrypted: i=1; AJvYcCUfq8NA+qkznQF4NcbVes8vRUvCgf99DEjIPu0zSe09vVDb+8b9LhUWssNNbPAbw8tHjkzEXbtbLUfBdaUX@vger.kernel.org, AJvYcCV1o9DUAndCrYHclR/rEDmTaAoeV1z6+0kF5sDYFZFRGzUT3L2qJ/s2LOB8MunRestBytqBdZ5mpREvd4U=@vger.kernel.org, AJvYcCVVDyaz+b1UFtxre0vdfvFSSENGOz1gYZ9zvQBBrgT+j8D+8f2S9jqexmj+fsdyU++vaTYZdD3C@vger.kernel.org, AJvYcCVqrfQPl2KbkTf+PcdNSBvx2T1f2q+KKRTq6Gg2IMaR1pi0UQosboEESU9yG+1yUQXckA8=@vger.kernel.org, AJvYcCVv+AaysIiAkWwWVecuaWAIItYV6RRQdNhUcvaqmV+MDnfm6xPW5JKAqMTsP+I6+vZaQ/ASM9VK0Ybzcum5@vger.kernel.org, AJvYcCXPtI6/rFI5sV7h2/NdM+fz2QBZ7fOBtCDE43I4308+MitmgmUuQAPY4U2mOogu5WokFIfWi2jN+TrHpAuZz0A=@vger.kernel.org, AJvYcCXxkA8e38m63/fqpRdnK0IK91FcXRQ3VzrMMFwLcfuN87F1IRGF8PjlzA3Q7g6ZsuZxMMXGhtmp4MJVwwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBwhHgiCLW07dIP9y88Lffj3dzJW5VaHJ5JxVEnC8vdqVo/a4
	3HH4ZyyQJRdLLIuYD09nF9UxJVB/PwuxKE7XI+Ox0Ny56O7No1I1
X-Gm-Gg: ASbGnctcKbadp9Jup2cwi1zxO2hj78cnphkI4M8K073vLiJQfhMp8LiIQAZeQwqJ3bS
	zv1aXR5sUdK8TlZoSMOIpzoTYjcisrXtktAjWjQT2l24ezZLhoBmAcGsU5RdPLbRzTDOnYmiDjG
	IEPxuA36e3kreWHZQkWuA96t5jrQ28MIsY7GFq0i/7uTmd7xquUsoNLaB8V4B2nCiWsyOxQOSHK
	KIozR73DpI9XTLZXzMsUsxHyTAetOLraPgPrW0vvylS7DmTMRc2Thmp/mtVZLMj8CixYEiUdMNS
	Dd5lSvamk/VKCJCOBZ2MwsJ0Mz4RKkhzC/Sk7dt7XFgE5ggFlb1rF6rt
X-Google-Smtp-Source: AGHT+IFT1Vzkj4StFehOYZfGx3Pqek+1r8/xkOZDF3lpptIfx6ywtn9p4F3sEZEqv+n3pwXv0Ec0Og==
X-Received: by 2002:a17:90b:5488:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2fce789bbb5mr17312586a91.13.1740329003448;
        Sun, 23 Feb 2025 08:43:23 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:43:22 -0800 (PST)
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
Subject: [PATCH 03/17] x86: Replace open-coded parity calculation with parity8()
Date: Mon, 24 Feb 2025 00:42:03 +0800
Message-Id: <20250223164217.2139331-4-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/x86/kernel/bootflag.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index 3fed7ae58b60..314ff0e84900 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <asm/io.h>
 
 #include <linux/mc146818rtc.h>
@@ -20,26 +21,13 @@
 
 int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
 
-static int __init parity(u8 v)
-{
-	int x = 0;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		x ^= (v & 1);
-		v >>= 1;
-	}
-
-	return x;
-}
-
 static void __init sbf_write(u8 v)
 {
 	unsigned long flags;
 
 	if (sbf_port != -1) {
 		v &= ~SBF_PARITY;
-		if (!parity(v))
+		if (!parity8(v))
 			v |= SBF_PARITY;
 
 		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
@@ -70,7 +58,7 @@ static int __init sbf_value_valid(u8 v)
 {
 	if (v & SBF_RESERVED)		/* Reserved bits */
 		return 0;
-	if (!parity(v))
+	if (!parity8(v))
 		return 0;
 
 	return 1;
-- 
2.34.1


