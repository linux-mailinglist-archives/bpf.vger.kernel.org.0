Return-Path: <bpf+bounces-46079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7479E3F58
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABF4284A22
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FD520B816;
	Wed,  4 Dec 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jrWKOl5T"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DC13D26B
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328679; cv=none; b=kVzbHQESPsTBgdouu5PFCg0iZn8l85JFPGyUd/2IL5fcc9+dhLUuoEbkqnR2GIDDdzPuP5LihZohILtjdIL1GefSaEhmnVgCE1J5ZaMkYlvW1Ur7YM+GCvdcEwfep85LHo2U23SgYsmDG43UN2Q/kfBrvIvucHlUwttfrFDZzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328679; c=relaxed/simple;
	bh=z80VRYgndEKeLr3K9zSqZuuTQGon81YTRmmGH/COD9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkiMw1EnoAYiXw5JqEAVj7y4LDaRMkvtgNTtJM8xeEVOD340xF+k58AsSfPy88ApWJwULQDmPp/vdUuiVlXjVnmyNCCnAET3LechGNrM5LINl3z3xlhj6/Wg/XSew+BPzQ7XsB5dHpG7RWqx+lhVes7IyoQKoLyH6OF7X+nYi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jrWKOl5T; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FhVmn021556
	for <bpf@vger.kernel.org>; Wed, 4 Dec 2024 08:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=6d0OVtQh8PAwFlCoDroKJbcIssZqCjG9PHG/9g1vSLw=; b=jrWKOl5TpJ77
	aGaelM348TGNpQeSFjuE5fNTUi1d7Kb4vUZy9NYE5ZNOhOyrZwY57f/MPeOLRKej
	fPgWKCqESeJDXSJwxEf/Bwq3/hfwgJsfL1gFvSjSxV4M0O9/UjaY8v8+gJVN29Ia
	5E6e8QhzWUn/d2zWOuNkZB+271Cz3nhPVxXPKFEFtwnMYFPgB3TDVF6hj3yvN8/e
	2Dv4i24SD34ino9AkeQ3eHSV3kXhdZbIq+DJwcxxDe+WqgiIdDCH/OS1kqLGGMsO
	4Vo4TyWtLya8KCRdAc1sqKKocPh9EB2ejtKP+PJ2VYiOJlXQp3Fzi+KMfrHKgR0+
	WIx/qd1DGg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43arn88vvu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 08:11:16 -0800 (PST)
Received: from twshared60378.16.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Dec 2024 16:11:14 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id E29BAD0936A8; Wed,  4 Dec 2024 08:11:09 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: Pull file-opening logic up to top-level functions
Date: Wed, 4 Dec 2024 08:11:00 -0800
Message-ID: <20241204161101.1148347-2-ajor@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204161101.1148347-1-ajor@meta.com>
References: <20241204161101.1148347-1-ajor@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: J_es5jQiri3o3FvbGDNYE78KNm-CpLeQ
X-Proofpoint-GUID: J_es5jQiri3o3FvbGDNYE78KNm-CpLeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

Move the filename arguments and file-descriptor handling from
init_output_elf() and linker_load_obj_file() and instead handle them
at the top-level in bpf_linker__new() and bpf_linker__add_file().

This will allow the inner functions to be shared with a new,
non-filename-based, API in the next commit.

Signed-off-by: Alastair Robertson <ajor@meta.com>
---
 tools/lib/bpf/linker.c | 78 ++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index cf71d149fe26..375896a94e6a 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -157,9 +157,9 @@ struct bpf_linker {
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
@@ -233,9 +233,18 @@ struct bpf_linker *bpf_linker__new(const char *filen=
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
=20
-	err =3D init_output_elf(linker, filename);
+	err =3D init_output_elf(linker);
 	if (err)
 		goto err_out;
=20
@@ -294,23 +303,12 @@ static Elf64_Sym *add_new_sym(struct bpf_linker *li=
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
@@ -440,7 +438,7 @@ int bpf_linker__add_file(struct bpf_linker *linker, c=
onst char *filename,
 			 const struct bpf_linker_file_opts *opts)
 {
 	struct src_obj obj =3D {};
-	int err =3D 0;
+	int err =3D 0, fd;
=20
 	if (!OPTS_VALID(opts, bpf_linker_file_opts))
 		return libbpf_err(-EINVAL);
@@ -448,7 +446,15 @@ int bpf_linker__add_file(struct bpf_linker *linker, =
const char *filename,
 	if (!linker->elf)
 		return libbpf_err(-EINVAL);
=20
-	err =3D err ?: linker_load_obj_file(linker, filename, opts, &obj);
+	fd =3D open(filename, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		pr_warn("failed to open file '%s': %s\n", filename, errstr(errno));
+		return -errno;
+	}
+
+	obj.fd =3D fd;
+
+	err =3D err ?: linker_load_obj_file(linker, opts, &obj);
 	err =3D err ?: linker_append_sec_data(linker, &obj);
 	err =3D err ?: linker_append_elf_syms(linker, &obj);
 	err =3D err ?: linker_append_elf_relos(linker, &obj);
@@ -534,7 +540,7 @@ static struct src_sec *add_src_sec(struct src_obj *ob=
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
@@ -554,20 +560,12 @@ static int linker_load_obj_file(struct bpf_linker *=
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
@@ -575,7 +573,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 	ehdr =3D elf64_getehdr(obj->elf);
 	if (!ehdr) {
 		err =3D -errno;
-		pr_warn_elf("failed to get ELF header for %s", filename);
+		pr_warn_elf("failed to get ELF header for %s", obj->filename);
 		return err;
 	}
=20
@@ -583,7 +581,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 	obj_byteorder =3D ehdr->e_ident[EI_DATA];
 	if (obj_byteorder !=3D ELFDATA2LSB && obj_byteorder !=3D ELFDATA2MSB) {
 		err =3D -EOPNOTSUPP;
-		pr_warn("unknown byte order of ELF file %s\n", filename);
+		pr_warn("unknown byte order of ELF file %s\n", obj->filename);
 		return err;
 	}
 	if (link_byteorder =3D=3D ELFDATANONE) {
@@ -593,7 +591,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 			 obj_byteorder =3D=3D ELFDATA2MSB ? "big" : "little");
 	} else if (link_byteorder !=3D obj_byteorder) {
 		err =3D -EOPNOTSUPP;
-		pr_warn("byte order mismatch with ELF file %s\n", filename);
+		pr_warn("byte order mismatch with ELF file %s\n", obj->filename);
 		return err;
 	}
=20
@@ -601,13 +599,13 @@ static int linker_load_obj_file(struct bpf_linker *=
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
@@ -620,7 +618,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 		if (!shdr) {
 			err =3D -errno;
 			pr_warn_elf("failed to get section #%zu header for %s",
-				    sec_idx, filename);
+				    sec_idx, obj->filename);
 			return err;
 		}
=20
@@ -628,7 +626,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 		if (!sec_name) {
 			err =3D -errno;
 			pr_warn_elf("failed to get section #%zu name for %s",
-				    sec_idx, filename);
+				    sec_idx, obj->filename);
 			return err;
 		}
=20
@@ -636,7 +634,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 		if (!data) {
 			err =3D -errno;
 			pr_warn_elf("failed to get section #%zu (%s) data from %s",
-				    sec_idx, sec_name, filename);
+				    sec_idx, sec_name, obj->filename);
 			return err;
 		}
=20
@@ -672,7 +670,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 				err =3D libbpf_get_error(obj->btf);
 				if (err) {
 					pr_warn("failed to parse .BTF from %s: %s\n",
-						filename, errstr(err));
+						obj->filename, errstr(err));
 					return err;
 				}
 				sec->skipped =3D true;
@@ -683,7 +681,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 				err =3D libbpf_get_error(obj->btf_ext);
 				if (err) {
 					pr_warn("failed to parse .BTF.ext from '%s': %s\n",
-						filename, errstr(err));
+						obj->filename, errstr(err));
 					return err;
 				}
 				sec->skipped =3D true;
@@ -700,7 +698,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 			break;
 		default:
 			pr_warn("unrecognized section #%zu (%s) in %s\n",
-				sec_idx, sec_name, filename);
+				sec_idx, sec_name, obj->filename);
 			err =3D -EINVAL;
 			return err;
 		}
--=20
2.43.5


