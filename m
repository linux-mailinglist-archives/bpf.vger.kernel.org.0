Return-Path: <bpf+bounces-50931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4FA2E57E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9084918883FF
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775513AA53;
	Mon, 10 Feb 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cKiyXK/U"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0EF1A3159
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172966; cv=none; b=g8muTeDD9IfQ5sBa5IAsOBXhEgCq/EfGHPn22f/XHIHvK1VQrGGSIehcIQG1lDjKIV5i3WcigrGJ8Lserf51nYiegfPb4yVktAZPyQqzLBDj+0SUA2r0sqfqXDEBG01QXEzhboJlDAwrJfIKj7vmUbB4b0ExIfiUdKIGEPPiDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172966; c=relaxed/simple;
	bh=X0NDo99JUIhQgCkXEGpBHD1c4bE5QBncu5qCdxZUJq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFFXkF8MYXzK3xc/k6nRCSEMeiRFY0RlrXLtXICP/4Vpc+N8/MnuEYsK3yoteqoEdCwiwZekceOl1D7MgBZGhXh4fRwBz9cvxvkNjDbf6+6N0z2d1xLeoH+Ph4h6DHLUaEVD4lEc1MygUQCrudmxa0xlCYKavOtqW9AMXUA62+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cKiyXK/U; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hjvZs
	QtBjoXdIYM1DEU6F0kCZ75RAR5nAAaL09pCXmg=; b=cKiyXK/UyHTXuZ82fgys5
	/UaExHwrAcAf+C/1Au1u2udRtfNuSQvyH9+T7WFbza2hbS8RtPN6BNFPZMZbNw+Y
	0HLisuOeu2Xr5rcIjRioIp76ey6FXVphUo3EStUhpP/kiIKe6ydM+Azu9YjYQedM
	hM2Sxo5Ap0DC3Bf5vu7+qE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHQY03rKlnG_C_LA--.33048S4;
	Mon, 10 Feb 2025 15:35:20 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH 3/3] Revert "bpf: Support __nullable argument suffix for tp_btf"
Date: Mon, 10 Feb 2025 15:35:09 +0800
Message-Id: <20250210073509.232007-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210073509.232007-1-yangfeng59949@163.com>
References: <20250210073509.232007-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHQY03rKlnG_C_LA--.33048S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr48Ww15AFy7CF4fZw4DCFg_yoW5Cw1xpF
	13JF9rAr4IqFW7uF18AFs5ury5Jws5W3y7KrWkJw1Fyr17ZrnYqa13Kr1xZ34ayFWUG340
	vF13urW0qw47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7sqJUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiGB7veGepq0oTmwAAs2

From: Feng Yang <yangfeng@kylinos.cn>

This commit 838a10bd2ebf 
("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL") 
has already resolved the issue, so we can roll back these patches.
This reverts commit 8aeaed21befc90f27f4fca6dd190850d97d2e9e3.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/btf.c      |  3 ---
 kernel/bpf/verifier.c | 36 ++++--------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9433b6467bbe..e66f98b493d0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6683,9 +6683,6 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
-	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
-		info->reg_type |= PTR_MAYBE_NULL;
-
 	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
 		struct btf *btf = prog->aux->attach_btf;
 		const struct btf_type *t;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..3c40b5b18f46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -28,8 +28,6 @@
 #include <linux/cpumask.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
-#include <linux/trace_events.h>
-#include <linux/kallsyms.h>
 
 #include "disasm.h"
 
@@ -22509,13 +22507,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 {
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
 	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
-	char trace_symbol[KSYM_SYMBOL_LEN];
 	const char prefix[] = "btf_trace_";
-	struct bpf_raw_event_map *btp;
 	int ret = 0, subprog = -1, i;
 	const struct btf_type *t;
 	bool conservative = true;
-	const char *tname, *fname;
+	const char *tname;
 	struct btf *btf;
 	long addr = 0;
 	struct module *mod = NULL;
@@ -22655,34 +22651,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		tname += sizeof(prefix) - 1;
-
-		/* The func_proto of "btf_trace_##tname" is generated from typedef without argument
-		 * names. Thus using bpf_raw_event_map to get argument names.
-		 */
-		btp = bpf_get_raw_tracepoint(tname);
-		if (!btp)
+		t = btf_type_by_id(btf, t->type);
+		if (!btf_type_is_ptr(t))
+			/* should never happen in valid vmlinux build */
 			return -EINVAL;
-		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
-					trace_symbol);
-		bpf_put_raw_tracepoint(btp);
-
-		if (fname)
-			ret = btf_find_by_name_kind(btf, fname, BTF_KIND_FUNC);
-
-		if (!fname || ret < 0) {
-			bpf_log(log, "Cannot find btf of tracepoint template, fall back to %s%s.\n",
-				prefix, tname);
-			t = btf_type_by_id(btf, t->type);
-			if (!btf_type_is_ptr(t))
-				/* should never happen in valid vmlinux build */
-				return -EINVAL;
-		} else {
-			t = btf_type_by_id(btf, ret);
-			if (!btf_type_is_func(t))
-				/* should never happen in valid vmlinux build */
-				return -EINVAL;
-		}
-
 		t = btf_type_by_id(btf, t->type);
 		if (!btf_type_is_func_proto(t))
 			/* should never happen in valid vmlinux build */
-- 
2.43.0


