Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ECF509580
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358657AbiDUDm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Apr 2022 23:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiDUDmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:42:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF163C0
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:40:07 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KILQlS001850
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:40:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhub7dhsx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:40:06 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 20:40:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EBAAA186F53DF; Wed, 20 Apr 2022 20:39:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: switch fexit_stress to bpf_link_create() API
Date:   Wed, 20 Apr 2022 20:39:45 -0700
Message-ID: <20220421033945.3602803-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421033945.3602803-1-andrii@kernel.org>
References: <20220421033945.3602803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9TTAU2x2rFiCxQAszIIa2EllCzqe6odJ
X-Proofpoint-ORIG-GUID: 9TTAU2x2rFiCxQAszIIa2EllCzqe6odJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use bpf_link_create() API in fexit_stress test to attach FEXIT programs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 3ee2107bbf7a..fe1f0f26ea14 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -53,7 +53,7 @@ void test_fexit_stress(void)
 					    &trace_opts);
 		if (!ASSERT_GE(fexit_fd[i], 0, "fexit load"))
 			goto out;
-		link_fd[i] = bpf_raw_tracepoint_open(NULL, fexit_fd[i]);
+		link_fd[i] = bpf_link_create(fexit_fd[i], 0, BPF_TRACE_FEXIT, NULL);
 		if (!ASSERT_GE(link_fd[i], 0, "fexit attach"))
 			goto out;
 	}
-- 
2.30.2

