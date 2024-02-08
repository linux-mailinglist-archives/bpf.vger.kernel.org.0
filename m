Return-Path: <bpf+bounces-21476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A184DA07
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240AE1F22EEF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5267E62;
	Thu,  8 Feb 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny7IfhII"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2863410;
	Thu,  8 Feb 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373489; cv=none; b=O+GmHaqJqqpDNqIvZY2pwwpmVZIkrzs5sGiD6XEGPAwcAnW3GgcHCRSa7jgvkAuPspyKSM9xYzDaM1uehTB4JH4+C5/kSipPnJOTcddKr8Jd5GopRd6sNxXpTlg3jrwn2Qw39ErfMG+8whJcN7vJrBVHKGJ3pGNSJ+nNgh+z+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373489; c=relaxed/simple;
	bh=uJ7n0v1Hu3yIwlxagQmhtcAIEoBMxKcWkHCp7Khv0OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmSzOE/tFQgwBUJ6Ii58WInGN3agrFWRV4B19UJ5EkFztvR8zNJk3EdY7EkzGRRr4iE33PNAMdsrpUQGWFX0qzMWZ2KhFFqNjNTU3/1BpoecOd5XBZTPETmBDIFazqJ9LtNrWkDXP7rhULMoGTW8Z8ch8TVZKl+V3+ixWCdPQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny7IfhII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65269C43390;
	Thu,  8 Feb 2024 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373488;
	bh=uJ7n0v1Hu3yIwlxagQmhtcAIEoBMxKcWkHCp7Khv0OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny7IfhIIZ+0CchtfwLbSzQmhLoR/XtW8kGJYjPXGv40NCDHneDYzkuXID6vIi75PG
	 dEJ71dyQYyTfpAenaJUjf9KXA0jw7WRTp2IzLlnbSP7GAVUqJlBKWCbr0q+l1KmM0s
	 rNkSTTpMIBZYc1TQtxxxGQRq9PmlLANJgDVzSDvU0Xk0WAQ/zfMPM76bDrlpd7p6Uv
	 qRfRBKJzZ8AJpz1YQoYKXAuXnv3YFggPBvfzan96nGOjoOZQfRj/XtM44w9hV5EOvb
	 7dSR0k6j/z2yc+RLgFLUQ65pPDa2emCbnotp/ukA9EQVkueNExsUVs71ZYDUZVHen8
	 11tU6fobRrpYA==
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
Subject: [PATCH bpf-next v5 2/3] bpf, btf: Add check_btf_kconfigs helper
Date: Thu,  8 Feb 2024 14:24:22 +0800
Message-Id: <fa5537fc55f1e4d0bfd686598c81b7ab9dbd82b7.1707373307.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707373307.git.tanggeliang@kylinos.cn>
References: <cover.1707373307.git.tanggeliang@kylinos.cn>
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
to check CONFIG_DEBUG_INFO_BTF and CONFIG_DEBUG_INFO_BTF_MODULES in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/btf.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16eb937eca46..e318df7f0071 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7738,6 +7738,17 @@ static struct btf *btf_get_module_btf(const struct module *module)
 	return btf;
 }
 
+static int check_btf_kconfigs(const struct module *module)
+{
+	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+		pr_err("missing vmlinux BTF, cannot register kfuncs\n");
+		return -ENOENT;
+	}
+	if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+		pr_warn("missing module BTF, cannot register kfuncs\n");
+	return 0;
+}
+
 BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
 {
 	struct btf *btf = NULL;
@@ -8098,15 +8109,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
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
+		return check_btf_kconfigs(kset->owner);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
@@ -8214,15 +8218,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	int ret;
 
 	btf = btf_get_module_btf(owner);
-	if (!btf) {
-		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
-			return -ENOENT;
-		}
-		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
-			pr_warn("missing module BTF, cannot register dtor kfuncs\n");
-		return 0;
-	}
+	if (!btf)
+		return check_btf_kconfigs(owner);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
-- 
2.40.1


