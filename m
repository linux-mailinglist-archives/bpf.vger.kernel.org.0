Return-Path: <bpf+bounces-55547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD1A82B6E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BA0465063
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D74278161;
	Wed,  9 Apr 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBfd1OOs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53226A1C8;
	Wed,  9 Apr 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213607; cv=none; b=psj42xA43HgRn1wNt7emD07s6b5YIeyKFITS9YlvfBSiOyTFOB2dpiuOGO5IKxNw7CiQgpCbc8M5tZ7QgJARJWqtqYqEuSs7s1RBA/mq1QdTHpb+jvpj3dDPV95Sc17EyA+4s21YFZxKta9tdzu2NJhrPHB+HcScfvm298oCYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213607; c=relaxed/simple;
	bh=86K6PMYrG4Yc7WDoGSRLur+je0yhJ/i79zL8gF3HsR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzVI2sSRbkGRAZe8Dl3Opgd2Bf4dmBEuO+mPTYkDsJWa2QU017jxaAwZx5AhBVioLMPvz8MmJ8c4OndbxWyYwEopkR+79Pj7Odt13jIBwKS3+yuBvjC9vTveBU2VcCaskLvpJT3JM/UxNOjQJxsXWp3h+wrIXr/MkG9Ar2xwrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBfd1OOs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-303a66af07eso5487887a91.2;
        Wed, 09 Apr 2025 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213604; x=1744818404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BuIdzO9eB2TbumWIHS4Jh+TQPJAfCKqhpNNx8Z0il0=;
        b=ZBfd1OOsGeB6Rxuk3EZhcqH2cKcIQIzZS4jgA1gpyT3sYCqqFKLuXfCo8OsCazCRmo
         L68dKQ1rH2YZjyvOE5QBCLssmFmBsDFqmR6M0mCfK/soOFAwKGqCDOsBxtAzS5r0ZaH3
         p9w4S+WOXkFXbkha987dos6Xe4meca1XVhFVw2neLAv9ImoeIan2zHSJS7KImH2a/eVF
         yCeBO0AHNNM+ZP+B+97eVi4cEOJc8jWOdhHVhoL1/xSNJv+HVdp1CDFwqbwkIYKdIP8K
         PHficpw4QYyfZHQIJ85hUgupentM4VVbodkgbY44WIsWXr/i9cfLVEjNBCZUfWnOBcva
         OhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213604; x=1744818404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BuIdzO9eB2TbumWIHS4Jh+TQPJAfCKqhpNNx8Z0il0=;
        b=D82vb4HJZZilsbP6KMf58HOSdUxcKKJCDzvLWx3u8PmguLuh85uMIDjPcXk3uvXqAX
         7Z/fwOPLRxRYoLXvr7ZsMLAR1oIGfC72lrDHhr0JpCijqXjzUe82H4Tb0OmZn5lo1DF3
         PWaHXrzKbo909i9Vn85MwZkFhktaTFpNIO+brN9TdC54O2Z9QEFpijGY5m666Nf2Nz+3
         HDaVESamVFvyB5Q9K92/kUMCKxP5+foob9w8Slwen913zb/ogaNiEPQyzqJkBoGkfW9Q
         w2UwPZncdzpKHpNe6H9Yv9WGfh5UJFIg+TpV+OBFGXnrNi2cxprO7OJhpXCiZqgaf++h
         i9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU6s6CuNZUDZhnHKzaKNx/EV2SWSLalYhkTjWP23dQMhj8PjgFSoDj+VvfGxMbLQqm0eBioLHvP@vger.kernel.org, AJvYcCUjdnckgfgMCcNks7+BQlMwOOFuXJuoo9iAXaZQezn0lmsQlXjN85GnA6WlD2NeYQZMTCmNLfRXbGC5LDg0iLg=@vger.kernel.org, AJvYcCUmrv9FgzqvOCFk+iM436OHmsjOJJGDh4ksjYwH5dYPbTL2CL7+Hj3y2JSyKgRYWysv7t2FSOFZ3T5Vs6kB@vger.kernel.org, AJvYcCVC1jGZ+nGa3QKWkLXQaWfgo7/e30T2RZRNTsuOkxlBULW5ce7XuMfI2NIfdiaG5ECi25DuGHYAuWfA5Cg=@vger.kernel.org, AJvYcCVYd4tgMrepp3Y2KiL3jMLPo+bvtBnwINUfyO7Gm1hypc6afCtYl0V/9SCwbp/ZamB+2WNaGAkHL5xgLR5F@vger.kernel.org, AJvYcCWgDQ+gbTiCwRioNTEjPxeSOyMhWd17/yDcxqrHvClWo0biYMJdEYmFTTySEhf97Ahe/LpvetzPTZWWGyI=@vger.kernel.org, AJvYcCXBewpRU4OZFHul9CY+6ecKo2HyT3hS+WfnYmTmrfRhGgQvPEwViq9sLmJqyGQ5URxy7kM=@vger.kernel.org, AJvYcCXFx/QAuQTZ9E6frQoYxtPIFCBfyWqzirGwS59yfL00YLQFQvH0FI8DLRdk5vVxW97+HM+/vaU54k4vYdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VtMSlqzp1ClhUCLZyKcYNu4QGh0yXGUznHyd/ntOqErAS9ja
	yG63SExBOO3oGeR4LEWGAK25yWGzVtgO/hfhrut2+nmz2+8SFQgg
X-Gm-Gg: ASbGncsEFHA1FA1iIBDz5U4hiFup5upzCltpZPXz5fSSyCBrQ3V8rcKFAVtFGHh4tR6
	LX8k5jSVJa7T11BPl5iDi1/E9tGGU57n+Prx1BVbBBunKuss9wdcse4JQZSno16CmPdzBPkeBy5
	+aTq8CZbDRiD1OPDKNtB0wiLMm7KvlDaS4T5aZFGFZZlE13qrnUW7gfbENGXnFoSOpKH09ucvrC
	QqSso6uwOVPAlNJVfb2eZNno/8EbE8nCtJ1fwhOo3rBPBnYKaQWKSE6BdNZg3L2gxk7ERara2R/
	62WJJON/M5s5lhVSSF/b8G5WKTFi5MLiy2vj+sc1PqwN+LMy8/AmZFaqr818HN5AR8c8lCQ=
X-Google-Smtp-Source: AGHT+IHJFVNSWnOegw3VgIiiuGFrSpWrUrgalLTX98dIPQMejjp36YTfz+PTZSsEbZDfgQmuBjYI5A==
X-Received: by 2002:a17:90b:2b8e:b0:2ee:90a1:5d42 with SMTP id 98e67ed59e1d1-306dba636c9mr5272799a91.0.1744213603675;
        Wed, 09 Apr 2025 08:46:43 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:46:43 -0700 (PDT)
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
Subject: [PATCH v4 11/13] mtd: ssfdc: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:54 +0800
Message-Id: <20250409154356.423512-12-visitorckw@gmail.com>
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
 drivers/mtd/ssfdc.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 46c01fa2ec46..0db4776424d0 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -7,6 +7,7 @@
  * Based on NTFL and MTDBLOCK_RO drivers
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -178,24 +179,11 @@ static int read_raw_oob(struct mtd_info *mtd, loff_t offs, uint8_t *buf)
 	return 0;
 }
 
-/* Parity calculator on a word of n bit size */
-static int get_parity(int number, int size)
-{
- 	int k;
-	int parity;
-
-	parity = 1;
-	for (k = 0; k < size; k++) {
-		parity += (number >> k);
-		parity &= 1;
-	}
-	return parity;
-}
-
 /* Read and validate the logical block address field stored in the OOB */
 static int get_logical_address(uint8_t *oob_buf)
 {
-	int block_address, parity;
+	int block_address;
+	bool parity;
 	int offset[2] = {6, 11}; /* offset of the 2 address fields within OOB */
 	int j;
 	int ok = 0;
@@ -215,7 +203,7 @@ static int get_logical_address(uint8_t *oob_buf)
 			block_address &= 0x7FF;
 			block_address >>= 1;
 
-			if (get_parity(block_address, 10) != parity) {
+			if (parity_odd(block_address & 0x3ff) == parity) {
 				pr_debug("SSFDC_RO: logical address field%d"
 					"parity error(0x%04X)\n", j+1,
 					block_address);
-- 
2.34.1


