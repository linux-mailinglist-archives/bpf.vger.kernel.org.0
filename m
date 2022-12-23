Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCE654C47
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiLWFto convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiLWFti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809D2657E
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:37 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN3kwjS027926
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:37 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mmgpbf11u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:37 -0800
Received: from twshared22340.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 11B3723EA75F6; Thu, 22 Dec 2022 21:49:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/7] bpf: perform byte-by-byte comparison only when necessary in regsafe()
Date:   Thu, 22 Dec 2022 21:49:19 -0800
Message-ID: <20221223054921.958283-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OWJ3_ILu9UStV_M08Ge-N4p7hsWooDEb
X-Proofpoint-ORIG-GUID: OWJ3_ILu9UStV_M08Ge-N4p7hsWooDEb
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

Extract byte-by-byte comparison of bpf_reg_state in regsafe() into
a helper function, which makes it more convenient to use it "on demand"
only for registers that benefit from such checks, instead of doing it
all the time, even if result of such comparison is ignored.

Also, remove WARN_ON_ONCE(1)+return false dead code. There is no risk of
missing some case as compiler will warn about non-void function not
returning value in some branches (and that under assumption that default
case is removed in the future).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5133d0a5b0cb..6431b994b3f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13057,18 +13057,19 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 	}
 }
 
+static bool regs_exact(const struct bpf_reg_state *rold,
+		       const struct bpf_reg_state *rcur)
+{
+	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
+}
+
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
 {
-	bool equal;
-
 	if (!(rold->live & REG_LIVE_READ))
 		/* explored state didn't use this */
 		return true;
-
-	equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
-
 	if (rold->type == NOT_INIT)
 		/* explored state can't have used this */
 		return true;
@@ -13101,7 +13102,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
-		if (equal)
+		if (regs_exact(rold, rcur))
 			return true;
 		if (env->explore_alu_limits)
 			return false;
@@ -13144,15 +13145,11 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* two stack pointers are equal only if they're pointing to
 		 * the same stack frame, since fp-8 in foo != fp-8 in bar
 		 */
-		return equal && rold->frameno == rcur->frameno;
+		return regs_exact(rold, rcur) && rold->frameno == rcur->frameno;
 	default:
 		/* Only valid matches are exact, which memcmp() */
-		return equal;
+		return regs_exact(rold, rcur);
 	}
-
-	/* Shouldn't get here; if we do, say it's not safe */
-	WARN_ON_ONCE(1);
-	return false;
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-- 
2.30.2

