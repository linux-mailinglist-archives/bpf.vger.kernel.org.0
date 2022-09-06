Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA45AEA7F
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiIFNov (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiIFNnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:43:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248C7EFC3
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:37:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h1so6886081wmd.3
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NDTfb7fWPG0FEls+QEBCRAYe3U9PF/PWZyZgEiTKI9c=;
        b=SaLrk7pIT+xosPWKc7hMHwwe/oAjK8VGKaa4VUv1Q9f3jmpsBaJDuzzYra4Jfppxrr
         jkFc+vrPy+4IDgdQI3xKuljAgLxzmk397UQwSsp210h+dOhI4IDZFT5jP9IHh726KQqB
         9CX1JLA0al8GDkGjDDfF9gqoky0mgh616DR9fF8b4CkncmgR5JGtGEzy7jayTUnoWOOO
         THOl9inDWUMBMFriYq9ky9NNDAWBckWECMuMy8IrqTlIvUUDOVWbIz81dxaizrmJ4ptt
         iE+X/G5ri1upyYFybRWC2BqffurR12qZo2ck2F2DMoZ6t9tLwWekqYgCtalKaX6EnQNC
         82wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NDTfb7fWPG0FEls+QEBCRAYe3U9PF/PWZyZgEiTKI9c=;
        b=tyl+Jz0OXrixDtlbH3Mysf581BRwy/Ocx/c3rNfIQPRHj4ve6okrTlUukitXWQCI5F
         VeA5tRB3dL1sRV5yQDzOqYWUjo1WAzcbFQUEnOCYzhkBMplztXPm+YvKjISkPgo1qT6R
         VfPXAdMKtVQqjG1GGkSfKEe+hAFguTmwREMnQBKTrvumHPhSRBrtjH52QPJpc9M+a9KW
         qAzBApPIfgZwxnSxfLSINE/CFXc8wQhyU7MAyXYje3hUaBvB9pRwe9tPkYfAwug0Hj3Q
         vXQPZ2o7/EEAyvvtif9QMLn9gEA8sna+QYpjpy1kqjr3TpEU6uOT77nuLIsFfUp55R4A
         VOFA==
X-Gm-Message-State: ACgBeo3figoEQfvx9SBMOsokP+iw/twuqV9dVHj2rTaj/s0kmErid/+S
        6ZWgZf1npcuk6mIvVyf5S+Jdrw==
X-Google-Smtp-Source: AA6agR6mu6X0rNoV3zH8ekCF+3OD4E9105uTUVbtCNHwpwtq8aufJCViGrQAjr4aSJEwffu4eyq8zQ==
X-Received: by 2002:a7b:c848:0:b0:3a5:41f6:4d37 with SMTP id c8-20020a7bc848000000b003a541f64d37mr14357019wml.23.1662471396426;
        Tue, 06 Sep 2022 06:36:36 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:35 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/7] bpftool: Refactor disassembler for JIT-ed programs
Date:   Tue,  6 Sep 2022 14:36:11 +0100
Message-Id: <20220906133613.54928-6-quentin@isovalent.com>
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

Refactor disasm_print_insn() to extract the code specific to libbfd and
move it to dedicated functions. There is no functional change. This is
in preparation for supporting an alternative library for disassembling
the instructions.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/jit_disasm.c | 133 ++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 45 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 723a9b799a0c..e31ad3950fd6 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -30,6 +30,14 @@
 #include "json_writer.h"
 #include "main.h"
 
+static int oper_count;
+
+typedef struct {
+	struct disassemble_info *info;
+	disassembler_ftype disassemble;
+	bfd *bfdf;
+} disasm_ctx_t;
+
 static int get_exec_path(char *tpath, size_t size)
 {
 	const char *path = "/proc/self/exe";
@@ -44,7 +52,6 @@ static int get_exec_path(char *tpath, size_t size)
 	return 0;
 }
 
-static int oper_count;
 static int printf_json(void *out, const char *fmt, va_list ap)
 {
 	char *s;
@@ -102,46 +109,44 @@ static int fprintf_json_styled(void *out,
 	return r;
 }
 
-int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
-		      const char *arch, const char *disassembler_options,
-		      const struct btf *btf,
-		      const struct bpf_prog_linfo *prog_linfo,
-		      __u64 func_ksym, unsigned int func_idx,
-		      bool linum)
+static int init_context(disasm_ctx_t *ctx, const char *arch,
+			const char *disassembler_options,
+			unsigned char *image, ssize_t len)
 {
-	const struct bpf_line_info *linfo = NULL;
-	disassembler_ftype disassemble;
-	int count, i, pc = 0, err = -1;
-	struct disassemble_info info;
-	unsigned int nr_skip = 0;
+	struct disassemble_info *info;
 	char tpath[PATH_MAX];
 	bfd *bfdf;
 
-	if (!len)
-		return -1;
-
 	memset(tpath, 0, sizeof(tpath));
 	if (get_exec_path(tpath, sizeof(tpath))) {
 		p_err("failed to create disasembler (get_exec_path)");
 		return -1;
 	}
 
-	bfdf = bfd_openr(tpath, NULL);
-	if (!bfdf) {
+	ctx->bfdf = bfd_openr(tpath, NULL);
+	if (!ctx->bfdf) {
 		p_err("failed to create disassembler (bfd_openr)");
 		return -1;
 	}
-	if (!bfd_check_format(bfdf, bfd_object)) {
+	if (!bfd_check_format(ctx->bfdf, bfd_object)) {
 		p_err("failed to create disassembler (bfd_check_format)");
-		goto exit_close;
+		goto err_close;
 	}
+	bfdf = ctx->bfdf;
+
+	ctx->info = malloc(sizeof(struct disassemble_info));
+	if (!ctx->info) {
+		p_err("mem alloc failed");
+		goto err_close;
+	}
+	info = ctx->info;
 
 	if (json_output)
-		init_disassemble_info_compat(&info, stdout,
+		init_disassemble_info_compat(info, stdout,
 					     (fprintf_ftype) fprintf_json,
 					     fprintf_json_styled);
 	else
-		init_disassemble_info_compat(&info, stdout,
+		init_disassemble_info_compat(info, stdout,
 					     (fprintf_ftype) fprintf,
 					     fprintf_styled);
 
@@ -153,31 +158,76 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			bfdf->arch_info = inf;
 		} else {
 			p_err("No libbfd support for %s", arch);
-			goto exit_close;
+			goto err_free;
 		}
 	}
 
-	info.arch = bfd_get_arch(bfdf);
-	info.mach = bfd_get_mach(bfdf);
+	info->arch = bfd_get_arch(bfdf);
+	info->mach = bfd_get_mach(bfdf);
 	if (disassembler_options)
-		info.disassembler_options = disassembler_options;
-	info.buffer = image;
-	info.buffer_length = len;
+		info->disassembler_options = disassembler_options;
+	info->buffer = image;
+	info->buffer_length = len;
 
-	disassemble_init_for_target(&info);
+	disassemble_init_for_target(info);
 
 #ifdef DISASM_FOUR_ARGS_SIGNATURE
-	disassemble = disassembler(info.arch,
-				   bfd_big_endian(bfdf),
-				   info.mach,
-				   bfdf);
+	ctx->disassemble = disassembler(info->arch,
+					bfd_big_endian(bfdf),
+					info->mach,
+					bfdf);
 #else
-	disassemble = disassembler(bfdf);
+	ctx->disassemble = disassembler(bfdf);
 #endif
-	if (!disassemble) {
+	if (!ctx->disassemble) {
 		p_err("failed to create disassembler");
-		goto exit_close;
+		goto err_free;
 	}
+	return 0;
+
+err_free:
+	free(info);
+err_close:
+	bfd_close(ctx->bfdf);
+	return -1;
+}
+
+static void destroy_context(disasm_ctx_t *ctx)
+{
+	free(ctx->info);
+	bfd_close(ctx->bfdf);
+}
+
+static int
+disassemble_insn(disasm_ctx_t *ctx, __maybe_unused unsigned char *image,
+		 __maybe_unused ssize_t len, int pc)
+{
+	return ctx->disassemble(pc, ctx->info);
+}
+
+int disasm_init(void)
+{
+	bfd_init();
+	return 0;
+}
+
+int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
+		      const char *arch, const char *disassembler_options,
+		      const struct btf *btf,
+		      const struct bpf_prog_linfo *prog_linfo,
+		      __u64 func_ksym, unsigned int func_idx,
+		      bool linum)
+{
+	const struct bpf_line_info *linfo = NULL;
+	unsigned int nr_skip = 0;
+	int count, i, pc = 0;
+	disasm_ctx_t ctx;
+
+	if (!len)
+		return -1;
+
+	if (init_context(&ctx, arch, disassembler_options, image, len))
+		return -1;
 
 	if (json_output)
 		jsonw_start_array(json_wtr);
@@ -205,7 +255,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			printf("%4x:\t", pc);
 		}
 
-		count = disassemble(pc, &info);
+		count = disassemble_insn(&ctx, image, len, pc);
+
 		if (json_output) {
 			/* Operand array, was started in fprintf_json. Before
 			 * that, make sure we have a _null_ value if no operand
@@ -241,15 +292,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
-	err = 0;
+	destroy_context(&ctx);
 
-exit_close:
-	bfd_close(bfdf);
-	return err;
-}
-
-int disasm_init(void)
-{
-	bfd_init();
 	return 0;
 }
-- 
2.34.1

