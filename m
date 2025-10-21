Return-Path: <bpf+bounces-71627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AE8BF8812
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 733904FAE0A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56678279792;
	Tue, 21 Oct 2025 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajcrWtMG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02077277C81
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077030; cv=none; b=KtnltriSJ+AY+t4e5etRqU89gAxD1wMTBn+v7zCpn5xwjlZvnKs1xsdDaSDzhYbZ2f/RnGAwln63fJN8LhA1mOw54AXaXJPGjlfBnYpZTKyua64n6KKTbJxMBQ1uCkTSAxwUzusCe82ZgNS+bh58JmK+Awg2c07EfHoNAcBZbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077030; c=relaxed/simple;
	bh=YgoY+pgbWPRjmzU4FIIvz4YTxzDxdbdLNMVEhuBqavw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIjdmPxohMR7WCfRaj8HjszWP2AzqCzu1pkMckY4ZZQWqxeTuYyUjhBj1N7H6R3tL0asGVzf1Nuc6qjHO4BJB9ht5jV0BkoCfsch18KOTgFw44mnHmMmoCGXwPI4dDT+HST02nfbCh4W8j6GZvohcbqsY3xiCg49PAbE7jcadG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajcrWtMG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so3853049f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077026; x=1761681826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WQ4CRRRgXLtruImHv5Rpdohd4VhlcBzTPG2qtCf+8I=;
        b=ajcrWtMGPA6pS27IdSu1VDw7QUYaiip3ppffQGj6xiWU6wLGHx4PCPscBEOOuaD9I3
         DVQQv7gEQnE3X+xR5VfnQiQdlco4tjyiYP5qGPSbWIrWmKtnZfesmwOZLeNJvAjf6JPd
         F6k3hUNTaGp/mR0pWITz0VJ0Al1Rfr8KiGOmw+ZqGwsIDjKTsajIDhK4Z+sNPGjjVLFL
         YpqrxMdABq5teHDZvBFOYj5rzB1mMD5xwZGP+q+aPsb1OAZ1v2T5Msh3A8AaNWb6z9r8
         lGxd79cfHCzslDqigKUH34WGWZKvnTNZ3nQGIhlDlrsuCAzcB9S+frxsiBhjrJFh+NKr
         ArGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077026; x=1761681826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WQ4CRRRgXLtruImHv5Rpdohd4VhlcBzTPG2qtCf+8I=;
        b=GCWOhRBseEuGYxuW0+SnCGtSJef9mYfKNCMMrIcV80qXEMfZ3+8HEJJ19XEUN72j/6
         iJBgU8LYZGSxr2P72DAwT6yYfpOLJnLhQVAhN8VevNBQptArwHVQJOSDpc8QIOVaECIb
         cb5UqEG4tBv5zu/G+IBe6SSlel4SXQI3OiJKCVz5txesUhpqNRjNo57f60JWg8GE4SQ/
         wGB2VHIVnmo4oMlUWLxntwkO6ZI4J8wmMbUl7hTZ+D5dDS0lFg3UmtKBZNlPtqvJHRQJ
         /c7w0BwICu6ufprUwPN6D3OCduhzUWL+POLf6FfHSgViwOkSMQiSb1g8xmNiIKJIZfDU
         LDdg==
X-Gm-Message-State: AOJu0YyAgKHBPntKW1XzCewqd8qc0IObbLcpSM9UsmJ2DfBMx3zD2sLC
	5M7jYp+pbt5hNwjCmWAUlHV/cVUNWeRCYDrxaD5pvaU7W0/56TSoc6FjKOMcfQ==
X-Gm-Gg: ASbGncvE7FC+jNOjK9rSBMRH/W2eiEAz9Pndc7R5m9XlAHU4++sdjgozgONiX1e3Hjj
	DBhX5P3UjHv9BE1SIdL2WN8EUFqNIFQy0KehWXCdAR9q5O+SnkKi2py3t6mrVSsZHsBsNY8OMSa
	Vszs7GqLw/b1//9aPzv1cqHue1vLkQy2LB1RXpubz0WCEoUJC/nr10CYw3hqIWIvUB0Z94Q8I5q
	CUGodtbw9Ymq3K8skIycMsIlyhSsahMKroaBJ+OlAh9ayEVHNoS+bDmpEv3JCLcaFl7SXOt2XWq
	tXpaquAZWqvKi2I8g5MK9WAk2uSD2slmzezY6yCwf4Dja8dss6DJYd8vqFJrg6Vtkw1qb9CsCRp
	cC02Unl/fFn749BeM9phjIUx+qKlIJ14D6DbmNLEftOa6xKg0h8EEKVY6Plbppn2A7pTKOpE=
X-Google-Smtp-Source: AGHT+IFPHqBTrFMEusqmMcCvImeEFqVJZFfO7Pg7OJqZ9KajIZnN59jG3YDiBZf90xIA/JRZqUkuTQ==
X-Received: by 2002:a05:6000:2087:b0:427:921:8972 with SMTP id ffacd0b85a97d-42709218a43mr10807665f8f.40.1761077026114;
        Tue, 21 Oct 2025 13:03:46 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c65sm21686787f8f.15.2025.10.21.13.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 04/10] lib/freader: support reading more than 2 folios
Date: Tue, 21 Oct 2025 21:03:28 +0100
Message-ID: <20251021200334.220542-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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


