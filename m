Return-Path: <bpf+bounces-3776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB1743762
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134ED281080
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC64A957;
	Fri, 30 Jun 2023 08:35:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25327A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EC1C433C8;
	Fri, 30 Jun 2023 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114138;
	bh=zrm949cB1mOryVNymXblH8xLJVu+X/RGQp9RYXMNCDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B14BSl5joaH2aXwwo6Bmggwga/QOq9WnTakCnZ+EL7XJyvlU/jlTsOWwzvgYu254+
	 q7ivHLAlfbadVilh6QXBNBNm9QLy42saJY7fcS8TM3sx8OwJHixtpQcptrzagMOuDS
	 SIXpyKVCFoNOuwxTY32E5LyBWHzu0YdK7Kd2/mXruSqFR1ql6tOc0kjvoBDnMCGl3y
	 nXMORCa2d8EUrapyj/eJWPPJG7PhROc3oU+N7jSDU+LMuxG6emOEzNEiP+bJlGxW80
	 VNGzl1Va7QV0FQQ3ddu/Pr6t6Y+jAk6+X0+RL96T7sFU6c7AdSmuhMEhFXOVLimSRA
	 NB1LfILWglDFA==
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
Subject: [PATCHv3 bpf-next 09/26] libbpf: Add elf symbol iterator
Date: Fri, 30 Jun 2023 10:33:27 +0200
Message-ID: <20230630083344.984305-10-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/elf.c | 178 +++++++++++++++++++++++++++++---------------
 1 file changed, 117 insertions(+), 61 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 74e35071d22e..fcce4bd2478f 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -59,6 +59,108 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
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
+static unsigned long elf_sym_offset(struct elf_sym *sym)
+{
+	return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
+}
+
 /* Find offset of function name in the provided ELF object. "binary_path" is
  * the path to the ELF binary represented by "elf", and only used for error
  * reporting matters. "name" matches symbol name or name@@LIB for library
@@ -90,64 +192,36 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
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
+		int curr_bind;
 
-		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
-		if (!scn) {
-			pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
-				 binary_path);
-			continue;
-		}
-		if (!gelf_getshdr(scn, &sh))
-			continue;
-		strtabidx = sh.sh_link;
-		symbols = elf_getdata(scn, 0);
-		if (!symbols) {
-			pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
-				binary_path, elf_errmsg(-1));
-			ret = -LIBBPF_ERRNO__FORMAT;
+		ret = elf_sym_iter_new(&iter, elf, binary_path, sh_types[i], STT_FUNC);
+		if (ret) {
+			if (ret == -ENOENT)
+				continue;
 			goto out;
 		}
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
+			curr_bind = GELF_ST_BIND(sym->sym.st_info);
+
+			if (ret > 0) {
 				/* handle multiple matches */
 				if (last_bind != STB_WEAK && curr_bind != STB_WEAK) {
 					/* Only accept one non-weak bind. */
 					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
-						sname, name, binary_path);
+						sym->name, name, binary_path);
 					ret = -LIBBPF_ERRNO__FORMAT;
 					goto out;
 				} else if (curr_bind == STB_WEAK) {
@@ -158,25 +232,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
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
+			ret = elf_sym_offset(sym);
 			last_bind = curr_bind;
 		}
 		if (ret > 0)
-- 
2.41.0


