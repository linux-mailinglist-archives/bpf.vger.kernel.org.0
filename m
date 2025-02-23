Return-Path: <bpf+bounces-52285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B7A4103C
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592563B8799
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C692920E70A;
	Sun, 23 Feb 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjTBecVn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F20137930;
	Sun, 23 Feb 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329160; cv=none; b=bsaA2DGOgoZWFl0GAA02OUDLa92XdRTKy9YKSr3kJdBifcgy6RzLD8rjwOlvFFl8XlxcIqNLOGisY7/hekTukTsPQdc8W6AXlygjSf9G9I7fkXmfM8IFxv75tF4yc9OitDMQjRcyfGACt7KU1fYuB8rWXHetFxaj6Qo+LiXB7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329160; c=relaxed/simple;
	bh=VpxAbF0iBul4Uw/Lq+mofgkf8czO0+orTD3RsRZ9cYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKoDvYpGlME5HH4x/3ueOzqJ47bNM+8hEBO8S63bZmigIQX9Ryud+HcLo0PoJtKwr1H+SHGh2A76u9n5wXIKUl0jk/qB307913/GuFTH1pjbGy2M5zNu3Y+e/ubtVn2PoGvDsce52aboTBRdRcl5E/erOHf4RtnCB86BEC6MXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjTBecVn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso2745195a91.0;
        Sun, 23 Feb 2025 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329158; x=1740933958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzBrmzWckDIJwY51QBb0mQJ5Dqo6Ldx+jMH0V0Ck8/w=;
        b=CjTBecVnq+JEtt0Olvb3Q88N6Dhx8qwCfRzSi8G3dBD9JUn6ZOwA4fAZOyC7XqFUwJ
         Ai+//fykwUUGeVXRRlsC3AD5/b39+JAm/GArUx5PTB1uuF9y2bHJHUq5RUXw/ZOyRh2z
         pVkg4ZsbmEMnONLEsBz+FNGLIAhgC/DomaPhiiVrWNv7M1P3ORHQr+c7u3ilTgyY0WUa
         efrxFGT/b6Rrkw5RNDaDxjJKTLlR6C1Tqk5eIxxNIcuQqi7NDD37e9eB3teiAZpvemRc
         oZsUQh8wKHCJ0DwWRbTJgvuUfIjPibil7GStEbQYCkOHHqUXjcuuNgfdfVs8ooEdBJ1+
         UzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329158; x=1740933958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzBrmzWckDIJwY51QBb0mQJ5Dqo6Ldx+jMH0V0Ck8/w=;
        b=q7H6ruRe6NXtMZHPIv4+CjOgHK3Yg78kmQEXKpdcxeGmGafyR5OxtQnrTCGKFzDaKu
         ZAl+WzLvT1Tt8KoOFe++MRmm/QEt+Nn1BQNtAHWPmXYmCVGT9tTN0sd73yGfcNGYzv7o
         kwg/eYFxawFBgrGG28lJY8xowH4cIutfwXejpjaIxkcGa625k5TvsNPRl502kGGKaPg8
         M7ekY/CTLBQqlGYW6LTClBIKMx35pSfWDq9KPG0UKgywMsVF50Eq8O9+mhPyH3iUH6bG
         jMOohZ86oGJn637NIacGcL+EAqLxK+zIQASq9rjYMHzrLr9RESNSK7wn/uufDkNM6lxx
         MzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4xHnIMVo3PaOhn5mHUx5Hbs9ss1mSPb8GiYUyo+Ql4AZifQKg3doNQe0PIo70YsblOc+S3mfc4g1Jx7XIucQ=@vger.kernel.org, AJvYcCUnlqV5jl2oc1Q8LAuJjQ4ti+/2GEBLdaagGHwQ/+ydKhncSC8wWacrSeuP5G1gxg/uR+ckitnkSTKMlGc=@vger.kernel.org, AJvYcCWe15N4jzuvZg0Y+TPEDD3fblWLlaUKl3H/3JSdDJDPZXOGiHJDjVD7oq+SElamb6cif1K+Px91@vger.kernel.org, AJvYcCWihHuNyULU/0Ky+ZXZkprpBD+UviUAZEiy39ANo96PsRVjh2GlSBnUPmSFuqUlTee143jHNRCEg1+JCwPl@vger.kernel.org, AJvYcCWsCYLjy77JWWM4+crkA2NAowTuP6ebceY/ozLOU7LELsVq+PnLrWFuQrtxnK+WJywS9iYp85E5YGCH3NmQ@vger.kernel.org, AJvYcCXXCAwKRHPbdeOaOoZRkIbIl5NEcTdpJMAM99icnvx6Aj8LIyDKLLinNM8zLwPMBvKuMrc/ev7pNm86Ol0=@vger.kernel.org, AJvYcCXgUuLF0d5YwCkuszlZIuEMFqSQ4RyHlQBjQeIlUZluoGibS+6q+9zg6rrCQyW2WSdvoIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypD5VxPgb2Aut9aRJE64Mg5TOP8NLJgCX9b/dxe/aemH16KfD6
	govjoY8onB9KXlSYaddDq8n6GSjXErrDhcL2nFLJuzem1aweAMDZ
X-Gm-Gg: ASbGncvf9SIYzpOy6HkwKz3qWAxzyQAQuEL9nxb9U4iJ18b5vOtfIj4qmjabMgLoyYp
	xRR+YuPLQTOezJp65+OxmED2Zc32B/jL7bp7Ow968gs9mX2qLS8dPjt+FFR19JuOI334dNWlR8j
	lb0SUKJsSGVjqDRhPVKDJY/+ZWnHGnu6IbdaKLfeX/6mK1HSEGMqsKoPQJNdvVdhKs8A9kcDePX
	iGQQI4bxoB0LqvZ0CS4x74CoT1OsKbjvQ4WRFebN5jx+FTW7MOZRqqUFxETB4NZuJpCZwXKIUyo
	4VoPpHWbgfuVHpyhzG3zNJbDLwnUIagV9fyfGRqoPP3QuxjzujRZKwSW
X-Google-Smtp-Source: AGHT+IF16AG7QV3yDJH/B6gDeFm18hoNJMWrJMQH/o1eQGkDQfNTajRN2mVaQtR8BSlGLJjsCZspog==
X-Received: by 2002:a17:90b:2e44:b0:2f5:63a:44f9 with SMTP id 98e67ed59e1d1-2fce7b0acaamr15082851a91.23.1740329158110;
        Sun, 23 Feb 2025 08:45:58 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:45:57 -0800 (PST)
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
Subject: [PATCH 17/17] nfp: bpf: Replace open-coded parity calculation with parity64()
Date: Mon, 24 Feb 2025 00:42:17 +0800
Message-Id: <20250223164217.2139331-18-visitorckw@gmail.com>
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


