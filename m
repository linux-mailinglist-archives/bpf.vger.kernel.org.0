Return-Path: <bpf+bounces-7303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8E7755B1
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A61281B8B
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429717740;
	Wed,  9 Aug 2023 08:36:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F41428C
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEBCC433C8;
	Wed,  9 Aug 2023 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570197;
	bh=JRRJz8/nLZw6vAx2LW1/td9rYqJfps4sUneIFNzu93M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qi09vN0fMnvRRnxT9TTVWkOt5mHFYC79ffcF6GzpsAzHQVkyA2NC/OJaJrCAVAAqK
	 e56apXfphm1j2/W09pvmfkv+nSMs7PVm91lRWbCxAZeRbQ9TVRVz/KgRS05dOVCP4K
	 878gbWsVCfF8Nb27j7p8SLGKYIWZG/H9RWzaQ3ZjVFHsRN56KuOJ0+LiUUTkiNLul2
	 cdRCdK3ppuVAlx5hJQBfWWw25XH7sP5aYtC3cz0VYV03eDGnHUlXizvqbIpN3Qrr6V
	 nPwH57t5IHGUuigeG1XeP6ydHSrCdvXxJ53+Psg0n3FJn6g/jnCU2C0TKVKSHyRGa+
	 IJLZLrtNhYbog==
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
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv7 bpf-next 11/28] libbpf: Add elf_resolve_syms_offsets function
Date: Wed,  9 Aug 2023 10:34:23 +0200
Message-ID: <20230809083440.3209381-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
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
 tools/lib/bpf/elf.c             | 110 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |   2 +
 2 files changed, 112 insertions(+)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 8a3f8a725981..8c512641c1d7 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -267,3 +267,113 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name)
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
+static int symbol_cmp(const void *a, const void *b)
+{
+	const struct symbol *sym_a = a;
+	const struct symbol *sym_b = b;
+
+	return strcmp(sym_a->name, sym_b->name);
+}
+
+/*
+ * Return offsets in @poffsets for symbols specified in @syms array argument.
+ * On success returns 0 and offsets are returned in allocated array with @cnt
+ * size, that needs to be released by the caller.
+ */
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
+		if (err == -ENOENT)
+			continue;
+		if (err)
+			goto out;
+
+		while ((sym = elf_sym_iter_next(&iter))) {
+			unsigned long sym_offset = elf_sym_offset(sym);
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
+				if (*offset == sym_offset)
+					continue;
+				/* handle multiple matches */
+				if (found->bind != STB_WEAK && bind != STB_WEAK) {
+					/* Only accept one non-weak bind. */
+					pr_warn("elf: ambiguous match found '%s@%lu' in '%s' previous offset %lu\n",
+						sym->name, sym_offset, binary_path, *offset);
+					err = -ESRCH;
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
+			*offset = sym_offset;
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
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 0bbcd8e6fdc5..92851c5f912d 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -589,4 +589,6 @@ struct elf_fd {
 int elf_open(const char *binary_path, struct elf_fd *elf_fd);
 void elf_close(struct elf_fd *elf_fd);
 
+int elf_resolve_syms_offsets(const char *binary_path, int cnt,
+			     const char **syms, unsigned long **poffsets);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.41.0


