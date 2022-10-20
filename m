Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABF60605D
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJTMh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJTMh0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75E3495C8
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so34205466wrr.3
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA9eacgGZiA4SnV5uyL526OIKeHyinf6gpH6AIvYlko=;
        b=enyEii4aDYL369wDE9Z1eEQbOutcxsKsSj+TwCbSAPRuIzBTg/aGwic3MBFgVAFlg3
         soLTkCekCEEsD2+3+GO81JgYqULtF0yUd9i6zhsyzGV6zXHywnyXyKgrxhfupQGsDXkT
         rox+lbqsM6CxWZXFuKYH56ySiK/dTrPvl3MgI8zV7eX97fkHEgpSlt+D7yx/YY3+6eRv
         9F9tQpSt/oY59aSt09bd3BbtvY+AZWtm96LpDkkc3Hnuj+FQFx9eH1sTijJxccf5jd0Z
         f5BhBvLE/r1tdH3ayfmNqdSA009o5rloapx5EOJa2Y5tkWHvT9dYIJLwz8zrYzqsTjHW
         7fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA9eacgGZiA4SnV5uyL526OIKeHyinf6gpH6AIvYlko=;
        b=kqOqvMUk3tJeZwjUkscEUvD2k3OQTlb5rV05VcyhVjiAZAkkQ04G1JQ4iNH20q4p+u
         G783DZ7ahws3n8V11Uem+M0HDDodaDz52cmVR6HXwIAEs5D26aW6IOSe4a5YKVE0hc2L
         Uth21qm2R0vf7C+nY80e27AvX85Xn160Istl96wig90eubCOeD036AC1FDRDmHl8ey9k
         w9S2ZTCd6wwo3EaQTHdq0S2IBz9rGbJpV4M0B+kYxnbzYEoVeyUDmPO0pM/G3F/JIgfw
         4kdABhtIACyrLAHHTsAx73ndf0AskKLy8+PRGwa30yxB/nCM+BSC49nZaX8Pyx3P1A1t
         QBYQ==
X-Gm-Message-State: ACrzQf0nA+TLPE2Uu5YOPV3q4VoumkuyHqTlG7FjKhrYWe8uDgXKyEhb
        JZ9SJ0fV3ywPu3eNw/I5GwzLeg==
X-Google-Smtp-Source: AMsMyM6mfzCkNnXmHmUC0LxQN9ZpXPxzViP7555v55NPqG6BBBJfTZdbMP0qnQSlPsPMNNImIVDXuA==
X-Received: by 2002:a05:6000:18ac:b0:235:6c05:1b90 with SMTP id b12-20020a05600018ac00b002356c051b90mr2736338wri.53.1666269443239;
        Thu, 20 Oct 2022 05:37:23 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/8] bpftool: Refactor disassembler for JIT-ed programs
Date:   Thu, 20 Oct 2022 13:37:01 +0100
Message-Id: <20221020123704.91203-6-quentin@isovalent.com>
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

