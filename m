Return-Path: <bpf+bounces-53488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D47A5516C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E283A80C8
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F52505B6;
	Thu,  6 Mar 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcUoBAwN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F98213E64;
	Thu,  6 Mar 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278518; cv=none; b=mYmC/I9BcRzxZN70MYEI5Ed+77rGJqU0DY5yuJ9qp8jyHiPVsDBye985QM/kTppwQOm1X8GsD6ae1SiEZiTMKg0UVkg+D3CMRHBnFop1hWIhgLAptwWAqpVZ24g2XLXq5WOxMAlvBIYk5Lp2bqNQqYMbe3ERscrBW2tKABkEyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278518; c=relaxed/simple;
	bh=I6WJGZ+wmJHASMpeshHLkCaDYKparCJHsPTSZrYO2e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAKkn0IXk+fH7mF0e3MKn1G5n82SgRMZaU7GjN1xlUS5c05tcHsZCbYx8shOXPihRyImA6lpcb7z77kAz/S8JMNQxI0hOKFRplCuCUMAkDE1PQqew5RjrQ4cl7DCj09Jcf7V3GGaS+UkPGih1KmuB/U92eCrdTUgW3rvbMJnjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcUoBAwN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so1485876a91.2;
        Thu, 06 Mar 2025 08:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278517; x=1741883317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlCo47pw1I/mq/I7vHIVVBFEFMdGZP7EQcov25MLW34=;
        b=hcUoBAwNnnHEBxps5zeFU/Y0zD0u/WtBJ40PZNM7MlRn4KSyeDkmzCeL0EiGovEF5O
         Fr+LW0r8FL+wQOfMysJyaFU8iSLQmb48ZaLG0Z6eFRpYBnW50wMbhMD9Xu6BAOI/wPqu
         khs7QC/i+KLlLFVatGPdlmpCCqyaGD+6OlOjAs4c3E/t7E1EsE+595r9eB4sUHKmLlIu
         gblcAu8H3IKfrRrpH9MVzFjrsepX3ny6RiKWYqm6/Hn0U9usM7dEDkPmH9DktpVGlrY5
         SCvmbyp7D05+H0xYcNC/0G5hOoZQPcu8KqvIOTI5DEO/yC2Y2xRY8Wb/6hqbO5ZRzksK
         WzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278517; x=1741883317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlCo47pw1I/mq/I7vHIVVBFEFMdGZP7EQcov25MLW34=;
        b=TsfXnptNjVsUNHeGlHEvWpBqH3WGQt+OGJZ+Fd7R6W6pZXraBEB0EaSwFGwWTnCCJI
         r6MqoT3+vfr5OKxCqVPlWXceySxSeXmW6CVrOWd8Z4Pszg+V0a0NIziCKeX3OP+JXc9R
         DAwywgHA50hOqBh7dUoAmg41IQo4Pg171OsScVBwTjg8w1SIbE4ad38QQpeRWh2mMFjn
         qJeFv4N5a9br7oCXWnthWJfYimowELPShlu3xa7AzpU9NsutYQiCcUnU3IeDM91T7GQ5
         D1rRIx7vS9TUeH34dLlTvI0A7cSXno1kviTZcLbGmwqsovpF+1a0lkzAxHuVMsC06mAE
         u76A==
X-Forwarded-Encrypted: i=1; AJvYcCUfFySXOEpRJ8acvCsnDzRp3KrR8gjnurHX6pdDoUhD3Ny8mCmuAJSh8d6rY48AqaWzXlKmc3Il@vger.kernel.org, AJvYcCUpZRm+PeB5qcrcs8v8R0QGudtJ5c7u3JefCA8+1qef2HBtn4oUqdit+8Vm69whyHbbcdo=@vger.kernel.org, AJvYcCVMnCwgMgITiNG3O2xnXTBqEv8knEqQOnEryy3dxZDS8RkPFg3Cmd6OfRQ4+YLwM9wzrTtf0gEH8F3ptaOaTAk=@vger.kernel.org, AJvYcCVyH9wQBsL/8VVI2Vu3QvOo2Z3n3FjtDK0a4T1RfEW9hN7TJKZdrtKo2fJIZI3FNyLa66MkZkHpHiiGGgs=@vger.kernel.org, AJvYcCWg7EGb0jLO7Rm4gC+ia4RCieiufy7l8D34u6Ky9dLPuBk2jo0tOJyQXt9i9rPAU3tvhG2gZUssd0TBmKE=@vger.kernel.org, AJvYcCX/VPMBctiekShGJ4QnXkuE6kZHVmNPQwg8oU31KEq2ilrBdAo1hMbzjBw16AI6sT6Wrj1koJEv5FQqUTjU@vger.kernel.org, AJvYcCXlcnL1KPwDBVCfjskvarMGP528egwBuYsJknlgFvwSUI5CT18xNWkrV7qbp78DcsPtk1VwlP1gUZC9DVyq@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyWkz4OmOIIe+NyO7/i4F9xo40jE0efNKkdzSkGl7827hNRC3
	bhZg2W0Okkmico8ZJ18nc7i1ktDxi5x6H31sXfnzPZjaPkAabB6d
X-Gm-Gg: ASbGncuNLKdf6m1Eu4el34okOxRqct+GvQGRRT5gjtgyY9GYJ6EGrvM8F9Defs6TLhf
	SMDr0ef3SKzZM0tR9MBoSZCWOgJLVeDy0Qwvulk/fUWjhtS4pbr8hsnH8d1jdWCwvAAADhijmxq
	V1719bb2hmGa+aKz6+0jhhQ4Zmw02+jDlfqYl1CRipMnP+ilHC2bu+k70owQ7qf//H1K56x3Tf1
	pm/4sAbslquYTOwrYSM81iv+ceH6u2WwhTla+PJiLcGGmWmzy+pqopme6Qb4C04k6PFcVCBrnKK
	SJWrKvjqBg6Et6hxNBYXE5aEY1ja/meggbh5Aj7cRqyfrHY0OifLeIkhTfXB/dOGfBOgRxLq0g8
	=
X-Google-Smtp-Source: AGHT+IEEoNncBZARV2kGM5Yy+T23A5PpEPT2NiyzW+biIXJ8M18fImFLR3KC2etUuhFwV9KdupSQZw==
X-Received: by 2002:a17:90b:1f88:b0:2fe:68a5:d84b with SMTP id 98e67ed59e1d1-2ff49716658mr11420319a91.1.1741278516777;
        Thu, 06 Mar 2025 08:28:36 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:28:36 -0800 (PST)
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
Subject: [PATCH v3 16/16] nfp: bpf: Replace open-coded parity calculation with parity64()
Date: Fri,  7 Mar 2025 00:25:41 +0800
Message-Id: <20250306162541.2633025-17-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity64() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Change parity64() to !!parity64().

 drivers/net/ethernet/netronome/nfp/nfp_asm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_asm.c b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
index 154399c5453f..14306f128497 100644
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
+		ecc |= !!parity64(nfp_ustore_ecc_polynomials[i] & insn) << i;
 
 	return insn | (u64)ecc << NFP_USTORE_OP_BITS;
 }
-- 
2.34.1


