Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6632229E
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBVXZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 18:25:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230040AbhBVXZw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 18:25:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MN4RxE171088;
        Mon, 22 Feb 2021 18:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xVR0raTk2sprTo8jxMIqOS/mtPcHjokL4b6HZb7/rC8=;
 b=bq6gFF5uuMiIBdBdWke3LXEC0BSDDLxvZ0RiRnyM2gYzxAKt9k9iSZ1mTcluFKxp36Xa
 NV5yAqIv9NcBmK58QjEXsKYpgj4xKm+B+KmxubhRD5dp0P5l3cFhqd5q+shN7ZYS7lCr
 3fD9k+3JHuWd9izj00mJUSFhXZ0knbcr1wZrUTlnFzjwGkTTM2yr5DpeDX3FE4Yb1T6o
 8KTgI+K4pKBbKkxIJLPgoQewlK7RdLUoIegzc75er6ZDFPfBGnzwm6UPnnRDkLd1jr4J
 r8JgRpE+6vh0PRcFQUeXqwuTYyvILYmKZFbZ1rOng0j56hn3Q8IUtcyaOjBA2hFvZBZH iw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkftn815-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 18:25:00 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MNC6a5020415;
        Mon, 22 Feb 2021 23:24:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28a33n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 23:24:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MNOtie48562482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 23:24:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4442EAE04D;
        Mon, 22 Feb 2021 23:24:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF7B8AE045;
        Mon, 22 Feb 2021 23:24:54 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 23:24:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Copy extra resources in the non-flavored build too
Date:   Tue, 23 Feb 2021 00:24:51 +0100
Message-Id: <20210222232451.84574-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_08:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220199
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building selftests in a separate directory like this:

    make O=... -C tools/testing/selftests/bpf

and then running:

    ./test_progs -t btf

causes all the non-flavored btf_dump_test_case_*.c tests to fail,
because these files are not copied to where test_progs expects to find
them.

Fix by removing the flavored build check and using rsync instead of cp:
cp fails because e.g. urandom_read is being copied into itself, and
rsync simply skips such cases. rsync is used by kselftests elsewhere
and therefore is not a new dependency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 044bfdcf5b74..192119f6aeb7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -382,12 +382,9 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
-# only copy extra resources if in flavored build
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
-ifneq ($2,)
 	$$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
-	$(Q)cp -a $$^ $(TRUNNER_OUTPUT)/
-endif
+	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
-- 
2.29.2

