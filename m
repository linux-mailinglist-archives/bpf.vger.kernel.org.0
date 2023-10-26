Return-Path: <bpf+bounces-13394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3987D8E5B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3187228233E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD0883C;
	Fri, 27 Oct 2023 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj0WuIWX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC87495
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:17 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB31A7
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso1443042a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386473; x=1698991273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhv57qGO2ds9mbz1kzxH2y7YI2Zg20QWv6WH4DiyAo4=;
        b=mj0WuIWXz4air3W1ndK/ksNO7jEM5unuXaBdifKgWHjEJ+4H4iIbLy2plbYhzRS2xs
         wMT8XLcGsN56VL+BvtxKhgfMbe+KzVc6425yIEUqAv42vnzbJgEMtYewY1PtZmgga84W
         oVl3DHMWLhO0REIHb6rPEASIAIsWI3X7FN0hZpDEW7D0w9TdMn5ICJzoEuYRo7lNvREu
         Gzuyd85xILRMaNA+Aqt2BnoaQwWAuTpwzRPv3DLm4l8wpYddnQgBd5RTOhNZOmLmbxEv
         Xmb8js5KhndLsSiUKswXsjuTYVeZUP2M2TWVy3K/vh2pE5XUw/jykvUfQ2m9QUDOWzKL
         x33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386473; x=1698991273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhv57qGO2ds9mbz1kzxH2y7YI2Zg20QWv6WH4DiyAo4=;
        b=AagkgL+nXa3E86jGy5BtIp3TndzsW01v3IkiHHpntlQhZU0h3BjcVnAni4yXDRYDR/
         6sRxIAorGCuQdpVmWJtPWCYFK5ZB9syxoJqiHw1GsL/KjD6qLojvdHwhxxYq4ZFenf1J
         HcEaTwMaOoTviUE1kovoOfLIsvUPVrEtZ6pfi6iPFuWMyFCxjjH6vuUeWixqqxIOgGWA
         jyzAQTe6jG6nvc48Hj0LqRX5HkzERV67rxGQPy/pHLxZSsvqJ1bHXCzSc2fNjFIQL2Au
         9vdvIumi1pDnFjkE7ZOT/hTQPXz1Wv6XTB7+jVuKo5EuBjZ4Lke/RA07VNAVtVNX6CQV
         KWGw==
X-Gm-Message-State: AOJu0YxtfSP2gIMG3la9tJ0pkNR77PgdECkg3M0V9sVAsr57YtQPdZMD
	jfMJ0y3Dz6HS0v3OOqyBfZA=
X-Google-Smtp-Source: AGHT+IE2jl0HioVsQXNEfZxRACFosanEuhKFHfIooEHzU9KdPnTtunsaur1cC+gCgV8FkLRBioC3ig==
X-Received: by 2002:a17:90a:1996:b0:27d:2054:9641 with SMTP id 22-20020a17090a199600b0027d20549641mr1710760pji.36.1698386473513;
        Thu, 26 Oct 2023 23:01:13 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:13 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/8] LoongArch: BPF: Support sign-extension load instructions
Date: Thu, 26 Oct 2023 18:43:31 +0000
Message-Id: <20231026184337.563801-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026184337.563801-1-hengqi.chen@gmail.com>
References: <20231026184337.563801-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for sign-extension load instructions.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index db9342b2d0e6..0c2bbca527ef 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -411,7 +411,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	off_t offset;
 	struct exception_table_entry *ex;
 
-	if (!ctx->image || !ctx->prog->aux->extable || BPF_MODE(insn->code) != BPF_PROBE_MEM)
+	if (!ctx->image || !ctx->prog->aux->extable)
+		return 0;
+
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX)
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->num_exentries >= ctx->prog->aux->num_exentries))
@@ -450,7 +454,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 {
 	u8 tm = -1;
 	u64 func_addr;
-	bool func_addr_fixed;
+	bool func_addr_fixed, sign_extend;
 	int i = insn - ctx->prog->insnsi;
 	int ret, jmp_offset;
 	const u8 code = insn->code;
@@ -879,31 +883,56 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+	/* dst_reg = (s64)*(signed size *)(src_reg + off) */
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
+		sign_extend = BPF_MODE(insn->code) == BPF_MEMSX ||
+			      BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
 			if (is_signed_imm12(off)) {
-				emit_insn(ctx, ldbu, dst, src, off);
+				if (sign_extend)
+					emit_insn(ctx, ldb, dst, src, off);
+				else
+					emit_insn(ctx, ldbu, dst, src, off);
 			} else {
 				move_imm(ctx, t1, off, is32);
-				emit_insn(ctx, ldxbu, dst, src, t1);
+				if (sign_extend)
+					emit_insn(ctx, ldxb, dst, src, t1);
+				else
+					emit_insn(ctx, ldxbu, dst, src, t1);
 			}
 			break;
 		case BPF_H:
 			if (is_signed_imm12(off)) {
-				emit_insn(ctx, ldhu, dst, src, off);
+				if (sign_extend)
+					emit_insn(ctx, ldh, dst, src, off);
+				else
+					emit_insn(ctx, ldhu, dst, src, off);
 			} else {
 				move_imm(ctx, t1, off, is32);
-				emit_insn(ctx, ldxhu, dst, src, t1);
+				if (sign_extend)
+					emit_insn(ctx, ldxh, dst, src, t1);
+				else
+					emit_insn(ctx, ldxhu, dst, src, t1);
 			}
 			break;
 		case BPF_W:
 			if (is_signed_imm12(off)) {
-				emit_insn(ctx, ldwu, dst, src, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, ldptrw, dst, src, off);
+				if (sign_extend)
+					emit_insn(ctx, ldw, dst, src, off);
+				else
+					emit_insn(ctx, ldwu, dst, src, off);
 			} else {
 				move_imm(ctx, t1, off, is32);
-				emit_insn(ctx, ldxwu, dst, src, t1);
+				if (sign_extend)
+					emit_insn(ctx, ldxw, dst, src, t1);
+				else
+					emit_insn(ctx, ldxwu, dst, src, t1);
 			}
 			break;
 		case BPF_DW:
-- 
2.34.1


