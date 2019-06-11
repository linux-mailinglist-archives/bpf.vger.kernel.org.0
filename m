Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA03C0AC
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2019 02:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfFKAnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 20:43:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36794 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728645AbfFKAnS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jun 2019 20:43:18 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B0d9qd018278
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 17:43:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Co9u+zSDiVXwGEpAN7pH8aL3BJmqlgTYA65Hbi9sL3A=;
 b=rKgRqHiKBftREM+lI3ddS0ZIJd5P0EGv6sBOfmDTuwczxDZhIl4lCiv/Fi6BB62E2iH5
 A4bCkZuK7y0+Ah9cvEvBlvfipL2m7sOwSw1I1LG2gqq4l7gZr7RP7vhUN+gFyssS8BML
 a2dRSMhNy8GV2pfKaz75tj8D7YnGhe5f39U= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t1r8j2gqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 17:43:16 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 10 Jun 2019 17:43:15 -0700
Received: by devvm3632.prn2.facebook.com (Postfix, from userid 172007)
        id 0BD75D0D4F14; Mon, 10 Jun 2019 17:43:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Hechao Li <hechaol@fb.com>
Smtp-Origin-Hostname: devvm3632.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <kernel-team@fb.com>, Hechao Li <hechaol@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next] selftests/bpf : clean up feature/ when make clean
Date:   Mon, 10 Jun 2019 17:43:07 -0700
Message-ID: <20190611004307.3774913-1-hechaol@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=383 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110002
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An error "implicit declaration of function 'reallocarray'" can be thrown
with the following steps:

$ cd tools/testing/selftests/bpf
$ make clean && make CC=<Path to GCC 4.8.5>
$ make clean && make CC=<Path to GCC 7.x>

The cause is that the feature folder generated by GCC 4.8.5 is not
removed, leaving feature-reallocarray being 1, which causes reallocarray
not defined when re-compliing with GCC 7.x. This diff adds feature
folder to EXTRA_CLEAN to avoid this problem.

v2: Rephrase the commit message.

Signed-off-by: Hechao Li <hechaol@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2b426ae1cdc9..44fb61f4d502 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -279,4 +279,5 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $(VERIFIER_TEST_FILES)
 		 ) > $(VERIFIER_TESTS_H))
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
-	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H)
+	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H) \
+	feature
-- 
2.17.1

