Return-Path: <bpf+bounces-62265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA0AF73B8
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D711E4E4604
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C52EB5D1;
	Thu,  3 Jul 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDuslK0u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D172EAD06;
	Thu,  3 Jul 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545067; cv=none; b=H2LDFNIwUB8ZcbeFP7LbsIZMD0NLDptgUgI+5Ho5xHzfMSKKJPFldz1klCt0tyOW+iFCAH2az3Zv+WuOhBUDgTWU1x6FG90R4SDybuSrkLnadVODllmLq7qyk82ciF+CZMJ1zoruq7EEBQzw7ZgzZZ178Bob4EbtaSyKH5qHRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545067; c=relaxed/simple;
	bh=pTP3A3udzpqP7idQ6yfAvXRvXy8d4QhQ8MKaOULTNUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=py3ce+yVtF/dh1NXUxNlWFxgmVtk5Ep9b6GLGTh78VwVlzhpbpIvTjWzUoAwFby6wUR6hCp+rLuJ6Mv+rX6xpxG4wa1a3tEr6uW5vV7r/KrccD0PwPLCzdG9BXPXfpHH00zg/xcWk4We8B/s99Xk7CGVzIZQgDY8BOxDw5yKtZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDuslK0u; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-748e378ba4fso10384170b3a.1;
        Thu, 03 Jul 2025 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545065; x=1752149865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTJ5AcJp6NNlMzGq4x270cqfrcd7ussd7QF3anZ6zjo=;
        b=iDuslK0uutEU934ij4u9s3QrHsWsJvJWpkPEQGmjuLmsfGh/IFH27lm04Ncl8LIx70
         x06gkAoJWxFBVohE/LYHzfvg6RLqN2jRqTvnqG4rac2YvcD2FRH8ubRBmIFXOS0HEbsA
         Sv6UUFg+uJrXTqgP8Q4yIlKUdMOMSpcaI9kFmd+FBLVD3zt9MCdVj1m/OqpoHsWJEqfV
         wJWMo/0G6MUc/Lp8E+I33Ufj4YKbM8MBwlLPf6Hp+cO6eim87SLb8SeCNKtGT+Q9HxBI
         2BkNU6CYoVsTxKxCO94OgoBbOAUvGfsGo30hfy+w3IOszA/aHF5RV8ZNlbeGGbfh5PsI
         TQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545065; x=1752149865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTJ5AcJp6NNlMzGq4x270cqfrcd7ussd7QF3anZ6zjo=;
        b=EWOaQXugIGt1QcD++/0eMu/TuNHv52LCMlbjaTAxl5MqOfmk4j4xIZLhwN/LIneXWp
         GSbLy8uGItIHS6MPkyyIvBfJheh0/6s8YHnrmhVj8oaHR29ksewc9VgHstXNTGT4Toa0
         vZ6jEwxCywuIunBwPivnrX14DGXGaClE0txDsNMxgXLYKpW9/Su3OeQNo8MwEX1i6++f
         wH+75qGl93s5mC8LoBPzqjAtHunjQRSMMSMOJWXb6R6TrNIvwdtTc9feoXDtAuk9YlJM
         lotCSqAHWDTkkhw3B60GHJc64Qg/2O5Iyd7XmzXYvd0YY+q0yEbcZxCrEQHqww6m1Ihc
         pHnw==
X-Forwarded-Encrypted: i=1; AJvYcCUXrTimG3uB9oHBK7uppw+YawKrXRowE2tT6E5Iig0mGGkvWvE9wX8LeMflz7OHaqaXY71VXenfb3XB0ao=@vger.kernel.org, AJvYcCXw/ZUIjlM/1D4MpXoBvZMQLB1sID9IPzOe8223GIg4HqPB8SNnVmffkiAvSKJ3jHDG3QvIkLFU@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDtCbH9cAV/7Uot7o7wsvTznO7Mv2IVDHrX2XEcCTLceRm/0a
	9sz9pC/bVUHvou/8ZNfiXovpadIiUc4+BmXGW8GazCUmShbQgG3olEI+
X-Gm-Gg: ASbGncuYyL5fRt7PrJpD8yhHWn9ckDV3RmJNISCBduoaCU4+izgqLOBE03ROb4770/f
	gkx39EIJbCxQbbhJsxAOFv2YuNn7tM9Nwv+Ep+ndvtJwDKHQTo3+h8v5N3+9/2TxUcQHDSJbHxA
	/CEXom1tQ+vAP1MYHVvpTB20D4ZMkGSyOMSpqi+aBCRf3WXQ9XNZ5/U/uOWVcdha+zYzze3oXHO
	0VIlQcXMjYd/BzxfaAVoa1EU67EOsdA+10rwexYBKYW6Nl4Dh18vlOZ1HrRMtMC9titzWlNyMhE
	vswksQlt5jkFUKJEnLK/TukHEVObi6EDpjEI3/R5nqVgyxiN5PRI7G7dsH7Vp6WUYR1uiVsCeMm
	04lxewxhrhNCvVw==
X-Google-Smtp-Source: AGHT+IE5J9rg2JiGcm8zZgpSCqAB1SulBnM4AJphFwGhTQ8H4Bu3le9DoyEpJT0xTDGVeumPLIFxOw==
X-Received: by 2002:a05:6a00:10c8:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-74b5104baebmr7621967b3a.11.1751545065403;
        Thu, 03 Jul 2025 05:17:45 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:45 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 10/18] x86,bpf: factor out arch_bpf_get_regs_nr
Date: Thu,  3 Jul 2025 20:15:13 +0800
Message-Id: <20250703121521.1874196-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the function arch_bpf_get_regs_nr() to get the regs count that used
by the function args.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 22 +++++++++++++++-------
 include/linux/bpf.h         |  1 +
 kernel/bpf/verifier.c       |  5 +++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8d2fc436a748..7795917efc41 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3001,6 +3001,19 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+int arch_bpf_get_regs_nr(const struct btf_func_model *m)
+{
+	int nr_regs = m->nr_args;
+
+	/* extra registers for struct arguments */
+	for (int i = 0; i < m->nr_args; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
+	}
+
+	return nr_regs;
+}
+
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
 	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
@@ -3071,7 +3084,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 struct bpf_tramp_links *tlinks,
 					 void *func_addr)
 {
-	int i, ret, nr_regs = m->nr_args, stack_size = 0;
+	int i, ret, nr_regs, stack_size = 0;
 	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
@@ -3089,15 +3102,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
-	/* extra registers for struct arguments */
-	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
-	}
-
 	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
 	 * are passed through regs, the remains are through stack.
 	 */
+	nr_regs = arch_bpf_get_regs_nr(m);
 	if (nr_regs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bb3ab1aa3a9d..da5951b0335b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1220,6 +1220,7 @@ void arch_free_bpf_trampoline(void *image, unsigned int size);
 int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr);
+int arch_bpf_get_regs_nr(const struct btf_func_model *m);
 
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6311be5a63a..86a64d843465 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23274,6 +23274,11 @@ static int do_check_main(struct bpf_verifier_env *env)
 }
 
 
+int __weak arch_bpf_get_regs_nr(const struct btf_func_model *m)
+{
+	return -ENODEV;
+}
+
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	int i;
-- 
2.39.5


