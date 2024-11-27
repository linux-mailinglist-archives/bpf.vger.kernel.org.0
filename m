Return-Path: <bpf+bounces-45739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D660E9DAD63
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96374281F75
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629220110E;
	Wed, 27 Nov 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIqWiWTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDE20309
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733502; cv=none; b=Y/EsA7iLMeJL2+Cq27O3CNpJKUEsVVm93Woj3UD5KAaCPjaqwRLTwiCp5dZOkrNIUK7D0Kuk9SOfjSlNdxBQjDcfDmuO+703LOlj8CBYBE+bd0AgBrwKr7vgh6wjLbcBVmWQhP1FLH8rgzypnDKUGgu/XHsQggLWPwRqkKkTLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733502; c=relaxed/simple;
	bh=h0LqxQ42MMPent3wsGT2YYH2dwg3a/IXfXT3SKw5gT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0jVcbvAyQlu41hfqQ70gbf0kj8NvK30dvn7EhJLb7jOe5XQ/agdFhVU4k8lzfynCuZ2JwNqkpUW6osWreAt4XJjmczGNI6MbZhMVzQW30PrZMeda4ZssHl0oJ7MP3Viy9k85U7KJpm1w4u94g1LD/812HiEkbmjnmTkyuGUw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIqWiWTJ; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3823e45339bso52953f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732733499; x=1733338299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzSfLUWRBNvo0A0RH4lHABmogu7i2Nws7BjZvmN/WVs=;
        b=WIqWiWTJc8Y8PlSpL80uHZxnqkDt+Rd1wzZps1HD6uxLd0yCCNh65lIN3+iPajYhY4
         XorjSJ2GKMe0XLCslgUZifu8P/MHdgfC4tmKMCo6AHWmGF7vQqfxPJlZoSG/Z3Xh6FEN
         DPHwQSbf+EpvOXVNp1DgmjX5m/0PeH3e8BiN2OudWFWkFGBSf6e/6Eg9+zB50migLgsX
         2s9Vlz+CvC7PIgKei0Atowt3q3gMmQ8oaYE8U7XIf2Z8wWbBw+cgqwaurvwWN0pvE/yv
         5OVWqDkUP3/FPn/g9FtP/d0Ct4UYnXbue/lA4nZw0JthP9IuE51eOvFlPUnJUB3hIkgk
         lN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733499; x=1733338299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzSfLUWRBNvo0A0RH4lHABmogu7i2Nws7BjZvmN/WVs=;
        b=bYk9fcINCUPtauob6bw24fQ1yQaFaC++WyQWZiURuHqgviMpKy4s4oXHXylkpk4IY6
         MhyUAMqjR6SP4qZ02g+VrZiEDC2dnwCDbC6LiNhLRi8r2VJlQCGpO2PaX/rDnQirLlZa
         M4HLsZL2eKkFyLCed/YiZ9/F307G5mri4YNcnHcxb87w72jSU0lHAFsH+wMO0RRox7lz
         UtW+Yrmo2cuwkkTcmdNJnNuCJ6zPBO0EXzrmz0MrIncFxplcFtOpAcPuTteXITNUQl+j
         a6BTinfWUCfUjRQq5Hhv9keNGcdGVf8rz4QFdYlIMTvYrrweCPsz2QEZXpY4fd86GfyC
         18NQ==
X-Gm-Message-State: AOJu0YxRk5FCxvgMNODA4VA2VZH/zLlgOgvnH2X7Zd8uC06PJfqS67VM
	2A8lKiXODpbjLKF+3irXMqaUOqyHxQxWuWZKuNRvFFAJqexFbctfr2cSXrJsTeA=
X-Gm-Gg: ASbGncspCoX+WhrXuIoOUsUYZzXTPjrFU2EClGXnvhjeljAXoa49vvBRTYCXy2xEfyX
	Ygl+iBvZLNiuF6yJYWj7HL39ZiXaW/KhKkytv/xDM8QT6VQlnHaFFCnPWc9jsHkqsAIqqk7yVR1
	/6Jc8pD7K5T3r5DWnJpRpYyQrnYyAE7PSiOM9KidAPemZ7216ylYq0c4ZSd0R/8DBh8GoZSID17
	21wcpnrbiyCCLhQtIwxcCB/rdVFDlWffEuDAJccfpN2515JeQbFNTIjO9DIVzOAm8yxNKXg1Dsy
X-Google-Smtp-Source: AGHT+IE3q3GkTlK5NjGckLWwlUskkDfySbJYz8W6jHAIgWLPNOlE06cTu0lCZf+ABGKnb/E67CAs1A==
X-Received: by 2002:a5d:5888:0:b0:382:4378:4652 with SMTP id ffacd0b85a97d-385c6edd47bmr3165333f8f.45.1732733498523;
        Wed, 27 Nov 2024 10:51:38 -0800 (PST)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5f59sm16858250f8f.10.2024.11.27.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:51:37 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 1/4] bpf: Don't relax STACK_INVALID to STACK_MISC when not allow_ptr_leaks
Date: Wed, 27 Nov 2024 10:51:32 -0800
Message-ID: <20241127185135.2753982-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127185135.2753982-1-memxor@gmail.com>
References: <20241127185135.2753982-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5054; h=from:subject; bh=h0LqxQ42MMPent3wsGT2YYH2dwg3a/IXfXT3SKw5gT0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR2oxyJfFnazCRwF4JiIVisRfB6Wd8z4HFB/tOrX5 XLQm6WyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dqMQAKCRBM4MiGSL8Ryvt0D/ 9HDcOX9Rdnjsa11Adus6V37AKuJql1hrAoYRCNMEfkMULzZNCKxuObcnXKfHAdnvi5JPslEebTI/Jl T5fg7LGjBzriGwJuauYgzxdE6/+GprOw0JRHC2g3cJOWRAzas87y6UBoqv3YtkgBGlU7iThol/aTi4 T+AwtusSm//6aSgFsZTafYY37CjfiEikNO8BFfUQYUmoBppq6H5XC3YLfIQ8QyDdt6Z1Teg3hj2MW/ BWhFY7Itov6+r6+ZxBRgUKBYAGtwlm73Ycd0hZ4YCNgj+Aipae3wVnAgyl++C2EsYGhSX/gREIdvow vwvx/eO/eww0SDX3l9GCItDOZdWh4hRR4tUwefv8ECw+NIuZKAEvMNbH228sLzHnPGlmdKplF1fqXt w6XzSqVi7Z0LrGIyGkp0OEhvBORjimeJDL11UoJAJ4kkUw/ESZGiOuPV3lfelXA3TgaGU2e3BRUJ2c WhGzfgtL0ntnalmZqR+dRcopRIAfSGOzaurNsTjF7P948nu5UtxqBSxedQ41JA8Z3Q8SPosIUpDl3o ZIOJqk9Oxs+u09nJ13VGlw238uLpV5QK6LJcIYkTyxAXw+XOXPE3h6Gevfkkp5dmI0ZQBQuuBjsRy7 6dlsgy/a7cTyepqcKoWzvdWUdZ4NQaDyUoApceN+etlI5c71UuF7AyUobTIQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Inside mark_stack_slot_misc, we should not upgrade STACK_INVALID to
STACK_MISC when allow_ptr_leaks is false, since invalid contents
shouldn't be read unless the program has the relevant capabilities.
The relaxation only makes sense when env->allow_ptr_leaks is true.

Currently, the condition is inverted (i.e. checking for true instead of
false), simply invert it to restore correct behavior.

Update error strings of selftests relying on current behavior's verifier
output.

Fixes: eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spills")
Reported-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                          |  2 +-
 .../selftests/bpf/progs/verifier_spill_fill.c  | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..f9791a001e25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1209,7 +1209,7 @@ static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
 {
 	if (*stype == STACK_ZERO)
 		return;
-	if (env->allow_ptr_leaks && *stype == STACK_INVALID)
+	if (!env->allow_ptr_leaks && *stype == STACK_INVALID)
 		return;
 	*stype = STACK_MISC;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 671d9f415dbf..f52f10dbc91d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -464,9 +464,9 @@ l0_%=:	r1 >>= 16;					\
 SEC("raw_tp")
 __log_level(2)
 __success
-__msg("fp-8=0m??scalar()")
-__msg("fp-16=00mm??scalar()")
-__msg("fp-24=00mm???scalar()")
+__msg("fp-8=0mmmscalar()")
+__msg("fp-16=00mmmmscalar()")
+__msg("fp-24=00mmmmmscalar()")
 __naked void spill_subregs_preserve_stack_zero(void)
 {
 	asm volatile (
@@ -717,16 +717,16 @@ SEC("raw_tp")
 __log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
 __success
 /* make sure fp-8 is 32-bit FAKE subregister spill */
-__msg("3: (62) *(u32 *)(r10 -8) = 1          ; R10=fp0 fp-8=????1")
+__msg("3: (62) *(u32 *)(r10 -8) = 1          ; R10=fp0 fp-8=mmmm1")
 /* but fp-16 is spilled IMPRECISE zero const reg */
-__msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0_w=1 R10=fp0 fp-16=????1")
+__msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0_w=1 R10=fp0 fp-16=mmmm1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
-__msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2_w=1 R10=fp0 fp-8=????1")
+__msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2_w=1 R10=fp0 fp-8=mmmm1")
 __msg("9: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 8: (61) r2 = *(u32 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_r=????P1 fp-16=????1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_r=mmmmP1 fp-16=mmmm1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
@@ -734,7 +734,7 @@ __msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
 __msg("mark_precise: frame0: regs= stack=-8 before 3: (62) *(u32 *)(r10 -8) = 1")
 __msg("10: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,off=1) R2_w=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
-__msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2_w=1 R10=fp0 fp-16=????1")
+__msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2_w=1 R10=fp0 fp-16=mmmm1")
 __msg("13: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 12: (61) r2 = *(u32 *)(r10 -16)")
@@ -743,7 +743,7 @@ __msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2
 __msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
 __msg("mark_precise: frame0: regs= stack=-16 before 8: (61) r2 = *(u32 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_r=????P1 fp-16_r=????P1")
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R0_w=1 R1=ctx() R6_r=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8_r=mmmmP1 fp-16_r=mmmmP1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
-- 
2.43.5


