Return-Path: <bpf+bounces-45757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB79DAED3
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0C71661F7
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998452036E5;
	Wed, 27 Nov 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvBchB0E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78118EFED
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742433; cv=none; b=CyGs5RaDr9Ua/LzDsGVfQ8xR8NC2Ee1hIL7K356Ho2MkaGvICB5H9TTqALqj+DsDCzlO3G+Gj0A4KIENGV37oBTY5XiRsKVJV2PCyAdMkwpeSAkt0PRhT/QzptJjFonmMpG5tVHO2VpSsL4VL56AKjM+OsQbtY6wu55v1IhqVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742433; c=relaxed/simple;
	bh=h0LqxQ42MMPent3wsGT2YYH2dwg3a/IXfXT3SKw5gT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY4KetOOFinm0+6CnMfnTVcJ44PQG+ZARfGIm9bdZ4Jq0cBt4xP/Ye2t+YBulUrdZOWQfZam5E7RJEyqhM63TcAlul4/2vZq65WEiTooOsS71xnZnpcFAfRpKcuiW7Qc9eZ3f8mSjxdOXGEDyxsl+VQl+pi8uIDmC6Hezv4agaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvBchB0E; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a90fed23so910255e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732742429; x=1733347229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzSfLUWRBNvo0A0RH4lHABmogu7i2Nws7BjZvmN/WVs=;
        b=YvBchB0EGRykvNDXyZIeT5FSTpp0Q4ayIV4UQgHRknj7dphcKP0qHXpRA/oUAhGQyQ
         Do3Wwe4C3K1dusYbnwJpxA/nbn0nXWtVI2UaXS0SZ+JifQ21ZGaR4nq6Qp5aspreRG/B
         lHDwc/BzExYDnhckVounzRF9pfJ+vWq8ywsQ1lBfXALjNWL0d/bXIckLOhp6/QavOIuK
         96oraP//ylSvFh0l2Ri3Tzm4Kf5idGC04RXjdselfxhEg3PAS8yCmHuMgTTpVHSdhwHj
         R8B4pJMY+hfrbfrVmazESPiEURd1ENrKlIgPyZgf33qx0LzNIIll57UYRPN7bKmf8qgZ
         x7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742429; x=1733347229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzSfLUWRBNvo0A0RH4lHABmogu7i2Nws7BjZvmN/WVs=;
        b=mvuGx7ndZTUEgyX3p5Q2LXlXOTpO1P+LptHhmMSY5XoQxW8en2sFF98BkgSuRozhEC
         /yypn45uDdoKbbrpBXq41WFFw8R8JorOYfUGsNODR+K86KDCCzSe2+NiOtpJ9fp+Qpos
         h6m+4+2dUZ62Ojb7mlX/g+5VbU6Ylmk2Vej3ls0182HR32zfSGpbPNE6eHIK2iq708nm
         td0YnabMkkPcbzZLrrVdN4CgDo2HjofPJWBd8AHdcOkZkUmNdj/J6N5wOxyK8NNmOtKz
         6BB1nSPsI68qA2IRgQ0/63s9vwYtrpBcQnBfXIMZIa/dG1utnOTDTCxVHBKFlv7CLiS4
         XijQ==
X-Gm-Message-State: AOJu0YwZKtO55aDcbtRu0tk0epPFXIBE6imkDIYcmjJZLFzZnoDSstd2
	iWaZGZeCQHalCnUz3XzSvfGMs5qbLNxMD8dFE9ANpo6mzl+4Pgiwn91f31v4jIE=
X-Gm-Gg: ASbGnctu3Q4nh7xAfy6Tzlzq2r3Zmo/42CoKLxbGGtar0J3BJ2qHr74/HtDlg/debMv
	o/2FXyiumaMsoJVpUtxkVh2Fz10V3aavTtt3AekigdhfOZZaVmX+UGGu8VBAmrP1GG/Gdguk3Cn
	y0BMOWiVXNW0lDPpvvzPTEaXXwLw3kkxgaJYVqZGev/og79kR87zfl9I4MJZQFiQzrCFu+I77nl
	srwOexhZm4g85jV9GB71hxxrmnqf1NDSGVS8aGKryHWgSxBVNR937es1DW3U2SpucFDs7YrvSVK
	EQ==
X-Google-Smtp-Source: AGHT+IFWGpTZRhOL6WzhViCWw9mrSCvGl9pikD0d1cEiEICr0dCD2capMzNEWxVJfznOQZfxS4yn1Q==
X-Received: by 2002:a05:600c:1c88:b0:434:a0a0:3660 with SMTP id 5b1f17b1804b1-434a9dfbbffmr45307705e9.31.1732742429103;
        Wed, 27 Nov 2024 13:20:29 -0800 (PST)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3b4asm17608808f8f.84.2024.11.27.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:20:28 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/4] bpf: Don't relax STACK_INVALID to STACK_MISC when not allow_ptr_leaks
Date: Wed, 27 Nov 2024 13:20:23 -0800
Message-ID: <20241127212026.3580542-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127212026.3580542-1-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5054; h=from:subject; bh=h0LqxQ42MMPent3wsGT2YYH2dwg3a/IXfXT3SKw5gT0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR40ByJfFnazCRwF4JiIVisRfB6Wd8z4HFB/tOrX5 XLQm6WyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eNAQAKCRBM4MiGSL8Ryim3EA C27kSzUyN/L8P8HkIB6yq4vpqduRe5p/ih0BInEaOIpld7lLnAlNieszuULPXiHmPIFcM3P99HAvNu QaxHyEMCT8IFXvPk6c9dw0wayCqFhpL70sSCWtt15IvC/h9pBICFNvGsK14W4HjqVFuyNOeFL19FqT XSmMDz6Ev+sG8fscV1HwJIiufXGtBW5mgRUlyFosDsYZix1CrzyWR6pbQ+jRnx93pxPkKYeVJU//oG /0D6S8uEk0uj4E4D+RDg3CV3P/cs9ajquXmjUguI7YFp58mxHDN8mfLNjK3kIGreokh78Y+xuIY0nQ J0hyyssRbG9xaYsANAU2uCRPIG6wRI0wRgQFs4lySJbNEpDlrBoyPOr2twA/b0uxbe/1FrEC6DXnA8 qNZNK22ev9X54FK4IN1iMpVilbBVQ+8srPHxfmsDBYguuXWgAFkjKUuEGa0Q+iYwoh3/DG/bUJbKcO Mm1jvwri0xC+w0yQFK2aatkdmN79fIjwCVBqHhLW2rzmvdQRKfVypxLlVkCzbS35aC5/Mh41tPWHTt lD1garoeS7CZBqUGQFcWcPD861TnxcVLus/RVHrFRVwb4x/94E2BXCJQWwD49S8CNqyDVwOtAVlA2E cHVWfC88W6qTIh1ULMfM9isxeqM/hGQ05JinOh4jork3fj0AgLU5pYwLBugg==
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


