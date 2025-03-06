Return-Path: <bpf+bounces-53473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB21A550C7
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28501188EF33
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5B21E094;
	Thu,  6 Mar 2025 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVYlKyBo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6D213241;
	Thu,  6 Mar 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278379; cv=none; b=Z2f6a8BtjIKq9IGA7Fq1LPS6OtGl3VHoVLfV2jEa2yKHHxGfSA/T5qbwMW6N3Slb+o7X7oi8kWZAZ88KvMceGHNpZmz7d7ATGb3FYTQniVgRi5dW8bziOqITs9oOzikRT0G426452dkKj7U3DgQrK2PMGOydn7iOkrQwnGduA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278379; c=relaxed/simple;
	bh=CI2QBouZ2dkwbzeZblAU+6oACVJBoXLyg4YLH7XXZZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ve7biRGmESmhhEdNui++hKVwwu+ep+WdvxRV7KiEMEUQP9TCkZXAvaRC/wzgKWQyQutT4lFtTQNhkHpbYJ7qqyD5YgGNhc/XhQVGfpGYyjkufMOfBZO6s7i+zdC78cj0FSjFWb9pOdjYk02NBrwSZvYT6t5JCHSqJs1HUW6ulxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVYlKyBo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so1032747a91.2;
        Thu, 06 Mar 2025 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278377; x=1741883177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4VnYHrG4RwnHlGdrfRVkI5G3ZqKaX1Ck3mTCfWdoMQ=;
        b=CVYlKyBoG2ufgRtWVfwqci+hRFg6H819X2wPu7GFMeSmukT3Xpg4Lxsjry8UNIZ+m3
         6i+08MyR5CCJIM/+32OtVubqu4tm0AzdyqpT4HeIfkS0KG23RIwdnywfIXvj9SGtWmGx
         N6b7Z3LIGi040ENpSsEMHfpmIgYtw+RcMo9uzKSibF9S+2zfxln9EMkMGRvCxuSI0FJs
         bNmgOTdx7A4PP/ZD9XFHTOLA4Ze/CiTglXpPWRG7IT8+8yb2sRb1Mcj2yYs+CJm8F1lY
         OFhp9oPGSiOiILQZINPt4eF8sHWKXzoBswwL1a65fItzs/OuCQ8rxMIrynB/vlyAFmTp
         jIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278377; x=1741883177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4VnYHrG4RwnHlGdrfRVkI5G3ZqKaX1Ck3mTCfWdoMQ=;
        b=xDM3/w/UjmeLExpFtlInHc6CexlU2JsaPMiaOVzPO1N043m3YxdwKlEzivPHdNzL/r
         q4r1dw/cYXo9TqUrQnTgCMfEAWV9Pf+MMSlCyBsx2aB2petr7IbTaJdOWK2Qjgufn1wl
         yRdzZ5zzW3erLQbP/mfLiQqGCH27LO0ptC2EmlUo+qq02gVKYG0dzt0/XWMajQMF8VSk
         MwiHEaYy9xehtLgUJ/PM7q4g4EQy7zfpvrJSgXNgcuVN1BuFzN7BDO2NqigDD0qlt1IX
         77ZLDnHALL0zFVAecnoryVl3ne8AZUUoSEouASbaWsNfB1+0UZo0qlaKGnItYWupGi8u
         62KA==
X-Forwarded-Encrypted: i=1; AJvYcCW+vbmWn3pPSL6xNvzpN8iBvJ+c1LZ7ChbpFLp3VvEuVVBoOp7gLN1KmU26dMfuNFzF7jk=@vger.kernel.org, AJvYcCWzLObVbLm90PvJGW1dvBP97L+HCAaXLT5zHnek7nz35YhCRQQT4ToiRMfoFa2JqKBZbK3HdLE7y79PAtE=@vger.kernel.org, AJvYcCXCH1BeQSzABvEyhyaHY1EIg375IEiA4b4HDwn6vrbmpp2cTb9O1OY8zPihjY71+rYg2gX9oTG12wlnZS3E@vger.kernel.org, AJvYcCXHvwmE9ugPbJwUFqw8B0Wzl5cw3OnBKJ1zZ+zbn7+bi7eKDzmjeq0h6Lgpd7kpPhd/5sZA47Fc@vger.kernel.org, AJvYcCXMG6xW04jcZAIXsiTlmL6DbHx9MEo4z9///vgvJNWSrHIEvpI3f7hfmSBUG2f0Iy6pD1bpHG9jPrtlqVI=@vger.kernel.org, AJvYcCXP9DdWwK0D41/Je3puiGG9/UcUtKXGp8GE6UBpW7Y5kcIhrbdYeDx1+REVaKt3wA5xYjTU1Ls048uPmFAL@vger.kernel.org, AJvYcCXe5e/vgqK5pwrTxIc2m5byqleE+Pp01UmIzapUFVnyAeoCYsUkDSnOdTUioxF4v8n/Qr7JDczdicY7IjL7vKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFq9m/kEgEZLPQnTvfS49gMIk6NjBLblq1EA7d1Tfmdt0HS2bs
	Yyhftlw/4epKMjk03yr7aa7OZp8cD8GWygdiUV05EqwCi4m2Kp3O
X-Gm-Gg: ASbGnctU2cdL1W6Q7YOC4iHtsQu4GLPTG00uxaQ/ymDoe3uIwAKyFGkTKj+TLBfJvK/
	vVm/IGqgSBiOf4I3O2w/cE2a26fh98noKIN0iIjaHtddFmCuqGXLmJsANdoBQSJWqTHWPqnUeue
	rK99uKUzBw6n7wxm0Tz/nmxANt24q+R2IbgsbkVh4W5p1A1UyEKzlum5kdBZyMtJW92OK57DYn3
	4OoubiybXg1AopkHv8GmVONmLrwl75Jx1SZXJnjhn3UeXe8uqjxj7XSpD6X/uwYUGzHUXAT+IOS
	sglUGCJVioDvAH3XUS7EUexaIjVxJ3AuAewv1qhAfBKmy6Ubb7XC6tI7zc11HHKEgtOWoySimQE
	=
X-Google-Smtp-Source: AGHT+IHz+gPXGVLABcu1Z5L/FQeF1foGDNMRW0PUwFQDBuhtYoYyf91GQ4fqN6r0d6c4jX9sVUpwVA==
X-Received: by 2002:a17:90b:264c:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-2ff49753d20mr10753652a91.21.1741278377011;
        Thu, 06 Mar 2025 08:26:17 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:26:16 -0800 (PST)
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
Subject: [PATCH v3 02/16] bitops: Add parity16(), parity32(), and parity64() helpers
Date: Fri,  7 Mar 2025 00:25:27 +0800
Message-Id: <20250306162541.2633025-3-visitorckw@gmail.com>
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

Add parity16(), parity32(), and parity64() to compute the parity of
16-bit, 32-bit, and 64-bit values, respectively. Each function extends
parity8() by XOR-ing upper and lower halves, reducing the input size
progressively.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 44e5765b8bec..906757e1ddf8 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -260,6 +260,48 @@ static inline __attribute_const__ bool parity8(u8 val)
 	return (0x6996 >> (val & 0xf)) & 1;
 }
 
+/**
+ * parity16 - get the parity of an u16 value
+ * @val: the value to be examined
+ *
+ * Determine the parity of the u16 argument.
+ *
+ * Returns:
+ * false for even parity, true for odd parity
+ */
+static inline __attribute_const__ bool parity16(u16 val)
+{
+	return parity8(val ^ (val >> 8));
+}
+
+/**
+ * parity32 - get the parity of an u32 value
+ * @val: the value to be examined
+ *
+ * Determine the parity of the u32 argument.
+ *
+ * Returns:
+ * false for even parity, true for odd parity
+ */
+static inline __attribute_const__ bool parity32(u32 val)
+{
+	return parity16(val ^ (val >> 16));
+}
+
+/**
+ * parity64 - get the parity of an u64 value
+ * @val: the value to be examined
+ *
+ * Determine the parity of the u64 argument.
+ *
+ * Returns:
+ * false for even parity, true for odd parity
+ */
+static inline __attribute_const__ bool parity64(u64 val)
+{
+	return parity32(val ^ (val >> 32));
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
-- 
2.34.1


