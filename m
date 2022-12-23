Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94549654C46
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLWFth convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLWFth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:37 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2D2657E
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:36 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN144se005437
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:36 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mmc5jrap4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:35 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EB1F823EA75B6; Thu, 22 Dec 2022 21:49:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/7] bpf: generalize MAYBE_NULL vs non-MAYBE_NULL rule
Date:   Thu, 22 Dec 2022 21:49:17 -0800
Message-ID: <20221223054921.958283-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: isQUbYDqhwOvw182uQFwXNi5ODW5q7iz
X-Proofpoint-ORIG-GUID: isQUbYDqhwOvw182uQFwXNi5ODW5q7iz
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

Make generic check to prevent XXX_OR_NULL and XXX register types to be
intermixed. While technically in some situations it could be safe, it's
impossible to enforce due to the loss of an ID when converting
XXX_OR_NULL to its non-NULL variant. So prevent this in general, not
just for PTR_TO_MAP_KEY and PTR_TO_MAP_VALUE.

PTR_TO_MAP_KEY_OR_NULL and PTR_TO_MAP_VALUE_OR_NULL checks, which were
previously special-cased, are simplified to generic check that takes
into account range_within() and tnum_in(). This is correct as BPF
verifier doesn't allow arithmetic on XXX_OR_NULL register types, so
var_off and ranges should stay zero. But even if in the future this
restriction is lifted, it's even more important to enforce that var_off
and ranges are compatible, otherwise it's possible to construct case
where this can be exploited to bypass verifier's memory range safety
checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e419e6024251..218a7ace4210 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13074,6 +13074,21 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return true;
 	if (rcur->type == NOT_INIT)
 		return false;
+
+	/* Register types that are *not* MAYBE_NULL could technically be safe
+	 * to use as their MAYBE_NULL variants (e.g., PTR_TO_MAP_VALUE  is
+	 * safe to be used as PTR_TO_MAP_VALUE_OR_NULL, provided both point to
+	 * the same map).
+	 * However, if the old MAYBE_NULL register then got NULL checked,
+	 * doing so could have affected others with the same id, and we can't
+	 * check for that because we lost the id when we converted to
+	 * a non-MAYBE_NULL variant.
+	 * So, as a general rule we don't allow mixing MAYBE_NULL and
+	 * non-MAYBE_NULL registers.
+	 */
+	if (type_may_be_null(rold->type) != type_may_be_null(rcur->type))
+		return false;
+
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
 		if (equal)
@@ -13098,22 +13113,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		}
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
-		/* a PTR_TO_MAP_VALUE could be safe to use as a
-		 * PTR_TO_MAP_VALUE_OR_NULL into the same map.
-		 * However, if the old PTR_TO_MAP_VALUE_OR_NULL then got NULL-
-		 * checked, doing so could have affected others with the same
-		 * id, and we can't check for that because we lost the id when
-		 * we converted to a PTR_TO_MAP_VALUE.
-		 */
-		if (type_may_be_null(rold->type)) {
-			if (!type_may_be_null(rcur->type))
-				return false;
-			if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)))
-				return false;
-			/* Check our ids match any regs they're supposed to */
-			return check_ids(rold->id, rcur->id, idmap);
-		}
-
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 */
-- 
2.30.2

