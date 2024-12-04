Return-Path: <bpf+bounces-46080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6969E3F65
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0506E168650
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766520D4FE;
	Wed,  4 Dec 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="llOipfrm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7F1FAC30
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328680; cv=none; b=SLsT0t6Kxq082ghf7DXAj2+fqHC4tPKQc61UX/CwQvEG+LzJWNrEUMGNyxE0YhLJqXt+aZKfysz8em3wWmdUoRE4XatSCNqVNWbI3vpJCWZNz1DhkG2askXHLFyLxVUA/B0fWOI/kqTzxiy/vvvg2QeLyLR8lckN/T7QqkwXrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328680; c=relaxed/simple;
	bh=dYWNvjmaRU6Pkv0pUU9fqkio/70ug9AOP9DXpRXNDmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxqupNQACkj7uvbMvo5uLw6qXZ/h3DO8sXemz5G3ApVv9Z8CLd5+A/nwJLn+O/cAvUDj7dCOZJLSDaXMGTEjzh6HXHszGro5k2UU0T53W211eBI/HmwqwVpVOhIu1ZAT0E4EO2F5q9f5mxMS2EmjFHsgH9yg7Q7VBRNOPQMnykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=llOipfrm; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FhVLD021577
	for <bpf@vger.kernel.org>; Wed, 4 Dec 2024 08:11:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ghwSe1tG53xAwMqfd/KsGuTRg4d9TgssLwxBUWsEypw=; b=llOipfrm51M4
	1V1Q/moQVot6A5IPYQCkjvgJY+Ke1qjLpH5I42vLfg+J806N35zs0Sa8b27QCu6r
	FQmCqIE8uPy3RTg//YedDUt5Wq140sCSu4Alruo2AzkYplVTSzDEZ0ysaqDFj0K3
	E3mXn8oRjJ/pQ78jtuFMWlAi/n//D6WSugEFbx7R128zOwj8mxVCKTHZxwaEme8g
	XukNtAUknW8Vlb2JcZJ4+CQ/PvRoS275taG5Rfhld0xgkJxVHUlFdGrdCfn0qIOs
	puMI+jdIgoFo4mfoj+3encwrel0aIiq10K/zZ/CJKxvjhMfCm0cePwqmWCA4lzM4
	VnGR8d4wnQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43arn88vvx-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 08:11:17 -0800 (PST)
Received: from twshared7122.08.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Dec 2024 16:11:16 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id 783B4D0936C6; Wed,  4 Dec 2024 08:11:14 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next v2 2/2] libbpf: Extend linker API to support in-memory ELF files
Date: Wed, 4 Dec 2024 08:11:01 -0800
Message-ID: <20241204161101.1148347-3-ajor@meta.com>
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
X-Proofpoint-ORIG-GUID: r0Q_-AMtyrMXrhnelz_TnyiZ0901r5q6
X-Proofpoint-GUID: r0Q_-AMtyrMXrhnelz_TnyiZ0901r5q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

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
 tools/lib/bpf/libbpf.h   |  12 +++-
 tools/lib/bpf/libbpf.map |   3 +
 tools/lib/bpf/linker.c   | 143 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 145 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b2ce3a72b11d..7a88830a3431 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1784,21 +1784,29 @@ enum libbpf_tristate {
 struct bpf_linker_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
+	const char *filename;
 };
-#define bpf_linker_opts__last_field sz
+#define bpf_linker_opts__last_field filename
=20
 struct bpf_linker_file_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
+	const char *filename;
 };
-#define bpf_linker_file_opts__last_field sz
+#define bpf_linker_file_opts__last_field filename
=20
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
+LIBBPF_API int bpf_linker__add_buf(struct bpf_linker *linker, const char=
 *name,
+				   void *buf, int buf_sz,
+				   const struct bpf_linker_file_opts *opts);
 LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
 LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
=20
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 54b6f312cfa8..23f2a30778f0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -432,4 +432,7 @@ LIBBPF_1.5.0 {
 } LIBBPF_1.4.0;
=20
 LIBBPF_1.6.0 {
+		bpf_linker__add_buf;
+		bpf_linker__add_fd;
+		bpf_linker__new_fd;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 375896a94e6a..fd98469fa20d 100644
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
@@ -243,6 +250,54 @@ struct bpf_linker *bpf_linker__new(const char *filen=
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
+#define LINKER_MAX_FD_NAME_SIZE 24
+
+struct bpf_linker *bpf_linker__new_fd(int fd, struct bpf_linker_opts *op=
ts)
+{
+	struct bpf_linker *linker;
+	const char *filename;
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
+	filename =3D OPTS_GET(opts, filename, NULL);
+	if (filename) {
+		linker->filename =3D strdup(filename);
+	} else {
+		linker->filename =3D malloc(LINKER_MAX_FD_NAME_SIZE);
+		if (!linker->filename)
+			return errno =3D ENOMEM, NULL;
+		snprintf(linker->filename, LINKER_MAX_FD_NAME_SIZE, "fd:%d", fd);
+	}
+
+	linker->fd =3D fd;
+	linker->fd_is_owned =3D false;
=20
 	err =3D init_output_elf(linker);
 	if (err)
@@ -435,16 +490,15 @@ static int init_output_elf(struct bpf_linker *linke=
r)
 }
=20
 int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
-			 const struct bpf_linker_file_opts *opts)
+			 const struct bpf_linker_file_opts *input_opts)
 {
-	struct src_obj obj =3D {};
-	int err =3D 0, fd;
+	int fd, ret;
=20
-	if (!OPTS_VALID(opts, bpf_linker_file_opts))
-		return libbpf_err(-EINVAL);
+	LIBBPF_OPTS(bpf_linker_file_opts, opts);
=20
-	if (!linker->elf)
-		return libbpf_err(-EINVAL);
+	if (input_opts)
+		opts =3D *input_opts;
+	opts.filename =3D filename;
=20
 	fd =3D open(filename, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
@@ -452,6 +506,37 @@ int bpf_linker__add_file(struct bpf_linker *linker, =
const char *filename,
 		return -errno;
 	}
=20
+	ret =3D bpf_linker__add_fd(linker, fd, &opts);
+
+	close(fd);
+
+	return ret;
+}
+
+int bpf_linker__add_fd(struct bpf_linker *linker, int fd,
+		       const struct bpf_linker_file_opts *opts)
+{
+	struct src_obj obj =3D {};
+	const char *filename;
+	char name[LINKER_MAX_FD_NAME_SIZE];
+	int err =3D 0;
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
+	filename =3D OPTS_GET(opts, filename, NULL);
+	if (filename) {
+		obj.filename =3D filename;
+	} else {
+		snprintf(name, sizeof(name), "fd:%d", fd);
+		obj.filename =3D name;
+	}
 	obj.fd =3D fd;
=20
 	err =3D err ?: linker_load_obj_file(linker, opts, &obj);
@@ -469,12 +554,47 @@ int bpf_linker__add_file(struct bpf_linker *linker,=
 const char *filename,
 	free(obj.sym_map);
 	if (obj.elf)
 		elf_end(obj.elf);
-	if (obj.fd >=3D 0)
-		close(obj.fd);
+	/* leave obj.fd for the caller to clean up if appropriate */
=20
 	return libbpf_err(err);
 }
=20
+int bpf_linker__add_buf(struct bpf_linker *linker, const char *name,
+			void *buf, int buf_sz,
+			const struct bpf_linker_file_opts *input_opts)
+{
+	int fd, written, ret;
+
+	LIBBPF_OPTS(bpf_linker_file_opts, opts);
+
+	if (input_opts)
+		opts =3D *input_opts;
+	opts.filename =3D name;
+
+	fd =3D memfd_create(name, 0);
+	if (fd < 0) {
+		pr_warn("failed to create memfd '%s': %s\n", name, errstr(errno));
+		return -errno;
+	}
+
+	written =3D 0;
+	while (written < buf_sz) {
+		ret =3D write(fd, buf, buf_sz);
+		if (ret < 0) {
+			pr_warn("failed to write '%s': %s\n", name, errstr(errno));
+			return -errno;
+		}
+		written +=3D ret;
+	}
+
+	ret =3D bpf_linker__add_fd(linker, fd, &opts);
+
+	if (fd >=3D 0)
+		close(fd);
+
+	return ret;
+}
+
 static bool is_dwarf_sec_name(const char *name)
 {
 	/* approximation, but the actual list is too long */
@@ -2691,9 +2811,10 @@ int bpf_linker__finalize(struct bpf_linker *linker=
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


