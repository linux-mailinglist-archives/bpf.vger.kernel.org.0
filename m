Return-Path: <bpf+bounces-52971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07437A4ABFA
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE02D1895A08
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E781EB19B;
	Sat,  1 Mar 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0Iidb9K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017851DED5B;
	Sat,  1 Mar 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839201; cv=none; b=C1xOYj+C0tDLxUDqwAcKIYOH77KiVo9O1ADXV/rakAPeOj65qZq0OrRqSzVPRmnjAdBORmS8E6Am7MUawrDnXoUpOTyN8xKWh7+IYK7WKhWUUfW/aoa4myZaOeAQUGHyDFCZ0kzopqXFAjZM57uPRFZ45uoLHo0CcQLN62KtyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839201; c=relaxed/simple;
	bh=HKAn3f+7sbHTTp+UNFXBUa/TbF/WrljtWVRMW4BZHbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhLhi06F6Qo+D/m0eyseYg7qO880H0Jyx6+ESBe+BtdvQEhVwuQWK9Z66N2pckvGBu+dGrowuubxG40yiWal4QiXV1sjIE86Sc7IHJBB28UWB8vKIO8A25cr+IWLX3rR5Uxnun/D+z368ibQoabzez2w2/l8llVZ6Qtym1f/56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0Iidb9K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2238e884f72so4222005ad.3;
        Sat, 01 Mar 2025 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839199; x=1741443999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcXJ496C/2+0qa2GsfTbiscKGioWO59ZW48/kJd6oSs=;
        b=I0Iidb9KjngxCJQSWvqtZqpGbi/kE43cy60oXRYsmeNQSt/ptsOiUOa3TfTVsxj5pj
         dyPQSeN7dTWvOIClu0BELxJA1AbR+9GVVg6/aWbFVTPm+7TWdhz/i/VjFt7h48/PlcbK
         Dbk9exEhatxv468OQAk+wFhDu8aE9T0D6p3KVcQ9WoCOHj91QLzBo1zIZTun1q2xCuiR
         wVHxonlxbKpdpdWsa0gFrA+kT7jbAtPPh9YWvVXtpLMy0HHga3iytDZGbvgTEgTAMskh
         b1awLUrXHygEhlZNL5F49v/B7rpYPrr7Yi2yTC8sU5A4/RSki8l40cVuSoRJPyNQ/Ld+
         UqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839199; x=1741443999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcXJ496C/2+0qa2GsfTbiscKGioWO59ZW48/kJd6oSs=;
        b=fOVjZ9E0Wb9myRNzV4hYTen5J6nTwywRm8f3TkfaSEsVRwh0VNZCpDwG6iUYOU4Cf3
         HaLwEK2qtfB7o4ukOzv+VLcybuQ4t5FeHg0J9cyuY/B2Bk+29IZwu2/0GWh9i84IPJMJ
         ZXK8aB6+DhXzblDClQuRm7k5vKZuHLwO0PgqyNVDFHA7/uVlGQfrLafLxC0zE7qUZBrU
         c1v6P28qI7+0TD4jnxDePEbpYBuDPAlX/5vb25sfPyaCODI6LuKgcJk6abKNFXgAil4C
         vyILbehsQNiWzT+LWTrlA0Rhggsg5Z1CHBSqHCq7PCqfKIs58n3/HaJjoZUxUbO2wJQr
         RSRA==
X-Forwarded-Encrypted: i=1; AJvYcCUnmGKFLL4t2KwIfdcXNCdTRGegOy/4u8HkEhG4YIaXqP6m8bd4l7hU6YmCjb6H5DaBbo2LoyAVWfOmNuU=@vger.kernel.org, AJvYcCV/cMOEDcN6YeNx3fWJk9HVh5vfPQJB5iTrsxSvQBh+aItTzWxrkQu/Ztfm8P5bKz2iApdmIYjy@vger.kernel.org, AJvYcCVTo9XQbYnvA2vcsJcQHVUivT2ba3qhFfpHgeRmeYapU+OhLvqVhPFIJPolHelb5D7V5blj7we4rfFx2NFg@vger.kernel.org, AJvYcCVhoHNSdN8ZzH+3Ge7k253wUsNRccJlyYble3ghE59ko+213fGb7tP+EPnfFilCpXL1b9RU06tdfE0+VOt4@vger.kernel.org, AJvYcCViaS7aNsGJliWJyXExeVNlb6X7hlr1bZsNpxb3MgMqxLSuNeqgqwTMqcoRpiRE77oQ5bq8MxE9eWNsNQdVSh4=@vger.kernel.org, AJvYcCX4oRZJKNuMXVYU7gIEQTi8Rvrjaz2Xwq7aLvz3jSxXXBGxnMePEjKQJ8yAMocSvZKjfi49j0V9zH78W1Q=@vger.kernel.org, AJvYcCXQ4+CiK7R43Zl5jnsfYDAqdG3DIdiUcC/fbsQ+ej0v9yG19XnMJ+/Kh/OrnaWLSXeUG/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd5D05Irb5jBuIerdteVQtgvJAFleyZ1idZcML118eL7F69/p
	k8LZvdhatVU8HotgEUfhykDVqqLogYhIQFVEg5DbQ4kZ2ae19L3D
X-Gm-Gg: ASbGncv1/D2mm9RJ+iq1NvepQqnuwGniga6kUsdcQAHQD3hClbvHRyU2Xye+1KI2wZ+
	iwGZEwdx0bWmjfUzduc0Gz0LvttNKQWs1MYbxn3LO//Vx6xT0gJ2dCW2bdLYgQydVnwarut96Ih
	c74kjmQ7EEG17ixop+yUGLDxr3KQQGjpCqkC6ThrN8RGot6dVVXUNk3I/RxvhvHwd+fyJO/C26L
	wQiyvEZrAbdqenzU6rymEeKUqsCRqyAynOVePfm5nGh+cF7U4tRQS+iQi4fvCZtEUzHukJNz+qP
	hQ8b+H21KlFAwEc7VhoGSLJXbyEj/9u0YsqBK6+IYbweiTRLuJEGe0Kqd4UhRJbdeVgX/Hft+7I
	=
X-Google-Smtp-Source: AGHT+IF0PsFOHNYq2JTljPhmrhYVkAKjdgh1XZeXstNsMDq6/4mtC72Fp39DdqLibOGQ7FEZk2iiHA==
X-Received: by 2002:a17:902:da8d:b0:215:9bc2:42ec with SMTP id d9443c01a7336-22369260956mr94926455ad.47.1740839199131;
        Sat, 01 Mar 2025 06:26:39 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:26:38 -0800 (PST)
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
Subject: [PATCH v2 08/18] lib/bch: Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:23:59 +0800
Message-Id: <20250301142409.2513835-9-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/bch.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index 1c0cb07cdfeb..769459749982 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -311,18 +311,6 @@ static inline int deg(unsigned int poly)
 	return fls(poly)-1;
 }
 
-static inline int parity(unsigned int x)
-{
-	/*
-	 * public domain code snippet, lifted from
-	 * http://www-graphics.stanford.edu/~seander/bithacks.html
-	 */
-	x ^= x >> 1;
-	x ^= x >> 2;
-	x = (x & 0x11111111U) * 0x11111111U;
-	return (x >> 28) & 1;
-}
-
 /* Galois field basic operations: multiply, divide, inverse, etc. */
 
 static inline unsigned int gf_mul(struct bch_control *bch, unsigned int a,
@@ -524,7 +512,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 		tmp = 0;
 		for (r = m-1; r >= 0; r--) {
 			mask = rows[r] & (tmp|1);
-			tmp |= parity(mask) << (m-r);
+			tmp |= parity32(mask) << (m-r);
 		}
 		sol[p] = tmp >> 1;
 	}
-- 
2.34.1


