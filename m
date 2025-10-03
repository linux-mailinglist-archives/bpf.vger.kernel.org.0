Return-Path: <bpf+bounces-70308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CBBB771B
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC8848335D
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D162BD02A;
	Fri,  3 Oct 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQTQXOgb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EB23814D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507481; cv=none; b=qW6o9nY025NL0AuTmDCZe2lMQDWTZmEvlEKJFnN7nAy7CMhL/uc3sat2rW+7ZMwcEr0mnSK64vf5XwvF4qpjpsxjXvL5vIgaZH7/tq1FtCFsHFkwF6I4hqPASuX7readdCBEt1ji9RiogxhNm+tAEcjSB3OaWSy7XMFVq5H27tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507481; c=relaxed/simple;
	bh=+l8pnmdCZFqroyo6z2cL3V7DuOcMNw+AI+/mO7qpKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BE966ZOJB9Ug6PrHpnhz4OtdEB8VdSFs0ZhvooNm1TkSEQRHo4WGuovhpbaAYlQRuD6VQBXd7L2m5YVlr5XJ4/K0a8plR367IPoTLbQXpcBr+/X3RwZiMRJQZNbkE4h2JKosrLrF6PWF37nw2dt3wp0BIjThARPgUe9Wx6FplXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQTQXOgb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso17721245e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507478; x=1760112278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSGjEQUd9b+CvNz/Ml8Cqt7o21c54FVqeqUV7elEs4I=;
        b=HQTQXOgbzLpwtEiCo5nhbu55djAwWjABOqQ+iiHV28bMbugR5sFnL5yMVuAJqZRbIj
         ZWtN8QACwkKq1riD1YSC46p96GOlhhzaVeE3s4u9dXM7zjx4cJFTKUEFZGX6dVlLe49s
         L9zNOXM3eRkXXa2x5BDl1/grBkKNSsyv0RkUJMqqqttpvzP6tqJus5DfqM7OtAUonmKJ
         2kkXfKmi4gmDJRzm23Bxbyz/PH8jbJf+JDGIC9U15E5D7pmLc2oQf4P4Eu9Ws57VabAi
         y4fv8moeoS4+aqpRlRFXwo0VVGCIlRrE168L3v3Qedf6Gz6qzVL/mLQBA0Zu07pLYbYh
         Pj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507478; x=1760112278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSGjEQUd9b+CvNz/Ml8Cqt7o21c54FVqeqUV7elEs4I=;
        b=kyj5l3QcjsKjJEjshj8eisXJh9k1vWYciDparuw43iiidxjxF67+2kiVeZdscGWJIe
         m8/Z6Jwtgz/Cpb4Z3jraGFslz1yFgYj5oIlWzy/eno7PUkSrHlt04WH2eb5wpYzyAVLc
         XXscIjp8boy3DvIjSAS1fMMASDPx3eIH0v0e5q7sRpjPo7vF4G0B6UJSWc7CJZ3YHit+
         nSIHFbyD6ZlXZ8Y3wPKv/i1nPyoKkrns4Fk0qdmNOOZtgaKImS0zReamuu5ovrDbniB+
         m1eHP9JcELgzUS2XbEYat+Bs+wyxGTJ10pst5pBF9DLxZMgukAkG1CoW7lPwC8dBfawL
         CAHg==
X-Gm-Message-State: AOJu0YweMo+9FY09BYWJRaZiptqHGAB1opQFUEsxOKxmtN7x/6bLVxSz
	7prdctst/50v/vIYfmD1/QiMSUwLsU+sfpi6g+8HBNNDZ0jiap0Z4m1bocDLHw==
X-Gm-Gg: ASbGncubnk4AMIhvstuni/M3cZKrn1pyIM2ff7wIqS0O8qKwrJ168vtk7OupovVbJ9D
	8MZScHgfoOhev5yePjg0wJU8XYEu3Qd4TzWOupWZrvQC5qAp04qhLy2GG0/WZRwp6j3h9Z3sD5q
	gLpVuiXtZbP9beRR1S/CRWLCC/k4KsOj/bD7zxIx4iiS1h36DwaxzcknHN+3yXqvrbEXn++pP5R
	nOryVDNqWEEXMiKZmMmxuMPj09oj+MsentGtlNbXkJJXApMlzhApslyQvUiOxuVsZj4N65/SMJp
	QCfSOD1yue3aW3kdW352Waz6iSBX2ASQ+sEfk+Vbzt2IIAVopjO+UioGRFRG3ARxpnmUIcOBaS+
	E93xMyZOLybxjatvog/21Yp6qtQ==
X-Google-Smtp-Source: AGHT+IEL8TT1O/lsa06FozufhG2bkit9npa/6oFV5olfgrtBq7vKZwrEA9Q+pz/YYlQ+BcJnAzkLBw==
X-Received: by 2002:a05:600d:13:b0:46e:41e6:28c7 with SMTP id 5b1f17b1804b1-46e714acf6amr20177135e9.8.1759507477480;
        Fri, 03 Oct 2025 09:04:37 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3b75sm130284725e9.7.2025.10.03.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:37 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v1 04/10] lib/freader: support reading more than 2 folios
Date: Fri,  3 Oct 2025 17:04:10 +0100
Message-ID: <20251003160416.585080-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
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
---
 lib/freader.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/freader.c b/lib/freader.c
index 32a17d137b32..f73b594a137d 100644
--- a/lib/freader.c
+++ b/lib/freader.c
@@ -105,17 +105,22 @@ const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
 	folio_sz = folio_size(r->folio);
 	if (file_off + sz > r->folio_off + folio_sz) {
 		int part_sz = r->folio_off + folio_sz - file_off;
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
+		size_t dst_off = 0, src_off = file_off - r->folio_off;
+
+		do {
+			memcpy(r->buf + dst_off, r->addr + src_off, part_sz);
+			sz -= part_sz;
+			if (sz == 0)
+				break;
+			/* fetch next folio */
+			r->err = freader_get_folio(r, r->folio_off + folio_sz);
+			if (r->err)
+				return NULL;
+			folio_sz = folio_size(r->folio);
+			src_off = 0; /* read from the beginning, starting second folio */
+			dst_off += part_sz;
+			part_sz = min_t(u64, sz, folio_sz);
+		} while (sz);
 
 		return r->buf;
 	}
-- 
2.51.0


