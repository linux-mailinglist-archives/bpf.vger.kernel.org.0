Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF048DF9A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfHNVDz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 17:03:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbfHNVDz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Aug 2019 17:03:55 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EKxeau000365
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 14:03:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=pt8DX9ADvMiDJpeBuJjyrRAEy+R1WsHfHFr9DkwWeSg=;
 b=qWMhvpihX4l5iia7k5OXqnIiW2MHuXLNHGy+V5RbtXKGmpAk7G1i7SMAbchrj1dE3gfq
 S9IVZtLOQlBuw55o16h1dbAXtJU5omyyllrP87pcothSIfD64w/TgYWUCjYMYsg6BqNj
 KakgAZKWPPPFlc0loEZts2Hwdsnve+EQVZM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ucrp2g99k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 14:03:54 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Aug 2019 14:01:36 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id C0F068617B4; Wed, 14 Aug 2019 13:05:49 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <rdna@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next] libbpf: make libbpf.map source of truth for libbpf version
Date:   Wed, 14 Aug 2019 13:05:48 -0700
Message-ID: <20190814200548.623033-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140190
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently libbpf version is specified in 2 places: libbpf.map and
Makefile. They easily get out of sync and it's very easy to update one,
but forget to update another one. In addition, Github projection of
libbpf has to maintain its own version which has to be remembered to be
kept in sync manually, which is very error-prone approach.

This patch makes libbpf.map a source of truth for libbpf version and
uses shell invocation to parse out correct full and major libbpf version
to use during build. Now we need to make sure that once new release
cycle starts, we need to add (initially) empty section to libbpf.map
with correct latest version.

This also will make it possible to keep Github projection consistent
with kernel sources version of libbpf by adopting similar parsing of
version from libbpf.map.

v2->v3:
- grep -o + sort -rV (Andrey);

v1->v2:
- eager version vars evaluation (Jakub);
- simplified version regex (Andrey);

Cc: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/Makefile   | 20 ++++++++------------
 tools/lib/bpf/libbpf.map |  3 +++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 9312066a1ae3..148a27164189 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Most of this file is copied from tools/lib/traceevent/Makefile
 
-BPF_VERSION = 0
-BPF_PATCHLEVEL = 0
-BPF_EXTRAVERSION = 4
+LIBBPF_VERSION := $(shell \
+	grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
+	sort -rV | head -n1 | cut -d'_' -f2)
+LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
 
 MAKEFLAGS += --no-print-directory
 
@@ -79,15 +80,9 @@ export prefix libdir src obj
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-VERSION		= $(BPF_VERSION)
-PATCHLEVEL	= $(BPF_PATCHLEVEL)
-EXTRAVERSION	= $(BPF_EXTRAVERSION)
-
 OBJ		= $@
 N		=
 
-LIBBPF_VERSION	= $(BPF_VERSION).$(BPF_PATCHLEVEL).$(BPF_EXTRAVERSION)
-
 LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
 LIB_FILE	= libbpf.a libbpf.so*
 PC_FILE		= libbpf.pc
@@ -178,10 +173,10 @@ $(BPF_IN): force elfdep bpfdep
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(VERSION) \
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
 				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
-	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
+	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
 $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
@@ -257,7 +252,8 @@ config-clean:
 
 clean:
 	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
-		*.o *~ *.a *.so *.so.$(VERSION) .*.d .*.cmd *.pc LIBBPF-CFLAGS
+		*.o *~ *.a *.so *.so.$(LIBBPF_MAJOR_VERSION) .*.d .*.cmd \
+		*.pc LIBBPF-CFLAGS
 	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
 
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8..4e72df8e98ba 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -184,3 +184,6 @@ LIBBPF_0.0.4 {
 		perf_buffer__new_raw;
 		perf_buffer__poll;
 } LIBBPF_0.0.3;
+
+LIBBPF_0.0.5 {
+} LIBBPF_0.0.4;
-- 
2.17.1

