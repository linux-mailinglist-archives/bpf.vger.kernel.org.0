Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B367140319C
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhIGXp1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Sep 2021 19:45:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhIGXp0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:45:26 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187NegBv019381
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:44:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcqfa1tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:44:19 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:44:18 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5DF673D405AC; Tue,  7 Sep 2021 16:44:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <quentin@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for scheduling API deprecations
Date:   Tue, 7 Sep 2021 16:44:10 -0700
Message-ID: <20210907234410.3457231-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: beLrg8HGMFN02CmDfJe27VniJgAYKJKA
X-Proofpoint-ORIG-GUID: beLrg8HGMFN02CmDfJe27VniJgAYKJKA
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1034 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109070149
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Quentin Monnet <quentin@isovalent.com>

Introduce a macro LIBBPF_DEPRECATED_SINCE(major, minor, message) to prepare
the deprecation of two API functions. This macro marks functions as deprecated
when libbpf's version reaches the values passed as an argument.

As part of this change libbpf_version.h header is added with recorded major
(LIBBPF_MAJOR_VERSION) and minor (LIBBPF_MINOR_VERSION) libbpf version macros.
They are now part of libbpf public API and can be relied upon by user code.
libbpf_version.h is installed system-wide along other libbpf public headers.

Due to this new build-time auto-generated header, in-kernel applications
relying on libbpf (resolve_btfids and bpftool) are updated to include libbpf's
output directory as part of a list of include search paths. Better fix would
be to use libbpf's make_install target to install public API headers, but that
clean up is left out as a future improvement. The build changes were tested by
building kernel (with KBUILD_OUTPUT and O= specified explicitly), bpftool,
libbpf, selftests/bpf, and resolve_btfids builds. No problems were detected.

Note that because of the constraints of the C preprocessor we have to write
a few lines of macro magic for each version used to prepare deprecation (0.6
for now).

Also, use LIBBPF_DEPRECATED_SINCE() to schedule deprecation of
btf__get_from_id() and btf__load(), which are replaced by
btf__load_from_kernel_by_id() and btf__load_into_kernel(), respectively,
starting from future libbpf v0.6. This is part of libbpf 1.0 effort ([0]).

  [0] Closes: https://github.com/libbpf/libbpf/issues/278

Co-developed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/Makefile        |  4 ++++
 tools/bpf/resolve_btfids/Makefile |  4 +++-
 tools/lib/bpf/Makefile            | 24 +++++++++++++++++-------
 tools/lib/bpf/btf.h               |  2 ++
 tools/lib/bpf/libbpf_common.h     | 19 +++++++++++++++++++
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index d73232be1e99..06aa1616dabe 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -60,6 +60,7 @@ CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(if $(OUTPUT),$(OUTPUT),.) \
+	$(if $(LIBBPF_OUTPUT),-I$(LIBBPF_OUTPUT)) \
 	-I$(srctree)/kernel/bpf/ \
 	-I$(srctree)/tools/include \
 	-I$(srctree)/tools/include/uapi \
@@ -137,7 +138,10 @@ endif
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
 BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
+$(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
+
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
+$(OBJS): $(LIBBPF)
 
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index bb9fa8de7e62..d9ef8a959ed8 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -26,6 +26,7 @@ LIBBPF_SRC := $(srctree)/tools/lib/bpf/
 SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
 
 BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
+LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
 SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
 
 BINARY     := $(OUTPUT)/resolve_btfids
@@ -41,11 +42,12 @@ $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)/libbpf
-	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)  OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)  OUTPUT=$(LIBBPF_OUT) $(abspath $@)
 
 CFLAGS := -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
+          -I$(LIBBPF_OUT) \
           -I$(LIBBPF_SRC) \
           -I$(SUBCMD_SRC)
 
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 74c3b73a5fbe..dab21e0c7cc2 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -8,7 +8,8 @@ VERSION_SCRIPT := libbpf.map
 LIBBPF_VERSION := $(shell \
 	grep -oE '^LIBBPF_([0-9.]+)' $(VERSION_SCRIPT) | \
 	sort -rV | head -n1 | cut -d'_' -f2)
-LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
+LIBBPF_MAJOR_VERSION := $(word 1,$(subst ., ,$(LIBBPF_VERSION)))
+LIBBPF_MINOR_VERSION := $(word 2,$(subst ., ,$(LIBBPF_VERSION)))
 
 MAKEFLAGS += --no-print-directory
 
@@ -59,7 +60,8 @@ ifndef VERBOSE
   VERBOSE = 0
 endif
 
-INCLUDES = -I. -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
+INCLUDES = -I$(if $(OUTPUT),$(OUTPUT),.)				\
+	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
 
 export prefix libdir src obj
 
@@ -111,7 +113,9 @@ SHARED_OBJDIR	:= $(OUTPUT)sharedobjs/
 STATIC_OBJDIR	:= $(OUTPUT)staticobjs/
 BPF_IN_SHARED	:= $(SHARED_OBJDIR)libbpf-in.o
 BPF_IN_STATIC	:= $(STATIC_OBJDIR)libbpf-in.o
+VERSION_HDR	:= $(OUTPUT)libbpf_version.h
 BPF_HELPER_DEFS	:= $(OUTPUT)bpf_helper_defs.h
+BPF_GENERATED	:= $(BPF_HELPER_DEFS) $(VERSION_HDR)
 
 LIB_TARGET	:= $(addprefix $(OUTPUT),$(LIB_TARGET))
 LIB_FILE	:= $(addprefix $(OUTPUT),$(LIB_FILE))
@@ -136,7 +140,7 @@ all: fixdep
 
 all_cmd: $(CMD_TARGETS) check
 
-$(BPF_IN_SHARED): force $(BPF_HELPER_DEFS)
+$(BPF_IN_SHARED): force $(BPF_GENERATED)
 	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
@@ -154,13 +158,19 @@ $(BPF_IN_SHARED): force $(BPF_HELPER_DEFS)
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
 
-$(BPF_IN_STATIC): force $(BPF_HELPER_DEFS)
+$(BPF_IN_STATIC): force $(BPF_GENERATED)
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
 	$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
 		--file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_HELPER_DEFS)
 
+$(VERSION_HDR): force
+	$(QUIET_GEN)echo "/* This file was auto-generated. */" > $@
+	@echo "" >> $@
+	@echo "#define LIBBPF_MAJOR_VERSION $(LIBBPF_MAJOR_VERSION)" >> $@
+	@echo "#define LIBBPF_MINOR_VERSION $(LIBBPF_MINOR_VERSION)" >> $@
+
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED) $(VERSION_SCRIPT)
@@ -224,10 +234,10 @@ install_lib: all_cmd
 		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
 
 INSTALL_HEADERS = bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h \
-		  bpf_helpers.h $(BPF_HELPER_DEFS) bpf_tracing.h	     \
+		  bpf_helpers.h $(BPF_GENERATED) bpf_tracing.h	     \
 		  bpf_endian.h bpf_core_read.h skel_internal.h
 
-install_headers: $(BPF_HELPER_DEFS)
+install_headers: $(BPF_GENERATED)
 	$(call QUIET_INSTALL, headers)					     \
 		$(foreach hdr,$(INSTALL_HEADERS),			     \
 			$(call do_install,$(hdr),$(prefix)/include/bpf,644);)
@@ -240,7 +250,7 @@ install: install_lib install_pkgconfig install_headers
 
 clean:
 	$(call QUIET_CLEAN, libbpf) $(RM) -rf $(CMD_TARGETS)		     \
-		*~ .*.d .*.cmd LIBBPF-CFLAGS $(BPF_HELPER_DEFS)		     \
+		*~ .*.d .*.cmd LIBBPF-CFLAGS $(BPF_GENERATED)		     \
 		$(SHARED_OBJDIR) $(STATIC_OBJDIR)			     \
 		$(addprefix $(OUTPUT),					     \
 			    *.o *.a *.so *.so.$(LIBBPF_MAJOR_VERSION) *.pc)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4a711f990904..f2e2fab950b7 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -50,9 +50,11 @@ LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
 
 LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
 LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_from_kernel_by_id instead")
 LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
 
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_into_kernel instead")
 LIBBPF_API int btf__load(struct btf *btf);
 LIBBPF_API int btf__load_into_kernel(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 947d8bd8a7bb..36ac77f2bea2 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -10,6 +10,7 @@
 #define __LIBBPF_LIBBPF_COMMON_H
 
 #include <string.h>
+#include "libbpf_version.h"
 
 #ifndef LIBBPF_API
 #define LIBBPF_API __attribute__((visibility("default")))
@@ -17,6 +18,24 @@
 
 #define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))
 
+/* Mark a symbol as deprecated when libbpf version is >= {major}.{minor} */
+#define LIBBPF_DEPRECATED_SINCE(major, minor, msg)			    \
+	__LIBBPF_MARK_DEPRECATED_ ## major ## _ ## minor		    \
+		(LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: " msg))
+
+#define __LIBBPF_CURRENT_VERSION_GEQ(major, minor)			    \
+	(LIBBPF_MAJOR_VERSION > (major) ||				    \
+	 (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
+
+/* Add checks for other versions below when planning deprecation of API symbols
+ * with the LIBBPF_DEPRECATED_SINCE macro.
+ */
+#if __LIBBPF_CURRENT_VERSION_GEQ(0, 6)
+#define __LIBBPF_MARK_DEPRECATED_0_6(X) X
+#else
+#define __LIBBPF_MARK_DEPRECATED_0_6(X)
+#endif
+
 /* Helper macro to declare and initialize libbpf options struct
  *
  * This dance with uninitialized declaration, followed by memset to zero,
-- 
2.30.2

