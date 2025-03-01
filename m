Return-Path: <bpf+bounces-52965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCEA4ABC7
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC047A8C88
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6671E377E;
	Sat,  1 Mar 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ila2gCMq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B841E1035;
	Sat,  1 Mar 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839138; cv=none; b=hHRbGk6auDW9YSWcmlyYb/w9IoIEKw4lYFloNpWbN82QqBVA3V9kfjx7um+YAr4yI4LitxcEGFSOrRwK/aKu7rJQdXQrnpS6DadGAxMxMJv+kAy3GWxM9wSf83tW8Wje1jVzE5RqSSSTbrvBhlgVT248EtNr+DxQt864sKX5eBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839138; c=relaxed/simple;
	bh=Hp0hGvKZ6hZDXmPlOHysECp6knm016n56jHAcRs/TUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFgU2Ght9hCN8eB5JULOStFjNJUpZc1OtACZnQdmXWulX+8+8K8ohiBJe1d4EhwWi0PllXrsxelREJyH/4boSreKCprOu/Lsu5S8XYOn8QvQsvKbUgyqRFI0zkgPSG4M7jTttL643E4kuTefxSAqi3fXp1etcLUMw83WE/6b5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ila2gCMq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235c5818a3so14252465ad.1;
        Sat, 01 Mar 2025 06:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839136; x=1741443936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DnAEglK79Mk3omljF0fSTgcHsRTccmWpKjUoP5FAFM=;
        b=Ila2gCMqseDR5iVkDO7r1OGs4Bgpoz/J8Or7WZ0pzhB5QvCv3SeHozd562ZEFXYdmZ
         njtKSkJCejp7tflxcdeNR8h1TjeMqXtLGuvZ/yUoIz1kYGVyTQxVIAk+MAcHQSDSPXUI
         qxUxI1L78mRXL+0YSQa+bQmqQKjU0qN/HyYjEUBtwzUPRphx4m+QTfiXzZSH6O5BCDOW
         ok2GstzTSX5iKxn6KW1rtDoQ3zJiORFSD0M4D5HugyPLDrtj+xf5BQ8+/doPGLWpo0Pr
         FIOtkfNqA1X/U0h41Ghs01Zjc04o54uZGjSvF5q9uQM1EbamnrcOfuSJZEihdAiTSm64
         s/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839136; x=1741443936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DnAEglK79Mk3omljF0fSTgcHsRTccmWpKjUoP5FAFM=;
        b=EKGDm+UXYnFg/LH6IwoEixyiTDsZXJjg0PoB4egFVFD/1bW6zX1akUd+6L500IbNnD
         0o63rlqf/HEhWd10AN/J6TftWwH6/03QPo77q1a32NxtZEQfvUUvpkhaZZpeH2VI6hUC
         fyt0dCb8B7tKyJLYVkdAAhpPz8dHAhVWKL4Y7ZmSxJ1QYOtqaEJtJcduiSsTiMYy2w4J
         asOhcJkb6uVBpQjPiCreRVOfgApolwSW+PVXi4oLqa0fIzRR8m1qdNcWvCVCm1Owh73Z
         VyzUQEInO8Ze5f58l0ZWGJIJP9qXNK8nvEnGwsxVUVO8skHnmdzvCfB8IMqh+nElWH/s
         p0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+zTbwQm94+KbTOk6tfPaduBAY5LgqwqZr/QVA9n1xhpQ48/T7vPjNo0bOdv9XqiHBQU=@vger.kernel.org, AJvYcCUSNqEFBN/AeZ9ixjeo5uEn9S4o0NMDtrU7U8XO82IPJMmP0yAp6HhXgCV9ODfPUQP9yDDgBNWoRE4Mye/o@vger.kernel.org, AJvYcCUW6SUAJ/3nUtyIzkDcekQGYsa8bFrxzpAixhhunQPlb3zjZltWTC+kwBpmCNecK3NRlY9heX0LF57XIV1A@vger.kernel.org, AJvYcCVDNWnZ4rLG3ChDXLSD9r0MEiPjIXJENHB+MZkEvYDmSeKLVLi0XVhSYWPuWHkw8MGzKiIfr6tdjRFxL6wEWXA=@vger.kernel.org, AJvYcCVGyjXtaCwL59+R1/fuTmqN5+Qwpoqi+UAOFtDlatRaLiVXaKF0I284XrN+lOkqagXWRUWkfsVrAoPH+pU=@vger.kernel.org, AJvYcCW/pFkC8QFOB8zRunATpZ6koxMl6zTGfmBzkdzBSvfK+NJoK1S88nmQqb+E4D3Oz9qXCJDxZOTPTACkXGo=@vger.kernel.org, AJvYcCXiv8vwjChVfjhFo0xNfHvAkZrjp/j0l7Dbsow5/1+WhhwfQARSI5QzB0fX4nDeVH7g+ujCgIwf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1E5QMADxgHm2SWzqOUaXCWemKTM6XjKkqsRQoHFeAU/6jWMJP
	dO4n8ig6I9ltIZfW1nLRXYV6yWQ/QBkNTn9R6BFZ7k0twTBuFFJT
X-Gm-Gg: ASbGnctOMUd3i703DKtPgDKUB8Rane5GZ2tEP4dQNepBcCv3BLwpBAJ+L1Z4v80bNl+
	R8Yd7xtkMeF8RT6qfot332E/V7nPlaH8pRboftJgqFEIff0wKa+CpjKm8+jE4KMzQ0RG9ZypF/4
	NZKBuC8iSG/HKcZTrL/O+4ow8ZQLVkJYwdhszD2bvvFNRvgZu5nSqVyDgkLxFT6TaHLkOLz9A8U
	32fEV8DfjWN07jY8wyJGo/0dMM7cLjdCJe7GyTwEoevqm/N37ej4I/9YtQp/4USqeluT2vG6f7S
	PnBJLKuCY69KVf4TnaC/P/eNpk8B9q8M91+o/E78yZ3+3DVXGEc+xGJdRA1J7oyha2DHeKgrP6s
	=
X-Google-Smtp-Source: AGHT+IFRKRz4BN5AxlaA28KHfZNYjOTMLj0QAU9lL8VlPLbOS4h8EVG2ykvV/etQT7fBRPoRmphS1A==
X-Received: by 2002:a17:902:d4c9:b0:223:5240:f831 with SMTP id d9443c01a7336-223690dff12mr91198085ad.25.1740839136548;
        Sat, 01 Mar 2025 06:25:36 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:25:35 -0800 (PST)
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
Subject: [PATCH v2 02/18] bitops: Optimize parity8() using __builtin_parity()
Date: Sat,  1 Mar 2025 22:23:53 +0800
Message-Id: <20250301142409.2513835-3-visitorckw@gmail.com>
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

Refactor parity8() to use __builtin_parity() when no
architecture-specific implementation is available. If the input is a
compile-time constant, expand it using the _parity_const() macro to
enable constant folding, allowing the compiler to optimize it at
compile time.

Additionally, mark parity8() with __attribute_const__ to indicate its
pure nature, ensuring better optimization opportunities.

This change improves efficiency by leveraging compiler intrinsics while
maintaining a fallback mechanism for architectures without specific
implementations.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..4c307d9c1545 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -229,6 +229,27 @@ static inline int get_count_order_long(unsigned long l)
 	return (int)fls_long(--l);
 }
 
+#define _parity_const(val)	\
+({				\
+	u64 __v = (val);	\
+	int __ret;		\
+	__v ^= __v >> 32;	\
+	__v ^= __v >> 16;	\
+	__v ^= __v >> 8;	\
+	__v ^= __v >> 4;	\
+	__v ^= __v >> 2;	\
+	__v ^= __v >> 1;	\
+	__ret = __v & 1;	\
+	__ret;			\
+})
+
+#ifndef _parity8
+static inline __attribute_const__ int _parity8(u8 val)
+{
+	return __builtin_parity(val);
+}
+#endif
+
 /**
  * parity8 - get the parity of an u8 value
  * @value: the value to be examined
@@ -250,14 +271,9 @@ static inline int get_count_order_long(unsigned long l)
  *	if (parity8(val) == 0)
  *		val ^= BIT(7);
  */
-static inline int parity8(u8 val)
+static inline __attribute_const__ int parity8(u8 val)
 {
-	/*
-	 * One explanation of this algorithm:
-	 * https://funloop.org/codex/problem/parity/README.html
-	 */
-	val ^= val >> 4;
-	return (0x6996 >> (val & 0xf)) & 1;
+	return __builtin_constant_p(val) ? _parity_const(val) : _parity8(val);
 }
 
 /**
-- 
2.34.1


