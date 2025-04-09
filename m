Return-Path: <bpf+bounces-55542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C0A82B11
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0017B4451
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9DD268690;
	Wed,  9 Apr 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWZ2KV6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC794264626;
	Wed,  9 Apr 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213546; cv=none; b=sTIImG7xYcJnNEeo8gVp7OyTq2hSh929mhJngGMlFW3MGDqtVDlQo7p+k+bGFLuVKAH/syo13uH0gggDtxuFao2kIK5da7kHK6PEN0w6rgSififabcegKh8U+4/H87i8ztZ9jgXvcevC7HRMNnryMmNWciJxeHwlljHz+FartzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213546; c=relaxed/simple;
	bh=yUb8DFUy4I0Hz+Ls1dIGoJuPKJueQIprpNYXIuIwr9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7lrZPC7RN/GSfEGC755Xusnlelj4UzZB3PByXfAVwXUswFdcZWsnp+X7DQ1Xjh2AFwVy6lIkGfR1Ldkob7fh1M8UCWBH1C5Vv+FEAevXOOIbZ1f+jhQuq7CfLbNLSl3zwWokFGZLtD/VK9sgby8q2E68cCCZWND5LDPGBaCx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWZ2KV6I; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af93cd64ef3so4766632a12.2;
        Wed, 09 Apr 2025 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213544; x=1744818344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTd+jcAteb5XQtuvZoTF72DclP9q3bsZAYfMztua9WA=;
        b=EWZ2KV6Ica3glvCCM2o7V4VctnVKco9QsOK36Z95IcmX4cHRZP1TooLLR2nQXCc0UI
         WCb+S+/hBGuyObmxnMuNDyYfOaQGd6LVvTssdjXWFZgpD//5xcJlusy5sZT3zJG8LJmM
         /Larg1q9f6HkmEsFoQqK3pp7OyKsIBdVOOG6ESlgvZYcIq06q4+HVcOKIrQuVdhEpLs8
         fKx7zJUqFY2MiRQyoW07msk3HcKGMb/HfhDlxl3Au8XYch7/gdzA7WpWdQ7CZnFUurGq
         tnFFwiNJb6zXdnQYJcJA1VWAyimsY4N4pi5WhwRTnQTlU9SYYLTQYBu+sPuURepGNogH
         4d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213544; x=1744818344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTd+jcAteb5XQtuvZoTF72DclP9q3bsZAYfMztua9WA=;
        b=H2pfIfhVGVEvA0VYVPe24zPMYYnPyEbSGWGyjIvo64viSyoyoLkpABaJKnyxHtwZLw
         NxYxqocCcFlh8Z4mrdw1hL8059WzYZbux6h9N6tk9hThoWWqPMPQel9MBz4t1DDx3t6v
         2lBPTc1GWFMwACng2T38rdhRK0j6ZRrGLIhj3vviYmYljDAz8ryDh8zHOpQbTOQoAG9o
         K7ZDqE1/jO5UkLfJNSWtOpX3dG5FnaJIjku91L0dZYpA1BiIHytPe664Fl30BULPOStx
         AMNjEwvW/qdUdNqhDQTnpg1frEii5JHs8QpW9qjrZzcTNDsJsvTGHtoN06fvUA9pRp6S
         DL+g==
X-Forwarded-Encrypted: i=1; AJvYcCUDTT23w5+DLma73cI8j/uK2G4oOCU/xmlKML4Fa9Jf/OGxQDCrnSm8/+dMVNVElNM8TGs=@vger.kernel.org, AJvYcCUTlU+GYa1t+P8yWgKc2Qd3/GckvZ8KZ4Vw5ZdnYYbnadZkJEfcxGLli9Rm4X3lBuvA6jQelglRyushVzY=@vger.kernel.org, AJvYcCUVE0v/+x/JCw0DTFz9xPflv+msIEkRhW1LUg5xNpThNzRB+ZmRqFEE6v3pZtxNXJjeRpHkAZReoExgKRU=@vger.kernel.org, AJvYcCUbdKh6iP9SBK8bVWNK6LHZanFTYiNkbjpQxeFlzTEdYEejtbxK2v9oCNjiKukF3JbDwbvRIe4p@vger.kernel.org, AJvYcCUx0g8tV0qR4xfbJL3LmTvoP0fx8mW1g5vJtadizYE9jn9yFkikg+Ek667sDkIr66zjH/4JhhBHrGTMIveSKSg=@vger.kernel.org, AJvYcCVRArNSNv2dTlXXG1GYkaxW5UwwjwsMqFJAYZIgpZH8EklP0N1UZTSA3Hl6DkCkDguhMlNAbyd4+qleRFY=@vger.kernel.org, AJvYcCWZOQ24cPibSdj5CJF3kNuE3SaeOuDNOqWr8nlnNR6cvfJ/2M7wGvtFE+CvtcsmLG7En4es76QGSkp5IGxv@vger.kernel.org, AJvYcCWrjKzKLUOyWwNhWh5bcHTquzlD2Mw++nL9HzW3ybNxIYCztFlq4XC9t06eWFD5JLKJuZpTrDRK5QR4+CsS@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKHHkJwknEHEglSd4WSWYVHiQXlrc5rs29SU043R1MqeZ+StD
	jY98t18cCTcvfAAVj5Hm9bBq1SDSTIbcm19yXTd09+DOIlJJygCw
X-Gm-Gg: ASbGncveqyM1hdaGtQCzTILkW+6e50Ho0Z8Vjbf5fwT9+8fMh3jS8pHbSwJVReV2/UV
	DdBmEsZXD3fJ5l4Q89By8ONQqBWwBKKeA3mDViw96FcWwr1tPyxFujJfPHQXgO+VqgUUf22HPus
	8IVAryT85bO+eIGtrYFIueC5N/z6DdLPhG2iSyqs7rmCDGnADp4E+w1JjYxjMG3546LUsi0tfr4
	DpbUxtlTm1mchGkdyXxZ/6Qlm1G1lD44qYz3ipKPT2hN44o/cKXVPyJo3xMtff0wtrulAGAcXZy
	kHraeiLlfd7CApgsNbJVjZ0VE01xRPRfaM18gWwjab5s/uE0lH8VuAzTL85q3qdd9cKkLnI=
X-Google-Smtp-Source: AGHT+IEJ7Jl6M7/jx+b0QfG2QtnETYXioK/EteWOwSUQmw7SIb5H5CEFmuEhS1eLp2rAJpsPWE7AMg==
X-Received: by 2002:a17:90b:3d09:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-306dd56b507mr3990247a91.27.1744213544132;
        Wed, 09 Apr 2025 08:45:44 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:45:43 -0700 (PDT)
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
Subject: [PATCH v4 06/13] lib/bch: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:49 +0800
Message-Id: <20250409154356.423512-7-visitorckw@gmail.com>
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
 lib/bch.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index 1c0cb07cdfeb..3f14d69f373e 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -311,18 +311,6 @@ static inline int deg(unsigned int poly)
 	return fls(poly)-1;
 }
 
-static inline int parity(unsigned int x)
-{
-	/*
-	 * public domain code snippet, lifted from
-	 * http://www-graphics.stanford.edu/~seander/bithacks.html
-	 */
-	x ^= x >> 1;
-	x ^= x >> 2;
-	x = (x & 0x11111111U) * 0x11111111U;
-	return (x >> 28) & 1;
-}
-
 /* Galois field basic operations: multiply, divide, inverse, etc. */
 
 static inline unsigned int gf_mul(struct bch_control *bch, unsigned int a,
@@ -524,7 +512,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 		tmp = 0;
 		for (r = m-1; r >= 0; r--) {
 			mask = rows[r] & (tmp|1);
-			tmp |= parity(mask) << (m-r);
+			tmp |= parity_odd(mask) << (m-r);
 		}
 		sol[p] = tmp >> 1;
 	}
-- 
2.34.1


