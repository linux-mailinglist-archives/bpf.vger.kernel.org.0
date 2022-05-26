Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD7535136
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiEZPHt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 11:07:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA51A828;
        Thu, 26 May 2022 08:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D64F2B8205B;
        Thu, 26 May 2022 15:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C84EC385A9;
        Thu, 26 May 2022 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653577664;
        bh=x3d7TqSbxMJllfd2k1XcRmoR2wsqAstaGdnx9rmo3sA=;
        h=Date:From:To:Cc:Subject:From;
        b=u6c9xivvO/CPbJwlPcOZvTKkD0fL/a7YEuR7dq4KPBNBCCQgzdMd3Ck/vTGCfpKW1
         7IMKOD7E75wuqdO0q2I1ppRkWxsg/8V/tOLftqCvLn/VKXH2weL87aW1JG7y+AjE8+
         ULe5ytBIXZDImMrOp2U8HW7gHpyFL2qLGUZgQHXvgjlEHUz670z6/gHXbcSOc7kMpj
         roBxR04oLPffNRIetb3Iy2eQrqekiDEqyRdhiexIqBFSk2jeG4CdGSSOHv47WZasGQ
         m07XKbT3SPiYDeZF7e3dB72gY1EAUfLLq/w3hED28jYL7uViDQImmOHwHInrjGuD8C
         xzQ6YrYaf9+hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C5184036D; Thu, 26 May 2022 12:07:41 -0300 (-03)
Date:   Thu, 26 May 2022 12:07:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: [FYI PATCH 1/1] perf build: Stop using __weak bpf_map_create() to
 handle older libbpf versions
Message-ID: <Yo+XvQNKL4K5khl2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm carrying this one in my perf/core branch to fix the build with latest torvalds/master.

- Arnaldo

----

By adding a feature test for bpf_map_create() and providing a fallback if
it isn't present in older versions of libbpf.

This also fixes the build with torvalds/master at this point:

  $ git log --oneline -5 torvalds/master
  babf0bb978e3c9fc (torvalds/master) Merge tag 'xfs-5.19-for-linus' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
  e375780b631a5fc2 Merge tag 'fsnotify_for_v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
  8b728edc5be16179 Merge tag 'fs_for_v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
  3f306ea2e18568f6 Merge tag 'dma-mapping-5.19-2022-05-25' of git://git.infradead.org/users/hch/dma-mapping
  fbe86daca0ba878b Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
  $

Coping with:

  $ git log --oneline -2 d16495a982324f75
  d16495a982324f75 libbpf: remove bpf_create_map*() APIs
  e2371b1632b1c61c libbpf: start 1.0 development cycle
  $

As the __weak function fails to build as it calls the now removed
bpf_create_map() API.

Testing:

  $ rpm -q libbpf-devel
  libbpf-devel-0.4.0-2.fc35.x86_64
  $
  $ make -C tools/perf BUILD_BPF_SKEL=1 LIBBPF_DYNAMIC=1 O=/tmp/build/perf install-bin
  $ cat /tmp/build/perf/feature/test-libbpf-bpf_map_create.make.output
  test-libbpf-bpf_map_create.c: In function ‘main’:
  test-libbpf-bpf_map_create.c:6:16: error: implicit declaration of function ‘bpf_map_create’; did you mean ‘bpf_map_freeze’? [-Werror=implicit-function-declaration]
      6 |         return bpf_map_create(0 /* map_type */, NULL /* map_name */, 0, /* key_size */,
        |                ^~~~~~~~~~~~~~
        |                bpf_map_freeze
  test-libbpf-bpf_map_create.c:6:87: error: expected expression before ‘,’ token
      6 |         return bpf_map_create(0 /* map_type */, NULL /* map_name */, 0, /* key_size */,
        |                                                                                       ^
  cc1: all warnings being treated as errors
  $
  $ objdump -dS /tmp/build/perf/perf | grep '<bpf_map_create>:' -A20
  000000000058b290 <bpf_map_create>:
  {
    58b290:	55                   	push   %rbp
    58b291:	48 89 e5             	mov    %rsp,%rbp
    58b294:	48 83 ec 10          	sub    $0x10,%rsp
    58b298:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    58b29f:	00 00
    58b2a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    58b2a5:	31 c0                	xor    %eax,%eax
  	return bpf_create_map(map_type, key_size, value_size, max_entries, 0);
    58b2a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    58b2ab:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
    58b2b2:	00 00
    58b2b4:	75 10                	jne    58b2c6 <bpf_map_create+0x36>
  }
    58b2b6:	c9                   	leave
    58b2b7:	89 d6                	mov    %edx,%esi
    58b2b9:	89 ca                	mov    %ecx,%edx
    58b2bb:	44 89 c1             	mov    %r8d,%ecx
  	return bpf_create_map(map_type, key_size, value_size, max_entries, 0);
    58b2be:	45 31 c0             	xor    %r8d,%r8d
  $

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/linux-perf-users/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                     | 1 +
 tools/build/feature/Makefile                     | 4 ++++
 tools/build/feature/test-libbpf-bpf_map_create.c | 8 ++++++++
 tools/perf/Makefile.config                       | 5 +++++
 tools/perf/util/bpf_counter.c                    | 6 +++++-
 5 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 34cf2bff72ca20e5..888a0421d43b9606 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -102,6 +102,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libbpf-bpf_prog_load           \
          libbpf-bpf_object__next_program \
          libbpf-bpf_object__next_map    \
+         libbpf-bpf_create_map		\
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 5b31a6d063d731c2..7c2a17e23c30aca0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -59,6 +59,7 @@ FILES=                                          \
          test-libbpf.bin                        \
          test-libbpf-btf__load_from_kernel_by_id.bin	\
          test-libbpf-bpf_prog_load.bin          \
+         test-libbpf-bpf_map_create.bin		\
          test-libbpf-bpf_object__next_program.bin \
          test-libbpf-bpf_object__next_map.bin   \
          test-libbpf-btf__raw_data.bin          \
@@ -298,6 +299,9 @@ $(OUTPUT)test-libbpf-btf__load_from_kernel_by_id.bin:
 $(OUTPUT)test-libbpf-bpf_prog_load.bin:
 	$(BUILD) -lbpf
 
+$(OUTPUT)test-libbpf-bpf_map_create.bin:
+	$(BUILD) -lbpf
+
 $(OUTPUT)test-libbpf-bpf_object__next_program.bin:
 	$(BUILD) -lbpf
 
diff --git a/tools/build/feature/test-libbpf-bpf_map_create.c b/tools/build/feature/test-libbpf-bpf_map_create.c
new file mode 100644
index 0000000000000000..b9f550e332c8fdab
--- /dev/null
+++ b/tools/build/feature/test-libbpf-bpf_map_create.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/bpf.h>
+
+int main(void)
+{
+	return bpf_map_create(0 /* map_type */, NULL /* map_name */, 0, /* key_size */,
+			      0 /* value_size */, 0 /* max_entries */, NULL /* opts */);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c27fd00865c593b4..73e0762092feba30 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -589,6 +589,10 @@ ifndef NO_LIBELF
           ifeq ($(feature-libbpf-btf__raw_data), 1)
             CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
           endif
+          $(call feature_check,libbpf-bpf_map_create)
+          ifeq ($(feature-libbpf-bpf_map_create), 1)
+            CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
+          endif
         else
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
@@ -598,6 +602,7 @@ ifndef NO_LIBELF
         CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
         CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
         CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
+        CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
       endif
     endif
 
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index d4931f54e1dd38ea..ef1c15e4aeba5ed4 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -312,7 +312,10 @@ static bool bperf_attr_map_compatible(int attr_map_fd)
 		(map_info.value_size == sizeof(struct perf_event_attr_map_entry));
 }
 
-int __weak
+#ifndef HAVE_LIBBPF_BPF_MAP_CREATE
+LIBBPF_API int bpf_create_map(enum bpf_map_type map_type, int key_size,
+                              int value_size, int max_entries, __u32 map_flags);
+int
 bpf_map_create(enum bpf_map_type map_type,
 	       const char *map_name __maybe_unused,
 	       __u32 key_size,
@@ -325,6 +328,7 @@ bpf_map_create(enum bpf_map_type map_type,
 	return bpf_create_map(map_type, key_size, value_size, max_entries, 0);
 #pragma GCC diagnostic pop
 }
+#endif
 
 static int bperf_lock_attr_map(struct target *target)
 {
-- 
2.35.1

