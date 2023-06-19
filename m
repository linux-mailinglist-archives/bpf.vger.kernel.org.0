Return-Path: <bpf+bounces-2846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A336B735627
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5AC1C209FA
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0B110795;
	Mon, 19 Jun 2023 11:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A408C06
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 11:50:22 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12BC9;
	Mon, 19 Jun 2023 04:50:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-54fac329a71so1525323a12.1;
        Mon, 19 Jun 2023 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687175421; x=1689767421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UQHgCYMSUpJKwkxCT8Gz4j2ViWlUBZ9rAr/225IOUc=;
        b=X+AH26S0pESoQoY7mV4YObJoPGMhOo8TcwKST2E0D9DFgnIavPYPHGKxCZAXlbQmXU
         K9boDCLJgoN4H/Uv18k3G49LAVlBNV9jEHH//Kj6Dz3bHqOhX1VUZfiW33/Ueq6MLJto
         9yW/b70xsdaL4Rr+8o0Uil1vmKLab7Zi+WtIpSmIdW4aEHHckBTdbb7e1ksjwPwcXa1v
         DcH2onF1Z++xeEkBJ/UWAu32uGzldJ9zwkVmPAYee5K9xqF9A+dDofmwD8MF+lfEVkMx
         WlGjVheE3NocsSCOWxYWRkcu0DcxJF5+HNRd2UnNK+AMvQd08HQM3/onEJtZhYY9MFOc
         7kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175421; x=1689767421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UQHgCYMSUpJKwkxCT8Gz4j2ViWlUBZ9rAr/225IOUc=;
        b=FgZgIyQyfFT7ftudhq0hrL/Z0D8lsXxBkaoUcFLjvop0b14g+R6517jfi/RzMTt6z9
         8zMdtcXZLKds8ZW8QxeneawFI2wI9gJHUKE1iLx/fQATuE6ETmEKFdqujkmIh5wXPfHM
         szEYZNR9oU0BYRZZ5+gYPUAI/GKxS/uANhQM077XZYhBk74XvLxLMYP1V8eXSZteN2lv
         k6HyGsgHGUTM4DZbMpGOZHHcMFZ2PyNAHk/bTqNOkKfqpijGFRxTqnLOpDjZz+guz9ZN
         t+qSP3aB/zAYwkGT1Tr1yKKfGX/EbfKOpZ2YK33uiFFxiaG4y51PEut38hsw0kXz7VVS
         4mKA==
X-Gm-Message-State: AC+VfDxOlXjoZ3N/Nxsth1OxEWon1k2y/U3GWV9tRCzfJ/0QSy1GsVS9
	cBaAi1CEjyvXxHhFhfYcVcI=
X-Google-Smtp-Source: ACHHUZ4eZxfFOfZ5KE3j/CQj2Lr8ga8x20Xxa2lrQQ2aI4tqX47awC9xIimK7gLx0W2mv+kcSw3V8g==
X-Received: by 2002:a17:902:da92:b0:1b4:ff2a:24e3 with SMTP id j18-20020a170902da9200b001b4ff2a24e3mr4843469plx.45.1687175421011;
        Mon, 19 Jun 2023 04:50:21 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.86])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b001aaf370b1c7sm20287882plt.278.2023.06.19.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:50:20 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	alexei.starovoitov@gmail.com
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
	benbjiang@tencent.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v6 1/3] bpf, x86: save/restore regs with BPF_DW size
Date: Mon, 19 Jun 2023 19:49:45 +0800
Message-Id: <20230619114947.1543848-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619114947.1543848-1-imagedong@tencent.com>
References: <20230619114947.1543848-1-imagedong@tencent.com>
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

As we already reserve 8 byte in the stack for each reg, it is ok to
store/restore the regs in BPF_DW size. This will make the code in
save_regs()/restore_regs() simpler.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v6:
- adjust the commit log
---
 arch/x86/net/bpf_jit_comp.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..a407fbbffecd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1860,57 +1860,34 @@ st:			if (is_imm8(insn->off))
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 		      int stack_size)
 {
-	int i, j, arg_size;
-	bool next_same_struct = false;
+	int i;
 
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		arg_size = m->arg_size[j];
-		if (arg_size > 8) {
-			arg_size = 8;
-			next_same_struct = !next_same_struct;
-		}
-
-		emit_stx(prog, bytes_to_bpf_size(arg_size),
-			 BPF_REG_FP,
+	for (i = 0; i < min(nr_regs, 6); i++)
+		emit_stx(prog, BPF_DW, BPF_REG_FP,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 -(stack_size - i * 8));
-
-		j = next_same_struct ? j : j + 1;
-	}
 }
 
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			 int stack_size)
 {
-	int i, j, arg_size;
-	bool next_same_struct = false;
+	int i;
 
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
-		/* The arg_size is at most 16 bytes, enforced by the verifier. */
-		arg_size = m->arg_size[j];
-		if (arg_size > 8) {
-			arg_size = 8;
-			next_same_struct = !next_same_struct;
-		}
-
-		emit_ldx(prog, bytes_to_bpf_size(arg_size),
+	for (i = 0; i < min(nr_regs, 6); i++)
+		emit_ldx(prog, BPF_DW,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
 			 -(stack_size - i * 8));
-
-		j = next_same_struct ? j : j + 1;
-	}
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-- 
2.40.1


