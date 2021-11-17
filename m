Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9B454E1B
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 20:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhKQTo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 17 Nov 2021 14:44:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240591AbhKQToY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 14:44:24 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AHJdqWn004815
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 11:41:25 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3cd3ahtfw3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 11:41:25 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 11:41:23 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 049FC98F112F; Wed, 17 Nov 2021 11:41:14 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with duplicated structs
Date:   Wed, 17 Nov 2021 11:41:13 -0800
Message-ID: <20211117194114.347675-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Ig_5iSHulreq94IXnZhmklYEnPjnE-En
X-Proofpoint-ORIG-GUID: Ig_5iSHulreq94IXnZhmklYEnPjnE-En
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

According to [0], compilers sometimes might produce duplicate DWARF
definitions for exactly the same struct/union within the same
compilation unit (CU). We've had similar issues with identical arrays
and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
same for struct/union by ensuring that two structs/unions are exactly
the same, down to the integer values of field referenced type IDs.

Solving this more generically (allowing referenced types to be
equivalent, but using different type IDs, all within a single CU)
requires a huge complexity increase to handle many-to-many mappings
between canonidal and candidate type graphs. Before we invest in that,
let's see if this approach handles all the instances of this issue in
practice. Thankfully it's pretty rare, it seems.

  [0] https://lore.kernel.org/bpf/YXr2NFlJTAhHdZqq@krava/

Reported-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b6be579e0dc6..e97217a77196 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3477,8 +3477,8 @@ static long btf_hash_struct(struct btf_type *t)
 }
 
 /*
- * Check structural compatibility of two FUNC_PROTOs, ignoring referenced type
- * IDs. This check is performed during type graph equivalence check and
+ * Check structural compatibility of two STRUCTs/UNIONs, ignoring referenced
+ * type IDs. This check is performed during type graph equivalence check and
  * referenced types equivalence is checked separately.
  */
 static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
@@ -3851,6 +3851,31 @@ static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
 	return btf_equal_array(t1, t2);
 }
 
+/* Check if given two types are identical STRUCT/UNION definitions */
+static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
+{
+	const struct btf_member *m1, *m2;
+	struct btf_type *t1, *t2;
+	int n, i;
+
+	t1 = btf_type_by_id(d->btf, id1);
+	t2 = btf_type_by_id(d->btf, id2);
+
+	if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
+		return false;
+
+	if (!btf_shallow_equal_struct(t1, t2))
+		return false;
+
+	m1 = btf_members(t1);
+	m2 = btf_members(t2);
+	for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
+		if (m1->type != m2->type)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union (we'll
  * call it "candidate graph" in this description for brevity) to a type graph
@@ -3962,6 +3987,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 
 	hypot_type_id = d->hypot_map[canon_id];
 	if (hypot_type_id <= BTF_MAX_NR_TYPES) {
+		if (hypot_type_id == cand_id)
+			return 1;
 		/* In some cases compiler will generate different DWARF types
 		 * for *identical* array type definitions and use them for
 		 * different fields within the *same* struct. This breaks type
@@ -3970,8 +3997,18 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		 * types within a single CU. So work around that by explicitly
 		 * allowing identical array types here.
 		 */
-		return hypot_type_id == cand_id ||
-		       btf_dedup_identical_arrays(d, hypot_type_id, cand_id);
+		if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
+			return 1;
+		/* It turns out that similar situation can happen with
+		 * struct/union sometimes, sigh... Handle the case where
+		 * structs/unions are exactly the same, down to the referenced
+		 * type IDs. Anything more complicated (e.g., if referenced
+		 * types are different, but equivalent) is *way more*
+		 * complicated and requires a many-to-many equivalence mapping.
+		 */
+		if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
+			return 1;
+		return 0;
 	}
 
 	if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
-- 
2.30.2

