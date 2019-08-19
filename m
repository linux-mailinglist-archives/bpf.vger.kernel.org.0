Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D80923A2
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2019 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHSMje (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 08:39:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbfHSMje (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Aug 2019 08:39:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JCcKJM049705
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2019 08:39:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufsa6x4bb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2019 08:39:24 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 19 Aug 2019 13:38:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 13:38:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JCcmJ250331888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 12:38:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97E624203F;
        Mon, 19 Aug 2019 12:38:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5494C42052;
        Mon, 19 Aug 2019 12:38:48 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.98.226])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 12:38:48 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] selftests/bpf: fix test_btf_dump with O=
Date:   Mon, 19 Aug 2019 14:38:47 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081912-4275-0000-0000-0000035ABEC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081912-4276-0000-0000-0000386CDB85
Message-Id: <20190819123847.67494-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190143
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_btf_dump fails when run with O=, because it needs to access source
files and assumes they live in ./progs/, which is not the case in this
scenario.

Fix by instructing kselftest to copy btf_dump_test_case_*.c files to the
test directory. Since kselftest does not preserve directory structure,
adjust the test to look in ./progs/ and then in ./.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile        | 3 +++
 tools/testing/selftests/bpf/test_btf_dump.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c085964e1d05..69b98d8d3b5b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -34,6 +34,9 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
 
+BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
+TEST_FILES = $(BTF_C_FILES)
+
 # Also test sub-register code-gen if LLVM has eBPF v3 processor support which
 # contains both ALU32 and JMP32 instructions.
 SUBREG_CODEGEN := $(shell echo "int cal(int a) { return a > 0; }" | \
diff --git a/tools/testing/selftests/bpf/test_btf_dump.c b/tools/testing/selftests/bpf/test_btf_dump.c
index 8f850823d35f..6e75dd3cb14f 100644
--- a/tools/testing/selftests/bpf/test_btf_dump.c
+++ b/tools/testing/selftests/bpf/test_btf_dump.c
@@ -97,6 +97,13 @@ int test_btf_dump_case(int n, struct btf_dump_test_case *test_case)
 	}
 
 	snprintf(test_file, sizeof(test_file), "progs/%s.c", test_case->name);
+	if (access(test_file, R_OK) == -1)
+		/*
+		 * When the test is run with O=, kselftest copies TEST_FILES
+		 * without preserving the directory structure.
+		 */
+		snprintf(test_file, sizeof(test_file), "%s.c",
+			test_case->name);
 	/*
 	 * Diff test output and expected test output, contained between
 	 * START-EXPECTED-OUTPUT and END-EXPECTED-OUTPUT lines in test case.
-- 
2.21.0

