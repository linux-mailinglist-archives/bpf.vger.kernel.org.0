Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C21654C45
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiLWFtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLWFti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04552A513
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:37 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN3kwjT027926
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:37 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mmgpbf11u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:37 -0800
Received: from twshared22340.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0552323EA75C6; Thu, 22 Dec 2022 21:49:31 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/7] bpf: reject non-exact register type matches in regsafe()
Date:   Thu, 22 Dec 2022 21:49:18 -0800
Message-ID: <20221223054921.958283-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: et5u-UEpLfp9zvzj4hktyysReKKoTZif
X-Proofpoint-ORIG-GUID: et5u-UEpLfp9zvzj4hktyysReKKoTZif
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

Generalize the (somewhat implicit) rule of regsafe(), which states that
if register types in old and current states do not match *exactly*, they
can't be safely considered equivalent.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 45 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 218a7ace4210..5133d0a5b0cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13075,18 +13075,28 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	if (rcur->type == NOT_INIT)
 		return false;
 
-	/* Register types that are *not* MAYBE_NULL could technically be safe
-	 * to use as their MAYBE_NULL variants (e.g., PTR_TO_MAP_VALUE  is
-	 * safe to be used as PTR_TO_MAP_VALUE_OR_NULL, provided both point to
-	 * the same map).
+	/* Enforce that register types have to match exactly, including their
+	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
+	 * rule.
+	 *
+	 * One can make a point that using a pointer register as unbounded
+	 * SCALAR would be technically acceptable, but this could lead to
+	 * pointer leaks because scalars are allowed to leak while pointers
+	 * are not. We could make this safe in special cases if root is
+	 * calling us, but it's probably not worth the hassle.
+	 *
+	 * Also, register types that are *not* MAYBE_NULL could technically be
+	 * safe to use as their MAYBE_NULL variants (e.g., PTR_TO_MAP_VALUE
+	 * is safe to be used as PTR_TO_MAP_VALUE_OR_NULL, provided both point
+	 * to the same map).
 	 * However, if the old MAYBE_NULL register then got NULL checked,
 	 * doing so could have affected others with the same id, and we can't
 	 * check for that because we lost the id when we converted to
 	 * a non-MAYBE_NULL variant.
 	 * So, as a general rule we don't allow mixing MAYBE_NULL and
-	 * non-MAYBE_NULL registers.
+	 * non-MAYBE_NULL registers as well.
 	 */
-	if (type_may_be_null(rold->type) != type_may_be_null(rcur->type))
+	if (rold->type != rcur->type)
 		return false;
 
 	switch (base_type(rold->type)) {
@@ -13095,22 +13105,11 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return true;
 		if (env->explore_alu_limits)
 			return false;
-		if (rcur->type == SCALAR_VALUE) {
-			if (!rold->precise)
-				return true;
-			/* new val must satisfy old val knowledge */
-			return range_within(rold, rcur) &&
-			       tnum_in(rold->var_off, rcur->var_off);
-		} else {
-			/* We're trying to use a pointer in place of a scalar.
-			 * Even if the scalar was unbounded, this could lead to
-			 * pointer leaks because scalars are allowed to leak
-			 * while pointers are not. We could make this safe in
-			 * special cases if root is calling us, but it's
-			 * probably not worth the hassle.
-			 */
-			return false;
-		}
+		if (!rold->precise)
+			return true;
+		/* new val must satisfy old val knowledge */
+		return range_within(rold, rcur) &&
+		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 		/* If the new min/max/var_off satisfy the old ones and
@@ -13122,8 +13121,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       check_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
-		if (rcur->type != rold->type)
-			return false;
 		/* We must have at least as much range as the old ptr
 		 * did, so that any accesses which were safe before are
 		 * still safe.  This is true even if old range < old off,
-- 
2.30.2

