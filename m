Return-Path: <bpf+bounces-21148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E17848B9A
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 07:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42518B23276
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9079E0;
	Sun,  4 Feb 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeGpWVsH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED179D8;
	Sun,  4 Feb 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029910; cv=none; b=cTxSNc4m+cGLKlzZLx4BohzpJintU8Er2pQoPr7EpXi1+9V+1sj4ZlIA5wZlx0lJ/TfSkw050+osMuCF4WdQJYgLziaV5GF/Ek0D7Dj+1dq19qWMYMKdQiYNlooqcCpLqOZbjiq8QMyWA80iKcoc0X6W8s+BCvQMJbOW5VZOqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029910; c=relaxed/simple;
	bh=k9AifK51mhoszp31sOs1tkzmn8zZLwblUNZUTc+Syx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXQPBtWpZb2EQE+CfPrPU1irddm1144hClORoT/Q3i6WkD1PQXQL9RAfzgl8UUm7kTtVVSLQHyVWHEo4yRaBTpbvG//1Gv8bVhS96ksetOmgLeODP/7KoihoBbok59b9jv9Qza7mVpE8sQzK1CveSMM4UIsOQOeLwrRW4Ak2tVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeGpWVsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB44C433A6;
	Sun,  4 Feb 2024 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707029909;
	bh=k9AifK51mhoszp31sOs1tkzmn8zZLwblUNZUTc+Syx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeGpWVsHszAe6Qwk8YETEmU4G7kbRQgMOc7+2wulP+FttF4xExdkfYPUB7MMgjWAl
	 PicjbPRBzX46GhzShBKduYNNxBDickyRpej3ZgDScWjNh3bHaVEf3iVknPN1QODYjL
	 Bx/DgXTjwdyPvvmDsMAt2BuLWDK9QR5QRGAYVK0sYXObmN10NBubtAR5IUYRdGRebP
	 gbsD2XcB5GrIGk34P7iAlzLaFl4jmgTB1lUbByXlA/ajCxSR2wn0+00fuNLU8U7yoJ
	 jQS4zjzaBvJ9jlEOaxQ5Zs8HWwqgePS+CbsiPOeflFTA0fsPTNN+VZTz2/6ku+fX62
	 kptwyKA5sJLTA==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v3 1/2] bpf, btf: Add register_check_missing_btf helper
Date: Sun,  4 Feb 2024 14:58:12 +0800
Message-Id: <6dfe28c4045e1a3d31b3ba60dde31c7650ac66df.1707029682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707029682.git.tanggeliang@kylinos.cn>
References: <cover.1707029682.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts duplicate code on error path when btf_get_module_btf()
returns NULL from the functions __register_btf_kfunc_id_set() and
register_btf_id_dtor_kfuncs() into a new helper named
register_check_missing_btf() to check CONFIG_DEBUG_INFO_BTF,
CONFIG_DEBUG_INFO_BTF_MODULES and CONFIG_MODULE_ALLOW_BTF_MISMATCH in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7725cb6e564..d166c12206ea 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -26,6 +26,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/module.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -7738,6 +7739,24 @@ static struct btf *btf_get_module_btf(const struct module *module)
 	return btf;
 }
 
+static int register_check_missing_btf(const struct module *module, const char *msg)
+{
+	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+		pr_err("missing vmlinux BTF, cannot register %s\n", msg);
+		return -ENOENT;
+	}
+	if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
+		if (IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
+			pr_warn("allow module %s BTF mismatch, skip register %s\n",
+				module->name, msg);
+			return 0;
+		}
+		pr_err("missing module %s BTF, cannot register %s\n", module->name, msg);
+		return -ENOENT;
+	}
+	return 0;
+}
+
 BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
 {
 	struct btf *btf = NULL;
@@ -8098,15 +8117,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	int ret, i;
 
 	btf = btf_get_module_btf(kset->owner);
-	if (!btf) {
-		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
-			pr_warn("missing module BTF, cannot register kfuncs\n");
-		return 0;
-	}
+	if (!btf)
+		return register_check_missing_btf(kset->owner, "kfuncs");
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
@@ -8214,17 +8226,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	int ret;
 
 	btf = btf_get_module_btf(owner);
-	if (!btf) {
-		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
-			return -ENOENT;
-		}
-		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
-			pr_err("missing module BTF, cannot register dtor kfuncs\n");
-			return -ENOENT;
-		}
-		return 0;
-	}
+	if (!btf)
+		return register_check_missing_btf(owner, "dtor kfuncs");
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
-- 
2.40.1


