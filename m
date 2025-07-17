Return-Path: <bpf+bounces-63616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76763B09085
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14F44A4CF2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91722F85E0;
	Thu, 17 Jul 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx2NCaNC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E051E5705;
	Thu, 17 Jul 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765926; cv=none; b=C1GdLRmPuU/wov4nYE3La4F8mF2M1armC84O0c263xgmC/b2DNZWw2XjiImveEhXFhYGDDU+o/ezYF2RZ/PMt0BS63g5LrwLzqxx6Jy6fq/TY2rh1ySmuhVmCoBKJFCbw8M/Jw5bva0vyDxvllfSq7h7iIrFgfelBV3gp1REPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765926; c=relaxed/simple;
	bh=yYdDmFcjV9Cd9YTHCzbn1C3SR/qjGpEfYNYJkne0gRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/DC4fzaSnZTCE+6x2oh2Oj5zR+LTYfu5Vn+raOasu3mLhdcDE3N7qNadlTTZuockWHU+DmAfVL9WbzuHwAueHzb5z/DTcOeYzc+FAtfg5igD3bZtshrfuvpCkULOFDRyqWBZ5EOX6tegpRWaGNvHZY0K90JPOmhiqUi9/Y0Nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx2NCaNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D11C4CEE3;
	Thu, 17 Jul 2025 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752765925;
	bh=yYdDmFcjV9Cd9YTHCzbn1C3SR/qjGpEfYNYJkne0gRw=;
	h=From:To:Cc:Subject:Date:From;
	b=tx2NCaNCFT2dCoSBjtCL3d8XUICTpdU/zAaT4P0nHtNlt55aIvs4pLdkZai7RBKvM
	 pPgRTNtLePyEOLM5/YzcQY72CZlrJHyscD848jbQj+vQMlZ2US06akRslhlmjd+gsr
	 mP/MMm87R696AasaZEBqxuL7NHTdNOtPxV6ZtMwMwr2VDn+uNFSR5PeW8KAwHm5dU+
	 Udj+mfrkhMkvEuE5I82tRCK32H0PZdxY+mEY5gDXJyMeBHe+mzWPfhBKwq+uLL8Rsv
	 ZJJ6qZzxcWqtf1P7NEQvl5muL+/DHXiZUta8wzq2kSA62CIlcPEA/BE9ybgvqIzh5z
	 wvImLVsSISrBQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [RFC dwarves] btf_encoder: Remove duplicates from functions entries
Date: Thu, 17 Jul 2025 17:25:12 +0200
Message-ID: <20250717152512.488022-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Menglong reported issue where we can have function in BTF which has
multiple addresses in kallsysm [1].

Rather than filtering this in runtime, let's teach pahole to remove
such functions.

Removing duplicate records from functions entries that have more
at least one different address. This way btf_encoder__find_function
won't find such functions and they won't be added in BTF.

In my setup it removed 428 functions out of 77141.

[1] https://lore.kernel.org/bpf/20250710070835.260831-1-dongml2@chinatelecom.cn/
Reported-by: Menglong Dong <menglong8.dong@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---

Alan, 
I'd like to test this in the pahole CI, is there a way to manualy trigger it?

thanks,
jirka


---
 btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 16739066caae..a25fe2f8bfb1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -99,6 +99,7 @@ struct elf_function {
 	size_t		prefixlen;
 	bool		kfunc;
 	uint32_t	kfunc_flags;
+	unsigned long	addr;
 };
 
 struct elf_secinfo {
@@ -1469,6 +1470,7 @@ static void elf_functions__collect_function(struct elf_functions *functions, GEl
 
 	func = &functions->entries[functions->cnt];
 	func->name = name;
+	func->addr = sym->st_value;
 	if (strchr(name, '.')) {
 		const char *suffix = strchr(name, '.');
 
@@ -2143,6 +2145,40 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 	return err;
 }
 
+/*
+ * Remove name duplicates from functions->entries that have
+ * at least 2 different addresses.
+ */
+static void functions_remove_dups(struct elf_functions *functions)
+{
+	struct elf_function *n = &functions->entries[0];
+	bool matched = false, diff = false;
+	int i, j;
+
+	for (i = 0, j = 1; i < functions->cnt && j < functions->cnt; i++, j++) {
+		struct elf_function *a = &functions->entries[i];
+		struct elf_function *b = &functions->entries[j];
+
+		if (!strcmp(a->name, b->name)) {
+			matched = true;
+			diff |= a->addr != b->addr;
+			continue;
+		}
+
+		/*
+		 * Keep only not-matched entries and last one of the matched/duplicates
+		 * ones if all of the matched entries had the same address.
+		 **/
+		if (!matched || !diff)
+			*n++ = *a;
+		matched = diff = false;
+	}
+
+	if (!matched || !diff)
+		*n++ = functions->entries[functions->cnt - 1];
+	functions->cnt = n - &functions->entries[0];
+}
+
 static int elf_functions__collect(struct elf_functions *functions)
 {
 	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
@@ -2168,6 +2204,7 @@ static int elf_functions__collect(struct elf_functions *functions)
 
 	if (functions->cnt) {
 		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
+		functions_remove_dups(functions);
 	} else {
 		err = 0;
 		goto out_free;
-- 
2.50.1


