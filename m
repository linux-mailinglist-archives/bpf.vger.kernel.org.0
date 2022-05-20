Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A452E5B2
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbiETHCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 03:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346269AbiETHCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 03:02:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B06FD32
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 00:02:03 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24JLD3Z1021660
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 00:02:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=e1aegQTZz49plswIikiZ/aHuT5knpdfW2DMsOjeEbU4=;
 b=ZqiNS1GpBmF+mT/4aQbxq78AiZOqwrH7qASAeyrS6JUS2gXHruShFwQYpxC5+1L1HfKO
 zafMejDSZNVi2kfb79KidYnvtWTxPiNkugUhGJtrQumhSMyOktVWbZECS986axUSnTW2
 tcgRss5OVbsDZdOYgsf+8izBFpqTE7/HQ90= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g5wkracm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 00:02:02 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 00:02:01 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 75546721E296; Fri, 20 May 2022 00:01:59 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix subtest number formatting in test_progs
Date:   Fri, 20 May 2022 00:01:44 -0700
Message-ID: <20220520070144.10312-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HsJ-nRHDWg5NsFnlOBu-mUiDu7PnkaRB
X-Proofpoint-ORIG-GUID: HsJ-nRHDWg5NsFnlOBu-mUiDu7PnkaRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_02,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove weird spaces around / while preserving proper
indentation

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index ecf69fce036e..262b7577b0ef 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -230,9 +230,14 @@ static void print_test_log(char *log_buf, size_t log=
_cnt)
 		fprintf(env.stdout, "\n");
 }
=20
+#define TEST_NUM_WIDTH 7
+#define STRINGIFY(value) #value
+#define QUOTE(macro) STRINGIFY(macro)
+#define TEST_NUM_WIDTH_STR QUOTE(TEST_NUM_WIDTH)
+
 static void print_test_name(int test_num, const char *test_name, char *r=
esult)
 {
-	fprintf(env.stdout, "#%-9d %s", test_num, test_name);
+	fprintf(env.stdout, "#%-" TEST_NUM_WIDTH_STR "d %s", test_num, test_nam=
e);
=20
 	if (result)
 		fprintf(env.stdout, ":%s", result);
@@ -244,8 +249,12 @@ static void print_subtest_name(int test_num, int sub=
test_num,
 			       const char *test_name, char *subtest_name,
 			       char *result)
 {
-	fprintf(env.stdout, "#%-3d/%-5d %s/%s",
-		test_num, subtest_num,
+	char test_num_str[TEST_NUM_WIDTH + 1];
+
+	snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest=
_num);
+
+	fprintf(env.stdout, "#%-" TEST_NUM_WIDTH_STR "s %s/%s",
+		test_num_str,
 		test_name, subtest_name);
=20
 	if (result)
--=20
2.30.2

