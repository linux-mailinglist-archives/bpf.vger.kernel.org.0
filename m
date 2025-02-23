Return-Path: <bpf+bounces-52279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270EA41012
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899083B6727
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4B20550B;
	Sun, 23 Feb 2025 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVM8wdUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CAC77104;
	Sun, 23 Feb 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329095; cv=none; b=t1k/RKmPkURetcec5XnSDMp27wrDcgXCg/bfXLc1pmV8jQWKTlPyeq83R8gXmF/aRXndBbf5NtmN2fAs6la+DHUFDKwrZguPBfW7vAwSzDc8QgbFgYMUk9p+I2Vk9p3i3CcHOQ0Keld7CRqO/4TvXa30ET0XO90tr5QHvZsENs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329095; c=relaxed/simple;
	bh=v3VP9b1b7CvlBsixzdFcwOQjjl2Hrulp8xfqmv1a5yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOuu86/zdBVQBB8Ke2boeB2Udj/eXnSYd1d8OX7bKzZKm6RWkMCKpV6hT9fLpd+v4MqUc94OPUAzqBDyOu3hbWYCyj0Z1zBsoxS1ygQnjlmvEtNylhlbwLSzcREXlpcF+UyhTExwkWuVUDHrVCoih1llVAbqBD6hxsQcCk0Z9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVM8wdUg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so5833219a91.3;
        Sun, 23 Feb 2025 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329093; x=1740933893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/rM0c8KAofiqOH9E+BbTStqrJdKUl6Z4Ta9tU7voiA=;
        b=CVM8wdUgcjml+AFsid8GHXhJ1Fttyq5x5xVEEJpe6g9Z4/siHaUkOn/Obik7Khta0H
         sX6E6VV2QsGR1lek5fm+qMKW0dt3vy82f2csSs84ugk+veJ25SbEy/SdA22dhyJt9YKy
         JTvcveEetBbs5Fsp5MMy1YY1eP8UGpBxslnB7s21PDSmJEmFo3Fk3WfXqADnU2QvGqzf
         dl82eM/uKHjxX8lhGx0AUZcoKvzVwvvB8rUnbFk0VaPmoyFuB6JIGPc8VJCAMJ+2YEnH
         7fycycD8fp3HfyyCmN5gZ+eSoRK4exkzf+mB2VHm+fyK82CVhakQ0EfXOnaxGq99eUWD
         tYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329093; x=1740933893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/rM0c8KAofiqOH9E+BbTStqrJdKUl6Z4Ta9tU7voiA=;
        b=dGb9uavk+QeI5e+Q4ggASBKNQWliHf6czd8Tzo8xJxfhp1h1IOZm5PhmO/KaiZ5WmT
         aEhuvgAFAbaIyVQwE931qi5pTW2sCd0T0BExjjy0dRtcnHNumNqMtulWFeDbib0Q8/AB
         Egcg3WGTzwYCMZwJTX6JLYHhBqWuKAFFfEvuXKYCZcLDNq/GjKButf3JrkEUddeKcXAL
         fIbAnUCNVppmhiPqTYgn8+7mLtpWVbU17P/Cfxahurlz1YS8nIGmqv7+9YY870Zxuxo9
         Xs3pj+xf+D4ijGNIR68trU7qvBEM5dylBPEvtxmYVsr9XJK4Z6JOd4iNDVV9gnjciFQ0
         nNMg==
X-Forwarded-Encrypted: i=1; AJvYcCUZk3moQx45JlR3KWEsdENEQ1cy3kC5k8lMTshzNvLkyYRukBMeR8Lct/JttuWEcdcSnAARcKvI@vger.kernel.org, AJvYcCUyvpPilvOkZbAeZhuwes8D5WOamSoyTuVjx41kEiNI8nja3w7V03reLUwVnEIB5Ep4HGzxgL9BbO1Jqfk=@vger.kernel.org, AJvYcCV4faCZXislByBoydXdkCKJwN7/PAjZULsNaEGg+5ixQQsmiHgp48XVIgbtcmL/UXtnOTG9wcnZdDcCHcfX@vger.kernel.org, AJvYcCVMuHhHR4ZJDwZLOkSfjEvkkA2zbvArwkf4Q1qB3gCauF/QMlr+uLN084MrjU4A7cvtSZ8=@vger.kernel.org, AJvYcCWbuYmtW9u2L8mXov0Q4iu6e7RWAkWD3RXcfE6DvblStfdYs1Do5SvIWrHHlAWwGi/YUszp4sQYsrLZWVciJlw=@vger.kernel.org, AJvYcCX8VujuUPq0WflFUqbFM5NTtt/mfFmiCzmnX9wTCY4JAPTRqpUFL0xZVooFiRfj8YSibPyhRY1AlZB94KM=@vger.kernel.org, AJvYcCXXrcmkN3/pylPS35S54YjbXZiemnVJC+vPWY0wPtOO/5CMIQzHkZbz9PObWuxajTp9ipIfczx6bQSrsd+t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Hq2H1Owgdjvn3r6eKf+wdtSMyqpJ0gyv7vbAuI6qF71Kuo/W
	rp4/O0jStRlPGVZsgbSeMwFpJoGyRSx0DhIJXzgkk3JQN3d2rTk6
X-Gm-Gg: ASbGncvoJ6ohKiWe13qE9R3fSop+CtsluHE/z616ANycbk9yExPmie3ugXhGePuvShl
	/zlWZvDw4T2Fj9/yaOTIrinPe12Ld2A1kckPQCcz3cbkIjt3iFhPdWRllcpf1qwYFkXezuUOFyl
	7+oy+dPQJl2TYc3NOLIiBJa0kCpjmHgF87ncHfd0aF1Ej3ClmfiW0ypfHQvv31Fo3h1XBRjsizC
	1VdRzEHhzs9BKDMWd+hTvkZ50YfysDrckQc657jFCBj2XD3QRLbDSsJr0pAowG6hkIYTpsIisD5
	d7SgBk4/lFkMNaAyun2ludFZ1KUuOXQusWm5k91HmHP7QRrSJ6E4/lYT
X-Google-Smtp-Source: AGHT+IFyGSvrJM271swgjLlCi2TwHZU6y12ME2N9/TuoQb9IugR13IQRKyCWyxRNE+S6ruhpAiUUqQ==
X-Received: by 2002:a17:90b:2b8f:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2fce78aab09mr18428370a91.10.1740329093592;
        Sun, 23 Feb 2025 08:44:53 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:44:53 -0800 (PST)
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
Subject: [PATCH 11/17] wifi: brcm80211: Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:11 +0800
Message-Id: <20250223164217.2139331-12-visitorckw@gmail.com>
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
 .../wireless/broadcom/brcm80211/brcmsmac/dma.c   | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index 80c35027787a..d1a1ecd97d42 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/bitops.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
 
@@ -283,21 +284,6 @@ struct dma_info {
 	bool aligndesc_4k;
 };
 
-/* Check for odd number of 1's */
-static u32 parity32(__le32 data)
-{
-	/* no swap needed for counting 1's */
-	u32 par_data = *(u32 *)&data;
-
-	par_data ^= par_data >> 16;
-	par_data ^= par_data >> 8;
-	par_data ^= par_data >> 4;
-	par_data ^= par_data >> 2;
-	par_data ^= par_data >> 1;
-
-	return par_data & 1;
-}
-
 static bool dma64_dd_parity(struct dma64desc *dd)
 {
 	return parity32(dd->addrlow ^ dd->addrhigh ^ dd->ctrl1 ^ dd->ctrl2);
-- 
2.34.1


