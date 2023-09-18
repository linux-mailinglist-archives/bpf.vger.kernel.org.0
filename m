Return-Path: <bpf+bounces-10247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801917A409E
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5992814E0
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1C85233;
	Mon, 18 Sep 2023 05:50:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970115D4
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 05:50:46 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527E128
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:41 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bf58009a8dso2618952a34.1
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695016240; x=1695621040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/Vi3jOFoldGGFJNpwJiZyAtSgXWGeHgJkxz+O+MuaI=;
        b=Lb/AP/w5gOuJFFW/t8RSalrpMAlO8xE3eFxtO4gDPozsgaVEmLHXZ1ZJ4uv08wazpW
         Ba0gQwc1dvyKuJyXMQTwztCFizgRAHvFeKKdSNkkpZHZ/1BZXUhtPAgwYwTGk/tCW8Ul
         G5jVCQu38bosd7iIeFXvpFT4AszOte54PtV6Z3K13a87RbCqLhOS2e6CwjyhFCp+ftSu
         7jYR6NPtRu7oAAqTPRECTvVd2M/3XRXI87DI6Wlev4mwkybq2i5s3P5P8f+Q3kf0Wfw5
         3+oCUGJhsd86tnXsuruHLJH9OpmP9C4Mv5RdzmDhQquQ74vkDSjaOZm/Jy8IYVUOVYoR
         0jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016240; x=1695621040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Vi3jOFoldGGFJNpwJiZyAtSgXWGeHgJkxz+O+MuaI=;
        b=MVZxYkAyhmhfaa+H/fFtESEX8Iuqis3g3vjLA2kgBW+KR8LKNN/43aumvpCdK7Z/yg
         7olHG5+RoYDzK0L/UCMEKk9XCpaHROoepdZ/de/OaYLf6DtGnEKaMbeh7YMl5biIwOcK
         Qji7mteBpG+Cx7Li2JnsqpUWZ6NdcntBXOYEe04fUL5CT1jDW249Tq+dM2hiJ8sMgJDZ
         pw8ungSSMs4l4UoSDrseedI+h9h+4WX0CF18YYfTh+LwMNGfsqcGYp5Qqz+Ph2zcpPtb
         MY4yhPl/+PZYzSM4G+NYq5XJmErzyysQzFP0PceuMmA07+37NKreEgTxgFMZjHFl2jXd
         hHDQ==
X-Gm-Message-State: AOJu0Yx74OdHGjHGmocqTZuT5zKhyCFBIMmbO9Yv8b8m5Fadqqti5e9O
	er7kjkNtt8LssOOlo6wRK5h04IuLveJpow==
X-Google-Smtp-Source: AGHT+IGh520x/AUhpaC41JOeUPLDv7U/VUYv5Ry4hZdcgCz0JXPwV8U8C6YqM6Mr7llfconx9EKt3g==
X-Received: by 2002:a05:6358:99a0:b0:141:a74:da31 with SMTP id j32-20020a05635899a000b001410a74da31mr9425284rwb.8.1695016239823;
        Sun, 17 Sep 2023 22:50:39 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id i15-20020aa787cf000000b006877a17b578sm6374496pfo.40.2023.09.17.22.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 22:50:39 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v4 2/3] libbpf: Support symbol versioning for uprobe
Date: Mon, 18 Sep 2023 02:48:12 +0000
Message-Id: <20230918024813.237475-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918024813.237475-1-hengqi.chen@gmail.com>
References: <20230918024813.237475-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In current implementation, we assume that symbol found in .dynsym section
would have a version suffix and use it to compare with symbol user supplied.
According to the spec ([0]), this assumption is incorrect, the version info
of dynamic symbols are stored in .gnu.version and .gnu.version_d sections
of ELF objects. For example:

    $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
    000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
    000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
    000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5

    $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
      706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
      2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
      2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5

In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name won't work.
Because the qualified name does NOT match `pthread_rwlock_wrlock` (without
version suffix) in .dynsym sections.

This commit implements the symbol versioning for dynsym and allows user to
specify symbol in the following forms:
  - func
  - func@LIB_VERSION
  - func@@LIB_VERSION

In case of symbol conflicts, error out and users should resolve it by
specifying a qualified name.

  [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/elf.c    | 134 +++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.c |   2 +-
 2 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 5c9e588b17da..f7ad7a7acc29 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <libelf.h>
 #include <gelf.h>
 #include <fcntl.h>
@@ -10,6 +13,17 @@
 
 #define STRERR_BUFSIZE  128
 
+/* A SHT_GNU_versym section holds 16-bit words. This bit is set if
+ * the symbol is hidden and can only be seen when referenced using an
+ * explicit version number. This is a GNU extension.
+ */
+#define VERSYM_HIDDEN	0x8000
+
+/* This is the mask for the rest of the data in a word read from a
+ * SHT_GNU_versym section.
+ */
+#define VERSYM_VERSION	0x7fff
+
 int elf_open(const char *binary_path, struct elf_fd *elf_fd)
 {
 	char errmsg[STRERR_BUFSIZE];
@@ -64,13 +78,18 @@ struct elf_sym {
 	const char *name;
 	GElf_Sym sym;
 	GElf_Shdr sh;
+	int ver;
+	bool hidden;
 };
 
 struct elf_sym_iter {
 	Elf *elf;
 	Elf_Data *syms;
+	Elf_Data *versyms;
+	Elf_Data *verdefs;
 	size_t nr_syms;
 	size_t strtabidx;
+	size_t verdef_strtabidx;
 	size_t next_sym_idx;
 	struct elf_sym sym;
 	int st_type;
@@ -111,6 +130,29 @@ static int elf_sym_iter_new(struct elf_sym_iter *iter,
 	iter->nr_syms = iter->syms->d_size / sh.sh_entsize;
 	iter->elf = elf;
 	iter->st_type = st_type;
+
+	/* Version symbol table is meaningful to dynsym only */
+	if (sh_type != SHT_DYNSYM)
+		return 0;
+
+	scn = elf_find_next_scn_by_type(elf, SHT_GNU_versym, NULL);
+	if (!scn)
+		return 0;
+	if (!gelf_getshdr(scn, &sh))
+		return -EINVAL;
+	iter->versyms = elf_getdata(scn, 0);
+
+	scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
+	if (!scn) {
+		pr_debug("elf: failed to find verdef ELF sections in '%s'\n",
+			 binary_path);
+		return -ENOENT;
+	}
+	if (!gelf_getshdr(scn, &sh))
+		return -EINVAL;
+	iter->verdef_strtabidx = sh.sh_link;
+	iter->verdefs = elf_getdata(scn, 0);
+
 	return 0;
 }
 
@@ -119,6 +161,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
 	struct elf_sym *ret = &iter->sym;
 	GElf_Sym *sym = &ret->sym;
 	const char *name = NULL;
+	GElf_Versym versym;
 	Elf_Scn *sym_scn;
 	size_t idx;
 
@@ -138,12 +181,80 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
 
 		iter->next_sym_idx = idx + 1;
 		ret->name = name;
+		ret->ver = 0;
+		ret->hidden = false;
+
+		if (iter->versyms) {
+			if (!gelf_getversym(iter->versyms, idx, &versym))
+				continue;
+			ret->ver = versym & VERSYM_VERSION;
+			ret->hidden = versym & VERSYM_HIDDEN;
+		}
 		return ret;
 	}
 
 	return NULL;
 }
 
+static const char *elf_get_vername(struct elf_sym_iter *iter, int ver)
+{
+	GElf_Verdaux verdaux;
+	GElf_Verdef verdef;
+	int offset;
+
+	offset = 0;
+	while (gelf_getverdef(iter->verdefs, offset, &verdef)) {
+		if (verdef.vd_ndx != ver) {
+			if (!verdef.vd_next)
+				break;
+
+			offset += verdef.vd_next;
+			continue;
+		}
+
+		if (!gelf_getverdaux(iter->verdefs, offset + verdef.vd_aux, &verdaux))
+			break;
+
+		return elf_strptr(iter->elf, iter->verdef_strtabidx, verdaux.vda_name);
+
+	}
+	return NULL;
+}
+
+static bool symbol_match(struct elf_sym_iter *iter, int sh_type, struct elf_sym *sym,
+			 const char *name, size_t name_len, const char *lib_ver)
+{
+	const char *ver_name;
+
+	/* Symbols are in forms of func, func@LIB_VER or func@@LIB_VER
+	 * make sure the func part matches the user specified name
+	 */
+	if (strncmp(sym->name, name, name_len) != 0)
+		return false;
+
+	/* ...but we don't want a search for "foo" to match 'foo2" also, so any
+	 * additional characters in sname should be of the form "@@LIB".
+	 */
+	if (sym->name[name_len] != '\0' && sym->name[name_len] != '@')
+		return false;
+
+	/* If user does not specify symbol version, then we got a match */
+	if (!lib_ver)
+		return true;
+
+	/* If user specifies symbol version, for dynamic symbols,
+	 * get version name from ELF verdef section for comparison.
+	 */
+	if (sh_type == SHT_DYNSYM) {
+		ver_name = elf_get_vername(iter, sym->ver);
+		if (!ver_name)
+			return false;
+		return !strcmp(ver_name, lib_ver);
+	}
+
+	/* For normal symbols, it is already in form of func@LIB_VER */
+	return !strcmp(sym->name, name);
+}
 
 /* Transform symbol's virtual address (absolute for binaries and relative
  * for shared libs) into file offset, which is what kernel is expecting
@@ -166,7 +277,8 @@ static unsigned long elf_sym_offset(struct elf_sym *sym)
 long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 {
 	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
-	bool is_shared_lib, is_name_qualified;
+	const char *at_symbol, *lib_ver;
+	bool is_shared_lib;
 	long ret = -ENOENT;
 	size_t name_len;
 	GElf_Ehdr ehdr;
@@ -179,9 +291,15 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	/* for shared lib case, we do not need to calculate relative offset */
 	is_shared_lib = ehdr.e_type == ET_DYN;
 
-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
+	/* Does name specify "@@LIB_VER" or "@LIB_VER" ? */
+	at_symbol = strchr(name, '@');
+	if (at_symbol) {
+		name_len = at_symbol - name;
+		lib_ver = strrchr(name, '@') + 1;
+	} else {
+		name_len = strlen(name);
+		lib_ver = NULL;
+	}
 
 	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
@@ -201,13 +319,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 			goto out;
 
 		while ((sym = elf_sym_iter_next(&iter))) {
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sym->name, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
+			if (!symbol_match(&iter, sh_types[i], sym, name, name_len, lib_ver))
 				continue;
 
 			cur_bind = GELF_ST_BIND(sym->sym.st_info);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a6108e3238b..b4758e54a815 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 
 	*link = NULL;
 
-	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
 		   &probe_type, &binary_path, &func_name, &offset);
 	switch (n) {
 	case 1:
-- 
2.34.1


