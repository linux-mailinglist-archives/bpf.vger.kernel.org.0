Return-Path: <bpf+bounces-21132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C1848460
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 08:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF7C1F270A1
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4274EB46;
	Sat,  3 Feb 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjj65yit"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FD4E1D5;
	Sat,  3 Feb 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946744; cv=none; b=J8LMFm3feTEZKVloRECRsdWFt0clR0M68Cy9zRiGu/RssJyPFzrBeYrNDIRknEcq4pSSwZAbxSIgdFh4LMdiqIvKqqttWGCwzsEp12EstIRQYFEhD4lRQjCs2vKyYLCemXJEnF0CCw7kBRKoDGi+9CPlWH/9OfPCwU8Rzr5bxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946744; c=relaxed/simple;
	bh=ovbEnLmZSuIL7RZ1CQqKF2Cqdi1QnymtDtpeGGF8zBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcZId0vwkCmmoOwL7qGPP0V3oHZz5HmtcO8hKDU3AlHjYh3lbkJHgBJbGsSOUAvFdBCvvMRvDADnzS9GC83vdRJPFOoBc9h7tmMI46YJpJTR8YGGag076jE0m1wDaADHDr5Dqkx+AaJ+Iyu/GpNSVSI/56cdvq0fN3jaAiFgpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjj65yit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07222C433B1;
	Sat,  3 Feb 2024 07:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706946743;
	bh=ovbEnLmZSuIL7RZ1CQqKF2Cqdi1QnymtDtpeGGF8zBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vjj65yitptlNB0KFh+lI5o98aCnqL76F+Pxob++oVhRWWuPdw1FqEahQacyIjEkZ+
	 ZrT2El+USULCVzFkCY1dHSekvmqU5B6ZQwZarCJPiAdN7neX5V2GymUcQR+/szMvZ2
	 Go1tjcQfdCyIvmxLD66imkdGie0sDmJEddb4S2G18UFtiRQ0xKnBSE/URxSrnXD0XW
	 HyuspJ+vp2evVdjaeAkgNTuRtPSFqVv9RmN0CQzNUpKVQY+eg8sXdr5O4fC10gNp2U
	 6jkiTIS0r+5Z7aNrs/X0WOIoqiH4fYRITuYB29su6pgLkBarPCC6GZVmxDWKLLB/YM
	 hZZlk2RWJJk4A==
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
Subject: [PATCH bpf-next v2 1/2] bpf, btf: Add register_check_missing_btf helper
Date: Sat,  3 Feb 2024 15:51:04 +0800
Message-Id: <f4b147ddaa8fe8c07c7ba77a1d61780bffc49bb6.1706946547.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706946547.git.tanggeliang@kylinos.cn>
References: <cover.1706946547.git.tanggeliang@kylinos.cn>
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
 kernel/bpf/btf.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7725cb6e564..1ebe26a3a7a5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7738,6 +7738,24 @@ static struct btf *btf_get_module_btf(const struct module *module)
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
@@ -8098,15 +8116,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
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
 
@@ -8214,17 +8225,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
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


