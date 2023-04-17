Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4C6E5105
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQTeW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDQTeV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 15:34:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B227B0;
        Mon, 17 Apr 2023 12:34:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec9ccab8bbso1681485e87.2;
        Mon, 17 Apr 2023 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681760057; x=1684352057;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKiq+dfuXxPCK65ueY2+8jxQZPAaLr20iv5vBFv5en0=;
        b=C6aw+GVwQET2J1ZEfk4Q8nLuh/6vhQTrRuVW5iu1BIEEmygMMkbKtg3XrDY35BaOZJ
         chpQYoE4YQ8J7xBdH6Fcrzzz22KnyAaNl//HYV3YINJwPWMjYq1JUkMX3G937LWvqjD9
         kLVdVULHTwrD+zEm81we1xaJoMJheFM4RmPCwvpcBM0f5K2DUcypFLQwb0RV/2jnfdQn
         hOM4pcts/YfwJaIu0BGS4bTgGFrEr3rfDoRuZwreHXpWtndDk3/y9Bl1uOuKh2Tm5rKr
         xXVLC2hRH+QsaSRxnr+kwkF4b5yCZcCP7uYxTH5XWtkVMIUnBoiGnn+YYTfEnYoxa9BP
         777A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681760057; x=1684352057;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKiq+dfuXxPCK65ueY2+8jxQZPAaLr20iv5vBFv5en0=;
        b=bhUghQY9ukuHQBsjWn3jTY8FRkcyM7nKuAb61wtqbfL1G+hbEcFNqY0KIAEW5Nr6Ng
         I2UOeAIjgpJBby55fKDdoupf5YsnF6wZ6AKehgTsB7l5OudkpSkr8clP8P7LfRS876UR
         /tr76sbjO73y+7GjXnrSQDg03l0H25OuH2TU+jAbOdLq/LYUDZaF2jWWuErzDmDwVLGm
         JyoFa44s7gG0o9QdSg/xq7DRUC+4fcMbESEEE84VzGxsqOpRBrH6SPAbm1AhquL+lF/Y
         46ZXpf4BGcXLUg52VWIwqL6I4ABj8iskga2yKRZy1kPhdthMrftIBejrdXF8OaINlDr3
         3YMQ==
X-Gm-Message-State: AAQBX9cJbfd9pRX6NaKmASKbAUQq2+EMExMSJL05784LOEswALF3GHN5
        DBcMXUhQa06Oi1qXQ1bwfZw=
X-Google-Smtp-Source: AKy350ZkyNHR2oFlkL9WwKW5766PuujupxXOjD0QVEY13Pd3xfBEoQNQdSdo9h44QAH9s3x1abbjQw==
X-Received: by 2002:ac2:44b4:0:b0:4ed:bf01:3ff3 with SMTP id c20-20020ac244b4000000b004edbf013ff3mr1770405lfm.43.1681760057607;
        Mon, 17 Apr 2023 12:34:17 -0700 (PDT)
Received: from eg ([2a01:799:1727:1d00:276c:c908:5e5e:3b0a])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2514b000000b004eb0eafaa02sm2118861lfd.243.2023.04.17.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:34:17 -0700 (PDT)
Date:   Mon, 17 Apr 2023 21:34:15 +0200
From:   Espen Grindhaug <espen.grindhaug@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: Improve version handling when attaching uprobe
Message-ID: <ZD2fNzhzFRHmywRv@eg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change fixes the handling of versions in elf_find_func_offset.
In the previous implementation, we incorrectly assumed that the
version information would be present in the string found in the
string table.

We now look up the correct version string in the version symbol
table before constructing the full name and then comparing.

This patch adds support for both name@version and name@@version to
match output of the various elf parsers.

Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
---
 tools/lib/bpf/libbpf.c | 148 +++++++++++++++++++++++++++++++++++------
 1 file changed, 129 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49cd304ae3bc..ef5e11ce6241 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10620,31 +10620,94 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 }
 
 /* Return next ELF section of sh_type after scn, or first of that type if scn is NULL. */
-static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
+static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn, size_t *idx)
 {
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		GElf_Shdr sh;
 
 		if (!gelf_getshdr(scn, &sh))
 			continue;
-		if (sh.sh_type == sh_type)
+		if (sh.sh_type == sh_type) {
+			if (idx)
+				*idx = sh.sh_link;
 			return scn;
+		}
+	}
+	return NULL;
+}
+
+static Elf_Data *elf_find_data_by_type(Elf *elf, int sh_type, size_t *idx)
+{
+	Elf_Scn *scn = elf_find_next_scn_by_type(elf, sh_type, NULL, idx);
+
+	if (scn)
+		return elf_getdata(scn, NULL);
+
+	return NULL;
+}
+
+static Elf64_Verdef *elf_verdef_by_offset(Elf_Data *data, size_t offset)
+{
+	if (offset + sizeof(Elf64_Verdef) > data->d_size)
+		return NULL;
+
+	return (Elf64_Verdef *)((char *) data->d_buf + offset);
+}
+
+static Elf64_Versym *elf_versym_by_idx(Elf_Data *data, size_t idx)
+{
+	if (idx >= data->d_size / sizeof(Elf64_Versym))
+		return NULL;
+
+	return (Elf64_Versym *)(data->d_buf + idx * sizeof(Elf64_Versym));
+}
+
+static Elf64_Verdaux *elf_verdaux_by_offset(Elf_Data *data, size_t offset)
+{
+	if (offset + sizeof(Elf64_Verdaux) > data->d_size)
+		return NULL;
+
+	return (Elf64_Verdaux *)((char *) data->d_buf + offset);
+}
+
+#define ELF_VERSYM_HIDDEN 0x8000
+#define ELF_VERSYM_IDX_MASK 0x7fff
+
+static Elf64_Verdaux *elf_get_verdaux_by_versym(Elf_Data *verdef_data, Elf64_Versym *versym)
+{
+	size_t offset = 0;
+
+	while (offset + sizeof(Elf64_Verdef) <= verdef_data->d_size) {
+		Elf64_Verdef *verdef = elf_verdef_by_offset(verdef_data, offset);
+
+		if (!verdef)
+			break;
+
+		if (verdef->vd_ndx == (*versym & ELF_VERSYM_IDX_MASK))
+			return elf_verdaux_by_offset(verdef_data, offset + verdef->vd_aux);
+
+		if (verdef->vd_next == 0)
+			break;
+
+		offset += verdef->vd_next;
 	}
 	return NULL;
 }
 
 /* Find offset of function name in the provided ELF object. "binary_path" is
  * the path to the ELF binary represented by "elf", and only used for error
- * reporting matters. "name" matches symbol name or name@@LIB for library
- * functions.
+ * reporting matters. "name" matches symbol name, name@LIB or name@@LIB for
+ * library functions.
  */
 static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 {
 	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
 	bool is_shared_lib, is_name_qualified;
 	long ret = -ENOENT;
-	size_t name_len;
 	GElf_Ehdr ehdr;
+	Elf_Data *versym_data = NULL;
+	Elf_Data *verdef_data = NULL;
+	size_t verdef_stridx = 0;
 
 	if (!gelf_getehdr(elf, &ehdr)) {
 		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
@@ -10654,9 +10717,12 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 	/* for shared lib case, we do not need to calculate relative offset */
 	is_shared_lib = ehdr.e_type == ET_DYN;
 
-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
+	/* Does name specify "@@LIB" or "@LIB"? */
+	is_name_qualified = strstr(name, "@") != NULL;
+
+	/* Extract version definition and version symbol table */
+	versym_data = elf_find_data_by_type(elf, SHT_GNU_versym, NULL);
+	verdef_data = elf_find_data_by_type(elf, SHT_GNU_verdef, &verdef_stridx);
 
 	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
@@ -10671,10 +10737,10 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 		const char *sname;
 		GElf_Shdr sh;
 
-		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
+		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL, NULL);
 		if (!scn) {
 			pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
-				 binary_path);
+				binary_path);
 			continue;
 		}
 		if (!gelf_getshdr(scn, &sh))
@@ -10705,16 +10771,60 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 			if (!sname)
 				continue;
 
-			curr_bind = GELF_ST_BIND(sym.st_info);
+			if (is_name_qualified) {
+				Elf64_Versym *versym;
+				Elf64_Verdaux *verdaux;
+				int res;
+				char full_name[256];
 
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sname, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
-				continue;
+				/* check that name at least starts with sname before building
+				 * the full name
+				 */
+				if (strncmp(name, sname, strlen(sname)) != 0)
+					continue;
+
+				if (!versym_data || !verdef_data) {
+					pr_warn("elf: failed to find version definition or version symbol table in '%s'\n",
+						binary_path);
+					break;
+				}
+
+				versym = elf_versym_by_idx(versym_data, idx);
+				if (!versym) {
+					pr_warn("elf: failed to lookup versym for '%s' in '%s'\n",
+						sname, binary_path);
+					continue;
+				}
+
+				verdaux = elf_get_verdaux_by_versym(verdef_data, versym);
+				if (!verdaux) {
+					pr_warn("elf: failed to lookup verdaux for '%s' in '%s'\n",
+						sname, binary_path);
+					continue;
+				}
+
+				res = snprintf(full_name, sizeof(full_name),
+					       (*versym & ELF_VERSYM_HIDDEN) ? "%s@%s" :
+								    "%s@@%s",
+					       sname,
+					       elf_strptr(elf, verdef_stridx,
+							  verdaux->vda_name));
+
+				if (res < 0 || res >= sizeof(full_name)) {
+					pr_warn("elf: failed to build full name for '%s' in '%s'\n",
+						sname, binary_path);
+					continue;
+				}
+
+				if (strcmp(full_name, name) != 0)
+					continue;
+			} else {
+				/* If name is not qualified, we want to match the symbol name */
+				if (strcmp(sname, name) != 0)
+					continue;
+			}
+
+			curr_bind = GELF_ST_BIND(sym.st_info);
 
 			if (ret >= 0) {
 				/* handle multiple matches */
-- 
2.34.1

