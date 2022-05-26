Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDF5353A4
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347996AbiEZSzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348684AbiEZSzg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:55:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EBDE338
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:33 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QIo8Zi007401
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nQiL+22cqPu9RKG5471FIahBi+S/abhmUKdCegDIAeE=;
 b=GauHX5KK9OYD6C5ImOosTyGHGqwgU8e5eCjDcjcW+8vUE9arPx90FCjkD/g0PITkid0q
 MZvPwPTQeYhVi7KIE/ejnURzzUyiwMCO0Harb9mjj79din6WvRYgjmvlg/FBpNTxjaMw
 Ru9/CXfgnrrWCSku/mNMk/Ol7RWKW6h+etk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93upqard-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:32 -0700
Received: from twshared6696.05.ash7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:55:31 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D80B4AD83D64; Thu, 26 May 2022 11:55:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 10/18] libbpf: Add enum64 relocation support
Date:   Thu, 26 May 2022 11:55:24 -0700
Message-ID: <20220526185524.2550356-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: III-jGzgekhij9ThVLWuX7uQMUzYOrCo
X-Proofpoint-ORIG-GUID: III-jGzgekhij9ThVLWuX7uQMUzYOrCo
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

The enum64 relocation support is added. The bpf local type
could be either enum or enum64 and the remote type could be
either enum or enum64 too. The all combinations of local enum/enum64
and remote enum/enum64 are supported.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.h       |  7 +++++
 tools/lib/bpf/libbpf.c    |  7 ++---
 tools/lib/bpf/relo_core.c | 54 +++++++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index d4fe1300ed33..aa2b38abdd2c 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -537,6 +537,13 @@ static inline bool btf_type_is_any_enum(const struct=
 btf_type *t)
 	return btf_is_enum(t) || btf_is_enum64(t);
 }
=20
+static inline bool btf_kind_core_compat(const struct btf_type *t1,
+					const struct btf_type *t2)
+{
+	return btf_kind(t1) =3D=3D btf_kind(t2) ||
+	       (btf_type_is_any_enum(t1) && btf_type_is_any_enum(t2));
+}
+
 static inline __u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a9667b49b838..4a234dce5e9f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5401,7 +5401,7 @@ int bpf_core_add_cands(struct bpf_core_cand *local_=
cand,
 	n =3D btf__type_cnt(targ_btf);
 	for (i =3D targ_start_id; i < n; i++) {
 		t =3D btf__type_by_id(targ_btf, i);
-		if (btf_kind(t) !=3D btf_kind(local_t))
+		if (!btf_kind_core_compat(t, local_t))
 			continue;
=20
 		targ_name =3D btf__name_by_offset(targ_btf, t->name_off);
@@ -5615,7 +5615,7 @@ int bpf_core_types_are_compat(const struct btf *loc=
al_btf, __u32 local_id,
 	/* caller made sure that names match (ignoring flavor suffix) */
 	local_type =3D btf__type_by_id(local_btf, local_id);
 	targ_type =3D btf__type_by_id(targ_btf, targ_id);
-	if (btf_kind(local_type) !=3D btf_kind(targ_type))
+	if (!btf_kind_core_compat(local_type, targ_type))
 		return 0;
=20
 recur:
@@ -5628,7 +5628,7 @@ int bpf_core_types_are_compat(const struct btf *loc=
al_btf, __u32 local_id,
 	if (!local_type || !targ_type)
 		return -EINVAL;
=20
-	if (btf_kind(local_type) !=3D btf_kind(targ_type))
+	if (!btf_kind_core_compat(local_type, targ_type))
 		return 0;
=20
 	switch (btf_kind(local_type)) {
@@ -5636,6 +5636,7 @@ int bpf_core_types_are_compat(const struct btf *loc=
al_btf, __u32 local_id,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_FWD:
 		return 1;
 	case BTF_KIND_INT:
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 78b16cda86fa..8c1d608c3adf 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -186,7 +186,7 @@ int bpf_core_parse_spec(const char *prog_name, const =
struct btf *btf,
 	struct bpf_core_accessor *acc;
 	const struct btf_type *t;
 	const char *name, *spec_str;
-	__u32 id;
+	__u32 id, name_off;
 	__s64 sz;
=20
 	spec_str =3D btf__name_by_offset(btf, relo->access_str_off);
@@ -231,11 +231,13 @@ int bpf_core_parse_spec(const char *prog_name, cons=
t struct btf *btf,
 	spec->len++;
=20
 	if (core_relo_is_enumval_based(relo->kind)) {
-		if (!btf_is_enum(t) || spec->raw_len > 1 || access_idx >=3D btf_vlen(t=
))
+		if (!btf_type_is_any_enum(t) || spec->raw_len > 1 || access_idx >=3D b=
tf_vlen(t))
 			return -EINVAL;
=20
 		/* record enumerator name in a first accessor */
-		acc->name =3D btf__name_by_offset(btf, btf_enum(t)[access_idx].name_of=
f);
+		name_off =3D btf_is_enum(t) ? btf_enum(t)[access_idx].name_off
+					  : btf_enum64(t)[access_idx].name_off;
+		acc->name =3D btf__name_by_offset(btf, name_off);
 		return 0;
 	}
=20
@@ -340,7 +342,7 @@ static int bpf_core_fields_are_compat(const struct bt=
f *local_btf,
=20
 	if (btf_is_composite(local_type) && btf_is_composite(targ_type))
 		return 1;
-	if (btf_kind(local_type) !=3D btf_kind(targ_type))
+	if (!btf_kind_core_compat(local_type, targ_type))
 		return 0;
=20
 	switch (btf_kind(local_type)) {
@@ -348,6 +350,7 @@ static int bpf_core_fields_are_compat(const struct bt=
f *local_btf,
 	case BTF_KIND_FLOAT:
 		return 1;
 	case BTF_KIND_FWD:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_ENUM: {
 		const char *local_name, *targ_name;
 		size_t local_len, targ_len;
@@ -477,6 +480,7 @@ static int bpf_core_spec_match(struct bpf_core_spec *=
local_spec,
 	const struct bpf_core_accessor *local_acc;
 	struct bpf_core_accessor *targ_acc;
 	int i, sz, matched;
+	__u32 name_off;
=20
 	memset(targ_spec, 0, sizeof(*targ_spec));
 	targ_spec->btf =3D targ_btf;
@@ -494,18 +498,22 @@ static int bpf_core_spec_match(struct bpf_core_spec=
 *local_spec,
=20
 	if (core_relo_is_enumval_based(local_spec->relo_kind)) {
 		size_t local_essent_len, targ_essent_len;
-		const struct btf_enum *e;
 		const char *targ_name;
=20
 		/* has to resolve to an enum */
 		targ_type =3D skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id=
);
-		if (!btf_is_enum(targ_type))
+		if (!btf_type_is_any_enum(targ_type))
 			return 0;
=20
 		local_essent_len =3D bpf_core_essential_name_len(local_acc->name);
=20
-		for (i =3D 0, e =3D btf_enum(targ_type); i < btf_vlen(targ_type); i++,=
 e++) {
-			targ_name =3D btf__name_by_offset(targ_spec->btf, e->name_off);
+		for (i =3D 0; i < btf_vlen(targ_type); i++) {
+			if (btf_is_enum(targ_type))
+				name_off =3D btf_enum(targ_type)[i].name_off;
+			else
+				name_off =3D btf_enum64(targ_type)[i].name_off;
+
+			targ_name =3D btf__name_by_offset(targ_spec->btf, name_off);
 			targ_essent_len =3D bpf_core_essential_name_len(targ_name);
 			if (targ_essent_len !=3D local_essent_len)
 				continue;
@@ -680,8 +688,7 @@ static int bpf_core_calc_field_relo(const char *prog_=
name,
 		*val =3D byte_sz;
 		break;
 	case BPF_CORE_FIELD_SIGNED:
-		/* enums will be assumed unsigned */
-		*val =3D btf_is_enum(mt) ||
+		*val =3D btf_type_is_any_enum(mt) ||
 		       (btf_int_encoding(mt) & BTF_INT_SIGNED);
 		if (validate)
 			*validate =3D true; /* signedness is never ambiguous */
@@ -754,7 +761,6 @@ static int bpf_core_calc_enumval_relo(const struct bp=
f_core_relo *relo,
 				      __u64 *val)
 {
 	const struct btf_type *t;
-	const struct btf_enum *e;
=20
 	switch (relo->kind) {
 	case BPF_CORE_ENUMVAL_EXISTS:
@@ -764,8 +770,10 @@ static int bpf_core_calc_enumval_relo(const struct b=
pf_core_relo *relo,
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t =3D btf_type_by_id(spec->btf, spec->spec[0].type_id);
-		e =3D btf_enum(t) + spec->spec[0].idx;
-		*val =3D e->val;
+		if (btf_is_enum(t))
+			*val =3D btf_enum(t)[spec->spec[0].idx].val;
+		else
+			*val =3D btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1060,7 +1068,6 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
 int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core=
_spec *spec)
 {
 	const struct btf_type *t;
-	const struct btf_enum *e;
 	const char *s;
 	__u32 type_id;
 	int i, len =3D 0;
@@ -1089,10 +1096,23 @@ int bpf_core_format_spec(char *buf, size_t buf_sz=
, const struct bpf_core_spec *s
=20
 	if (core_relo_is_enumval_based(spec->relo_kind)) {
 		t =3D skip_mods_and_typedefs(spec->btf, type_id, NULL);
-		e =3D btf_enum(t) + spec->raw_spec[0];
-		s =3D btf__name_by_offset(spec->btf, e->name_off);
+		if (btf_is_enum(t)) {
+			const struct btf_enum *e;
+			const char *fmt_str;
+
+			e =3D btf_enum(t) + spec->raw_spec[0];
+			s =3D btf__name_by_offset(spec->btf, e->name_off);
+			fmt_str =3D BTF_INFO_KFLAG(t->info) ? "::%s =3D %d" : "::%s =3D %u";
+			append_buf(fmt_str, s, e->val);
+		} else {
+			const struct btf_enum64 *e;
+			const char *fmt_str;
=20
-		append_buf("::%s =3D %u", s, e->val);
+			e =3D btf_enum64(t) + spec->raw_spec[0];
+			s =3D btf__name_by_offset(spec->btf, e->name_off);
+			fmt_str =3D BTF_INFO_KFLAG(t->info) ? "::%s =3D %lld" : "::%s =3D %ll=
u";
+			append_buf(fmt_str, s, (unsigned long long)btf_enum64_value(e));
+		}
 		return len;
 	}
=20
--=20
2.30.2

