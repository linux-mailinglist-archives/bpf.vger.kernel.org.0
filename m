Return-Path: <bpf+bounces-21410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64FC84CC59
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDFB1C2269A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005137C6EE;
	Wed,  7 Feb 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7cYiql/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928C7A723;
	Wed,  7 Feb 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314901; cv=none; b=fuuz2dHJwdpjVGSjDWy+NGdYS0vFbAtPrtz6KjCVF1XbpDWVOrs8Ii70nIjKUO/+tc/pnLf+8p5RDy1zlzQYI1WSHCGekJCCi1gaQD2OJHYNR77oYlybDRZ1SPR6agq6M4Zz7x0X/u4vHAPpN7aFts9ZQeCJNwMCxE4MqmEaan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314901; c=relaxed/simple;
	bh=JmKdnwDvh8if28fTJVSrKG/pAJ4TElCzJ+iBTT3w+14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7ybi5R0Elt5cVhz6fSpU6qYq6laTZCp62nzq+4eE18LJdSwEKqbpztLAgzeyuHGO51zMc0tAILUgehLG0rCDyWi6DF+g48AIb1ow6DIWrdkLkHhUCPPDD5yAKDHWLAbgne2ojpr2DAjPAznArfROSpqc7E/2inq6mxecAP0+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7cYiql/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC9CC43390;
	Wed,  7 Feb 2024 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314901;
	bh=JmKdnwDvh8if28fTJVSrKG/pAJ4TElCzJ+iBTT3w+14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7cYiql/2I+DNe74Y+AyD/JUbB4B8QRx4uyPaTZ5mugnU+6X+8/1AR6az3k317psr
	 KCU3IhAp4hRrVxL3f64MUvMsgPby17+SjdqwmcZ0eRPajIjrW0S7TGbLCRw0dAmRy4
	 D1Ce9XE11lX09HdFyp7dyKZ3JbXHMxah/3Zc9/f6M8zNbjGSHUrPhwp44mtWf1ErDu
	 YjQGloZs3WdYO02neB25VW36tukE5ZKYDT4oO5tNJQvwU+xb9ewK+ZK/Bpnl2Qs8jT
	 G+Ja1ZqtGR0HHt7PUn+qpypXEutXhXkj1i/TSchK2+aiT5V5MFyLaPhamNIw1cBH2T
	 zhmKdhM9Gpq6A==
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
Subject: [PATCH bpf-next v4 2/3] bpf, btf: Add check_btf_kconfigs helper
Date: Wed,  7 Feb 2024 22:07:55 +0800
Message-Id: <ceae2dee1fb8b8ed99422f2f316bac189fc96cba.1707314646.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707314646.git.tanggeliang@kylinos.cn>
References: <cover.1707314646.git.tanggeliang@kylinos.cn>
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
register_btf_id_dtor_kfuncs() into a new helper named check_btf_kconfigs()
to check CONFIG_DEBUG_INFO_BTF, CONFIG_DEBUG_INFO_BTF_MODULES and
CONFIG_MODULE_ALLOW_BTF_MISMATCH in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 203391e61d93..eedbee04de89 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7738,6 +7738,20 @@ static struct btf *btf_get_module_btf(const struct module *module)
 	return btf;
 }
 
+static int check_btf_kconfigs(const struct module *module)
+{
+	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+		pr_err("missing vmlinux BTF, cannot register kfuncs\n");
+		return -ENOENT;
+	}
+	if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
+	    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
+		pr_err("missing module BTF, cannot register kfuncs\n");
+		return -ENOENT;
+	}
+	return 0;
+}
+
 BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
 {
 	struct btf *btf = NULL;
@@ -8098,18 +8112,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	int ret, i;
 
 	btf = btf_get_module_btf(kset->owner);
-	if (!btf) {
-		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
-		    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
-			pr_warn("missing module BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
-		return 0;
-	}
+	if (!btf)
+		return check_btf_kconfigs(kset->owner);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
@@ -8217,18 +8221,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	int ret;
 
 	btf = btf_get_module_btf(owner);
-	if (!btf) {
-		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
-			return -ENOENT;
-		}
-		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) &&
-		    !IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
-			pr_err("missing module BTF, cannot register dtor kfuncs\n");
-			return -ENOENT;
-		}
-		return 0;
-	}
+	if (!btf)
+		return check_btf_kconfigs(owner);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
-- 
2.40.1


