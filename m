Return-Path: <bpf+bounces-52966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430CBA4ABD1
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AB57A922E
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CC1E5020;
	Sat,  1 Mar 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhpUguZd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E891E0DCE;
	Sat,  1 Mar 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839149; cv=none; b=PCDYDJdzHvJDXkSW2cOhifbh1DZJWIXU3xLKmmnDh3KZ8bkkvvG4S38wU4kF+yrAT1lTLkDixvbSGXe0xJFMSYSmJmDn3+im37ZalKtGZnMGToGM+7E4iUtauQlIxss+BYEZfjPjqhAZ+IFuA1l7stVcBGOaQE+X6gS2G1QghLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839149; c=relaxed/simple;
	bh=SGs/08YH9pzcyzj8Hy5T07XyaLzA+LXAm2VV8KsMYOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3Eu4rLfgRMKd/bFgl6wyjefxd5jmubZFAQ701fF5BY6aOq2Ng5Y2iwsJx5tb5sSnIjON3alRF4uSPFfwkZcLQQe2BkEhrglcP4l469exhNlw7SPDy8hNSm7+84Sr6BuMZKZAmXedy7hIro+ir3RQa73fqaijRsGvOS3ki2YtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhpUguZd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239f8646f6so61335ad.2;
        Sat, 01 Mar 2025 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839147; x=1741443947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWaUwtVpZP3UXTpS/tFZiOQ6e7YZSypzh2SSq6Q5dUY=;
        b=QhpUguZd9kmmpvDh7rbmgc+XGPjBhRA4UJgqzF90rXoRb/mv/c6dPtLLlgZqmBeCd7
         HXlN0ngiCT63NX2YiaGZM+X97APmpymqh9Wl5ydCe2JJQBtAbs9CfMmHMqPutUZSyBiy
         0qm0n4YyQ1xNWits1cayGiZeiUFZhKHYRqgrr8CgZ47n97xvC/plzGgPOUoklJwsp3oz
         oADoMHJ9zcVNotGlFmeYiuceJC09zYBM40pd8Gk12f6CmuYm/HCKid0+q3z93XPENXu5
         NjkzYjzgnOPWIJP+ms5f/uvVJ5bZjPQ2tvU0RdnryZVqYTy38HSodCixidK73qxkJ7MP
         iIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839147; x=1741443947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWaUwtVpZP3UXTpS/tFZiOQ6e7YZSypzh2SSq6Q5dUY=;
        b=WBHiYdfXl/3K2igRsHakhZF4OnWbmfKaQiXHsWe5p7msTUjtp2HLrKf4QbgeHNjSZR
         TgRJ3iUrWO4UTD423Ra+gpJ00RtIycCz0Ev2dFdkoanbX8W6i7kdD1+UmZysq502vMkS
         Z3gElhcand9CmlSUsAS1ajxDWAgCkr9Mci4xQYkIkPihJCKPMF/JHTcIjDz7pg/XHb2U
         W5terPf9yznjBmTpnLEf8106dqbzSvOqWBquXGkbHn+yT9ZBJCKZErFsWy39GNa56ja9
         u8wIB93BhTle9ShYDhAf9iPV0SxS3nZjT1S1mdh+eDRbdAkiPWGu7mOp7T5fbyyI5ZU3
         38xw==
X-Forwarded-Encrypted: i=1; AJvYcCU8qkCBK7AJwM3gTlSjlKyMvUqw7DDZHE0cOrnORn/W2jpYujAd3sGnWBwfOM3asOPVgIlWrN8274wDWiKZfXg=@vger.kernel.org, AJvYcCUlXAS76cbOIr/U0WrwEn7Bogf0AVERhfaHZYz8BZmyEHHBD7MwPnCAiNZjU1QN4gnKqmY=@vger.kernel.org, AJvYcCUwHFHaFQ0156X6Y2M0PQnjbwu0axmjT8H/436Mza/PebzLXoCBMwlqPVdEO2rxh+5XSKFfc+rvwOl5V0A=@vger.kernel.org, AJvYcCVWvSn2Hpl2zZZ9kjOs9YzUFYuGwxnzKmJWYQxG8WFVKIJhVPxbLB+fh8oJktFyZVAK96aOk92r3V9K8mvI@vger.kernel.org, AJvYcCWv7FpoH5hB5RDW/bdKVpifcxV6TwByUIs8II4CRbd0l7GEV0C4QbNsn8zPCmJrF5bjrIUgME22@vger.kernel.org, AJvYcCX4cAmM63I/eiwjXh5C0NGjyqcfx8pWZx6Pxqyp9aTCOzl3DgrWeSs+WYItftvp+XIJlxo+8sSSF7BAW8LN@vger.kernel.org, AJvYcCXADq7eT951texCVNKLyn5fs1+PzZyiwqL2aSGhJDczibgnXoJ4x9T1SJK51YrGjHv1y7qagq2AFgNiFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g7BaaZH9a3vZu9DeXQu0MT5kUCrESJUeBNYB9tFYktUjXMHg
	Ot1GiIiqx+UTuF5C8iE2yHIGNIZYUCEQTT/ZOjpyM7M016UMBD5w
X-Gm-Gg: ASbGncuJ5AXzYgNFJ3OZtEXfWJHutDdqSxcG0TCGlQN0GDqbdxtX0fQ4vJd90vbxPnZ
	gKV900RGz/SpxYlW94sjCgYbyfZqJ5N3kGP2UsyqhtRuPH1+mY1/H7cHTRZ+9C9O8bGi/q8r93t
	wzTsSYvrfDN/GZWnxU5t1HJLyybF0o/9p/I4sDFdjusKvkmEkXst5plijTX9Sh/trrFuEjpoudt
	9PP34n+ld8gvrn92kpgvm/uf7HMR0V7+QzDmjS1Hl/INagh0JjZqVyz+4jVu48OU5SHisoSZHu6
	98Fro1/nFOkld133WIqUJoNeIyydj7ncUr3aD565O5rSfXExt6r2+/JWajAUGafdCa86p0k7xoA
	=
X-Google-Smtp-Source: AGHT+IG6ecfCPGcNZUMHBfcPl8yc5atQiQ27orXscqjAcai4Vvxl2x3xemsSJ5TeQh/ex0SazOZMFA==
X-Received: by 2002:a17:902:d48f:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-22368fa8f1bmr107105175ad.25.1740839147356;
        Sat, 01 Mar 2025 06:25:47 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:25:46 -0800 (PST)
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
Subject: [PATCH v2 03/18] bitops: Add parity16(), parity32(), and parity64() helpers
Date: Sat,  1 Mar 2025 22:23:54 +0800
Message-Id: <20250301142409.2513835-4-visitorckw@gmail.com>
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

Introduce parity16(), parity32(), and parity64() functions for
computing parity on 16-bit, 32-bit, and 64-bit integers, respectively.
These functions use __builtin_parity() or __builtin_parityll() when
available, ensuring efficient computation. If the input is a
compile-time constant, they expand using the _parity_const() macro to
allow constant folding.

These additions provide parity computation helpers for larger integer
types, ensuring consistency and performance across different
bit-widths.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4c307d9c1545..41e9e7fb894b 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -276,6 +276,69 @@ static inline __attribute_const__ int parity8(u8 val)
 	return __builtin_constant_p(val) ? _parity_const(val) : _parity8(val);
 }
 
+#ifndef _parity16
+static inline __attribute_const__ int _parity16(u16 val)
+{
+	return __builtin_parity(val);
+}
+#endif
+
+/**
+ * parity16 - get the parity of an u16 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u16 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ */
+static inline __attribute_const__ int parity16(u16 val)
+{
+	return __builtin_constant_p(val) ? _parity_const(val) : _parity16(val);
+}
+
+#ifndef _parity32
+static inline __attribute_const__ int _parity32(u32 val)
+{
+	return __builtin_parity(val);
+}
+#endif
+
+/**
+ * parity32 - get the parity of an u32 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u32 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ */
+static inline __attribute_const__ int parity32(u32 val)
+{
+	return __builtin_constant_p(val) ? _parity_const(val) : _parity32(val);
+}
+
+#ifndef _parity64
+static inline __attribute_const__ int _parity64(u64 val)
+{
+	return __builtin_parityll(val);
+}
+#endif
+
+/**
+ * parity64 - get the parity of an u64 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u64 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ */
+static inline __attribute_const__ int parity64(u64 val)
+{
+	return __builtin_constant_p(val) ? _parity_const(val) : _parity64(val);
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
-- 
2.34.1


