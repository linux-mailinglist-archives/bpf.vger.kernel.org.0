Return-Path: <bpf+bounces-2475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0172D77C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 04:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513B81C20C0A
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B531C02;
	Tue, 13 Jun 2023 02:53:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D857F
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 02:53:11 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA62EE;
	Mon, 12 Jun 2023 19:53:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-25bf9dadfe8so1010598a91.2;
        Mon, 12 Jun 2023 19:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686624790; x=1689216790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhfGhyxz9mxcYU3gu8XgR3Vlbsf30YJwKDPoiQbXWnM=;
        b=sL1tTQz4lw+fvdYDYr1RQKRj7JRGn5jb4frHHtc2pkSggplruhRo8YEK+qA/XMsPPI
         MRFbBf2ef9fZKHk8OuFR6CkvtO+2bbCIx0Qm4kQjIKfoabyrhvGkKKU0lXlBiiQhPnjw
         huwd7Xp2gzmw1RmcTWyoh1NQIvoW7jnpOJGEq+MS0J9FI3VzXZ89Nd2iu8NGikDsIhDC
         RNT9aH774C57KoYrvPNZUFW67Jcdr0/9Od+3uycBFDumFrUFq+uMVz58Ij8zWhUxkoTf
         iWg4df8Jkm2zvm4CCOA9jswDcrmzoEJDNkziKuWmmlCdnggYJMgjB51TSKIAzF0p6jxt
         pUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686624790; x=1689216790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhfGhyxz9mxcYU3gu8XgR3Vlbsf30YJwKDPoiQbXWnM=;
        b=ecBEIcy8pNj0HUcqjFMuefZdo0BQSWtWJM6X3Vkk/qghCHDyXafsJqDy7yGJd1paf4
         gVuOXHxKYli9AsNaLG5sdC94OwXDygqJGlN2W2EH9BjIXNLBxt8Gx2nsT6W62RdSX47E
         Acl70qzxEFJsHvwRFH/hFwADtLQgiDd4zqjJc0DVfc0V9cagMz0fClFKgb1Sl54qZSv1
         ZiXEbjFXMMdzpQpkiJAr6RiGWGyY4dUNG1qpM09vxk90ioyTbcIfxT+Wq4u940KuJC6J
         HbMe2h82shUc0LpV0WkVKbzIXUMpH0NpeC7Yefea/a2dHEoJruizaJ2HmgxsNG+ldkO6
         7z7A==
X-Gm-Message-State: AC+VfDxhpQJLlx+m8o/R/68T0vcRmbzg0Wh56HULqdrYCbbZTRlrwknT
	sKueXW7VHyUQ23gTuDJWmvs=
X-Google-Smtp-Source: ACHHUZ4Q49fgtFu0mLg2pIRWhivEkTAPXLUVuTZ/wzxXWIUnmlQe2OfYhNAy9c9Bns//94X8IsjuEQ==
X-Received: by 2002:a17:90b:4d83:b0:253:30e1:7d68 with SMTP id oj3-20020a17090b4d8300b0025330e17d68mr9890409pjb.0.1686624789918;
        Mon, 12 Jun 2023 19:53:09 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.85])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b00543e9e17207sm8240207pgv.30.2023.06.12.19.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 19:53:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/3] bpf, x86: clean garbage values when store args from regs into stack
Date: Tue, 13 Jun 2023 10:52:24 +0800
Message-Id: <20230613025226.3167956-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613025226.3167956-1-imagedong@tencent.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
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


