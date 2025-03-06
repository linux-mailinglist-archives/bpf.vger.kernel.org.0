Return-Path: <bpf+bounces-53486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209ACA5515B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0751880739
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96C245031;
	Thu,  6 Mar 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aese9qAZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8B2139A6;
	Thu,  6 Mar 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278500; cv=none; b=gFTPipviFw9fGmNf1CfXOt+nEu55Fql2S8jfQ8Knpln7Y9jKs2vfvrtgag9tq5Ac5PmawlhnZM00965VgCrF/6znXji81/jcCtCC3HhN9lbl/p5We4F6OxdjR2iP4GVZmc4louWi8Lr/QIMNwHShMDJi/hQZJNkoE7dRxl3DAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278500; c=relaxed/simple;
	bh=Wbj+Koi+nWFPD6iLPf9X8IXOjBAM7BvB2b2RpboElIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIWmaLekbvVNYqAgvkK4cmtB3oQhrAgmWrXsH1CrYbizC/yGzanpzC7RbocROewvBFRINYX+zm265+jCCbmwnHW1m0QXdvV1gBcgGsKm6kF6dY1ZRPmMoi1ljkn89ow+kNsAr2XzUqJ6o1cQ7xSmGvFf4LCTPwuzB0fsou7Ch38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aese9qAZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso1640782a91.1;
        Thu, 06 Mar 2025 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278496; x=1741883296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS9Ngq0ErapA9ho16k90z8id/zApcMAPWGpuMTc0x9A=;
        b=Aese9qAZgdqyfZk/8HD6AF1tFDjhIKKKYqoliMrm8IvASf+ODDYeAn2TXdZ+sbtpTx
         EBj1gjWZEq98p3zfwT4x+3JnwlzCevaU4wMEL8kkDUk92vjZTcADYF8HTSK3UfihySw2
         YW0lRMFw1YuKXUtrdFzdgZ7wFeWHSHnn3iOXHU3deHYiNFqTObkbun2/LxQLETjeefH/
         +Ct0P0Q3oWYmUUW/PP6hJw23T+zzIEioxlRwvvBuqe5HhuiEh0AOT0HzjY7VGmkVJEAf
         +YXMMEvPXeIUZZsxkHvru6/z7MgEddqAJuFQKNGxylNTX6ZXTIU4VUvWZaWHlgFDByZT
         Qa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278496; x=1741883296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS9Ngq0ErapA9ho16k90z8id/zApcMAPWGpuMTc0x9A=;
        b=DV92oCIPQnMuVrCqlc2DjjGlL6ViaLZYmQqzcvNj4EUPnnQoqaRgosi/sFbMhZXbNt
         bvJ9UM4NrlRmiTHX+mFzUY/r8m4FWoXpYt9reUyD+4gzsf++ivcytrW1lEwb1DZnxieU
         bX7ta00Y5lTTLrWHJ6ag035I43QqOAF4ws5d4I5U70GUIwAlLYc+Y78BiIzCc6yLKnEN
         taFu3fywtiM277d4W3eAW2Y5FZ6tP3pZT/C9Bd4ebXkLC05upb5YEYUvOTeWeBcdO+b6
         /+YrND39VkEVBVSZ9ct5Fcl7dRxfZZT/SLkDav61pB9CBLQEqdxpNkSSg6pLFUYd4HKA
         jqeA==
X-Forwarded-Encrypted: i=1; AJvYcCU6P1mxlad4pBuDzNrMGNszTzpwfbLIOuqJ8PP3eeVjtUM76ek34SgwyvKfRByxpq+y+xY67M886rhTy2x3@vger.kernel.org, AJvYcCUHP6ipiWy7IFAT4OlBPp0o6Wtw7L11c17th//MlOlQRjk5NkjwjTm9GQV6tkJX7PHyjLjqaLkXuCNKVP4=@vger.kernel.org, AJvYcCV3C2EsFte+6J36lO+N0/lkbOADcghIe42ob5+0C2sa2zGCSDAuhduQiYZarpoYKfVYMZg=@vger.kernel.org, AJvYcCWI84c1+HsD1zMoIySzrF7IsKt01YQvg2xgTUFu5fOQ/hecuebHtaMkzaBQiAbHKuHHBKcol5K7MAFBYmI=@vger.kernel.org, AJvYcCX0ED0v+JYaz7Tg4At+HpZzjDi7GVME8lqzVrkj5+VCrLV3tw9drA6CagRp0pzpivLB7loEPcpCyqn4AT0Rdtk=@vger.kernel.org, AJvYcCXKVaZMA7pwunjJwsgZDxQLm3/BgxnOBGKhB5G92daRmfuxcpZD7BkasxbYNcmItx0JBDOWq4Hg@vger.kernel.org, AJvYcCXQhUuLL7VLkYafLoEFsXff7EviLbjr+dTAJdWmF4QoIhwXTpdereSo22x/y8s3wZqPUlKzlhSaNDUsFuNo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxn9Zpr/v0SVLz8oOu/EYmUkvi4+ljWf6Pf+POCaI3ec/LLkqP
	ma3xNi7r0o6aA/uFcs82nvKZ2WZJ6yl+8X45ylOoYyc3uyJa+BhG
X-Gm-Gg: ASbGncvCNIAn7ut8+ir7s++1jGRLiXgJ5yootoIitgHHlHLWeBmYlJLKZMUk2xaFB4q
	SZW0e6gaFTc8LlPSHvIlZaeXNW0NFnjQqOwy/e5Gj83kdiURFLnLX3iT2uEqcwn3hgUZCD1d6hp
	bu0UNRj5X1DNZHUvsoS5Ilv37ErRkqgP8ijpre7WlvtGAhaxA+twiPjEKWzdnZ0joTUAJqQi73V
	FsdYtoPY7b7HLwgb5RojsfXPd+bxQv7qlEHBIjOrifOeN79YKM0FYzaUOsW6Lz2JO6+8X8Rg9gV
	ohsTNbUwJypO94MIW5HyLEc2ic2j2228765V0SvX42pLS8yXvU4wbaxNlO2NENXDjzLgGlSsf8E
	=
X-Google-Smtp-Source: AGHT+IFnMh654YdQkj0YFSRHf+ssdwCg9qa/rMgaUesbiD2om2YrQrVL25CKfgP6tloqN6SwFoBXOA==
X-Received: by 2002:a17:90b:4c4f:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-2ff6162ec0fmr6970693a91.0.1741278496344;
        Thu, 06 Mar 2025 08:28:16 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:28:15 -0800 (PST)
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
Subject: [PATCH v3 14/16] fsi: i2cr: Replace open-coded parity calculation with parity64()
Date: Fri,  7 Mar 2025 00:25:39 +0800
Message-Id: <20250306162541.2633025-15-visitorckw@gmail.com>
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
- Change parity ^= parity64(v) to parity != parity64(v).

 drivers/fsi/fsi-master-i2cr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 46511236bbca..3356c478e395 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -44,15 +44,9 @@ static bool i2cr_check_parity32(u32 v, bool parity)
 
 static bool i2cr_check_parity64(u64 v)
 {
-	u32 i;
 	bool parity = I2CR_INITIAL_PARITY;
 
-	for (i = 0; i < 64; ++i) {
-		if (v & (1llu << i))
-			parity = !parity;
-	}
-
-	return parity;
+	return parity != parity64(v);
 }
 
 static u32 i2cr_get_command(u32 address, bool parity)
-- 
2.34.1


