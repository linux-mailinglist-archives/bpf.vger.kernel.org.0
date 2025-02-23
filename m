Return-Path: <bpf+bounces-52269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB1A40FD6
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9263B636F
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F4145A11;
	Sun, 23 Feb 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO/shwOK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365778F41;
	Sun, 23 Feb 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328983; cv=none; b=jdUEgLaO9ZVZTUxFZTX8m4BmWe4ITJ3tPWEZzqKqGByZOaTRZBpl2dsCz0FqFY4i+3aUDOTCpZ/471xYS+DWmeKA534aBtVZMo6XgGhEPk7jC+HTRqzwBPa+/Df6Oq/okBZ088JEXNSB62soGIxQIzzoWsSK81964jlIeB2rXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328983; c=relaxed/simple;
	bh=hSOjgUw8pInTvIwc3Vx2Sv+ma38FohsXF5UBIlyo008=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=St1Chg2RH5SY/LkOmwztshAExH4oJpnByxKNFSRsRWm4ySbYr/DIN50PnX7vLRupgWujWNtuhfIXxtWssmDzYYopVqWbqEKR/qLtmjCRDnWmCORTk6S1eIWEor5VPWC+Wo827bhpXGWU0cOJ0WMwT7tGta3smXJs4M0ZpgHVvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO/shwOK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso5600716a91.2;
        Sun, 23 Feb 2025 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740328982; x=1740933782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8NvrVTMlDH5q7zXpF8J7bfqPimXPkp8jnsCRo60EBQ=;
        b=DO/shwOKozgqDMAiGKOgSNvG8IJ14/csFa++GcSeBtS7Znv3okslTAGhJMk6iPVRP6
         n4t4kHzUOHdNHvruj/bt8vHzI7tYwASpdHZssuviwOxTo15Pcf4YlzGfBI1W9vMgSlB1
         PW65j8ZF9ebfF0vSrovejhNNqdYLsi/s+5Yif9Ww3NM26M4XERZy3ROvA0IbI76YOpqa
         8Kf/9C8xbBNOgn3YxVj4cXtynsNCQ8SOZ9hz4DWVRt8pwWHN4TgTPJZre3Ss5rS6ph+R
         LR4U4g6GctJWXL7pUgW3zh7ii3kGDYTAgbByhV08CBUK5HhrWZZ+QIfmFP/+usvsImL/
         G9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328982; x=1740933782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8NvrVTMlDH5q7zXpF8J7bfqPimXPkp8jnsCRo60EBQ=;
        b=gOKQ1nCgQA5md9y8No769wOfOn44amaNCtnozD6PqkAs1cUGf8zPgMyxMIeHyg4Kui
         rBhJK0RyKUK24yIq1aqNHcY8vqyT4DSGaVuPelVecfO1rf56IKTG547+rtdbJl/BNNsv
         AfP6t65TTNd4PFuZ/PkB4F/cKDg5Pq0rn5aQyXQOj85KdVHymS7e0V1uNwiiDgTTGOoz
         ReI9W0/JiPex30ZJJ2yQpP2JBYrec8JUiIdLcUcyfpDU70ex3T0Ki16/sjj6PZFskrbe
         xTD5GPt4Sj7ETG6X7cLLHB4Er3VCFtDipgyijvZ9KQ3kXCsIDp/ISZuE25+HVjanQ5x5
         NR9A==
X-Forwarded-Encrypted: i=1; AJvYcCU99jlV+/Jy02NNZNMTU9sNQHgmP3tzuPhYZ+jFb6hUYSbGV2JuRBzbdibudaRoIyquBmV+GrCIdlneG/4mZ8o=@vger.kernel.org, AJvYcCVKhfnT9xQ+B0wjai2QqfuRYA5i8IFOD3wTkaVkh8V3b6bQIQbnh2oIAiW8ZifZVxp0MZFng9uv5IYZk3cm@vger.kernel.org, AJvYcCVkghz2viIhJt68R1JvlqfcALSlCW/BqMu+qXyCJtgYkLA3WzNHjfEblw1fTX0lzOevHUHSMYjM@vger.kernel.org, AJvYcCWMGwp5S69s5Ai7b1BWbOcx/bE7L90D2Aw/W4NmTEwtEHgtC9B6/XDWzz9w+rSRUwa0szapf/zputUY+Ynt@vger.kernel.org, AJvYcCWw0hJ2eyWus/8K5BESklO75mk/Z7wegUt+YAujoN601KttjguG6aMoFO1HZQOFX3aWiJg=@vger.kernel.org, AJvYcCX0WAlctFwKuvydD6OjuZnr1GnqjyEUaROEMjhLix3a1y+AS1D7gfCC1EU9AQbJ5LBeAknpRovdCHjL8OY=@vger.kernel.org, AJvYcCXQfbpD6VLCjtFYfdrhudBvewR7HZ1SxVPJIvlGCe1AaFhk5EwYA/LZ4Yva7QFbxCttn79P7Cg2ageTIAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5A/Qbo9OEvt8xlsaFKGC+Wsox0YgJ3lHMUaEBSEgTMBnWpwIy
	kla9aTVEfazJ2iMcJ8AbCCWj8Nj0KUoerMfG1Ls6tBg1+DloOFN6
X-Gm-Gg: ASbGnctJeThbhDtahG+zwKrTX0mY5KxNj2kWNX18Y51oiSdk8ovQyVtlmZ3dRrceWRF
	lCIu1p40axoKhyGwufR57zqEkxYpdlQK38mVL0dPCtFi4xdf52hPVjIN6YTDQw18B04c2o4B0wQ
	OGj0v2aZXV/lJ55LFCL6H88K97mAy4gEQUXG1IO7Lk+eI7WoHOtTReetIM4ypHM26LYSJ6tm+RQ
	ZTZkblvqr6Lf0Vk3Rvy81q2XHhDOrOR4XJR9ZgbuUQaMU5odQA4GVbNihxId5TZWO135cP3VaI6
	Y0lXN5Eo2TpeAWBYT0wqBuSCHOOcjoBeXtufokO1nc87XF9Yo54fIdu+
X-Google-Smtp-Source: AGHT+IHY182dhZjo+LBq9qsTP5GtRPKleXwf977mCGplhz7BFQQV3AK7mJ142hsRvikrULeBFmErJw==
X-Received: by 2002:a17:90b:4b90:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2fce86b31cdmr16578615a91.13.1740328981599;
        Sun, 23 Feb 2025 08:43:01 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:43:01 -0800 (PST)
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
Subject: [PATCH 01/17] bitops: Add generic parity calculation for u32
Date: Mon, 24 Feb 2025 00:42:01 +0800
Message-Id: <20250223164217.2139331-2-visitorckw@gmail.com>
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

Several parts of the kernel open-code parity calculations using
different methods. Add a generic parity32() helper implemented with the
same efficient approach as parity8().

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..fb13dedad7aa 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -260,6 +260,27 @@ static inline int parity8(u8 val)
 	return (0x6996 >> (val & 0xf)) & 1;
 }
 
+/**
+ * parity32 - get the parity of an u32 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u32 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ */
+static inline int parity32(u32 val)
+{
+	/*
+	 * One explanation of this algorithm:
+	 * https://funloop.org/codex/problem/parity/README.html
+	 */
+	val ^= val >> 16;
+	val ^= val >> 8;
+	val ^= val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
-- 
2.34.1


