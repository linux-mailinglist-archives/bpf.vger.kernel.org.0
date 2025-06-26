Return-Path: <bpf+bounces-61651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E2AE9731
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE3189DABA
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86899239E79;
	Thu, 26 Jun 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MBqRGZ1Q"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8402520013A;
	Thu, 26 Jun 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924224; cv=none; b=FwrmaTlhcKKT7opdGTnU1L0TyRtkzONq3JxELjhxvDVB1RKAIWLZSDBEgrbycMvSFrnkjNe46Kb6VDyEeyv3fHZ9hZsKeenYIHQYTxkUnKFIrJ/1qUwOJGIYduFE26TzfTVHgM7ZkfHb9/vL54037rbfvFTt9ur9Qrmeb93qhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924224; c=relaxed/simple;
	bh=DrLS180neJeC5dQve1RV7glRwMtowA1GDHPS1HnSDh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIKgYHzdDCXFEh+o0XY64Q817Y+2r+5b6d+91nTEFdzzX8Ii05Gh+tvGvn2zlb3x6FOXBx7J+rau/Rej2gG/5lyx9Gmd757PUkb+ftdEO6cjhjaEE1rORpmyNffIKRO6OSzulIKgN1D+cw6DrPDevZhPoKCurewOaWcTuGZXd4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MBqRGZ1Q; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lq
	oqxU9YUnAwTXjO8851Gt6t66InMt1Bb1xi6bmCY3Q=; b=MBqRGZ1QAkAgLEJqCn
	jEBReHftDNkXK1RzVfQobCbcD0d0YQVPNXtLMF+tWSrftG/4+BaM/Kyo7OEMtjEv
	tzwnPfzc8kexu0J5aJWidpvqwdlINg4zs2zBkNmTCBSW2R6wl95Mu/KZXryFHUW3
	WgRf5aOm8OzKCfxghZc1Koiso=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3H4OQ+1xooBCyAg--.46751S2;
	Thu, 26 Jun 2025 15:49:38 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.org,
	qmo@qmon.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v3] bpftool: Add CET-aware symbol matching for x86_64 architectures
Date: Thu, 26 Jun 2025 15:49:30 +0800
Message-Id: <20250626074930.81813-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626061158.29702-1-chenyuan_fl@163.com>
References: <20250626061158.29702-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H4OQ+1xooBCyAg--.46751S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr48Jw1kWFykKr4kWry8Zrb_yoW5Jw45pr
	s3Ars5KF4UXFW3Wws3Xa1IyFW3KFs2v3yUZF9rG34Ykr45Xwn2vF42k3W8AF1aqr1kXw13
	XFyayrZ0gryvyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piwID5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNwV4vWhc8Sv7mQAAs7

From: Yuan Chen <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86_64 systems. CET prefixes functions with a 4-byte
'endbr' instruction, shifting the actual entry point to symbol + 4.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 03513ffffb79..dfd192b4c5ad 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -307,8 +307,21 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		goto error;
 
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (dd.sym_mapping[i].address != data[j].addr) {
+#if defined(__x86_64__) || defined(__amd64__)
+			/*
+			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
+			 * function entry points have a 4-byte 'endbr' instruction prefix.
+			 * This causes the actual function address = symbol address + 4.
+			 * Here we check if this symbol matches the target address minus 4,
+			 * indicating we've found a CET-enabled function entry point.
+			 */
+			if (dd.sym_mapping[i].address == data[j].addr - 4)
+				goto found;
+#endif
 			continue;
+		}
+found:
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
 		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
@@ -744,8 +757,21 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 
 	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (dd.sym_mapping[i].address != data[j].addr) {
+#if defined(__x86_64__) || defined(__amd64__)
+			/*
+			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
+			 * function entry points have a 4-byte 'endbr' instruction prefix.
+			 * This causes the actual function address = symbol address + 4.
+			 * Here we check if this symbol matches the target address minus 4,
+			 * indicating we've found a CET-enabled function entry point.
+			 */
+			if (dd.sym_mapping[i].address == data[j].addr - 4)
+				goto found;
+#endif
 			continue;
+		}
+found:
 		printf("\n\t%016lx %-16llx %s",
 		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
 		if (dd.sym_mapping[i].module[0] != '\0')
-- 
2.43.0


