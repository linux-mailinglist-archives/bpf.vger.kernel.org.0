Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF101409F15
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhIMV2c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Sep 2021 17:28:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50994 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhIMV2b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 17:28:31 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DH3kma000491
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 14:27:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xdq5p5n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 14:27:15 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 14:27:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9859A3F42CBE; Mon, 13 Sep 2021 14:27:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: make libbpf_version.h non-auto-generated
Date:   Mon, 13 Sep 2021 14:27:08 -0700
Message-ID: <20210913212708.2826473-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: U2mwJ89igc91VX61qvQFOjDj-KfUBXbh
X-Proofpoint-GUID: U2mwJ89igc91VX61qvQFOjDj-KfUBXbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turn previously auto-generated libbpf_version.h header into a normal
header file. This prevents various tricky Makefile integration issues,
simplifies the overall build process, but also allows to further extend
it with some more versioning-related APIs in the future.

To prevent accidental out-of-sync versions as defined by libbpf.map and
libbpf_version.h, Makefile checks their consistency at build time.

Simultaneously with this change bump libbpf.map to v0.6.

Fixes: 0b46b7550560 ("libbpf: Add LIBBPF_DEPRECATED_SINCE macro for scheduling API deprecations")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/.gitignore       |  1 -
 tools/lib/bpf/Makefile         | 32 +++++++++++++++++++++-----------
 tools/lib/bpf/libbpf.map       |  3 +++
 tools/lib/bpf/libbpf_version.h |  9 +++++++++
 4 files changed, 33 insertions(+), 12 deletions(-)
 create mode 100644 tools/lib/bpf/libbpf_version.h

diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
index 5d4cfac671d5..0da84cb9e66d 100644
--- a/tools/lib/bpf/.gitignore
+++ b/tools/lib/bpf/.gitignore
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-libbpf_version.h
 libbpf.pc
 libbpf.so.*
 TAGS
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index dab21e0c7cc2..3f6f8aa3b3a4 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -115,7 +115,7 @@ BPF_IN_SHARED	:= $(SHARED_OBJDIR)libbpf-in.o
 BPF_IN_STATIC	:= $(STATIC_OBJDIR)libbpf-in.o
 VERSION_HDR	:= $(OUTPUT)libbpf_version.h
 BPF_HELPER_DEFS	:= $(OUTPUT)bpf_helper_defs.h
-BPF_GENERATED	:= $(BPF_HELPER_DEFS) $(VERSION_HDR)
+BPF_GENERATED	:= $(BPF_HELPER_DEFS)
 
 LIB_TARGET	:= $(addprefix $(OUTPUT),$(LIB_TARGET))
 LIB_FILE	:= $(addprefix $(OUTPUT),$(LIB_FILE))
@@ -165,12 +165,6 @@ $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
 	$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
 		--file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_HELPER_DEFS)
 
-$(VERSION_HDR): force
-	$(QUIET_GEN)echo "/* This file was auto-generated. */" > $@
-	@echo "" >> $@
-	@echo "#define LIBBPF_MAJOR_VERSION $(LIBBPF_MAJOR_VERSION)" >> $@
-	@echo "#define LIBBPF_MINOR_VERSION $(LIBBPF_MINOR_VERSION)" >> $@
-
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED) $(VERSION_SCRIPT)
@@ -189,7 +183,7 @@ $(OUTPUT)libbpf.pc:
 		-e "s|@VERSION@|$(LIBBPF_VERSION)|" \
 		< libbpf.pc.template > $@
 
-check: check_abi
+check: check_abi check_version
 
 check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 	@if [ "$(GLOBAL_SYM_COUNT)" != "$(VERSIONED_SYM_COUNT)" ]; then	 \
@@ -215,6 +209,21 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 		exit 1;							 \
 	fi
 
+HDR_MAJ_VERSION := $(shell grep -oE '^\#define LIBBPF_MAJOR_VERSION ([0-9]+)$$' libbpf_version.h | cut -d' ' -f3)
+HDR_MIN_VERSION := $(shell grep -oE '^\#define LIBBPF_MINOR_VERSION ([0-9]+)$$' libbpf_version.h | cut -d' ' -f3)
+
+check_version: $(VERSION_SCRIPT) $(VERSION_HDR)
+	@if [ "$(HDR_MAJ_VERSION)" != "$(LIBBPF_MAJOR_VERSION)" ]; then        \
+		echo "Error: libbpf major version mismatch detected: "	       \
+		     "'$(HDR_MAJ_VERSION)' != '$(LIBBPF_MAJOR_VERSION)'" >&2;  \
+		exit 1;							       \
+	fi
+	@if [ "$(HDR_MIN_VERSION)" != "$(LIBBPF_MINOR_VERSION)" ]; then	       \
+		echo "Error: libbpf minor version mismatch detected: "	       \
+		     "'$(HDR_MIN_VERSION)' != '$(LIBBPF_MINOR_VERSION)'" >&2;  \
+		exit 1;							       \
+	fi
+
 define do_install_mkdir
 	if [ ! -d '$(DESTDIR_SQ)$1' ]; then		\
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1';	\
@@ -234,8 +243,9 @@ install_lib: all_cmd
 		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
 
 INSTALL_HEADERS = bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h \
-		  bpf_helpers.h $(BPF_GENERATED) bpf_tracing.h	     \
-		  bpf_endian.h bpf_core_read.h skel_internal.h
+		  bpf_helpers.h $(BPF_GENERATED) bpf_tracing.h		     \
+		  bpf_endian.h bpf_core_read.h skel_internal.h		     \
+		  libbpf_version.h
 
 install_headers: $(BPF_GENERATED)
 	$(call QUIET_INSTALL, headers)					     \
@@ -255,7 +265,7 @@ clean:
 		$(addprefix $(OUTPUT),					     \
 			    *.o *.a *.so *.so.$(LIBBPF_MAJOR_VERSION) *.pc)
 
-PHONY += force cscope tags
+PHONY += force cscope tags check check_abi check_version
 force:
 
 cscope:
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index bbc53bb25f68..78ea62c9346f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -386,3 +386,6 @@ LIBBPF_0.5.0 {
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
 } LIBBPF_0.4.0;
+
+LIBBPF_0.6.0 {
+} LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
new file mode 100644
index 000000000000..dd56d76f291c
--- /dev/null
+++ b/tools/lib/bpf/libbpf_version.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (C) 2021 Facebook */
+#ifndef __LIBBPF_VERSION_H
+#define __LIBBPF_VERSION_H
+
+#define LIBBPF_MAJOR_VERSION 0
+#define LIBBPF_MINOR_VERSION 6
+
+#endif /* __LIBBPF_VERSION_H */
-- 
2.30.2

