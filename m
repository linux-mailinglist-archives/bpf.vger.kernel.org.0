Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1E4F9C4F
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiDHSQt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDHSQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 14:16:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E6E33
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 11:14:44 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238EKgHZ020689
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 11:14:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fa1fvt05t-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 11:14:43 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 11:14:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 148D016F87398; Fri,  8 Apr 2022 11:14:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add CO-RE relos into linked_funcs selftests
Date:   Fri, 8 Apr 2022 11:14:25 -0700
Message-ID: <20220408181425.2287230-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408181425.2287230-1-andrii@kernel.org>
References: <20220408181425.2287230-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aZ122DukdG3LiNHoxD0ZL5BnwlvQiTNv
X-Proofpoint-ORIG-GUID: aZ122DukdG3LiNHoxD0ZL5BnwlvQiTNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add CO-RE relocations into __weak subprogs for multi-file linked_funcs
selftest to make sure libbpf handles such combination well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/linked_funcs1.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/linked_funcs2.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/testing/selftests/bpf/progs/linked_funcs1.c
index b964ec1390c2..963b393c37e8 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
@@ -4,6 +4,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 /* weak and shared between two files */
 const volatile int my_tid __weak;
@@ -44,6 +45,13 @@ void set_output_ctx1(__u64 *ctx)
 /* this weak instance should win because it's the first one */
 __weak int set_output_weak(int x)
 {
+	static volatile int whatever;
+
+	/* make sure we use CO-RE relocations in a weak function, this used to
+	 * cause problems for BPF static linker
+	 */
+	whatever = bpf_core_type_size(struct task_struct);
+
 	output_weak1 = x;
 	return x;
 }
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/testing/selftests/bpf/progs/linked_funcs2.c
index 575e958e60b7..db195872f4eb 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
@@ -4,6 +4,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 /* weak and shared between both files */
 const volatile int my_tid __weak;
@@ -44,6 +45,13 @@ void set_output_ctx2(__u64 *ctx)
 /* this weak instance should lose, because it will be processed second */
 __weak int set_output_weak(int x)
 {
+	static volatile int whatever;
+
+	/* make sure we use CO-RE relocations in a weak function, this used to
+	 * cause problems for BPF static linker
+	 */
+	whatever = 2 * bpf_core_type_size(struct task_struct);
+
 	output_weak2 = x;
 	return 2 * x;
 }
-- 
2.30.2

