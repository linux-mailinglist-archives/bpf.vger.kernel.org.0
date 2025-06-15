Return-Path: <bpf+bounces-60676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5245ADA160
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525FF18914F7
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E8265281;
	Sun, 15 Jun 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSzWRBB/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E634264F99
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977733; cv=none; b=fgLwrVx0IibZkseGCLrC8CINomSPEiO1U+dsKwq4ok2q5YQrUaanZ9jDWug2j/BrWT+NoRqGN1OpR8OKmnM8Ou1qyCpA8s2FEYgrYNv09CGeN5IOq2n/Udi2g7kwLkMz5/WW1IZTzrYBi4GTq5FIx9uRNXUpVE8pfo3Ywj5upCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977733; c=relaxed/simple;
	bh=X4OU7CM8r0G8BnhQ9StlRC44CkSNChWT8aDPeTTPRbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcY4c3vtBruxTDCCgnk3uUzGUpb68p04NAchpW+quAypMfBd5yV5vHLEt4ZXeX8EA4/88uLhgAttThIljxc+Q2l+EdVtmgYUc2R2T9MC4wNoBuhuCC3MZHbx0zYAeWk6lG7Od4WwsGj9i8mr/zpqIPj/Fpr77RzcsCWUBtU4uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSzWRBB/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3115551f8f.1
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977730; x=1750582530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkKIh5n65qcP6CreMRdKCaQrX4KWJXfceUqSJXvUrZo=;
        b=BSzWRBB/7XNSoBfB0hny2knmZgqEDkdhZf0QEDp1YUgs2cIv5dbEP20opUqKJlwfRa
         nNwJ/jXHUqKNfphcc75ajHSus1PtnRspX2wwV5RGpwkyC6iur1U4kE5kjXq/y1izMzT+
         ulH6JZY62NWvxB23uEpBnLUeCK1OYeOABPySDYb/wNPYwSoAApBv9TEHWzg9JR97UkhP
         P/uk/uuJUZzY5/kKJp60q+46azMldTE1qLetad0ZxRcRcKS87naxLUr5wWRsgGEAx0JB
         nBzhya9QDd8X9xFGGlCx8epsbIu9Nl21GUYTGiB2hPqNA3efZMrFU0d+dANUKRk8UMAD
         X25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977730; x=1750582530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkKIh5n65qcP6CreMRdKCaQrX4KWJXfceUqSJXvUrZo=;
        b=DPvDBEAu8ALX/jpjnDw5nZ8uSNH5ExLaEQGRvr7MZIgs+5KBu19iFhDSWtRvp37W2j
         Qp9rBqX9fZu8fnwrkHkFaJfG7gXyOOIyJBEl2zpNPICVIw4AUCVT9aCW9WD8PHLPO+pF
         VSP+s/bVKUokhHmNsCfzBhZXAZRxPw8Vmlh7So6t9Jl0IR/z0FklSakFmgS2dU8P/Lzj
         gQyJeEgRm4A3LD+Vcg4heGC6yPP+z8GVahQ6XCrUkHNSKgJVec6OZp1Zl39hw3Bs/6mk
         yF93gQw3iBXI8OqBYf+0VKJJotaSoNBa4RUv70FYMu6F7MHxv8sJ7sucwLSGgwaHe7RW
         9aVQ==
X-Gm-Message-State: AOJu0YzkOoaM+CbiDdPFLShLOmJ+XrTp/AM9wKas2gU1Fl6eQPfcUwsK
	XFnnwMyEgp/QnmZTmYF+x2L7Ogjyy9c9gBKtNV+8Ud4Ta9AtVLOX21VW92OfJQ==
X-Gm-Gg: ASbGncvBDmURKgWCpzR6opStXrU9gsNC2dcNxtuU2gCtD/Kt+NPdK3SYI/kizKyZilS
	oXuudCTfbq4VrfHJx01SzOHRbCyzNLboBmxZVNVrQLhrhTO3jFXj8SXzfqv2jAbVUmKfDYcvY2I
	0k22g6Mn0bSqfUDhugidwzYLJlONfUDo5MAJzpobMHkkiacnoWBN5+ASN/n4N9HsGhDij79Yteb
	au8168koQVh8q3Piit7TngCBCUuuJw2vn+B0Bku4qAio3ahEhrmVMH5wsSphBnKN1fQaBOS8tYS
	vW+4aDqORhtcH25oX1SGdOMe0OpRLUclMAay57KfH+TlK2V1OF3VN0JfyBZkGxpPhlQozcJiJIg
	5U1UNzQ==
X-Google-Smtp-Source: AGHT+IGhakhisrkPlhnHwGalJ+1ZMo9YbHMHkFp6pXXYtsmZ2m2B/RpE/PUUx2sWTalSizria6qcsg==
X-Received: by 2002:a05:6000:4205:b0:3a4:eb43:6003 with SMTP id ffacd0b85a97d-3a572e89634mr4400517f8f.29.1749977729957;
        Sun, 15 Jun 2025 01:55:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:28 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 4/9] bpf, x86: allow indirect jumps to r8...r15
Date: Sun, 15 Jun 2025 08:59:38 +0000
Message-Id: <20250615085943.3871208-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the emit_indirect_jump() function only accepts one of the
RAX, RCX, ..., RBP registers as the destination. Prepare it to accept
R8, R9, ..., R15 as well. This is necessary to enable indirect jumps
support in eBPF.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 923c38f212dc..37dc83d91832 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -659,7 +659,19 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
-static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
+{
+	u8 *prog = *pprog;
+
+	if (ereg)
+		EMIT1(0x41);
+
+	EMIT2(0xFF, 0xE0 + reg);
+
+	*pprog = prog;
+}
+
+static void emit_indirect_jump(u8 **pprog, int reg, bool ereg, u8 *ip)
 {
 	u8 *prog = *pprog;
 
@@ -668,15 +680,15 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 		emit_jump(&prog, its_static_thunk(reg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
-		EMIT2(0xFF, 0xE0 + reg);
+		__emit_indirect_jump(pprog, reg, ereg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
 		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
-			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);
+			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);
 		else
-			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+			emit_jump(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
 	} else {
-		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
+		__emit_indirect_jump(pprog, reg, ereg);
 		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
@@ -796,7 +808,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
+	emit_indirect_jump(&prog, 1 /* rcx */, false, ip + (prog - start));
 
 	/* out: */
 	ctx->tail_call_indirect_label = prog - start;
@@ -3445,7 +3457,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, 2 /* rdx */, false, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


