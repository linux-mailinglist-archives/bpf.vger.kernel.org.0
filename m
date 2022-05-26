Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8C5353A8
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbiEZSzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348571AbiEZSzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:55:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3560C966E
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:42 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QInovK019702
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZotRVy+u+cTA2GrULbN9T7RxnRlKQ1+TZX+ikE7WqC8=;
 b=gaKf/Z6Miq6ig8O69cr8FEz6GNn3vA0C7tQAN1CEj1E71mVnBkn6gDrNsXZ4WEui5OXh
 Ab81BvbI5otBD3/Ea8FN2fbF4pG7HATDp46ubycFjbaBs0OxzvIzxVFW1ClC9HHCd7zo
 6llIouxCfvQiiv3B1L97mNZFDWhxt/xnZb4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ga8puu1g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:42 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:55:41 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 64409AD83D7F; Thu, 26 May 2022 11:55:30 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 11/18] bpftool: Add btf enum64 support
Date:   Thu, 26 May 2022 11:55:30 -0700
Message-ID: <20220526185530.2550659-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0g2gw-ffXRaesDEnwhCuH_PyKfRsU5k-
X-Proofpoint-GUID: 0g2gw-ffXRaesDEnwhCuH_PyKfRsU5k-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_10,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  [1] ENUM64 'A' encoding=3DUNSIGNED size=3D8 vlen=3D3
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

Note that for raw btf output, the encoding (UNSIGNED or SIGNED)
is printed out as well. The 64bit value is also represented properly
in BTF and C dump.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c        | 57 ++++++++++++++++++++++++++++++++--
 tools/bpf/bpftool/btf_dumper.c | 29 +++++++++++++++++
 tools/bpf/bpftool/gen.c        |  1 +
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 7e6accb9d9f7..0744bd1150be 100644
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
@@ -212,26 +213,76 @@ static int dump_btf_type(const struct btf *btf, __u=
32 id,
 	case BTF_KIND_ENUM: {
 		const struct btf_enum *v =3D (const void *)(t + 1);
 		__u16 vlen =3D BTF_INFO_VLEN(t->info);
+		const char *encoding;
 		int i;
=20
+		encoding =3D btf_kflag(t) ? "SIGNED" : "UNSIGNED";
 		if (json_output) {
+			jsonw_string_field(w, "encoding", encoding);
 			jsonw_uint_field(w, "size", t->size);
 			jsonw_uint_field(w, "vlen", vlen);
 			jsonw_name(w, "values");
 			jsonw_start_array(w);
 		} else {
-			printf(" size=3D%u vlen=3D%u", t->size, vlen);
+			printf(" encoding=3D%s size=3D%u vlen=3D%u", encoding, t->size, vlen)=
;
+		}
+		for (i =3D 0; i < vlen; i++, v++) {
+			const char *name =3D btf_str(btf, v->name_off);
+
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_string_field(w, "name", name);
+				if (btf_kflag(t))
+					jsonw_int_field(w, "val", v->val);
+				else
+					jsonw_uint_field(w, "val", v->val);
+				jsonw_end_object(w);
+			} else {
+				if (btf_kflag(t))
+					printf("\n\t'%s' val=3D%d", name, v->val);
+				else
+					printf("\n\t'%s' val=3D%u", name, v->val);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	case BTF_KIND_ENUM64: {
+		const struct btf_enum64 *v =3D btf_enum64(t);
+		__u16 vlen =3D btf_vlen(t);
+		const char *encoding;
+		int i;
+
+		encoding =3D btf_kflag(t) ? "SIGNED" : "UNSIGNED";
+		if (json_output) {
+			jsonw_string_field(w, "encoding", encoding);
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "values");
+			jsonw_start_array(w);
+		} else {
+			printf(" encoding=3D%s size=3D%u vlen=3D%u", encoding, t->size, vlen)=
;
 		}
 		for (i =3D 0; i < vlen; i++, v++) {
 			const char *name =3D btf_str(btf, v->name_off);
+			__u64 val =3D ((__u64)v->val_hi32 << 32) | v->val_lo32;
=20
 			if (json_output) {
 				jsonw_start_object(w);
 				jsonw_string_field(w, "name", name);
-				jsonw_uint_field(w, "val", v->val);
+				if (btf_kflag(t))
+					jsonw_int_field(w, "val", val);
+				else
+					jsonw_uint_field(w, "val", val);
 				jsonw_end_object(w);
 			} else {
-				printf("\n\t'%s' val=3D%u", name, v->val);
+				if (btf_kflag(t))
+					printf("\n\t'%s' val=3D%lldLL", name,
+					       (unsigned long long)val);
+				else
+					printf("\n\t'%s' val=3D%lluULL", name,
+					       (unsigned long long)val);
 			}
 		}
 		if (json_output)
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
index f5dddf8ef404..125798b0bc5d 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -182,6 +182,32 @@ static int btf_dumper_enum(const struct btf_dumper *=
d,
 	return 0;
 }
=20
+static int btf_dumper_enum64(const struct btf_dumper *d,
+			     const struct btf_type *t,
+			     const void *data)
+{
+	const struct btf_enum64 *enums =3D btf_enum64(t);
+	__u32 val_lo32, val_hi32;
+	__u64 value;
+	__u16 i;
+
+	value =3D *(__u64 *)data;
+	val_lo32 =3D (__u32)value;
+	val_hi32 =3D value >> 32;
+
+	for (i =3D 0; i < btf_vlen(t); i++) {
+		if (val_lo32 =3D=3D enums[i].val_lo32 && val_hi32 =3D=3D enums[i].val_=
hi32) {
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
@@ -542,6 +568,8 @@ static int btf_dumper_do_type(const struct btf_dumper=
 *d, __u32 type_id,
 		return btf_dumper_array(d, type_id, data);
 	case BTF_KIND_ENUM:
 		return btf_dumper_enum(d, t, data);
+	case BTF_KIND_ENUM64:
+		return btf_dumper_enum64(d, t, data);
 	case BTF_KIND_PTR:
 		btf_dumper_ptr(d, t, data);
 		return 0;
@@ -618,6 +646,7 @@ static int __btf_dumper_type_only(const struct btf *b=
tf, __u32 type_id,
 			      btf__name_by_offset(btf, t->name_off));
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		BTF_PRINT_ARG("enum %s ",
 			      btf__name_by_offset(btf, t->name_off));
 		break;
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 4c9477ff748d..14f5fe7f570e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1747,6 +1747,7 @@ btfgen_mark_type(struct btfgen_info *info, unsigned=
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

