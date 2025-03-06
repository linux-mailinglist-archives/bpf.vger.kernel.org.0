Return-Path: <bpf+bounces-53478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A0A550F9
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838431898A42
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016E216E3B;
	Thu,  6 Mar 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io/Skm56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B14215F73;
	Thu,  6 Mar 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278431; cv=none; b=oXpATs5CN+fJ1v+v8QJyADWWbiLo77f9pyqXArdj6uvUTosrVmgu/ZlG3foqfAjRIqloRlVKYDgdSLxi2dhAfBlNJ5PMIPOLwqGv6rRovN7F0YvvjCZVsyLrh+MlckX6MBL2DY3PfPBdipzUTJn3PDSMduvzWN0HqtzFzioEJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278431; c=relaxed/simple;
	bh=wM97YBa5xgJ18K9vOB6OMMfkw7YXLYTsVU4qscf8g1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiKH8ytucUQtLLGaBaYJ+RanCGUm1opkbd3r7qYcr7bBG5QDNicjNd3VvrmIVfEJ+kqwrHd3Swd8EVbRgCH3QiG6Vg7Dvjcb1mKFGEta29yv46cC/yI7Po0u5Z68QEaVTNfDF6kD3nVJ2RbbIpy8+BaPZHRgXU/rareUwgPEF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io/Skm56; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso1659133a91.0;
        Thu, 06 Mar 2025 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278428; x=1741883228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfkeURT+EbeVrjHOwezSCAhftS9inN7HFKHEaavRXXI=;
        b=Io/Skm56hUQcSlsiFQigHqHV7Lu3XB+E2cpWaypmO8MS2FIiiHMVSbOxmFVAN3yRXA
         i7P7zvfp5YJNfZ9PgiUie+6pr/5bROdv5iZ6XnQiwGcHh1LxkPGH3nyJcfAEWFtNiKHD
         MYy+T8hN/6NlCSqVjy35qahBBCDhz4koDALFYHumS2UsvRmj3CY8Q5qx5qaoQey4/J32
         7yiHTRd3zdEKG7kPb8ymK5vwMViVJBwlv+8Cx19i90jnKjGq4S6LJzEBb3friSfQMhWF
         EPPB36DeLh86sg0YBwiEI2EH9Fhfl3MgtEaqbGn7e/hbHxv6pWHWD81g9uLyXscH23h5
         Nbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278428; x=1741883228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfkeURT+EbeVrjHOwezSCAhftS9inN7HFKHEaavRXXI=;
        b=S43zU8xkuhZWQyoMBu3rgOOaKRxLahD75Qfs7IS9QTaCilC7aM9g9MBQlOqkNeylkR
         vabXd2Z4fEslmYUYvzq+UpPi7eyK8InqsmNCdcF0s/zuTU9VvUsfDOFdxSRsHJ6TdfW6
         eIavwtFVfyYgbNU+M2ee+/AraK9zgq2/h3P2c5xx59+Qtnql7r9vC/WchkxvtWg74ElS
         uoTdLSAq7mDDHybSxoplMo6N4oE+vDwVSc0Snb/+497VbGntf3lrm5QUR8ZMJyo9Rxri
         bBt6v7NPHczN3MktrMUPvvo+ItEW88okEYv7S7tECLrMzApGa1cArEkzkabReJF3r+iN
         /hrA==
X-Forwarded-Encrypted: i=1; AJvYcCU7kZLoTj88Joyj+80Tj2wO/i60Hs9XUJYDapn9aBTyfcS2bO0acAiKgni9NqX+nL8AXRBS2d4n@vger.kernel.org, AJvYcCUG/ssSOMu73aE5BmgWS10tGhL81mkAxFKBnZU+yvtvI2lEu9Qwczt+MwKVCuFvQBJL6XSH39NRqOVMEL0=@vger.kernel.org, AJvYcCVHpRvRhi6pDV3r3jsWVaPWA2eAeDBKgFGvIVK4UbsCUI0ah4cnHsx2auz8yv4rvXCtOzgDPnG0sv6Pnw3oJ2k=@vger.kernel.org, AJvYcCW5twCP2re1WyoDrUmc6SyHBz7mJHNBs80nY+cX2/rXeFLGhIrRq8pSAYFjdHc89QlZtEE=@vger.kernel.org, AJvYcCWra33zPpAysdyuqEuB5KGpOvoyq6PVCXNv2d2inU0QSrgCL+c45sd7WEm5sZFWYvga1sdFin7Ms+QIEQiZ@vger.kernel.org, AJvYcCXfKz64zZqdwVN+hi2Zcnp870wFoSH/SWALXA5Y/GazjkUa26yZUW+ksjlQgyCGIU5MMB4hp82V3FTFvBwq@vger.kernel.org, AJvYcCXopC01iHsVPmkxHXW+hChfjvKxPt9bgUjh2zTpOYefpMBgfGKKJfiv1I9UjUThgJhsSoOuZEqsJX0DFe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFpf9S/lB8gDepfqqaro7Qsi3ZkNSUnp0TlBrwvkH87h9kiIi
	kaz846gm1KrGa/G1JlFbDcJCaVPvXIYKG3nIrEkHYLA9hqS927WA
X-Gm-Gg: ASbGncu/+ifHVfMbhCpA5oDi2MNQQ0QKVpnQETKHlgldI2eawnijenLWbzDFW8FZUAA
	R7aPeeGijywbVz9Vo+P8qh9dM8fZnbqlelvlMbG4IARK1fKpVqbkzHmJU3KPZvF4r++CSq8X7pA
	jr1xQLYfSNY5GZQIjnMWc3udiI8I/3CdY2oG39HSC/7qziNQa+RrriV+69K4zIBilVfWRygp0iG
	HWiGCO9MHwri555ZHsx+fWR+2ikmPdtW/TtOWn+AwKnlQVYKFlkcd8Y0yAgxR2rgqF4mbQUCU0U
	r9uipiqiVBWQx7oYn0UCDjFXYFnd1CNbemKxuTIZLjQy5AiEy9UTAiO+8bf/F6JaL+8xK6uUBto
	=
X-Google-Smtp-Source: AGHT+IGNBcefivOmpQNsVFSdkYo/uQMo0VhzohCZYprzHPevS02kDmNn83LuER8aDdhmdhff3Ulvpw==
X-Received: by 2002:a17:90b:1808:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-2ff7b59dcffmr195851a91.2.1741278428557;
        Thu, 06 Mar 2025 08:27:08 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:27:08 -0800 (PST)
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
Subject: [PATCH v3 07/16] lib/bch: Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:32 +0800
Message-Id: <20250306162541.2633025-8-visitorckw@gmail.com>
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
- Change parity32(mask) to !!parity32(mask).

 lib/bch.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index 1c0cb07cdfeb..6c29122c0982 100644
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
+			tmp |= !!parity32(mask) << (m-r);
 		}
 		sol[p] = tmp >> 1;
 	}
-- 
2.34.1


