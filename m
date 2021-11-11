Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50F744D1B2
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhKKFjz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:39:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22016 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbhKKFjx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:39:53 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB5anZD020691
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:37:04 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8tfegq7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:37:04 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:36:33 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9E0788B0E62B; Wed, 10 Nov 2021 21:36:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/9] bpftool: normalize compile rules to specify output file last
Date:   Wed, 10 Nov 2021 21:36:16 -0800
Message-ID: <20211111053624.190580-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111053624.190580-1-andrii@kernel.org>
References: <20211111053624.190580-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: vuFtzTq52szom9WdQGdcHBelp6x7CMO1
X-Proofpoint-ORIG-GUID: vuFtzTq52szom9WdQGdcHBelp6x7CMO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When dealing with verbose Makefile output, it's extremely confusing when
compiler invocation commands don't specify -o <output.o> as the last
argument. Normalize bpftool's Makefile to do just that, as most other
BPF-related Makefiles are already doing that.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 622568c7a9b8..31dfef6a4121 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -177,7 +177,8 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF)
 		-I$(if $(OUTPUT),$(OUTPUT),.) \
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_INCLUDE) \
-		-g -O2 -Wall -target bpf -c $< -o $@ && $(LLVM_STRIP) -g $@
+		-g -O2 -Wall -target bpf -c $< -o $@
+	$(Q)$(LLVM_STRIP) -g $@
 
 $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
 	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton $< > $@
@@ -192,10 +193,10 @@ endif
 CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
 
 $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
-	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
+	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
-	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)feature.o:
 ifneq ($(feature-zlib), 1)
@@ -203,17 +204,16 @@ ifneq ($(feature-zlib), 1)
 endif
 
 $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
-	$(QUIET_LINK)$(HOSTCC) $(CFLAGS) $(LDFLAGS) -o $@ $(BOOTSTRAP_OBJS) \
-		$(LIBS_BOOTSTRAP)
+	$(QUIET_LINK)$(HOSTCC) $(CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
 
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
 
 $(BOOTSTRAP_OUTPUT)%.o: %.c $(LIBBPF_INTERNAL_HDRS) | $(BOOTSTRAP_OUTPUT)
-	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
+	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD $< -o $@
 
 $(OUTPUT)%.o: %.c
-	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
 
 feature-detect-clean:
 	$(call QUIET_CLEAN, feature-detect)
-- 
2.30.2

