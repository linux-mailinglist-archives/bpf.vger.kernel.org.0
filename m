Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9812B27BC13
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 06:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI2EdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 00:33:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgI2EdS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 00:33:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T4U3ql029043
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+4kVC1jg2XR5Sgd0TaMs8yrcG7UzhwN5eXma3Hxny1U=;
 b=pAfUOZCrGHpa4UPb+L3AOLg6Z4+g7hNGBcKVdKPy4/0OGt7MZ9LdfZlO0d+W86FDRijz
 qTeB4paSAPYCSd5vUjFaNoIGvkqS79E/A6X6pO9HNe81g0iyMtsEhhIH67mTl/DrH1xC
 10iP+T23j+g6bETlrFBPq+bfk3HuOzO8v3k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33tn598hj5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:16 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 21:33:15 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5BA162EC774F; Mon, 28 Sep 2020 21:30:58 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH bpf-next 2/3] libbpf: support BTF loading and raw data output in both endianness
Date:   Mon, 28 Sep 2020 21:30:45 -0700
Message-ID: <20200929043046.1324350-3-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929043046.1324350-1-andriin@fb.com>
References: <20200929043046.1324350-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-28,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=25 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach BTF to recognized wrong endianness and transparently convert it
internally to host endianness. Original endianness of BTF will be preserv=
ed
and used during btf__get_raw_data() to convert resulting raw data to the =
same
endianness and a source raw_data. This means that little-endian host can =
parse
big-endian BTF with no issues, all the type data will be presented to the
client application in native endianness, but when it's time for emitting =
BTF
to persist it in a file (e.g., after BTF deduplication), original non-nat=
ive
endianness will be preserved and stored.

It's possible to query original endianness of BTF data with new
btf__endianness() API. It's also possible to override desired output
endianness with btf__set_endianness(), so that if application needs to lo=
ad,
say, big-endian BTF and store it as little-endian BTF, it's possible to
manually override this. If btf__set_endianness() was used to change
endianness, btf__endianness() will reflect overridden endianness.

Given there are no known use cases for supporting cross-endianness for
.BTF.ext, loading .BTF.ext in non-native endianness is not supported.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c      | 310 +++++++++++++++++++++++++++++++--------
 tools/lib/bpf/btf.h      |   7 +
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 255 insertions(+), 64 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c25f49fad5a6..e1dbd766c698 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2018 Facebook */
=20
+#include <byteswap.h>
 #include <endian.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -27,8 +28,13 @@
 static struct btf_type btf_void;
=20
 struct btf {
+	/* raw BTF data in native endianness */
 	void *raw_data;
+	/* raw BTF data in non-native endianness */
+	void *raw_data_swapped;
 	__u32 raw_size;
+	/* whether target endianness differs from the native one */
+	bool swapped_endian;
=20
 	/*
 	 * When BTF is loaded from an ELF or raw memory it is stored
@@ -153,9 +159,19 @@ static int btf_add_type_idx_entry(struct btf *btf, _=
_u32 type_off)
 	return 0;
 }
=20
+static void btf_bswap_hdr(struct btf_header *h)
+{
+	h->magic =3D bswap_16(h->magic);
+	h->hdr_len =3D bswap_32(h->hdr_len);
+	h->type_off =3D bswap_32(h->type_off);
+	h->type_len =3D bswap_32(h->type_len);
+	h->str_off =3D bswap_32(h->str_off);
+	h->str_len =3D bswap_32(h->str_len);
+}
+
 static int btf_parse_hdr(struct btf *btf)
 {
-	const struct btf_header *hdr =3D btf->hdr;
+	struct btf_header *hdr =3D btf->hdr;
 	__u32 meta_left;
=20
 	if (btf->raw_size < sizeof(struct btf_header)) {
@@ -163,21 +179,19 @@ static int btf_parse_hdr(struct btf *btf)
 		return -EINVAL;
 	}
=20
-	if (hdr->magic !=3D BTF_MAGIC) {
+	if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
+		btf->swapped_endian =3D true;
+		if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)) {
+			pr_warn("Can't load BTF with non-native endianness due to unsupported=
 header length %u\n",
+				bswap_32(hdr->hdr_len));
+			return -ENOTSUP;
+		}
+		btf_bswap_hdr(hdr);
+	} else if (hdr->magic !=3D BTF_MAGIC) {
 		pr_debug("Invalid BTF magic:%x\n", hdr->magic);
 		return -EINVAL;
 	}
=20
-	if (hdr->version !=3D BTF_VERSION) {
-		pr_debug("Unsupported BTF version:%u\n", hdr->version);
-		return -ENOTSUP;
-	}
-
-	if (hdr->flags) {
-		pr_debug("Unsupported BTF flags:%x\n", hdr->flags);
-		return -ENOTSUP;
-	}
-
 	meta_left =3D btf->raw_size - sizeof(*hdr);
 	if (!meta_left) {
 		pr_debug("BTF has no data\n");
@@ -224,7 +238,7 @@ static int btf_parse_str_sec(struct btf *btf)
=20
 static int btf_type_size(const struct btf_type *t)
 {
-	int base_size =3D sizeof(struct btf_type);
+	const int base_size =3D sizeof(struct btf_type);
 	__u16 vlen =3D btf_vlen(t);
=20
 	switch (btf_kind(t)) {
@@ -257,12 +271,83 @@ static int btf_type_size(const struct btf_type *t)
 	}
 }
=20
+static void btf_bswap_type_base(struct btf_type *t)
+{
+	t->name_off =3D bswap_32(t->name_off);
+	t->info =3D bswap_32(t->info);
+	t->type =3D bswap_32(t->type);
+}
+
+static int btf_bswap_type_rest(struct btf_type *t)
+{
+	struct btf_var_secinfo *v;
+	struct btf_member *m;
+	struct btf_array *a;
+	struct btf_param *p;
+	struct btf_enum *e;
+	__u16 vlen =3D btf_vlen(t);
+	int i;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_FWD:
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FUNC:
+		return 0;
+	case BTF_KIND_INT:
+		*(__u32 *)(t + 1) =3D bswap_32(*(__u32 *)(t + 1));
+		return 0;
+	case BTF_KIND_ENUM:
+		for (i =3D 0, e =3D btf_enum(t); i < vlen; i++, e++) {
+			e->name_off =3D bswap_32(e->name_off);
+			e->val =3D bswap_32(e->val);
+		}
+		return 0;
+	case BTF_KIND_ARRAY:
+		a =3D btf_array(t);
+		a->type =3D bswap_32(a->type);
+		a->index_type =3D bswap_32(a->index_type);
+		a->nelems =3D bswap_32(a->nelems);
+		return 0;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		for (i =3D 0, m =3D btf_members(t); i < vlen; i++, m++) {
+			m->name_off =3D bswap_32(m->name_off);
+			m->type =3D bswap_32(m->type);
+			m->offset =3D bswap_32(m->offset);
+		}
+		return 0;
+	case BTF_KIND_FUNC_PROTO:
+		for (i =3D 0, p =3D btf_params(t); i < vlen; i++, p++) {
+			p->name_off =3D bswap_32(p->name_off);
+			p->type =3D bswap_32(p->type);
+		}
+		return 0;
+	case BTF_KIND_VAR:
+		btf_var(t)->linkage =3D bswap_32(btf_var(t)->linkage);
+		return 0;
+	case BTF_KIND_DATASEC:
+		for (i =3D 0, v =3D btf_var_secinfos(t); i < vlen; i++, v++) {
+			v->type =3D bswap_32(v->type);
+			v->offset =3D bswap_32(v->offset);
+			v->size =3D bswap_32(v->size);
+		}
+		return 0;
+	default:
+		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
+		return -EINVAL;
+	}
+}
+
 static int btf_parse_type_sec(struct btf *btf)
 {
 	struct btf_header *hdr =3D btf->hdr;
 	void *next_type =3D btf->types_data;
 	void *end_type =3D next_type + hdr->type_len;
-	int err, type_size;
+	int err, i, type_size;
=20
 	/* VOID (type_id =3D=3D 0) is specially handled by btf__get_type_by_id(=
),
 	 * so ensure we can never properly use its offset from index by
@@ -272,19 +357,36 @@ static int btf_parse_type_sec(struct btf *btf)
 	if (err)
 		return err;
=20
-	while (next_type < end_type) {
-		err =3D btf_add_type_idx_entry(btf, next_type - btf->types_data);
-		if (err)
-			return err;
+	while (next_type + sizeof(struct btf_type) <=3D end_type) {
+		i++;
+
+		if (btf->swapped_endian)
+			btf_bswap_type_base(next_type);
=20
 		type_size =3D btf_type_size(next_type);
 		if (type_size < 0)
 			return type_size;
+		if (next_type + type_size > end_type) {
+			pr_warn("BTF type [%d] is malformed\n", i);
+			return -EINVAL;
+		}
+
+		if (btf->swapped_endian && btf_bswap_type_rest(next_type))
+			return -EINVAL;
+
+		err =3D btf_add_type_idx_entry(btf, next_type - btf->types_data);
+		if (err)
+			return err;
=20
 		next_type +=3D type_size;
 		btf->nr_types++;
 	}
=20
+	if (next_type !=3D end_type) {
+		pr_warn("BTF types data is malformed\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
=20
@@ -373,6 +475,38 @@ int btf__set_pointer_size(struct btf *btf, size_t pt=
r_sz)
 	return 0;
 }
=20
+static bool is_host_big_endian(void)
+{
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+	return false;
+#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
+	return true;
+#else
+# error "Unrecognized __BYTE_ORDER__"
+#endif
+}
+
+enum btf_endianness btf__endianness(const struct btf *btf)
+{
+	if (is_host_big_endian())
+		return btf->swapped_endian ? BTF_LITTLE_ENDIAN : BTF_BIG_ENDIAN;
+	else
+		return btf->swapped_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+}
+
+int btf__set_endianness(struct btf *btf, enum btf_endianness endian)
+{
+	if (endian !=3D BTF_LITTLE_ENDIAN && endian !=3D BTF_BIG_ENDIAN)
+		return -EINVAL;
+
+	btf->swapped_endian =3D is_host_big_endian() !=3D (endian =3D=3D BTF_BI=
G_ENDIAN);
+	if (!btf->swapped_endian) {
+		free(btf->raw_data_swapped);
+		btf->raw_data_swapped =3D NULL;
+	}
+	return 0;
+}
+
 static bool btf_type_is_void(const struct btf_type *t)
 {
 	return t =3D=3D &btf_void || btf_is_fwd(t);
@@ -561,6 +695,7 @@ void btf__free(struct btf *btf)
 		free(btf->strs_data);
 	}
 	free(btf->raw_data);
+	free(btf->raw_data_swapped);
 	free(btf->type_offs);
 	free(btf);
 }
@@ -572,8 +707,10 @@ struct btf *btf__new_empty(void)
 	btf =3D calloc(1, sizeof(*btf));
 	if (!btf)
 		return ERR_PTR(-ENOMEM);
+
 	btf->fd =3D -1;
 	btf->ptr_sz =3D sizeof(void *);
+	btf->swapped_endian =3D false;
=20
 	/* +1 for empty string at offset 0 */
 	btf->raw_size =3D sizeof(struct btf_header) + 1;
@@ -604,8 +741,6 @@ struct btf *btf__new(const void *data, __u32 size)
 	if (!btf)
 		return ERR_PTR(-ENOMEM);
=20
-	btf->fd =3D -1;
-
 	btf->raw_data =3D malloc(size);
 	if (!btf->raw_data) {
 		err =3D -ENOMEM;
@@ -624,6 +759,10 @@ struct btf *btf__new(const void *data, __u32 size)
=20
 	err =3D btf_parse_str_sec(btf);
 	err =3D err ?: btf_parse_type_sec(btf);
+	if (err)
+		goto done;
+
+	btf->fd =3D -1;
=20
 done:
 	if (err) {
@@ -634,17 +773,6 @@ struct btf *btf__new(const void *data, __u32 size)
 	return btf;
 }
=20
-static bool btf_check_endianness(const GElf_Ehdr *ehdr)
-{
-#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
-	return ehdr->e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
-#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
-	return ehdr->e_ident[EI_DATA] =3D=3D ELFDATA2MSB;
-#else
-# error "Unrecognized __BYTE_ORDER__"
-#endif
-}
-
 struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
 {
 	Elf_Data *btf_data =3D NULL, *btf_ext_data =3D NULL;
@@ -677,10 +805,6 @@ struct btf *btf__parse_elf(const char *path, struct =
btf_ext **btf_ext)
 		pr_warn("failed to get EHDR from %s\n", path);
 		goto done;
 	}
-	if (!btf_check_endianness(&ehdr)) {
-		pr_warn("non-native ELF endianness is not supported\n");
-		goto done;
-	}
 	if (!elf_rawdata(elf_getscn(elf, ehdr.e_shstrndx), NULL)) {
 		pr_warn("failed to get e_shstrndx from %s\n", path);
 		goto done;
@@ -792,7 +916,7 @@ struct btf *btf__parse_raw(const char *path)
 		err =3D -EIO;
 		goto err_out;
 	}
-	if (magic !=3D BTF_MAGIC) {
+	if (magic !=3D BTF_MAGIC && magic !=3D bswap_16(BTF_MAGIC)) {
 		/* definitely not a raw BTF */
 		err =3D -EPROTO;
 		goto err_out;
@@ -942,11 +1066,13 @@ int btf__finalize_data(struct bpf_object *obj, str=
uct btf *btf)
 	return err;
 }
=20
+static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool s=
wap_endian);
+
 int btf__load(struct btf *btf)
 {
 	__u32 log_buf_size =3D 0, raw_size;
 	char *log_buf =3D NULL;
-	const void *raw_data;
+	void *raw_data;
 	int err =3D 0;
=20
 	if (btf->fd >=3D 0)
@@ -961,11 +1087,14 @@ int btf__load(struct btf *btf)
 		*log_buf =3D 0;
 	}
=20
-	raw_data =3D btf__get_raw_data(btf, &raw_size);
+	raw_data =3D btf_get_raw_data(btf, &raw_size, false);
 	if (!raw_data) {
 		err =3D -ENOMEM;
 		goto done;
 	}
+	/* cache native raw data representation */
+	btf->raw_size =3D raw_size;
+	btf->raw_data =3D raw_data;
=20
 	btf->fd =3D bpf_load_btf(raw_data, raw_size, log_buf, log_buf_size, fal=
se);
 	if (btf->fd < 0) {
@@ -998,31 +1127,73 @@ void btf__set_fd(struct btf *btf, int fd)
 	btf->fd =3D fd;
 }
=20
-const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
+static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool s=
wap_endian)
 {
-	struct btf *btf =3D (struct btf *)btf_ro;
+	struct btf_header *hdr =3D btf->hdr;
+	struct btf_type *t;
+	void *data, *p;
+	__u32 data_sz;
+	int i;
=20
-	if (!btf->raw_data) {
-		struct btf_header *hdr =3D btf->hdr;
-		void *data;
+	data =3D swap_endian ? btf->raw_data_swapped : btf->raw_data;
+	if (data) {
+		*size =3D btf->raw_size;
+		return data;
+	}
+
+	data_sz =3D hdr->hdr_len + hdr->type_len + hdr->str_len;
+	data =3D calloc(1, data_sz);
+	if (!data)
+		return NULL;
+	p =3D data;
+
+	memcpy(p, hdr, hdr->hdr_len);
+	if (swap_endian)
+		btf_bswap_hdr(p);
+	p +=3D hdr->hdr_len;
+
+	memcpy(p, btf->types_data, hdr->type_len);
+	if (swap_endian) {
+		for (i =3D 1; i <=3D btf->nr_types; i++) {
+			t =3D p  + btf->type_offs[i];
+			/* btf_bswap_type_rest() relies on native t->info, so
+			 * we swap base type info after we swapped all the
+			 * additional information
+			 */
+			if (btf_bswap_type_rest(t))
+				goto err_out;
+			btf_bswap_type_base(t);
+		}
+	}
+	p +=3D hdr->type_len;
+
+	memcpy(p, btf->strs_data, hdr->str_len);
+	p +=3D hdr->str_len;
=20
-		btf->raw_size =3D hdr->hdr_len + hdr->type_len + hdr->str_len;
-		btf->raw_data =3D calloc(1, btf->raw_size);
-		if (!btf->raw_data)
-			return NULL;
-		data =3D btf->raw_data;
+	*size =3D data_sz;
+	return data;
+err_out:
+	free(data);
+	return NULL;
+}
=20
-		memcpy(data, hdr, hdr->hdr_len);
-		data +=3D hdr->hdr_len;
+const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
+{
+	struct btf *btf =3D (struct btf *)btf_ro;
+	__u32 data_sz;
+	void *data;
=20
-		memcpy(data, btf->types_data, hdr->type_len);
-		data +=3D hdr->type_len;
+	data =3D btf_get_raw_data(btf, &data_sz, btf->swapped_endian);
+	if (!data)
+		return NULL;
=20
-		memcpy(data, btf->strs_data, hdr->str_len);
-		data +=3D hdr->str_len;
-	}
-	*size =3D btf->raw_size;
-	return btf->raw_data;
+	btf->raw_size =3D data_sz;
+	if (btf->swapped_endian)
+		btf->raw_data_swapped =3D data;
+	else
+		btf->raw_data =3D data;
+	*size =3D data_sz;
+	return data;
 }
=20
 const char *btf__str_by_offset(const struct btf *btf, __u32 offset)
@@ -1190,6 +1361,18 @@ static bool strs_hash_equal_fn(const void *key1, c=
onst void *key2, void *ctx)
 	return strcmp(str1, str2) =3D=3D 0;
 }
=20
+static void btf_invalidate_raw_data(struct btf *btf)
+{
+	if (btf->raw_data) {
+		free(btf->raw_data);
+		btf->raw_data =3D NULL;
+	}
+	if (btf->raw_data_swapped) {
+		free(btf->raw_data_swapped);
+		btf->raw_data_swapped =3D NULL;
+	}
+}
+
 /* Ensure BTF is ready to be modified (by splitting into a three memory
  * regions for header, types, and strings). Also invalidate cached
  * raw_data, if any.
@@ -1203,10 +1386,7 @@ static int btf_ensure_modifiable(struct btf *btf)
=20
 	if (btf_is_modifiable(btf)) {
 		/* any BTF modification invalidates raw_data */
-		if (btf->raw_data) {
-			free(btf->raw_data);
-			btf->raw_data =3D NULL;
-		}
+		btf_invalidate_raw_data(btf);
 		return 0;
 	}
=20
@@ -1254,8 +1434,7 @@ static int btf_ensure_modifiable(struct btf *btf)
 	btf->strs_deduped =3D btf->hdr->str_len <=3D 1;
=20
 	/* invalidate raw_data representation */
-	free(btf->raw_data);
-	btf->raw_data =3D NULL;
+	btf_invalidate_raw_data(btf);
=20
 	return 0;
=20
@@ -2275,7 +2454,10 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 dat=
a_size)
 		return -EINVAL;
 	}
=20
-	if (hdr->magic !=3D BTF_MAGIC) {
+	if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
+		pr_warn("BTF.ext in non-native endianness is not supported\n");
+		return -ENOTSUP;
+	} else if (hdr->magic !=3D BTF_MAGIC) {
 		pr_debug("Invalid BTF.ext magic:%x\n", hdr->magic);
 		return -EINVAL;
 	}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index f7dec0144c3c..57247240a20a 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -25,6 +25,11 @@ struct btf_type;
=20
 struct bpf_object;
=20
+enum btf_endianness {
+	BTF_LITTLE_ENDIAN =3D 0,
+	BTF_BIG_ENDIAN =3D 1,
+};
+
 LIBBPF_API void btf__free(struct btf *btf);
 LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
 LIBBPF_API struct btf *btf__new_empty(void);
@@ -42,6 +47,8 @@ LIBBPF_API const struct btf_type *btf__type_by_id(const=
 struct btf *btf,
 						  __u32 id);
 LIBBPF_API size_t btf__pointer_size(const struct btf *btf);
 LIBBPF_API int btf__set_pointer_size(struct btf *btf, size_t ptr_sz);
+LIBBPF_API enum btf_endianness btf__endianness(const struct btf *btf);
+LIBBPF_API int btf__set_endianness(struct btf *btf, enum btf_endianness =
endian);
 LIBBPF_API __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)=
;
 LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
 LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6b10ebad69c6..f7a8ff37ef04 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -325,8 +325,10 @@ LIBBPF_0.2.0 {
 		btf__add_union;
 		btf__add_var;
 		btf__add_volatile;
+		btf__endianness;
 		btf__find_str;
 		btf__new_empty;
+		btf__set_endianness;
 		btf__str_by_offset;
 		perf_buffer__buffer_cnt;
 		perf_buffer__buffer_fd;
--=20
2.24.1

