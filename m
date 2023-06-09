Return-Path: <bpf+bounces-2220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6172960F
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF501C20A52
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674014A8D;
	Fri,  9 Jun 2023 09:57:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4C13AE9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:57:25 +0000 (UTC)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2CB7AB6;
	Fri,  9 Jun 2023 02:57:11 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 006d021491bc7-559409cc490so1019905eaf.3;
        Fri, 09 Jun 2023 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304630; x=1688896630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odT6+rgQqp77JJ8LV+JNNotDPvzRm1aU2ce2tTNslKg=;
        b=nGtuEwHEkJJ/K9Cxr9t+VLarD+KhlwiVqpwzlWVzTAtiotn2+8vMZSaYKUGQ3Bwyx7
         Y9HXa/bGqMSFbWAznCM18RPQNpuYASmEx+jUjWwQOLRDY2SiUMQnWMhTHSPghgjzO2s/
         ftrAIH2TEv84ZfMI+/6QdFdbyT4X5USxzOtilJnJxQ3AOVGLjqLSddP4Gf2PY71jR6Br
         FDc8jCjbW97PHyUWGX2WO4TDf8H9QK0yiT5a8sshAjMn7X6rn8ek0wH/huLwDCfGi7Aj
         SSk8iFI/YMrWibMVjD/0ke9RRhkt/V9oVk1PwOtARSNR85znARMLxESZtYJCXt/JUEuX
         slRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304630; x=1688896630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odT6+rgQqp77JJ8LV+JNNotDPvzRm1aU2ce2tTNslKg=;
        b=PdLK/2asvBp30kivTrnNsr7qJa84uL9mUEg9W5yV6kIGObZAVC88eHOFXTRJy/bNTY
         QyI/WYPra+56NIcy6aG1MRpj0aUxZwLet5ig9VgdaJ7kO2yv8vxFgyS4PD/jMBK/xfSN
         nv2bYnWtV/9C1ch4zJVqp9TylS4N3DIlS9gZTfXM7oBhCN4MDLZs54WFdMMXgdAxi7bg
         ua8x3PgFHWSMBxszLGULysjneOWF/xAyT5pbJNnDEpbYv12l3PyydfJGgZBUvv99YAto
         bNfh0UOG6zLZG8Pk9j1w2IEVhz4LA8QNOrbljmpl81xd1ScZDr4VBvheKIWJ0tsf78od
         pFNg==
X-Gm-Message-State: AC+VfDyV+E6KqrCfiR3lWbJVe0WXzMJ1HDpIieOWNcx1W0B1oHYg90hz
	CGoA3XVkNGhGg8/azO7wf/k=
X-Google-Smtp-Source: ACHHUZ7L7Afe4yMt/dqD3g6NNiT/1f3jVS/4vSDqVpfulu8Hq0p1NopPUsk7YHP0OtYHPqmsuU1edw==
X-Received: by 2002:a05:6358:4f82:b0:129:f7ad:20f1 with SMTP id cg2-20020a0563584f8200b00129f7ad20f1mr794812rwb.23.1686304630163;
        Fri, 09 Jun 2023 02:57:10 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.114])
        by smtp.gmail.com with ESMTPSA id 26-20020a63175a000000b0053f3797fc4asm2603369pgx.0.2023.06.09.02.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:57:09 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 2/3] bpf, x86: clean garbage value in the stack of trampoline
Date: Fri,  9 Jun 2023 17:56:52 +0800
Message-Id: <20230609095653.1406173-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609095653.1406173-1-imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

There are garbage values in upper bytes when we store the arguments
into stack in save_regs() if the size of the argument less then 8.

As we already reserve 8 byte for the arguments in regs and stack,
it is ok to store/restore the regs in BPF_DW size. Then, the garbage
values in upper bytes will be cleaned.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v4:
- clean grabage value when argument count is 7
---
 arch/x86/net/bpf_jit_comp.c | 45 ++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a767e13c8c85..f6f51a5d14db 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1857,6 +1857,28 @@ st:			if (is_imm8(insn->off))
 	return proglen;
 }
 
+static inline void clean_garbage(u8 **pprog, int nr_regs, int stack_size,
+				 int arg_size)
+{
+	u8 *prog;
+
+	/* clean potential garbage values in upper 32-bit. 'stack_size'
+	 * here is the offset of the 7th argument on-stack.
+	 */
+	if (nr_regs == 7 && arg_size <= 4) {
+		int off = -(stack_size - 4);
+
+		prog = *pprog;
+		/* mov DWORD PTR [rbp + off], 0 */
+		if (!is_imm8(off))
+			EMIT2_off32(0xC7, 0x85, off);
+		else
+			EMIT3(0xC7, 0x45, off);
+		EMIT(0, 4);
+		*pprog = prog;
+	}
+}
+
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 		      int stack_size)
 {
@@ -1878,8 +1900,7 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 
 		if (i <= 5) {
 			/* copy function arguments from regs into stack */
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
+			emit_stx(prog, BPF_DW, BPF_REG_FP,
 				 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 				 -(stack_size - i * 8));
 		} else {
@@ -1893,17 +1914,16 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			 *   8(return addr of the caller)
 			 * which means: rbp + 24
 			 */
-			emit_ldx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_0, BPF_REG_FP,
+			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 				 (i - 6) * 8 + 0x18);
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
-				 BPF_REG_0,
+			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 				 -(stack_size - i * 8));
 		}
 
 		j = next_same_struct ? j : j + 1;
 	}
+
+	clean_garbage(prog, nr_regs, stack_size - 6 * 8, arg_size);
 }
 
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
@@ -1925,7 +1945,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			next_same_struct = !next_same_struct;
 		}
 
-		emit_ldx(prog, bytes_to_bpf_size(arg_size),
+		emit_ldx(prog, BPF_DW,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
 			 -(stack_size - i * 8));
@@ -1956,17 +1976,16 @@ static void prepare_origin_stack(const struct btf_func_model *m, u8 **prog,
 		}
 
 		if (i > 5) {
-			emit_ldx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_0, BPF_REG_FP,
+			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 				 (i - 6) * 8 + 0x18);
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
-				 BPF_REG_0,
+			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 				 -(stack_size - (i - 6) * 8));
 		}
 
 		j = next_same_struct ? j : j + 1;
 	}
+
+	clean_garbage(prog, nr_regs, stack_size, arg_size);
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-- 
2.40.1


