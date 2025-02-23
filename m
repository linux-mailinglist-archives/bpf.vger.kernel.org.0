Return-Path: <bpf+bounces-52273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D6A40FFD
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B84179C6A
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11016F8E9;
	Sun, 23 Feb 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP8bABKz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62F13792B;
	Sun, 23 Feb 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329027; cv=none; b=uMaYkGl6ghhzLTR1Ete8Xds21m1KkgxBc1M1dbPLLb/J3VZzgJbW0UFx2iLcrmDXhnlwryk90HcXucQ1R7IBNtmE/FaumGO9VOVRAzLwPOJMgPYB41M6tobp6sKrDuBuFWBX/MTe9+3J/LySFIcaqH1viAK+wahyB9sQZVQWybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329027; c=relaxed/simple;
	bh=JIGbdj519hBofglwm1x6Wa4PWHJoF7xJSHZGDTpyM6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRnrNiUqwlLf2xLDpNkB1pZV9t/FL2xvbDf/tYLuqZcBha8+rhracb8s8yyVUu2yYfucBDsECKnNK/x67vt91xlMhMl4un00j1R252Bhs9ool78/fg+n/njIhnFsEZ83Mz+PBEQhd5nKOPGHwY8I7OMFNgJNOGBkQ1uHDXXaNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP8bABKz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso4287431a91.3;
        Sun, 23 Feb 2025 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329025; x=1740933825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Ho2aCKNYfg5T/o22fFzxZ+UyjSx6Fm0wn6W8o8Gr8=;
        b=IP8bABKzIVJdlwzWzDVNlmft0o/mQWGbMN/Ur66+5XF/KrJNlzaeuGPkCqXr1sCiTq
         WpqRpwB09BEkuuwfnp1nWHawlVUFF/jC9+PZ6Oh3iKuXaJRNkEbx6kd2iY0hjGmuISYE
         tJQcE+81Eb220RWkfMOulirlnntMnBlTPsVTnf2NEu9+X7uK52y/mWz/FFJSAjFKKvgl
         gb6ie3kvk6fpm+wC0gpWtvMrI0CFE4lvhvwD/oOGsgTTDld85zURF5+IllKdLP4MY0uW
         J3YVIBUWnmrgL/cX/3v7Q5A4StjeG6t57w15x8SfZSo7LFSotfHtQkgEToSOIqMvKOlf
         72bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329025; x=1740933825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Ho2aCKNYfg5T/o22fFzxZ+UyjSx6Fm0wn6W8o8Gr8=;
        b=Aqc95Y72Yc6MFVZSPSF0SjHm5a3aAuc+Y8O2Sak2h8/vI78R+5etr4FboMYFfizypO
         yflYzh9t9mqNT0QiQPYua9fUhdd7LdJu8P31meuGK09+v9/Nx2+icJe2ela/EUrhbyz1
         9i0EYUOwiNnYZ1xJD2LmKwvxqz1GRWLar0Av0XPtQrZ9B9yRTnkv9PYVEj1tDtvnGYAy
         7ZXZKacqlNnDE9pw1430LLGKOiHAjyZhBtMJFjWCeyHXnRdhteJNeQUDvRvzh7yrW4KU
         LXMGC4CIvpLS422qmb/GzkggfliiRUQCVtxPqTdMorGaPS8W2KAr4rm+N/VMV3E5/Z3s
         gWcw==
X-Forwarded-Encrypted: i=1; AJvYcCUHfUj1IqA2snmLgzjPbqbexT827UrGw0WGT9reiey1WMmBFxRrLSCqZDkgw/VUbMmY4HQ=@vger.kernel.org, AJvYcCUVhKLFPq1nQ6jDulijxhkQdVWzAEKRkdjOrI1pvxFqFMqbTHX7wkV5ZFU/FO5R6wzOqRO+IEOd4kKoBio=@vger.kernel.org, AJvYcCUd6HgvYDHfvOYJe+mN5wGw2ig4azVwEFxRaWPD4QiZxMAkuPR8tke/F3ararl+2ZcMhozaCj3vHM3wXyI=@vger.kernel.org, AJvYcCUfRDrswgElYQNG+HbrSN4gzi4gAA9c5AzZIHSJjhgy21F14T9s24slL8vOp5n+TqcWtQwEofkIOsdRVGXEXZE=@vger.kernel.org, AJvYcCVFE94nnmOJE5bdet8ZbdQ5aU/TfbyjvliHZ38SmCfxRr16aqNsE5Ts6hAv+Zt8rPzj6rvIrGxMIXoF/7+7@vger.kernel.org, AJvYcCVtDlKJlSPLH7bl2ARXMYJi5q86O4hD79qecMbrWlkilWQMSbyEfAlPEzCONSwOFAivIPI4TPeg@vger.kernel.org, AJvYcCXr1OOz9Wf4TR5Rkoxy58gewDFwmTeo5ptHX7o0CbzOefE+kMTiwD6QMp/fhqQwzt4evOfnE53JO4h8J28U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jIPYHaCzC8iipSLTrz5J5xI8C5lOBp0ocLfVJT40CkzEjSj8
	koi921Sr+ELBx9aWYqqx3/PQTdVdIZrJBxrSpk9GjDL+/VIiiKjk
X-Gm-Gg: ASbGncsa5F9m+aiUdIgf1+F/QQS9xKw2ZobApBXW++K1/5PnCljfXh6QCvw+Mu/tnY1
	OBVoeZDqn2nTCxg+nd9fy7CCMsglhre67ZTjMwLHp54Pc7RcwunaSgjQ1K9A4p+48go1a6NETnY
	2em8MNffW+xu6sAzsYf2/2gdNvUvWhTlfNz53fp4ldg0c1K2cSPyaAb8SkzTCvsvM7gg7NLv5e8
	a35aiGR2Lr60BBy98RQr37noT0Z+aDzTqoAXA6W5jj7eSn9N3KRVVaWnlDj+Y3YXuw7pGhQtBEv
	Xf0wRiVfLDVDQgmRXBneRCURNQn4HCVsuAa00auSWlhUyj+PS4ppM5As
X-Google-Smtp-Source: AGHT+IGVq/VDL8yFNkkrNqMmhpwnPeH21AgiBV1Ypn8QzIpzc6gLajBMUvDiltb0IdO3Sbiytrzwqg==
X-Received: by 2002:a17:90b:2e0d:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2fce7b07205mr19070739a91.33.1740329025494;
        Sun, 23 Feb 2025 08:43:45 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:43:45 -0800 (PST)
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
Subject: [PATCH 05/17] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity8()
Date: Mon, 24 Feb 2025 00:42:05 +0800
Message-Id: <20250223164217.2139331-6-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/pci/cx18/cx18-av-vbi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
index 65281d40c681..1a113aad9cd4 100644
--- a/drivers/media/pci/cx18/cx18-av-vbi.c
+++ b/drivers/media/pci/cx18/cx18-av-vbi.c
@@ -8,6 +8,7 @@
  */
 
 
+#include <linux/bitops.h>
 #include "cx18-driver.h"
 
 /*
@@ -56,15 +57,6 @@ struct vbi_anc_data {
 	/* u8 fill[]; Variable number of fill bytes */
 };
 
-static int odd_parity(u8 c)
-{
-	c ^= (c >> 4);
-	c ^= (c >> 2);
-	c ^= (c >> 1);
-
-	return c & 1;
-}
-
 static int decode_vps(u8 *dst, u8 *p)
 {
 	static const u8 biphase_tbl[] = {
@@ -278,7 +270,7 @@ int cx18_av_decode_vbi_line(struct v4l2_subdev *sd,
 		break;
 	case 6:
 		sdid = V4L2_SLICED_CAPTION_525;
-		err = !odd_parity(p[0]) || !odd_parity(p[1]);
+		err = !parity8(p[0]) || !parity8(p[1]);
 		break;
 	case 9:
 		sdid = V4L2_SLICED_VPS;
-- 
2.34.1


