Return-Path: <bpf+bounces-65706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A784B27661
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 04:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6281C86000
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 02:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CAC2BE027;
	Fri, 15 Aug 2025 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fE2MBgIb"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7D29CB4A;
	Fri, 15 Aug 2025 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755226401; cv=none; b=QwV1ETnl2XouoWq/jt3Rj4s0Kx4tluP0GcdsljtH1lxU2BBz74iiSIstsrnI0UfnjupA+q5gTYFgvKryNCQW6NeXsFLti137pEfqcS7RCfzWFLG+3wxPPeiE2irTsJc0Ht2AZBahGE+/filbrSLze8bbf3meZ43imjqBx4TsWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755226401; c=relaxed/simple;
	bh=f9NJzUrhCOM9KilhriBKA/T6jjoYILPLXQjI1+nqMZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFkLzHeLFciGj7gnL8MP302V0VzeKHtxbB2HrR9qS4zx6swWHvpGgSAd7vN6C3qsQeX3LzOAsR9KWp3KihPByveycRGQ4QICd6v4MLM1i2Z9PUOxj+k0/VwtlGuT33WJr2+m7Qk8rd9OeSeFk/7bOc2nRBc7o2q+emmGeOxkiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fE2MBgIb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ir
	oJxSNUvK7lBdPM6Ibdm0a9Y1ycJgleUpcpGhBKzPk=; b=fE2MBgIb7U6L7YSBLH
	YMZg62SX3fAzFr1TEUsVMweqenNuDbIUZldSL6haZQMbH90PGxF8brA72dNRJAB1
	5LD1OB0idLLxQ7orpd4vDyrGIrOCZm4eVaVhVM3UC8gxR2SjoUf3XeRqVgU6HIdh
	7RLHsHyzrNnXiq5THgSktpu0c=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnIl_toJ5oqDUKCA--.29342S4;
	Fri, 15 Aug 2025 10:52:52 +0800 (CST)
From: chenyuan_fl@163.com
To: yonghong.song@linux.dev,
	olsajiri@gmail.com
Cc: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	qmo@kernel.org
Subject: [PATCH v6 2/2] bpftool: Add CET-aware symbol matching for x86_64 architectures
Date: Fri, 15 Aug 2025 03:52:27 +0100
Message-Id: <20250815025227.6204-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815025227.6204-1-chenyuan_fl@163.com>
References: <74709a08-4536-4c5a-8140-12d8b42e97c0@linux.dev>
 <20250815025227.6204-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnIl_toJ5oqDUKCA--.29342S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1DtF47WFWUKr1xKr15Jwb_yoW5urWrpr
	Z8Jws0yFW8XrWfWwsxAayUAF1akFs7Zw4UAF9rG3yI9w15Zr1DZr4xKF10vF1avr1kJw47
	AFna9FZ0kFWayrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIWlkUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbBSQSlvWiX9VwW2wADsN

From: Yuan Chen <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86_64 systems. CET prefixes functions with
a 4-byte 'endbr' instruction, shifting the actual hook entry point to
symbol + 4.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a773e05d5ade..6787971d3167 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -282,11 +282,52 @@ get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
 	return data;
 }
 
+static bool is_x86_ibt_enabled(void)
+{
+#if defined(__x86_64__)
+	struct kernel_config_option options[] = {
+		{ "CONFIG_X86_KERNEL_IBT", },
+	};
+	char *values[ARRAY_SIZE(options)] = { };
+	bool ret;
+
+	if (read_kernel_config(options, ARRAY_SIZE(options), values, NULL))
+		return false;
+
+	ret = !!values[0];
+	free(values[0]);
+	return ret;
+#else
+	return false;
+#endif
+}
+
+static bool
+symbol_matches_target(__u64 sym_addr, __u64 target_addr, bool is_ibt_enabled)
+{
+	if (sym_addr == target_addr)
+		return true;
+
+	/*
+	 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
+	 * function entry points have a 4-byte 'endbr' instruction prefix.
+	 * This causes kprobe hooks to target the address *after* 'endbr'
+	 * (symbol address + 4), preserving the CET instruction.
+	 * Here we check if the symbol address matches the hook target address
+	 * minus 4, indicating a CET-enabled function entry point.
+	 */
+	if (is_ibt_enabled && sym_addr == target_addr - 4)
+		return true;
+
+	return false;
+}
+
 static void
 show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
 	struct addr_cookie *data;
 	__u32 i, j = 0;
+	bool is_ibt_enabled;
 
 	jsonw_bool_field(json_wtr, "retprobe",
 			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
@@ -306,8 +347,10 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	if (!dd.sym_count)
 		goto error;
 
+	is_ibt_enabled = is_x86_ibt_enabled();
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address,
+					   data[j].addr, is_ibt_enabled))
 			continue;
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
@@ -719,6 +762,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 {
 	struct addr_cookie *data;
 	__u32 i, j = 0;
+	bool is_ibt_enabled;
 
 	if (!info->kprobe_multi.count)
 		return;
@@ -742,9 +786,11 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 	if (!dd.sym_count)
 		goto error;
 
+	is_ibt_enabled = is_x86_ibt_enabled();
 	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address,
+					   data[j].addr, is_ibt_enabled))
 			continue;
 		printf("\n\t%016lx %-16llx %s",
 		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
-- 
2.39.5


