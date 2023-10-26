Return-Path: <bpf+bounces-13398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FED7D8E60
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF6B21340
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9018F41;
	Fri, 27 Oct 2023 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR4C6EpX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB8881F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:28 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEE1B8
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5ab2cb900fcso1371065a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386486; x=1698991286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXv9dn4i8m4RUIoprh3jAeTLejyEjZe30vXJvAEpPQI=;
        b=cR4C6EpXr4IThnhKsLx3wrUu1ZDu7BgPoMZRP8xGtNjZAfhSaah354P20hYZD35WUu
         JySEG6Igo4ha8A+U0umg5X9SaUjMAbbWAounA6uvEc3bpSxtzyHk/MzW5fSkNir29dK5
         jY80FrX91XzwMGQtP5sWuBNp/NObRvA6TD2NpfFtvjKzxhs+b8P3XGJjUeq4mVt623vz
         M+tqRUtX8MI8AOi/EBpJh3D9PB67Zfq/cN15Iaq6woKMHaZMd/QvLdse9TldlO9I2NIZ
         g4A8K4+T4Y07XXSnFmvbUgll5GamtOuLdGOTAgahLk0NEibz+ZlvDnEKv3R4UDECDYrC
         FziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386486; x=1698991286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXv9dn4i8m4RUIoprh3jAeTLejyEjZe30vXJvAEpPQI=;
        b=qfeMBmrQ3WO3mmYTo68zeWVx8Dqiuwty7/10VsKE6KvepX7wB+TGFKKDBY1xWrU+cM
         ydJrgi8/76f95e+m4zAWne2ic8g2cN+zP1q13GypmEAjThXocIN8LjUu8Thcy42uDBJl
         juTrQGJ6Po/Kl1Fo08tvJo06LyK1SfXUyba8T8oyvf4ofD8WwTiqxg0U/nfndxLurtKt
         WY66IvvzGrRqHLcc7sS1O6CZ7IotHNbouhpdGVioxgn5Lcn+x7ZmvTc13G4P9Izo5aau
         r3NLQwFQMvGY+L/KjyOqe0GyDt4nRIr6A7k+5c8Jz0B31u49YjQMHFp/2o9ErfwZR24z
         hPRg==
X-Gm-Message-State: AOJu0Yy7jgkFUN5LC/QivgqDLbHtOTSwgc3sC12Q3OsV6x2nVT/XGW0W
	L0a0hRWyxw6Z2KIef3pLDm8=
X-Google-Smtp-Source: AGHT+IFiVPAOA9+35Jg4JjLI0IlKVNR+C1+6tE2tw5V9YMxPmaqIL13TxeO8q1y4Gjwqe7cV/wMzxQ==
X-Received: by 2002:a17:90a:ad91:b0:27d:b9d:bd6f with SMTP id s17-20020a17090aad9100b0027d0b9dbd6fmr1567936pjq.45.1698386485857;
        Thu, 26 Oct 2023 23:01:25 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:25 -0700 (PDT)
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
Subject: [PATCH bpf-next 6/8] LoongArch: BPF: Support signed div instructions
Date: Thu, 26 Oct 2023 18:43:35 +0000
Message-Id: <20231026184337.563801-7-hengqi.chen@gmail.com>
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

Add support for signed div instructions.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 050fcf233a34..7c0d129b82a4 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -553,20 +553,36 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst / src */
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
-		emit_zext_32(ctx, dst, is32);
-		move_reg(ctx, t1, src);
-		emit_zext_32(ctx, t1, is32);
-		emit_insn(ctx, divdu, dst, dst, t1);
-		emit_zext_32(ctx, dst, is32);
+		if (!off) {
+			emit_zext_32(ctx, dst, is32);
+			move_reg(ctx, t1, src);
+			emit_zext_32(ctx, t1, is32);
+			emit_insn(ctx, divdu, dst, dst, t1);
+			emit_zext_32(ctx, dst, is32);
+		} else {
+			emit_sext_32(ctx, dst, is32);
+			move_reg(ctx, t1, src);
+			emit_sext_32(ctx, t1, is32);
+			emit_insn(ctx, divd, dst, dst, t1);
+			emit_sext_32(ctx, dst, is32);
+		}
 		break;
 
 	/* dst = dst / imm */
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
-		move_imm(ctx, t1, imm, is32);
-		emit_zext_32(ctx, dst, is32);
-		emit_insn(ctx, divdu, dst, dst, t1);
-		emit_zext_32(ctx, dst, is32);
+		if (!off) {
+			move_imm(ctx, t1, imm, is32);
+			emit_zext_32(ctx, dst, is32);
+			emit_insn(ctx, divdu, dst, dst, t1);
+			emit_zext_32(ctx, dst, is32);
+		} else {
+			move_imm(ctx, t1, imm, false);
+			emit_sext_32(ctx, t1, is32);
+			emit_sext_32(ctx, dst, is32);
+			emit_insn(ctx, divd, dst, dst, t1);
+			emit_sext_32(ctx, dst, is32);
+		}
 		break;
 
 	/* dst = dst % src */
-- 
2.34.1


