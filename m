Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C06A8D4B
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCBXut convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCBXus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14A31E1A
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:48 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KUvsn032521
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:48 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2y1mkc91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:47 -0800
Received: from twshared18553.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BD9E4291B7EDF; Thu,  2 Mar 2023 15:50:32 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 07/17] bpf: fix visit_insn()'s detection of BPF_FUNC_timer_set_callback helper
Date:   Thu, 2 Mar 2023 15:50:05 -0800
Message-ID: <20230302235015.2044271-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lduPUZep_xm9zCxPk8I0i31nWlJ7d4WI
X-Proofpoint-ORIG-GUID: lduPUZep_xm9zCxPk8I0i31nWlJ7d4WI
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

It's not correct to assume that any BPF_CALL instruction is a helper
call. Fix visit_insn()'s detection of bpf_timer_set_callback() helper by
also checking insn->code == 0. For kfuncs insn->code would be set to
BPF_PSEUDO_KFUNC_CALL, and for subprog calls it will be BPF_PSEUDO_CALL.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8055f3d9b47..666e416dc8a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13405,7 +13405,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insn->imm == BPF_FUNC_timer_set_callback)
+		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_timer_set_callback)
 			/* Mark this call insn as a prune point to trigger
 			 * is_state_visited() check before call itself is
 			 * processed by __check_func_call(). Otherwise new
-- 
2.30.2

