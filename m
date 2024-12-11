Return-Path: <bpf+bounces-46645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC69ED245
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ABF16572F
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7D1DDC22;
	Wed, 11 Dec 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BfpQYlfe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99231DDA3C
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935251; cv=none; b=rtPdCr4EaMZMUnXqjT+OKgk3qWlPlBWcj6oSFPss6IRFEVrGQoK6FgjcJB+6A9KybDlrsAVm5Do2CQY2ROh/8k8jawn/cSduDNW7xuyYPccHFNl6Ka/eEzx28zgQgRoZJQ6gksCtzVRnJwFaK1XGYhKV6tYp9BUeW1omJ8+gkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935251; c=relaxed/simple;
	bh=rC4zj3vKjA3T+/EjqKFl0/tv6GDcOBHnvtIcqIZbCDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncQvFKrXvUgQmbK9XDXMU8hadj8BlnrRkNIyOs/v/v9oGghHruwT3WloGj0FHfD5K9oVgK6oysHesZ3lFQlsgyiwd9a9CYH7EFxiK5bxqaCOf5Oo7lYfv7vY4+YL59qlS01uPYAJL11U3dU3PpBe4HJ5ZvZsI1fW9Ijj8/V9htA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BfpQYlfe; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFHmAK020765
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:40:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=xbiln5nukbNSyX4ieHJty83yMy3mz8c3CgwYDlIEeno=; b=BfpQYlfemsal
	XIEBs8f73Px8Zy6qPcKtVwAI5hw8Xx7vr3SM3Hr6uXYDgWPriowOXIVlBWB4Q4Wp
	VtWZhhHzo0dq9uP8WaXkGhWb48jQGN6cI6zDgUEeMQMHu3A+cb35b6JJj8d3YDAB
	RwdehkUEo+Y8duKruHcqMA7t5DFkNxKxjNtMqGIxUr9+xrqX5wXYCEicS5uVqyJT
	fiKgzRhVkTnSYpHsyhPy4pN4ojqU/uZaxASZjOqDKcxs4uY+UdoP3DNnL0XAwFEI
	kPAsFQ6kvYUiWblZA/R0La4s3gCBJuZjk2UtuQWWT7hUfkNtZ0HbFwV+bAcbHjOk
	9cd4ZY/Tgw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43fbt59cma-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:40:48 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 16:40:46 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id 1878BD41CD3D; Wed, 11 Dec 2024 08:40:37 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next v3 2/2] libbpf: Extend linker API to support in-memory ELF files
Date: Wed, 11 Dec 2024 08:40:30 -0800
Message-ID: <20241211164030.573042-3-ajor@meta.com>
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
X-Proofpoint-GUID: LSm3aWiBd4VVbyVj4vYbRsrxgN-zwP6T
X-Proofpoint-ORIG-GUID: LSm3aWiBd4VVbyVj4vYbRsrxgN-zwP6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The new_fd and add_fd functions correspond to the original new and
add_file functions, but accept an FD instead of a file name. This
gives API consumers the option of using anonymous files/memfds to
avoid writing ELFs to disk.

This new API will be useful for performing linking as part of
bpftrace's JIT compilation.

The add_buf function is a convenience wrapper that does the work of
creating a memfd for the caller.

Signed-off-by: Alastair Robertson <ajor@meta.com>
---
 tools/lib/bpf/libbpf.h   |   5 ++
 tools/lib/bpf/libbpf.map |   4 +
 tools/lib/bpf/linker.c   | 163 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 152 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b2ce3a72b11d..d45807103565 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1796,9 +1796,14 @@ struct bpf_linker_file_opts {
 struct bpf_linker;
=20
 LIBBPF_API struct bpf_linker *bpf_linker__new(const char *filename, stru=
ct bpf_linker_opts *opts);
+LIBBPF_API struct bpf_linker *bpf_linker__new_fd(int fd, struct bpf_link=
er_opts *opts);
 LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
 				    const char *filename,
 				    const struct bpf_linker_file_opts *opts);
+LIBBPF_API int bpf_linker__add_fd(struct bpf_linker *linker, int fd,
+				  const struct bpf_linker_file_opts *opts);
+LIBBPF_API int bpf_linker__add_buf(struct bpf_linker *linker, void *buf,=
 size_t buf_sz,
+				   const struct bpf_linker_file_opts *opts);
 LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
 LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
=20
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 54b6f312cfa8..a8b2936a1646 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -432,4 +432,8 @@ LIBBPF_1.5.0 {
 } LIBBPF_1.4.0;
=20
 LIBBPF_1.6.0 {
+	global:
+		bpf_linker__add_buf;
+		bpf_linker__add_fd;
+		bpf_linker__new_fd;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index eb2ac7afce01..6b3b86d98f6c 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -4,6 +4,10 @@
  *
  * Copyright (c) 2021 Facebook
  */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -16,6 +20,7 @@
 #include <elf.h>
 #include <libelf.h>
 #include <fcntl.h>
+#include <sys/mman.h>
 #include "libbpf.h"
 #include "btf.h"
 #include "libbpf_internal.h"
@@ -152,6 +157,8 @@ struct bpf_linker {
 	/* global (including extern) ELF symbols */
 	int glob_sym_cnt;
 	struct glob_sym *glob_syms;
+
+	bool fd_is_owned;
 };
=20
 #define pr_warn_elf(fmt, ...)									\
@@ -159,6 +166,9 @@ struct bpf_linker {
=20
 static int init_output_elf(struct bpf_linker *linker);
=20
+static int bpf_linker_add_file(struct bpf_linker *linker, int fd,
+			       const char *filename);
+
 static int linker_load_obj_file(struct bpf_linker *linker,
 				struct src_obj *obj);
 static int linker_sanity_check_elf(struct src_obj *obj);
@@ -190,7 +200,7 @@ void bpf_linker__free(struct bpf_linker *linker)
 	if (linker->elf)
 		elf_end(linker->elf);
=20
-	if (linker->fd >=3D 0)
+	if (linker->fd >=3D 0 && linker->fd_is_owned)
 		close(linker->fd);
=20
 	strset__free(linker->strtab_strs);
@@ -244,6 +254,49 @@ struct bpf_linker *bpf_linker__new(const char *filen=
ame, struct bpf_linker_opts
 		pr_warn("failed to create '%s': %d\n", filename, err);
 		goto err_out;
 	}
+	linker->fd_is_owned =3D true;
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
+struct bpf_linker *bpf_linker__new_fd(int fd, struct bpf_linker_opts *op=
ts)
+{
+	struct bpf_linker *linker;
+	char filename[32];
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
+	snprintf(filename, sizeof(filename), "fd:%d", fd);
+	linker->filename =3D strdup(filename);
+	if (!linker->filename) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
+
+	linker->fd =3D fd;
+	linker->fd_is_owned =3D false;
=20
 	err =3D init_output_elf(linker);
 	if (err)
@@ -435,23 +488,11 @@ static int init_output_elf(struct bpf_linker *linke=
r)
 	return 0;
 }
=20
-int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
-			 const struct bpf_linker_file_opts *opts)
+static int bpf_linker_add_file(struct bpf_linker *linker, int fd,
+			       const char *filename)
 {
 	struct src_obj obj =3D {};
-	int err =3D 0, fd;
-
-	if (!OPTS_VALID(opts, bpf_linker_file_opts))
-		return libbpf_err(-EINVAL);
-
-	if (!linker->elf)
-		return libbpf_err(-EINVAL);
-
-	fd =3D open(filename, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		pr_warn("failed to open file '%s': %s\n", filename, errstr(errno));
-		return -errno;
-	}
+	int err =3D 0;
=20
 	obj.filename =3D filename;
 	obj.fd =3D fd;
@@ -471,12 +512,93 @@ int bpf_linker__add_file(struct bpf_linker *linker,=
 const char *filename,
 	free(obj.sym_map);
 	if (obj.elf)
 		elf_end(obj.elf);
-	if (obj.fd >=3D 0)
-		close(obj.fd);
=20
 	return libbpf_err(err);
 }
=20
+int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
+			 const struct bpf_linker_file_opts *opts)
+{
+	int fd, ret;
+
+	if (!OPTS_VALID(opts, bpf_linker_file_opts))
+		return libbpf_err(-EINVAL);
+
+	if (!linker->elf)
+		return libbpf_err(-EINVAL);
+
+	fd =3D open(filename, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		pr_warn("failed to open file '%s': %s\n", filename, errstr(errno));
+		return -errno;
+	}
+
+	ret =3D bpf_linker_add_file(linker, fd, filename);
+
+	close(fd);
+
+	return ret;
+}
+
+int bpf_linker__add_fd(struct bpf_linker *linker, int fd,
+		       const struct bpf_linker_file_opts *opts)
+{
+	char filename[32];
+	int ret;
+
+	if (!OPTS_VALID(opts, bpf_linker_file_opts))
+		return libbpf_err(-EINVAL);
+
+	if (!linker->elf)
+		return libbpf_err(-EINVAL);
+
+	if (fd < 0)
+		return libbpf_err(-EINVAL);
+
+	snprintf(filename, sizeof(filename), "fd:%d", fd);
+
+	ret =3D bpf_linker_add_file(linker, fd, filename);
+
+	return ret;
+}
+
+int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf=
_sz,
+			const struct bpf_linker_file_opts *opts)
+{
+	char filename[32];
+	int fd, written, ret;
+
+	if (!OPTS_VALID(opts, bpf_linker_file_opts))
+		return libbpf_err(-EINVAL);
+
+	if (!linker->elf)
+		return libbpf_err(-EINVAL);
+
+	snprintf(filename, sizeof(filename), "mem:%p+%zu", buf, buf_sz);
+
+	fd =3D memfd_create(filename, 0);
+	if (fd < 0) {
+		pr_warn("failed to create memfd '%s': %s\n", filename, errstr(errno));
+		return -errno;
+	}
+
+	written =3D 0;
+	while (written < buf_sz) {
+		ret =3D write(fd, buf, buf_sz);
+		if (ret < 0) {
+			pr_warn("failed to write '%s': %s\n", filename, errstr(errno));
+			return -errno;
+		}
+		written +=3D ret;
+	}
+
+	ret =3D bpf_linker_add_file(linker, fd, filename);
+
+	close(fd);
+
+	return ret;
+}
+
 static bool is_dwarf_sec_name(const char *name)
 {
 	/* approximation, but the actual list is too long */
@@ -2686,9 +2808,10 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
 	}
=20
 	elf_end(linker->elf);
-	close(linker->fd);
-
 	linker->elf =3D NULL;
+
+	if (linker->fd_is_owned)
+		close(linker->fd);
 	linker->fd =3D -1;
=20
 	return 0;
--=20
2.43.5


