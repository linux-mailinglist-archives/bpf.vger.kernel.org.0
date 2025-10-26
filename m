Return-Path: <bpf+bounces-72279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71819C0B37A
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C398D3B9A62
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5B721D585;
	Sun, 26 Oct 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWA1BCwE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA05201004
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511153; cv=none; b=dGvpPznBQNCmpL3J9c4i97GjZOxlAuI5oDrN8+9cpntWxW3JglyLB9CBizt5xhOT/SxM13omWtFkJGcG/FJYf83UFiFxWaiMDblO3QUTdS/DQbn3fGgWr+Du+EENoGCZw2DV8R0KGwgMbnmvTXDuBjEesEp8rYUFaNN9GHL64i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511153; c=relaxed/simple;
	bh=YgoY+pgbWPRjmzU4FIIvz4YTxzDxdbdLNMVEhuBqavw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOCQ38Hco+F1in+E3Rcm4I+xCZ+iAZrg3YKAnwJLMhxnfTgnDhj+BcvqWUpel0BG1+4gml/CFSVQQBfghE2DWu8q8Umx+L7u3qoQ2I/ukQQ91NK6QeEtCfQ3AT7YtaAi/hT6TECMTu72mGWP9iUaGdQoNYY4Ryjak3rry4x1qVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWA1BCwE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso3934353f8f.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511150; x=1762115950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WQ4CRRRgXLtruImHv5Rpdohd4VhlcBzTPG2qtCf+8I=;
        b=bWA1BCwEQTwkYakWz3zDAfOlmFcAE7R1tpcuxHpsbj6y1SFdH2ymv8H74oWPnu16ts
         LcP0N65RdkXariIIoN7pWS6IWRRrwKXknqasDNtiDhYrkNTc/iJvWtc6NyIZHdNehTO1
         u64XGgO7yVdkKqnwcJ+EKPA6ikUaIpmqqGz0aegLK76GWdRs6mZ1UjF86g6J34VamjT1
         PEeYPgJie1Gl3DWSUMLiXBHyvCUU+7SRswRs2EtHwiucDe/Ox0N/T3mkW1vPxTZsC6vK
         WvJZ4WXby3fUwqwhTqcpoMPzVdkV9Uc+tICC63yPCPkSGUKYla+sN6vIXfrXJx5TnmL9
         hOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511150; x=1762115950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WQ4CRRRgXLtruImHv5Rpdohd4VhlcBzTPG2qtCf+8I=;
        b=SNGyPb0IFFKAl3cw3AQT5EApP7nq6YmXpEXndcfcwYImQS2feMvjZaGJFqQoCMBaDi
         od++xGzcMbZSUYyiYU29Y5RUOjvKoJ8sVdqyfk+xJjbSzf/S3MMde1WTtX93PUh2RSuC
         Z7ye5InsPHKmigQZUzRfnzzYgHJBJ41D90yraI2XiJEd3LJ3CtvjfQby8awlcuND02jx
         OUeQdU8alLwhUqGcurw2QJjdcz5u3BnP4bDvCqilyDu1cEouXhfWxEwU89/4hUNh9wO9
         Y2wXgqLsnXtAKyzSCw5jYNxZw+rxaR9DmBeYIjRyncFKVg6Djxn7dV/H5M98QrUlyQeA
         75sw==
X-Gm-Message-State: AOJu0YwJYyA1T4BVAwuFwPbS+CMZk2S+CUQBCEkvaCsU8RxJQH/YkMK8
	w6WIEIw7xdd7rWpb+2njVeWaoawma6BWP/QOAMQE/T67TXDHSwxXbUnjJKqj+g==
X-Gm-Gg: ASbGncugLg47s1W6RaXta98Tv51M5BhjNxYkWehWrUUb0qS/OtWttu3mUVWe12VY+LX
	RhvX6+TS3AIaBv5h7O6Xg89SyW8FJlfgzd5dd2OOFwzqAIQBWSj3c3IuOnGquDOWb2FoiopqFXO
	x/0gSWjMn/5MBv1k2WsTijQESUy1Q6vwlr87AuyXAb/Fu3MDOzkhl4NJ8QiT/9tyLXoiqQ80jUY
	S0zcVRjVRy6/DQSpcF4+ia1/I0v/muUAKMrriXOq6X4ZGSBE+lo4Kv32SxQzZ8US/DHzpOlv4hQ
	kFT13iWbcj9Oz3PSkJQf4yxUxw0YDfwDehyycopS/nXPYYWRkdGTQg95m9bnGql92pm7sCTddPi
	D/l1X26ioUyjkDXYnvFXN7P8TXUuZ/I66iZdTOzqHHSLneRiIOivp4+NM73e69bq2CBxM3YKp4O
	U3SJLD
X-Google-Smtp-Source: AGHT+IHj62g5V72Ph0bfFgy1nGIxQ0cU+oPhPckemshNaQD9Osdm/Jz90SXqTJqlPY9I2QQU0E/0lA==
X-Received: by 2002:a05:6000:1849:b0:428:5659:8209 with SMTP id ffacd0b85a97d-4299074ffeamr7975756f8f.33.1761511149720;
        Sun, 26 Oct 2025 13:39:09 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d3532sm10607379f8f.20.2025.10.26.13.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:08 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 04/10] lib/freader: support reading more than 2 folios
Date: Sun, 26 Oct 2025 20:38:47 +0000
Message-ID: <20251026203853.135105-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

freader_fetch currently reads from at most two folios. When a read spans
into a third folio, the overflow bytes are copied adjacent to the second
folio’s data instead of being handled as a separate folio.
This patch modifies fetch algorithm to support reading from many folios.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index df06e492810d..aaf61dfc0919 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -108,18 +108,21 @@ const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
 	 */
 	folio_sz = folio_size(r->folio);
 	if (file_off + sz > r->folio_off + folio_sz) {
-		int part_sz = r->folio_off + folio_sz - file_off;
-
-		/* copy the part that resides in the current folio */
-		memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
-
-		/* fetch next folio */
-		r->err = freader_get_folio(r, r->folio_off + folio_sz);
-		if (r->err)
-			return NULL;
-
-		/* copy the rest of requested data */
-		memcpy(r->buf + part_sz, r->addr, sz - part_sz);
+		u64 part_sz = r->folio_off + folio_sz - file_off, off;
+
+		memcpy(r->buf, r->addr + file_off - r->folio_off, part_sz);
+		off = part_sz;
+
+		while (off < sz) {
+			/* fetch next folio */
+			r->err = freader_get_folio(r, r->folio_off + folio_sz);
+			if (r->err)
+				return NULL;
+			folio_sz = folio_size(r->folio);
+			part_sz = min_t(u64, sz - off, folio_sz);
+			memcpy(r->buf + off, r->addr, part_sz);
+			off += part_sz;
+		}
 
 		return r->buf;
 	}
-- 
2.51.0


