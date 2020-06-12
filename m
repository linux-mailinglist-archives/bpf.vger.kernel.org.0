Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E827A1F7EF3
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLWfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:35:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1286 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgFLWfM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 18:35:12 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CMZ21K012291
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dZPjfJ4jpnFYdyEqwj3OWwDlOMWNrWUwlrURgkLJtUM=;
 b=H4+A7E7bem1X0TO3fx4RgH7El+m81F1hgs/Be1sEMr4iW2gezkFgI6uF8JPU/hJseqlL
 6No1fBAGp1itXrkOyFtereNRTuG934KZ7Ozd3Yd+m1CMQZUCMvCLb5jNgfk/9LaZ4KWY
 JoIceg3YBBUNIK39pXQtQdLGVQEjaKH1YHk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31mcnr1u53-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:35:10 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 15:34:42 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 54E3B2EC1DA9; Fri, 12 Jun 2020 15:32:11 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next 6/8] tools/bpftool: generalize BPF skeleton support and generate vmlinux.h
Date:   Fri, 12 Jun 2020 15:31:48 -0700
Message-ID: <20200612223150.1177182-7-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200612223150.1177182-1-andriin@fb.com>
References: <20200612223150.1177182-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 cotscore=-2147483648 suspectscore=8 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adapt Makefile to support BPF skeleton generation beyond single profiler.=
bpf.c
case. Also add vmlinux.h generation and switch profiler.bpf.c to use it.

clang-bpf-global-var feature is extended and renamed to clang-bpf-co-re t=
o
check for support of preserve_access_index attribute, which, together wit=
h BTF
for global variables, is the minimum requirement for modern BPF programs.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/.gitignore                  |  3 +-
 tools/bpf/bpftool/Makefile                    | 42 ++++++++++++-----
 tools/bpf/bpftool/skeleton/profiler.bpf.c     |  3 +-
 tools/bpf/bpftool/skeleton/profiler.h         | 46 -------------------
 tools/build/feature/Makefile                  |  4 +-
 tools/build/feature/test-clang-bpf-co-re.c    |  9 ++++
 .../build/feature/test-clang-bpf-global-var.c |  4 --
 7 files changed, 45 insertions(+), 66 deletions(-)
 delete mode 100644 tools/bpf/bpftool/skeleton/profiler.h
 create mode 100644 tools/build/feature/test-clang-bpf-co-re.c
 delete mode 100644 tools/build/feature/test-clang-bpf-global-var.c

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index ce721adf3161..3e601bcfd461 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -7,4 +7,5 @@ bpf-helpers.*
 FEATURE-DUMP.bpftool
 feature
 libbpf
-profiler.skel.h
+/*.skel.h
+/vmlinux.h
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index eec2da4d45d2..bdb6e38c6c5c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -42,6 +42,7 @@ CFLAGS +=3D -O2
 CFLAGS +=3D -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-in=
itializers
 CFLAGS +=3D $(filter-out -Wswitch-enum,$(EXTRA_WARNINGS))
 CFLAGS +=3D -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEADERS__ \
+	-I$(if $(OUTPUT),$(OUTPUT),.) \
 	-I$(srctree)/kernel/bpf/ \
 	-I$(srctree)/tools/include \
 	-I$(srctree)/tools/include/uapi \
@@ -61,9 +62,9 @@ CLANG ?=3D clang
=20
 FEATURE_USER =3D .bpftool
 FEATURE_TESTS =3D libbfd disassembler-four-args reallocarray zlib libcap=
 \
-	clang-bpf-global-var
+	clang-bpf-co-re
 FEATURE_DISPLAY =3D libbfd disassembler-four-args zlib libcap \
-	clang-bpf-global-var
+	clang-bpf-co-re
=20
 check_feat :=3D 1
 NON_CHECK_FEAT_TARGETS :=3D clean uninstall doc doc-clean doc-install do=
c-uninstall
@@ -121,20 +122,38 @@ BPFTOOL_BOOTSTRAP :=3D $(if $(OUTPUT),$(OUTPUT)bpft=
ool-bootstrap,./bpftool-bootstr
 BOOTSTRAP_OBJS =3D $(addprefix $(OUTPUT),main.o common.o json_writer.o g=
en.o btf.o)
 OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
=20
-ifneq ($(feature-clang-bpf-global-var),1)
-	CFLAGS +=3D -DBPFTOOL_WITHOUT_SKELETONS
-endif
+VMLINUX_BTF_PATHS :=3D $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../vmlinux					\
+		     /sys/kernel/btf/vmlinux				\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF :=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
+
+ifneq ($(VMLINUX_BTF),)
+ifeq ($(feature-clang-bpf-co-re),1)
+
+BUILD_BPF_SKELS :=3D 1
+
+$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
+	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@
=20
-skeleton/profiler.bpf.o: skeleton/profiler.bpf.c $(LIBBPF)
+$(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF)
 	$(QUIET_CLANG)$(CLANG) \
+		-I$(if $(OUTPUT),$(OUTPUT),.) \
 		-I$(srctree)/tools/include/uapi/ \
-		-I$(LIBBPF_PATH) -I$(srctree)/tools/lib \
+		-I$(LIBBPF_PATH) \
+		-I$(srctree)/tools/lib \
 		-g -O2 -target bpf -c $< -o $@
=20
-profiler.skel.h: $(BPFTOOL_BOOTSTRAP) skeleton/profiler.bpf.o
-	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton skeleton/profiler.bpf.o >=
 $@
+$(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
+	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton $< > $@
+
+$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h
+
+endif
+endif
=20
-$(OUTPUT)prog.o: prog.c profiler.skel.h
+CFLAGS +=3D $(if BUILD_BPF_SKELS,,-DBPFTOOL_WITHOUT_SKELETONS)
=20
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
@@ -153,7 +172,7 @@ $(OUTPUT)%.o: %.c
 clean: $(LIBBPF)-clean
 	$(call QUIET_CLEAN, bpftool)
 	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
-	$(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) profiler.skel.h skeleton/profiler.bpf=
.o
+	$(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
 	$(Q)$(RM) -r -- $(OUTPUT)libbpf/
 	$(call QUIET_CLEAN, core-gen)
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
@@ -188,6 +207,7 @@ FORCE:
 zdep:
 	@if [ "$(feature-zlib)" !=3D "1" ]; then echo "No zlib found"; exit 1 ;=
 fi
=20
+.SECONDARY:
 .PHONY: all FORCE clean install uninstall zdep
 .PHONY: doc doc-clean doc-install doc-uninstall
 .DEFAULT_GOAL :=3D all
diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftoo=
l/skeleton/profiler.bpf.c
index 20034c12f7c5..5207880b9204 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-#include "profiler.h"
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
=20
diff --git a/tools/bpf/bpftool/skeleton/profiler.h b/tools/bpf/bpftool/sk=
eleton/profiler.h
deleted file mode 100644
index 1f767e9510f7..000000000000
--- a/tools/bpf/bpftool/skeleton/profiler.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
-#ifndef __PROFILER_H
-#define __PROFILER_H
-
-/* useful typedefs from vmlinux.h */
-
-typedef signed char __s8;
-typedef unsigned char __u8;
-typedef short int __s16;
-typedef short unsigned int __u16;
-typedef int __s32;
-typedef unsigned int __u32;
-typedef long long int __s64;
-typedef long long unsigned int __u64;
-
-typedef __s8 s8;
-typedef __u8 u8;
-typedef __s16 s16;
-typedef __u16 u16;
-typedef __s32 s32;
-typedef __u32 u32;
-typedef __s64 s64;
-typedef __u64 u64;
-
-enum {
-	false =3D 0,
-	true =3D 1,
-};
-
-#ifdef __CHECKER__
-#define __bitwise__ __attribute__((bitwise))
-#else
-#define __bitwise__
-#endif
-
-typedef __u16 __bitwise__ __le16;
-typedef __u16 __bitwise__ __be16;
-typedef __u32 __bitwise__ __le32;
-typedef __u32 __bitwise__ __be32;
-typedef __u64 __bitwise__ __le64;
-typedef __u64 __bitwise__ __be64;
-
-typedef __u16 __bitwise__ __sum16;
-typedef __u32 __bitwise__ __wsum;
-
-#endif /* __PROFILER_H */
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 84f845b9627d..26d11a1a9870 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -68,7 +68,7 @@ FILES=3D                                          \
          test-llvm-version.bin			\
          test-libaio.bin			\
          test-libzstd.bin			\
-         test-clang-bpf-global-var.bin		\
+         test-clang-bpf-co-re.bin		\
          test-file-handle.bin			\
          test-libpfm4.bin
=20
@@ -325,7 +325,7 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
=20
-$(OUTPUT)test-clang-bpf-global-var.bin:
+$(OUTPUT)test-clang-bpf-co-re.bin:
 	$(CLANG) -S -g -target bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
 		grep BTF_KIND_VAR
=20
diff --git a/tools/build/feature/test-clang-bpf-co-re.c b/tools/build/fea=
ture/test-clang-bpf-co-re.c
new file mode 100644
index 000000000000..cb5265bfdd83
--- /dev/null
+++ b/tools/build/feature/test-clang-bpf-co-re.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+struct test {
+	int a;
+	int b;
+} __attribute__((preserve_access_index));
+
+volatile struct test global_value_for_test =3D {};
diff --git a/tools/build/feature/test-clang-bpf-global-var.c b/tools/buil=
d/feature/test-clang-bpf-global-var.c
deleted file mode 100644
index 221f1481d52e..000000000000
--- a/tools/build/feature/test-clang-bpf-global-var.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2020 Facebook
-
-volatile int global_value_for_test =3D 1;
--=20
2.24.1

