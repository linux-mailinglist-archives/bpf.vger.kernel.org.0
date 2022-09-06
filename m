Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB52B5AEAC6
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiIFNor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiIFNnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:43:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0095BD11B
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:38:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b17so2158008wrq.3
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6qwqarUq+IF4oE3LW/CY/4dfi8ZMWfExmdWZvKwSC6g=;
        b=8FCgFTK32v1WTPP/ZjhSaI0yMo3HrRxWsvK/b+Y4cFer25utbtQ0iezgkBwgswazOw
         uCDXYAAT/6I2iNhs1kUKuvANdElmazW+Mt+slWHzYQx4/tW35C0u1gT3YfvWXRJH7S4W
         wqj3ijJLjId9zfekc8L6+4xQW8oDY3A+ZwPyR3b0n3+3o2ly4WQof5zBe5aaiGNdiI95
         fiA9DLk3Md1JZgeKd5ccC18GnohGJYRi78iQYU57zJguCU3o9DfwVo4ZG6Vl2pQ4/nfq
         i8yoUVqqwQAf90RniO2J+TeratKjAE7QarBOwljE7Tjp6B37vyQi8VvLkwc1dIwtMNbA
         bIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6qwqarUq+IF4oE3LW/CY/4dfi8ZMWfExmdWZvKwSC6g=;
        b=3Nr9Am2Kkk1tkG/T/pxpcgcHCmDJ26kmf9Y1YkTVwfpPZjpIAaH+9XJlGw41W/OFBH
         VXeX5Bbz3nYola2BFVG1WmhLJlrVGoxFpJDY6d3x7PcmIWul12F3b9hfUO+xY2Xb6nXD
         k8uxCd+Ocuj1917WVu/zZBUgRogHPc+hwdarrrbfCuGWpHsrrExMJ8f+kWL4vI24VzY+
         GQ+u3IowEhbMjRmOrMvzgoI8w9szItOysxZhOk5E/kgVOlmescB+mAtJDu6weElEVr00
         EHAxuEJwnqRbjAUJe8mVaADfjXpt2pZzhxhjRqMnQVowMpW2ub1ocQhgrSHZ9b/MhcEr
         ahEA==
X-Gm-Message-State: ACgBeo1HA630okjsKMlV0xCIoxEn6KomNR4ZP1OW7mApGDK3sOXByH8I
        2KSl6gQdK+DJdU3X4TuimSjv/g==
X-Google-Smtp-Source: AA6agR5TSgJCP7AT7fzKD67C6ybaySqBqSKDWPMbmLPY+1FKJdxiZJ5KPphf0ZJscHOXChb1NuVRww==
X-Received: by 2002:adf:fe06:0:b0:228:db6f:41ae with SMTP id n6-20020adffe06000000b00228db6f41aemr1560775wrr.577.1662471393507;
        Tue, 06 Sep 2022 06:36:33 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:33 -0700 (PDT)
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
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/7] bpftool: Remove asserts from JIT disassembler
Date:   Tue,  6 Sep 2022 14:36:08 +0100
Message-Id: <20220906133613.54928-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906133613.54928-1-quentin@isovalent.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
MIME-Version: 1.0
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

