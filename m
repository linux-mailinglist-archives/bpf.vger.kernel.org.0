Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9360605B
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTMh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJTMhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBD275DE
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t4so14785282wmj.5
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztgNoAY9JwrDyrrl7KRIcTiS50vpaEWtiAVvSexKhbQ=;
        b=wgGF22Qvm5v2glnTw6D1VaBgWTsz6jCW2W5WMS9yEuNViadbWgeJ8yrPx8xXr8+Sv9
         eTJwHBkkNb/dSzeAsfODo85hXqjskduTCEUedwOU+ttmOHEnnJen6kxOdWYLn4IHo21E
         aSwYsiCU804zFhHvGjG4ImW0vTWMrE6O4hX/pKLkKGlj2ec8cvms89uoSDLUTj8HiSpZ
         J3bOf69L8b7YkFaE9730r3t/iwswXMG9GfR8n7zIHNPsTNPy68/9kvNEQB/vRbg165bo
         48We4qnzz81zsfh3PiOvZau0SarwySIcGA/d2P7Zk7fpZdlgPGH476GJre5YX/U3SJQ6
         GGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztgNoAY9JwrDyrrl7KRIcTiS50vpaEWtiAVvSexKhbQ=;
        b=ToRHUTuDyU8eTgBVLvUgabHEsryHnJsIJxYgd8sPXyvibrXmJXhZbAoReS0yUsoF2e
         RVgD7jnD5hzXEGMW0/+9cULISS3quH8EETjJLuTzGpE2NPZb7aeyFuqCZMfpUVz+S1xm
         HwnmWJKUOIlPUs3n92W1daISApwRKvenk1prf48Qs7MhaBRE3d41WVRebdsWAinFRa/B
         3Neec7MWYv5QTj5aJju68rYvzMGu9CehiNj0nTOrvN+/4ZOg90YoJGTiUIqc+8Lzf3Hv
         VPu5ZQtvuAAIXrcxsBkp+mWhEBPkJ/CGiQlCp6yHcu6VuOnFhMY8TUjG/71xL0O4dDs5
         dyhw==
X-Gm-Message-State: ACrzQf2d+cfc3+kWdUyzdXYG0GZyLxArCjaYuYb3QVShuSOZORRovXa1
        UfDckxKnUhAUQEySMUXBUb9xIQ==
X-Google-Smtp-Source: AMsMyM7RlNXEK4iHileA1BsODjtfwZgZDbtoF33aMRODQIGDtgj9t5tTod7jI3CVvXTDHQyDa44gKQ==
X-Received: by 2002:a05:600c:1e8b:b0:3c6:f6e5:c41d with SMTP id be11-20020a05600c1e8b00b003c6f6e5c41dmr14929732wmb.12.1666269440468;
        Thu, 20 Oct 2022 05:37:20 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:20 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v3 2/8] bpftool: Remove asserts from JIT disassembler
Date:   Thu, 20 Oct 2022 13:36:58 +0100
Message-Id: <20221020123704.91203-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020123704.91203-1-quentin@isovalent.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The JIT disassembler in bpftool is the only components (with the JSON
writer) using asserts to check the return values of functions. But it
does not do so in a consistent way, and diasm_print_insn() returns no
value, although sometimes the operation failed.

Remove the asserts, and instead check the return values, print messages
on errors, and propagate the error to the caller from prog.c.

Remove the inclusion of assert.h from jit_disasm.c, and also from map.c
where it is unused.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/jit_disasm.c | 51 +++++++++++++++++++++++-----------
 tools/bpf/bpftool/main.h       | 25 +++++++++--------
 tools/bpf/bpftool/map.c        |  1 -
 tools/bpf/bpftool/prog.c       | 15 ++++++----
 4 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 71cb258ab0ee..723a9b799a0c 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -18,7 +18,6 @@
 #include <stdarg.h>
 #include <stdint.h>
 #include <stdlib.h>
-#include <assert.h>
 #include <unistd.h>
 #include <string.h>
 #include <bfd.h>
@@ -31,14 +30,18 @@
 #include "json_writer.h"
 #include "main.h"
 
-static void get_exec_path(char *tpath, size_t size)
+static int get_exec_path(char *tpath, size_t size)
 {
 	const char *path = "/proc/self/exe";
 	ssize_t len;
 
 	len = readlink(path, tpath, size - 1);
-	assert(len > 0);
+	if (len <= 0)
+		return -1;
+
 	tpath[len] = 0;
+
+	return 0;
 }
 
 static int oper_count;
@@ -99,30 +102,39 @@ static int fprintf_json_styled(void *out,
 	return r;
 }
 
-void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
-		       const char *arch, const char *disassembler_options,
-		       const struct btf *btf,
-		       const struct bpf_prog_linfo *prog_linfo,
-		       __u64 func_ksym, unsigned int func_idx,
-		       bool linum)
+int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
+		      const char *arch, const char *disassembler_options,
+		      const struct btf *btf,
+		      const struct bpf_prog_linfo *prog_linfo,
+		      __u64 func_ksym, unsigned int func_idx,
+		      bool linum)
 {
 	const struct bpf_line_info *linfo = NULL;
 	disassembler_ftype disassemble;
+	int count, i, pc = 0, err = -1;
 	struct disassemble_info info;
 	unsigned int nr_skip = 0;
-	int count, i, pc = 0;
 	char tpath[PATH_MAX];
 	bfd *bfdf;
 
 	if (!len)
-		return;
+		return -1;
 
 	memset(tpath, 0, sizeof(tpath));
-	get_exec_path(tpath, sizeof(tpath));
+	if (get_exec_path(tpath, sizeof(tpath))) {
+		p_err("failed to create disasembler (get_exec_path)");
+		return -1;
+	}
 
 	bfdf = bfd_openr(tpath, NULL);
-	assert(bfdf);
-	assert(bfd_check_format(bfdf, bfd_object));
+	if (!bfdf) {
+		p_err("failed to create disassembler (bfd_openr)");
+		return -1;
+	}
+	if (!bfd_check_format(bfdf, bfd_object)) {
+		p_err("failed to create disassembler (bfd_check_format)");
+		goto exit_close;
+	}
 
 	if (json_output)
 		init_disassemble_info_compat(&info, stdout,
@@ -141,7 +153,7 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			bfdf->arch_info = inf;
 		} else {
 			p_err("No libbfd support for %s", arch);
-			return;
+			goto exit_close;
 		}
 	}
 
@@ -162,7 +174,10 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 #else
 	disassemble = disassembler(bfdf);
 #endif
-	assert(disassemble);
+	if (!disassemble) {
+		p_err("failed to create disassembler");
+		goto exit_close;
+	}
 
 	if (json_output)
 		jsonw_start_array(json_wtr);
@@ -226,7 +241,11 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
+	err = 0;
+
+exit_close:
 	bfd_close(bfdf);
+	return err;
 }
 
 int disasm_init(void)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 5e5060c2ac04..c9e171082cf6 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -173,22 +173,23 @@ int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
 
 struct bpf_prog_linfo;
 #ifdef HAVE_LIBBFD_SUPPORT
-void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
-		       const char *arch, const char *disassembler_options,
-		       const struct btf *btf,
-		       const struct bpf_prog_linfo *prog_linfo,
-		       __u64 func_ksym, unsigned int func_idx,
-		       bool linum);
+int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
+		      const char *arch, const char *disassembler_options,
+		      const struct btf *btf,
+		      const struct bpf_prog_linfo *prog_linfo,
+		      __u64 func_ksym, unsigned int func_idx,
+		      bool linum);
 int disasm_init(void);
 #else
 static inline
-void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
-		       const char *arch, const char *disassembler_options,
-		       const struct btf *btf,
-		       const struct bpf_prog_linfo *prog_linfo,
-		       __u64 func_ksym, unsigned int func_idx,
-		       bool linum)
+int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
+		      const char *arch, const char *disassembler_options,
+		      const struct btf *btf,
+		      const struct bpf_prog_linfo *prog_linfo,
+		      __u64 func_ksym, unsigned int func_idx,
+		      bool linum)
 {
+	return 0;
 }
 static inline int disasm_init(void)
 {
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9a6ca9f31133..3087ced658ad 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (C) 2017-2018 Netronome Systems, Inc. */
 
-#include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/err.h>
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a31ae9f0c307..345dca656a34 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -822,10 +822,11 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 					printf("%s:\n", sym_name);
 				}
 
-				disasm_print_insn(img, lens[i], opcodes,
-						  name, disasm_opt, btf,
-						  prog_linfo, ksyms[i], i,
-						  linum);
+				if (disasm_print_insn(img, lens[i], opcodes,
+						      name, disasm_opt, btf,
+						      prog_linfo, ksyms[i], i,
+						      linum))
+					goto exit_free;
 
 				img += lens[i];
 
@@ -838,8 +839,10 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 			if (json_output)
 				jsonw_end_array(json_wtr);
 		} else {
-			disasm_print_insn(buf, member_len, opcodes, name,
-					  disasm_opt, btf, NULL, 0, 0, false);
+			if (disasm_print_insn(buf, member_len, opcodes, name,
+					      disasm_opt, btf, NULL, 0, 0,
+					      false))
+				goto exit_free;
 		}
 	} else if (visual) {
 		if (json_output)
-- 
2.34.1

