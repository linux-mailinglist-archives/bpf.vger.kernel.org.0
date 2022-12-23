Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56C654C49
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiLWFtu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLWFts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C72A27F
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:47 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN13ATV021737
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:47 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mmgpbf13c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:47 -0800
Received: from twshared19054.43.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1C0C123EA7602; Thu, 22 Dec 2022 21:49:36 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/7] bpf: fix regs_exact() logic in regsafe() to remap IDs correctly
Date:   Thu, 22 Dec 2022 21:49:20 -0800
Message-ID: <20221223054921.958283-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UZjIc_5TegUe63eoifGxlGpf7sxBfjQP
X-Proofpoint-ORIG-GUID: UZjIc_5TegUe63eoifGxlGpf7sxBfjQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_02,2022-12-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Comparing IDs exactly between two separate states is not just
suboptimal, but also incorrect in some cases. So update regs_exact()
check to do byte-by-byte memcmp() only up to id/ref_obj_id. For id and
ref_obj_id perform proper check_ids() checks, taking into account idmap.

This change makes more states equivalent improving insns and states
stats across a bunch of selftest BPF programs:

File                                         Program                           Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
-------------------------------------------  --------------------------------  ---------  ---------  --------------  ----------  ----------  -------------
cgrp_kfunc_success.bpf.linked1.o             test_cgrp_get_release                   141        137     -4 (-2.84%)          13          13    +0 (+0.00%)
cgrp_kfunc_success.bpf.linked1.o             test_cgrp_xchg_release                  142        139     -3 (-2.11%)          14          13    -1 (-7.14%)
connect6_prog.bpf.linked1.o                  connect_v6_prog                         139        102   -37 (-26.62%)           9           6   -3 (-33.33%)
ima.bpf.linked1.o                            bprm_creds_for_exec                      68         61    -7 (-10.29%)           6           5   -1 (-16.67%)
linked_list.bpf.linked1.o                    global_list_in_list                     569        499   -70 (-12.30%)          60          52   -8 (-13.33%)
linked_list.bpf.linked1.o                    global_list_push_pop                    167        150   -17 (-10.18%)          18          16   -2 (-11.11%)
linked_list.bpf.linked1.o                    global_list_push_pop_multiple           881        815    -66 (-7.49%)          74          63  -11 (-14.86%)
linked_list.bpf.linked1.o                    inner_map_list_in_list                  579        534    -45 (-7.77%)          61          55    -6 (-9.84%)
linked_list.bpf.linked1.o                    inner_map_list_push_pop                 190        181     -9 (-4.74%)          19          18    -1 (-5.26%)
linked_list.bpf.linked1.o                    inner_map_list_push_pop_multiple        916        850    -66 (-7.21%)          75          64  -11 (-14.67%)
linked_list.bpf.linked1.o                    map_list_in_list                        588        525   -63 (-10.71%)          62          55   -7 (-11.29%)
linked_list.bpf.linked1.o                    map_list_push_pop                       183        174     -9 (-4.92%)          18          17    -1 (-5.56%)
linked_list.bpf.linked1.o                    map_list_push_pop_multiple              909        843    -66 (-7.26%)          75          64  -11 (-14.67%)
map_kptr.bpf.linked1.o                       test_map_kptr                           264        256     -8 (-3.03%)          26          26    +0 (+0.00%)
map_kptr.bpf.linked1.o                       test_map_kptr_ref                        95         91     -4 (-4.21%)           9           8   -1 (-11.11%)
task_kfunc_success.bpf.linked1.o             test_task_xchg_release                  139        136     -3 (-2.16%)          14          13    -1 (-7.14%)
test_bpf_nf.bpf.linked1.o                    nf_skb_ct_test                          815        509  -306 (-37.55%)          57          30  -27 (-47.37%)
test_bpf_nf.bpf.linked1.o                    nf_xdp_ct_test                          815        509  -306 (-37.55%)          57          30  -27 (-47.37%)
test_cls_redirect.bpf.linked1.o              cls_redirect                          78925      78390   -535 (-0.68%)        4782        4704   -78 (-1.63%)
test_cls_redirect_subprogs.bpf.linked1.o     cls_redirect                          64901      63897  -1004 (-1.55%)        4612        4470  -142 (-3.08%)
test_sk_lookup.bpf.linked1.o                 access_ctx_sk                           181         95   -86 (-47.51%)          19          10   -9 (-47.37%)
test_sk_lookup.bpf.linked1.o                 ctx_narrow_access                       447        437    -10 (-2.24%)          38          37    -1 (-2.63%)
test_sk_lookup_kern.bpf.linked1.o            sk_lookup_success                       148        133   -15 (-10.14%)          14          12   -2 (-14.29%)
test_tcp_check_syncookie_kern.bpf.linked1.o  check_syncookie_clsact                  304        300     -4 (-1.32%)          23          22    -1 (-4.35%)
test_tcp_check_syncookie_kern.bpf.linked1.o  check_syncookie_xdp                     304        300     -4 (-1.32%)          23          22    -1 (-4.35%)
test_verify_pkcs7_sig.bpf.linked1.o          bpf                                      87         76   -11 (-12.64%)           7           6   -1 (-14.29%)
-------------------------------------------  --------------------------------  ---------  ---------  --------------  ----------  ----------  -------------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6431b994b3f6..b23812d2bb49 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12946,6 +12946,13 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
 {
 	unsigned int i;
 
+	/* either both IDs should be set or both should be zero */
+	if (!!old_id != !!cur_id)
+		return false;
+
+	if (old_id == 0) /* cur_id == 0 as well */
+		return true;
+
 	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
 		if (!idmap[i].old) {
 			/* Reached an empty slot; haven't seen this id before */
@@ -13058,9 +13065,12 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 }
 
 static bool regs_exact(const struct bpf_reg_state *rold,
-		       const struct bpf_reg_state *rcur)
+		       const struct bpf_reg_state *rcur,
+		       struct bpf_id_pair *idmap)
 {
-	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
+	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 && 
+	       check_ids(rold->id, rcur->id, idmap) &&
+	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 }
 
 /* Returns true if (rold safe implies rcur safe) */
@@ -13102,7 +13112,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
-		if (regs_exact(rold, rcur))
+		if (regs_exact(rold, rcur, idmap))
 			return true;
 		if (env->explore_alu_limits)
 			return false;
@@ -13136,7 +13146,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (rold->off != rcur->off)
 			return false;
 		/* id relations must be preserved */
-		if (rold->id && !check_ids(rold->id, rcur->id, idmap))
+		if (!check_ids(rold->id, rcur->id, idmap))
 			return false;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
@@ -13145,10 +13155,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* two stack pointers are equal only if they're pointing to
 		 * the same stack frame, since fp-8 in foo != fp-8 in bar
 		 */
-		return regs_exact(rold, rcur) && rold->frameno == rcur->frameno;
+		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
 	default:
-		/* Only valid matches are exact, which memcmp() */
-		return regs_exact(rold, rcur);
+		return regs_exact(rold, rcur, idmap);
 	}
 }
 
-- 
2.30.2

