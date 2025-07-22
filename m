Return-Path: <bpf+bounces-63977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A6FB0CF45
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FB61C21C77
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20A11D6DB5;
	Tue, 22 Jul 2025 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bmn0F9G4"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AF1D54D8;
	Tue, 22 Jul 2025 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148856; cv=none; b=gbFwBuuC2cyxa6zbat7m3Hnv9U7N6lhAU0hdNVFGte75j4wHA3Xoie0CzxTE+7/Syum2Dl3fmjvDWjBuDt6do6jxtaRK/7O7xRDfHvOMvkIDHkKuagaAcsPrEw7P1g5vsOrL0DGQD4t3+BR1oaLZZeJnMFLaTt70GxJ/kXOrnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148856; c=relaxed/simple;
	bh=wA1QITrQBhdk+4tvlTm+Tov0pvRC29l4XibQzq+mUzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiVaenqMju9/UvNy03ctaS5Lf5oDp7LS/btuyAn20c9LksE6O1d7mY8P9rOVEUfNz8bcLsELkj1E7J7wuKfP+eNE0T0jhnzm3PDPd9QgfazLyR1xjfhsVRIqZV4zp585I7vPcc8vXpyB4H0eXrH30uZ4Ayep9WKpxE3H0LdAxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bmn0F9G4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UF
	FA3TVgkftJ5l67i2jAJr8Ojd09cjfv7mgXsQZyJeA=; b=bmn0F9G4mKZ2F778aD
	edxDi8mBkR7SetlQS5yOTRQrNroAO0kbbja7VZQ0o55LGMag8rPSv2hfcK7SA6XM
	uiewlmDxhrKH+rG0Z1OmI2JMguAFyn67iRJWc6/ittmRBU8xZiijgFHwAGQwj2uP
	ZL37BdojAMbNXUJX4SFfrGuoI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P0WJ7X5oMjZkGg--.28519S2;
	Tue, 22 Jul 2025 09:46:49 +0800 (CST)
From: chenyuan_fl@163.com
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.com>
Subject: [PATCH v4] bpftool: Add CET-aware symbol matching for x86/x86_64 architectures
Date: Tue, 22 Jul 2025 09:46:42 +0800
Message-Id: <20250722014642.14073-1-chenyuan_fl@163.com>
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
X-CM-TRANSID:_____wD3P0WJ7X5oMjZkGg--.28519S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF43uw13tFyruw1fJFy7Wrg_yoW5Jw47pr
	WrAwsYyFWUXrW3Wws3Aa15AFW3tFsavw47Ar97G34a9r45Zrn2yF1xKF1IyF1aqr1kJw47
	AFnI9FZ0gFZIvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFq2NUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiUQ+SvWh+7IsVFQAAsA

From: Yuan Chen <chenyuan@kylinos.com>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86/x86_64 systems. CET prefixes functions with
a 4-byte 'endbr' instruction, shifting the actual hook entry point to
symbol + 4.

Changed in PATCH v4:
* Refactor repeated code into a function.
* Add detection for the x86 architecture.

Signed-off-by: Yuan Chen <chenyuan@kylinos.com>
---
 tools/bpf/bpftool/link.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a773e05d5ade..9e5d85421919 100644
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
@@ -307,8 +329,9 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		goto error;
 
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
 			continue;
+
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
 		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
@@ -744,7 +767,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 
 	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address, data[j].addr))
 			continue;
 		printf("\n\t%016lx %-16llx %s",
 		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
-- 
2.25.1


