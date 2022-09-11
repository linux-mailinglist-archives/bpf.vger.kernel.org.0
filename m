Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367F5B5117
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiIKUPJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIKUPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:15:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7B193EA
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bj14so12252094wrb.12
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KdmLbSWGqiOLb/m/H92/rXiw90GcfXHeM589SNO2Oa0=;
        b=WYEznBBRZ82Fnv9eYDT1gLDxE3qNgbVEgeJLn8Lc/xei1Km9vGLqM4R7JYn7dVolga
         NLYjSRc6B+HKxBHJ2Far8ucX08GOFrhDO4k15hyhb3V7cTiWBfO0R4YSAaLhLGpB497M
         xItxlIYmklJkY3uv64w6cqpYpzfe2oT2FAg1K8xjUar/3JYoH0/MjVYkq1LViQv14eul
         3lHWo0mrAZO8BGy+T5INpkJaiLnfcDTL56GIC7EqBwSnOdwnaxaAs6FKHGmDIeLAUF+S
         GN/XXouCdi2vPc1xmUH0wkzK4gMCD6zOO8AzOSfoGC/thPQoo5BHRdXMDpEW+WROAcrS
         8CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KdmLbSWGqiOLb/m/H92/rXiw90GcfXHeM589SNO2Oa0=;
        b=XyduMtc7pipY/ZA3FTtfMPporh5VahwsX2U+ut90Zg9R5XanyYiQt/ShFNpeStaQkX
         GLzn9BRP1Fr6wDH9+qRhZTtv5P7lKu1J395PNbYTp9wJcrtK6jJ9cs/2yyRSMc7uWV1z
         LnImZKszogofoCZvYfDbJGAhrJugKh+oRkIl6gFBDJGiNAi9PqTvkwynaPvxMxasUNMt
         ZZK/OVET99vfUgzd0QO2X7hd39M+C2c8bLdUFfLh4uy10abzAAVqWtWNt0jN3I26ALUF
         ClxbwDaDtxgn/SYI8tf5fwQLtgfoTO2q+smRq6zeBLFs6P6fWcvfnDYhC/0E+EpZFo7+
         gwlQ==
X-Gm-Message-State: ACgBeo3Kmwu4OljxrYR3bJ42PTrVnAjst+xI51AVhQkCtXuHI1WVT2Gn
        BIHDaLm3IrjC2kbgNwD0/sFuaw==
X-Google-Smtp-Source: AA6agR5zFo61+YyP0TuVZfx6eoQopKPYkTGQYVRf+1htSOwdOzqNZ5xDTY11ikg69CvCmmS83V3iHQ==
X-Received: by 2002:a5d:6802:0:b0:228:d6e9:6dd8 with SMTP id w2-20020a5d6802000000b00228d6e96dd8mr14170538wru.710.1662927302400;
        Sun, 11 Sep 2022 13:15:02 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:14:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/8] bpftool: Remove asserts from JIT disassembler
Date:   Sun, 11 Sep 2022 21:14:45 +0100
Message-Id: <20220911201451.12368-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911201451.12368-1-quentin@isovalent.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 38b6bc9c26c3..a0e573589811 100644
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

