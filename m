Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6A6ED1FF
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjDXQF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjDXQFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74AF6A63
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7227861B66
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C743C433D2;
        Mon, 24 Apr 2023 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352352;
        bh=CoLqMMo4N6vU/BeEX3vwOSYaCzuCwcndOB/EdHcIEXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbrqGcl/q243LMmDgUfyWIZwJvKqk9zRvobdBh6GHHQ9pUCFBMHhnr83mmhygk9Ek
         KmthMRR82Ibl50M030p7ZVJQ7DoHwUpNexrEC22N3R4hT/s+U+JMGFwVvzsRfVVI3G
         7nOVUyCwPxp0JxVLL5VMOKbNKYhsGCXYNyvVRd5ovD46SyG2GDdG1wIPC+NatN1XDl
         FtkeKxf6wCl6px3dmZedkw4LrRCO+0aJw8xBz710OJiKnk2uPs97XFeAGnoTctGEbb
         H1yMGg06e/I6pjEBudA1uTWfa2V1cXfrymyNvwVpqA5Gx1IFnDd2WQhfgYvk0d7zxE
         6oSNNwPpx3hDA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 06/20] libbpf: Factor elf_for_each_symbol function
Date:   Mon, 24 Apr 2023 18:04:33 +0200
Message-Id: <20230424160447.2005755-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we have elf_find_func_offset function that looks up
symbol in the binary and returns its offset to be used for uprobe
attachment.

For attaching multiple uprobes we will need interface that allows
us to get offsets for multiple symbols specified either by name or
regular expression.

Factoring out elf_for_each_symbol helper function that iterates
all symbols in binary and calls following callbacks:

  fn_match - on each symbol
             if it returns error < 0, we bail out with that error
  fn_done  - when we finish iterating symbol section,
             if it returns true, we don't iterate next section

It will be used in following changes to lookup multiple symbols
and their offsets.

Changing elf_find_func_offset to use elf_for_each_symbol with
single_match callback that's looking to match single function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 185 +++++++++++++++++++++++++----------------
 1 file changed, 114 insertions(+), 71 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b5bde1f19831..92c92ed2101f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10707,30 +10707,87 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 	return NULL;
 }
 
-/* Find offset of function name in the provided ELF object. "binary_path" is
- * the path to the ELF binary represented by "elf", and only used for error
- * reporting matters. "name" matches symbol name or name@@LIB for library
- * functions.
- */
-static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
-{
-	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
-	bool is_shared_lib, is_name_qualified;
-	long ret = -ENOENT;
+struct elf_func_offset {
+	const char *name;
+	unsigned long offset;
+	int last_bind;
 	size_t name_len;
-	GElf_Ehdr ehdr;
+	bool is_name_qualified;
+};
 
-	if (!gelf_getehdr(elf, &ehdr)) {
-		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
-		ret = -LIBBPF_ERRNO__FORMAT;
-		goto out;
+static int single_done(void *_data)
+{
+	struct elf_func_offset *data = _data;
+
+	return data->offset > 0;
+}
+
+static int single_match(Elf *elf, const char *binary_path, const char *sname,
+			GElf_Sym *sym, void *_data)
+{
+	struct elf_func_offset *data = _data;
+	size_t name_len = data->name_len;
+	const char *name = data->name;
+	Elf_Scn *sym_scn;
+	GElf_Shdr sym_sh;
+	int curr_bind;
+
+	curr_bind = GELF_ST_BIND(sym->st_info);
+
+	/* User can specify func, func@@LIB or func@@LIB_VERSION. */
+	if (strncmp(sname, name, name_len) != 0)
+		return 0;
+	/* ...but we don't want a search for "foo" to match 'foo2" also, so any
+	 * additional characters in sname should be of the form "@@LIB".
+	 */
+	if (!data->is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
+		return 0;
+
+	if (data->offset > 0) {
+		/* handle multiple matches */
+		if (data->last_bind != STB_WEAK && curr_bind != STB_WEAK) {
+			/* Only accept one non-weak bind. */
+			pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
+				sname, name, binary_path);
+			return -LIBBPF_ERRNO__FORMAT;
+		} else if (curr_bind == STB_WEAK) {
+			/* already have a non-weak bind, and
+			 * this is a weak bind, so ignore.
+			 */
+			return 0;
+		}
 	}
-	/* for shared lib case, we do not need to calculate relative offset */
-	is_shared_lib = ehdr.e_type == ET_DYN;
 
-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
+	/* Transform symbol's virtual address (absolute for
+	 * binaries and relative for shared libs) into file
+	 * offset, which is what kernel is expecting for
+	 * uprobe/uretprobe attachment.
+	 * See Documentation/trace/uprobetracer.rst for more
+	 * details.
+	 * This is done by looking up symbol's containing
+	 * section's header and using it's virtual address
+	 * (sh_addr) and corresponding file offset (sh_offset)
+	 * to transform sym.st_value (virtual address) into
+	 * desired final file offset.
+	 */
+	sym_scn = elf_getscn(elf, sym->st_shndx);
+	if (!sym_scn)
+		return 0;
+	if (!gelf_getshdr(sym_scn, &sym_sh))
+		return 0;
+
+	data->offset = sym->st_value - sym_sh.sh_addr + sym_sh.sh_offset;
+	data->last_bind = curr_bind;
+	return 0;
+}
+
+static int elf_for_each_symbol(Elf *elf, const char *binary_path,
+			       int (*fn_match)(Elf *, const char *, const char *, GElf_Sym *, void *),
+			       int (*fn_done)(void *),
+			       void *data)
+{
+	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	int ret = -ENOENT;
 
 	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
@@ -10741,7 +10798,6 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 		size_t nr_syms, strtabidx, idx;
 		Elf_Data *symbols = NULL;
 		Elf_Scn *scn = NULL;
-		int last_bind = -1;
 		const char *sname;
 		GElf_Shdr sh;
 
@@ -10764,10 +10820,7 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 		nr_syms = symbols->d_size / sh.sh_entsize;
 
 		for (idx = 0; idx < nr_syms; idx++) {
-			int curr_bind;
 			GElf_Sym sym;
-			Elf_Scn *sym_scn;
-			GElf_Shdr sym_sh;
 
 			if (!gelf_getsym(symbols, idx, &sym))
 				continue;
@@ -10779,58 +10832,48 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 			if (!sname)
 				continue;
 
-			curr_bind = GELF_ST_BIND(sym.st_info);
-
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sname, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
-				continue;
+			ret = fn_match(elf, binary_path, sname, &sym, data);
+			if (ret < 0)
+				goto out;
+		}
+		if (fn_done(data))
+			break;
+	}
 
-			if (ret >= 0) {
-				/* handle multiple matches */
-				if (last_bind != STB_WEAK && curr_bind != STB_WEAK) {
-					/* Only accept one non-weak bind. */
-					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
-						sname, name, binary_path);
-					ret = -LIBBPF_ERRNO__FORMAT;
-					goto out;
-				} else if (curr_bind == STB_WEAK) {
-					/* already have a non-weak bind, and
-					 * this is a weak bind, so ignore.
-					 */
-					continue;
-				}
-			}
+out:
+	return ret;
+}
 
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
+/* Find offset of function name in the provided ELF object. "binary_path" is
+ * the path to the ELF binary represented by "elf", and only used for error
+ * reporting matters. "name" matches symbol name or name@@LIB for library
+ * functions.
+ */
+static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
+{
+	struct elf_func_offset data = {
+		.name = name,
+		.last_bind = -1,
+		.name_len = strlen(name),
+		/* Does name specify "@@LIB"? */
+		.is_name_qualified = strstr(name, "@@") != NULL,
+	};
+	bool is_shared_lib;
+	GElf_Ehdr ehdr;
+	long ret;
+	int err;
 
-			ret = sym.st_value - sym_sh.sh_addr + sym_sh.sh_offset;
-			last_bind = curr_bind;
-		}
-		if (ret > 0)
-			break;
+	if (!gelf_getehdr(elf, &ehdr)) {
+		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
+		ret = -LIBBPF_ERRNO__FORMAT;
+		goto out;
 	}
 
+	/* for shared lib case, we do not need to calculate relative offset */
+	is_shared_lib = ehdr.e_type == ET_DYN;
+
+	err = elf_for_each_symbol(elf, binary_path, single_match, single_done, &data);
+	ret = err < 0 ? (long) err : data.offset;
 	if (ret > 0) {
 		pr_debug("elf: symbol address match for '%s' in '%s': 0x%lx\n", name, binary_path,
 			 ret);
-- 
2.40.0

