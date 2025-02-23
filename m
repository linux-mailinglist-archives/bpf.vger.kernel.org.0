Return-Path: <bpf+bounces-52276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E3BA41013
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1C117887A
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0CD194080;
	Sun, 23 Feb 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3ILKsQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0713B280;
	Sun, 23 Feb 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329062; cv=none; b=CfMJk3brgSQIXegzLE8cumE9ISSFCaT0l5QbAOr8pRx+wd2Qo7n7QUXUwZRm8O4MMMYiK3lfriLDRTFFKR62YII/RJRX2MzTGmSul5D9vL6Yv2In/OhQ/uN1IK3gUxNvLxnxtQGintp4OlBSbLHSFI5QTRPq6Fctb6igrZjs2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329062; c=relaxed/simple;
	bh=HKAn3f+7sbHTTp+UNFXBUa/TbF/WrljtWVRMW4BZHbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRbqHnwuOIcGdv3eDxVkIEghVcdNvjWUgNbLxENhnX/Bki0vqDPEkaArns9MrHRUHk9CIlLd7OBFKpAy8JoSHyywXevEZ83pTu8nNawvB7M3sybLPFS6D2dMKvbRRop+N+vinCHrt9Bhe7UtFt0ChC2f0LfOIdYMghaLOPg2LiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3ILKsQD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so5668623a91.2;
        Sun, 23 Feb 2025 08:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329060; x=1740933860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcXJ496C/2+0qa2GsfTbiscKGioWO59ZW48/kJd6oSs=;
        b=R3ILKsQDeSASlpib/utH1OBIIvgkbhHKtzCiJKemgAPlVFtDHx0/4XMqZJ4nDybQzs
         U154M++P8t3jcEkfluN+cVLpu3Nfd8HGHcaPxo5HOZJcpy+r/fzrFuvFtutRYJ5lc9aw
         8NzMzLZMXu2HtvqZB1EkZGnPXVdg7queQYG3aOJmVnGlJQlF+libls8umbgRzyviUI1Y
         gHT0NaVpQJ8S7brJ5FKN4xcgOejWPk3LQFdsLDSGzQxyATcnHybFyVi/BweRSflcS+E/
         yHIPAdZfXVAya7CImLvTTgxBqSAmgRgSvB/lmNsRYyzeKiHuQ36mVWeEYsSy8RbcL6Nu
         yFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329060; x=1740933860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcXJ496C/2+0qa2GsfTbiscKGioWO59ZW48/kJd6oSs=;
        b=T29ZWCteeGMQCfJaGGkWZaM720v4IoZ9596slC9BPcijvCdNLLsMTiHsDFt7Xox2+V
         xOmC0pYlPa3HvBhdj/FZf1l1ZXf7xxxf/9rzaGZ652FQ3Ut6g8VUk7O+TZrQcEaiBIfG
         OqehBplnImUDY/XZzeBNQLY26XqpN9LWZWTBEcvwcOhV/Xn0ZT5IFAhKMUd8IkAjJKsr
         YnxnjEvE29xUDnbc3gHJIjfXuGawxY7/VuSTY8bpUcOZIVm9y9rWTewQjdA3rjwYJqg3
         X9PUe3kil1kvDVPXDiha1TMKSGQotGeWxmdR+SBVNG2ILv84WPVcIZxmdvKlxP+bqOHP
         E07g==
X-Forwarded-Encrypted: i=1; AJvYcCUIiJXLPh2ZYk9mgOmeqvLvhCIv47Uas0VP30JgTvWA1egtfe6tpfYoswgeM50LNChREHg1pucGvvU5aX9T@vger.kernel.org, AJvYcCVXkjUUxT+k0aXZTfUxzPOA4gRj5aL9DzLIvBvZQ6gn3PoD1wk1vycSOX7ahRH73DHlxWrPYPMGclIGVcM7@vger.kernel.org, AJvYcCWJppFVd+Ue3OwqTDVDstl/tfcAYMCUEwoeKUqtg7O5d44czHyOrgorfXGtCTgzQHK6Ocy5Qs5e@vger.kernel.org, AJvYcCWMMvHL80mI7FkffHtPzjlsb3icGkr2JVgxC7Vgyex06/lR2Xa8fepuLEfF5mtlgS/Hfq0AQHJROi+h8rPGoss=@vger.kernel.org, AJvYcCXRW3UbJAOGsxC7iW+e/XMPtMwZtXjUU1PwknAsuJjqqg7w5tFetCBW925b/xfyWNdLTwY=@vger.kernel.org, AJvYcCXTSmcYnxIktHvPHMd/AJ/Y+9nF0mLcXXOAqJqINoxB+cRSFewZqUphNkM1f1KIuAKFWSSb7PcGr3BMEFY=@vger.kernel.org, AJvYcCXUn7OIdwtPUnZt+rgVBnadqcGbfFGqzq4q992HzPac4lzT4eZ9YKttYvR5AebNDKVvPpLV89NegB1BXb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDvu2SBx9jwAyLagkCciFBY5559S2PCxVQ17gYfQs1QcQGOSC
	6S1S7+hytA/Zoim5pt6RDcIPZS5pkt4M1yS32LARcAhXGPrx1n1p
X-Gm-Gg: ASbGncueRaW4oDsHSOMFOCQPhtjChu0Xj44bILDXw9/R51VBW69kx7GJ/Qhh6qk42WW
	qAKZNVCTQxZ+Y8Cm59Fa2zYY9suR2BeHL1VZify76PVVCV6JcylTj4Q23ijWXbfERfNotTPTHw8
	S2hgYcbAr+JwRekz3KIhZaj5ACnxwJlqO7/+j17a6jWv9N0n1zbrXc18mKIDVv6/irwUdClPm8Y
	kDdzrG6Fn6O3z1C0XkRchaHeglNMS6N2tBmsFkan6fzv39zi4/EpGtEDUv1rs05ANegK/aRpfri
	TvdhBda1E9qTsetkFPsJ/1a2jLfZua4w76Y/2L1Vz9MsbPTVNVUBL+dB
X-Google-Smtp-Source: AGHT+IHbMWEVOubhP8X9psmxxmvHUjnp2Da3yrH5tyGilfGOwqHtwm1WTVAYDoMFuzjd1nirp2a0lA==
X-Received: by 2002:a17:90b:2f10:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2fce75d8389mr20940871a91.0.1740329060473;
        Sun, 23 Feb 2025 08:44:20 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:44:20 -0800 (PST)
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
Subject: [PATCH 08/17] lib/bch: Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:08 +0800
Message-Id: <20250223164217.2139331-9-visitorckw@gmail.com>
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
 lib/bch.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index 1c0cb07cdfeb..769459749982 100644
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
+			tmp |= parity32(mask) << (m-r);
 		}
 		sol[p] = tmp >> 1;
 	}
-- 
2.34.1


