Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A117D53F612
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiFGG0k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiFGG0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:26:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E755C9EC9
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:26:38 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257653aK015231
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NlLE5NUSl/m87K1SqhPZqD9ylih7Qhr3BtjI/0sAsbk=;
 b=fk8XHmKqlnI2+S/T2GvFTq+Ligle6IlXOnLwh3eA/sL+ZIVCEOH9HnRt59PQsXDOQvBw
 fmrLH8j3/C5NO2UUd+TCSTmir2ryjlSxC/uG2Cbr2eDBi+Y5RpqyrqNn251JRrJewM0c
 zc9rCrLoCorMorlFNBX0LZiqGxK2x0B9A+8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gj13cg2f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:26:38 -0700
Received: from twshared17349.03.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:26:37 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B9106B52108F; Mon,  6 Jun 2022 23:26:31 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 07/17] libbpf: Add enum64 support for btf_dump
Date:   Mon, 6 Jun 2022 23:26:31 -0700
Message-ID: <20220607062631.3720526-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6NbNG3EwHe22OzFEhuIf-8fOtWDYMTRR
X-Proofpoint-ORIG-GUID: 6NbNG3EwHe22OzFEhuIf-8fOtWDYMTRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add enum64 btf dumping support. For long long and unsigned long long
dump, suffixes 'LL' and 'ULL' are added to avoid compilation errors
in some cases.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.h      |   5 ++
 tools/lib/bpf/btf_dump.c | 137 +++++++++++++++++++++++++++++----------
 2 files changed, 108 insertions(+), 34 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index c7e8b1fdfe24..dcb3f575a281 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -566,6 +566,11 @@ static inline struct btf_enum64 *btf_enum64(const st=
ruct btf_type *t)
 	return (struct btf_enum64 *)(t + 1);
 }
=20
+static inline __u64 btf_enum64_value(const struct btf_enum64 *e)
+{
+	return ((__u64)e->val_hi32 << 32) | e->val_lo32;
+}
+
 static inline struct btf_member *btf_members(const struct btf_type *t)
 {
 	return (struct btf_member *)(t + 1);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6b1bc1f43728..f5275f819027 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -318,6 +318,7 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
 		switch (btf_kind(t)) {
 		case BTF_KIND_INT:
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 		case BTF_KIND_FWD:
 		case BTF_KIND_FLOAT:
 			break;
@@ -538,6 +539,7 @@ static int btf_dump_order_type(struct btf_dump *d, __=
u32 id, bool through_ptr)
 		return 1;
 	}
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_FWD:
 		/*
 		 * non-anonymous or non-referenced enums are top-level
@@ -739,6 +741,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __=
u32 id, __u32 cont_id)
 		tstate->emit_state =3D EMITTED;
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		if (top_level_def) {
 			btf_dump_emit_enum_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
@@ -989,38 +992,81 @@ static void btf_dump_emit_enum_fwd(struct btf_dump =
*d, __u32 id,
 	btf_dump_printf(d, "enum %s", btf_dump_type_name(d, id));
 }
=20
-static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
-				   const struct btf_type *t,
-				   int lvl)
+static void btf_dump_emit_enum32_val(struct btf_dump *d,
+				     const struct btf_type *t,
+				     int lvl, __u16 vlen)
 {
 	const struct btf_enum *v =3D btf_enum(t);
-	__u16 vlen =3D btf_vlen(t);
+	bool is_signed =3D btf_kflag(t);
+	const char *fmt_str;
 	const char *name;
 	size_t dup_cnt;
 	int i;
=20
+	for (i =3D 0; i < vlen; i++, v++) {
+		name =3D btf_name_of(d, v->name_off);
+		/* enumerators share namespace with typedef idents */
+		dup_cnt =3D btf_dump_name_dups(d, d->ident_names, name);
+		if (dup_cnt > 1) {
+			fmt_str =3D is_signed ? "\n%s%s___%zd =3D %d," : "\n%s%s___%zd =3D %u=
,";
+			btf_dump_printf(d, fmt_str, pfx(lvl + 1), name, dup_cnt, v->val);
+		} else {
+			fmt_str =3D is_signed ? "\n%s%s =3D %d," : "\n%s%s =3D %u,";
+			btf_dump_printf(d, fmt_str, pfx(lvl + 1), name, v->val);
+		}
+	}
+}
+
+static void btf_dump_emit_enum64_val(struct btf_dump *d,
+				     const struct btf_type *t,
+				     int lvl, __u16 vlen)
+{
+	const struct btf_enum64 *v =3D btf_enum64(t);
+	bool is_signed =3D btf_kflag(t);
+	const char *fmt_str;
+	const char *name;
+	size_t dup_cnt;
+	__u64 val;
+	int i;
+
+	for (i =3D 0; i < vlen; i++, v++) {
+		name =3D btf_name_of(d, v->name_off);
+		dup_cnt =3D btf_dump_name_dups(d, d->ident_names, name);
+		val =3D btf_enum64_value(v);
+		if (dup_cnt > 1) {
+			fmt_str =3D is_signed ? "\n%s%s___%zd =3D %lldLL,"
+					    : "\n%s%s___%zd =3D %lluULL,";
+			btf_dump_printf(d, fmt_str,
+					pfx(lvl + 1), name, dup_cnt,
+					(unsigned long long)val);
+		} else {
+			fmt_str =3D is_signed ? "\n%s%s =3D %lldLL,"
+					    : "\n%s%s =3D %lluULL,";
+			btf_dump_printf(d, fmt_str,
+					pfx(lvl + 1), name,
+					(unsigned long long)val);
+		}
+	}
+}
+static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
+				   const struct btf_type *t,
+				   int lvl)
+{
+	__u16 vlen =3D btf_vlen(t);
+
 	btf_dump_printf(d, "enum%s%s",
 			t->name_off ? " " : "",
 			btf_dump_type_name(d, id));
=20
-	if (vlen) {
-		btf_dump_printf(d, " {");
-		for (i =3D 0; i < vlen; i++, v++) {
-			name =3D btf_name_of(d, v->name_off);
-			/* enumerators share namespace with typedef idents */
-			dup_cnt =3D btf_dump_name_dups(d, d->ident_names, name);
-			if (dup_cnt > 1) {
-				btf_dump_printf(d, "\n%s%s___%zu =3D %u,",
-						pfx(lvl + 1), name, dup_cnt,
-						(__u32)v->val);
-			} else {
-				btf_dump_printf(d, "\n%s%s =3D %u,",
-						pfx(lvl + 1), name,
-						(__u32)v->val);
-			}
-		}
-		btf_dump_printf(d, "\n%s}", pfx(lvl));
-	}
+	if (!vlen)
+		return;
+
+	btf_dump_printf(d, " {");
+	if (btf_is_enum(t))
+		btf_dump_emit_enum32_val(d, t, lvl, vlen);
+	else
+		btf_dump_emit_enum64_val(d, t, lvl, vlen);
+	btf_dump_printf(d, "\n%s}", pfx(lvl));
 }
=20
 static void btf_dump_emit_fwd_def(struct btf_dump *d, __u32 id,
@@ -1178,6 +1224,7 @@ static void btf_dump_emit_type_decl(struct btf_dump=
 *d, __u32 id,
 			break;
 		case BTF_KIND_INT:
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 		case BTF_KIND_FWD:
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
@@ -1312,6 +1359,7 @@ static void btf_dump_emit_type_chain(struct btf_dum=
p *d,
 				btf_dump_emit_struct_fwd(d, id, t);
 			break;
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 			btf_dump_emit_mods(d, decls);
 			/* inline anonymous enum */
 			if (t->name_off =3D=3D 0 && !d->skip_anon_defs)
@@ -1988,7 +2036,8 @@ static int btf_dump_get_enum_value(struct btf_dump =
*d,
 				   __u32 id,
 				   __s64 *value)
 {
-	/* handle unaligned enum value */
+	bool is_signed =3D btf_kflag(t);
+
 	if (!ptr_is_aligned(d->btf, id, data)) {
 		__u64 val;
 		int err;
@@ -2005,13 +2054,13 @@ static int btf_dump_get_enum_value(struct btf_dum=
p *d,
 		*value =3D *(__s64 *)data;
 		return 0;
 	case 4:
-		*value =3D *(__s32 *)data;
+		*value =3D is_signed ? *(__s32 *)data : *(__u32 *)data;
 		return 0;
 	case 2:
-		*value =3D *(__s16 *)data;
+		*value =3D is_signed ? *(__s16 *)data : *(__u16 *)data;
 		return 0;
 	case 1:
-		*value =3D *(__s8 *)data;
+		*value =3D is_signed ? *(__s8 *)data : *(__u8 *)data;
 		return 0;
 	default:
 		pr_warn("unexpected size %d for enum, id:[%u]\n", t->size, id);
@@ -2024,7 +2073,7 @@ static int btf_dump_enum_data(struct btf_dump *d,
 			      __u32 id,
 			      const void *data)
 {
-	const struct btf_enum *e;
+	bool is_signed;
 	__s64 value;
 	int i, err;
=20
@@ -2032,14 +2081,31 @@ static int btf_dump_enum_data(struct btf_dump *d,
 	if (err)
 		return err;
=20
-	for (i =3D 0, e =3D btf_enum(t); i < btf_vlen(t); i++, e++) {
-		if (value !=3D e->val)
-			continue;
-		btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
-		return 0;
-	}
+	is_signed =3D btf_kflag(t);
+	if (btf_is_enum(t)) {
+		const struct btf_enum *e;
+
+		for (i =3D 0, e =3D btf_enum(t); i < btf_vlen(t); i++, e++) {
+			if (value !=3D e->val)
+				continue;
+			btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
+			return 0;
+		}
=20
-	btf_dump_type_values(d, "%d", value);
+		btf_dump_type_values(d, is_signed ? "%d" : "%u", value);
+	} else {
+		const struct btf_enum64 *e;
+
+		for (i =3D 0, e =3D btf_enum64(t); i < btf_vlen(t); i++, e++) {
+			if (value !=3D btf_enum64_value(e))
+				continue;
+			btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
+			return 0;
+		}
+
+		btf_dump_type_values(d, is_signed ? "%lldLL" : "%lluULL",
+				     (unsigned long long)value);
+	}
 	return 0;
 }
=20
@@ -2099,6 +2165,7 @@ static int btf_dump_type_data_check_overflow(struct=
 btf_dump *d,
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_PTR:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		if (data + bits_offset / 8 + size > d->typed_dump->data_end)
 			return -E2BIG;
 		break;
@@ -2203,6 +2270,7 @@ static int btf_dump_type_data_check_zero(struct btf=
_dump *d,
 		return -ENODATA;
 	}
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		err =3D btf_dump_get_enum_value(d, t, data, id, &value);
 		if (err)
 			return err;
@@ -2275,6 +2343,7 @@ static int btf_dump_dump_type_data(struct btf_dump =
*d,
 		err =3D btf_dump_struct_data(d, t, id, data);
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		/* handle bitfield and int enum values */
 		if (bit_sz) {
 			__u64 print_num;
--=20
2.30.2

