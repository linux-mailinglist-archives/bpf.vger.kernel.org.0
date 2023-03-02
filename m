Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0906A7ACF
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 06:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCBFcj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 00:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBFci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 00:32:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04C4AFF1
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 21:32:36 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32233ZEf020460
        for <bpf@vger.kernel.org>; Wed, 1 Mar 2023 21:32:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p1junw6rd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 21:32:36 -0800
Received: from twshared37576.17.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Mar 2023 21:32:33 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F2E5E290D0F30; Wed,  1 Mar 2023 21:32:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/8] bpf: honor env->test_state_freq flag in is_state_visited()
Date:   Wed, 1 Mar 2023 21:32:12 -0800
Message-ID: <20230302053216.1426015-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302053216.1426015-1-andrii@kernel.org>
References: <20230302053216.1426015-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QFh0DncNncQ42hjZMv-EXk0c_fwifVEZ
X-Proofpoint-ORIG-GUID: QFh0DncNncQ42hjZMv-EXk0c_fwifVEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

env->test_state_freq flag can be set by user by passing
BPF_F_TEST_STATE_FREQ program flag. This is used in a bunch of selftests
to have predictable state checkpoints at every jump and so on.

Currently, bounded loop handling heuristic ignores this flag if number
of processed jumps and/or number of processed instructions is below some
thresholds, which throws off that reliable state checkpointing.

Honor this flag in all circumstances by disabling heuristic if
env->test_state_freq is set.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 97f03f9fc711..154f5d251ecb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14556,7 +14556,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * This threshold shouldn't be too high either, since states
 			 * at the end of the loop are likely to be useful in pruning.
 			 */
-			if (env->jmps_processed - env->prev_jmps_processed < 20 &&
+			if (!env->test_state_freq &&
+			    env->jmps_processed - env->prev_jmps_processed < 20 &&
 			    env->insn_processed - env->prev_insn_processed < 100)
 				add_new_state = false;
 			goto miss;
-- 
2.30.2

