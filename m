Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE80B380138
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhENAiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A67C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k15so10058601pgb.10
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A82fnCpRlRpNCPZoeOc9LjoJQoPv+rtdjruUrM2K2YQ=;
        b=DW4bXQ3ms8AEI/l5onaTJR/t78M/18ROXVIFAkjMKAjFYp9QJyou7rODebY3498LVj
         0x9MkUldKWqfpMPbQGiVFEqRS6C+IwUiR3a57KuHTx6ucrH7wfBE+moUX7teO2ueVp5L
         GMCBp6Qh63zcN0PbZS75q5z2efsOi20smEeaSJsQpC418pmMXZg8zXSwITpejwaS7PpW
         scsLmxWtTPbWMDsbKw6/5FXH0veRpusqwR3hG+JsGKfUS2U+QA0PE61iw6g76qEPvRpo
         Lp/G9ziqz4rOUNOh1zwhEwHLfrNctbCqn3vbxLZxFSs45/c8jSNUV4RMDRBhDxW7wnXx
         iflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A82fnCpRlRpNCPZoeOc9LjoJQoPv+rtdjruUrM2K2YQ=;
        b=tZM/oUkLho2e8qVEopiK+w+xtYOqOE1KZvscHhqdiRJy48IVuU7dgF9261QQ4ttmfZ
         CyfcDkqFhZVIrn/wCbCe5s1dAxb7AEegBaLenB9PUs500OhKj1z2IKm8jwzz0lwH8HKP
         Kmp0Rj2iuH5vB97ZEVYKjlsvldbaxsa2zqEDivmnjcsq7z1L2sU99hNJhnlWoDyI/fhH
         7Cl/28SuGxiMy7lqUHsX3R/HflmmoTkuAO8jNO+ksydBYfkrw228fa2sK1hkHHCO9ZqK
         h7pgXPGkJz//6YPrYlgfZkPaQtJfTpTdqLRA6Litj5qBPJB/yJ9CCs1zcjeUMyzwWPNz
         296A==
X-Gm-Message-State: AOAM531+kY6EtLTb0GlL8WGr0LgCspT2Ji1YaoscMROb6YhPVlA/19Lz
        7Bggypv3QM41plcN3e7fow0=
X-Google-Smtp-Source: ABdhPJxNdANeXDToSYhm4QALaXs2HUlGt1AAY25BUzVnSMBNV32VbaL07EOFMyoKeSFfiF3gpPhREw==
X-Received: by 2002:a63:b102:: with SMTP id r2mr22486071pgf.254.1620952614331;
        Thu, 13 May 2021 17:36:54 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 15/21] libbpf: Cleanup temp FDs when intermediate sys_bpf fails.
Date:   Thu, 13 May 2021 17:36:17 -0700
Message-Id: <20210514003623.28033-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
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
index 0fc54b1ca311..8df718a6b142 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -101,8 +101,36 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level)
 {
+	size_t stack_sz = sizeof(struct loader_stack);
+	int i;
+
 	gen->log_level = log_level;
+	/* save ctx pointer into R6 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
+
+	/* bzero stack */
+	emit(gen, BPF_MOV64_REG(BPF_REG_1, BPF_REG_10));
+	emit(gen, BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -stack_sz));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, stack_sz));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
+
+	/* jump over cleanup code */
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
+			      /* size of cleanup code below */
+			      (stack_sz / 4) * 3 + 2));
+
+	/* remember the label where all error branches will jump to */
+	gen->cleanup_label = gen->insn_cur - gen->insn_start;
+	/* emit cleanup code: close all temp FDs */
+	for (i = 0; i < stack_sz; i += 4) {
+		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
+		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
+		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
+	}
+	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
+	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	emit(gen, BPF_EXIT_INSN());
 }
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
@@ -187,12 +215,24 @@ static void emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int attr_size)
 	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
 }
 
+static bool is_simm16(__s64 value)
+{
+	return value == (__s64)(__s16)value;
+}
+
 static void emit_check_err(struct bpf_gen *gen)
 {
-	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 2));
-	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
-	/* TODO: close intermediate FDs in case of error */
-	emit(gen, BPF_EXIT_INSN());
+	__s64 off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
+
+	/* R7 contains result of last sys_bpf command.
+	 * if (R7 < 0) goto cleanup;
+	 */
+	if (is_simm16(off)) {
+		emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, off));
+	} else {
+		gen->error = -ERANGE;
+		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
+	}
 }
 
 /* reg1 and reg2 should not be R1 - R5. They can be R0, R6 - R10 */
-- 
2.30.2

