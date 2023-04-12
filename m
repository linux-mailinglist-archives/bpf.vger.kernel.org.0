Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6096E0073
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLVFb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 17:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjDLVFa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:05:30 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28747ABC
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:05:19 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CI939d009331
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwqws4vmd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:04:40 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 14:04:38 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id ECA051B0AF057; Wed, 12 Apr 2023 14:04:31 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@meta.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach
Date:   Wed, 12 Apr 2023 14:04:22 -0700
Message-ID: <20230412210423.900851-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412210423.900851-1-song@kernel.org>
References: <20230412210423.900851-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: n0TmlKuOkxiRSKmIuLaRamWy7MjnLa6A
X-Proofpoint-ORIG-GUID: n0TmlKuOkxiRSKmIuLaRamWy7MjnLa6A
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

skel->links.oncpu is leaked in one case. This causes test perf_branches
fails when it runs after get_stackid_cannot_attach:

./test_progs -t get_stackid_cannot_attach,perf_branches
84      get_stackid_cannot_attach:OK
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_good_sample:FAIL:output not valid no valid sample from prog
146/1   perf_branches/perf_branches_hw:FAIL
146/2   perf_branches/perf_branches_no_hw:OK
146     perf_branches:FAIL

All error logs:
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_good_sample:FAIL:output not valid no valid sample from prog
146/1   perf_branches/perf_branches_hw:FAIL
146     perf_branches:FAIL
Summary: 1/1 PASSED, 0 SKIPPED, 1 FAILED

Fix this by adding the missing bpf_link__destroy().

Fixes: 346938e9380c ("selftests/bpf: Add get_stackid_cannot_attach")
Signed-off-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
index 5308de1ed478..2715c68301f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
@@ -65,6 +65,7 @@ void test_get_stackid_cannot_attach(void)
 	skel->links.oncpu = bpf_program__attach_perf_event(skel->progs.oncpu,
 							   pmu_fd);
 	ASSERT_OK_PTR(skel->links.oncpu, "attach_perf_event_callchain");
+	bpf_link__destroy(skel->links.oncpu);
 	close(pmu_fd);
 
 	/* add exclude_callchain_kernel, attach should fail */
-- 
2.34.1

