Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7F323B2A
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhBXLRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 06:17:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234923AbhBXLPz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 06:15:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OB3wRN077149;
        Wed, 24 Feb 2021 06:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5kkcllD9HEIGxLpRYO2xOfe7pqqEN0Z5Bu6HatAZfN0=;
 b=m6ELGwAtOvn6bGvxrVmu4e1P2diU0C2dkhIFx2/14QL1zAcwE3sorOe24GN5aINseYhy
 Gt4i49dAeFG+o9xc35q+TGmHlX3RtpFhktatnyLk0QW/txh0SaHn7KpYLMsn8hWukjBv
 R5bUUR0ng+Q+4p0v4ocbRjmDSoKZRWRzdkGJN+daV6nhdbyM4lFvKc+AKqSwmxbKnZdI
 IHsl3USmDFuPRSQvPxlCEkFiCZ2BdFCsvowrKgi4NtiLcZ8B5CQ7xaTSaYIGub0qNDwQ
 NbecOAZ4532vMJ4I9NOqKBvBPqAEweF3CpS4DYKKRaKC6U9fq8yTEHG5TtW8P/BSmIRu uQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkn08h0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 06:14:53 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OBC4U1025002;
        Wed, 24 Feb 2021 11:14:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt283g19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:14:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OBEmFu47251936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 11:14:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E95211C04C;
        Wed, 24 Feb 2021 11:14:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E88F311C04A;
        Wed, 24 Feb 2021 11:14:47 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 11:14:47 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: Copy extras in out-of-srctree builds
Date:   Wed, 24 Feb 2021 12:14:45 +0100
Message-Id: <20210224111445.102342-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_03:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102240086
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building selftests in a separate directory like this:

    make O="$BUILD" -C tools/testing/selftests/bpf

and then running:

    cd "$BUILD" && ./test_progs -t btf

causes all the non-flavored btf_dump_test_case_*.c tests to fail,
because these files are not copied to where test_progs expects to find
them.

Fix by not skipping EXT-COPY when the original $(OUTPUT) is not empty
(lib.mk sets it to $(shell pwd) in that case) and using rsync instead
of cp: cp fails because e.g. urandom_read is being copied into itself,
and rsync simply skips such cases. rsync is already used by kselftests
and therefore is not a new dependency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/bpf/20210222232451.84574-1-iii@linux.ibm.com/
v1 -> v2: Andrii has noticed that unconditional EXT-COPY pollutes the
          srctree in non-flavored in-srctree builds. Fix by making
          EXT-COPY conditional again, but this time skip it only for
          non-flavored in-srctree builds.

 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 044bfdcf5b74..a81af15e4ded 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -382,11 +382,12 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
-# only copy extra resources if in flavored build
+# non-flavored in-srctree builds receive special treatment, in particular, we
+# do not need to copy extra resources (see e.g. test_btf_dump_case())
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
-ifneq ($2,)
+ifneq ($2:$(OUTPUT),:$(shell pwd))
 	$$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
-	$(Q)cp -a $$^ $(TRUNNER_OUTPUT)/
+	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 endif
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
-- 
2.29.2

