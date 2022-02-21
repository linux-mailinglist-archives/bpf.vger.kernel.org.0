Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0581E4BE40A
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358421AbiBUM5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 07:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358408AbiBUM5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 07:57:05 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A21D0CE
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 04:56:41 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id f19so31760148qvb.6
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 04:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+gJDZiXv/VI+XvMkOdkPWmqi1RQ71lkSx0ZGjpdOV8=;
        b=NqfK9Z+eee3NxzE1oOQy2QDkpId5Tokr7DEg5c33+mQj3B3JdZdyY2xUaAyvhunEu9
         G68MQ0S87X8q/SIbkVUgJZ0RRSWrMOfmlNnvTl7tSOmR/4IRS+2vbYktL+wluvveYJ71
         yHGQnk4LrqY5cNQ+EpL0W3wABicWeoUjmnn6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+gJDZiXv/VI+XvMkOdkPWmqi1RQ71lkSx0ZGjpdOV8=;
        b=sXwDWx7D+Ph4M+VLIgAqaAdRdt0+aWGjXK0hlv8998LjjBwFbUWOQ8mHJIi4P2tm58
         kQw7nzlwRz+mGwb6/RXKlPVctKFuMqhNZ6YenC/u7eglgTuksq0S8h2zZC1TNf7FLjbW
         9mYTAqhr/oDrKPygmuEI058TXaHZ9TyE+mIRieGtuiS2TjsrBP5rFKyzuhAKTZgG5Rf2
         BlhiVlK6kJQ6acV5KEoghKOdOE3m338AIwbRx83pM0G8PJrOuGvx6txnvEF9cvnaiBxs
         m/xoCRaM7dF4PKFX5jQlUo/4xkPB0qGGdM/juQs+TdwwKC9jP1d4hG+2/qCbDODu6bQ3
         JWGg==
X-Gm-Message-State: AOAM532Unb7sroGjrBoQDYa1OQPIXRt4J8g4sZRH8KBfrkHVtyR+pSiZ
        jVHi279oaf7FV4n/yEUNoQpNUA==
X-Google-Smtp-Source: ABdhPJzONQGrJVP/t62VyG/Of/RXj1/9yNGnGMjCpv2+lkUqamjSsgjaSrvB+kFhibbqmiilaYBuAA==
X-Received: by 2002:ac8:7f81:0:b0:2dd:a370:c595 with SMTP id z1-20020ac87f81000000b002dda370c595mr12977543qtj.402.1645448200324;
        Mon, 21 Feb 2022 04:56:40 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id d17sm27343436qkn.84.2022.02.21.04.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:56:39 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2] bpftool: Remove usage of reallocarray()
Date:   Mon, 21 Feb 2022 07:56:17 -0500
Message-Id: <20220221125617.39610-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit fixes a compilation error on systems with glibc < 2.26 [0]:

```
In file included from main.h:14:0,
                 from gen.c:24:
linux/tools/include/tools/libc_compat.h:11:21: error: attempt to use poisoned "reallocarray"
 static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
```

This happens because gen.c pulls <bpf/libbpf_internal.h>, and then
<tools/libc_compat.h> (through main.h). When
COMPAT_NEED_REALLOCARRAY is set, libc_compat.h defines reallocarray()
which libbpf_internal.h poisons with a GCC pragma.

This commit reuses libbpf_reallocarray() implemented in commit
029258d7b228 ("libbpf: Remove any use of reallocarray() in libbpf").

v1 -> v2:
- reuse libbpf_reallocarray() instead of reimplementing it

Reported-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>

[0]: https://lore.kernel.org/bpf/3bf2bd49-9f2d-a2df-5536-bc0dde70a83b@isovalent.com/
---
 tools/bpf/bpftool/Makefile        | 6 +-----
 tools/bpf/bpftool/main.h          | 2 +-
 tools/bpf/bpftool/prog.c          | 7 ++++---
 tools/bpf/bpftool/xlated_dumper.c | 5 +++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index a137db96bd56..ba647aede0d6 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,7 +93,7 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args reallocarray zlib libcap \
+FEATURE_TESTS = libbfd disassembler-four-args zlib libcap \
 	clang-bpf-co-re
 FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
 	clang-bpf-co-re
@@ -118,10 +118,6 @@ ifeq ($(feature-disassembler-four-args), 1)
 CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
 
-ifeq ($(feature-reallocarray), 0)
-CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
-endif
-
 LIBS = $(LIBBPF) -lelf -lz
 LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
 ifeq ($(feature-libcap), 1)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0c3840596b5a..0468e5b24bd4 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -8,10 +8,10 @@
 #undef GCC_VERSION
 #include <stdbool.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <linux/bpf.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <tools/libc_compat.h>
 
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 92a6f679ef7d..8a52eed19fa2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -26,6 +26,7 @@
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_internal.h>
 #include <bpf/skel_internal.h>
 
 #include "cfg.h"
@@ -1558,9 +1559,9 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			if (fd < 0)
 				goto err_free_reuse_maps;
 
-			new_map_replace = reallocarray(map_replace,
-						       old_map_fds + 1,
-						       sizeof(*map_replace));
+			new_map_replace = libbpf_reallocarray(map_replace,
+							      old_map_fds + 1,
+							      sizeof(*map_replace));
 			if (!new_map_replace) {
 				p_err("mem alloc failed");
 				goto err_free_reuse_maps;
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index f1f32e21d5cd..2d9cd6a7b3c8 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_internal.h>
 
 #include "disasm.h"
 #include "json_writer.h"
@@ -32,8 +33,8 @@ void kernel_syms_load(struct dump_data *dd)
 		return;
 
 	while (fgets(buff, sizeof(buff), fp)) {
-		tmp = reallocarray(dd->sym_mapping, dd->sym_count + 1,
-				   sizeof(*dd->sym_mapping));
+		tmp = libbpf_reallocarray(dd->sym_mapping, dd->sym_count + 1,
+					  sizeof(*dd->sym_mapping));
 		if (!tmp) {
 out:
 			free(dd->sym_mapping);
-- 
2.25.1

