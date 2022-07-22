Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8557E694
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGVSe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiGVSe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:34:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A881485
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:56 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26MHoqBh024211
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0U6H34c0tdqJjcCxGt7q7fxnft7oVj9bPnjTSrQQtMM=;
 b=qyAkphqgbTtQKH9PZXC1PzCr34DX+YDrDa2JO8HHJOPkGGZIeL6Bq7WCDPmmKEuXwODX
 Yr34oYJUU0x69cG6yXsZKCOIwS+jtSG/qqj5ehUoE9BI2JA7scCnJA4DPi4h6MER1lc1
 Q4k/z5YDja/y7cAayfVgyFSGWz0yYZILMxQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hg0n708yq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:34:55 -0700
Received: from twshared39111.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:34:53 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 5C631AB6F193; Fri, 22 Jul 2022 11:34:45 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 01/11] bpf: Pull repeated reg access bounds check into helper fn
Date:   Fri, 22 Jul 2022 11:34:28 -0700
Message-ID: <20220722183438.3319790-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5EZfN1u7Ms3iJ0St8dfPnDwQOD7SypYm
X-Proofpoint-GUID: 5EZfN1u7Ms3iJ0St8dfPnDwQOD7SypYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verifier's check_map_access function has some duplicated bounds checking
arithmetic to determine whether a map element access might touch a
protected field (bpf_spin_lock and bpf_timer). Pull this logic out into
new reg_access_may_touch_field helper function to improve readability
and understandability of the code.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ceccc420db3..c5fbaa9f025a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3783,6 +3783,19 @@ static int check_map_kptr_access(struct bpf_verifi=
er_env *env, u32 regno,
 	return 0;
 }
=20
+/* if any part of struct field can be touched by
+ * load/store reject this program.
+ * To check that [x1, x2) overlaps with [y1, y2)
+ * it is sufficient to check x1 < y2 && y1 < x2.
+ */
+static bool reg_access_may_touch_field(const struct bpf_reg_state *reg,
+				       u32 access_off, size_t access_sz,
+				       u32 field_off, size_t field_sz)
+{
+	return reg->smin_value + access_off < field_off + field_sz &&
+			field_off < reg->umax_value + access_off + access_sz;
+}
+
 /* check read/write into a map element with possible variable offset */
 static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			    int off, int size, bool zero_size_allowed,
@@ -3800,15 +3813,9 @@ static int check_map_access(struct bpf_verifier_en=
v *env, u32 regno,
 		return err;
=20
 	if (map_value_has_spin_lock(map)) {
-		u32 lock =3D map->spin_lock_off;
+		u32 t =3D map->spin_lock_off;
=20
-		/* if any part of struct bpf_spin_lock can be touched by
-		 * load/store reject this program.
-		 * To check that [x1, x2) overlaps with [y1, y2)
-		 * it is sufficient to check x1 < y2 && y1 < x2.
-		 */
-		if (reg->smin_value + off < lock + sizeof(struct bpf_spin_lock) &&
-		     lock < reg->umax_value + off + size) {
+		if (reg_access_may_touch_field(reg, off, size, t, sizeof(struct bpf_sp=
in_lock))) {
 			verbose(env, "bpf_spin_lock cannot be accessed directly by load/store=
\n");
 			return -EACCES;
 		}
@@ -3816,8 +3823,7 @@ static int check_map_access(struct bpf_verifier_env=
 *env, u32 regno,
 	if (map_value_has_timer(map)) {
 		u32 t =3D map->timer_off;
=20
-		if (reg->smin_value + off < t + sizeof(struct bpf_timer) &&
-		     t < reg->umax_value + off + size) {
+		if (reg_access_may_touch_field(reg, off, size, t, sizeof(struct bpf_ti=
mer))) {
 			verbose(env, "bpf_timer cannot be accessed directly by load/store\n")=
;
 			return -EACCES;
 		}
--=20
2.30.2

