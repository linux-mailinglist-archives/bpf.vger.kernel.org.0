Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A374403150
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbhIGXCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32394 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347179AbhIGXCQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187Mxt0X011453
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YFZwEXQ7K3m0D/DEMfBpoTl91tjp6Poj+wYC+KheTu0=;
 b=qX3JWhvBEVo6CmsxJRBuMmrqtxFVDPWj0ciZCpJEUQ7dFuSzxTrzMUYWEY9spPqOFW1H
 pyPjSIKIN5iO+IioOunNuy7m4Tt8LZ9TwyBZiEsyY+yL697jlcG9V1D0h02pldL2xNJN
 8g0RCQDZMfdBdAgYGn/GVCuXj857jPaw7ks= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcq4t7k9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:09 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:01:05 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B6AB46E0C03B; Tue,  7 Sep 2021 16:01:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/9] libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
Date:   Tue, 7 Sep 2021 16:01:00 -0700
Message-ID: <20210907230100.1958061-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: um1_Drr8DnVdI-7bJHGHxB0uO68Wf8BT
X-Proofpoint-ORIG-GUID: um1_Drr8DnVdI-7bJHGHxB0uO68Wf8BT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=450 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch renames functions btf_{hash,equal}_int() to
btf_{hash,equal}_int_tag() so they can be reused for
BTF_KIND_TAG support. There is no functionality change for
this patch.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 77dc24d58302..7cb6ebf1be37 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3256,8 +3256,8 @@ static bool btf_equal_common(struct btf_type *t1, s=
truct btf_type *t2)
 	       t1->size =3D=3D t2->size;
 }
=20
-/* Calculate type signature hash of INT. */
-static long btf_hash_int(struct btf_type *t)
+/* Calculate type signature hash of INT or TAG. */
+static long btf_hash_int_tag(struct btf_type *t)
 {
 	__u32 info =3D *(__u32 *)(t + 1);
 	long h;
@@ -3267,8 +3267,8 @@ static long btf_hash_int(struct btf_type *t)
 	return h;
 }
=20
-/* Check structural equality of two INTs. */
-static bool btf_equal_int(struct btf_type *t1, struct btf_type *t2)
+/* Check structural equality of two INTs or TAGs. */
+static bool btf_equal_int_tag(struct btf_type *t1, struct btf_type *t2)
 {
 	__u32 info1, info2;
=20
@@ -3535,7 +3535,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h =3D btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
-			h =3D btf_hash_int(t);
+			h =3D btf_hash_int_tag(t);
 			break;
 		case BTF_KIND_ENUM:
 			h =3D btf_hash_enum(t);
@@ -3593,11 +3593,11 @@ static int btf_dedup_prim_type(struct btf_dedup *=
d, __u32 type_id)
 		return 0;
=20
 	case BTF_KIND_INT:
-		h =3D btf_hash_int(t);
+		h =3D btf_hash_int_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id =3D (__u32)(long)hash_entry->value;
 			cand =3D btf_type_by_id(d->btf, cand_id);
-			if (btf_equal_int(t, cand)) {
+			if (btf_equal_int_tag(t, cand)) {
 				new_id =3D cand_id;
 				break;
 			}
@@ -3881,7 +3881,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, =
__u32 cand_id,
=20
 	switch (cand_kind) {
 	case BTF_KIND_INT:
-		return btf_equal_int(cand_type, canon_type);
+		return btf_equal_int_tag(cand_type, canon_type);
=20
 	case BTF_KIND_ENUM:
 		if (d->opts.dont_resolve_fwds)
--=20
2.30.2

