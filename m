Return-Path: <bpf+bounces-71022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63FDBDF98B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA83B4AB0
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A93375BA;
	Wed, 15 Oct 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDjHHara"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D2335BC6
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544725; cv=none; b=FDPP5UxSSBZUxJxsaMYV7Raw3B9tTXX+t8YfyKV8Mw5o5t5QHnySZrROw0Z+H86Gzbs9A73gy3eMk7Wf8K1bdINMly4v0tOU6a/P82S8a01XTi+3xGrRBilcaxxja5PMh/B2y45aGnyRB079Xbh7P6IBLb4H/RP6KhTDvmYVTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544725; c=relaxed/simple;
	bh=BSnac3UTqnwJXUXsDyxzn1XOLPAD8nxkfD7Crr51T60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KN4KxGVWX0J+FZkjTVcV7BCKAdXYIzSOCgPR9UJuts2WMAvZoU1cBjbk1yHcVhaLAWnAxlBLJ8vC+evYbE/BdLSJQI1JNvoZ29ILYdw5Kkx8Ve1z51TsXUvudIUHa9fwSgkkd1XQRxJtgKCdInCqrX/8oVj3UrLc05zLpl0T2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDjHHara; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso39222245e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544722; x=1761149522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVbTl2PuQSrCprNzYvKsMw5tsg+Vjhdov6vWIJWYmK0=;
        b=aDjHHaraQBJ0JzdPI+ecJeCntP8SrNI+R5e6H1S5pv0D8iQTSpyQIHxvYGDYfTKo05
         R+HupFsYTsLbaBmiJoH25VTo97b3TATEOuMGMD7GamDt4Cl3rRHHQRhIimkjKnbcPLho
         O+plcT4/iSGm7VfVFQcral4A9yOelSQ/lB3C2FH0Vs0kNp9aBJrE4kAZaRmEg7DudP2N
         /pyCz+aD/FnMXsRzhDuVvDkBTRXnEv6fSHuRjnAytMC+WCYBDgChsjiAHGffVbR85YO2
         oQvEjSC5yEzofGvhy24PYQNsQN2Q7oXxoETHAgLRAIprmutEIFUVYqa4dyElr2iGC/bq
         9ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544722; x=1761149522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVbTl2PuQSrCprNzYvKsMw5tsg+Vjhdov6vWIJWYmK0=;
        b=fGLqn2MD9t2/A6GkdX5RhvbbYpireHdykNAIgnfcBMKj/3TFACCwL+VZWmcAA39oPK
         19dALIfZUnCPv/t0yd6ZhmWk3GHoLJ0g6EECnINUJhWu1s5oKMMuRyU3cNMHaaAhJcY7
         hDmmydg1n7BavdSfgNvgS+3t9Is2CH6N5bd2dZVJSTrVB7WXNjhNvPPPhZKMrQOfHqsu
         jtD4wriIasnnvxi3+Go0vlc3l3rDV9GvpHpVSKfqw7Dc4spkwBV/PBjKOuWBKUlUbhku
         78r6RhQBvEjDD3aWWQktaO685H0clvUEhZziOo4a3UfIfA043vY1LUREV/NrO3zxUEMe
         xK4w==
X-Gm-Message-State: AOJu0YzBiWDv5SUaRHiEEpOdvJkr9ZiyxvrElTALOTi27He8Ea1+9EM5
	bl756l8nxbf9rHqLDYeXHIOETje/QbT9Enfl8F1Tr+Lle2CjIDIl0djp2lxfxg==
X-Gm-Gg: ASbGncvOW8JNPXeVOHDMPBeqvmCMh5KC1aEB113rJ/uGWbC8+TVjVG7nsagqFSVq9q1
	rt2qy+5yDtRICrwbAWP8yl7I0gQkK6lMfoFe31D6CsXy3zYED+2Ia8YnzntZBLzlmofja9bwoTO
	MXzdAyXeN3Ngb5fRJVCYz8YM73NWmtKjRGpy80DCKE/uxxbB/po438fr1PzrQDYYmlGb2+AFUam
	uijhD5lsn1OnMjZBSway9Ch2J7LNHDDcX6SMGzgpI0qAzAeQzsTErbzhGD8US2/DBjxvkCol3sV
	cNUD0ly2VGYUBLA47ZyX+fX2SS5RJaJH/P3y2n8Sl3HqLabIUyx6HdjXJDs1oUkJ80/un/PJEmR
	keuayVNCH3KductJHjqkYyZnP5IpUF60gshDCQgMo/47ciNoKLQmF2VCrYvNkQhzdig==
X-Google-Smtp-Source: AGHT+IEJc479XkNzgz5qdjMdaVDmzDp5GZESPYa0wBWWn1Mpz3qVPrkao4R+fEKGI79b/qvnIF4ICg==
X-Received: by 2002:a05:600c:4690:b0:46e:31c3:1442 with SMTP id 5b1f17b1804b1-46fa9af9811mr201306195e9.18.1760544721939;
        Wed, 15 Oct 2025 09:12:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc78559c8sm84921885e9.4.2025.10.15.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/11] lib/freader: support reading more than 2 folios
Date: Wed, 15 Oct 2025 17:11:48 +0100
Message-ID: <20251015161155.120148-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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
 lib/buildid.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index df06e492810d..ade01d7ff682 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -108,18 +108,20 @@ const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
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
+			part_sz = min_t(u64, sz - off, folio_size(r->folio));
+			memcpy(r->buf + off, r->addr, part_sz);
+			off += part_sz;
+		}
 
 		return r->buf;
 	}
-- 
2.51.0


