Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD7575721
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 23:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiGNVn2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Jul 2022 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbiGNVn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 17:43:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37F06EEB9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:43:25 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26ELZifL009013
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:43:25 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hak153waq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:43:24 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 14:43:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D98B01C583C05; Thu, 14 Jul 2022 14:43:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: validate .bss section bigger than 8MB is possible now
Date:   Thu, 14 Jul 2022 14:43:05 -0700
Message-ID: <20220714214305.3189551-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714214305.3189551-1-andrii@kernel.org>
References: <20220714214305.3189551-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i67FN5yefAXxqEi3rFskq6SNsiq19EsU
X-Proofpoint-GUID: i67FN5yefAXxqEi3rFskq6SNsiq19EsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_17,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple big 16MB array and validate access to the very last byte of
it to make sure that kernel supports > KMALLOC_MAX_SIZE value_size for
BPF array maps (which are backing .bss in this case).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/skeleton.c | 2 ++
 tools/testing/selftests/bpf/progs/test_skeleton.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/testing/selftests/bpf/prog_tests/skeleton.c
index 180afd632f4c..99dac5292b41 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -122,6 +122,8 @@ void test_skeleton(void)
 
 	ASSERT_EQ(skel->bss->out_mostly_var, 123, "out_mostly_var");
 
+	ASSERT_EQ(bss->huge_arr[ARRAY_SIZE(bss->huge_arr) - 1], 123, "huge_arr");
+
 	elf_bytes = test_skeleton__elf_bytes(&elf_bytes_sz);
 	ASSERT_OK_PTR(elf_bytes, "elf_bytes");
 	ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");
diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
index 1b1187d2967b..1a4e93f6d9df 100644
--- a/tools/testing/selftests/bpf/progs/test_skeleton.c
+++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
@@ -51,6 +51,8 @@ int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
 int read_mostly_var __read_mostly;
 int out_mostly_var;
 
+char huge_arr[16 * 1024 * 1024];
+
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
 {
@@ -71,6 +73,8 @@ int handler(const void *ctx)
 
 	out_mostly_var = read_mostly_var;
 
+	huge_arr[sizeof(huge_arr) - 1] = 123;
+
 	return 0;
 }
 
-- 
2.30.2

