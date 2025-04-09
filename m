Return-Path: <bpf+bounces-55549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D28A82B91
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F719E0559
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65AA27BF80;
	Wed,  9 Apr 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QicgUccX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60A267B15;
	Wed,  9 Apr 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213628; cv=none; b=oZfxzAWfRxUbXmsHSFV3MIpm0CaKqWQfdbYH5Iq+RrzeR9fHL7rOTdBJOpTpq3GjnvzVhlZj5rTkwECY1i9TIpiiAK7l9cCpi9MmqF+TDpxCcCqpyifH4Tz4kTAmngWisztWBaX8ZFZlFr24gqHKp1O3RZwvI0GZPn9sKJ96pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213628; c=relaxed/simple;
	bh=glSAwwj1LCX2HcCq8CCc3CWcWjMh8MB3lFrgIi3HsrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SSkRJlXKMBJrU2C9nnXT1HMInog8JMRoUG/bAgIUBNJIkpPgcLTZJOzbDJNBIQSkS6/muaNvE/RI5wNvt3+/7oFSv0znG0JJj9v+rWBy51zbCDHUnUtIx5qaF86BPG+F/aqMmqyBxJNgGoO6IyAgmq86HeOOcbi/4yQso0Y9onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QicgUccX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b00e3c87713so2134170a12.2;
        Wed, 09 Apr 2025 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213626; x=1744818426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCEd/+juUKZOFlQ/4SCoGPbjU2jFBlmcZeDTBbgWCik=;
        b=QicgUccXfzEZQHfaQ+Z6C0vSi0+eY+adT6ctoCNNmuyDF7j09XL70yVvTloXj/Xn//
         1ChFQ36umnZidj1lo6D631FOnWhNtICl/VgFEW35PZQ7+lPsjcOEu2cVGd9yFWAmhSzs
         5bhrjDCJxHy11MgAsCbPDr1D1S0Z4z5knENVm6lhae9JYH9Gq3USPaBRp4+649zh90S4
         TN2M4WwPuCBQXLrDdJfP5V5eXKNn43G3nrFN40qYXAHU3OcECoUEpOz216TNJ84V0WVQ
         u/u58B0YGJXOWyJOQb8WV1ASwYUuJ2FiK8WqMJouvgTGt9uXvVAMl/oZO0LJXKkU/IPK
         z6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213626; x=1744818426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCEd/+juUKZOFlQ/4SCoGPbjU2jFBlmcZeDTBbgWCik=;
        b=KFktOBSLjMj5DQyrQThMaqkKGamHd6iIJs5yBfDNqQm7mz7Mr4tro1yaC19m3FshXS
         FFdkYnMeoYwS6af9sJqFx6PRi8ECfi9xyuMoxAiXJZSf7U/L3Vo+nxnNAYKqvmaSNXnk
         WbhbXK0rj/NP5LxeotNfoSych5kXP8nT/oOvR2BTOKVgSSHi1HwdXk8ZzesJhb/MHh0S
         +evHGuTTuQDLvnpia5kXUqok+fFar0GGlggvv90TZTxCBqgeKYUpJel711m7m7fFDeP5
         Bo+lKjQkUvMNKK7i0XtKTeP0fm76y/BpgzWUIqZgXeypHQkT1hucDvIwlEwpXf4LsIJb
         btdg==
X-Forwarded-Encrypted: i=1; AJvYcCU058AxZWdknk6y6nDxydX/l3Qn2EJ1rHCFco2RgLEjsDZKDRQUEN+6/TiMZb1PVBtbWZraVWdwD99ZFPw=@vger.kernel.org, AJvYcCU3DepfKf7cd33aNlqz6AuFTfBBGg07c2cCquftPSj8CCls+BJ9iZx9kfMaeFxcEydkMT8JWlgkOLhAzslD@vger.kernel.org, AJvYcCU6nOb/avaEgBf4czR9xQ/35jJdZFP1TQ9K694fpR6SrPv0p9I/HmgQjfsjAcM/08Cf3VNZirLhT6R8q3niSQU=@vger.kernel.org, AJvYcCUJPG0Rl5shr2gsf/41mqE9hZyJbsZaxsTg5FlhSSKeJZYnJ/NHfql5wXzV6Q77y6ceoew5Fg1/p8G53Yg=@vger.kernel.org, AJvYcCVWnbqnJBaGCfCL4mW+i0IREZSMNYsCZ3m+WGnmLND4DyLsrZwVlPH7nWpAuiCllk++3NKiGw1PnfnbUon0@vger.kernel.org, AJvYcCVpt7s6aY7EAhFiVO3d1aMsL6m2R6eNjiGYmsXLhV5yPN5JJrtp/14O1Tvv8We1q6lhwFzWcnjis78kvAo=@vger.kernel.org, AJvYcCWBGVuP3n2qm77HKwjdBbcuaJD/44rGL9xOYkGOy1KybNRLM4FAdzU/zqNt/eUQSDiONt9jlbJE@vger.kernel.org, AJvYcCWl/cdV/78F1k0BUQE+h+pIyWp5u4jDoNObiMSprsfKG5kYeFiL0ltpKA0hP7SB/l5T6PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqofMdisAOI0IY+vb7gJMzi9c9vTXmH8uYXM9+CIOp32EM/UO
	qxkd3wpcfOduVME8yCm+eTbetMh6HOFmxTy/31NroOOvfzUKQOhm
X-Gm-Gg: ASbGncut1NjBIZI4zpCkS2PodorKr++J6PZUV3qxHqYV9XOgXjiXoqumeaBgcNANEbq
	QGai/q9ERB/Opx0d8wYTMTEq5OB7w4mK0QMSEY3qQxI8sGiMNke1w84ymzZCPcL2/C/Kc5uUsIg
	0ZuOBvxAhlflEdloFU+zo7gTUCmEr+knxMUxOJkd3YetKlK2+oz4OHP871McpRFmbfwhAKOX8Cd
	ZYKaZFILFawl8uheP1MLBLudWx/UqfmNVnm1VY4KNs4ODeJhclarj21yEsFGQVfRBbbW07mUH87
	uxNderhMCD8EXny52lP8csb3OTxtbTrfUwo3rYWuUMBZlGu7ojnIZywchoTovxCVr7PiWGc=
X-Google-Smtp-Source: AGHT+IF8SQ2JgM5sFunT9Xi0DOo/QXgkDUpLAzWqHE4Pm6PBSNMIs+CrkMQPqWas8YcuXm51yI9Ehg==
X-Received: by 2002:a17:90b:58cf:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-306dbc0c8abmr4476592a91.26.1744213625892;
        Wed, 09 Apr 2025 08:47:05 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:47:05 -0700 (PDT)
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
Subject: [PATCH v4 13/13] nfp: bpf: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:56 +0800
Message-Id: <20250409154356.423512-14-visitorckw@gmail.com>
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
 drivers/net/ethernet/netronome/nfp/nfp_asm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_asm.c b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
index 154399c5453f..2f8f78abb6f5 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_asm.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
@@ -295,11 +295,6 @@ static const u64 nfp_ustore_ecc_polynomials[NFP_USTORE_ECC_POLY_WORDS] = {
 	0x0daf69a46910ULL,
 };
 
-static bool parity(u64 value)
-{
-	return hweight64(value) & 1;
-}
-
 int nfp_ustore_check_valid_no_ecc(u64 insn)
 {
 	if (insn & ~GENMASK_ULL(NFP_USTORE_OP_BITS, 0))
@@ -314,7 +309,7 @@ u64 nfp_ustore_calc_ecc_insn(u64 insn)
 	int i;
 
 	for (i = 0; i < NFP_USTORE_ECC_POLY_WORDS; i++)
-		ecc |= parity(nfp_ustore_ecc_polynomials[i] & insn) << i;
+		ecc |= parity_odd(nfp_ustore_ecc_polynomials[i] & insn) << i;
 
 	return insn | (u64)ecc << NFP_USTORE_OP_BITS;
 }
-- 
2.34.1


