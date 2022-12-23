Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B459654C43
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiLWFtd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWFtc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093F2A270
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:31 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN12sDP021667
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mmgpbf11a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:31 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:30 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D285823EA75AC; Thu, 22 Dec 2022 21:49:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/7] bpf: reorganize struct bpf_reg_state fields
Date:   Thu, 22 Dec 2022 21:49:16 -0800
Message-ID: <20221223054921.958283-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: V5Vq5sdW7lFiIS9xYmJH9GLHtRsMDK0e
X-Proofpoint-ORIG-GUID: V5Vq5sdW7lFiIS9xYmJH9GLHtRsMDK0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_02,2022-12-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move id and ref_obj_id fields after scalar data section (var_off and
ranges). This is necessary to simplify next patch which will change
regsafe()'s logic to be safer, as it makes the contents that has to be
an exact match (type-specific parts, off, type, and var_off+ranges)
a single sequential block of memory, while id and ref_obj_id should
always be remapped and thus can't be memcp()'ed.

There are few places that assume that var_off is after id/ref_obj_id to
clear out id/ref_obj_id with the single memset(0). These are changed to
explicitly zero-out id/ref_obj_id fields. Other places are adjusted to
preserve exact byte-by-byte comparison behavior.

No functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 40 ++++++++++++++++++------------------
 kernel/bpf/verifier.c        | 17 ++++++++-------
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 53d175cbaa02..127058cfec47 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -92,6 +92,26 @@ struct bpf_reg_state {
 
 		u32 subprogno; /* for PTR_TO_FUNC */
 	};
+	/* For scalar types (SCALAR_VALUE), this represents our knowledge of
+	 * the actual value.
+	 * For pointer types, this represents the variable part of the offset
+	 * from the pointed-to object, and is shared with all bpf_reg_states
+	 * with the same id as us.
+	 */
+	struct tnum var_off;
+	/* Used to determine if any memory access using this register will
+	 * result in a bad access.
+	 * These refer to the same value as var_off, not necessarily the actual
+	 * contents of the register.
+	 */
+	s64 smin_value; /* minimum possible (s64)value */
+	s64 smax_value; /* maximum possible (s64)value */
+	u64 umin_value; /* minimum possible (u64)value */
+	u64 umax_value; /* maximum possible (u64)value */
+	s32 s32_min_value; /* minimum possible (s32)value */
+	s32 s32_max_value; /* maximum possible (s32)value */
+	u32 u32_min_value; /* minimum possible (u32)value */
+	u32 u32_max_value; /* maximum possible (u32)value */
 	/* For PTR_TO_PACKET, used to find other pointers with the same variable
 	 * offset, so they can share range knowledge.
 	 * For PTR_TO_MAP_VALUE_OR_NULL this is used to share which map value we
@@ -144,26 +164,6 @@ struct bpf_reg_state {
 	 * allowed and has the same effect as bpf_sk_release(sk).
 	 */
 	u32 ref_obj_id;
-	/* For scalar types (SCALAR_VALUE), this represents our knowledge of
-	 * the actual value.
-	 * For pointer types, this represents the variable part of the offset
-	 * from the pointed-to object, and is shared with all bpf_reg_states
-	 * with the same id as us.
-	 */
-	struct tnum var_off;
-	/* Used to determine if any memory access using this register will
-	 * result in a bad access.
-	 * These refer to the same value as var_off, not necessarily the actual
-	 * contents of the register.
-	 */
-	s64 smin_value; /* minimum possible (s64)value */
-	s64 smax_value; /* maximum possible (s64)value */
-	u64 umin_value; /* minimum possible (u64)value */
-	u64 umax_value; /* maximum possible (u64)value */
-	s32 s32_min_value; /* minimum possible (s32)value */
-	s32 s32_max_value; /* maximum possible (s32)value */
-	u32 u32_min_value; /* minimum possible (u32)value */
-	u32 u32_max_value; /* maximum possible (u32)value */
 	/* parentage chain for liveness checking */
 	struct bpf_reg_state *parent;
 	/* Inside the callee two registers can be both PTR_TO_STACK like
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ab8337f6a576..e419e6024251 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1402,9 +1402,11 @@ static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
  */
 static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
-	/* Clear id, off, and union(map_ptr, range) */
+	/* Clear off and union(map_ptr, range) */
 	memset(((u8 *)reg) + sizeof(reg->type), 0,
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
+	reg->id = 0;
+	reg->ref_obj_id = 0;
 	___mark_reg_known(reg, imm);
 }
 
@@ -1750,11 +1752,13 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
 {
 	/*
-	 * Clear type, id, off, and union(map_ptr, range) and
+	 * Clear type, off, and union(map_ptr, range) and
 	 * padding between 'type' and union
 	 */
 	memset(reg, 0, offsetof(struct bpf_reg_state, var_off));
 	reg->type = SCALAR_VALUE;
+	reg->id = 0;
+	reg->ref_obj_id = 0;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
 	reg->precise = !env->bpf_capable;
@@ -13104,7 +13108,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (type_may_be_null(rold->type)) {
 			if (!type_may_be_null(rcur->type))
 				return false;
-			if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)))
+			if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)))
 				return false;
 			/* Check our ids match any regs they're supposed to */
 			return check_ids(rold->id, rcur->id, idmap);
@@ -13112,13 +13116,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
-		 * 'id' is not compared, since it's only used for maps with
-		 * bpf_spin_lock inside map element and in such cases if
-		 * the rest of the prog is valid for one map element then
-		 * it's valid for all map elements regardless of the key
-		 * used in bpf_map_lookup()
 		 */
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap);
-- 
2.30.2

