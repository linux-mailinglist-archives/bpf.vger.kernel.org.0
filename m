Return-Path: <bpf+bounces-4914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF275172C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4501B1C21237
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16717525F;
	Thu, 13 Jul 2023 04:08:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C95258
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:08:50 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746112101;
	Wed, 12 Jul 2023 21:08:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b8a462e0b0so1670545ad.3;
        Wed, 12 Jul 2023 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689221329; x=1691813329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9OF5rBDxNaq2DXKTbLZbdXHNFefw4Fd6mHFek0g5ew=;
        b=gQDPPIRke8xv7MGRPOrZSHURDZKqnZkO53gb9cH+7Y/jvQOts6gi8i65cr0dU1chx2
         AYpY2ZNKtS0gG7MYcIjJp0NKRJK5ZA8XrjWRf6ldMBd3Fw4/YPIP5S/Um2FtKEVhI4RY
         tGJHmFgq3QvmNpzggV57mkKSW6tBmBOT01BcHRO+0UH7yykdQVoSEQuaUZW4Z0Kr/w23
         s9LmSPcotzRWfERA2/qbJ63F9oaMsgS/RsZSzjr98XC7mHc02xDjSVXKZ1SiN7LJ/pq6
         FMQQ/dtdvdmZTwsRfvNdYFecH8km7Sbap+GL+ijbQZAjtQhog+fB95atq3eiBMdbVage
         B24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221329; x=1691813329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9OF5rBDxNaq2DXKTbLZbdXHNFefw4Fd6mHFek0g5ew=;
        b=kq1nmmo4Db/ZEHVVrkrkx2Uh+CY9QrF8x72mREqRE8qupAtn4xwUzhXXAKj0LHdAJU
         mlravSaygDKahokaneKmzBK2Gb3elS3AYh1ADlW/t4ZVVT0DmZE/lbu59IpAuSvFIxph
         b3Ft32Ww+VQplRcZQBXYUYoh/pdHloM143gGylqR656Q9/edpzO88cCJKzHvsMjkX9mr
         9K9FhYUE0lKOyABwGBuREAXff/L7ABIH5zyfWVN9tjASKjbHq4B+2FP5polKB0h7P2FK
         D57orYCX7Gi+g65caZGyYV7ir23N3VmoljI4T8ar/+1099mwg4s57incJy8MrigH/BDs
         0WRQ==
X-Gm-Message-State: ABy/qLYAdZeazfw5e8azC4q2up78CM7ihTulvE0/IXhVI0sRbtwEf9ts
	gjUUnqiLSdwAVrbF/UgbLQU=
X-Google-Smtp-Source: APBJJlHFvs0MjJxSYwj7luS3cl4wrUlaftbIjKcO6a1HpxozZWfPkoSuLx816zm263ERbgsik8reqQ==
X-Received: by 2002:a17:902:db08:b0:1b9:d3a2:f596 with SMTP id m8-20020a170902db0800b001b9d3a2f596mr253219plx.52.1689221328884;
        Wed, 12 Jul 2023 21:08:48 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.100])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001bb04755212sm483217plg.228.2023.07.12.21.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:08:48 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	daniel@iogearbox.net,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	dsahern@kernel.org,
	jolsa@kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v10 1/3] bpf, x86: save/restore regs with BPF_DW size
Date: Thu, 13 Jul 2023 12:07:36 +0800
Message-Id: <20230713040738.1789742-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713040738.1789742-1-imagedong@tencent.com>
References: <20230713040738.1789742-1-imagedong@tencent.com>
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
index 438adb695daa..fcbd3b7123a4 100644
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


