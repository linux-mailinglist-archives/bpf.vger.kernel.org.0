Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5142764BF0D
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiLMWGN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 13 Dec 2022 17:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiLMWGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:06:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35DC11C27
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:06:02 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDKPt83024695
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:06:02 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3meyf59ax7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:06:02 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 14:06:00 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 5048B11711901; Tue, 13 Dec 2022 14:05:50 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>,
        =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
Subject: [PATCH bpf-next] selftests/bpf: select CONFIG_FUNCTION_ERROR_INJECTION
Date:   Tue, 13 Dec 2022 14:05:00 -0800
Message-ID: <20221213220500.3427947-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: QRF76UMHXl6IqWBx8seDOA424Sjo12bZ
X-Proofpoint-GUID: QRF76UMHXl6IqWBx8seDOA424Sjo12bZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF selftests require CONFIG_FUNCTION_ERROR_INJECTION to work. However,
CONFIG_FUNCTION_ERROR_INJECTION is no longer 'y' by default after [1].
As a result, we are seeing errors like the following from BPF CI:

   bpf_testmod_test_read() is not modifiable
   __x64_sys_setdomainname is not sleepable
   __x64_sys_getpgid is not sleepable

Fix this by explicitly selecting CONFIG_FUNCTION_ERROR_INJECTION in the
selftest config.

[1] commit a4412fdd49dc ("error-injection: Add prompt for function error injection")
Reported-by: Daniel Müller <deso@posteo.net>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 612f699dc4f7..5cbc975fd5c8 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -76,3 +76,4 @@ CONFIG_USERFAULTFD=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
\ No newline at end of file
-- 
2.30.2

