Return-Path: <bpf+bounces-52282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7230A41040
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D5E1898AF8
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73420C496;
	Sun, 23 Feb 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfTCDukj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294E148855;
	Sun, 23 Feb 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329127; cv=none; b=Pmvi5MGs4CGqcDqIgUQrmYX9SkeT/230+jcWfKGl/hlA6SeOdqw4dP6oUXQM0Kr+9j0sbTuo7gdqKrIZ+2bHa1SYswZkFlVqFqefYSpxQq9eLsGbhxdrr55icEguNLxKMOCYyfgBRG5xsCUcHbVXQ+y8G0KfPvuDVmqMP1fPbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329127; c=relaxed/simple;
	bh=6rZCyADuBKXQMtzY8frtZm7r8BeFGku217x/vpm4MWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rxop20NNpPU8ixfZwn/UlNae0TyDyjd1mfIVYo0t5LCKzkGM4dE5lPfGgSvt8dKGQzkdKy1KxneYa6ouiHqTdqOVb67nQm9v1gU5fCCHZtI2oH4P123aYomEk8EBAjkT7fu/LoR6Bfvi5uwETNvNncxGYmoXBIILuyQGk3J+n40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfTCDukj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c8f38febso75266735ad.2;
        Sun, 23 Feb 2025 08:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329125; x=1740933925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCIStMwChzl4Z+E/b6UIovNeeE8MF3lkiK/lI/bZwfc=;
        b=JfTCDukjbBJT2W7yVzFjj7T5q5uqZ8dNgk03wchMdovW4zRrsFDdELrLB018HphpSs
         wAOCZ3/+QK2JmHebMj8B/VV7iYFbr8K0BW2skZ9qUepvjKIFnk0Wd8/RRS/UJmM96Ma6
         Ew4RWH1ONzd61W8qkSb9otoeRi3itPB+zcEj015gfIYDEfHGqRuQMXi26F6TjCodppRG
         Mobgap2eGKVcLw/saDIZ9kEuXcyG2Zj9eDEkjtOflvOrWOORViZ+K1MxFXQFLxkFKzZP
         DphC9t4bUhNREtZa1/XNiSDObl4F7xLW2s6RPqaxFhB6athUu/+nPfDVTfVznBIXW+WN
         An8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329125; x=1740933925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCIStMwChzl4Z+E/b6UIovNeeE8MF3lkiK/lI/bZwfc=;
        b=O+AsickG588ekk1DfchWmstTOp7LGGvffQBxSxfwRiRWqjYtQup19MZagKzwPt4dfA
         j7qGdyFtnWqSih0wTfK5MyJXmXTx1fm4/vxq79OjverW1XsHyAqa6Y6qj9V3GQOcG4HL
         /Woz/5pqGhzSqbKOhQJNTo+i6JRVHOUj2mzyi5pVK2m0iNU0XI4M0y1WnsszvU8rVJ+x
         IScoVxnz0735EvmZ1OTjt1mYLKdqxmP+RD1g0EBuFcJntpowEk1GqbzeYcCAkaLnDMTJ
         mYyKkWmfWqsf2oQjqR19+hlgMzi+DNEMDIp8EwyXGp98aFuOymNneFX5d/4gaK1rQ0sZ
         6Elg==
X-Forwarded-Encrypted: i=1; AJvYcCUaUgm/NCP94l6rc3MpOumO6RLjkC6k3TD2x1UT3fpWc6GB1s2LOdBvLbZR7mYjcXAShZoqSopLdG6I/aTG@vger.kernel.org, AJvYcCUgyn53jMNLGciRl0bYm1mzhGaevpXZU8+yugO+6HUs7o9WpzMRYTdOXX70XjzcddNpE8ndm6BrSdf29xY=@vger.kernel.org, AJvYcCVi99Ah7MezQVwGFIzRBb/3iHsReiGaUJROqzZQZ9q4Uv2P5yLooIJEnBZJHVkf23vhni7nmAaeZ6NiLJs=@vger.kernel.org, AJvYcCW55LzFs6Rr0EYhmbbB4M/AQ2GDAx9KGdhnCM6hAt4UAhlNBnsae1owj4nYRntEZRBDVl6H9GwP@vger.kernel.org, AJvYcCXlWjHjJFAXiUZh76rkN+AEsJUDqh0E1ugDI9xKIBUM8Rb+i5E4UZto5maJM4W2bTeQeQ69lYqWPDi5VOzO@vger.kernel.org, AJvYcCXmibcnZvtT3iKJHL8gPQ0N8aRXquRNt3TdFrOmvAbms8i+RbYQzZ5RYvyYNbXZahtcRPuQjY0/zCXi5Z4t1GA=@vger.kernel.org, AJvYcCXwqpDjZqU2cebCLCZADoHyyVZyCu+BPTarAvGiX94cIJxboeHqAFr8Ll0yZP+NTmA5Ci0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtEN/NpR1jyyd2WFsOtcZule4yzMoRrJtdz16lgZBJs+5cxuT
	t1VB1OzKkJBaaYIS7aEw5K8aK8NpPPl3j6w5QAPG1B0fEvI/M3aQ
X-Gm-Gg: ASbGnctlwlrbhc0HTXGUZDh3rXN/ZkFdFJXYCO641cqEo2CWlhGwqBIT6kHIS1ILwCi
	Yf0FIqfvvPTKjEHbaUNuskaRWI2YUPBTYI0Qtdh+9XtC8Fq39G+hW/2HHAflxlEeSeMByR3IacX
	Fbon/z0RgI+FbnN7oWm6WqdTDrySzeKEy+AVSZGr72aw1ux5riZBpd2u8apm7Ov5x5EtRH1d/rI
	xdRQudSI3I894Atuw4YbUptWR5E0PXIrh7i/AGnZENZGE4wmw/FlwVwF25jKYR7t5dBBi+j3aV0
	TVMKbmU3C4/z2toA4jHqoYmtSUw5runwxDSumOhPL7ziV9ctuTUhm7OZ
X-Google-Smtp-Source: AGHT+IFs3TQ1rSxmmbPXVRsSl3rqDEDcDSV6UQtHXLRs1szh2ELiA6tHTHYs6po5Gu/F9oStBVoG9Q==
X-Received: by 2002:a17:90b:4fc9:b0:2ee:dd79:e046 with SMTP id 98e67ed59e1d1-2fce78a3738mr17084857a91.13.1740329124995;
        Sun, 23 Feb 2025 08:45:24 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:45:24 -0800 (PST)
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
Subject: [PATCH 14/17] fsi: i2cr: Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:14 +0800
Message-Id: <20250223164217.2139331-15-visitorckw@gmail.com>
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
 drivers/fsi/fsi-master-i2cr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e5..8212b99ab2f9 100644
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
+	return parity ^ parity32(v);
 }
 
 static bool i2cr_check_parity64(u64 v)
-- 
2.34.1


