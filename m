Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659C6E0089
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDLVLc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjDLVLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:11:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D259E3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:11:30 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CI9ACJ010159
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:39 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwqspvujh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:38 -0700
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 14:04:38 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 7CBAB1B0AF061; Wed, 12 Apr 2023 14:04:32 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@meta.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Keep the loop in bpf_testmod_loop_test
Date:   Wed, 12 Apr 2023 14:04:23 -0700
Message-ID: <20230412210423.900851-4-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412210423.900851-1-song@kernel.org>
References: <20230412210423.900851-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bp3lVbQxVRyizfaL0LqE8hoEHFy2SuQX
X-Proofpoint-GUID: bp3lVbQxVRyizfaL0LqE8hoEHFy2SuQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_11,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some compilers (for example clang-15) optimize bpf_testmod_loop_test and
remove the loop:

gcc version
(gdb) disassemble bpf_testmod_loop_test
Dump of assembler code for function bpf_testmod_loop_test:
   0x0000000000000570 <+0>:     callq  0x575 <bpf_testmod_loop_test+5>
   0x0000000000000575 <+5>:     xor    %eax,%eax
   0x0000000000000577 <+7>:     test   %edi,%edi
   0x0000000000000579 <+9>:     jle    0x587 <bpf_testmod_loop_test+23>
   0x000000000000057b <+11>:    xor    %edx,%edx
   0x000000000000057d <+13>:    add    %edx,%eax
   0x000000000000057f <+15>:    add    $0x1,%edx
   0x0000000000000582 <+18>:    cmp    %edx,%edi
   0x0000000000000584 <+20>:    jne    0x57d <bpf_testmod_loop_test+13>
   0x0000000000000586 <+22>:    retq
   0x0000000000000587 <+23>:    retq

clang-15 version
(gdb) disassemble bpf_testmod_loop_test
Dump of assembler code for function bpf_testmod_loop_test:
   0x0000000000000450 <+0>:     nopl   0x0(%rax,%rax,1)
   0x0000000000000455 <+5>:     test   %edi,%edi
   0x0000000000000457 <+7>:     jle    0x46b <bpf_testmod_loop_test+27>
   0x0000000000000459 <+9>:     lea    -0x1(%rdi),%eax
   0x000000000000045c <+12>:    lea    -0x2(%rdi),%ecx
   0x000000000000045f <+15>:    imul   %rax,%rcx
   0x0000000000000463 <+19>:    shr    %rcx
   0x0000000000000466 <+22>:    lea    -0x1(%rdi,%rcx,1),%eax
   0x000000000000046a <+26>:    retq
   0x000000000000046b <+27>:    xor    %eax,%eax
   0x000000000000046d <+29>:    retq

Note: The jne instruction is removed in clang-15 version.

Force the compile to keep the loop by making sum volatile.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 7999476b9446..c5ad39bbe9af 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -130,7 +130,11 @@ bpf_testmod_test_btf_type_tag_percpu_2(struct bpf_testmod_btf_type_tag_3 *arg) {
 
 noinline int bpf_testmod_loop_test(int n)
 {
-	int i, sum = 0;
+	/* Make sum volatile, so smart compilers, such as clang, will not
+	 * optimize the code by removing the loop.
+	 */
+	volatile int sum = 0;
+	int i;
 
 	/* the primary goal of this test is to test LBR. Create a lot of
 	 * branches in the function, so we can catch it easily.
-- 
2.34.1

