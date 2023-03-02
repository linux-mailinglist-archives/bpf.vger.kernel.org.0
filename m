Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2296A8D47
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCBXuo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCBXun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165931E1A
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:42 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 322KV1qP013328
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:42 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p2uad4s02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:42 -0800
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C7E6A291B7EE4; Thu,  2 Mar 2023 15:50:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 08/17] bpf: ensure that r0 is marked scratched after any function call
Date:   Thu, 2 Mar 2023 15:50:06 -0800
Message-ID: <20230302235015.2044271-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vIHbTRuAoIQlyKxlAjjU6izBxIaKOuwN
X-Proofpoint-GUID: vIHbTRuAoIQlyKxlAjjU6izBxIaKOuwN
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

r0 is important (unless called function is void-returning, but that's
taken care of by print_verifier_state() anyways) in verifier logs.
Currently for helpers we seem to print it in verifier log, but for
kfuncs we don't.

Instead of figuring out where in the maze of code we accidentally set r0
as scratched for helpers and why we don't do that for kfuncs, just
enforce that after any function call r0 is marked as scratched.

Also, perhaps, we should reconsider "scratched" terminology, as it's
mightily confusing. "Touched" would seem more appropriate. But I left
that for follow ups for now.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 666e416dc8a2..0004c9f3737f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15001,6 +15001,8 @@ static int do_check(struct bpf_verifier_env *env)
 					err = check_helper_call(env, insn, &env->insn_idx);
 				if (err)
 					return err;
+
+				mark_reg_scratched(env, BPF_REG_0);
 			} else if (opcode == BPF_JA) {
 				if (BPF_SRC(insn->code) != BPF_K ||
 				    insn->imm != 0 ||
-- 
2.30.2

