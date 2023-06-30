Return-Path: <bpf+bounces-3774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DCA74375A
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1883B28103A
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332FA957;
	Fri, 30 Jun 2023 08:35:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B5A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B90C433C0;
	Fri, 30 Jun 2023 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114113;
	bh=J8yM+PBhePqqb1qm8PTZ+x79N7m8p5Ir/KVVktpM3RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiLNL9gl1mgIXM06FkgcyWvUVyRGCHn0B43S3HI14B00KtTtmbCAzTp8LCGU7kGjX
	 A0TirHAj1OzT9aCFn66V/ZiWADnMEmNjKzJT3PNdc/+P8hA4yLDwCCUrTyDojiJbI3
	 omEgtMEkhB6ZlGJCFw+IHmRmND5p1B2YSMZE3H9KgTmVQm2OrI9nYF8ctEiugJG9ZI
	 3ATd95k8SBTyQBWONaEwZ9fP13JI9RkGhzd284af6mySJ8pBxm+bktToPhsZOaTCzx
	 ADyYyj0mWLWzNu/kxGp1/ZsqhqMeDCZEQKJ/iz3rfs96L91gGD7VW2L1HIquBmi6Cm
	 8UXvu5icXsuTg==
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
Subject: [PATCHv3 bpf-next 07/26] libbpf: Move elf_find_func_offset* functions to elf object
Date: Fri, 30 Jun 2023 10:33:25 +0200
Message-ID: <20230630083344.984305-8-jolsa@kernel.org>
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

Adding new elf object that will contain elf related functions.
There's no functional change.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/Build        |   2 +-
 tools/lib/bpf/elf.c        | 198 +++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c     | 186 +---------------------------------
 tools/lib/bpf/libbpf_elf.h |  11 +++
 4 files changed, 211 insertions(+), 186 deletions(-)
 create mode 100644 tools/lib/bpf/elf.c
 create mode 100644 tools/lib/bpf/libbpf_elf.h

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index b8b0a6369363..2d0c282c8588 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o
+	    usdt.o zip.o elf.o
diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
new file mode 100644
index 000000000000..2b62b4af28ce
--- /dev/null
+++ b/tools/lib/bpf/elf.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include <libelf.h>
+#include <gelf.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+
+#include "libbpf_elf.h"
+#include "libbpf_internal.h"
+#include "str_error.h"
+
+#define STRERR_BUFSIZE  128
+
+/* Return next ELF section of sh_type after scn, or first of that type if scn is NULL. */
+static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
+{
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		GElf_Shdr sh;
+
+		if (!gelf_getshdr(scn, &sh))
+			continue;
+		if (sh.sh_type == sh_type)
+			return scn;
+	}
+	return NULL;
+}
+
+/* Find offset of function name in the provided ELF object. "binary_path" is
+ * the path to the ELF binary represented by "elf", and only used for error
+ * reporting matters. "name" matches symbol name or name@@LIB for library
+ * functions.
+ */
+long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
+{
+	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	bool is_shared_lib, is_name_qualified;
+	long ret = -ENOENT;
+	size_t name_len;
+	GElf_Ehdr ehdr;
+
+	if (!gelf_getehdr(elf, &ehdr)) {
+		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
+		ret = -LIBBPF_ERRNO__FORMAT;
+		goto out;
+	}
+	/* for shared lib case, we do not need to calculate relative offset */
+	is_shared_lib = ehdr.e_type == ET_DYN;
+
+	name_len = strlen(name);
+	/* Does name specify "@@LIB"? */
+	is_name_qualified = strstr(name, "@@") != NULL;
+
+	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
+	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
+	 * linked binary may not have SHT_DYMSYM, so absence of a section should not be
+	 * reported as a warning/error.
+	 */
+	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
+		size_t nr_syms, strtabidx, idx;
+		Elf_Data *symbols = NULL;
+		Elf_Scn *scn = NULL;
+		int last_bind = -1;
+		const char *sname;
+		GElf_Shdr sh;
+
+		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
+		if (!scn) {
+			pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
+				 binary_path);
+			continue;
+		}
+		if (!gelf_getshdr(scn, &sh))
+			continue;
+		strtabidx = sh.sh_link;
+		symbols = elf_getdata(scn, 0);
+		if (!symbols) {
+			pr_warn("elf: failed to get symbols for symtab section in '%s': %s\n",
+				binary_path, elf_errmsg(-1));
+			ret = -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		nr_syms = symbols->d_size / sh.sh_entsize;
+
+		for (idx = 0; idx < nr_syms; idx++) {
+			int curr_bind;
+			GElf_Sym sym;
+			Elf_Scn *sym_scn;
+			GElf_Shdr sym_sh;
+
+			if (!gelf_getsym(symbols, idx, &sym))
+				continue;
+
+			if (GELF_ST_TYPE(sym.st_info) != STT_FUNC)
+				continue;
+
+			sname = elf_strptr(elf, strtabidx, sym.st_name);
+			if (!sname)
+				continue;
+
+			curr_bind = GELF_ST_BIND(sym.st_info);
+
+			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
+			if (strncmp(sname, name, name_len) != 0)
+				continue;
+			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
+			 * additional characters in sname should be of the form "@@LIB".
+			 */
+			if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
+				continue;
+
+			if (ret >= 0) {
+				/* handle multiple matches */
+				if (last_bind != STB_WEAK && curr_bind != STB_WEAK) {
+					/* Only accept one non-weak bind. */
+					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
+						sname, name, binary_path);
+					ret = -LIBBPF_ERRNO__FORMAT;
+					goto out;
+				} else if (curr_bind == STB_WEAK) {
+					/* already have a non-weak bind, and
+					 * this is a weak bind, so ignore.
+					 */
+					continue;
+				}
+			}
+
+			/* Transform symbol's virtual address (absolute for
+			 * binaries and relative for shared libs) into file
+			 * offset, which is what kernel is expecting for
+			 * uprobe/uretprobe attachment.
+			 * See Documentation/trace/uprobetracer.rst for more
+			 * details.
+			 * This is done by looking up symbol's containing
+			 * section's header and using it's virtual address
+			 * (sh_addr) and corresponding file offset (sh_offset)
+			 * to transform sym.st_value (virtual address) into
+			 * desired final file offset.
+			 */
+			sym_scn = elf_getscn(elf, sym.st_shndx);
+			if (!sym_scn)
+				continue;
+			if (!gelf_getshdr(sym_scn, &sym_sh))
+				continue;
+
+			ret = sym.st_value - sym_sh.sh_addr + sym_sh.sh_offset;
+			last_bind = curr_bind;
+		}
+		if (ret > 0)
+			break;
+	}
+
+	if (ret > 0) {
+		pr_debug("elf: symbol address match for '%s' in '%s': 0x%lx\n", name, binary_path,
+			 ret);
+	} else {
+		if (ret == 0) {
+			pr_warn("elf: '%s' is 0 in symtab for '%s': %s\n", name, binary_path,
+				is_shared_lib ? "should not be 0 in a shared library" :
+						"try using shared library path instead");
+			ret = -ENOENT;
+		} else {
+			pr_warn("elf: failed to find symbol '%s' in '%s'\n", name, binary_path);
+		}
+	}
+out:
+	return ret;
+}
+
+/* Find offset of function name in ELF object specified by path. "name" matches
+ * symbol name or name@@LIB for library functions.
+ */
+long elf_find_func_offset_from_file(const char *binary_path, const char *name)
+{
+	char errmsg[STRERR_BUFSIZE];
+	long ret = -ENOENT;
+	Elf *elf;
+	int fd;
+
+	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ret = -errno;
+		pr_warn("failed to open %s: %s\n", binary_path,
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		return ret;
+	}
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf) {
+		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
+		close(fd);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	ret = elf_find_func_offset(elf, binary_path, name);
+	elf_end(elf);
+	close(fd);
+	return ret;
+}
+
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 53dcf25c4878..093add8124d8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -54,6 +54,7 @@
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
 #include "zip.h"
+#include "libbpf_elf.h"
 
 #ifndef BPF_FS_MAGIC
 #define BPF_FS_MAGIC		0xcafe4a11
@@ -10811,191 +10812,6 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 	return err;
 }
 
-/* Return next ELF section of sh_type after scn, or first of that type if scn is NULL. */
-static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
-{
-	while ((scn = elf_nextscn(elf, scn)) != NULL) {
-		GElf_Shdr sh;
-
-		if (!gelf_getshdr(scn, &sh))
-			continue;
-		if (sh.sh_type == sh_type)
-			return scn;
-	}
-	return NULL;
-}
-
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
-	size_t name_len;
-	GElf_Ehdr ehdr;
-
-	if (!gelf_getehdr(elf, &ehdr)) {
-		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
-		ret = -LIBBPF_ERRNO__FORMAT;
-		goto out;
-	}
-	/* for shared lib case, we do not need to calculate relative offset */
-	is_shared_lib = ehdr.e_type == ET_DYN;
-
-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
-
-	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
-	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
-	 * linked binary may not have SHT_DYMSYM, so absence of a section should not be
-	 * reported as a warning/error.
-	 */
-	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
-		size_t nr_syms, strtabidx, idx;
-		Elf_Data *symbols = NULL;
-		Elf_Scn *scn = NULL;
-		int last_bind = -1;
-		const char *sname;
-		GElf_Shdr sh;
-
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
-
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sname, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
-				continue;
-
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
-		}
-		if (ret > 0)
-			break;
-	}
-
-	if (ret > 0) {
-		pr_debug("elf: symbol address match for '%s' in '%s': 0x%lx\n", name, binary_path,
-			 ret);
-	} else {
-		if (ret == 0) {
-			pr_warn("elf: '%s' is 0 in symtab for '%s': %s\n", name, binary_path,
-				is_shared_lib ? "should not be 0 in a shared library" :
-						"try using shared library path instead");
-			ret = -ENOENT;
-		} else {
-			pr_warn("elf: failed to find symbol '%s' in '%s'\n", name, binary_path);
-		}
-	}
-out:
-	return ret;
-}
-
-/* Find offset of function name in ELF object specified by path. "name" matches
- * symbol name or name@@LIB for library functions.
- */
-static long elf_find_func_offset_from_file(const char *binary_path, const char *name)
-{
-	char errmsg[STRERR_BUFSIZE];
-	long ret = -ENOENT;
-	Elf *elf;
-	int fd;
-
-	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = -errno;
-		pr_warn("failed to open %s: %s\n", binary_path,
-			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
-		return ret;
-	}
-	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
-	if (!elf) {
-		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
-		close(fd);
-		return -LIBBPF_ERRNO__FORMAT;
-	}
-
-	ret = elf_find_func_offset(elf, binary_path, name);
-	elf_end(elf);
-	close(fd);
-	return ret;
-}
-
 /* Find offset of function name in archive specified by path. Currently
  * supported are .zip files that do not compress their contents, as used on
  * Android in the form of APKs, for example. "file_name" is the name of the ELF
diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
new file mode 100644
index 000000000000..1b652220fabf
--- /dev/null
+++ b/tools/lib/bpf/libbpf_elf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __LIBBPF_LIBBPF_ELF_H
+#define __LIBBPF_LIBBPF_ELF_H
+
+#include <libelf.h>
+
+long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name);
+long elf_find_func_offset_from_file(const char *binary_path, const char *name);
+
+#endif /* *__LIBBPF_LIBBPF_ELF_H */
-- 
2.41.0


