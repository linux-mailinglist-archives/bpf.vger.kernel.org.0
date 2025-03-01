Return-Path: <bpf+bounces-52980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C665A4AC36
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3964189958F
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8D1F151A;
	Sat,  1 Mar 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoo9Ko7s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFA1E570A;
	Sat,  1 Mar 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839294; cv=none; b=YxfikD4e6KYweklWOnS7GGFtQPO0Twy9gEW1hvtsu6SoSBdPm5XY2NqjC78HQfFQJsZAlycvGV+w2vlWHw3yUfjq5RgkObODOwxzEuPagXsxAx26jzP8h1s6t51SOm6FOCJ+8RYZdNOu4w40mU3Nex5EhJaHh3D7dnSYwptmK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839294; c=relaxed/simple;
	bh=VpxAbF0iBul4Uw/Lq+mofgkf8czO0+orTD3RsRZ9cYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=at8cy7kAGT0WiDUKIATPaYmmOWZWO0c1Uz4KSF18RkaTBiDGCSam/si+lRyzLosYIZC7wZxluUuF9pShTw+j+HXohrdfupG/5AXvdwdvWZ2EGTj0MeukCtcCx4+1kKNnyCCiwa34VBRO+E/F++SsManfdjm3aC6wUAG9tpW4tHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoo9Ko7s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22355618fd9so51359145ad.3;
        Sat, 01 Mar 2025 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839292; x=1741444092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzBrmzWckDIJwY51QBb0mQJ5Dqo6Ldx+jMH0V0Ck8/w=;
        b=Hoo9Ko7stR0h0zAYidH+zbNBzfnsfFoY5xhAgyaNfr+CcT1jkILbcLCuvYFaFXhjzh
         E/feNRSAqo7r1vF2a5muAda/iFg6x2InBoX1QnozMNuuT1tCJyDS27Ci9mdKaYf0NazO
         cnpSkkLkBajs8MJi4S58HrgPotHxF6QEE5no+8fx+5V3zGWrzplNzBF0ky3yDzZprPWw
         ZyMMaxE/Im2gaVUAUdM1G+GK09lMqJvx663XgSHZdQE2b75kGtKICgqD9btdc74tUomX
         cu68gR9wrdbGxiDwlZqQxmr4k+eRNDp1KMpD0lFzTgSR5exzwnXHRxBGYay3hsKHJLoe
         yC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839292; x=1741444092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzBrmzWckDIJwY51QBb0mQJ5Dqo6Ldx+jMH0V0Ck8/w=;
        b=RfpkpKYzcwuGEElkaBELn4xnsixSf4KFUybZ6qkCq2F/oTwlNaeV6byy3eZj0PlRGa
         btal4bCa2TSSyF9yWd67BioVT51fGOMNhvg6Q70rxXDwf8JXlLdqiaWRiU6wsu8zLXD7
         XnYX7NZJ2rhDDesqhGUrMK5TN8hMROrTIYJjH3dFO7iQS5u/LBisY4woonW0wBf8rxOd
         jxDbAIUCjFZfMn0exYCRfPtLaBj2PqpLsMGDBJaFMOO0NTir54Xr/1rLkGZeISrh19cS
         F9pJIeRRCKo+ezmLXPg9LhjGrcdiiZbqdunzdmdrwkmC2PrV/SAaW/EPebDnoEwuq6Az
         euow==
X-Forwarded-Encrypted: i=1; AJvYcCU9GYM/SlAr/nqOeF4UFi6w7yC3M0+M7XRd/qKWHabemwxj6rr302B/7iGzRNgeX2D5p39ydUCPvu/ozkM=@vger.kernel.org, AJvYcCUIFznEsR/9QIDmmTe5w1jV/0Cq+qdw7Y6OSPIAPSrr9JHlPeam7+ZqNGkFz9mUvw4NWf3pFUN8Mm9dPgtI@vger.kernel.org, AJvYcCVfNNxB+xmeMcLjSmPSnVLD/PZwaNSyPS/uTzLvVdTDanm7gOtKawU4ZBuKXcm+J0YrVos8w9oJ@vger.kernel.org, AJvYcCWzUxR2QeNE9Cl5oT7XuWBwwGdw0igbV1mDKFsZDq3FMht66BMlhzP3NuCAqUKiu+iDSUtSS00qAJ8+0GI=@vger.kernel.org, AJvYcCXCkUj9j6JNQRFrKExP7s0onDCLuVRfgjQ1njImWWBedq+Lx3ChoRC2aAQGSIg0T/ftoqpromH5TSwbiQj0JQU=@vger.kernel.org, AJvYcCXfG6wvV8/L28hcUTJefYqD8lugwFM2MT19HO9XH5WMGG44AP6RlIyvttk17Kv2qXG+ZYo=@vger.kernel.org, AJvYcCXzajDpOd484kGMhoCRbmbYYCxGS1ep4bBTEQrheWB/X6zLt6RLcbdGiopBVF47+b9cyxARQ1aeW2kuQSMl@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKsW+/VMx7SUOYmNvEP+ztTAfnFZUkmw9yB7jxmlShjWRGjas
	IsnFzCoPMENzJbuR01JIuqgaUFakODk/F224N6gWA2cRYryf1Hxf
X-Gm-Gg: ASbGncuSnAzr82ltOhaysbycI0bR2q0LEQNCr58S7APk2Agj2irSEGId7FsCOGSVsgC
	CUAyUaHDW+HGEodsB2We2mtlqoJKNLU1w1CwTjYUZNHhTD1lc+Hcv7NgDCfX7IDMKGKxp/QEKYN
	XgsgKXUOWsZd9X/j7mio7TkTnB3rzLRyHH+UybpbEx6EmWmNLzWV3kJp784tqXGTpGiTq2bi/Sf
	I2CGOq0kjhlWdI4MtxIUsHYjW6P2i05f8umAI60p4O5lIW53ZF3JQYtapxkN3ZJXsHnycTNrMTp
	/6XUzZu6JYyGo3SbHIbMpGlvvVvQo+v2h9JfTLnJ/+wnR8rFxea9ElPiCjyzEbGEIm5RTpo1eKc
	=
X-Google-Smtp-Source: AGHT+IHOy6Wv/sKHhRUGc/3EBAQcCBF/SI4YUeW7LDGDR7+GStKywND2M264p9e2dxtzneP/WiNrxQ==
X-Received: by 2002:a17:903:fa5:b0:220:f40c:71e9 with SMTP id d9443c01a7336-22368f71f0dmr96371785ad.9.1740839291945;
        Sat, 01 Mar 2025 06:28:11 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:28:11 -0800 (PST)
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
Subject: [PATCH v2 17/18] nfp: bpf: Replace open-coded parity calculation with parity64()
Date: Sat,  1 Mar 2025 22:24:08 +0800
Message-Id: <20250301142409.2513835-18-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity64() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_asm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_asm.c b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
index 154399c5453f..3646f84a6e8c 100644
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
+		ecc |= parity64(nfp_ustore_ecc_polynomials[i] & insn) << i;
 
 	return insn | (u64)ecc << NFP_USTORE_OP_BITS;
 }
-- 
2.34.1


