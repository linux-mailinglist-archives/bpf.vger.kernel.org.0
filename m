Return-Path: <bpf+bounces-45292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224269D411A
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 18:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51B7B37BBE
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651E1A7265;
	Wed, 20 Nov 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ReQq3wSg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D038155330
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122176; cv=none; b=oXJUv4SWfeU7OGSC87YLuwOiqyfctNnlppo5NrYYw4qc8LTnGmoluZWvMu5j2IthY4Kaflx151fd/XUoAopYbFjecERE3PJW4ycTeTrZZdNfobwOOAfEMxhK431YdGznmsAlp4wMrcJx3Q9B6saIvimH/XSgCWKNV1AfDmAi1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122176; c=relaxed/simple;
	bh=YVuF9wncXib6inBcfsW0WwxuVZJJSkLPIcjE8zJr3fQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VB6K4wKTMcze2mHcyfgn3Lvcer0txyFqJjcAfqbsyQ/k0I71i+3Bvqc05dno4SvmNWQ5lw/86oIO1k6HmB8FafsEuQ83ZUPJ7JSxLc34U2OgtwqaEETh6Z1myiEOfwh90HmPHp6ZDHBljOm+gqb3lap62fBFoWx0BUjzPdrp1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ReQq3wSg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AKEoRMJ007258
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 09:02:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ZjircFNmTTq+3Rk34y
	r73hZjGbQQiy1K8MXpKR6r0CA=; b=ReQq3wSguYRajpnmLKHU4CjSuVLl+GyHza
	G2EfM1mcRJDv7DQH88KcLZiPhSS8b06upn7ay02eqRgBIYfYhO+sfCcyJPtsxmPu
	SneYsf88sL0StLdmG3lOTJYcoNq38Ze6kse9xHYet3URdEItavZmcIq25BcrD0eN
	46ch0y4GyEJ43L76Ttq7eoFi8DXBcovQ49L9WouFndhRR7BABRAURmQTk2dBk9st
	fL9uvfGqUbYKLJrGcsIvKF1HQy1R6i7rUiomrL45UUfPNMx63pqO9O/TkGvbwLwF
	wkyQxK4BXmzU7VYb9kq9NisRzhQvssCJv8te0e5+ercoo+9phfug==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 431h659ay3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 09:02:53 -0800 (PST)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 20 Nov 2024 17:02:51 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id E637CC949506; Wed, 20 Nov 2024 09:02:39 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next] libbpf: Extend linker API to support in-memory ELF files
Date: Wed, 20 Nov 2024 09:02:06 -0800
Message-ID: <20241120170206.2592931-1-ajor@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ne1O78IhMlVz89cOWv3gOMLu4qfUVhke
X-Proofpoint-GUID: Ne1O78IhMlVz89cOWv3gOMLu4qfUVhke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The new_fd, add_fd and finalize_fd functions correspond to the original
new, add_file and finalize functions, but accept an FD instead of a file
name. This gives API consumers the option of using anonymous
files/memfds to avoid writing ELFs to disk.

This new API will be useful for performing linking as part of
bpftrace's JIT compilation.

The add_buf function is a convenience wrapper that does the work of
creating a memfd for the caller.

Signed-off-by: Alastair Robertson <ajor@meta.com>
---
 tools/lib/bpf/libbpf.h   |   9 ++
 tools/lib/bpf/libbpf.map |   4 +
 tools/lib/bpf/linker.c   | 229 +++++++++++++++++++++++++++++----------
 3 files changed, 185 insertions(+), 57 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b2ce3a72b11d..aae8f954c4fc 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1796,10 +1796,19 @@ struct bpf_linker_file_opts {
 struct bpf_linker;
=20
 LIBBPF_API struct bpf_linker *bpf_linker__new(const char *filename, stru=
ct bpf_linker_opts *opts);
+LIBBPF_API struct bpf_linker *bpf_linker__new_fd(const char *name, int f=
d,
+						 struct bpf_linker_opts *opts);
 LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
 				    const char *filename,
 				    const struct bpf_linker_file_opts *opts);
+LIBBPF_API int bpf_linker__add_fd(struct bpf_linker *linker,
+				  const char *name, int fd,
+				  const struct bpf_linker_file_opts *opts);
+LIBBPF_API int bpf_linker__add_buf(struct bpf_linker *linker, const char=
 *name,
+				   void *buffer, int buffer_sz,
+				   const struct bpf_linker_file_opts *opts);
 LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
+LIBBPF_API int bpf_linker__finalize_fd(struct bpf_linker *linker);
 LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
=20
 /*
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 54b6f312cfa8..e767f34c1d08 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -432,4 +432,8 @@ LIBBPF_1.5.0 {
 } LIBBPF_1.4.0;
=20
 LIBBPF_1.6.0 {
+		bpf_linker__new_fd;
+		bpf_linker__add_fd;
+		bpf_linker__add_buf;
+		bpf_linker__finalize_fd;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index cf71d149fe26..6571ed8b858f 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2021 Facebook
  */
+#define _GNU_SOURCE
+
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -16,6 +18,7 @@
 #include <elf.h>
 #include <libelf.h>
 #include <fcntl.h>
+#include <sys/mman.h>
 #include "libbpf.h"
 #include "btf.h"
 #include "libbpf_internal.h"
@@ -157,9 +160,9 @@ struct bpf_linker {
 #define pr_warn_elf(fmt, ...)									\
 	libbpf_print(LIBBPF_WARN, "libbpf: " fmt ": %s\n", ##__VA_ARGS__, elf_e=
rrmsg(-1))
=20
-static int init_output_elf(struct bpf_linker *linker, const char *file);
+static int init_output_elf(struct bpf_linker *linker);
=20
-static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
+static int linker_load_obj_file(struct bpf_linker *linker,
 				const struct bpf_linker_file_opts *opts,
 				struct src_obj *obj);
 static int linker_sanity_check_elf(struct src_obj *obj);
@@ -233,9 +236,56 @@ struct bpf_linker *bpf_linker__new(const char *filen=
ame, struct bpf_linker_opts
 	if (!linker)
 		return errno =3D ENOMEM, NULL;
=20
-	linker->fd =3D -1;
+	linker->filename =3D strdup(filename);
+	if (!linker->filename)
+		return errno =3D ENOMEM, NULL;
+
+	linker->fd =3D open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,=
 0644);
+	if (linker->fd < 0) {
+		err =3D -errno;
+		pr_warn("failed to create '%s': %d\n", filename, err);
+		goto err_out;
+	}
+
+	err =3D init_output_elf(linker);
+	if (err)
+		goto err_out;
+
+	return linker;
+
+err_out:
+	bpf_linker__free(linker);
+	return errno =3D -err, NULL;
+}
+
+struct bpf_linker *bpf_linker__new_fd(const char *name, int fd,
+				      struct bpf_linker_opts *opts)
+{
+	struct bpf_linker *linker;
+	int err;
+
+	if (fd < 0)
+		return errno =3D EINVAL, NULL;
+
+	if (!OPTS_VALID(opts, bpf_linker_opts))
+		return errno =3D EINVAL, NULL;
+
+	if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
+		pr_warn_elf("libelf initialization failed");
+		return errno =3D EINVAL, NULL;
+	}
+
+	linker =3D calloc(1, sizeof(*linker));
+	if (!linker)
+		return errno =3D ENOMEM, NULL;
+
+	linker->filename =3D strdup(name);
+	if (!linker->filename)
+		return errno =3D ENOMEM, NULL;
+
+	linker->fd =3D fd;
=20
-	err =3D init_output_elf(linker, filename);
+	err =3D init_output_elf(linker);
 	if (err)
 		goto err_out;
=20
@@ -294,23 +344,12 @@ static Elf64_Sym *add_new_sym(struct bpf_linker *li=
nker, size_t *sym_idx)
 	return sym;
 }
=20
-static int init_output_elf(struct bpf_linker *linker, const char *file)
+static int init_output_elf(struct bpf_linker *linker)
 {
 	int err, str_off;
 	Elf64_Sym *init_sym;
 	struct dst_sec *sec;
=20
-	linker->filename =3D strdup(file);
-	if (!linker->filename)
-		return -ENOMEM;
-
-	linker->fd =3D open(file, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 064=
4);
-	if (linker->fd < 0) {
-		err =3D -errno;
-		pr_warn("failed to create '%s': %s\n", file, errstr(err));
-		return err;
-	}
-
 	linker->elf =3D elf_begin(linker->fd, ELF_C_WRITE, NULL);
 	if (!linker->elf) {
 		pr_warn_elf("failed to create ELF object");
@@ -436,10 +475,9 @@ static int init_output_elf(struct bpf_linker *linker=
, const char *file)
 	return 0;
 }
=20
-int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
-			 const struct bpf_linker_file_opts *opts)
+static int linker_add_common(struct bpf_linker *linker, struct src_obj *=
obj,
+			     const struct bpf_linker_file_opts *opts)
 {
-	struct src_obj obj =3D {};
 	int err =3D 0;
=20
 	if (!OPTS_VALID(opts, bpf_linker_file_opts))
@@ -448,25 +486,91 @@ int bpf_linker__add_file(struct bpf_linker *linker,=
 const char *filename,
 	if (!linker->elf)
 		return libbpf_err(-EINVAL);
=20
-	err =3D err ?: linker_load_obj_file(linker, filename, opts, &obj);
-	err =3D err ?: linker_append_sec_data(linker, &obj);
-	err =3D err ?: linker_append_elf_syms(linker, &obj);
-	err =3D err ?: linker_append_elf_relos(linker, &obj);
-	err =3D err ?: linker_append_btf(linker, &obj);
-	err =3D err ?: linker_append_btf_ext(linker, &obj);
+	err =3D err ?: linker_load_obj_file(linker, opts, obj);
+	err =3D err ?: linker_append_sec_data(linker, obj);
+	err =3D err ?: linker_append_elf_syms(linker, obj);
+	err =3D err ?: linker_append_elf_relos(linker, obj);
+	err =3D err ?: linker_append_btf(linker, obj);
+	err =3D err ?: linker_append_btf_ext(linker, obj);
=20
 	/* free up src_obj resources */
-	free(obj.btf_type_map);
-	btf__free(obj.btf);
-	btf_ext__free(obj.btf_ext);
-	free(obj.secs);
-	free(obj.sym_map);
-	if (obj.elf)
-		elf_end(obj.elf);
+	free(obj->btf_type_map);
+	btf__free(obj->btf);
+	btf_ext__free(obj->btf_ext);
+	free(obj->secs);
+	free(obj->sym_map);
+	if (obj->elf)
+		elf_end(obj->elf);
+	/* leave obj->fd for the caller to clean up if appropriate */
+
+	return libbpf_err(err);
+}
+
+int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
+			 const struct bpf_linker_file_opts *opts)
+{
+	struct src_obj obj =3D {};
+	int ret;
+
+	obj.filename =3D filename;
+	obj.fd =3D open(filename, O_RDONLY | O_CLOEXEC);
+	if (obj.fd < 0) {
+		pr_warn("failed to open file '%s': %s\n", filename, errstr(errno));
+		return -errno;
+	}
+
+	ret =3D linker_add_common(linker, &obj, opts);
+
 	if (obj.fd >=3D 0)
 		close(obj.fd);
=20
-	return libbpf_err(err);
+	return ret;
+}
+
+int bpf_linker__add_fd(struct bpf_linker *linker, const char *name, int =
fd,
+		       const struct bpf_linker_file_opts *opts)
+{
+	struct src_obj obj =3D {};
+
+	if (fd < 0)
+		return libbpf_err(-EINVAL);
+
+	obj.filename =3D name;
+	obj.fd =3D fd;
+
+	return linker_add_common(linker, &obj, opts);
+}
+
+int bpf_linker__add_buf(struct bpf_linker *linker, const char *name,
+			void *buffer, int buffer_sz,
+			const struct bpf_linker_file_opts *opts)
+{
+	struct src_obj obj =3D {};
+	int written, ret;
+
+	obj.filename =3D name;
+	obj.fd =3D memfd_create(name, 0);
+	if (obj.fd < 0) {
+		pr_warn("failed to create memfd '%s': %s\n", name, errstr(errno));
+		return -errno;
+	}
+
+	written =3D 0;
+	while (written < buffer_sz) {
+		ret =3D write(obj.fd, buffer, buffer_sz);
+		if (ret < 0) {
+			pr_warn("failed to write '%s': %s\n", name, errstr(errno));
+			return -errno;
+		}
+		written +=3D ret;
+	}
+
+	ret =3D linker_add_common(linker, &obj, opts);
+
+	if (obj.fd >=3D 0)
+		close(obj.fd);
+
+	return ret;
 }
=20
 static bool is_dwarf_sec_name(const char *name)
@@ -534,7 +638,7 @@ static struct src_sec *add_src_sec(struct src_obj *ob=
j, const char *sec_name)
 	return sec;
 }
=20
-static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
+static int linker_load_obj_file(struct bpf_linker *linker,
 				const struct bpf_linker_file_opts *opts,
 				struct src_obj *obj)
 {
@@ -554,20 +658,12 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
 #error "Unknown __BYTE_ORDER__"
 #endif
=20
-	pr_debug("linker: adding object file '%s'...\n", filename);
-
-	obj->filename =3D filename;
+	pr_debug("linker: adding object file '%s'...\n", obj->filename);
=20
-	obj->fd =3D open(filename, O_RDONLY | O_CLOEXEC);
-	if (obj->fd < 0) {
-		err =3D -errno;
-		pr_warn("failed to open file '%s': %s\n", filename, errstr(err));
-		return err;
-	}
 	obj->elf =3D elf_begin(obj->fd, ELF_C_READ_MMAP, NULL);
 	if (!obj->elf) {
 		err =3D -errno;
-		pr_warn_elf("failed to parse ELF file '%s'", filename);
+		pr_warn_elf("failed to parse ELF file '%s'", obj->filename);
 		return err;
 	}
=20
@@ -575,7 +671,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 	ehdr =3D elf64_getehdr(obj->elf);
 	if (!ehdr) {
 		err =3D -errno;
-		pr_warn_elf("failed to get ELF header for %s", filename);
+		pr_warn_elf("failed to get ELF header for %s", obj->filename);
 		return err;
 	}
=20
@@ -583,7 +679,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 	obj_byteorder =3D ehdr->e_ident[EI_DATA];
 	if (obj_byteorder !=3D ELFDATA2LSB && obj_byteorder !=3D ELFDATA2MSB) {
 		err =3D -EOPNOTSUPP;
-		pr_warn("unknown byte order of ELF file %s\n", filename);
+		pr_warn("unknown byte order of ELF file %s\n", obj->filename);
 		return err;
 	}
 	if (link_byteorder =3D=3D ELFDATANONE) {
@@ -593,7 +689,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 			 obj_byteorder =3D=3D ELFDATA2MSB ? "big" : "little");
 	} else if (link_byteorder !=3D obj_byteorder) {
 		err =3D -EOPNOTSUPP;
-		pr_warn("byte order mismatch with ELF file %s\n", filename);
+		pr_warn("byte order mismatch with ELF file %s\n", obj->filename);
 		return err;
 	}
=20
@@ -601,13 +697,13 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
 	    || ehdr->e_machine !=3D EM_BPF
 	    || ehdr->e_ident[EI_CLASS] !=3D ELFCLASS64) {
 		err =3D -EOPNOTSUPP;
-		pr_warn_elf("unsupported kind of ELF file %s", filename);
+		pr_warn_elf("unsupported kind of ELF file %s", obj->filename);
 		return err;
 	}
=20
 	if (elf_getshdrstrndx(obj->elf, &obj->shstrs_sec_idx)) {
 		err =3D -errno;
-		pr_warn_elf("failed to get SHSTRTAB section index for %s", filename);
+		pr_warn_elf("failed to get SHSTRTAB section index for %s", obj->filena=
me);
 		return err;
 	}
=20
@@ -620,7 +716,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 		if (!shdr) {
 			err =3D -errno;
 			pr_warn_elf("failed to get section #%zu header for %s",
-				    sec_idx, filename);
+				    sec_idx, obj->filename);
 			return err;
 		}
=20
@@ -628,7 +724,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 		if (!sec_name) {
 			err =3D -errno;
 			pr_warn_elf("failed to get section #%zu name for %s",
-				    sec_idx, filename);
+				    sec_idx, obj->filename);
 			return err;
 		}
=20
@@ -636,7 +732,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 		if (!data) {
 			err =3D -errno;
 			pr_warn_elf("failed to get section #%zu (%s) data from %s",
-				    sec_idx, sec_name, filename);
+				    sec_idx, sec_name, obj->filename);
 			return err;
 		}
=20
@@ -672,7 +768,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 				err =3D libbpf_get_error(obj->btf);
 				if (err) {
 					pr_warn("failed to parse .BTF from %s: %s\n",
-						filename, errstr(err));
+						obj->filename, errstr(err));
 					return err;
 				}
 				sec->skipped =3D true;
@@ -683,7 +779,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 				err =3D libbpf_get_error(obj->btf_ext);
 				if (err) {
 					pr_warn("failed to parse .BTF.ext from '%s': %s\n",
-						filename, errstr(err));
+						obj->filename, errstr(err));
 					return err;
 				}
 				sec->skipped =3D true;
@@ -700,7 +796,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 			break;
 		default:
 			pr_warn("unrecognized section #%zu (%s) in %s\n",
-				sec_idx, sec_name, filename);
+				sec_idx, sec_name, obj->filename);
 			err =3D -EINVAL;
 			return err;
 		}
@@ -2634,7 +2730,7 @@ static int linker_append_btf_ext(struct bpf_linker =
*linker, struct src_obj *obj)
 	return 0;
 }
=20
-int bpf_linker__finalize(struct bpf_linker *linker)
+int linker_finalize_common(struct bpf_linker *linker)
 {
 	struct dst_sec *sec;
 	size_t strs_sz;
@@ -2693,9 +2789,28 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
 	}
=20
 	elf_end(linker->elf);
+	linker->elf =3D NULL;
+
+	/* leave linker->fd for the caller to close if appropriate */
+
+	return 0;
+}
+
+int bpf_linker__finalize(struct bpf_linker *linker)
+{
+	linker_finalize_common(linker);
+
 	close(linker->fd);
+	linker->fd =3D -1;
=20
-	linker->elf =3D NULL;
+	return 0;
+}
+
+int bpf_linker__finalize_fd(struct bpf_linker *linker)
+{
+	linker_finalize_common(linker);
+
+	/* linker->fd was opened by the caller, so do not close it here */
 	linker->fd =3D -1;
=20
 	return 0;
--=20
2.43.5


