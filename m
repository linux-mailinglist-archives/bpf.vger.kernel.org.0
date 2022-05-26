Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229A45353A1
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbiEZSzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348543AbiEZSzM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:55:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DE6C8BF1
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QInu0J022421
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kDvpRGW+SpeVOM+IJnN/edaiVNHDjr8QfgfbAlc9Isc=;
 b=Q8lsVNHPLn4bwscCBvKOrqQaBn11rc15HCPB5LzoUTWszHshMBychUY44oglvbFGEORY
 nDMPQYXaMzd4dQTjNeLQQ4tp5kYB0sCNaa7HZUGZsPNJDNeNEKIVYJFjmtTGcckdDUMn
 1QLzuNUUQpGP8uKQqLfEYB1fnCiHpEdkUwY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ga5x8uwxh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:55:09 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:55:08 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D794EAD83CF5; Thu, 26 May 2022 11:55:03 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 06/18] libbpf: Add enum64 deduplication support
Date:   Thu, 26 May 2022 11:55:03 -0700
Message-ID: <20220526185503.2548083-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tFBOGI3Z6qVi-39n3t1ZyOHUg7DMnuCD
X-Proofpoint-GUID: tFBOGI3Z6qVi-39n3t1ZyOHUg7DMnuCD
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

Add enum64 deduplication support. BTF_KIND_ENUM64 handling
is very similar to BTF_KIND_ENUM.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 62 +++++++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h |  5 ++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3bb6780f710d..78507dfa9fcb 100644
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
@@ -3602,9 +3602,31 @@ static bool btf_equal_enum(struct btf_type *t1, st=
ruct btf_type *t2)
 	return true;
 }
=20
+static bool btf_equal_enum64(struct btf_type *t1, struct btf_type *t2)
+{
+	const struct btf_enum64 *m1, *m2;
+	__u16 vlen;
+	int i;
+
+	if (!btf_equal_common(t1, t2))
+		return false;
+
+	vlen =3D btf_vlen(t1);
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
 static inline bool btf_is_enum_fwd(struct btf_type *t)
 {
-	return btf_is_enum(t) && btf_vlen(t) =3D=3D 0;
+	return btf_type_is_any_enum(t) && btf_vlen(t) =3D=3D 0;
 }
=20
 static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
@@ -3617,6 +3639,17 @@ static bool btf_compat_enum(struct btf_type *t1, s=
truct btf_type *t2)
 	       t1->size =3D=3D t2->size;
 }
=20
+static bool btf_compat_enum64(struct btf_type *t1, struct btf_type *t2)
+{
+	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
+		return btf_equal_enum64(t1, t2);
+
+	/* ignore vlen when comparing */
+	return t1->name_off =3D=3D t2->name_off &&
+	       (t1->info & ~0xffff) =3D=3D (t2->info & ~0xffff) &&
+	       t1->size =3D=3D t2->size;
+}
+
 /*
  * Calculate type signature hash of STRUCT/UNION, ignoring referenced ty=
pe IDs,
  * as referenced type IDs equivalence is established separately during t=
ype
@@ -3829,6 +3862,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h =3D btf_hash_int_decl_tag(t);
 			break;
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 			h =3D btf_hash_enum(t);
 			break;
 		case BTF_KIND_STRUCT:
@@ -3918,6 +3952,27 @@ static int btf_dedup_prim_type(struct btf_dedup *d=
, __u32 type_id)
 		}
 		break;
=20
+	case BTF_KIND_ENUM64:
+		h =3D btf_hash_enum(t);
+		for_each_dedup_cand(d, hash_entry, h) {
+			cand_id =3D (__u32)(long)hash_entry->value;
+			cand =3D btf_type_by_id(d->btf, cand_id);
+			if (btf_equal_enum64(t, cand)) {
+				new_id =3D cand_id;
+				break;
+			}
+			if (btf_compat_enum64(t, cand)) {
+				if (btf_is_enum_fwd(t)) {
+					/* resolve fwd to full enum */
+					new_id =3D cand_id;
+					break;
+				}
+				/* resolve canonical enum fwd to full enum */
+				d->map[cand_id] =3D type_id;
+			}
+		}
+		break;
+
 	case BTF_KIND_FWD:
 	case BTF_KIND_FLOAT:
 		h =3D btf_hash_common(t);
@@ -4213,6 +4268,9 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, =
__u32 cand_id,
 	case BTF_KIND_ENUM:
 		return btf_compat_enum(cand_type, canon_type);
=20
+	case BTF_KIND_ENUM64:
+		return btf_compat_enum64(cand_type, canon_type);
+
 	case BTF_KIND_FWD:
 	case BTF_KIND_FLOAT:
 		return btf_equal_common(cand_type, canon_type);
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

