Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0E6DB3DD
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDGTCo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 7 Apr 2023 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDGTCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 15:02:30 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31411BB
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 12:01:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Gh4Ar027824
        for <bpf@vger.kernel.org>; Fri, 7 Apr 2023 12:01:46 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt6y25sqq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 12:01:46 -0700
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 7 Apr 2023 12:01:44 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 5CE131A8A68EF; Fri,  7 Apr 2023 12:01:37 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@meta.com>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Use PERF_COUNT_HW_CPU_CYCLES event for get_branch_snapshot
Date:   Fri, 7 Apr 2023 12:01:30 -0700
Message-ID: <20230407190130.2093736-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -ZD3W75L53zOtrCj-_bPODagM1O1q3d6
X-Proofpoint-GUID: -ZD3W75L53zOtrCj-_bPODagM1O1q3d6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

perf_event with type=PERF_TYPE_RAW and config=0x1b00 turned out to be not
reliable in ensuring LBR is active. Thus, test_progs:get_branch_snapshot is
not reliable in some systems. Replace it with PERF_COUNT_HW_CPU_CYCLES
event, which gives more consistent results.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 3948da12a528..0394a1156d99 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -37,8 +37,8 @@ static int create_perf_events(void)
 
 	/* create perf event */
 	attr.size = sizeof(attr);
-	attr.type = PERF_TYPE_RAW;
-	attr.config = 0x1b00;
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.config = PERF_COUNT_HW_CPU_CYCLES;
 	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
 	attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL |
 		PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
-- 
2.34.1

