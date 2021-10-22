Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93B438041
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhJVWfA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 18:35:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27116 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233793AbhJVWfA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:35:00 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MLBSSX023225
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3busjqe91s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:41 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:32:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0F46670D5F81; Fri, 22 Oct 2021 15:32:39 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: support multiple tests per file
Date:   Fri, 22 Oct 2021 15:32:26 -0700
Message-ID: <20211022223228.99920-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022223228.99920-1-andrii@kernel.org>
References: <20211022223228.99920-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: xV3DNEYdQSkPH7fCrgOzvj3bjKVOeOap
X-Proofpoint-GUID: xV3DNEYdQSkPH7fCrgOzvj3bjKVOeOap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Revamp how test discovery works for test_progs and allow multiple test
entries per file. Any global void function with no arguments and
serial_test_ or test_ prefix is considered a test.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 498222543c37..ac47cf9760fc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -421,10 +421,9 @@ ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
 $(TRUNNER_TESTS_DIR)-tests-hdr := y
 $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
 	$$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
-	$$(shell ( cd $(TRUNNER_TESTS_DIR);				\
-		  echo '/* Generated header, do not edit */';		\
-		  ls *.c 2> /dev/null |					\
-			sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';	\
+	$$(shell (echo '/* Generated header, do not edit */';					\
+		  sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'	\
+			$(TRUNNER_TESTS_DIR)/*.c | sort ;	\
 		 ) > $$@)
 endif
 
-- 
2.30.2

