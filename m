Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1368333A087
	for <lists+bpf@lfdr.de>; Sat, 13 Mar 2021 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhCMTgO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 13 Mar 2021 14:36:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234491AbhCMTgF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 13 Mar 2021 14:36:05 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12DJVgen003160
        for <bpf@vger.kernel.org>; Sat, 13 Mar 2021 11:36:05 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 378skh9t1b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 13 Mar 2021 11:36:05 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 13 Mar 2021 11:36:04 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 340EE2ED20BF; Sat, 13 Mar 2021 11:35:59 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 09/11] selftests/bpf: re-generate vmlinux.h and BPF skeletons if bpftool changed
Date:   Sat, 13 Mar 2021 11:35:35 -0800
Message-ID: <20210313193537.1548766-10-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210313193537.1548766-1-andrii@kernel.org>
References: <20210313193537.1548766-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-13_07:2021-03-12,2021-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 clxscore=1034 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trigger vmlinux.h and BPF skeletons re-generation if detected that bpftool was
re-compiled. Otherwise full `make clean` is required to get updated skeletons,
if bpftool is modified.

Fixes: acbd06206bbb ("selftests/bpf: Add vmlinux.h selftest exercising tracing of syscalls")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d0db2b673c6f..dbca39f45382 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -232,7 +232,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                \
 		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
 endif
 
-$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) | $(BPFTOOL) $(INCLUDE_DIR)
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 	$(call msg,GEN,,$@)
 	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
@@ -357,7 +357,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 
 $(TRUNNER_BPF_SKELS): $(TRUNNER_OUTPUT)/%.skel.h:			\
 		      $(TRUNNER_OUTPUT)/%.o				\
-		      | $(BPFTOOL) $(TRUNNER_OUTPUT)
+		      $(BPFTOOL)					\
+		      | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen skeleton $$< > $$@
 endif
-- 
2.24.1

