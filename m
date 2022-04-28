Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A023512A5B
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 06:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiD1ETB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 00:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242694AbiD1ES6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 00:18:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A202A719
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:43 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RLlLMT009954
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fprsx9t26-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:42 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 21:15:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A8ACF192F88D2; Wed, 27 Apr 2022 21:15:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] libbpf: append "..." in fixed up log if CO-RE spec is truncated
Date:   Wed, 27 Apr 2022 21:15:20 -0700
Message-ID: <20220428041523.4089853-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428041523.4089853-1-andrii@kernel.org>
References: <20220428041523.4089853-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zNKdwyCgZhx_ZDy3f1GXT46Ns2Z0Fxek
X-Proofpoint-ORIG-GUID: zNKdwyCgZhx_ZDy3f1GXT46Ns2Z0Fxek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Detect CO-RE spec truncation and append "..." to make user aware that
there was supposed to be more of the spec there.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 73a5192defb3..a85d83390d67 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6947,7 +6947,7 @@ static void fixup_log_failed_core_relo(struct bpf_program *prog,
 	const struct bpf_core_relo *relo;
 	struct bpf_core_spec spec;
 	char patch[512], spec_buf[256];
-	int insn_idx, err;
+	int insn_idx, err, spec_len;
 
 	if (sscanf(line1, "%d: (%*d) call unknown#195896080\n", &insn_idx) != 1)
 		return;
@@ -6960,11 +6960,11 @@ static void fixup_log_failed_core_relo(struct bpf_program *prog,
 	if (err)
 		return;
 
-	bpf_core_format_spec(spec_buf, sizeof(spec_buf), &spec);
+	spec_len = bpf_core_format_spec(spec_buf, sizeof(spec_buf), &spec);
 	snprintf(patch, sizeof(patch),
 		 "%d: <invalid CO-RE relocation>\n"
-		 "failed to resolve CO-RE relocation %s\n",
-		 insn_idx, spec_buf);
+		 "failed to resolve CO-RE relocation %s%s\n",
+		 insn_idx, spec_buf, spec_len >= sizeof(spec_buf) ? "..." : "");
 
 	patch_log(buf, buf_sz, log_sz, line1, line3 - line1, patch);
 }
-- 
2.30.2

