Return-Path: <bpf+bounces-66939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74805B3B303
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F4F20446F
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239022B594;
	Fri, 29 Aug 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ld3f3buL"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993A1D5CD7;
	Fri, 29 Aug 2025 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447903; cv=none; b=ZWI28P6vhjbijVz6YCteVppYPcuWfxtU8wwff3kNpybzr4KnuveCopRm+BwNC3S8kfQDzn3NwFZ6FhZN6BflLtwpAOW7uKOWREAF97gMEEuR8u+ORVQ6nbi5ke7eINGHfwpNqDFmHjSSJfIPbVsOOswoCrK/5hxfNv7pmBqlgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447903; c=relaxed/simple;
	bh=8eT40SFiTm3bVZK3mBpVRWmv0CD13kcOlWuHOLTsX8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JflV4h3M2jAauMMQYPo5qUILAyFJIsU4TKH6bqTfymKhHRq7kffd1NQpl9jUnGNHljPGqgWUciWCrPg5Wug8mpW01RGaILNKhR7HeA4YcdLBLt4bdFmfBozGuKOtdDyUi9Q5v2k2G5zbjqYmd8Xh6VGkco5Z86zsPd5ydKDr+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ld3f3buL; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cq
	pEj+ueVwgCgyH4K9Q1Vf8CzcGg3m/pudLLnNbw+iA=; b=ld3f3buL4MukubknxU
	+RIMMyVmjYRFVLSHjBZIGVkqQ6NkUBK+7IJ5GZuhnx9ZqwDoO+/vI6j4ReCSk87n
	xczpr4XgXepT9t3OsfNkKylOeRMyh5RQQbfBhIcaBx8ZfogHUIB21f10Wy1ux/Nn
	feACqfp7zLcfI/zeMNDYTmve0=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3vTZ9RLFoGWmGEg--.4740S4;
	Fri, 29 Aug 2025 14:11:14 +0800 (CST)
From: chenyuan_fl@163.com
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	olsajiri@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan@kylinos.cn,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v8 2/2] bpftool: Add CET-aware symbol matching for x86_64 architectures
Date: Fri, 29 Aug 2025 07:11:07 +0100
Message-Id: <20250829061107.23905-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829061107.23905-1-chenyuan_fl@163.com>
References: <20250829061107.23905-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vTZ9RLFoGWmGEg--.4740S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1Duw1kCw1kGFyruFWUtwb_yoWrGw1kpr
	WrJw1YyFW8XrW3Wws3AayUCF43KFsavw4UAr9rG3yI9r15Xr1DZF4xKF10vF1avrykJa17
	AF1fuFZ0kFZIyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jILvtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbBSQa4vWixPi6UnAABsK

From: Yuan Chen <chenyuan@kylinos.cn>

Adjust symbol matching logic to account for Control-flow Enforcement
Technology (CET) on x86_64 systems. CET prefixes functions with
a 4-byte 'endbr' instruction, shifting the actual hook entry point to
symbol + 4.

Acked-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 54 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a773e05d5ade..bdcd717b0348 100644
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
@@ -306,11 +347,13 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	if (!dd.sym_count)
 		goto error;
 
+	is_ibt_enabled = is_x86_ibt_enabled();
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != data[j].addr)
+		if (!symbol_matches_target(dd.sym_mapping[i].address,
+					   data[j].addr, is_ibt_enabled))
 			continue;
 		jsonw_start_object(json_wtr);
-		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
+		jsonw_uint_field(json_wtr, "addr", (unsigned long)data[j].addr);
 		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
 		/* Print null if it is vmlinux */
 		if (dd.sym_mapping[i].module[0] == '\0') {
@@ -719,6 +762,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 {
 	struct addr_cookie *data;
 	__u32 i, j = 0;
+	bool is_ibt_enabled;
 
 	if (!info->kprobe_multi.count)
 		return;
@@ -742,12 +786,14 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
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
-		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
+		       (unsigned long)data[j].addr, data[j].cookie, dd.sym_mapping[i].name);
 		if (dd.sym_mapping[i].module[0] != '\0')
 			printf(" [%s]  ", dd.sym_mapping[i].module);
 		else
-- 
2.39.5


