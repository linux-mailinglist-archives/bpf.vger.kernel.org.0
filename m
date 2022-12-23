Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE1654C42
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLWFtg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Dec 2022 00:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWFtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 00:49:35 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC52E2657E
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:34 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN13QJP013297
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:34 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mm4p9a6qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 21:49:34 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 21:49:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BE0C223EA756C; Thu, 22 Dec 2022 21:49:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/7] bpf: teach refsafe() to take into account ID remapping
Date:   Thu, 22 Dec 2022 21:49:15 -0800
Message-ID: <20221223054921.958283-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221223054921.958283-1-andrii@kernel.org>
References: <20221223054921.958283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0EarYQsKS6Qp9y65012eJ-TiovbDuBct
X-Proofpoint-ORIG-GUID: 0EarYQsKS6Qp9y65012eJ-TiovbDuBct
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

states_equal() check performs ID mapping between old and new states to
establish a 1-to-1 correspondence between IDs, even if their absolute
numberic values across two equivalent states differ. This is important
both for correctness and to avoid unnecessary work when two states are
equivalent.

With recent changes we partially fixed this logic by maintaining ID map
across all function frames. This patch also makes refsafe() check take
into account (and maintain) ID map, making states_equal() behavior more
optimal and correct.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa358b3d5d7..ab8337f6a576 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13223,12 +13223,20 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	return true;
 }
 
-static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur)
+static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
+		    struct bpf_id_pair *idmap)
 {
+	int i;
+
 	if (old->acquired_refs != cur->acquired_refs)
 		return false;
-	return !memcmp(old->refs, cur->refs,
-		       sizeof(*old->refs) * old->acquired_refs);
+
+	for (i = 0; i < old->acquired_refs; i++) {
+		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
+			return false;
+	}
+
+	return true;
 }
 
 /* compare two verifier states
@@ -13270,7 +13278,7 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!stacksafe(env, old, cur, env->idmap_scratch))
 		return false;
 
-	if (!refsafe(old, cur))
+	if (!refsafe(old, cur, env->idmap_scratch))
 		return false;
 
 	return true;
-- 
2.30.2

