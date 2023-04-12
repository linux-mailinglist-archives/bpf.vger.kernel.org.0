Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902806DE9F9
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 05:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLDrH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 11 Apr 2023 23:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDLDrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 23:47:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290530E0
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 20:47:05 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNTfcv016638
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 20:47:04 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pw088f7nt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 20:47:04 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 20:47:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 32F712DCE7B7E; Tue, 11 Apr 2023 20:46:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] selftests/bpf: fix compiler warnings in bpf_testmod for kfuncs
Date:   Tue, 11 Apr 2023 20:46:47 -0700
Message-ID: <20230412034647.3968143-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sFK7_H-SyXYg8COG3fT5YQuY49Dl9j5s
X-Proofpoint-GUID: sFK7_H-SyXYg8COG3fT5YQuY49Dl9j5s
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add -Wmissing-prototypes ignore in bpf_testmod.c, similarly to what we
do in kernel code proper.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304080951.l14IDv3n-lkp@intel.com/
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 7999476b9446..dd35659ab9ae 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -28,6 +28,10 @@ struct bpf_testmod_struct_arg_2 {
 	long b;
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in bpf_testmod.ko BTF");
+
 noinline int
 bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, int c) {
 	bpf_testmod_test_struct_arg_result = a.a + a.b  + b + c;
@@ -171,6 +175,8 @@ noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
 	return a + b + c;
 }
 
+__diag_pop();
+
 int bpf_testmod_fentry_ok;
 
 noinline ssize_t
-- 
2.34.1

