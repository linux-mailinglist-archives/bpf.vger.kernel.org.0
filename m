Return-Path: <bpf+bounces-63978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3AB0CF77
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D3A7ADDC4
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0D1D5ADC;
	Tue, 22 Jul 2025 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H41QB2Su"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39818E25;
	Tue, 22 Jul 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149649; cv=none; b=aMrSDm3ohUxBf5EIYULZr4876tFmRfyojsgd9a41LEYxAIJei/6T5uVbra8XaTgtKRRhheylO1eznLemh+Y4VYyIsumDRQYqlS2IbbBChWaPNUZ3Dgn2JWAMkitPz8t52MFi4IDAMoK/shD1Ut3U8SHRFpHBfnC2YgU0TkCPO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149649; c=relaxed/simple;
	bh=Arb2kAB1fXl/ujCv5AJq7KwPVB5a1pOLsP9iJnNeYbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjWH5FSZ/DeCl2PnY+vdln1ojVKj/53k1vHto4pJ/Er3MR+Q3YSH2gw3yo3M9zkGIbwblRc5FVBPfTduY/Krx1ZDvQYYqzuwo14thofGNingFHQTTFq7GypfdUk8sDEZ51VJw5ggrFRLtOywwygBQ7p8TzeBOW9GofW+B+zW1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H41QB2Su; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3n
	24UHjigYYU3h9cCdzH+X8JMSVYyulsYNgdJQYdlTY=; b=H41QB2Su2LBJRiuyF8
	QqFhri7v0a3Z2S+eFMVdgRkFmbxDjhVwMZ81mgmE//mjffqeYPlDaa4lhyU4VQkV
	63+6SCfHNkIYWHlfvhh5I5B8K0LeRzq2GtMxAB+FW9vm/Gyo8EsxcV18eooi+goA
	UIjjbeA0S0glLtY6eyNlgGXiY=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHewun8H5o60m0GQ--.7S2;
	Tue, 22 Jul 2025 10:00:10 +0800 (CST)
From: chenyuan_fl@163.com
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v4] bpftool: Add CET-aware symbol matching for x86/x86_64 architectures
Date: Tue, 22 Jul 2025 10:00:00 +0800
Message-Id: <20250722020000.20037-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9f233a20-6649-4796-9ef4-a499382b0006@linux.dev>
References: <9f233a20-6649-4796-9ef4-a499382b0006@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHewun8H5o60m0GQ--.7S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rGw1fur1UZFyxWw1fCrg_yoW5JrW8pr
	WrAwsYyFWUXrW3Wws3Aa1ayFWayFsavw47AF97G3429r15Zrn2yFyxCF1IyF1aqFn5Jw47
	AF1akFZ8KFZavrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF6wZUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNw6SvWh+7D4fwQABsN

From: Yuan Chen <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86/x86_64 systems. CET prefixes functions with
a 4-byte 'endbr' instruction, shifting the actual hook entry point to
symbol + 4.

Changed in PATCH v4:
* Refactor repeated code into a function.
* Add detection for the x86 architecture.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a773e05d5ade..717ca8c5ff83 100644
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
+#if defined(__i386__) || defined(__x86_64__)
+	/*
+	 * On x86 architectures with CET (Control-flow Enforcement Technology),
+	 * function entry points have a 4-byte 'endbr' instruction prefix.
+	 * This causes kprobe hooks to target the address *after* 'endbr'
+	 * (symbol address + 4), preserving the CET instruction.
+	 * Here we check if the symbol address matches the hook target address minus 4,
+	 * indicating a CET-enabled function entry point.
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


