Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264E4F895A
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiDGUpy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 7 Apr 2022 16:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiDGUpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 16:45:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4512261980
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 13:38:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237KAoHt024314
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 13:38:50 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9nrnf3pf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 13:38:50 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 13:38:48 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 640E116D3AC26; Thu,  7 Apr 2022 13:38:44 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH bpf-next] libbpf: fix use #ifdef instead of #if to avoid compiler warning
Date:   Thu, 7 Apr 2022 13:38:42 -0700
Message-ID: <20220407203842.3019904-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: l4SaAWRhLiXrhvj-xFfcXNETTnVf1jnQ
X-Proofpoint-ORIG-GUID: l4SaAWRhLiXrhvj-xFfcXNETTnVf1jnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported by Naresh:

  perf build errors on i386 [1] on Linux next-20220407 [2]

  usdt.c:1181:5: error: "__x86_64__" is not defined, evaluates to 0
  [-Werror=undef]
   1181 | #if __x86_64__
        |     ^~~~~~~~~~
  usdt.c:1196:5: error: "__x86_64__" is not defined, evaluates to 0
  [-Werror=undef]
   1196 | #if __x86_64__
        |     ^~~~~~~~~~
  cc1: all warnings being treated as errors

Use #ifdef instead of #if to avoid this.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 4c59e584d158 ("libbpf: Add x86-specific USDT arg spec parsing logic")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index bb1e88613343..b699e720136a 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1178,7 +1178,7 @@ static int calc_pt_regs_off(const char *reg_name)
 		const char *names[4];
 		size_t pt_regs_off;
 	} reg_map[] = {
-#if __x86_64__
+#ifdef __x86_64__
 #define reg_off(reg64, reg32) offsetof(struct pt_regs, reg64)
 #else
 #define reg_off(reg64, reg32) offsetof(struct pt_regs, reg32)
@@ -1193,7 +1193,7 @@ static int calc_pt_regs_off(const char *reg_name)
 		{ {"rbp", "ebp", "bp", "bpl"}, reg_off(rbp, ebp) },
 		{ {"rsp", "esp", "sp", "spl"}, reg_off(rsp, esp) },
 #undef reg_off
-#if __x86_64__
+#ifdef __x86_64__
 		{ {"r8", "r8d", "r8w", "r8b"}, offsetof(struct pt_regs, r8) },
 		{ {"r9", "r9d", "r9w", "r9b"}, offsetof(struct pt_regs, r9) },
 		{ {"r10", "r10d", "r10w", "r10b"}, offsetof(struct pt_regs, r10) },
-- 
2.30.2

