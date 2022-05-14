Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB4526EB9
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiENDM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 23:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiENDM6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 23:12:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC464341A16
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:12:57 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DNXHoc031781
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:12:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KkuIFV18jmTn7i64V5OsydNZZ4aJCH0EainSOfjNwBc=;
 b=EF+emGJ28u96Cwa1FJOPTKtNoQtlSwWEVq1iQ2ApyWW6omSo5quwtr9mEiCm6x5WfHEW
 auP6yp18oQJJNGGUS+HCq+cHOMCjUbTLL1z63piqR8qhreRH+Tb3RHR1Ai8DEoJCDNnP
 ePDTBTUyHrEKwMUrTPE00Lkcog2Wu1Ug3qo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g17w02bak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:12:57 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 20:12:56 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2BA3AA45F453; Fri, 13 May 2022 20:12:53 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 06/18] libbpf: Add enum64 deduplication support
Date:   Fri, 13 May 2022 20:12:53 -0700
Message-ID: <20220514031253.3242578-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514031221.3240268-1-yhs@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oFj7-Y4DsjdwRSCBoSXv6GoTOC6PCeN1
X-Proofpoint-GUID: oFj7-Y4DsjdwRSCBoSXv6GoTOC6PCeN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add enum64 deduplication support. BTF_KIND_ENUM64 handling
is very similar to BTF_KIND_ENUM.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 55 +++++++++++++++++++++++++++++++++------------
 tools/lib/bpf/btf.h |  5 +++++
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3bb6780f710d..016cec84e3dd 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3568,7 +3568,7 @@ static bool btf_equal_int_tag(struct btf_type *t1, =
struct btf_type *t2)
 	return info1 =3D=3D info2;
 }
=20
-/* Calculate type signature hash of ENUM. */
+/* Calculate type signature hash of ENUM/ENUM64. */
 static long btf_hash_enum(struct btf_type *t)
 {
 	long h;
@@ -3580,17 +3580,12 @@ static long btf_hash_enum(struct btf_type *t)
 	return h;
 }
=20
-/* Check structural equality of two ENUMs. */
-static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
+static bool btf_equal_enum32_val(struct btf_type *t1, struct btf_type *t=
2)
 {
 	const struct btf_enum *m1, *m2;
-	__u16 vlen;
+	__u16 vlen =3D btf_vlen(t1);
 	int i;
=20
-	if (!btf_equal_common(t1, t2))
-		return false;
-
-	vlen =3D btf_vlen(t1);
 	m1 =3D btf_enum(t1);
 	m2 =3D btf_enum(t2);
 	for (i =3D 0; i < vlen; i++) {
@@ -3602,15 +3597,44 @@ static bool btf_equal_enum(struct btf_type *t1, s=
truct btf_type *t2)
 	return true;
 }
=20
+static bool btf_equal_enum64_val(struct btf_type *t1, struct btf_type *t=
2)
+{
+	const struct btf_enum64 *m1, *m2;
+	__u16 vlen =3D btf_vlen(t1);
+	int i;
+
+	m1 =3D btf_enum64(t1);
+	m2 =3D btf_enum64(t2);
+	for (i =3D 0; i < vlen; i++) {
+		if (m1->name_off !=3D m2->name_off || m1->val_lo32 !=3D m2->val_lo32 |=
|
+		    m1->val_hi32 !=3D m2->val_hi32)
+			return false;
+		m1++;
+		m2++;
+	}
+	return true;
+}
+
+/* Check structural equality of two ENUMs. */
+static bool btf_equal_enum_or_enum64(struct btf_type *t1, struct btf_typ=
e *t2)
+{
+	if (!btf_equal_common(t1, t2))
+		return false;
+
+	if (btf_is_enum(t1))
+		return btf_equal_enum32_val(t1, t2);
+	return btf_equal_enum64_val(t1, t2);
+}
+
 static inline bool btf_is_enum_fwd(struct btf_type *t)
 {
-	return btf_is_enum(t) && btf_vlen(t) =3D=3D 0;
+	return btf_type_is_any_enum(t) && btf_vlen(t) =3D=3D 0;
 }
=20
-static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
+static bool btf_compat_enum_or_enum64(struct btf_type *t1, struct btf_ty=
pe *t2)
 {
 	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
-		return btf_equal_enum(t1, t2);
+		return btf_equal_enum_or_enum64(t1, t2);
 	/* ignore vlen when comparing */
 	return t1->name_off =3D=3D t2->name_off &&
 	       (t1->info & ~0xffff) =3D=3D (t2->info & ~0xffff) &&
@@ -3829,6 +3853,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h =3D btf_hash_int_decl_tag(t);
 			break;
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 			h =3D btf_hash_enum(t);
 			break;
 		case BTF_KIND_STRUCT:
@@ -3898,15 +3923,16 @@ static int btf_dedup_prim_type(struct btf_dedup *=
d, __u32 type_id)
 		break;
=20
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		h =3D btf_hash_enum(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id =3D (__u32)(long)hash_entry->value;
 			cand =3D btf_type_by_id(d->btf, cand_id);
-			if (btf_equal_enum(t, cand)) {
+			if (btf_equal_enum_or_enum64(t, cand)) {
 				new_id =3D cand_id;
 				break;
 			}
-			if (btf_compat_enum(t, cand)) {
+			if (btf_compat_enum_or_enum64(t, cand)) {
 				if (btf_is_enum_fwd(t)) {
 					/* resolve fwd to full enum */
 					new_id =3D cand_id;
@@ -4211,7 +4237,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, =
__u32 cand_id,
 		return btf_equal_int_tag(cand_type, canon_type);
=20
 	case BTF_KIND_ENUM:
-		return btf_compat_enum(cand_type, canon_type);
+	case BTF_KIND_ENUM64:
+		return btf_compat_enum_or_enum64(cand_type, canon_type);
=20
 	case BTF_KIND_FWD:
 	case BTF_KIND_FLOAT:
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index a41463bf9060..b22c648c69ff 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -531,6 +531,11 @@ static inline bool btf_is_type_tag(const struct btf_=
type *t)
 	return btf_kind(t) =3D=3D BTF_KIND_TYPE_TAG;
 }
=20
+static inline bool btf_type_is_any_enum(const struct btf_type *t)
+{
+	return btf_is_enum(t) || btf_is_enum64(t);
+}
+
 static inline __u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
--=20
2.30.2

