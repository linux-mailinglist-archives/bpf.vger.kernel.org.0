Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB026A8D44
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCBXuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCBXug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B534C2A
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:35 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KVT63000387
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:35 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2qj7nyqx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:35 -0800
Received: from twshared18553.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:33 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 77A94291B7E9E; Thu,  2 Mar 2023 15:50:22 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 02/17] bpf: improve regsafe() checks for PTR_TO_{MEM,BUF,TP_BUFFER}
Date:   Thu, 2 Mar 2023 15:50:00 -0800
Message-ID: <20230302235015.2044271-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lJvH2HgNebJuBCq3whuub0mVRRgYzRdl
X-Proofpoint-GUID: lJvH2HgNebJuBCq3whuub0mVRRgYzRdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach regsafe() logic to handle PTR_TO_MEM, PTR_TO_BUF, and
PTR_TO_TP_BUFFER similarly to PTR_TO_MAP_{KEY,VALUE}. That is, instead of
exact match for var_off and range, use tnum_in() and range_within()
checks, allowing more general verified state to subsume more specific
current state. This allows to match wider range of valid and safe
states, speeding up verification and detecting wider range of equivalent
states for upcoming open-coded iteration looping logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60cc8473faa8..97f03f9fc711 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14114,13 +14114,17 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_TP_BUFFER:
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 */
 		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
-		       check_ids(rold->id, rcur->id, idmap);
+		       check_ids(rold->id, rcur->id, idmap) &&
+		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		/* We must have at least as much range as the old ptr
-- 
2.30.2

