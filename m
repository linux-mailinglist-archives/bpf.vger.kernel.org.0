Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE627125BD8
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLSHHK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:07:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbfLSHHK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:07:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ74OEn020938
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:07:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=QZLsuwz70l+llSxvzWIZnQVx8Quw7UG/d6jjC2bItVw=;
 b=dPqhKrWnuMEXsZqNt4Zz5gGhwvEBLMF/Q6FYBHs+Bp2wgt4JdkNXA0ArTGziFfFE30k8
 PE6lyPUkRB8DZfJyXguuq0zDausp7ketLqtr6YvYIVChSHo2ZUhJ2XRk7c9YmCWonzQw
 co+RSfcnGa7BdsELsoPXlyXzgwr8U5+uLlQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wysvhtqkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:07:09 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 18 Dec 2019 23:07:08 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DB0012EC16E6; Wed, 18 Dec 2019 23:07:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/3] selftests/bpf: build runqslower from selftests
Date:   Wed, 18 Dec 2019 23:06:58 -0800
Message-ID: <20191219070659.424273-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219070659.424273-1-andriin@fb.com>
References: <20191219070659.424273-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxlogscore=762 phishscore=0 suspectscore=9 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190059
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure runqslower tool from libbpf is built as part of selftests to prevent it
from bit rotting.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c652bd84ef0e..1f8eb95d019c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -75,7 +75,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp
 
-TEST_CUSTOM_PROGS = urandom_read
+TEST_CUSTOM_PROGS = urandom_read runqslower
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
@@ -93,6 +93,7 @@ OVERRIDE_TARGETS := 1
 override define CLEAN
 	$(call msg,    CLEAN)
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
+	$(MAKE) -C $(BPFDIR)/tools/runqslower clean
 endef
 
 include ../lib.mk
@@ -119,6 +120,10 @@ $(OUTPUT)/test_stub.o: test_stub.c
 	$(call msg,         CC,,$@)
 	$(CC) -c $(CFLAGS) -o $@ $<
 
+.PHONY: $(OUTPUT)/runqslower
+$(OUTPUT)/runqslower: force
+	$(MAKE) -C $(BPFDIR)/tools/runqslower
+
 BPFOBJ := $(OUTPUT)/libbpf.a
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
-- 
2.17.1

