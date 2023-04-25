Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB366EEB17
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjDYXtg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbjDYXtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14301B219
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:35 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEDZY022298
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6mws9he4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:34 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CF3AE2F2D833D; Tue, 25 Apr 2023 16:49:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 02/10] bpf: mark relevant stack slots scratched for register read instructions
Date:   Tue, 25 Apr 2023 16:49:03 -0700
Message-ID: <20230425234911.2113352-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sneBv6QkwCLV1tQzk2R__xsPQysjCVWH
X-Proofpoint-ORIG-GUID: sneBv6QkwCLV1tQzk2R__xsPQysjCVWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When handling instructions that read register slots, mark relevant stack
slots as scratched so that verifier log would contain those slots' states, in
addition to currently emitted registers with stack slot offsets.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbcf5a4e2fcd..fea6fe4acba2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4067,6 +4067,7 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 	for (i = min_off; i < max_off; i++) {
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
+		mark_stack_slot_scratched(env, spi);
 		stype = ptr_state->stack[spi].slot_type;
 		if (stype[slot % BPF_REG_SIZE] != STACK_ZERO)
 			break;
@@ -4118,6 +4119,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	stype = reg_state->stack[spi].slot_type;
 	reg = &reg_state->stack[spi].spilled_ptr;
 
+	mark_stack_slot_scratched(env, spi);
+
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
 
-- 
2.34.1

