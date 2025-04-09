Return-Path: <bpf+bounces-55546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33AAA82B35
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EE67B6093
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3827780D;
	Wed,  9 Apr 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acq5Z1In"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E5267B1F;
	Wed,  9 Apr 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213595; cv=none; b=NsqBZdaJh+8cRgbAWBqF7c3d97NyTGry4lEBi+zoI0FdyjRTDg9vdlwJUgsjO+3cCUww3DyS8W+ewRYkjKqSgcZEqb3bGzqw4MnsZOoOiVbF7lGjduT0YePnfxkh75M4ZNNZuoATbKDAcl09PsUR/kr0P9H4HcxgJnfmYzkCu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213595; c=relaxed/simple;
	bh=QBWyEkuiMWNVhDuO1rQlnUBmammNz6BWECv9ZgXDmxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvfGJuAXMXDly/lC8K+jiivUnMpgarrFrswxmcv8MeSsRIsBFNkTKMjbcAIoRe9sLoLxPXHkznJCncM7tgYscXRxZNnLikU2Y/4dszjREsJtT7zdslba09XpIzTwsZBlg4z/Nj7RrWLl+mz3GLY4Bcxy/6rXLOk4NDSZWmLt2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acq5Z1In; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301c4850194so5658576a91.2;
        Wed, 09 Apr 2025 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213593; x=1744818393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxwU2Eo6SZITicqBQinN6iBaz5ky/0lGxu1bDy42GZ4=;
        b=Acq5Z1Inv1aSe4NrQgTz6p9RBQ7R2/6Va4Qs+dM9/5P3L3HTVXPBabdTT5YUXlrDqA
         OmGPunnP9ijqP7u0JsEyg7sKwf9UzflsmdOOYYWli5+4VxI3ao2GhMSfIAIruw0wLzFt
         l6fRf21L0afjODm1FMrerpOoY1iVN+xBfUFgAY5e0tUI9ZWYGfzUk45rjMbcDo+fxdAi
         VZF5PmK8H8qRRT/oI5b3HHL8FddTgEMFXI36cPFzxA0Uohl8W8KTJJeMnOVwQEVm62P+
         hMeGUDzqbscd14mgdP0Qn7z8ZBzVArh5XHX6Q5sh834ihhnweZtZHNCt3zE1Gfem41VV
         pLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213593; x=1744818393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxwU2Eo6SZITicqBQinN6iBaz5ky/0lGxu1bDy42GZ4=;
        b=haaqMLyeM1J4zPU9xpOgzhHGRx6D6/8Qlmy3J1PVOW9+ao3iB377s7SSYoacC+NTjj
         vFMQgodGW+HWo3xpDTvZ9RQEAiHMeojMDBbXa8HUUA6q2eOFrluc9FpQsc8iI3O2dWjB
         gDMbQwOcg2JbbX1vIkrNlX4x58UzVFNk3buTQ6yWIRfeyU+Sl+cGzWRfPYr4ens7Lb4G
         M69dU3MAEAZanHz3RH5iCtF0RxQVrDTjfFHbYJPQlPEvkneMSwhDXox5Z6qxsU4hLoP4
         hAtXUND34ZXB4yEO5Z4muIvETp3Jeuz8tKGPrSuQtExdRCPTm66+R2fgCJyH+i/NDAdi
         5NRw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Yws+FJxrSkBManGDElfoJubSv0WpH20nr+YF8soUKLVTW+A+nSL8FUau0Qir+wgsAC0maIclBlr4SlQ=@vger.kernel.org, AJvYcCV7kQYXNYhypDrgDJ5Sb3lvgLlOOf+Hu+03Ngj5T0Ghm0e2JkVHPcc57Hipkh1u3WrEwA4flNb/@vger.kernel.org, AJvYcCVqDhbIt3pUPnPPPFCJ9qrLNHiYKEnQPheZkJnuv2Kh3ZW59gv/4BFWKcIVIk+m1Lqr4yhVTEWtk9TOL6E=@vger.kernel.org, AJvYcCWJcXobDL8F5xKb+nkejv4jjzWZT3erDCvd+leprNy+97Gd6uTWRZoN88pKrgwHVt27HVehTehX6Lj7ShASBVc=@vger.kernel.org, AJvYcCWdv3BFga9tR+MlRDuCReReUOfO7HYc9xaLlRXAsapu83pLVOir/brkf84GYcj5rpJ3V+vg3Zmgx4uH+UK/@vger.kernel.org, AJvYcCWtX5MOMCzUO/oP25LHqe7YBWl7jIyXpMPoVzivByKY+dgaBjwt7VNSuuaYjSxU4oGVRIY/D4sKRkI1/MQ=@vger.kernel.org, AJvYcCX6JphosHhUbHBjUvqizBB0cLk4/5ckFUng1khXL9AhQ+48md1rTu6NMG1XdOnOjd6dg1nC8H5CcS+UWoSr@vger.kernel.org, AJvYcCXwQBlboEroVVG6aB5qsL7XEE2ZwfbIQ5fyxubq2dKVACbAEumqiPvHJMmjN+l6V+3ONew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXavA8v8Xf3bvJN4889NlPXv0LF4K6ChIyW42mRSdff5M52Nv
	ByVsiy4VNQ7o/MOpZ0P3kur8K+R4vliWYXvIlEQmpvDPxx0oZbNh
X-Gm-Gg: ASbGnct+hVrDRJlravWRr1COL5/U3XW5AjLtL619fqbmEFjfX3NdtQ4vPufKVGVQfPv
	Md9rBoV9xS0YXMUUVA6EDYuORcbn+0U8s1g3Jwo/ju+98K2GdhSfIXsmz/bZK++R+EP7ZWN0oNm
	+QCaJzt5h3NfGaduwlstPi74ArA05J4lDHaPMWemb/wtGf1w9u+2E8gS0gu21SpVXD+eDmp05ts
	cjmk31I88o+Ig5km+Dbyp/nSXnhxUPFAyu526/WuuAFCBg8N2WFjoQzhi7cyx+uPHhiQAObJ3wo
	FsK1bfbG7RZE0NUUIGeF+bWPR0KSTV2+qpGPgYAq1oVZ/AwkiyTusVYIIgdxdBD6ldy2Zcg=
X-Google-Smtp-Source: AGHT+IGJskC9aR+5Dgsn/0q7tVfn/b9wEb0pUAkxSpjYPK7zbEkvmX2PCK7JdW0DCG7ccVky18srmw==
X-Received: by 2002:a17:90a:c887:b0:301:a0e9:66f with SMTP id 98e67ed59e1d1-306dd521d88mr4820575a91.14.1744213592804;
        Wed, 09 Apr 2025 08:46:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:46:32 -0700 (PDT)
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
Subject: [PATCH v4 10/13] drm/bridge: dw-hdmi: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:53 +0800
Message-Id: <20250409154356.423512-11-visitorckw@gmail.com>
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index cf1f66b7b192..abf2c72be622 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -4,6 +4,7 @@
  *
  * Written and tested against the Designware HDMI Tx found in iMX6.
  */
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -171,12 +172,7 @@ static void dw_hdmi_reformat_iec958(struct snd_dw_hdmi *dw,
 
 static u32 parity(u32 sample)
 {
-	sample ^= sample >> 16;
-	sample ^= sample >> 8;
-	sample ^= sample >> 4;
-	sample ^= sample >> 2;
-	sample ^= sample >> 1;
-	return (sample & 1) << 27;
+	return parity_odd(sample) << 27;
 }
 
 static void dw_hdmi_reformat_s24(struct snd_dw_hdmi *dw,
-- 
2.34.1


