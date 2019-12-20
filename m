Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5662A1273D9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 04:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLTD0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 22:26:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44885 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLTD0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 22:26:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so4205805pgl.11;
        Thu, 19 Dec 2019 19:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIPPkCS7n5fn+dgjA8yD3jKqMy1GLUWmBCnKSFockpQ=;
        b=e6uisxyLj8AFP4GjoxH1z7LjsCTcnfWL+8JxGdmEAlxjY1sSdMN19Ivq7bJQsYcKnt
         /qIYxzTf+0WydlkEvKBC4lg/Y057lFJvqwb1+42XIBfRnrShlVtxgDenjTEF0RgphuXD
         tZe4n45wzNUBL2k+W3UBBX+Ab3JxGwLgILmKBVi/LR274uHKsVWocbGWbd3c5hYYRR/3
         f5ATOQcWp3/BO4e9HbNiFLWz0qD5hFJALXjXyITmM/LHS3qprW0HX6HelRJlCrQDiogQ
         PMoD+OGjfNbGvM1Ag8ITi/CdFOIKU+b1nKLZPI0LBmKxL4qW/3JPU5k9Wi6RMJiIRJa+
         MaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RIPPkCS7n5fn+dgjA8yD3jKqMy1GLUWmBCnKSFockpQ=;
        b=Bv9oMQfotrzYZFVYtVV2mKRF50GH/23m18k/8MHhXgnCpD0srUGiaoRV9uYoCMaKXT
         DEErMxK6SOMVNJfAkbGFtm28I6CoNDp+tjfI7hKXlQePGoUsqb2gx7jMbLnARaTyXLTS
         LlzXqbFjWRVYjBrjtJBu5sDDNkRJi2GssmdgYUmRSR+gU6cRIsZG+J8KpQjbFPjfPGL4
         04fD4aWe1qx72QI1TeyGUZeYCgaPXFEC0G/w93E8P57VA0xXXkHBYvz6CvXvwh+K9a7Q
         V1hbwXBmyLrwLOe5MOdhy1eySx7z+kgE8rKVk9sBsNV6SCVdL8/I6d4B7McWCvH2WeuK
         YUNg==
X-Gm-Message-State: APjAAAXHpYOmqZFiAAuwgssUZIhKeqmPKHZ8XTztC5S+aZqyeOw9hrCV
        BzDJNKkcYRL25F3iQhSECI8=
X-Google-Smtp-Source: APXvYqzhuTMEplEt3U8y02dqoiAOWAT5VoLyuXYEgji9uu5OOacXqeMiUndp5eU6in4H6p31kReucA==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr13247637pfp.97.1576812365598;
        Thu, 19 Dec 2019 19:26:05 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id 200sm10217385pfz.121.2019.12.19.19.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 19:26:04 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] libbpf: Fix build on read-only filesystems
Date:   Fri, 20 Dec 2019 12:25:58 +0900
Message-Id: <20191220032558.3259098-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I got the following error when I tried to build perf on a read-only
filesystem with O=dir option.

  $ cd /some/where/ro/linux/tools/perf
  $ make O=$HOME/build/perf
  ...
    CC       /home/namhyung/build/perf/lib.o
  /bin/sh: bpf_helper_defs.h: Read-only file system
  make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
  make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
  make[2]: *** Waiting for unfinished jobs....
    LD       /home/namhyung/build/perf/libperf-in.o
    AR       /home/namhyung/build/perf/libperf.a
    PERF_VERSION = 5.4.0
  make[1]: *** [Makefile.perf:225: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2

It was becaused bpf_helper_defs.h was generated in current directory.
Move it to OUTPUT directory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/bpf/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 99425d0be6ff..2f42a35f4634 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -159,7 +159,7 @@ all: fixdep
 
 all_cmd: $(CMD_TARGETS) check
 
-$(BPF_IN_SHARED): force elfdep bpfdep bpf_helper_defs.h
+$(BPF_IN_SHARED): force elfdep bpfdep $(OUTPUT)bpf_helper_defs.h
 	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
@@ -177,12 +177,12 @@ $(BPF_IN_SHARED): force elfdep bpfdep bpf_helper_defs.h
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
 
-$(BPF_IN_STATIC): force elfdep bpfdep bpf_helper_defs.h
+$(BPF_IN_STATIC): force elfdep bpfdep $(OUTPUT)bpf_helper_defs.h
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
-bpf_helper_defs.h: $(srctree)/include/uapi/linux/bpf.h
+$(OUTPUT)bpf_helper_defs.h: $(srctree)/include/uapi/linux/bpf.h
 	$(Q)$(srctree)/scripts/bpf_helpers_doc.py --header 		\
-		--file $(srctree)/include/uapi/linux/bpf.h > bpf_helper_defs.h
+		--file $(srctree)/include/uapi/linux/bpf.h > $(OUTPUT)bpf_helper_defs.h
 
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
@@ -246,7 +246,7 @@ install_lib: all_cmd
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers: bpf_helper_defs.h
+install_headers: $(OUTPUT)bpf_helper_defs.h
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,bpf.h,$(prefix)/include/bpf,644); \
 		$(call do_install,libbpf.h,$(prefix)/include/bpf,644); \
@@ -254,7 +254,7 @@ install_headers: bpf_helper_defs.h
 		$(call do_install,libbpf_util.h,$(prefix)/include/bpf,644); \
 		$(call do_install,xsk.h,$(prefix)/include/bpf,644); \
 		$(call do_install,bpf_helpers.h,$(prefix)/include/bpf,644); \
-		$(call do_install,bpf_helper_defs.h,$(prefix)/include/bpf,644); \
+		$(call do_install,$(OUTPUT)bpf_helper_defs.h,$(prefix)/include/bpf,644); \
 		$(call do_install,bpf_tracing.h,$(prefix)/include/bpf,644); \
 		$(call do_install,bpf_endian.h,$(prefix)/include/bpf,644); \
 		$(call do_install,bpf_core_read.h,$(prefix)/include/bpf,644);
@@ -274,7 +274,7 @@ install: install_lib install_pkgconfig
 clean:
 	$(call QUIET_CLEAN, libbpf) $(RM) -rf $(CMD_TARGETS) \
 		*.o *~ *.a *.so *.so.$(LIBBPF_MAJOR_VERSION) .*.d .*.cmd \
-		*.pc LIBBPF-CFLAGS bpf_helper_defs.h \
+		*.pc LIBBPF-CFLAGS $(OUTPUT)bpf_helper_defs.h \
 		$(SHARED_OBJDIR) $(STATIC_OBJDIR)
 	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
 
-- 
2.24.1.735.g03f4e72817-goog

