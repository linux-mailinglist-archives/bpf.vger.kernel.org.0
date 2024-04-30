Return-Path: <bpf+bounces-28295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09038B8155
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 22:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD382869B7
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89219DF41;
	Tue, 30 Apr 2024 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKPXVLc0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AF180A82
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508396; cv=none; b=nRvKEhWEEPjBiujoAzmVFIQOW2XPVWQt4ThwqQtiYxtPzeropGFM5exTU57L6NhAY92/CJCWKD0/aZ9PTr/BslMyHokHrx/lmSS/TIpYyWhoOYT40kchx7bI9woS4Yxux+J6eHjKZbRr96pYtiY3UoyTUgjTY35LPbtSW+G8fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508396; c=relaxed/simple;
	bh=ZRwfzgkukq1beMra/ydj1GdxHAa2xc+TarpCA8fx3dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izzIhwqcLO2K52ESKla9DtaQdeDh2p49g2WMIaVhIBdQnU0tpzsZ9MAWYuZuvNb/Pyo5mGo0Y0Quy5emZOixLKLC4EN2w66fSOdTzFL/7OGcuSglnTyrILYjOpoYZUdeIyTiJTsxl/Cy42CM6L1u/KWaycl7An7N5Dqi5D6bhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKPXVLc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D4EC2BBFC;
	Tue, 30 Apr 2024 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714508396;
	bh=ZRwfzgkukq1beMra/ydj1GdxHAa2xc+TarpCA8fx3dc=;
	h=From:To:Cc:Subject:Date:From;
	b=hKPXVLc006FsfIpQlA8V6+XihxyegxBHgW8lgb3nN1SAOa7xN4KZn4YEavJTbl9w1
	 TkAnl9Pqy3Q4AcPZWgIvouc0XQy4QFy3B6fLoAfxeGRq5cdieOKtlPMwXVZGGvJsYI
	 QfzgugZxexfhRmLV3MKzZuPMpBYApOnroS41x+hskAGrGO9800rr7y0aiktlR9/OEm
	 5zD6LB5dEtyI9cvdzZJfLv86gCZKgemZw3107y6af/ZqoT+ROs6JqKqw0SExehoNGQ
	 PMHYz6wUjYsXhdhyUl7Z7Pb4NC5lFRmWiPZmi2HnaKVcqV5UjrbpovrvAtkzq2zI2E
	 +E4gvmm/Xw8TQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] libbpf: fix potential overflow in ring__consume_n()
Date: Tue, 30 Apr 2024 13:19:51 -0700
Message-ID: <20240430201952.888293-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ringbuf_process_ring() return int64_t, while ring__consume_n() assigns
it to int. It's highly unlikely, but possible for ringbuf_process_ring()
to return value larger than INT_MAX, so use int64_t. ring__consume_n()
does check INT_MAX before returning int result to the user.

Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 99e44cf02321..37c5a2d86a78 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -405,7 +405,7 @@ int ring__map_fd(const struct ring *r)
 
 int ring__consume_n(struct ring *r, size_t n)
 {
-	int res;
+	int64_t res;
 
 	res = ringbuf_process_ring(r, n);
 	if (res < 0)
-- 
2.43.0


