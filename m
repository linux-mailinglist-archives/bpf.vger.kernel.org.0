Return-Path: <bpf+bounces-2888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2C736663
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F12D1C20BCD
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB54C126;
	Tue, 20 Jun 2023 08:37:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17FBE79
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D0CC433C0;
	Tue, 20 Jun 2023 08:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250233;
	bh=WnIiyyCdWJBV8qamKYIlo+hki/XDjwGmeQAnAigmTZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7hUTvodA9VoQdwkCHdYOlrydwWu2/iSrb+HgNM7+K4vo4NrBTrxs2hZA4SEb6MR3
	 PDQfXnLQIqcXDFWkjxJ/AjQaEYMD92vY23bZFClmhGeuhCbf4GeSlp2Fjz5TMpIgcb
	 lsP3Yqq1ErwxzfguWvS3yhpoODD+DJKhThqUKVwozZmh308HoJ46PsyrFdj74cNA4t
	 609r5xgLxiO/YtcsnUgK0uOO2JDuTFp+pU5xVBYfEnnpjC0Q0B5ZXib21FVtJLit+k
	 7IFSRMqoBVkTGZJtCRyGokkHoYCQoMxJku4CWNqJsfrIPNymNX14KSQ7dthKz5jf2R
	 i5RSmD7QfBedQ==
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
Subject: [PATCHv2 bpf-next 08/24] libbpf: Add elf_find_multi_func_offset function
Date: Tue, 20 Jun 2023 10:35:34 +0200
Message-ID: <20230620083550.690426-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding elf_find_multi_func_offset function that looks up
offsets for symbols specified in syms array argument.

Offsets are returned in allocated array with the 'cnt' size,
that needs to be released by the caller.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 112 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |   2 +
 2 files changed, 114 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 30d9e3b69114..1c310b718961 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11053,6 +11053,118 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 	return ret;
 }
 
+struct elf_symbol_offset {
+	const char *name;
+	unsigned long offset;
+	int bind;
+	int idx;
+};
+
+static int cmp_func_offset(const void *_a, const void *_b)
+{
+	const struct elf_symbol_offset *a = _a;
+	const struct elf_symbol_offset *b = _b;
+
+	return strcmp(a->name, b->name);
+}
+
+static int
+__elf_find_multi_func_offset(Elf *elf, const char *binary_path, int cnt,
+			     const char **syms, unsigned long **poffsets)
+{
+	int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	struct elf_symbol_offset *func_offs;
+	int err = 0, i, idx, cnt_done = 0;
+	unsigned long *offsets = NULL;
+
+	func_offs = calloc(cnt, sizeof(*func_offs));
+	if (!func_offs)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt; i++) {
+		func_offs[i].name = syms[i];
+		func_offs[i].idx = i;
+	}
+
+	qsort(func_offs, cnt, sizeof(*func_offs), cmp_func_offset);
+
+	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
+		struct elf_symbol_iter iter;
+		struct elf_symbol *sym;
+
+		if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types[i]))
+			continue;
+
+		while ((sym = elf_symbol_iter_next(&iter))) {
+			struct elf_symbol_offset *fo, tmp = {
+				.name = sym->name,
+			};
+
+			fo = bsearch(&tmp, func_offs, cnt, sizeof(*func_offs),
+				     cmp_func_offset);
+			if (!fo)
+				continue;
+
+			if (fo->offset > 0) {
+				/* same offset, no problem */
+				if (fo->offset == sym->offset)
+					continue;
+				/* handle multiple matches */
+				if (fo->bind != STB_WEAK && sym->bind != STB_WEAK) {
+					/* Only accept one non-weak bind. */
+					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
+						sym->name, fo->name, binary_path);
+					err = -LIBBPF_ERRNO__FORMAT;
+					goto out;
+				} else if (sym->bind == STB_WEAK) {
+					/* already have a non-weak bind, and
+					 * this is a weak bind, so ignore.
+					 */
+					continue;
+				}
+			}
+			if (!fo->offset)
+				cnt_done++;
+			fo->offset = sym->offset;
+			fo->bind = sym->bind;
+		}
+	}
+
+	if (cnt != cnt_done) {
+		err = -ENOENT;
+		goto out;
+	}
+	offsets = calloc(cnt, sizeof(*offsets));
+	if (!offsets) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < cnt; i++) {
+		idx = func_offs[i].idx;
+		offsets[idx] = func_offs[i].offset;
+	}
+
+out:
+	*poffsets = offsets;
+	free(func_offs);
+	return err;
+}
+
+int elf_find_multi_func_offset(const char *binary_path, int cnt,
+			       const char **syms, unsigned long **poffsets)
+{
+	struct elf_fd elf_fd = {};
+	long ret = -ENOENT;
+
+	ret = open_elf(binary_path, &elf_fd);
+	if (ret)
+		return ret;
+
+	ret = __elf_find_multi_func_offset(elf_fd.elf, binary_path, cnt, syms, poffsets);
+	close_elf(&elf_fd);
+	return ret;
+}
+
 /* Find offset of function name in ELF object specified by path. "name" matches
  * symbol name or name@@LIB for library functions.
  */
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e4d05662a96c..13d5c12fbd0b 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -577,4 +577,6 @@ static inline bool is_pow_of_2(size_t x)
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
+int elf_find_multi_func_offset(const char *binary_path, int cnt,
+			       const char **syms, unsigned long **poffsets);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.41.0


