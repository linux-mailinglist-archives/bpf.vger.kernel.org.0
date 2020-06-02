Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6611EC175
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBR5Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 13:57:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbgFBR5Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Jun 2020 13:57:25 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052HVGow019456;
        Tue, 2 Jun 2020 13:57:13 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31dsq9u8t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 13:57:13 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052HtJ3S020554;
        Tue, 2 Jun 2020 17:57:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 31bf47ammu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 17:57:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052Hv8kA61538418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 17:57:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD67AE04D;
        Tue,  2 Jun 2020 17:57:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10334AE045;
        Tue,  2 Jun 2020 17:57:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.174.225])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jun 2020 17:57:07 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 1/2] tools/bpf: Don't use $(COMPILE.c)
Date:   Tue,  2 Jun 2020 19:56:48 +0200
Message-Id: <20200602175649.2501580-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200602175649.2501580-1-iii@linux.ibm.com>
References: <20200602175649.2501580-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 cotscore=-2147483648 mlxlogscore=999
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020123
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using make kselftest TARGETS=bpf, tools/bpf is built with
MAKEFLAGS=rR, which causes $(COMPILE.c) to be undefined, which in turn
causes the build to fail with

  CC       kselftest/bpf/tools/build/bpftool/map_perf_ring.o
/bin/sh: 1: -MMD: not found

Fix by using $(CC) $(CFLAGS) -c instead of $(COMPILE.c).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/bpf/Makefile         | 6 +++---
 tools/bpf/bpftool/Makefile | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index f897eeeb0b4f..77472e28c8fd 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -64,12 +64,12 @@ $(OUTPUT)%.lex.c: $(srctree)/tools/bpf/%.l
 	$(QUIET_FLEX)$(LEX) -o $@ $<
 
 $(OUTPUT)%.o: $(srctree)/tools/bpf/%.c
-	$(QUIET_CC)$(COMPILE.c) -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
 
 $(OUTPUT)%.yacc.o: $(OUTPUT)%.yacc.c
-	$(QUIET_CC)$(COMPILE.c) -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
 $(OUTPUT)%.lex.o: $(OUTPUT)%.lex.c
-	$(QUIET_CC)$(COMPILE.c) -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
 
 PROGS = $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg $(OUTPUT)bpf_asm
 
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index f584d1fdfc64..4df7ed7e47da 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -121,7 +121,7 @@ else
 endif
 
 $(OUTPUT)_prog.o: prog.c
-	$(QUIET_CC)$(COMPILE.c) -MMD -DBPFTOOL_WITHOUT_SKELETONS -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -DBPFTOOL_WITHOUT_SKELETONS -o $@ $<
 
 $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
@@ -136,10 +136,10 @@ profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
 	$(QUIET_GEN)$(OUTPUT)./_bpftool gen skeleton skeleton/profiler.bpf.o > $@
 
 $(OUTPUT)prog.o: prog.c profiler.skel.h
-	$(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
 
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
-	$(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
 
 $(OUTPUT)feature.o: | zdep
 
@@ -147,7 +147,7 @@ $(OUTPUT)bpftool: $(__OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(__OBJS) $(LIBS)
 
 $(OUTPUT)%.o: %.c
-	$(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
 
 clean: $(LIBBPF)-clean
 	$(call QUIET_CLEAN, bpftool)
-- 
2.25.4

