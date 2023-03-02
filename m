Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7A6A7AD0
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 06:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCBFcp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 00:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCBFco (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 00:32:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC934AFE7
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 21:32:43 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3220gUhP030799
        for <bpf@vger.kernel.org>; Wed, 1 Mar 2023 21:32:43 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2ejctday-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 21:32:43 -0800
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Mar 2023 21:32:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 09ACE290D0F6C; Wed,  1 Mar 2023 21:32:30 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/8] selftests/bpf: adjust log_fixup's buffer size for proper truncation
Date:   Wed, 1 Mar 2023 21:32:13 -0800
Message-ID: <20230302053216.1426015-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302053216.1426015-1-andrii@kernel.org>
References: <20230302053216.1426015-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R4VVYxnFVwODgHj6avWNAJ7_kSeXIEJ1
X-Proofpoint-GUID: R4VVYxnFVwODgHj6avWNAJ7_kSeXIEJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adjust log_fixup's expected buffer length to fix the test. It's pretty
finicky in its length expectation, but it doesn't break often. So just
adjust the length to work on current kernel and with follow up iterator
changes as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/log_fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index f4ffdcabf4e4..239e1c5753b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -141,7 +141,7 @@ void test_log_fixup(void)
 	if (test__start_subtest("bad_core_relo_trunc_partial"))
 		bad_core_relo(300, TRUNC_PARTIAL /* truncate original log a bit */);
 	if (test__start_subtest("bad_core_relo_trunc_full"))
-		bad_core_relo(250, TRUNC_FULL  /* truncate also libbpf's message patch */);
+		bad_core_relo(210, TRUNC_FULL  /* truncate also libbpf's message patch */);
 	if (test__start_subtest("bad_core_relo_subprog"))
 		bad_core_relo_subprog();
 	if (test__start_subtest("missing_map"))
-- 
2.30.2

