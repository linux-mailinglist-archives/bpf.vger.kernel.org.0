Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1437EF5A
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhELXB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346997AbhELVpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:45:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB553C08C5DB
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y32so19270143pga.11
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PVM6js/8x3mcMhIaz4/jpNKgQpvWqEVdFBIwdtNedIM=;
        b=I9lMtg1gpgSnYIB0xhcTagX1TjXYqb+uzVn+e3/VIlnJN1Cvl8quWLhhAjLxDJPsYJ
         ql/L6obdzb6SFKaMMqhI5yF705kXATJHejtV5iM+XFmMcnHGuhuG8PiVV8AQ2uHW647M
         erB3Q9Ykq8kgF/ionzzitP5N3M1Gue6vr6RbU7MjmxAlR9F00z1HUbZpyzyMB3yNOLAP
         iqStLJLER9pcN9VzynFd4P2IwJjLbCnAUrmk1t3BEi57RwmCpIqB0QPZfJxrifI8ZBzl
         Zkra/SuL0FVgnsxXkJfwG4xFlGBJ+cBiKyZz+LbzvcumezMIquLSaqH4e9Qk7XQqPb9O
         zMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PVM6js/8x3mcMhIaz4/jpNKgQpvWqEVdFBIwdtNedIM=;
        b=eFbnZDFCRwJuXaoDn5OKhsLUoDPcPXWE9syrxdnTiaKOE68ZUp6H7pkfsnCUGt5Yd3
         DB0BH4zLv/JJcuBjQQ75o+cFCbFzati7nXFIeQo92pRjT0H5my8xsnYf9dmx5V4NJs3l
         OtKpszz2Izec3uztq/s02SPmAqsoZhubsl7W08Gq8mLjp04Sm/U2zk13zwhlbkW6uosE
         gIVn+N9YS2I7b923SGEElW3CAXra+j7K99OlGJnuyw902PIBGr12o1T2Yy1gQ/AsJoMF
         sS3VSSMXBPg+T5VDAGIBAy5v8LcWaM5zegRh80TtvV/9NHlwWzJAhYj/moZ/3+0fgxpC
         Jw7A==
X-Gm-Message-State: AOAM530a2DDG0iGNFXePulaVpeNCVN+cWDRMbP8RhKDFf4dhrDN2V2IV
        oepIsgBv6FSA3Q1HY7a6NMw=
X-Google-Smtp-Source: ABdhPJxMBHqq6oZVnUMtfnCXSZQnrHLwvK2cWlzOKtC4eSYkhV07Kf9wTwZjRwmz/o57vMlL00RyFg==
X-Received: by 2002:a17:90b:188f:: with SMTP id mn15mr2273496pjb.219.1620855208484;
        Wed, 12 May 2021 14:33:28 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:27 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 15/21] libbpf: Cleanup temp FDs when intermediate sys_bpf fails.
Date:   Wed, 12 May 2021 14:32:50 -0700
Message-Id: <20210512213256.31203-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Fix loader program to close temporary FDs when intermediate
sys_bpf command fails.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  1 +
 tools/lib/bpf/gen_loader.c       | 48 +++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index f42a55efd559..615400391e57 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -15,6 +15,7 @@ struct bpf_gen {
 	void *data_cur;
 	void *insn_start;
 	void *insn_cur;
+	ssize_t cleanup_label;
 	__u32 nr_progs;
 	__u32 nr_maps;
 	int log_level;
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 585c672cc53e..bf61a046bc77 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -97,8 +97,36 @@ static void bpf_gen__emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bp
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level)
 {
+	size_t stack_sz = sizeof(struct loader_stack);
+	int i;
+
 	gen->log_level = log_level;
+	/* save ctx pointer into R6 */
 	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
+
+	/* bzero stack */
+	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_1, BPF_REG_10));
+	bpf_gen__emit(gen, BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -stack_sz));
+	bpf_gen__emit(gen, BPF_MOV64_IMM(BPF_REG_2, stack_sz));
+	bpf_gen__emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
+	bpf_gen__emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
+
+	/* jump over cleanup code */
+	bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
+				       /* size of cleanup code below */
+				       (stack_sz / 4) * 3 + 2));
+
+	/* remember the label where all error branches will jump to */
+	gen->cleanup_label = gen->insn_cur - gen->insn_start;
+	/* emit cleanup code: close all temp FDs */
+	for (i = 0; i < stack_sz; i += 4) {
+		bpf_gen__emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
+		bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
+		bpf_gen__emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
+	}
+	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
+	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	bpf_gen__emit(gen, BPF_EXIT_INSN());
 }
 
 static int bpf_gen__add_data(struct bpf_gen *gen, const void *data, __u32 size)
@@ -177,12 +205,24 @@ static void bpf_gen__emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int at
 	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
 }
 
+static bool is_simm16(__s64 value)
+{
+	return value == (__s64)(__s16)value;
+}
+
 static void bpf_gen__emit_check_err(struct bpf_gen *gen)
 {
-	bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 2));
-	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
-	/* TODO: close intermediate FDs in case of error */
-	bpf_gen__emit(gen, BPF_EXIT_INSN());
+	__s64 off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
+
+	/* R7 contains result of last sys_bpf command.
+	 * if (R7 < 0) goto cleanup;
+	 */
+	if (is_simm16(off)) {
+		bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, off));
+	} else {
+		gen->error = -ERANGE;
+		bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
+	}
 }
 
 /* reg1 and reg2 should not be R1 - R5. They can be R0, R6 - R10 */
-- 
2.30.2

