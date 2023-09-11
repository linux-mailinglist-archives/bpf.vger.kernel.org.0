Return-Path: <bpf+bounces-9619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D379A10C
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 03:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A332810C8
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9E317F3;
	Mon, 11 Sep 2023 01:51:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098E17C8
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 01:51:32 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00E126
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:29 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1c8e9d75ce1so2313297fac.3
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694397088; x=1695001888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcs60yTuuRwoEY792MEdOPva6TJQVvE7paEeFWeTfjE=;
        b=Dw2qZU0AbKBB8/35fKOnPqTLSIv9f5DS3mSe9hnb0wBFnDBqn1z++YPFePdyqBKq91
         dtjEyLkFkxuxCA1LEZ/T1fDdoOmLupxGxxmBNZfzMLWv7tZltOItmWBwUFpWB2CJUpYY
         YkhNSpTDYVPXjAOhbJVX1xnxUPXHtFLyBMxi5QY0FNCx6oUWFbG5uAfppxz+Ej9G4eWe
         c5AGp46xrBr2KWocQsJFkGTycm6dXmSnoP6Wq7WEvM/Sl9AuvXu47rogcJ5zmVd2G3/V
         W8olCToBTr8j5nl2ZreJ5SG5VvPKOgse0qnkkwVaU5VIGPgBMvaYNp7sgQZMiyLK1GmY
         c9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694397088; x=1695001888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcs60yTuuRwoEY792MEdOPva6TJQVvE7paEeFWeTfjE=;
        b=HtB44QRazwAHRmuP+vJXAK2ziGEgTOXm8a/AqvG70EzLd65KDqYtEH6CN9na68NPM7
         8savfJvk7PIpgo5xrdh995HE9J1w5lSxjVICEZbZKedEqlX894k1kE58Yko8DWwoYnmT
         f4+Tm3i6Khi7LLcbTp5FGlmdEeskFDbsGj6ZWg4Luiyxv35tH19P6zBoORM1I88WsZ/a
         NAuBacVyMiVtA4mFR13Psjmmx7X6UouspNav7fNOIRZ3HDsG2D104M2qUKNP/rNgoX/f
         rqqR+wv1d5uzif9MLL30gRiS+l36pVzV3KMBsDl+0iAcxw5USJ4FxOnOJBu3TXjeCLjj
         rihA==
X-Gm-Message-State: AOJu0Ywj3Vk9saSUToszQKS3Xha8lBOkknJagNeVZgJVXiD8J2UqCyBs
	M07qyIDmmKfZgb0LbteN43ayF8lqSZhXtQ==
X-Google-Smtp-Source: AGHT+IHwAJXb/Lf2pcUwsPpYzj2PoZDtLo8iEoC1JSX/+P1oZGZi/8f5+WDo9zHU1uTggU5CVermog==
X-Received: by 2002:a05:6870:14c9:b0:1be:fd4e:e369 with SMTP id l9-20020a05687014c900b001befd4ee369mr9140856oab.42.1694397088078;
        Sun, 10 Sep 2023 18:51:28 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a63b04e000000b0056365ee8603sm4375699pgo.67.2023.09.10.18.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 18:51:27 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v3 2/3] libbpf: Support symbol versioning for uprobe
Date: Mon, 11 Sep 2023 01:50:51 +0000
Message-Id: <20230911015052.72975-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230911015052.72975-1-hengqi.chen@gmail.com>
References: <20230911015052.72975-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
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
 tools/lib/bpf/elf.c    | 146 +++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.c |   2 +-
 2 files changed, 134 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 5c9e588b17da..825da903a34c 100644
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
@@ -64,11 +78,14 @@ struct elf_sym {
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
 	size_t nr_syms;
 	size_t strtabidx;
 	size_t next_sym_idx;
@@ -111,6 +128,18 @@ static int elf_sym_iter_new(struct elf_sym_iter *iter,
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
 	return 0;
 }
 
@@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
 	struct elf_sym *ret = &iter->sym;
 	GElf_Sym *sym = &ret->sym;
 	const char *name = NULL;
+	GElf_Versym versym;
 	Elf_Scn *sym_scn;
 	size_t idx;
 
@@ -138,12 +168,113 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
 
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
 
+static const char *elf_get_vername(Elf *elf, int ver)
+{
+	GElf_Verdaux verdaux;
+	GElf_Verdef verdef;
+	Elf_Data *verdefs;
+	size_t strtabidx;
+	GElf_Shdr sh;
+	Elf_Scn *scn;
+	int offset;
+
+	scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
+	if (!scn)
+		return NULL;
+	if (!gelf_getshdr(scn, &sh))
+		return NULL;
+	strtabidx = sh.sh_link;
+	verdefs =  elf_getdata(scn, 0);
+
+	offset = 0;
+	while (gelf_getverdef(verdefs, offset, &verdef)) {
+		if (verdef.vd_ndx != ver) {
+			if (!verdef.vd_next)
+				break;
+
+			offset += verdef.vd_next;
+			continue;
+		}
+
+		if (!gelf_getverdaux(verdefs, offset + verdef.vd_aux, &verdaux))
+			break;
+
+		return elf_strptr(elf, strtabidx, verdaux.vda_name);
+
+	}
+	return NULL;
+}
+
+static bool symbol_match(Elf *elf, int sh_type, struct elf_sym *sym, const char *name)
+{
+	size_t name_len, sname_len;
+	bool is_name_qualified;
+	const char *ver;
+	char *sname;
+	int ret;
+
+	name_len = strlen(name);
+	/* Does name specify "@LIB" or "@@LIB" ? */
+	is_name_qualified = strstr(name, "@") != NULL;
+
+	/* If user specify a qualified name, for dynamic symbol,
+	 * it is in form of func, NOT func@LIB_VER or func@@LIB_VER.
+	 * So construct a full quailified symbol name using versym info
+	 * for comparison.
+	 */
+	if (is_name_qualified && sh_type == SHT_DYNSYM) {
+		/* Make sure func match func@LIB_VER */
+		sname_len = strlen(sym->name);
+		if (strncmp(sym->name, name, sname_len) != 0)
+			return false;
+
+		/* But not func2@LIB_VER */
+		if (name[sname_len] != '@')
+			return false;
+
+		ver = elf_get_vername(elf, sym->ver);
+		if (!ver)
+			return false;
+
+		ret = asprintf(&sname, "%s%s%s", sym->name,
+			       sym->hidden ? "@" : "@@", ver);
+		if (ret == -1)
+			return false;
+
+		sname_len = ret;
+		ret = strncmp(sname, name, sname_len);
+		free(sname);
+		return ret == 0;
+	}
+
+	/* Otherwise, for normal symbols or non-qualified names
+	 * User can specify func, func@@LIB or func@@LIB_VERSION.
+	 */
+	if (strncmp(sym->name, name, name_len) != 0)
+		return false;
+	/* ...but we don't want a search for "foo" to match 'foo2" also, so any
+	 * additional characters in sname should be of the form "@LIB" or "@@LIB".
+	 */
+	if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
+		return false;
+
+	return true;
+}
 
 /* Transform symbol's virtual address (absolute for binaries and relative
  * for shared libs) into file offset, which is what kernel is expecting
@@ -166,9 +297,8 @@ static unsigned long elf_sym_offset(struct elf_sym *sym)
 long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 {
 	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
-	bool is_shared_lib, is_name_qualified;
+	bool is_shared_lib;
 	long ret = -ENOENT;
-	size_t name_len;
 	GElf_Ehdr ehdr;
 
 	if (!gelf_getehdr(elf, &ehdr)) {
@@ -179,10 +309,6 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	/* for shared lib case, we do not need to calculate relative offset */
 	is_shared_lib = ehdr.e_type == ET_DYN;
 
-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
-
 	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
 	 * linked binary may not have SHT_DYMSYM, so absence of a section should not be
@@ -201,13 +327,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 			goto out;
 
 		while ((sym = elf_sym_iter_next(&iter))) {
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sym->name, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
+			if (!symbol_match(elf, sh_types[i], sym, name))
 				continue;
 
 			cur_bind = GELF_ST_BIND(sym->sym.st_info);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..30b8f96820a7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11512,7 +11512,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 
 	*link = NULL;
 
-	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
 		   &probe_type, &binary_path, &func_name, &offset);
 	switch (n) {
 	case 1:
-- 
2.34.1


