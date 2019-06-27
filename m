Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71F657F0A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfF0JPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 05:15:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfF0JPA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jun 2019 05:15:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5R98aAM103239
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 05:14:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcrw061e6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 05:14:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 27 Jun 2019 10:14:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 10:14:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5R9ErJI52822058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 09:14:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D6E211C04A;
        Thu, 27 Jun 2019 09:14:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE7B11C050;
        Thu, 27 Jun 2019 09:14:52 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 09:14:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     bpf@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: do not ignore clang failures
Date:   Thu, 27 Jun 2019 11:14:50 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062709-0012-0000-0000-0000032CD379
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062709-0013-0000-0000-00002166109F
Message-Id: <20190627091450.78550-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270108
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling an eBPF prog fails, make still returns 0, because
failing clang command's output is piped to llc and therefore its
exit status is ignored.

This patch uses bash's pipefail option to fail the build when clang
fails, and also make's .DELETE_ON_ERROR target to get rid of partial
BPF bytecode files.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f2dbe2043067..2316fa2d5b3b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+SHELL := /bin/bash
 LIBDIR := ../../../lib
 BPFDIR := $(LIBDIR)/bpf
 APIDIR := ../../../include/uapi
@@ -191,7 +192,7 @@ $(ALU32_BUILD_DIR)/test_progs_32: prog_tests/*.c
 
 $(ALU32_BUILD_DIR)/%.o: progs/%.c $(ALU32_BUILD_DIR) \
 					$(ALU32_BUILD_DIR)/test_progs_32
-	$(CLANG) $(CLANG_FLAGS) \
+	set -o pipefail; $(CLANG) $(CLANG_FLAGS) \
 		 -O2 -target bpf -emit-llvm -c $< -o - |      \
 	$(LLC) -march=bpf -mattr=+alu32 -mcpu=$(CPU) $(LLC_FLAGS) \
 		-filetype=obj -o $@
@@ -203,7 +204,7 @@ endif
 # Have one program compiled without "-target bpf" to test whether libbpf loads
 # it successfully
 $(OUTPUT)/test_xdp.o: progs/test_xdp.c
-	$(CLANG) $(CLANG_FLAGS) \
+	set -o pipefail; $(CLANG) $(CLANG_FLAGS) \
 		-O2 -emit-llvm -c $< -o - | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
@@ -211,7 +212,7 @@ ifeq ($(DWARF2BTF),y)
 endif
 
 $(OUTPUT)/%.o: progs/%.c
-	$(CLANG) $(CLANG_FLAGS) \
+	set -o pipefail; $(CLANG) $(CLANG_FLAGS) \
 		 -O2 -target bpf -emit-llvm -c $< -o - |      \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
@@ -283,3 +284,5 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $(VERIFIER_TEST_FILES)
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
 	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H) \
 	feature
+
+.DELETE_ON_ERROR:
-- 
2.21.0

