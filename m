Return-Path: <bpf+bounces-8700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC9788FC4
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333D11C20F7F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CB19398;
	Fri, 25 Aug 2023 20:22:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3031803F
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 20:22:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D055171A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 13:22:09 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PKJkMj019740
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 13:22:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3spb66ddc1-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 13:22:09 -0700
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 25 Aug 2023 13:22:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 079C536DB0017; Fri, 25 Aug 2023 13:21:52 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Alan Maguire
	<alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next] libbpf: add basic BTF sanity validation
Date: Fri, 25 Aug 2023 13:21:52 -0700
Message-ID: <20230825202152.1813394-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UxW72JHHXwshSOrd7ACRjTcrbX9q0Dx7
X-Proofpoint-GUID: UxW72JHHXwshSOrd7ACRjTcrbX9q0Dx7
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement a simple and straightforward BTF sanity check when parsing BTF
data. Right now it's very basic and just validates that all the string
offsets and type IDs are within valid range. For FUNC we also check that
it points to FUNC_PROTO kinds.

Even with such simple checks it fixes a bunch of crashes found by OSS
fuzzer ([0]-[5]) and will allow fuzzer to make further progress.

Some other invariants will be checked in follow up patches (like
ensuring there is no infinite type loops), but this seems like a good
start already.

Adding FUNC -> FUNC_PROTO check revealed that one of selftests has
a problem with FUNC pointing to VAR instead, so fix it up in the same
commit.

  [0] https://github.com/libbpf/libbpf/issues/482
  [1] https://github.com/libbpf/libbpf/issues/483
  [2] https://github.com/libbpf/libbpf/issues/485
  [3] https://github.com/libbpf/libbpf/issues/613
  [4] https://github.com/libbpf/libbpf/issues/618
  [5] https://github.com/libbpf/libbpf/issues/619

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Song Liu <song@kernel.org>
Closes: https://github.com/libbpf/libbpf/issues/617
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c                          | 160 +++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/btf.c |   4 +-
 2 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8484b563b53d..ee95fd379d4d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -448,6 +448,165 @@ static int btf_parse_type_sec(struct btf *btf)
 	return 0;
 }
=20
+static int btf_validate_str(const struct btf *btf, __u32 str_off, const ch=
ar *what, __u32 type_id)
+{
+	const char *s;
+
+	s =3D btf__str_by_offset(btf, str_off);
+	if (!s) {
+		pr_warn("btf: type [%u]: invalid %s (string offset %u)\n", type_id, what=
, str_off);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int btf_validate_id(const struct btf *btf, __u32 id, __u32 ctx_id)
+{
+	const struct btf_type *t;
+
+	t =3D btf__type_by_id(btf, id);
+	if (!t) {
+		pr_warn("btf: type [%u]: invalid referenced type ID %u\n", ctx_id, id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int btf_validate_type(const struct btf *btf, const struct btf_type =
*t, __u32 id)
+{
+	__u32 kind =3D btf_kind(t);
+	int err, i, n;
+
+	err =3D btf_validate_str(btf, t->name_off, "type name", id);
+	if (err)
+		return err;
+
+	switch (kind) {
+	case BTF_KIND_UNKN:
+	case BTF_KIND_INT:
+	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
+		break;
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_TYPE_TAG:
+		err =3D btf_validate_id(btf, t->type, id);
+		if (err)
+			return err;
+		break;
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *a =3D btf_array(t);
+
+		err =3D btf_validate_id(btf, a->type, id);
+		err =3D err ?: btf_validate_id(btf, a->index_type, id);
+		if (err)
+			return err;
+		break;
+	}
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m =3D btf_members(t);
+
+		n =3D btf_vlen(t);
+		for (i =3D 0; i < n; i++, m++) {
+			err =3D btf_validate_str(btf, m->name_off, "field name", id);
+			err =3D err ?: btf_validate_id(btf, m->type, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_ENUM: {
+		const struct btf_enum *m =3D btf_enum(t);
+
+		n =3D btf_vlen(t);
+		for (i =3D 0; i < n; i++, m++) {
+			err =3D btf_validate_str(btf, m->name_off, "enum name", id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_ENUM64: {
+		const struct btf_enum64 *m =3D btf_enum64(t);
+
+		n =3D btf_vlen(t);
+		for (i =3D 0; i < n; i++, m++) {
+			err =3D btf_validate_str(btf, m->name_off, "enum name", id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_FUNC: {
+		const struct btf_type *ft;
+
+		err =3D btf_validate_id(btf, t->type, id);
+		if (err)
+			return err;
+		ft =3D btf__type_by_id(btf, t->type);
+		if (btf_kind(ft) !=3D BTF_KIND_FUNC_PROTO) {
+			pr_warn("btf: type [%u]: referenced type [%u] is not FUNC_PROTO\n", id,=
 t->type);
+			return -EINVAL;
+		}
+		break;
+	}
+	case BTF_KIND_FUNC_PROTO: {
+		const struct btf_param *m =3D btf_params(t);
+
+		n =3D btf_vlen(t);
+		for (i =3D 0; i < n; i++, m++) {
+			err =3D btf_validate_str(btf, m->name_off, "param name", id);
+			err =3D err ?: btf_validate_id(btf, m->type, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_DATASEC: {
+		const struct btf_var_secinfo *m =3D btf_var_secinfos(t);
+
+		n =3D btf_vlen(t);
+		for (i =3D 0; i < n; i++, m++) {
+			err =3D btf_validate_id(btf, m->type, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	default:
+		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* Validate basic sanity of BTF. It's intentionally less thorough than
+ * kernel's validation and validates only properties of BTF that libbpf re=
lies
+ * on to be correct (e.g., valid type IDs, valid string offsets, etc)
+ */
+static int btf_sanity_check(const struct btf *btf)
+{
+	const struct btf_type *t;
+	__u32 i, n =3D btf__type_cnt(btf);
+	int err;
+
+	for (i =3D 1; i < n; i++) {
+		t =3D btf_type_by_id(btf, i);
+		err =3D btf_validate_type(btf, t, i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 __u32 btf__type_cnt(const struct btf *btf)
 {
 	return btf->start_id + btf->nr_types;
@@ -902,6 +1061,7 @@ static struct btf *btf_new(const void *data, __u32 siz=
e, struct btf *base_btf)
=20
 	err =3D btf_parse_str_sec(btf);
 	err =3D err ?: btf_parse_type_sec(btf);
+	err =3D err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index 4e0cdb593318..92d51f377fe5 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7296,7 +7296,7 @@ static struct btf_dedup_test dedup_tests[] =3D {
 			BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
-			BTF_FUNC_ENC(NAME_NTH(4), 2),			/* [4] */
+			BTF_FUNC_ENC(NAME_NTH(4), 3),			/* [4] */
 			/* tag -> t */
 			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
 			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [6] */
@@ -7317,7 +7317,7 @@ static struct btf_dedup_test dedup_tests[] =3D {
 			BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
-			BTF_FUNC_ENC(NAME_NTH(4), 2),			/* [4] */
+			BTF_FUNC_ENC(NAME_NTH(4), 3),			/* [4] */
 			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
 			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [6] */
 			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [7] */
--=20
2.34.1


