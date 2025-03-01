Return-Path: <bpf+bounces-52976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA936A4AC18
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAE07A5CCE
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4B1EFF94;
	Sat,  1 Mar 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMXkz7eL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF81E2007;
	Sat,  1 Mar 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839252; cv=none; b=DJAzVFisbPRderAEDXxfi7mY2ykNSpfqIJUKCADTuNqSkAdFSeS4b+1UUK/GSCkITupPBqzOu50iF12A1Dt7tbez6ZfIirZIvDUudJhiDMJGBIqd2KhYplx3mkBcpIAu+uVYLWiDF1Ic/zOQlsP9UMNDV1982sRfNUAROR3XLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839252; c=relaxed/simple;
	bh=ZR7k7WuXjWgoiKosaPdwElgny5Md8dRLy7kh+y/t7/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ku1qHYly6MfxCr5ewWZUZ1R/lw/v+cvXcKMPnf8bmbfmR7JyirkStSGvyLabEQAt3E8KZg1r+UzeNpcrQi5mCzzD9nP+SvUuKLn/s2H1ABNrD0bfzEhum9FjyfiMbZcRna8+XCjrdEscu1ue4xop8yfOVDrf3aHFK9umNcaRxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMXkz7eL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223378e2b0dso44915525ad.0;
        Sat, 01 Mar 2025 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839250; x=1741444050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0fPaIWjdscIdDk4T1YIhhdJwaKRFyAzbGum2CZXkTo=;
        b=BMXkz7eL7c0rZ4gzz/F3UUza0SB+mPrryWEK8BdGCHtYP7who/obq+q2gsVk9dWkgV
         2mYnNskQULMN25UXKvM6qRSwhb9uo4idqFp+E6q+1svcTb/j10ZK6lZKKg8pJnd1Fa8j
         ydppIHU25AurKOe5h3T94+EyR+nKrRfl8PhF5EA5TSo+x3q3wSxnPS3BrBtPK+pCtVK1
         78yIM2bcqrzxGXJUBsTnpqR+RQG+LZFIpRXpe4Fr+094ZsXwzdVVvw7di8nyi85Pi5kK
         hVOC7l92YYXagOVBVZg90W8V3Qx8NdY8HIl3kJ7Pjf5xvuIpNmmO28fg3xyzjW7qd8JK
         umRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839250; x=1741444050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0fPaIWjdscIdDk4T1YIhhdJwaKRFyAzbGum2CZXkTo=;
        b=duUBDVUorXNGgvrvKiBYwP0/d9ANz7De8kbt1vHbGQWfLZgjLC5bygnZ7GEAo0WSiM
         F+hQeGDWiq1ap7x9eIOtb+Heg7ENKyE71bwNEAS10jTpF7ViNA53fYaL815w4XdQLMb6
         fcrjKnECT1vRKbWUiIPNXGvsNhw4db+U5SxH6SFj/TjrF6/BmxMYfvSQ5UTt9g11dcsa
         7gVOdh6JZ3Mt553NbKfMLBfIOyXcB+BBiQQIC+QRz4RqpxmiTR1ZMjRjkOnrn2J+/w9R
         U6M9Fflo90dvfIm14aTkrzx7N+eRiozJUF/8u+PAmoU3sng0Xys41FqYa800pqCId3Ef
         pB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTC0PZ91RA48hSZAZVRa49hPjsIeuk+ZXia99+/ABQrHAKJ25bTLl8YHPZA+fV+zTz8NN/GyFznX97hVxm@vger.kernel.org, AJvYcCVV5dJg1QSKMLk/Kxkh3IOxbDV6hWE+LnMyJH1997MVxXtyvA+UFXFpo5RQyISiya/kFXU1eXkbSfKHw78=@vger.kernel.org, AJvYcCW2CFkEBPHMmnxF9hCYriWSvUODSxklGCqDMHhPR1pJONNSKL0SVm41wsh0xJiwIaf9d7lsNoZ6Qnykk1w=@vger.kernel.org, AJvYcCWEQSB1VRTsvRvu/7o3L9R+iroL76N4+wn1Xb9BultMBnTukyXrHBdkCvh3ixHxnjjG+y4=@vger.kernel.org, AJvYcCWhXAEcrmBeqMBtqq0iTk3BeJzO6fZLKUeg+mCemXKVwXGfNThoRVc4k5gtwuuhRsZQ55JVOKVZz6meNNbAH6A=@vger.kernel.org, AJvYcCXBPSJoUP1TGorkAsiUWqbAaiOjPvT6PrsmlP/6IRpesbo5Rfvpia9JaYE1EFW/u/sdh1LY0d/p@vger.kernel.org, AJvYcCXjo4KLLYtXSIC/Q8aWob9KhWsDje9zxZKfm5KR4mFY3lzZE3zNDSGq2TrnYw/auSoIffKm71pWMjOhHzlW@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXqEIINfHhV5b/XRDOfW739B02+YseP7fcjBJmINLrG00kz7A
	rTzMDHn7ZYGhATbWNOOapcH9Xm9Xpwe+bvLzVRZNm+qTwqNn8aX0
X-Gm-Gg: ASbGncsuIbBhBG52MC7C6o3ouxZezvRiey/N+u2JrVZuGKvFeNWOealdlqUU4exWElC
	atAGH4BqHmCdWr4Up6TCM/vidqPcGcF0UFBrAX/QpW6PykHvA2Cur88pyXNWx0OJKKQorxpah+L
	W6FbSyoazO4k3piTI6XiP1NKzO/RxbCIJMqPHFvBP3Uqj8vHtdsAZeSCeY0Tk82llMFTrw8WIuh
	wn63nCNfoZVPn7hXUyUm+SF3huiw0l/N9YOSPDlwsEfFM3+HDgGJ5GHwVm5IYhUgOgoUG39gB3x
	HUjP/jD2Edr4d9kHhkX9e1Mxr3ogqc5vnW7ZHffC6nxNM2PG3mtwL1+MCgxjB4iyT0vNX9y7GD0
	=
X-Google-Smtp-Source: AGHT+IFMEc8dvlQQuKrdEq7g4EcMsmoDBk21A7+d2Y0BFwhyjxtIIjawJKqlgdflPWZNOKVAtnpI1w==
X-Received: by 2002:a17:903:2ca:b0:21f:55e:ed71 with SMTP id d9443c01a7336-22368f6d002mr138003395ad.5.1740839249904;
        Sat, 01 Mar 2025 06:27:29 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:27:29 -0800 (PST)
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
Subject: [PATCH v2 13/18] mtd: ssfdc: Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:24:04 +0800
Message-Id: <20250301142409.2513835-14-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/mtd/ssfdc.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 46c01fa2ec46..e7f9e73da644 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -7,6 +7,7 @@
  * Based on NTFL and MTDBLOCK_RO drivers
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -178,20 +179,6 @@ static int read_raw_oob(struct mtd_info *mtd, loff_t offs, uint8_t *buf)
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
@@ -215,7 +202,7 @@ static int get_logical_address(uint8_t *oob_buf)
 			block_address &= 0x7FF;
 			block_address >>= 1;
 
-			if (get_parity(block_address, 10) != parity) {
+			if (parity32(block_address & 0x3ff) == parity) {
 				pr_debug("SSFDC_RO: logical address field%d"
 					"parity error(0x%04X)\n", j+1,
 					block_address);
-- 
2.34.1


