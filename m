Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E28413F4B
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 04:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhIVCPE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 22:15:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhIVCPE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 22:15:04 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLH3NB005469
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 19:13:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AGn0dY78rO4IfBBLoomA0DE90NejQ/fp+0sD5zLW2Hg=;
 b=WTsogSRi6qutx6AeZ7Hy0zw5rp3Qc8E8Mcbg+nNwmGJpGEHcEbC//TM7ig357FEipX8M
 FMSeCTh4MzV9y534ltxuAWzKGuz3Z0dJtiM2Dyh/rsErweK1tefdnYJB8e2rzMejwCRk
 YkkB99le4Hflg27MZnWZ7gsM71RJexLwtSk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q61hhe0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 19:13:34 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 19:13:33 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 300F324E25F; Tue, 21 Sep 2021 19:13:32 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 2/2] btf_encoder: generate BTF_KIND_TAG from llvm annotations
Date:   Tue, 21 Sep 2021 19:13:32 -0700
Message-ID: <20210922021332.2287418-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922021321.2286360-1-yhs@fb.com>
References: <20210922021321.2286360-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: aSVkjM_aC83iomIMJ62niVYlc4egg9Ri
X-Proofpoint-GUID: aSVkjM_aC83iomIMJ62niVYlc4egg9Ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following is an example with latest upstream clang:
  $ cat t.c
  #define __tag1 __attribute__((btf_tag("tag1")))
  #define __tag2 __attribute__((btf_tag("tag2")))

  struct t {
          int a:1 __tag1;
          int b __tag2;
  } __tag1 __tag2;

  int g __tag1 __attribute__((section(".data..percpu")));

  int __tag1 foo(struct t *a1, int a2 __tag2) {
    return a1->b + a2 + g;
  }

  $ clang -O2 -g -c t.c
  $ pahole -JV t.o
  Found per-CPU symbol 'g' at address 0x0
  Found 1 per-CPU variables!
  Found 1 functions!
  File t.o:
  [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  [2] PTR (anon) type_id=3D3
  [3] STRUCT t size=3D8
        a type_id=3D1 bitfield_size=3D1 bits_offset=3D0
        b type_id=3D1 bitfield_size=3D0 bits_offset=3D32
  [4] TAG tag1 type_id=3D3 component_idx=3D0
  [5] TAG tag2 type_id=3D3 component_idx=3D1
  [6] TAG tag1 type_id=3D3 component_idx=3D-1
  [7] TAG tag2 type_id=3D3 component_idx=3D-1
  [8] FUNC_PROTO (anon) return=3D1 args=3D(2 a1, 1 a2)
  [9] FUNC foo type_id=3D8
  [10] TAG tag2 type_id=3D9 component_idx=3D1
  [11] TAG tag1 type_id=3D9 component_idx=3D-1
  search cu 't.c' for percpu global variables.
  Variable 'g' from CU 't.c' at address 0x0 encoded
  [12] VAR g type=3D1 linkage=3D1
  [13] TAG tag1 type_id=3D12 component_idx=3D-1
  [14] DATASEC .data..percpu size=3D4 vlen=3D1
        type=3D12 offset=3D0 size=3D4
  $ ...

With additional option --skip_encoding_btf_tag, pahole doesn't
generate BTF_KIND_TAGs any more.
  $ pahole -JV --skip_encoding_btf_tag t.o
  Found per-CPU symbol 'g' at address 0x0
  Found 1 per-CPU variables!
  Found 1 functions!
  File t.o:
  [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  [2] PTR (anon) type_id=3D3
  [3] STRUCT t size=3D8
        a type_id=3D1 bitfield_size=3D1 bits_offset=3D0
        b type_id=3D1 bitfield_size=3D0 bits_offset=3D32
  [4] FUNC_PROTO (anon) return=3D1 args=3D(2 a1, 1 a2)
  [5] FUNC foo type_id=3D4
  search cu 't.c' for percpu global variables.
  Variable 'g' from CU 't.c' at address 0x0 encoded
  [6] VAR g type=3D1 linkage=3D1
  [7] DATASEC .data..percpu size=3D4 vlen=3D1
        type=3D6 offset=3D0 size=3D4
  $ ...

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1b4e83d..c341f95 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -141,6 +141,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_VAR]          =3D "VAR",
 	[BTF_KIND_DATASEC]      =3D "DATASEC",
 	[BTF_KIND_FLOAT]        =3D "FLOAT",
+	[BTF_KIND_TAG]          =3D "TAG",
 };
=20
 static const char *btf__printable_name(const struct btf *btf, uint32_t o=
ffset)
@@ -644,6 +645,26 @@ static int32_t btf_encoder__add_datasec(struct btf_e=
ncoder *encoder, const char
 	return id;
 }
=20
+static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const c=
har *value, uint32_t type,
+				    int component_idx)
+{
+	struct btf *btf =3D encoder->btf;
+	const struct btf_type *t;
+	int32_t id;
+
+	id =3D btf__add_tag(btf, value, type, component_idx);
+	if (id > 0) {
+		t =3D btf__type_by_id(btf, id);
+		btf_encoder__log_type(encoder, t, false, true, "type_id=3D%u component=
_idx=3D%d",
+				      t->type, component_idx);
+	} else {
+		btf__log_err(btf, BTF_KIND_TAG, value, true, "component_idx=3D%d Error=
 emitting BTF type",
+			     component_idx);
+	}
+
+	return id;
+}
+
 /*
  * This corresponds to the same macro defined in
  * include/linux/kallsyms.h
@@ -1158,6 +1179,7 @@ static int btf_encoder__encode_cu_variables(struct =
btf_encoder *encoder, struct
 		struct variable *var =3D tag__variable(pos);
 		uint32_t size, type, linkage;
 		const char *name, *dwarf_name;
+		struct llvm_annotation *annot;
 		const struct tag *tag;
 		uint64_t addr;
 		int id;
@@ -1244,6 +1266,15 @@ static int btf_encoder__encode_cu_variables(struct=
 btf_encoder *encoder, struct
 			goto out;
 		}
=20
+		list_for_each_entry(annot, &var->annots, node) {
+			int tag_type_id =3D btf_encoder__add_tag(encoder, annot->value, id, a=
nnot->component_idx);
+			if (tag_type_id < 0) {
+				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' w=
ith component_idx %d\n",
+					annot->value, name, annot->component_idx);
+				goto out;
+			}
+		}
+
 		/*
 		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be add=
ed into
 		 * encoder->types later when we add BTF_VAR_DATASEC.
@@ -1359,6 +1390,8 @@ void btf_encoder__delete(struct btf_encoder *encode=
r)
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
 {
 	uint32_t type_id_off =3D btf__get_nr_types(encoder->btf);
+	struct llvm_annotation *annot;
+	int btf_type_id, tag_type_id;
 	uint32_t core_id;
 	struct function *fn;
 	struct tag *pos;
@@ -1378,7 +1411,7 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu)
 	}
=20
 	cu__for_each_type(cu, core_id, pos) {
-		int32_t btf_type_id =3D btf_encoder__encode_tag(encoder, pos, type_id_=
off);
+		btf_type_id =3D btf_encoder__encode_tag(encoder, pos, type_id_off);
=20
 		if (btf_type_id < 0 ||
 		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
@@ -1396,6 +1429,25 @@ int btf_encoder__encode_cu(struct btf_encoder *enc=
oder, struct cu *cu)
 		encoder->has_index_type =3D true;
 	}
=20
+	cu__for_each_type(cu, core_id, pos) {
+		struct namespace *ns;
+
+		if (pos->tag !=3D DW_TAG_structure_type && pos->tag !=3D DW_TAG_union_=
type)
+			continue;
+
+		btf_type_id =3D type_id_off + core_id;
+		ns =3D tag__namespace(pos);
+		list_for_each_entry(annot, &ns->annots, node) {
+			tag_type_id =3D btf_encoder__add_tag(encoder, annot->value, btf_type_=
id, annot->component_idx);
+			if (tag_type_id < 0) {
+				fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with co=
mponent_idx %d\n",
+					annot->value, pos->tag =3D=3D DW_TAG_structure_type ? "struct" : "u=
nion",
+					namespace__name(ns), annot->component_idx);
+				goto out;
+			}
+		}
+	}
+
 	cu__for_each_function(cu, core_id, fn) {
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
@@ -1436,6 +1488,15 @@ int btf_encoder__encode_cu(struct btf_encoder *enc=
oder, struct cu *cu)
 			printf("error: failed to encode function '%s'\n", function__name(fn))=
;
 			goto out;
 		}
+
+		list_for_each_entry(annot, &fn->annots, node) {
+			tag_type_id =3D btf_encoder__add_tag(encoder, annot->value, btf_fn_id=
, annot->component_idx);
+			if (tag_type_id < 0) {
+				fprintf(stderr, "error: failed to encode tag '%s' to func %s with co=
mponent_idx %d\n",
+					annot->value, name, annot->component_idx);
+				goto out;
+			}
+		}
 	}
=20
 	if (!encoder->skip_encoding_vars)
--=20
2.30.2

