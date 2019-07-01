Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B515C32C
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfGASlT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 14:41:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbfGASlT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jul 2019 14:41:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Ibc9v092144
        for <bpf@vger.kernel.org>; Mon, 1 Jul 2019 14:41:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfnsxvvw7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 14:41:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 1 Jul 2019 19:41:16 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 19:41:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61If3q428967222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 18:41:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E94EBA404D;
        Mon,  1 Jul 2019 18:41:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6704A4040;
        Mon,  1 Jul 2019 18:41:13 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.98.98])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 18:41:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     bpf@vger.kernel.org, liu.song.a23@gmail.com,
        andrii.nakryiko@gmail.com
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: do not ignore clang failures
Date:   Mon,  1 Jul 2019 20:40:26 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
References: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070118-0008-0000-0000-000002F8E123
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070118-0009-0000-0000-000022662739
Message-Id: <20190701184025.25731-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010219
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Am 01.07.2019 um 17:31 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
> Do we still need clang | llc pipeline with new clang? Could the same
> be achieved with single clang invocation? That would solve the problem
> of not detecting pipeline failures.

I’ve experimented with this a little, and found that new clang:

- Does not understand -march, but -target is sufficient.
- Understands -mcpu.
- Understands -Xclang -target-feature -Xclang +foo as a replacement for
  -mattr=foo.

However, there are two issues with that:

- Don’t older clangs need to be supported? For example, right now alu32
  progs are built conditionally.
- It does not seem to be possible to build test_xdp.o without -target
  bpf.

For now I'm attaching the new version of this patch, which introduces
intermediate targets for LLVM bitcode and does not require bash.

---

When compiling an eBPF prog fails, make still returns 0, because
failing clang command's output is piped to llc and therefore its
exit status is ignored.

Create separate targets for clang and llc invocations, so that when
clang fails, llc is not invoked at all, and make returns nonzero.
Pull Kbuild.include for .SECONDARY target, which prevents make from
deleting intermediate LLVM bitcode files.

Adding .bc targets triggers the latent problem with depending on
$(ALU32_BUILD_DIR): since directories are considered changed whenever a
member is added or removed, now everything that depends on
$(ALU32_BUILD_DIR) is always considered out-of-date.

While removing $(ALU32_BUILD_DIR) target might be tempting, since most
targets already depend on files inside it and therefore don't need it,
it might create problems in the future, when such dependencies need to
be removed.

So, instead, add $(ALU32_BUILD_DIR) where needed as an order-only
prerequisite. make provides this feature since version 3.80.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/Makefile   | 34 ++++++++++++++++----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index a2f7f79c7908..4604a54e3ff2 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -42,3 +42,4 @@ xdping
 test_sockopt
 test_sockopt_sk
 test_sockopt_multi
+*.bc
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index de1754a8f5fe..d60fee59fbd1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+include ../../../../scripts/Kbuild.include
 
 LIBDIR := ../../../lib
 BPFDIR := $(LIBDIR)/bpf
@@ -179,12 +180,12 @@ TEST_CUSTOM_PROGS += $(ALU32_BUILD_DIR)/test_progs_32
 $(ALU32_BUILD_DIR):
 	mkdir -p $@
 
-$(ALU32_BUILD_DIR)/urandom_read: $(OUTPUT)/urandom_read
+$(ALU32_BUILD_DIR)/urandom_read: $(OUTPUT)/urandom_read | $(ALU32_BUILD_DIR)
 	cp $< $@
 
 $(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(OUTPUT)/libbpf.a\
-						$(ALU32_BUILD_DIR) \
-						$(ALU32_BUILD_DIR)/urandom_read
+						$(ALU32_BUILD_DIR)/urandom_read \
+						| $(ALU32_BUILD_DIR)
 	$(CC) $(TEST_PROGS_CFLAGS) $(CFLAGS) \
 		-o $(ALU32_BUILD_DIR)/test_progs_32 \
 		test_progs.c test_stub.c trace_helpers.c prog_tests/*.c \
@@ -193,12 +194,15 @@ $(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(OUTPUT)/libbpf.a\
 $(ALU32_BUILD_DIR)/test_progs_32: $(PROG_TESTS_H)
 $(ALU32_BUILD_DIR)/test_progs_32: prog_tests/*.c
 
-$(ALU32_BUILD_DIR)/%.o: progs/%.c $(ALU32_BUILD_DIR) \
-					$(ALU32_BUILD_DIR)/test_progs_32
+$(ALU32_BUILD_DIR)/%.bc: progs/%.c $(ALU32_BUILD_DIR)/test_progs_32 \
+					| $(ALU32_BUILD_DIR)
 	$(CLANG) $(CLANG_FLAGS) \
-		 -O2 -target bpf -emit-llvm -c $< -o - |      \
+		 -O2 -target bpf -emit-llvm -c $< -o $@
+
+$(ALU32_BUILD_DIR)/%.o: $(ALU32_BUILD_DIR)/%.bc \
+				| $(ALU32_BUILD_DIR)
 	$(LLC) -march=bpf -mattr=+alu32 -mcpu=$(CPU) $(LLC_FLAGS) \
-		-filetype=obj -o $@
+		-filetype=obj -o $@ $<
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
 endif
@@ -206,18 +210,22 @@ endif
 
 # Have one program compiled without "-target bpf" to test whether libbpf loads
 # it successfully
-$(OUTPUT)/test_xdp.o: progs/test_xdp.c
+$(OUTPUT)/test_xdp.bc: progs/test_xdp.c
 	$(CLANG) $(CLANG_FLAGS) \
-		-O2 -emit-llvm -c $< -o - | \
-	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
+		-O2 -emit-llvm -c $< -o $@
+
+$(OUTPUT)/test_xdp.o: $(OUTPUT)/test_xdp.bc
+	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@ $<
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
 endif
 
-$(OUTPUT)/%.o: progs/%.c
+$(OUTPUT)/%.bc: progs/%.c
 	$(CLANG) $(CLANG_FLAGS) \
-		 -O2 -target bpf -emit-llvm -c $< -o - |      \
-	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
+		 -O2 -target bpf -emit-llvm -c $< -o $@
+
+$(OUTPUT)/%.o: $(OUTPUT)/%.bc
+	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@ $<
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
 endif
-- 
2.21.0

