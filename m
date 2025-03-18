Return-Path: <bpf+bounces-54317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B350A67664
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F87AAEC6
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934C20E038;
	Tue, 18 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YtOPIWmF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58D20E00A
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308198; cv=none; b=LzwLgEAFBIs/RIHPZrBrirBOYPPD6ygri3oFT7Qv+uvSlFgdlQ7e0BE0xXIlOBX9X2ivTvoEUm83osDo3Va8PYpUSBCruJzZ54cOw5f2fQK/lwikUAfS42g/COZnNvJAvnr8WAGcZTnpQ2O3/LqcXZsvibl6WRfLLrQlBq0oWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308198; c=relaxed/simple;
	bh=xTWLMGwZ+J2UJ54zkK4f/1GRnNBoqipWfS/8bDr/aWY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKldtqdJcK1koo2GfsrZWwe96gjXN36+jkfO+kHIK9OxV6ezZCleZu/CmE1x5fB7G6eZZ6g7T44xF5HkoS/quZpZbfXQazzXTrdU7hVLWpSwlDu7Db1BffauC5BNuVqNrnOb8xn052XJouAvxADOxrKgOrIixv65N4ZtLbnpAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YtOPIWmF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso35974895e9.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308194; x=1742912994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5x/Zdr28U7rm8LeTlmCEIcnCk+qjtX3EDdKLOo1AFXY=;
        b=YtOPIWmF6xBPscu7xsdUTTi1oJ1PlFwKIhx+QixBwlvFXLBJtq8eR56jL+G+lN3/3N
         orTMPfgdm0QzOKOg0CAupqTSbMvGAZ6Cq5BM9x/mv+q2wRpggcUWvMMy9w6IQdAxqneG
         82vGi8NVrBVSDZ2cbpf1JLLAjYFMNDPJSPLK1binIoOWZbiRwYLbE2Ho/T/n3/UyIkvS
         H+btze+MLVs1PvXWUpSU7Qwevqy0N0aXpvwN2HMf1FwrkVgQHbqwmAhkotbfYTxwXn+8
         F3nIZoYk+JUjXxdvJlaV4t5mHoatvoF2ZPtb1SvoBEjJIRl6eEu5Q5cLin5VWXYFE56v
         F6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308194; x=1742912994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x/Zdr28U7rm8LeTlmCEIcnCk+qjtX3EDdKLOo1AFXY=;
        b=O5RVJFXnIuhconeYDvYyzWTniedOeAQo/5wz0ko3QFm3S4tuxD0lpjEHC7YY4E28kj
         ibEjfq6G5S+DGn62kK0YvJIH+a48/rrOxloJHXBtn2qRGXLYbJXIAPpAFMS5mKHpwhUK
         jkfi7Uk+dE29AllMlUWfZkl7AHN6oZj5KWLT9HtP8ARkbX/3tS7NkcPG6zB/zhlwGnlX
         dE2o0JQv9Hed8GzFp5BRm+lk3OTXPib2AmsMTEDxtnpkznlV7I3jp7CEpPU3M1JTqN7G
         yxWPtiFFpN6URJD8GQCtKKpBk7ZOuesydmVqTEQk5bKMUJb/yEQ4OuoufwqMnrQMecor
         2Apw==
X-Gm-Message-State: AOJu0YydsnSA3VGmhXuSuli6PsKhVAwoTYSHFADtgtGUBkDCp+epA3sP
	leEKu+o1UwCgDm3dtsTgWgYo/khtP5IoZGh5uBvcAsEQkcxC6aNtix9L7modYO9LyoJ55LQQXHT
	B
X-Gm-Gg: ASbGncu5DrfTLr8QFjQzE8B6x2Ax/Da92CsACE14U8iehtyujUq5NP034aMhACAywNo
	vuKCEsmfLsH9JrnS73psNVbc+kvIHmGG1BLyqNNDKJ41bWovdG/YDDAc0q2spioOsvWwNnw/Mgl
	e7yGInsIoxz26kjmSrUE8TLeuPcm3JVl48rc5DDcLdzKk1hg5GsCV3K0hyeEbwfY8LdcIiu0qMu
	kMDXW/cdsWcfioGzQpDr+ES34eh3YxgvqBcEcVHuCNGCAhzW0o7odFdazDbuRlYG+Mxoa4GYEDi
	9qgX0ERLXcebtBw9ipl5a7p55ie9oXEjhppcwCt+04p4Ae07IGk1A/OzcQ==
X-Google-Smtp-Source: AGHT+IFa/zYy9gev8ciPJk+pRnAUSQgYVlQeFbZJgzbUqwgGg4pG8F7bChHyI/Rve0Xt7xnPlyGK0Q==
X-Received: by 2002:a05:600c:1e07:b0:43c:f689:88ce with SMTP id 5b1f17b1804b1-43d3b9d446bmr25661575e9.20.1742308193956;
        Tue, 18 Mar 2025 07:29:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:53 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 08/14] bpf, x86: implement static key support
Date: Tue, 18 Mar 2025 14:33:12 +0000
Message-Id: <20250318143318.656785-9-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bpf_arch_poke_static_branch() for x86. Namely, during each
JIT loop, save IP values and sizes of jump instructions pointed by
static keys. Then use the text_poke_bp() to toggle jumps/nops.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5856ac1aab80..31cadded820b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1569,6 +1569,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		int adjust_off = 0;
+		int abs_xlated_off;
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
@@ -1724,6 +1726,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
 			insn++;
 			i++;
+			adjust_off = 1;
 			break;
 
 			/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
@@ -2595,6 +2598,14 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			memcpy(rw_image + proglen, temp, ilen);
+
+			/*
+			 * Static keys need to know how the xlated code
+			 * of static ja instructions maps to jited code
+			 */
+			abs_xlated_off = bpf_prog->aux->subprog_start + i - 1 - adjust_off;
+			bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen, ilen,
+						 jmp_offset, image + proglen);
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
@@ -3880,3 +3891,38 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+int bpf_arch_poke_static_branch(struct bpf_insn_ptr *ptr, bool on)
+{
+	int jmp_offset = ptr->jitted_jump_offset;
+	void *ip = ptr->jitted_ip;
+	u32 len = ptr->jitted_len;
+	u8 op[5];
+
+	if (WARN_ON_ONCE(!ip))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(is_imm8(jmp_offset) && len != 2))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(!is_imm8(jmp_offset) && len != 5))
+		return -EINVAL;
+
+	if (on) {
+		if (len == 2) {
+			op[0] = 0xEB;
+			op[1] = jmp_offset;
+		} else {
+			op[0] = 0xE9;
+			memcpy(&op[1], &jmp_offset, 4);
+		}
+	} else {
+		memcpy(op, x86_nops[len], len);
+	}
+
+	mutex_lock(&text_mutex);
+	text_poke_bp(ip, op, len, NULL);
+	mutex_unlock(&text_mutex);
+
+	return 0;
+}
-- 
2.34.1


