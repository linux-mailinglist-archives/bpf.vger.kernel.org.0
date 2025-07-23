Return-Path: <bpf+bounces-64135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB6B0E889
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EBD1C875EF
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB651C3C18;
	Wed, 23 Jul 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e190X4xq"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3D7FBAC;
	Wed, 23 Jul 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237301; cv=none; b=GRZnioZ5VDdBryfvQeiOYPxuyfV1ClCrlbpzl3SIuoNKHiDH5BcbctDNyjq1XJiCpStupnkJmCc+jOgjMP/b1/ZIqPn7i2NKPZei0PL7InHah+tDRZf5YkR9KYwCuq+CUDgtzI1I4lgHI9Y0buMYl+8/HH5qDbTI3u0/+LveWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237301; c=relaxed/simple;
	bh=kmGiRF/ZJbNdvxxfMSqhEdF3VhoLo24HWKVd/MwtkSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GflKJbT3IuOPDYOourH2rp/YFJDHYiSemHWKgCuKFlh/W4256vrZ5J+3HR5OCuGlAdkuVOktXKYAJe0pPzOihnyLMlJ8hvOwiK8Gc4yFzreQPhGfXUax1CdGdD7rQbxrwga07uJeKkkY4zvi81FCNB8KxMbtZGb4+OGfIo3bfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e190X4xq; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Reply-To:
	MIME-Version; bh=qbVz3Gyzn0tiU4eAJzg3srV5isJwv1AXwHawFrenFNs=;
	b=e190X4xqQ2eA0YVutFdbvVOX+xHvN8m8RwtCr5Yl3Yd0+vBkt/4AHrGZBLyDkm
	kDMnsGynWQpa2BhichlKx+hMyIiouNCoud2ELS0SUN4iUL5Kih5KFC7CvTeJamQn
	fk5xSTYwWvUOtZSF+R02wHisd8g7n5MLJnenTscpGIup4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnnawBR4BoFrSvGg--.32671S2;
	Wed, 23 Jul 2025 10:20:50 +0800 (CST)
From: chenyuan_fl@163.com
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v5] bpftool: Add CET-aware symbol matching for x86_64 architectures
Date: Wed, 23 Jul 2025 10:20:43 +0800
Message-Id: <20250723022043.20503-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
Reply-To: <aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnnawBR4BoFrSvGg--.32671S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rGw1fur1UZFyxWw1fCrg_yoW5JFy3pF
	WrAws8AF4UXrW3Wws3Aa13AFWayFsavw4UAr97G3429r45Xrn2vFyxGF1IyF1agFn5Jw47
	AF1a9Fs8KFZavrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF6wZUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxWSvWh-mIdtxwAFsq

From: Yuan Chen <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86_64 systems. CET prefixes functions with
a 4-byte 'endbr' instruction, shifting the actual hook entry point to
symbol + 4.

Changed in PATCH v4:
* Refactor repeated code into a function.
* Add detection for the x86 architecture.

Changed int PATH v5:
* Remove detection for the x86 architecture.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a773e05d5ade..288bf9a032a5 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -282,6 +282,28 @@ get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
 	return data;
 }
 
+static bool
+symbol_matches_target(__u64 sym_addr, __u64 target_addr)
+{
+	if (sym_addr == target_addr)
+		return true;
+
+#if defined(__x86_64__)
+	/*
+	 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
+	 * function entry points have a 4-byte 'endbr' instruction prefix.
+	 * This causes kprobe hooks to target the address *after* 'endbr'
+	 * (symbol address + 4), preserving the CET instruction.
+	 * Here we check if the symbol address matches the hook target address
+	 * minus 4, indicating a CET-enabled function entry point.
+	 */
+	if (sym_addr == target_addr - 4)
+		return true;
+#endif
+
+	return false;
+}
+
 static void
 show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
@@ -307,7 +329,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		goto error;
 
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
 			continue;
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
@@ -744,7 +766,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 
 	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
 			continue;
 		printf("\n\t%016lx %-16llx %s",
 		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
-- 
2.25.1


