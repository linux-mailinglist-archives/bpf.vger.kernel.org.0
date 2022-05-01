Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C851673F
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbiEATEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355107AbiEATED (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:04:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F867167D0
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:00:36 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 241DeL0c025399
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:00:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=q8aWsUGV/E5Md6n7QjEHxFKn4Pb5XGc5avHCbXN8t5g=;
 b=HNf8tR3RR28Hnvg1KNaKIEjxwN3eYd1K3WhOOmohw1mrWpJO5Gf/E6TIZSa6K3hM2134
 kBdIelbB9XS7uUJ93hhnVjuO7N4lkqd+Bn+X/C2m3tcKzNrmZEuqhRMEGI55wvFJ4k3e
 vH343Z27QqLE2H3c/d67d+g8fdIiUlf6B3w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fs0m7dyrm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:00:35 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:33 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 79C619C01F64; Sun,  1 May 2022 12:00:28 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 05/12] bpftool: Add btf enum64 support
Date:   Sun, 1 May 2022 12:00:28 -0700
Message-ID: <20220501190028.2579037-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: p2Jx5WtE0Q8lLK-AD3xoKkWa5Ovlb4gg
X-Proofpoint-GUID: p2Jx5WtE0Q8lLK-AD3xoKkWa5Ovlb4gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_ENUM64 support.
For example, the following enum is defined in uapi bpf.h.
  $ cat core.c
  enum A {
        BPF_F_INDEX_MASK                =3D 0xffffffffULL,
        BPF_F_CURRENT_CPU               =3D BPF_F_INDEX_MASK,
        BPF_F_CTXLEN_MASK               =3D (0xfffffULL << 32),
  } g;
Compiled with
  clang -target bpf -O2 -g -c core.c
Using bpftool to dump types and generate format C file:
  $ bpftool btf dump file core.o
  ...
  [1] ENUM64 'A' size=3D8 vlen=3D3
        'BPF_F_INDEX_MASK' val=3D4294967295ULL
        'BPF_F_CURRENT_CPU' val=3D4294967295ULL
        'BPF_F_CTXLEN_MASK' val=3D4503595332403200ULL
  $ bpftool btf dump file core.o format c
  ...
  enum A {
        BPF_F_INDEX_MASK =3D 4294967295ULL,
        BPF_F_CURRENT_CPU =3D 4294967295ULL,
        BPF_F_CTXLEN_MASK =3D 4503595332403200ULL,
  };
  ...

The 64bit value is represented properly in BTF and C dump.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c        | 47 ++++++++++++++++++++++++++++++++--
 tools/bpf/bpftool/btf_dumper.c | 32 +++++++++++++++++++++++
 tools/bpf/bpftool/gen.c        |  1 +
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index a2c665beda87..ae3c413fa3b1 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -40,6 +40,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =3D=
 {
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
+	[BTF_KIND_ENUM64]	=3D "ENUM64",
 };
=20
 struct btf_attach_point {
@@ -228,10 +229,52 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
 			if (json_output) {
 				jsonw_start_object(w);
 				jsonw_string_field(w, "name", name);
-				jsonw_uint_field(w, "val", v->val);
+				if (btf_kflag(t))
+					jsonw_uint_field(w, "val", v->val);
+				else
+					jsonw_int_field(w, "val", v->val);
 				jsonw_end_object(w);
 			} else {
-				printf("\n\t'%s' val=3D%u", name, v->val);
+				if (btf_kflag(t))
+					printf("\n\t'%s' val=3D%u", name, v->val);
+				else
+					printf("\n\t'%s' val=3D%d", name, v->val);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	case BTF_KIND_ENUM64: {
+		const struct btf_enum64 *v =3D (const void *)(t + 1);
+		__u16 vlen =3D BTF_INFO_VLEN(t->info);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "values");
+			jsonw_start_array(w);
+		} else {
+			printf(" size=3D%u vlen=3D%u", t->size, vlen);
+		}
+		for (i =3D 0; i < vlen; i++, v++) {
+			const char *name =3D btf_str(btf, v->name_off);
+			__u64 val =3D (__u64)v->hi32 << 32 | v->lo32;
+
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_string_field(w, "name", name);
+				if (btf_kflag(t))
+					jsonw_uint_field(w, "val", val);
+				else
+					jsonw_int_field(w, "val", val);
+				jsonw_end_object(w);
+			} else {
+				if (btf_kflag(t))
+					printf("\n\t'%s' val=3D%lluULL", name, val);
+				else
+					printf("\n\t'%s' val=3D%lldLL", name, val);
 			}
 		}
 		if (json_output)
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
index f5dddf8ef404..f9f38384b9a6 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -182,6 +182,35 @@ static int btf_dumper_enum(const struct btf_dumper *=
d,
 	return 0;
 }
=20
+static int btf_dumper_enum64(const struct btf_dumper *d,
+			     const struct btf_type *t,
+			     const void *data)
+{
+	const struct btf_enum64 *enums =3D btf_enum64(t);
+	__u32 hi32, lo32;
+	__u64 value;
+	__u16 i;
+
+	if (t->size !=3D 8)
+		return -EINVAL;
+
+	value =3D *(__u64 *)data;
+	hi32 =3D value >> 32;
+	lo32 =3D (__u32)value;
+
+	for (i =3D 0; i < btf_vlen(t); i++) {
+		if (hi32 =3D=3D enums[i].hi32 && lo32 =3D=3D enums[i].lo32) {
+			jsonw_string(d->jw,
+				     btf__name_by_offset(d->btf,
+							 enums[i].name_off));
+			return 0;
+		}
+	}
+
+	jsonw_int(d->jw, value);
+	return 0;
+}
+
 static bool is_str_array(const struct btf *btf, const struct btf_array *=
arr,
 			 const char *s)
 {
@@ -542,6 +571,8 @@ static int btf_dumper_do_type(const struct btf_dumper=
 *d, __u32 type_id,
 		return btf_dumper_array(d, type_id, data);
 	case BTF_KIND_ENUM:
 		return btf_dumper_enum(d, t, data);
+	case BTF_KIND_ENUM64:
+		return btf_dumper_enum64(d, t, data);
 	case BTF_KIND_PTR:
 		btf_dumper_ptr(d, t, data);
 		return 0;
@@ -618,6 +649,7 @@ static int __btf_dumper_type_only(const struct btf *b=
tf, __u32 type_id,
 			      btf__name_by_offset(btf, t->name_off));
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		BTF_PRINT_ARG("enum %s ",
 			      btf__name_by_offset(btf, t->name_off));
 		break;
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7678af364793..b80c3577057f 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1746,6 +1746,7 @@ btfgen_mark_type(struct btfgen_info *info, unsigned=
 int type_id, bool follow_poi
 	case BTF_KIND_INT:
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 		break;
--=20
2.30.2

