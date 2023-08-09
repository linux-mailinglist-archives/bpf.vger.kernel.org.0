Return-Path: <bpf+bounces-7302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B67755B0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC57F1C2048F
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C79182BC;
	Wed,  9 Aug 2023 08:36:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A6613E
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B80BC433C8;
	Wed,  9 Aug 2023 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570187;
	bh=nWABmTYAaW1iin4pc2IXwBpaMyBNOk+m8/amficAyYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCsaxgz6WEYRpZIEn9wlr997iIHN30S7x9SHO8a983Hvvdf5OZEvYSpv30sDcpNpi
	 g0WMRN0F4mUey28tk5p5msE5Tby3LqE3YCx7jnbrNpBguFqUqgFwK8PQpr8kHPy9rx
	 iGapgHne8utVqpY73zxoZHnp/N7H9uDvNnAWVhxPLNxjLB7pZYAqoIwJyIa49If2or
	 +ryhj0XKqH7+k01viOPb7hTTyqqUcG4xPwWmnVMCpoDTPYaLywxVssYccBSMqJROzm
	 a3wHSiLOCAEitxgnsKoUY6PAIs2B3Rr24PagebKEFntDmShbN8o2hh+yilcgDXd8bU
	 p1lYQmFtLPUnA==
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
Subject: [PATCHv7 bpf-next 10/28] libbpf: Add elf symbol iterator
Date: Wed,  9 Aug 2023 10:34:22 +0200
Message-ID: <20230809083440.3209381-11-jolsa@kernel.org>
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

Adding elf symbol iterator object (and some functions) that follow
open-coded iterator pattern and some functions to ease up iterating
elf object symbols.

The idea is to iterate single symbol section with:

  struct elf_sym_iter iter;
  struct elf_sym *sym;

  if (elf_sym_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
        goto error;

  while ((sym = elf_sym_iter_next(&iter))) {
        ...
  }

I considered opening the elf inside the iterator and iterate all symbol
sections, but then it gets more complicated wrt user checks for when
the next section is processed.

Plus side is the we don't need 'exit' function, because caller/user is
in charge of that.

The returned iterated symbol object from elf_sym_iter_next function
is placed inside the struct elf_sym_iter, so no extra allocation or
argument is needed.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/elf.c | 179 ++++++++++++++++++++++++++++----------------
 1 file changed, 115 insertions(+), 64 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 71363acdeb67..8a3f8a725981 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -60,6 +60,104 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 	return NULL;
 }
 
+struct elf_sym {
+	const char *name;
+	GElf_Sym sym;
+	GElf_Shdr sh;
+};
+
+struct elf_sym_iter {
+	Elf *elf;
+	Elf_Data *syms;
+	size_t nr_syms;
+	size_t strtabidx;
+	size_t next_sym_idx;
+	struct elf_sym sym;
+	int st_type;
+};
+
+static int elf_sym_iter_new(struct elf_sym_iter *iter,
+			    Elf *elf, const char *binary_path,
+			    int sh_type, int st_type)
+{
+	Elf_Scn *scn = NULL;
+	GElf_Ehdr ehdr;
+	GElf_Shdr sh;
+
+	memset(iter, 0, sizeof(*iter));
+
+	if (!gelf_getehdr(elf, &ehdr)) {
+		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
+		return -EINVAL;
+	}
+
+	scn = elf_find_next_scn_by_type(elf, sh_type, NULL);
+	if (!scn) {
+		pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
+			 binary_path);
+		return -ENOENT;
+	}
+
+	if (!gelf_getshdr(scn, &sh))
+		return -EINVAL;
+
+	iter->strtabidx = sh.sh_link;
+	iter->syms = elf_getdata(scn, 0);
+	if (!iter->syms) {
+		pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
+			binary_path, elf_errmsg(-1));
+		return -EINVAL;
+	}
+	iter->nr_syms = iter->syms->d_size / sh.sh_entsize;
+	iter->elf = elf;
+	iter->st_type = st_type;
+	return 0;
+}
+
+static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
+{
+	struct elf_sym *ret = &iter->sym;
+	GElf_Sym *sym = &ret->sym;
+	const char *name = NULL;
+	Elf_Scn *sym_scn;
+	size_t idx;
+
+	for (idx = iter->next_sym_idx; idx < iter->nr_syms; idx++) {
+		if (!gelf_getsym(iter->syms, idx, sym))
+			continue;
+		if (GELF_ST_TYPE(sym->st_info) != iter->st_type)
+			continue;
+		name = elf_strptr(iter->elf, iter->strtabidx, sym->st_name);
+		if (!name)
+			continue;
+		sym_scn = elf_getscn(iter->elf, sym->st_shndx);
+		if (!sym_scn)
+			continue;
+		if (!gelf_getshdr(sym_scn, &ret->sh))
+			continue;
+
+		iter->next_sym_idx = idx + 1;
+		ret->name = name;
+		return ret;
+	}
+
+	return NULL;
+}
+
+
+/* Transform symbol's virtual address (absolute for binaries and relative
+ * for shared libs) into file offset, which is what kernel is expecting
+ * for uprobe/uretprobe attachment.
+ * See Documentation/trace/uprobetracer.rst for more details. This is done
+ * by looking up symbol's containing section's header and using iter's virtual
+ * address (sh_addr) and corresponding file offset (sh_offset) to transform
+ * sym.st_value (virtual address) into desired final file offset.
+ */
+static unsigned long elf_sym_offset(struct elf_sym *sym)
+{
+	return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
+}
+
 /* Find offset of function name in the provided ELF object. "binary_path" is
  * the path to the ELF binary represented by "elf", and only used for error
  * reporting matters. "name" matches symbol name or name@@LIB for library
@@ -91,67 +189,38 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	 * reported as a warning/error.
 	 */
 	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
-		size_t nr_syms, strtabidx, idx;
-		Elf_Data *symbols = NULL;
-		Elf_Scn *scn = NULL;
+		struct elf_sym_iter iter;
+		struct elf_sym *sym;
 		int last_bind = -1;
-		const char *sname;
-		GElf_Shdr sh;
+		int cur_bind;
 
-		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
-		if (!scn) {
-			pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
-				 binary_path);
+		ret = elf_sym_iter_new(&iter, elf, binary_path, sh_types[i], STT_FUNC);
+		if (ret == -ENOENT)
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
+		if (ret)
 			goto out;
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
 
+		while ((sym = elf_sym_iter_next(&iter))) {
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
 
-			if (ret >= 0) {
+			cur_bind = GELF_ST_BIND(sym->sym.st_info);
+
+			if (ret > 0) {
 				/* handle multiple matches */
-				if (last_bind != STB_WEAK && curr_bind != STB_WEAK) {
+				if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
 					/* Only accept one non-weak bind. */
 					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
-						sname, name, binary_path);
+						sym->name, name, binary_path);
 					ret = -LIBBPF_ERRNO__FORMAT;
 					goto out;
-				} else if (curr_bind == STB_WEAK) {
+				} else if (cur_bind == STB_WEAK) {
 					/* already have a non-weak bind, and
 					 * this is a weak bind, so ignore.
 					 */
@@ -159,26 +228,8 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 				}
 			}
 
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
+			ret = elf_sym_offset(sym);
+			last_bind = cur_bind;
 		}
 		if (ret > 0)
 			break;
-- 
2.41.0


