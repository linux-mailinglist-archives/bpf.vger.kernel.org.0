Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C254654C48
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiLWFtt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLWFtp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B792A52D
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:44 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN3uSN5001003
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:44 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mmc5jraq2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:44 -0800
Received: from twshared22340.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2868823EA760D; Thu, 22 Dec 2022 21:49:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 7/7] bpf: unify PTR_TO_MAP_{KEY,VALUE} with default case in regsafe()
Date:   Thu, 22 Dec 2022 21:49:21 -0800
Message-ID: <20221223054921.958283-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9QXaeyhpkRxU8lnbpiae7djTDlTLxtuJ
X-Proofpoint-ORIG-GUID: 9QXaeyhpkRxU8lnbpiae7djTDlTLxtuJ
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

Make default case in regsafe() safer. Instead of doing byte-by-byte
comparison, take into account ID remapping and also range and var_off
checks. For most of registers range and var_off will be zero (not set),
which doesn't matter. For some, like PTR_TO_MAP_{KEY,VALUE}, this
generalized logic is exactly matching what regsafe() was doing as
a special case. But in any case, if register has id and/or ref_obj_id
set, check it using check_ids() logic, taking into account idmap.

With these changes, default case should be handling most registers more
correctly, and even for future register would be a good default. For some
special cases, like PTR_TO_PACKET, one would still need to implement extra
checks (like special handling of reg->range) to get better state
equivalence, but default logic shouldn't be wrong.

With these changes veristat shows no difference in verifier stats across
selftests and Cilium BPF programs (which is a good thing).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b23812d2bb49..7e0fa3924f01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12919,8 +12919,8 @@ static int check_btf_info(struct bpf_verifier_env *env,
 }
 
 /* check %cur's range satisfies %old's */
-static bool range_within(struct bpf_reg_state *old,
-			 struct bpf_reg_state *cur)
+static bool range_within(const struct bpf_reg_state *old,
+			 const struct bpf_reg_state *cur)
 {
 	return old->umin_value <= cur->umin_value &&
 	       old->umax_value >= cur->umax_value &&
@@ -13073,6 +13073,17 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 }
 
+static bool regs_equal(const struct bpf_reg_state *rold,
+		       const struct bpf_reg_state *rcur,
+		       struct bpf_id_pair *idmap)
+{
+	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
+	       range_within(rold, rcur) &&
+	       tnum_in(rold->var_off, rcur->var_off) &&
+	       check_ids(rold->id, rcur->id, idmap) &&
+	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+}
+
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
@@ -13121,15 +13132,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-	case PTR_TO_MAP_KEY:
-	case PTR_TO_MAP_VALUE:
-		/* If the new min/max/var_off satisfy the old ones and
-		 * everything else matches, we are OK.
-		 */
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
-		       range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off) &&
-		       check_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		/* We must have at least as much range as the old ptr
@@ -13157,7 +13159,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 */
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
 	default:
-		return regs_exact(rold, rcur, idmap);
+		return regs_equal(rold, rcur, idmap);
 	}
 }
 
-- 
2.30.2

