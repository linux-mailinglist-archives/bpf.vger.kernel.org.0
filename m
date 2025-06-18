Return-Path: <bpf+bounces-60884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD9ADE0A0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 03:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3EA189CB04
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8E17C211;
	Wed, 18 Jun 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UofJ55Nf"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A6522F;
	Wed, 18 Jun 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750209609; cv=none; b=GzeCe+P4QmAeU9CahBrNhEsKBhSWRIPnIUmEwm+sLIVXc0mC8I8qSxN7QT9p385+rH6k0MRb9vYMRFfZi0HWtNJLXqRVFQRKR2OzdXJnSNvAuJUO8jN24VTkLDkesBcVIb8g0ZdsdgMqL+xf6WRm+/kGf5z0g8t1+TiiuPQTkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750209609; c=relaxed/simple;
	bh=GSlCfS4KpSEwtC7tiXYXLQqO0FpVAZR012++6tFEayY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcbQwZJfZ7FKGf4f1bkMBecwPGSAdLPHAHNt+yiWYYXBVBhY/LPeU1CLz70soVv+YMT6tnXN4rRBzi9sDuCxFiL7/wfaSzqCMUl5rSymnMeg40mwxqZlYDVCFuETxRUKW9LO7zxEnPEvrgn8Gdt1sxqTiLXy/ksesi+8sGARulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UofJ55Nf; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yR
	LjXnG7P8t/iK8n+LF0HnDZ3TakiYuoqdEOZIveRAY=; b=UofJ55NfUk5BTjvmGP
	A2ntqENLZEiBz2E0Ge+ea/Ih9lWGpk5zwyhQGLnsL+DbXeLJRKnmKif13kk3JZtU
	Xz0wc8LLV9J0iLVDxXOa6sBCjghuhE1Nf/qmpodfb0b0iyTAotwGyYDfSEGsSORy
	spsNZxI4/JFc4NsvNPHCCuGyA=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXX4YtFFJoJT98AA--.19090S2;
	Wed, 18 Jun 2025 09:19:42 +0800 (CST)
From: chenyuan <chenyuan_fl@163.com>
To: ast@kernel.org
Cc: andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	chenyuan <chenyuan@kylinos.cn>
Subject: [PATCH v2] libbpf: Fix null pointer dereference in btf_dump__free on allocation failure
Date: Wed, 18 Jun 2025 09:19:33 +0800
Message-Id: <20250618011933.11423-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX4YtFFJoJT98AA--.19090S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryDGw4rKFyrAr1kCr1ftFb_yoWDXwc_GF
	48ZrsrJrWYga9Ivw1UCFZavryfGFW5Ka10qrn5KrnxKayUG3WUJrZIvF9ayFW3G3yktFy7
	KasYgF93tr4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRttxh7UUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNwtwvWhSCmz3uQAAsj

From: chenyuan <chenyuan@kylinos.cn>

When btf_dump__new() fails to allocate memory for the internal hashmap
(btf_dump->type_names), it returns an error code. However, the cleanup
function btf_dump__free() does not check if btf_dump->type_names is NULL
before attempting to free it. This leads to a null pointer dereference
when btf_dump__free() is called on a btf_dump object.

Fix: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: chenyuan <chenyuan@kylinos.cn>
---
 tools/lib/bpf/btf_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 7c2f1f13f958..f09f25eccf3c 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -227,6 +227,9 @@ static void btf_dump_free_names(struct hashmap *map)
 	size_t bkt;
 	struct hashmap_entry *cur;
 
+	if (!map)
+		return;
+
 	hashmap__for_each_entry(map, cur, bkt)
 		free((void *)cur->pkey);
 
-- 
2.25.1


