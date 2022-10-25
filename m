Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6260CFE3
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiJYPDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiJYPDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F0D1B7F14
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h9so10483156wrt.0
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA9eacgGZiA4SnV5uyL526OIKeHyinf6gpH6AIvYlko=;
        b=c+XI2AGNsBI91Dq/ptTtzRJmcxOs5DiaB451uOmcBz1PAMHDZd/HKGRmpcmQVFHz3R
         gvLzGSnNKeUaqPz5I3FJeUqx5rKTxl4b00MfNUXYt1wG9uXswipOeLVTks2QWVSlaMKT
         xJlx0NROArI1lPAtyz7TAzeGQtYtZmsDEfVPSaxpgzmo29KmAzWhRIfEUV11k8KFWWi6
         yt1QNjH/bPGNFT5Q8F7jz2EIopgoBIR+91gahYh8K6GTSqt12sotsbNsrQedbIwT/C8M
         wkMLk1jaL3+YRJVaVAz9XjgxOOtxXz+kocu/vRv7z1Nsc8pg3APWZlfikSwCeH0EejWU
         tGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA9eacgGZiA4SnV5uyL526OIKeHyinf6gpH6AIvYlko=;
        b=jhh+Ndc2Dary3nuXVBzJmtlQbidQc8gPVejvT4tUYz4etfVFDQOY7w2R2U3L98FUSn
         vE1ydp0d58F7bWJZ+egWiKVUzOfUFtT8vktADX/mCuWo84dkpATUDZyI0wNZSSDlHIO7
         hLMzPYmBjob/jnkoO9PfaAVPybBfr1/PnYCQ+uyZlkqmYRNqV/mWNiRt4gwf6dQsQVBp
         beLt/jZdwLGLct0jf/mDqFKs04yW5IfkMMF0qCouWto8gTklZycoVanN8BUYrsXDqxjP
         F4TzNGtsz7o29EtQjS6BsVxDjtH3Yr5VrsQQhkQfMu4Nacvq9hz0gcRhL38BA18E+Vjg
         aQDQ==
X-Gm-Message-State: ACrzQf2aOOLuMEAmCSVqmiHkkXC8DaLAnoiu1JBpsTIlE8bn/CgK52Qq
        3uu0z0rUCifKprJq//VkizuNIw==
X-Google-Smtp-Source: AMsMyM6itCkyD29r7lO30+tYYGQUm57Ug0q2t1kvKvWBznULxB5cbpHZ8aO5n6vXsnUYvDj+ddPvHA==
X-Received: by 2002:a05:6000:1e03:b0:22e:3bf2:4685 with SMTP id bj3-20020a0560001e0300b0022e3bf24685mr25580064wrb.82.1666710223550;
        Tue, 25 Oct 2022 08:03:43 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/8] bpftool: Refactor disassembler for JIT-ed programs
Date:   Tue, 25 Oct 2022 16:03:26 +0100
Message-Id: <20221025150329.97371-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
References: <20221025150329.97371-1-quentin@isovalent.com>
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

Refactor disasm_print_insn() to extract the code specific to libbfd and
move it to dedicated functions. There is no functional change. This is
in preparation for supporting an alternative library for disassembling
the instructions.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
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

