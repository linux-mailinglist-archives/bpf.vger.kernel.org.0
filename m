Return-Path: <bpf+bounces-8522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19EF78792C
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BCC280E94
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B965818022;
	Thu, 24 Aug 2023 20:14:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4417FF0
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 20:14:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC021BF6
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:14:06 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 37OHdWhj029463
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:14:06 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3spb6jssgd-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:14:05 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 24 Aug 2023 13:14:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 83EFA36CAED63; Thu, 24 Aug 2023 13:13:59 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next] libbpf: add basic BTF sanity validation
Date: Thu, 24 Aug 2023 13:13:58 -0700
Message-ID: <20230824201358.1395122-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LehQ4u0e-LK4HAgNcxqQPAg48zlk7xoT
X-Proofpoint-GUID: LehQ4u0e-LK4HAgNcxqQPAg48zlk7xoT
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
 definitions=2023-08-24_16,2023-08-24_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement a simple and straightforward BTF sanity check when parsing BTF
data. Right now it's very basic and just validates that all the string
offsets and type IDs are within valid range. But even with such simple
checks it fixes a bunch of crashes found by OSS fuzzer ([0]-[5]) and
will allow fuzzer to make further progress.

Some other invariants will be checked in follow up patches (like
ensuring there is no infinite type loops), but this seems like a good
start already.

v1->v2:
  - fix array index_type vs type copy/paste error (Eduard);
  - add type ID check in FUNC_PROTO validation (Eduard);
  - move sanity check to btf parsing time (Martin).

  [0] https://github.com/libbpf/libbpf/issues/482
  [1] https://github.com/libbpf/libbpf/issues/483
  [2] https://github.com/libbpf/libbpf/issues/485
  [3] https://github.com/libbpf/libbpf/issues/613
  [4] https://github.com/libbpf/libbpf/issues/618
  [5] https://github.com/libbpf/libbpf/issues/619

Closes: https://github.com/libbpf/libbpf/issues/617
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8484b563b53d..28905539f045 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -448,6 +448,153 @@ static int btf_parse_type_sec(struct btf *btf)
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
+	case BTF_KIND_FUNC:
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
@@ -902,6 +1049,7 @@ static struct btf *btf_new(const void *data, __u32 siz=
e, struct btf *base_btf)
=20
 	err =3D btf_parse_str_sec(btf);
 	err =3D err ?: btf_parse_type_sec(btf);
+	err =3D err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
=20
--=20
2.34.1


