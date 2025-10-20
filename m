Return-Path: <bpf+bounces-71468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5AEBF3E3C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33E0A4FDDD1
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBAE2F25F7;
	Mon, 20 Oct 2025 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4YYgYJW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA82F1FEC
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999152; cv=none; b=LXo2MAMrVRL6IuhEs8M+heXikn4jgLzioo/fRIc+TrETsuHBOYtoT7K6aZtD++Xeg9VJZfmvc08DbFsngiSsX0EqV0MoYGISBeQ6Ts+5nrIuBHc1NGl09GZOe4m9Y3BhTvALD98P87Ju1Mp43GPhCdGSkcOzSCNbZ/xHlob4P7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999152; c=relaxed/simple;
	bh=YgoY+pgbWPRjmzU4FIIvz4YTxzDxdbdLNMVEhuBqavw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhW2pPwdrScAS1WdeumlTvkiY4iPVij4NckX39LSt6IMNKmkOtRYrXPqIX8a4klUGfvFcsiMa5P/Djaat6W7qWlygZyNP0795ZfeYwf2CLYI3tsV5+fqyPulzpZiF5AhGEbE2hhpghW8tlnXZYubbGgcoeuyiOF2tBL/A/+hGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4YYgYJW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so4198215e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999149; x=1761603949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WQ4CRRRgXLtruImHv5Rpdohd4VhlcBzTPG2qtCf+8I=;
        b=g4YYgYJWdzD2cgnGVwk/45p5l6NmOd9uPTWjqpBcIZXV2JiSVAy9K2XGi+UMpjuWNV
         wgC3gfSZF3GAc0IwRZKRaKkYXXqozsiEH4kH+RD8tp7A95QYIb16VzDDeAIpuLvDwFJ7
         5ZE4qwkK3Fc1cA8sjon/pAq94QI76FvW60i8JZb/uyARYkqydpta/+YvIASVQJAOv9TI
         CYZVd3FkF5U38SomoBiJlm32z2LOq+oHx20+9+vpax8RtMQ4tmZd4/zO/dzSHKCWV2Ay
         iAEyj6L7fE4/qNU9aSKECWjT0KoVSFlfsnKKDmfxpBWjTqgM10elpHw6/HXs7iwgG2Wg
         uMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999149; x=1761603949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WQ4CRRRgXLtruImHv5Rpdohd4VhlcBzTPG2qtCf+8I=;
        b=atK0izG5WKAPM5lo4flvElgXJlDeJIfgmdc93mcTI48xc3XJTJMGzN5QNFjab7T9UT
         +Br3vUTB8Lb+KYroKdNm9GHgSwAOdEtxtHcBdpckodNghHek7Hu5HF5ivWKrpPt2r7Io
         tUk6TXgaJE/HY/i+dVQ+JgLJTDBRnehlujwfwvrgTh+0hhMz3hBbAoB7MjusEiFJSl+k
         j3y3debYZhyEy8WnysKhbzmmbcVc8A6GcLE/bh4aWp689jH04tAo30W3RfxrRbEi9pvw
         GMpJjUPIh5f5RpSA7F7BfB3Q/lRqQVvK0Z3pEiJebfc7rwPW0gtKlpD0Y8tJ1OlggMrV
         Y6JA==
X-Gm-Message-State: AOJu0YzS4RTxRPiZ87Xx8dHxSsKkaEXYJdCxrUslVe34DIy37ytCiKxx
	xtzh60n6VbVKY4Nptxmsu4fqBc0KHKkm8iDbewVnuSBDsCERUI1YjHsSA/YZTA==
X-Gm-Gg: ASbGncuJyuqa+flHajGrLYEwTBzFpUQOIw01XmTj0pYhT0uy7XwGVDsnagbzWJpTTTm
	Gt1tLnyq6bcjN6yzRL0peJziMzN1+s35NrxmNfKkm+2OZCZ2PJch5KTf6F/RLQDjmeH2hfoAyNc
	ptPDEhWJ4VMEfvQP10JGkbN/ve4VJvhki5Zn4lEAii32VhED9qE9/XUWCS2GMNat1UGwCUPqcZe
	+tTLVGZXxmRY/4C/TRL+FxIZdjCErRx3KP4F80y2YN+fkE6obMzgIguxqYWc7OZ8myP0M9YwQbI
	aqBjJ3RrVkYSij1IZ/dINAKrD7IiZLFWgVZX0D5UfKNbzd5naK85oOnPHpi387hqE4Oy7Gt9H+7
	aZhYMVIvvQA6gPZ0cIGJsLxbSrWR2mztznT8YkCr//UoGnszM30r/BzZ3sPk=
X-Google-Smtp-Source: AGHT+IGGClWB5LyDEYscycmqFMnY4UwkV1X+Ab43vUHz958X/dvc66m86hHeiPvEh3EqyaU7fBMSrw==
X-Received: by 2002:a05:600c:3488:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-4711786c586mr104705015e9.1.1760999149145;
        Mon, 20 Oct 2025 15:25:49 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm17469276f8f.51.2025.10.20.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 04/10] lib/freader: support reading more than 2 folios
Date: Mon, 20 Oct 2025 23:25:32 +0100
Message-ID: <20251020222538.932915-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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


