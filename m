Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE21830C9
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 14:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLNDb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 09:03:31 -0400
Received: from sym2.noone.org ([178.63.92.236]:42224 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgCLNDb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 09:03:31 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48dTXf4MwmzvjdW; Thu, 12 Mar 2020 14:03:30 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2] bpftool: use linux/types.h from source tree for profiler build
Date:   Thu, 12 Mar 2020 14:03:30 +0100
Message-Id: <20200312130330.32239-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200312105335.10465-1-tklauser@distanz.ch>
References: <20200312105335.10465-1-tklauser@distanz.ch>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling bpftool on a system where the /usr/include/asm symlink
doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed),
the build fails with:

    CLANG    skeleton/profiler.bpf.o
  In file included from skeleton/profiler.bpf.c:4:
  In file included from /usr/include/linux/bpf.h:11:
  /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
  #include <asm/types.h>
           ^~~~~~~~~~~~~
  1 error generated.
  make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1

This indicates that the build is using linux/types.h from system headers
instead of source tree headers.

To fix this, adjust the clang search path to include the necessary
headers from tools/testing/selftests/bpf/include/uapi and
tools/include/uapi. Also use __bitwise__ instead of __bitwise in
skeleton/profiler.h to avoid clashing with the definition in
tools/testing/selftests/bpf/include/uapi/linux/types.h.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/Makefile            |  5 ++++-
 tools/bpf/bpftool/skeleton/profiler.h | 17 ++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 20a90d8450f8..f294f6c1e795 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -120,7 +120,10 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
 
 skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
-	$(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
+	$(QUIET_CLANG)$(CLANG) \
+		-I$(srctree)/tools/include/uapi/ \
+		-I$(srctree)/tools/testing/selftests/bpf/include/uapi \
+		-I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
 
 profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
 	$(QUIET_GEN)$(OUTPUT)./_bpftool gen skeleton skeleton/profiler.bpf.o > $@
diff --git a/tools/bpf/bpftool/skeleton/profiler.h b/tools/bpf/bpftool/skeleton/profiler.h
index e03b53eae767..1f767e9510f7 100644
--- a/tools/bpf/bpftool/skeleton/profiler.h
+++ b/tools/bpf/bpftool/skeleton/profiler.h
@@ -32,16 +32,15 @@ enum {
 #else
 #define __bitwise__
 #endif
-#define __bitwise __bitwise__
 
-typedef __u16 __bitwise __le16;
-typedef __u16 __bitwise __be16;
-typedef __u32 __bitwise __le32;
-typedef __u32 __bitwise __be32;
-typedef __u64 __bitwise __le64;
-typedef __u64 __bitwise __be64;
+typedef __u16 __bitwise__ __le16;
+typedef __u16 __bitwise__ __be16;
+typedef __u32 __bitwise__ __le32;
+typedef __u32 __bitwise__ __be32;
+typedef __u64 __bitwise__ __le64;
+typedef __u64 __bitwise__ __be64;
 
-typedef __u16 __bitwise __sum16;
-typedef __u32 __bitwise __wsum;
+typedef __u16 __bitwise__ __sum16;
+typedef __u32 __bitwise__ __wsum;
 
 #endif /* __PROFILER_H */
-- 
2.25.1

