Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22163D6196
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 18:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhGZPcU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Jul 2021 11:32:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55662 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231848AbhGZPcG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 11:32:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16QGA5cZ001645
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3a0eceavad-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:35 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:12:32 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D70DA3D405AD; Mon, 26 Jul 2021 09:12:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 bpf-next 07/14] libbpf: re-build libbpf.so when libbpf.map changes
Date:   Mon, 26 Jul 2021 09:12:04 -0700
Message-ID: <20210726161211.925206-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726161211.925206-1-andrii@kernel.org>
References: <20210726161211.925206-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ctXlTzPUgXQfATYaidSY5fyLm7N9nV1H
X-Proofpoint-ORIG-GUID: ctXlTzPUgXQfATYaidSY5fyLm7N9nV1H
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107260094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure libbpf.so is re-built whenever libbpf.map is modified.  Without this,
changes to libbpf.map are not detected and versioned symbols mismatch error
will be reported until `make clean && make` is used, which is a suboptimal
developer experience.

Fixes: 306b267cb3c4 ("libbpf: Verify versioned symbols")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index ec14aa725bb0..74c3b73a5fbe 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -4,8 +4,9 @@
 RM ?= rm
 srctree = $(abs_srctree)
 
+VERSION_SCRIPT := libbpf.map
 LIBBPF_VERSION := $(shell \
-	grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
+	grep -oE '^LIBBPF_([0-9.]+)' $(VERSION_SCRIPT) | \
 	sort -rV | head -n1 | cut -d'_' -f2)
 LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
 
@@ -110,7 +111,6 @@ SHARED_OBJDIR	:= $(OUTPUT)sharedobjs/
 STATIC_OBJDIR	:= $(OUTPUT)staticobjs/
 BPF_IN_SHARED	:= $(SHARED_OBJDIR)libbpf-in.o
 BPF_IN_STATIC	:= $(STATIC_OBJDIR)libbpf-in.o
-VERSION_SCRIPT	:= libbpf.map
 BPF_HELPER_DEFS	:= $(OUTPUT)bpf_helper_defs.h
 
 LIB_TARGET	:= $(addprefix $(OUTPUT),$(LIB_TARGET))
@@ -163,10 +163,10 @@ $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
 
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
-$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED)
+$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED) $(VERSION_SCRIPT)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) \
 		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
-		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -lz -o $@
+		-Wl,--version-script=$(VERSION_SCRIPT) $< -lelf -lz -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
@@ -181,7 +181,7 @@ $(OUTPUT)libbpf.pc:
 
 check: check_abi
 
-check_abi: $(OUTPUT)libbpf.so
+check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 	@if [ "$(GLOBAL_SYM_COUNT)" != "$(VERSIONED_SYM_COUNT)" ]; then	 \
 		echo "Warning: Num of global symbols in $(BPF_IN_SHARED)"	 \
 		     "($(GLOBAL_SYM_COUNT)) does NOT match with num of"	 \
-- 
2.30.2

