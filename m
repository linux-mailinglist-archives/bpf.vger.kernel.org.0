Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B64E7BC0
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiCYW6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 25 Mar 2022 18:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiCYW6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 18:58:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E4213CF2
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:57:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PHOYWg009259
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:57:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f0n6vyhnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:57:09 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 15:57:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7344214D4DE2D; Fri, 25 Mar 2022 15:56:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: fix selftest after random:urandom_read tracepoint removal
Date:   Fri, 25 Mar 2022 15:56:43 -0700
Message-ID: <20220325225643.2606-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Bn1GCIqNSEubEz_3vOgEYZ2lla056haj
X-Proofpoint-GUID: Bn1GCIqNSEubEz_3vOgEYZ2lla056haj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_08,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

14c174633f34 ("random: remove unused tracepoints") removed all the
tracepoints from drivers/char/random.c, one of which,
random:urandom_read, was used by stacktrace_build_id selftest to trigger
stack trace capture.

Fix breakage by switching to kprobing urandom_read() function.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/test_stacktrace_build_id.c   | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
index 36a707e7c7a7..6c62bfb8bb6f 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
@@ -39,16 +39,8 @@ struct {
 	__type(value, stack_trace_t);
 } stack_amap SEC(".maps");
 
-/* taken from /sys/kernel/debug/tracing/events/random/urandom_read/format */
-struct random_urandom_args {
-	unsigned long long pad;
-	int got_bits;
-	int pool_left;
-	int input_left;
-};
-
-SEC("tracepoint/random/urandom_read")
-int oncpu(struct random_urandom_args *args)
+SEC("kprobe/urandom_read")
+int oncpu(struct pt_regs *args)
 {
 	__u32 max_len = sizeof(struct bpf_stack_build_id)
 			* PERF_MAX_STACK_DEPTH;
-- 
2.30.2

