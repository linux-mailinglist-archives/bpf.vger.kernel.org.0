Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42973376F40
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEHDuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEHDuL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7BEC061761
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z16so8811102pga.1
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7EEMW5kBmPD/yBDhPPmRdicSHwy7w6bLkWjtExKKHU=;
        b=GxK00X/dQoVxZ67b00rEw8t0aH7Fe0sjS5/QBMPRIx59kW+CNPqvV/9aKlEZj3BkfN
         HVpLFXnRHerwBNlZTjhdQ2yjm0iTkfb0/f8kObbT7se+jse8im0c/m/Pcq8cLTIzsuCF
         g4KpXrE2RU18c5O5OF93zoDBUnse6PIgWbQAdW65kzkUZ2HNvtKw8aMxXNGREKowvhf6
         R5q18Hz2231TvLstF1eLSKNYiWMACIpGaUC0Gog5sSq8LLvzgyKwGvkrlF4Tl8R/8+23
         DmucZiZ60Xdlo6dApW0S7juxueZYoyvPLEp28dKpoe50lLeojwMWjVsMdI89Tag9FAMv
         G+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7EEMW5kBmPD/yBDhPPmRdicSHwy7w6bLkWjtExKKHU=;
        b=BAQf9e/V7nXPQGQwxukgWtDxrgmWb2wR0z2i5BQJTNQ7yvchFQF4XXsAdpi7pCXcJ/
         +tXirYr+OZpV0Escc9XfM+OWaOw9b5opnp8+DJ/hcpxIXFHPXF+S4GMl37nvut8P74LI
         Wo9guXLkuH9LrbJ38ztlpgbd7gKlTt8JgdCBbNsGkVVZPwQRcgiW+M+DbYr9l595Nvrg
         v7gCVZWYNwmfE0d2CRMcpxVUvvPsc0Tcsah+g0g3jzT7uSWiO4AZxG9r4DpdLlQ59PuH
         h88ZmLk1t2bC1/kwtXX1X89H1SyarqOVGu3Z8/oPlsCwcAm0dQtcy29b26nXdcCE+Uzi
         reEg==
X-Gm-Message-State: AOAM532xzy8xKvb6IgAbUGK/31R0aPSpqeI8hbOoV+G6DZTP5eq3ymP+
        XpYoytkh/++NNrpSWLwWFuo=
X-Google-Smtp-Source: ABdhPJzU39Sgj+PmfFx8zP0xZ+Ddk0ts901LiUDuXScsew1kmFQTLnvoV2+lTpaVAwlhxrAFOit2tQ==
X-Received: by 2002:a05:6a00:781:b029:27c:d3f6:d019 with SMTP id g1-20020a056a000781b029027cd3f6d019mr13715208pfu.42.1620445750455;
        Fri, 07 May 2021 20:49:10 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:09 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 16/22] libbpf: Cleanup temp FDs when intermediate sys_bpf fails.
Date:   Fri,  7 May 2021 20:48:31 -0700
Message-Id: <20210508034837.64585-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Fix loader program to close temporary FDs when intermediate
sys_bpf command fails.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  1 +
 tools/lib/bpf/gen_loader.c       | 38 ++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index f42a55efd559..da2c026a3f31 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -15,6 +15,7 @@ struct bpf_gen {
 	void *data_cur;
 	void *insn_start;
 	void *insn_cur;
+	size_t cleanup_label;
 	__u32 nr_progs;
 	__u32 nr_maps;
 	int log_level;
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 585c672cc53e..b1709421ba90 100644
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
+	for (i = 0; i < stack_sz; i+= 4) {
+		bpf_gen__emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
+		bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
+		bpf_gen__emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
+	}
+	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
+	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
+	bpf_gen__emit(gen, BPF_EXIT_INSN());
 }
 
 static int bpf_gen__add_data(struct bpf_gen *gen, const void *data, __u32 size)
@@ -179,10 +207,12 @@ static void bpf_gen__emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int at
 
 static void bpf_gen__emit_check_err(struct bpf_gen *gen)
 {
-	bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 2));
-	bpf_gen__emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
-	/* TODO: close intermediate FDs in case of error */
-	bpf_gen__emit(gen, BPF_EXIT_INSN());
+	/* R7 contains result of last sys_bpf command.
+	 * if (R7 < 0) goto cleanup;
+	 */
+	bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 1));
+	bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
+				       -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1));
 }
 
 /* reg1 and reg2 should not be R1 - R5. They can be R0, R6 - R10 */
-- 
2.30.2

