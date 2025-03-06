Return-Path: <bpf+bounces-53482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD16A55124
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40679173CFB
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A823F40D;
	Thu,  6 Mar 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEhyPLri"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7621ABD4;
	Thu,  6 Mar 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278471; cv=none; b=e62rn+i0YagpgyiLySzQJs6n8hutO7d/J3CDTX2JB9jhDT5LDwgKNIQFthKFgFiHw2Ef64mbThKg3x02kpbgLptReYi7bAQIHKh7WMbqhvaMJ2VQOyqdo5phwVX4wsZUg6/lXflhPNhK55XA996D6A7e4TyurgX48RmKueoKPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278471; c=relaxed/simple;
	bh=kbOoF3icqMO5cD9NY+9tgI31+VIx+Biv/oapmdtrbUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHWMLN90nd46jRqjco9qThtGAx9/AsDjftOoq+WEJTCqpXIgLEpjFiTTG4GXuw5zVWFHRLQ0Lb5FyAko1cezbaX1ND3yewKgU0EUYW+uUFd3kE+RWs9O7m6WTxQYYpS/tViapndAJhexycYQmSsqCsnCgSaPerrsOYNJFj1fbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEhyPLri; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1507938a91.0;
        Thu, 06 Mar 2025 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278468; x=1741883268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lzzZDV4xgSskf5edAWcKAl1UECahSIOp1fWE1tA1yk=;
        b=WEhyPLriiy/t4YSv/K1zPJ0ehrScWFvkb6nEwMjKykDbN+dtMs3at3nt6GAJeMbZ44
         j9ES3zSW2SF5HSQkKI/dVjFn5atqwwxQUo1mTONas752J+pm9xZCbYLMTrzAPK8gKboB
         WllB6wJTNnGTGS/8qhw7YpQsvstx8av52OJaLKOlk2DRC+HmJNO48jtffOGdt2osazXw
         UO7PDdj30bcBF1MxPHgO+nnBkueBNartsQNUOl9AHDQRxsZlijZvyCuKt2/mYm6Owbuw
         pDWSRpycCRvhCkrLkg/XlQDJvGPtMIHO5Q6TGuqSx7bS8W1A2QU5/N8r8/fKfVHDfOoi
         ISmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278468; x=1741883268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lzzZDV4xgSskf5edAWcKAl1UECahSIOp1fWE1tA1yk=;
        b=Hww+KRoqaZRaoMy3XmaygMvF1X/Px9+bWi+uLws1tpNgwjwFWyi8Ptizz4k3SSpFRZ
         2Arwb9bSjVhGCAINl+qTjOnG6eSvDv+biTvi4JoB4tcKboANG4CpPaT8dT3qiJ08KxNn
         6syGFvYjRk0zS+HpaF/gS96pOsNsnkaHXL2mhmPQIQfVYLA9KFxqO/9+9z/ovk++x38b
         ma3tSLIhr7VPov1gUVwtebnIBSPd8xmRAnxgAf4dQVp3M9UGLYRovL2cLWV2Iw3D8SeG
         rpJD1vNC4hckTL6cA85Z9T8BWi/tmlQMPx+wbeaZKj1D3okWg1h450szYOPzGNj0+tea
         bBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL4h6DFxGT1EzoX0LUsb7f7F5oLnK50wl1l5JSMlIMfWiJILd7SCYd5GAFBwiucltsuQBcM3WO@vger.kernel.org, AJvYcCVKhHKCqLUO1vn52ejUhBE5PZ2NoWSMEfNNnO9EasCCcyJIvpQHn1gXu8F0csQK1WK9kgs3L3tVD0w4zfZCFkA=@vger.kernel.org, AJvYcCVkQRxwQ9xtOB4pugHstvn4IUj2Am7NoDqy89M3tKnvyCoGSgqr6UbVlDObYiTG8ZEOOIf2V1TmZtV+fMox@vger.kernel.org, AJvYcCW2HMFA0ibPLHn030wQSwPV44PYVxV4H2w1hpF8pvHxszvt/BL2FBzXJonpZRbbbotGz78=@vger.kernel.org, AJvYcCXVJSZv6v0mnXiilR1HSaZW1iz7OMTFRFgHaRIShOwh6WWxHMmxVGZe2iy9V+qYpv+9D2zaIiXFLpGW6WQ=@vger.kernel.org, AJvYcCXew1aYpo9NZVpRv7j3/nZq2jBCn30FtmGeplFQR4/DUp6I7Qub93my69xVGKMrO96TDjCkw80R5phPPus=@vger.kernel.org, AJvYcCXq7aQJA37P3vZ3j+1/cPPNjfm7HKOI9dqGbvRqLOPIm5oFF70buWCb99LN9vkf3OQyNiz+yy6bM5NbPKmt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6bPQ5NhdH/esUPdaQLGRJww8aJoEtIlPrOmBD8O9AZchZqOw
	79sAFnNoRlvPeX3MaLhnXKU2NyxKJC9m3yF9nqZWWrKpc7Ua6nNj
X-Gm-Gg: ASbGncu296kIbRoR6zU3uj/c0W3d28Rt38dc1H/SZJaOZtpAHsKSMs3SxFTUmVIyXEF
	Uh67D3deZxF5A5nkc28VcGKDqyvwJHAQIaH/u6+tM54ZFXW8EiXiFmvRi2VUPU3pDGUtxHvPG+M
	lhmsN3EeEeiyqmoa4G0JE2Ov6VbbKVtAK6Hz6vMv9khOgArfNtOscQwtYGJmz4Q2QjMTj5zoGZm
	mgduh8Uu3gRk2zsynCJN0Zkp7kYEopuDoeNyOH7hKywykevrRetdyvxWwGZQ1whhKv1xAn3y6ay
	Gdw4v8jypdsp3HVNd4WsrN1hdebfDfZ5P8yQjSm/s+9TClXHxuSE8NHn9eBXnPgFGB2bX70vZxQ
	=
X-Google-Smtp-Source: AGHT+IHWBk8+6ksfik0EhK6cGMIWVO4KCt6lAGGIta1FZHsm7ob/3ELoZ4FHcMM7AbzddV9ZAUKTxA==
X-Received: by 2002:a17:90a:c888:b0:2fe:a77b:d97e with SMTP id 98e67ed59e1d1-2ff49728368mr13045551a91.11.1741278468014;
        Thu, 06 Mar 2025 08:27:48 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:27:47 -0800 (PST)
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
Subject: [PATCH v3 11/16] drm/bridge: dw-hdmi: Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:36 +0800
Message-Id: <20250306162541.2633025-12-visitorckw@gmail.com>
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
- Change parity32(sample) to !!parity32(sample).

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index cf1f66b7b192..a992ecb149d7 100644
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
+	return !!parity32(sample) << 27;
 }
 
 static void dw_hdmi_reformat_s24(struct snd_dw_hdmi *dw,
-- 
2.34.1


