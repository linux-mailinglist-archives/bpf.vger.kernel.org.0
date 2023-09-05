Return-Path: <bpf+bounces-9436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F888797A24
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B6B2816C8
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82313AE8;
	Thu,  7 Sep 2023 17:31:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD913AE4
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 17:31:53 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7B10CA
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 10:31:29 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64b3ae681d1so6982726d6.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694107836; x=1694712636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlLlKmiw/xSmwYWp60s46u5j6Sdvf+aKxz4mWiOlM+4=;
        b=DXQ3FcfBV8DFZYC9TiYJw8U/TOzhY5kH3X3ruPZaJFE7xYYHQlWJy9p2NGFVzJslOE
         s1w2Csvg5GpCgGu4sGRY5OqrnC4gKI/46Z8kSFRguVW0IdymO9n88hV+A9oGNRuRRgFm
         ffkuG9rbn7lk2iWlD6J1Ebe4ZTdWbmpFU0Hm63wf/cCO8ho6iypW0QGeFABSghWf4aWf
         Ebu67dTemu9dgddL3nrITkB+aN2Pc6Ha4cahHxC6wRDjYg0LtsFukhLDtRI9vcKjascP
         WghGCSlydGyT4K1iPE5snk+I9VqUdynVZF0NB/GWNpbjjMhCE4amWVefIkY+HCflsGpV
         I5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107836; x=1694712636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlLlKmiw/xSmwYWp60s46u5j6Sdvf+aKxz4mWiOlM+4=;
        b=Ong/ksqtcCHy1I76olk0XozpVK8Zx+1PinD7kGDs6FP97h7VLsUr9DfB19T80BofU5
         BxIsWWmc9EFHCAaWg+/cpH2FCwcfcZhreIsPNatEmPlYPlk1ACz3n/rxjOx7+FjxEMH3
         tolRE1C2BDBFVi3sBkbQbqkcnVObsBmmTMxPixmhUZoDeGcxLTjudb7RVdErnAStEnSd
         in9GkL+CBAEOGtt2XNoMIAq1YgSLFXX6BWtxuqeuHrABPJ3ht8eR7+X5vRevyj+zRy6x
         3sPJpozZgEJ5vhY/+Gh0rcdwXqmjM8DUomvPd84Au/zcQ9rouAjfuDexNuZGwmnE7s8D
         c+PA==
X-Gm-Message-State: AOJu0YzwWH/Jj3yKYh7Q+bD0rAkJDU4KFlt7uKpdozZex5UCJ/xWBx/8
	t7ITb4BeAaPL+vqo8Fi1J76AO269pHa8zw==
X-Google-Smtp-Source: AGHT+IEk+eHS3hjNC6DRpcHVKsC9lOqa8UoaqfGyCKZU+9pVgJ4xnj2TOwcoxU/z2edR4FVo+9t7Kw==
X-Received: by 2002:a05:6870:d69f:b0:1ba:6180:ff47 with SMTP id z31-20020a056870d69f00b001ba6180ff47mr20503924oap.21.1694065417833;
        Wed, 06 Sep 2023 22:43:37 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.117])
        by smtp.googlemail.com with ESMTPSA id q7-20020a637507000000b00570574feda0sm11860963pgc.19.2023.09.06.22.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 22:43:37 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 2/3] libbpf: Support symbol versioning for uprobe
Date: Tue,  5 Sep 2023 15:12:56 +0000
Message-Id: <20230905151257.729192-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905151257.729192-1-hengqi.chen@gmail.com>
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
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

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/elf.c    | 145 +++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.c |   2 +-
 2 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 5c9e588b17da..2d2819b7e018 100644
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

@@ -138,12 +168,112 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)

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
+		ret = strncmp(sname, name, name_len);
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
@@ -166,9 +296,8 @@ static unsigned long elf_sym_offset(struct elf_sym *sym)
 long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 {
 	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
-	bool is_shared_lib, is_name_qualified;
+	bool is_shared_lib;
 	long ret = -ENOENT;
-	size_t name_len;
 	GElf_Ehdr ehdr;

 	if (!gelf_getehdr(elf, &ehdr)) {
@@ -179,10 +308,6 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	/* for shared lib case, we do not need to calculate relative offset */
 	is_shared_lib = ehdr.e_type == ET_DYN;

-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
-
 	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
 	 * linked binary may not have SHT_DYMSYM, so absence of a section should not be
@@ -201,13 +326,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
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

