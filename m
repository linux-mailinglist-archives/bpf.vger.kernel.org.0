Return-Path: <bpf+bounces-46646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575109ED246
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BA1888AA6
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0D1DDC1B;
	Wed, 11 Dec 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KkEJCqSw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9301DDC28
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935254; cv=none; b=MBkXCNYUJ8YxbHuA8lBtHTh7CC3XHqu5reLPc8jDJvzN5WygEFR2BO7WGuJS9Ihz+ikveRgDW1l4j85Ww6vU/AIV5/dqHee1XSJ4Vh7fSOLs9Kbfxhr1xZAwAfxCG9WuGtCDbsRju2Mm+lGDAETs08yPSmiKyZonxFLAs31FwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935254; c=relaxed/simple;
	bh=UGqooN44QP0yvvkU4awbg/Jj59nn91kEbkUTd45bC84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttQJ5mJjyhPsNFNZpGWnyYCO+U3jRcIYBuWwKE1GOj4a5MCxOjSh2MQJU+cKAcG8gnOIdCweQLRk3rrD6zR669wKYWwt9Z9DuyJmjATiNfyU96gQWqwkATacEabqASDfPVw8YdJEiKopT6/YDP7F3daMfFv2NXnVI5Mqe/DXF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KkEJCqSw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFIXWm018110
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:40:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=FPQF7Blv516U2c3K8sanMxY+nhDtcUr4bdRsbNq78BQ=; b=KkEJCqSwPfq/
	UfJ2nn7URqULqHvfi1sCbUV+qdt7sv1NJu461OGPz15uICOG66x4D95ahXQGG4Dy
	Hwp16yRmTVqRWMVP4a4KoUfFdMPe8rcX1eD5ts1XBPRPAWKLnfZo0olfRBaa3xU1
	bbfaBiVY75zMa045uQH/us+h/e83YMsCvxgoAGQWQxpIH4DYu43k9CEaCgxsdatX
	ucZ/CzNGDwMtoZ0CnqTHK3ioUZXeISzlVnELsGM/Cpzpl2zlQCt4c+LFnKSfelY/
	dagV26AzTNC9p6115kVdyeudqFo/1/fFxNWcpTsS1+/QuzR9YSY9h6tZoR2xFibR
	XH2yYPiTpQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43fcews3u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:40:50 -0800 (PST)
Received: from twshared7122.08.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 16:40:46 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id 6F950D41CD37; Wed, 11 Dec 2024 08:40:36 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next v3 1/2] libbpf: Pull file-opening logic up to top-level functions
Date: Wed, 11 Dec 2024 08:40:29 -0800
Message-ID: <20241211164030.573042-2-ajor@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211164030.573042-1-ajor@meta.com>
References: <20241211164030.573042-1-ajor@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zMu9xxXD3TducOHdBBVO4KvjX6iSRcuk
X-Proofpoint-ORIG-GUID: zMu9xxXD3TducOHdBBVO4KvjX6iSRcuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Move the filename arguments and file-descriptor handling from
init_output_elf() and linker_load_obj_file() and instead handle them
at the top-level in bpf_linker__new() and bpf_linker__add_file().

This will allow the inner functions to be shared with a new,
non-filename-based, API in the next commit.

Signed-off-by: Alastair Robertson <ajor@meta.com>
---
 tools/lib/bpf/linker.c | 83 +++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index e56ba6e67451..eb2ac7afce01 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -157,10 +157,9 @@ struct bpf_linker {
 #define pr_warn_elf(fmt, ...)									\
 	libbpf_print(LIBBPF_WARN, "libbpf: " fmt ": %s\n", ##__VA_ARGS__, elf_e=
rrmsg(-1))
=20
-static int init_output_elf(struct bpf_linker *linker, const char *file);
+static int init_output_elf(struct bpf_linker *linker);
=20
-static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
-				const struct bpf_linker_file_opts *opts,
+static int linker_load_obj_file(struct bpf_linker *linker,
 				struct src_obj *obj);
 static int linker_sanity_check_elf(struct src_obj *obj);
 static int linker_sanity_check_elf_symtab(struct src_obj *obj, struct sr=
c_sec *sec);
@@ -233,9 +232,20 @@ struct bpf_linker *bpf_linker__new(const char *filen=
ame, struct bpf_linker_opts
 	if (!linker)
 		return errno =3D ENOMEM, NULL;
=20
-	linker->fd =3D -1;
+	linker->filename =3D strdup(filename);
+	if (!linker->filename) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
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
@@ -294,23 +304,12 @@ static Elf64_Sym *add_new_sym(struct bpf_linker *li=
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
@@ -440,7 +439,7 @@ int bpf_linker__add_file(struct bpf_linker *linker, c=
onst char *filename,
 			 const struct bpf_linker_file_opts *opts)
 {
 	struct src_obj obj =3D {};
-	int err =3D 0;
+	int err =3D 0, fd;
=20
 	if (!OPTS_VALID(opts, bpf_linker_file_opts))
 		return libbpf_err(-EINVAL);
@@ -448,7 +447,16 @@ int bpf_linker__add_file(struct bpf_linker *linker, =
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
+	obj.filename =3D filename;
+	obj.fd =3D fd;
+
+	err =3D err ?: linker_load_obj_file(linker, &obj);
 	err =3D err ?: linker_append_sec_data(linker, &obj);
 	err =3D err ?: linker_append_elf_syms(linker, &obj);
 	err =3D err ?: linker_append_elf_relos(linker, &obj);
@@ -534,8 +542,7 @@ static struct src_sec *add_src_sec(struct src_obj *ob=
j, const char *sec_name)
 	return sec;
 }
=20
-static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
-				const struct bpf_linker_file_opts *opts,
+static int linker_load_obj_file(struct bpf_linker *linker,
 				struct src_obj *obj)
 {
 	int err =3D 0;
@@ -554,26 +561,18 @@ static int linker_load_obj_file(struct bpf_linker *=
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
-		pr_warn_elf("failed to parse ELF file '%s'", filename);
+		pr_warn_elf("failed to parse ELF file '%s'", obj->filename);
 		return -EINVAL;
 	}
=20
 	/* Sanity check ELF file high-level properties */
 	ehdr =3D elf64_getehdr(obj->elf);
 	if (!ehdr) {
-		pr_warn_elf("failed to get ELF header for %s", filename);
+		pr_warn_elf("failed to get ELF header for %s", obj->filename);
 		return -EINVAL;
 	}
=20
@@ -581,7 +580,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 	obj_byteorder =3D ehdr->e_ident[EI_DATA];
 	if (obj_byteorder !=3D ELFDATA2LSB && obj_byteorder !=3D ELFDATA2MSB) {
 		err =3D -EOPNOTSUPP;
-		pr_warn("unknown byte order of ELF file %s\n", filename);
+		pr_warn("unknown byte order of ELF file %s\n", obj->filename);
 		return err;
 	}
 	if (link_byteorder =3D=3D ELFDATANONE) {
@@ -591,7 +590,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 			 obj_byteorder =3D=3D ELFDATA2MSB ? "big" : "little");
 	} else if (link_byteorder !=3D obj_byteorder) {
 		err =3D -EOPNOTSUPP;
-		pr_warn("byte order mismatch with ELF file %s\n", filename);
+		pr_warn("byte order mismatch with ELF file %s\n", obj->filename);
 		return err;
 	}
=20
@@ -599,12 +598,12 @@ static int linker_load_obj_file(struct bpf_linker *=
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
-		pr_warn_elf("failed to get SHSTRTAB section index for %s", filename);
+		pr_warn_elf("failed to get SHSTRTAB section index for %s", obj->filena=
me);
 		return -EINVAL;
 	}
=20
@@ -616,21 +615,21 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
 		shdr =3D elf64_getshdr(scn);
 		if (!shdr) {
 			pr_warn_elf("failed to get section #%zu header for %s",
-				    sec_idx, filename);
+				    sec_idx, obj->filename);
 			return -EINVAL;
 		}
=20
 		sec_name =3D elf_strptr(obj->elf, obj->shstrs_sec_idx, shdr->sh_name);
 		if (!sec_name) {
 			pr_warn_elf("failed to get section #%zu name for %s",
-				    sec_idx, filename);
+				    sec_idx, obj->filename);
 			return -EINVAL;
 		}
=20
 		data =3D elf_getdata(scn, 0);
 		if (!data) {
 			pr_warn_elf("failed to get section #%zu (%s) data from %s",
-				    sec_idx, sec_name, filename);
+				    sec_idx, sec_name, obj->filename);
 			return -EINVAL;
 		}
=20
@@ -666,7 +665,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 				err =3D libbpf_get_error(obj->btf);
 				if (err) {
 					pr_warn("failed to parse .BTF from %s: %s\n",
-						filename, errstr(err));
+						obj->filename, errstr(err));
 					return err;
 				}
 				sec->skipped =3D true;
@@ -677,7 +676,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
 				err =3D libbpf_get_error(obj->btf_ext);
 				if (err) {
 					pr_warn("failed to parse .BTF.ext from '%s': %s\n",
-						filename, errstr(err));
+						obj->filename, errstr(err));
 					return err;
 				}
 				sec->skipped =3D true;
@@ -694,7 +693,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
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


