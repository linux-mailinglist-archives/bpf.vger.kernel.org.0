Return-Path: <bpf+bounces-3777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E390743764
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3E1C20C06
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E78A957;
	Fri, 30 Jun 2023 08:35:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931521FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC94C433C0;
	Fri, 30 Jun 2023 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114150;
	bh=VUxbHMnLpXo/Xi6CJQ/zWxHn+cqlEAHQGuUroIq5QOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2ZwRjZsPlW9//WxiiJSF94B5ZUH8WD+7c+0W+tSHUsu9ismGdgdQrcES7WfVJGeA
	 R6W1BZ8U2Q3Obh9+GWPzuftfb2YpIprKLe4PEiQlJxIEMM7NMCDoFAb0KVEcfNy8tE
	 LP+XeLp+PGki0Kwfa23dsmGTzlzSGhBuo5AIIv9HwrRQ7i2OC28Av0cLx5k8Yl3ozM
	 077ttwjGNH5PUo5yDMTujDO4pWnjwvqBr748vnY1ecPnKMDusVC7YJ5jD77JVflqlg
	 1ylwL38SigiQEywFhJNZloNEthaVlQRV17O1xNAnRnRLW7r5vKZ+ZjL2M8+wr+qm9W
	 wICuZEX3D1QTQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 10/26] libbpf: Add elf_resolve_syms_offsets function
Date: Fri, 30 Jun 2023 10:33:28 +0200
Message-ID: <20230630083344.984305-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding elf_resolve_syms_offsets function that looks up
offsets for symbols specified in syms array argument.

Offsets are returned in allocated array with the 'cnt' size,
that needs to be released by the caller.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/elf.c        | 105 +++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_elf.h |   2 +
 2 files changed, 107 insertions(+)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index fcce4bd2478f..7e2f3b2e1fb6 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -271,3 +271,108 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name)
 	elf_close(&elf_fd);
 	return ret;
 }
+
+struct symbol {
+	const char *name;
+	int bind;
+	int idx;
+};
+
+static int symbol_cmp(const void *_a, const void *_b)
+{
+	const struct symbol *a = _a;
+	const struct symbol *b = _b;
+
+	return strcmp(a->name, b->name);
+}
+
+int elf_resolve_syms_offsets(const char *binary_path, int cnt,
+			     const char **syms, unsigned long **poffsets)
+{
+	int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	int err = 0, i, cnt_done = 0;
+	unsigned long *offsets;
+	struct symbol *symbols;
+	struct elf_fd elf_fd;
+
+	err = elf_open(binary_path, &elf_fd);
+	if (err)
+		return err;
+
+	offsets = calloc(cnt, sizeof(*offsets));
+	symbols = calloc(cnt, sizeof(*symbols));
+
+	if (!offsets || !symbols) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		symbols[i].name = syms[i];
+		symbols[i].idx = i;
+	}
+
+	qsort(symbols, cnt, sizeof(*symbols), symbol_cmp);
+
+	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
+		struct elf_sym_iter iter;
+		struct elf_sym *sym;
+
+		err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], STT_FUNC);
+		if (err) {
+			if (err == -ENOENT)
+				continue;
+			goto out;
+		}
+
+		while ((sym = elf_sym_iter_next(&iter))) {
+			int bind = GELF_ST_BIND(sym->sym.st_info);
+			struct symbol *found, tmp = {
+				.name = sym->name,
+			};
+			unsigned long *offset;
+
+			found = bsearch(&tmp, symbols, cnt, sizeof(*symbols), symbol_cmp);
+			if (!found)
+				continue;
+
+			offset = &offsets[found->idx];
+			if (*offset > 0) {
+				/* same offset, no problem */
+				if (*offset == elf_sym_offset(sym))
+					continue;
+				/* handle multiple matches */
+				if (found->bind != STB_WEAK && bind != STB_WEAK) {
+					/* Only accept one non-weak bind. */
+					pr_warn("elf: ambiguous match foundr '%s', '%s' in '%s'\n",
+						sym->name, found->name, binary_path);
+					err = -LIBBPF_ERRNO__FORMAT;
+					goto out;
+				} else if (bind == STB_WEAK) {
+					/* already have a non-weak bind, and
+					 * this is a weak bind, so ignore.
+					 */
+					continue;
+				}
+			} else {
+				cnt_done++;
+			}
+			*offset = elf_sym_offset(sym);
+			found->bind = bind;
+		}
+	}
+
+	if (cnt != cnt_done) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	*poffsets = offsets;
+
+out:
+	free(symbols);
+	if (err)
+		free(offsets);
+	elf_close(&elf_fd);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
index c763ac35a85e..026c7b378727 100644
--- a/tools/lib/bpf/libbpf_elf.h
+++ b/tools/lib/bpf/libbpf_elf.h
@@ -16,4 +16,6 @@ void elf_close(struct elf_fd *elf_fd);
 long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name);
 long elf_find_func_offset_from_file(const char *binary_path, const char *name);
 
+int elf_resolve_syms_offsets(const char *binary_path, int cnt,
+			     const char **syms, unsigned long **poffsets);
 #endif /* *__LIBBPF_LIBBPF_ELF_H */
-- 
2.41.0


