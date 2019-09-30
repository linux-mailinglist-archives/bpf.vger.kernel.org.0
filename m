Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB5C2744
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2019 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfI3Uvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 16:51:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30132 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729171AbfI3Uva (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Sep 2019 16:51:30 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UIZCk9023252
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 11:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=rNiyO+7h9FlkmiKJo9+ZcI3VdSYSN299VszRbuuyIcY=;
 b=MP3Cm56gQMWPg+tFBrnoIWU8IsgbJljVlueHQobF1CKPlWppwCR4CkSypz6c75rfrCOJ
 NtWx/d1vb0N0CtlWyVlq36VpcH7zHIo4sAuhb2CZPbmH0KTX0r84Tr2nBvzHfF3EpmFI
 eOKQmanMxeFGgBJpji9iMfCaKMa/eNp6K90= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vb66durf6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 11:35:14 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Sep 2019 11:34:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7489037014E8; Mon, 30 Sep 2019 11:34:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kevin Laatz <kevin.laatz@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v4] libbpf: handle symbol versioning properly for libbpf.a
Date:   Mon, 30 Sep 2019 11:34:29 -0700
Message-ID: <20190930183429.2544258-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_11:2019-09-30,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300165
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bcc uses libbpf repo as a submodule. It brings in libbpf source
code and builds everything together to produce shared libraries.
With latest libbpf, I got the following errors:
  /bin/ld: libbcc_bpf.so.0.10.0: version node not found for symbol xsk_umem__create@LIBBPF_0.0.2
  /bin/ld: failed to set dynamic section sizes: Bad value
  collect2: error: ld returned 1 exit status
  make[2]: *** [src/cc/libbcc_bpf.so.0.10.0] Error 1

In xsk.c, we have
  asm(".symver xsk_umem__create_v0_0_2, xsk_umem__create@LIBBPF_0.0.2");
  asm(".symver xsk_umem__create_v0_0_4, xsk_umem__create@@LIBBPF_0.0.4");
The linker thinks the built is for LIBBPF but cannot find proper version
LIBBPF_0.0.2/4, so emit errors.

I also confirmed that using libbpf.a to produce a shared library also
has issues:
  -bash-4.4$ cat t.c
  extern void *xsk_umem__create;
  void * test() { return xsk_umem__create; }
  -bash-4.4$ gcc -c -fPIC t.c
  -bash-4.4$ gcc -shared t.o libbpf.a -o t.so
  /bin/ld: t.so: version node not found for symbol xsk_umem__create@LIBBPF_0.0.2
  /bin/ld: failed to set dynamic section sizes: Bad value
  collect2: error: ld returned 1 exit status
  -bash-4.4$

Symbol versioning does happens in commonly used libraries, e.g., elfutils
and glibc. For static libraries, for a versioned symbol, the old definitions
will be ignored, and the symbol will be an alias to the latest definition.
For example, glibc sched_setaffinity is versioned.
  -bash-4.4$ readelf -s /usr/lib64/libc.so.6 | grep sched_setaffinity
     756: 000000000013d3d0    13 FUNC    GLOBAL DEFAULT   13 sched_setaffinity@GLIBC_2.3.3
     757: 00000000000e2e70   455 FUNC    GLOBAL DEFAULT   13 sched_setaffinity@@GLIBC_2.3.4
    1800: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS sched_setaffinity.c
    4228: 00000000000e2e70   455 FUNC    LOCAL  DEFAULT   13 __sched_setaffinity_new
    4648: 000000000013d3d0    13 FUNC    LOCAL  DEFAULT   13 __sched_setaffinity_old
    7338: 000000000013d3d0    13 FUNC    GLOBAL DEFAULT   13 sched_setaffinity@GLIBC_2
    7380: 00000000000e2e70   455 FUNC    GLOBAL DEFAULT   13 sched_setaffinity@@GLIBC_
  -bash-4.4$
For static library, the definition of sched_setaffinity aliases to the new definition.
  -bash-4.4$ readelf -s /usr/lib64/libc.a | grep sched_setaffinity
  File: /usr/lib64/libc.a(sched_setaffinity.o)
     8: 0000000000000000   455 FUNC    GLOBAL DEFAULT    1 __sched_setaffinity_new
    12: 0000000000000000   455 FUNC    WEAK   DEFAULT    1 sched_setaffinity

For both elfutils and glibc, additional macros are used to control different handling
of symbol versioning w.r.t static and shared libraries.
For elfutils, the macro is SYMBOL_VERSIONING
(https://sourceware.org/git/?p=elfutils.git;a=blob;f=lib/eu-config.h).
For glibc, the macro is SHARED
(https://sourceware.org/git/?p=glibc.git;a=blob;f=include/shlib-compat.h;hb=refs/heads/master)

This patch used SHARED as the macro name. After this patch, the libbpf.a has
  -bash-4.4$ readelf -s libbpf.a | grep xsk_umem__create
     372: 0000000000017145  1190 FUNC    GLOBAL DEFAULT    1 xsk_umem__create_v0_0_4
     405: 0000000000017145  1190 FUNC    WEAK   DEFAULT    1 xsk_umem__create
     499: 00000000000175eb   103 FUNC    GLOBAL DEFAULT    1 xsk_umem__create_v0_0_2
  -bash-4.4$
No versioned symbols for xsk_umem__create.
The libbpf.a can be used to build a shared library succesfully.
  -bash-4.4$ cat t.c
  extern void *xsk_umem__create;
  void * test() { return xsk_umem__create; }
  -bash-4.4$ gcc -c -fPIC t.c
  -bash-4.4$ gcc -shared t.o libbpf.a -o t.so
  -bash-4.4$

Fixes: 10d30e301732 ("libbpf: add flags to umem config")
Cc: Kevin Laatz <kevin.laatz@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/Makefile          | 27 ++++++++++++++++++---------
 tools/lib/bpf/libbpf_internal.h | 16 ++++++++++++++++
 tools/lib/bpf/xsk.c             |  4 ++--
 3 files changed, 36 insertions(+), 11 deletions(-)

ChangeLog:
  v3 -> v4:
     - Raname macros {OLD|NEW}_VERSION to {COMPAT|DEFAULT}_VERSION
       (Alexei).
  v2 -> v3:
     - Rename macro name from SYMBOL_VERSIONING to SHARED,
       plus some other minor changes (Andrii).
  v1 -> v2:
     - Simple hacking to remove versioning for static library, which
       does not work if the versioned symbol is referenced,
     to a proper implementation.

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 20772663d3e1..56ce6292071b 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -114,6 +114,9 @@ override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
 
+# flags specific for shared library
+SHLIB_FLAGS := -DSHARED
+
 ifeq ($(VERBOSE),1)
   Q =
 else
@@ -130,14 +133,17 @@ all:
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-BPF_IN		:= $(OUTPUT)libbpf-in.o
+SHARED_OBJDIR	:= $(OUTPUT)sharedobjs/
+STATIC_OBJDIR	:= $(OUTPUT)staticobjs/
+BPF_IN_SHARED	:= $(SHARED_OBJDIR)libbpf-in.o
+BPF_IN_STATIC	:= $(STATIC_OBJDIR)libbpf-in.o
 VERSION_SCRIPT	:= libbpf.map
 
 LIB_TARGET	:= $(addprefix $(OUTPUT),$(LIB_TARGET))
 LIB_FILE	:= $(addprefix $(OUTPUT),$(LIB_FILE))
 PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
 
-GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN) | \
+GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
 			   sort -u | wc -l)
@@ -159,7 +165,7 @@ all: fixdep
 
 all_cmd: $(CMD_TARGETS) check
 
-$(BPF_IN): force elfdep bpfdep
+$(BPF_IN_SHARED): force elfdep bpfdep
 	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
@@ -175,17 +181,20 @@ $(BPF_IN): force elfdep bpfdep
 	@(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../include/uapi/linux/if_xdp.h && ( \
 	(diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/linux/if_xdp.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
-	$(Q)$(MAKE) $(build)=libbpf
+	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
+
+$(BPF_IN_STATIC): force elfdep bpfdep
+	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
-$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
+$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
 				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
-$(OUTPUT)libbpf.a: $(BPF_IN)
+$(OUTPUT)libbpf.a: $(BPF_IN_STATIC)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.cpp $(OUTPUT)libbpf.a
@@ -201,7 +210,7 @@ check: check_abi
 
 check_abi: $(OUTPUT)libbpf.so
 	@if [ "$(GLOBAL_SYM_COUNT)" != "$(VERSIONED_SYM_COUNT)" ]; then	 \
-		echo "Warning: Num of global symbols in $(BPF_IN)"	 \
+		echo "Warning: Num of global symbols in $(BPF_IN_SHARED)"	 \
 		     "($(GLOBAL_SYM_COUNT)) does NOT match with num of"	 \
 		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
 		     "Please make sure all LIBBPF_API symbols are"	 \
@@ -259,9 +268,9 @@ config-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ clean >/dev/null
 
 clean:
-	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
+	$(call QUIET_CLEAN, libbpf) $(RM) -rf $(TARGETS) $(CXX_TEST_TARGET) \
 		*.o *~ *.a *.so *.so.$(LIBBPF_MAJOR_VERSION) .*.d .*.cmd \
-		*.pc LIBBPF-CFLAGS
+		*.pc LIBBPF-CFLAGS $(SHARED_OBJDIR) $(STATIC_OBJDIR)
 	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
 
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 2e83a34f8c79..f71a35875fb0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -34,6 +34,22 @@
 	(offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
 #endif
 
+/* Symbol versioning is different between static and shared library.
+ * Properly versioned symbols are needed for shared library, but
+ * only the symbol of the new version is needed for static library.
+ */
+#ifdef SHARED
+# define COMPAT_VERSION(internal_name, api_name, version) \
+	asm(".symver " #internal_name "," #api_name "@" #version);
+# define DEFAULT_VERSION(internal_name, api_name, version) \
+	asm(".symver " #internal_name "," #api_name "@@" #version);
+#else
+# define COMPAT_VERSION(internal_name, api_name, version)
+# define DEFAULT_VERSION(internal_name, api_name, version) \
+	extern typeof(internal_name) api_name \
+	__attribute__((weak, alias (#internal_name)));
+#endif
+
 extern void libbpf_print(enum libbpf_print_level level,
 			 const char *format, ...)
 	__attribute__((format(printf, 2, 3)));
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 24fa313524fb..a902838f9fcc 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -261,8 +261,8 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
 	return xsk_umem__create_v0_0_4(umem_ptr, umem_area, size, fill, comp,
 					&config);
 }
-asm(".symver xsk_umem__create_v0_0_2, xsk_umem__create@LIBBPF_0.0.2");
-asm(".symver xsk_umem__create_v0_0_4, xsk_umem__create@@LIBBPF_0.0.4");
+COMPAT_VERSION(xsk_umem__create_v0_0_2, xsk_umem__create, LIBBPF_0.0.2)
+DEFAULT_VERSION(xsk_umem__create_v0_0_4, xsk_umem__create, LIBBPF_0.0.4)
 
 static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 {
-- 
2.17.1

