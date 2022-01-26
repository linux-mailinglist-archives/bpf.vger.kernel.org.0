Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB85F49C27D
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 05:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiAZEHK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 23:07:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35824 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230036AbiAZEHJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 23:07:09 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PMO1q7006520
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:07:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Y0qKNhCI6ns3DUFil7kHybRw+kFWDsanuiUfhNjuUcI=;
 b=fxiaJ6CFNs//7iGWAk6xiG/xdB9d8xwGMwY3Yy22pgmHJqm0qYnBCULjofb2ZnII68fW
 ZmqbmBEvlHhr1Tc2OL//u8V3dhdWgz9i9NiKVEnnI3tqkExkFz3W7A94wuyuet75pG/S
 WtdrlieCieTY/qSYmW8FELUWXmA3IJvX1Uo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtrpf210v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:07:08 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 20:07:06 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id A32062C1E2B8; Tue, 25 Jan 2022 20:07:01 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v3 4/4] libbpf: Update libbpf to a new revision.
Date:   Tue, 25 Jan 2022 20:05:09 -0800
Message-ID: <20220126040509.1862767-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126040509.1862767-1-kuifeng@fb.com>
References: <20220126040509.1862767-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7q0OnMTzmEaxAUWw09QPgoi_7wtft9uV
X-Proofpoint-ORIG-GUID: 7q0OnMTzmEaxAUWw09QPgoi_7wtft9uV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace deprecated APIs with new ones.
---
 btf_encoder.c | 20 ++++++++++----------
 btf_loader.c  |  2 +-
 lib/bpf       |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 56a76f5d7275..a31dbe3edc93 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -172,7 +172,7 @@ __attribute ((format (printf, 5, 6)))
 static void btf__log_err(const struct btf *btf, int kind, const char *na=
me,
 			 bool output_cr, const char *fmt, ...)
 {
-	fprintf(stderr, "[%u] %s %s", btf__get_nr_types(btf) + 1,
+	fprintf(stderr, "[%u] %s %s", btf__type_cnt(btf),
 		btf_kind_str[kind], name ?: "(anon)");
=20
 	if (fmt && *fmt) {
@@ -203,7 +203,7 @@ static void btf_encoder__log_type(const struct btf_en=
coder *encoder, const struc
 	out =3D err ? stderr : stdout;
=20
 	fprintf(out, "[%u] %s %s",
-		btf__get_nr_types(btf), btf_kind_str[kind],
+		btf__type_cnt(btf) - 1, btf_kind_str[kind],
 		btf__printable_name(btf, t->name_off));
=20
 	if (fmt && *fmt) {
@@ -449,10 +449,10 @@ static int btf_encoder__add_field(struct btf_encode=
r *encoder, const char *name,
 	int err;
=20
 	err =3D btf__add_field(btf, name, type, offset, bitfield_size);
-	t =3D btf__type_by_id(btf, btf__get_nr_types(btf));
+	t =3D btf__type_by_id(btf, btf__type_cnt(btf) - 1);
 	if (err) {
 		fprintf(stderr, "[%u] %s %s's field '%s' offset=3D%u bit_size=3D%u typ=
e=3D%u Error emitting field\n",
-			btf__get_nr_types(btf), btf_kind_str[btf_kind(t)],
+			btf__type_cnt(btf) - 1, btf_kind_str[btf_kind(t)],
 			btf__printable_name(btf, t->name_off),
 			name, offset, bitfield_size, type);
 	} else {
@@ -899,9 +899,9 @@ static int btf_encoder__write_raw_file(struct btf_enc=
oder *encoder)
 	const void *raw_btf_data;
 	int fd, err;
=20
-	raw_btf_data =3D btf__get_raw_data(encoder->btf, &raw_btf_size);
+	raw_btf_data =3D btf__raw_data(encoder->btf, &raw_btf_size);
 	if (raw_btf_data =3D=3D NULL) {
-		fprintf(stderr, "%s: btf__get_raw_data failed!\n", __func__);
+		fprintf(stderr, "%s: btf__raw_data failed!\n", __func__);
 		return -1;
 	}
=20
@@ -976,7 +976,7 @@ static int btf_encoder__write_elf(struct btf_encoder =
*encoder)
 		}
 	}
=20
-	raw_btf_data =3D btf__get_raw_data(btf, &raw_btf_size);
+	raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
=20
 	if (btf_data) {
 		/* Existing .BTF section found */
@@ -1043,10 +1043,10 @@ int btf_encoder__encode(struct btf_encoder *encod=
er)
 		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
=20
 	/* Empty file, nothing to do, so... done! */
-	if (btf__get_nr_types(encoder->btf) =3D=3D 0)
+	if (btf__type_cnt(encoder->btf) - 1 =3D=3D 0)
 		return 0;
=20
-	if (btf__dedup(encoder->btf, NULL, NULL)) {
+	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
 	}
@@ -1403,7 +1403,7 @@ void btf_encoder__delete(struct btf_encoder *encode=
r)
=20
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
 {
-	uint32_t type_id_off =3D btf__get_nr_types(encoder->btf);
+	uint32_t type_id_off =3D btf__type_cnt(encoder->btf) - 1;
 	struct llvm_annotation *annot;
 	int btf_type_id, tag_type_id;
 	uint32_t core_id;
diff --git a/btf_loader.c b/btf_loader.c
index b61cadd55127..d9d59aa889a0 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -399,7 +399,7 @@ static int btf__load_types(struct btf *btf, struct cu=
 *cu)
 	uint32_t type_index;
 	int err;
=20
-	for (type_index =3D 1; type_index <=3D btf__get_nr_types(btf); type_ind=
ex++) {
+	for (type_index =3D 1; type_index <=3D btf__type_cnt(btf) - 1; type_ind=
ex++) {
 		const struct btf_type *type_ptr =3D btf__type_by_id(btf, type_index);
 		uint32_t type =3D btf_kind(type_ptr);
=20
diff --git a/lib/bpf b/lib/bpf
index 94a49850c5ee..393a058d061d 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 94a49850c5ee61ea02dfcbabf48013391e8cecdf
+Subproject commit 393a058d061d49d5c3055fa9eefafb4c0c31ccc3
--=20
2.30.2

