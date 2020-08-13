Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7824404B
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 23:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMVF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 17:05:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10450 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgHMVFZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 17:05:25 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DL5KjZ002817
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 14:05:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=P2IaHPgcuCGvXc0cTXu7jWpZ62GYFc+DA5ByNsae0+o=;
 b=OU00wcVM93gaxAlB4isgtvJu2d5ww7skRTL6GcgYyC5u3EjWyFdS99VeAk9rrI5PZ4dV
 TA480lgV8xHaK6oMTWklHEdcon+/se4GYRL9kK/CloiuOgzeRJr03HNr06ASSnDNf7Tb
 VkdrM+9n3i6Hk6UBzMTpcY5OjoZNRSIep78= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32w2yek4sc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 14:05:24 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 14:05:06 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id C0F2E2EC597F; Thu, 13 Aug 2020 13:49:59 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf 4/9] libbpf: handle BTF pointer sizes more carefully
Date:   Thu, 13 Aug 2020 13:49:40 -0700
Message-ID: <20200813204945.1020225-5-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813204945.1020225-1-andriin@fb.com>
References: <20200813204945.1020225-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=526 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=8 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With libbpf and BTF it is pretty common to have libbpf built for one
architecture, while BTF information was generated for a different archite=
cture
(typically, but not always, BPF). In such case, the size of a pointer mig=
ht
differ betweem architectures. libbpf previously was always making an
assumption that pointer size for BTF is the same as native architecture
pointer size, but that breaks for cases where libbpf is built as 32-bit
library, while BTF is for 64-bit architecture.

To solve this, add heuristic to determine pointer size by searching for `=
long`
or `unsigned long` integer type and using its size as a pointer size. Als=
o,
allow to override the pointer size with a new API btf__set_pointer_size()=
, for
cases where application knows which pointer size should be used. User
application can check what libbpf "guessed" by looking at the result of
btf__pointer_size(). If it's not 0, then libbpf successfully determined a
pointer size, otherwise native arch pointer size will be used.

For cases where BTF is parsed from ELF file, use ELF's class (32-bit or
64-bit) to determine pointer size.

Fixes: 8a138aed4a80 ("bpf: btf: Add BTF support to libbpf")
Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c      | 83 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      |  2 +
 tools/lib/bpf/btf_dump.c |  4 +-
 tools/lib/bpf/libbpf.map |  2 +
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 4843e44916f7..7dfca7016aaa 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -41,6 +41,7 @@ struct btf {
 	__u32 types_size;
 	__u32 data_size;
 	int fd;
+	int ptr_sz;
 };
=20
 static inline __u64 ptr_to_u64(const void *ptr)
@@ -221,6 +222,70 @@ const struct btf_type *btf__type_by_id(const struct =
btf *btf, __u32 type_id)
 	return btf->types[type_id];
 }
=20
+static int determine_ptr_size(const struct btf *btf)
+{
+	const struct btf_type *t;
+	const char *name;
+	int i;
+
+	for (i =3D 1; i <=3D btf->nr_types; i++) {
+		t =3D btf__type_by_id(btf, i);
+		if (!btf_is_int(t))
+			continue;
+
+		name =3D btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (strcmp(name, "long int") =3D=3D 0 ||
+		    strcmp(name, "long unsigned int") =3D=3D 0) {
+			if (t->size !=3D 4 && t->size !=3D 8)
+				continue;
+			return t->size;
+		}
+	}
+
+	return -1;
+}
+
+static size_t btf_ptr_sz(const struct btf *btf)
+{
+	if (!btf->ptr_sz)
+		((struct btf *)btf)->ptr_sz =3D determine_ptr_size(btf);
+	return btf->ptr_sz < 0 ? sizeof(void *) : btf->ptr_sz;
+}
+
+/* Return pointer size this BTF instance assumes. The size is heuristica=
lly
+ * determined by looking for 'long' or 'unsigned long' integer type and
+ * recording its size in bytes. If BTF type information doesn't have any=
 such
+ * type, this function returns 0. In the latter case, native architectur=
e's
+ * pointer size is assumed, so will be either 4 or 8, depending on
+ * architecture that libbpf was compiled for. It's possible to override
+ * guessed value by using btf__set_pointer_size() API.
+ */
+size_t btf__pointer_size(const struct btf *btf)
+{
+	if (!btf->ptr_sz)
+		((struct btf *)btf)->ptr_sz =3D determine_ptr_size(btf);
+
+	if (btf->ptr_sz < 0)
+		/* not enough BTF type info to guess */
+		return 0;
+
+	return btf->ptr_sz;
+}
+
+/* Override or set pointer size in bytes. Only values of 4 and 8 are
+ * supported.
+ */
+int btf__set_pointer_size(struct btf *btf, size_t ptr_sz)
+{
+	if (ptr_sz !=3D 4 && ptr_sz !=3D 8)
+		return -EINVAL;
+	btf->ptr_sz =3D ptr_sz;
+	return 0;
+}
+
 static bool btf_type_is_void(const struct btf_type *t)
 {
 	return t =3D=3D &btf_void || btf_is_fwd(t);
@@ -253,7 +318,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 =
type_id)
 			size =3D t->size;
 			goto done;
 		case BTF_KIND_PTR:
-			size =3D sizeof(void *);
+			size =3D btf_ptr_sz(btf);
 			goto done;
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_VOLATILE:
@@ -293,9 +358,9 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	switch (kind) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
-		return min(sizeof(void *), (size_t)t->size);
+		return min(btf_ptr_sz(btf), (size_t)t->size);
 	case BTF_KIND_PTR:
-		return sizeof(void *);
+		return btf_ptr_sz(btf);
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
@@ -533,6 +598,18 @@ struct btf *btf__parse_elf(const char *path, struct =
btf_ext **btf_ext)
 	if (IS_ERR(btf))
 		goto done;
=20
+	switch (gelf_getclass(elf)) {
+	case ELFCLASS32:
+		btf__set_pointer_size(btf, 4);
+		break;
+	case ELFCLASS64:
+		btf__set_pointer_size(btf, 8);
+		break;
+	default:
+		pr_warn("failed to get ELF class (bitness) for %s\n", path);
+		break;
+	}
+
 	if (btf_ext && btf_ext_data) {
 		*btf_ext =3D btf_ext__new(btf_ext_data->d_buf,
 					btf_ext_data->d_size);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index f4a1a1d2b9a3..1ca14448df4c 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -76,6 +76,8 @@ LIBBPF_API __s32 btf__find_by_name_kind(const struct bt=
f *btf,
 LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
 						  __u32 id);
+LIBBPF_API size_t btf__pointer_size(const struct btf *btf);
+LIBBPF_API int btf__set_pointer_size(struct btf *btf, size_t ptr_sz);
 LIBBPF_API __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)=
;
 LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
 LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ac81f3f8957a..fe39bd774697 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -61,6 +61,7 @@ struct btf_dump {
 	const struct btf_ext *btf_ext;
 	btf_dump_printf_fn_t printf_fn;
 	struct btf_dump_opts opts;
+	int ptr_sz;
 	bool strip_mods;
=20
 	/* per-type auxiliary state */
@@ -139,6 +140,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	d->btf_ext =3D btf_ext;
 	d->printf_fn =3D printf_fn;
 	d->opts.ctx =3D opts ? opts->ctx : NULL;
+	d->ptr_sz =3D btf__pointer_size(btf) ? : sizeof(void *);
=20
 	d->type_names =3D hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->type_names)) {
@@ -804,7 +806,7 @@ static void btf_dump_emit_bit_padding(const struct bt=
f_dump *d,
 				      int align, int lvl)
 {
 	int off_diff =3D m_off - cur_off;
-	int ptr_bits =3D sizeof(void *) * 8;
+	int ptr_bits =3D d->ptr_sz * 8;
=20
 	if (off_diff <=3D 0)
 		/* no gap */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 0c4722bfdd0a..e35bd6cdbdbf 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -295,5 +295,7 @@ LIBBPF_0.1.0 {
 		bpf_program__set_sk_lookup;
 		btf__parse;
 		btf__parse_raw;
+		btf__pointer_size;
 		btf__set_fd;
+		btf__set_pointer_size;
 } LIBBPF_0.0.9;
--=20
2.24.1

