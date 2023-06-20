Return-Path: <bpf+bounces-2886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9F736661
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86935280E3F
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF54AD48;
	Tue, 20 Jun 2023 08:36:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC6A92D
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88662C433C0;
	Tue, 20 Jun 2023 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250214;
	bh=06oeXnl0kz7cJxQhrJIMD+OV+KR3HkftQMs7oAY3JQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpY2RhsXiviTjXoV6dFpk3/hVJF0SCXEcowYAkS6IJgjxLiagI6zyOwmmmxs/pV9P
	 EShy9+Z9TkUpkEcRN7EBP0fjGWfmQbHOQYmAr0A3VmMGeHYNaB1tCz/vdYjMVdBy5U
	 tH6bLsWMumfMTJg5he3MrS6Ry8DqMv5/jV3jKqElbQ7D7+RtI3gxKPxelqlCBvuRtO
	 iSDpyREIv3lIHc1BHXxFqOgQw1Mvv+tvsnXAgDJPJ5/abCZES5giRNLIeYFA/zZgYE
	 qMufnzZk/3D0q9emZMbWMs4oTlUd5Z8XfiF9OZQkq7o01ZjtbtUJxIZO7nRoWvrwSW
	 IxyXlpVHSlq/g==
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
Subject: [PATCHv2 bpf-next 06/24] libbpf: Add elf symbol iterator
Date: Tue, 20 Jun 2023 10:35:32 +0200
Message-ID: <20230620083550.690426-7-jolsa@kernel.org>
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

Adding elf symbol iterator object (and some functions) that follow
open-coded iterator pattern and some functions to ease up iterating
elf object symbols.

The idea is to iterate single symbol section with:

  struct elf_symbol_iter iter;
  struct elf_symbol *sym;

  if (elf_symbol_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
        goto error;

  while ((sym = elf_symbol_iter_next(&iter))) {
        ...
  }

I considered opening the elf inside the iterator and iterate all symbol
sections, but then it gets more complicated wrt user checks for when
the next section is processed.

Plus side is the we don't need 'exit' function, because caller/user is
in charge of that.

The returned iterated symbol object from elf_symbol_iter_next function
is placed inside the struct elf_symbol_iter, so no extra allocation or
argument is needed.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 179 ++++++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 65 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af52188daa80..cdac368c7ce1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10824,6 +10824,109 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 	return NULL;
 }
 
+struct elf_symbol {
+	const char *name;
+	unsigned long offset;
+	int bind;
+};
+
+struct elf_symbol_iter {
+	Elf *elf;
+	Elf_Data *symbols;
+	size_t nr_syms;
+	size_t strtabidx;
+	size_t idx;
+	struct elf_symbol sym;
+};
+
+static int elf_symbol_iter_new(struct elf_symbol_iter *iter,
+			       Elf *elf, const char *binary_path,
+			       int sh_type)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Ehdr ehdr;
+	GElf_Shdr sh;
+
+	memset(iter, 0, sizeof(*iter));
+
+	if (!gelf_getehdr(elf, &ehdr)) {
+		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	scn = elf_find_next_scn_by_type(elf, sh_type, NULL);
+	if (!scn) {
+		pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
+			 binary_path);
+		return -EINVAL;
+	}
+
+	if (!gelf_getshdr(scn, &sh))
+		return -EINVAL;
+
+	iter->strtabidx = sh.sh_link;
+	iter->symbols = elf_getdata(scn, 0);
+	if (!iter->symbols) {
+		pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
+			binary_path, elf_errmsg(-1));
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+	iter->nr_syms = iter->symbols->d_size / sh.sh_entsize;
+	iter->elf = elf;
+	return 0;
+}
+
+static struct elf_symbol *elf_symbol_iter_next(struct elf_symbol_iter *iter)
+{
+	struct elf_symbol *ret = &iter->sym;
+	unsigned long offset = 0;
+	const char *name = NULL;
+	GElf_Shdr sym_sh;
+	Elf_Scn *sym_scn;
+	GElf_Sym sym;
+	size_t idx;
+
+	for (idx = iter->idx; idx < iter->nr_syms; idx++) {
+		if (!gelf_getsym(iter->symbols, idx, &sym))
+			continue;
+		if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
+			continue;
+		name = elf_strptr(iter->elf, iter->strtabidx, sym.st_name);
+		if (!name)
+			continue;
+
+		/* Transform symbol's virtual address (absolute for
+		 * binaries and relative for shared libs) into file
+		 * offset, which is what kernel is expecting for
+		 * uprobe/uretprobe attachment.
+		 * See Documentation/trace/uprobetracer.rst for more
+		 * details.
+		 * This is done by looking up symbol's containing
+		 * section's header and using iter's virtual address
+		 * (sh_addr) and corresponding file offset (sh_offset)
+		 * to transform sym.st_value (virtual address) into
+		 * desired final file offset.
+		 */
+		sym_scn = elf_getscn(iter->elf, sym.st_shndx);
+		if (!sym_scn)
+			continue;
+		if (!gelf_getshdr(sym_scn, &sym_sh))
+			continue;
+
+		offset = sym.st_value - sym_sh.sh_addr + sym_sh.sh_offset;
+		break;
+	}
+
+	/* we reached the last symbol */
+	if (idx == iter->nr_syms)
+		return NULL;
+	iter->idx = idx + 1;
+	ret->name = name;
+	ret->bind = GELF_ST_BIND(sym.st_info);
+	ret->offset = offset;
+	return ret;
+}
+
 /* Find offset of function name in the provided ELF object. "binary_path" is
  * the path to the ELF binary represented by "elf", and only used for error
  * reporting matters. "name" matches symbol name or name@@LIB for library
@@ -10855,94 +10958,40 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 	 * reported as a warning/error.
 	 */
 	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
-		size_t nr_syms, strtabidx, idx;
-		Elf_Data *symbols = NULL;
-		Elf_Scn *scn = NULL;
+		struct elf_symbol_iter iter;
+		struct elf_symbol *sym;
 		int last_bind = -1;
-		const char *sname;
-		GElf_Shdr sh;
 
-		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
-		if (!scn) {
-			pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
-				 binary_path);
+		if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types[i]))
 			continue;
-		}
-		if (!gelf_getshdr(scn, &sh))
-			continue;
-		strtabidx = sh.sh_link;
-		symbols = elf_getdata(scn, 0);
-		if (!symbols) {
-			pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
-				binary_path, elf_errmsg(-1));
-			ret = -LIBBPF_ERRNO__FORMAT;
-			goto out;
-		}
-		nr_syms = symbols->d_size / sh.sh_entsize;
-
-		for (idx = 0; idx < nr_syms; idx++) {
-			int curr_bind;
-			GElf_Sym sym;
-			Elf_Scn *sym_scn;
-			GElf_Shdr sym_sh;
-
-			if (!gelf_getsym(symbols, idx, &sym))
-				continue;
-
-			if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
-				continue;
-
-			sname = elf_strptr(elf, strtabidx, sym.st_name);
-			if (!sname)
-				continue;
-
-			curr_bind = GELF_ST_BIND(sym.st_info);
 
+		while ((sym = elf_symbol_iter_next(&iter))) {
 			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sname, name, name_len) != 0)
+			if (strncmp(sym->name, name, name_len) != 0)
 				continue;
 			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
 			 * additional characters in sname should be of the form "@@LIB".
 			 */
-			if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
+			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
 				continue;
 
 			if (ret >= 0) {
 				/* handle multiple matches */
-				if (last_bind != STB_WEAK && curr_bind != STB_WEAK) {
+				if (last_bind != STB_WEAK && sym->bind != STB_WEAK) {
 					/* Only accept one non-weak bind. */
 					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
-						sname, name, binary_path);
+						sym->name, name, binary_path);
 					ret = -LIBBPF_ERRNO__FORMAT;
 					goto out;
-				} else if (curr_bind == STB_WEAK) {
+				} else if (sym->bind == STB_WEAK) {
 					/* already have a non-weak bind, and
 					 * this is a weak bind, so ignore.
 					 */
 					continue;
 				}
 			}
-
-			/* Transform symbol's virtual address (absolute for
-			 * binaries and relative for shared libs) into file
-			 * offset, which is what kernel is expecting for
-			 * uprobe/uretprobe attachment.
-			 * See Documentation/trace/uprobetracer.rst for more
-			 * details.
-			 * This is done by looking up symbol's containing
-			 * section's header and using it's virtual address
-			 * (sh_addr) and corresponding file offset (sh_offset)
-			 * to transform sym.st_value (virtual address) into
-			 * desired final file offset.
-			 */
-			sym_scn = elf_getscn(elf, sym.st_shndx);
-			if (!sym_scn)
-				continue;
-			if (!gelf_getshdr(sym_scn, &sym_sh))
-				continue;
-
-			ret = sym.st_value - sym_sh.sh_addr + sym_sh.sh_offset;
-			last_bind = curr_bind;
+			last_bind = sym->bind;
+			ret = sym->offset;
 		}
 		if (ret > 0)
 			break;
-- 
2.41.0


