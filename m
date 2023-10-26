Return-Path: <bpf+bounces-13399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704297D8E62
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E866CB21627
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F7E8F4E;
	Fri, 27 Oct 2023 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/W99DOy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442278F44
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:30 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720161B5
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2800229592aso1001300a91.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386489; x=1698991289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWzFDBlrCucXbuh5gH/vQd/Yt8pKHvjRpmiR9c5r4z8=;
        b=f/W99DOyNgtlyEq6BO1L9KN0ld/qBLMrAqzW5BK8Q5qizkdJrQt3UqoApdNoPOobxW
         1M14A4+IjIZPq6euInnoOmvTI28/xFMpCFlhxnz7n2j84n9G1q26DYkMbQOlQKjCI2uT
         fBHU34NJf9m1bM0BvrHM1yk4jgurAJtmExNe4psw7m99fZYvmJ5URf7pWvc2x1ECkMzM
         Xm1OWL26MhCscTBAaW1kIJFJrn0FUCvvdv/Z65wJ51sleet6q80cwm7syWp/RKevLq1f
         ZQoF+OShfad/fzrdiJty9zyqlXzmeIz0LN/Mk5uXKVmjUkoK8FX8n+Oajblq74DEx+nN
         0Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386489; x=1698991289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWzFDBlrCucXbuh5gH/vQd/Yt8pKHvjRpmiR9c5r4z8=;
        b=nAItZ7LIfbKNIz70ptDC2qBFnUCEq9PWnsHIhIO92vv/QUb5kJzA+TBVhVg/cbS8Km
         CIRiIxTRer1p8FEyAUIcjnXc9kvfDoq+2LpAEQRojC4O3xy5zPtsDI4Gt1jomudLgd3q
         EZ4uD6MMvlF3+jUSWCGD7Izp0WDa5v1EsxkM4vBIhxooXruVhVP93wWQZ1/IvmZR7LXx
         B8IVw1HNi+atzjkcnp78PxCu2tL7wWawvvv3XsMlBTSYuhlD7/nKCco4WAAjNT7hwuSd
         wmAD6B9wbcvxQLYnXbLS/UQayOOBVniu74PSttaDYjhgWiByVx7iWleqg0NMBQBphDk1
         qQcg==
X-Gm-Message-State: AOJu0YwMt98rdj6+LG3WGCa5PW/Fcv/x8x54XyxcaeQi+Q3WCyEvRj5r
	CQERoNtK7cQdstY0PYnx5ww=
X-Google-Smtp-Source: AGHT+IEgaSgxsA8ckgC4SVIe+CC8eYEBsm/X0UUFfamFblf24Hb9Jb0oZED6z29P/GkbWh4L7jz1Mw==
X-Received: by 2002:a17:90a:6f03:b0:27d:6b5:9e07 with SMTP id d3-20020a17090a6f0300b0027d06b59e07mr1649997pjk.1.1698386488891;
        Thu, 26 Oct 2023 23:01:28 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:28 -0700 (PDT)
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
Subject: [PATCH bpf-next 7/8] LoongArch: BPF: Support signed mod instructions
Date: Thu, 26 Oct 2023 18:43:36 +0000
Message-Id: <20231026184337.563801-8-hengqi.chen@gmail.com>
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

Add support for signed mod instructions.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 7c0d129b82a4..169ff8b3915e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -588,20 +588,36 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = dst % src */
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_zext_32(ctx, dst, is32);
-		move_reg(ctx, t1, src);
-		emit_zext_32(ctx, t1, is32);
-		emit_insn(ctx, moddu, dst, dst, t1);
-		emit_zext_32(ctx, dst, is32);
+		if (!off) {
+			emit_zext_32(ctx, dst, is32);
+			move_reg(ctx, t1, src);
+			emit_zext_32(ctx, t1, is32);
+			emit_insn(ctx, moddu, dst, dst, t1);
+			emit_zext_32(ctx, dst, is32);
+		} else {
+			emit_sext_32(ctx, dst, is32);
+			move_reg(ctx, t1, src);
+			emit_sext_32(ctx, t1, is32);
+			emit_insn(ctx, modd, dst, dst, t1);
+			emit_sext_32(ctx, dst, is32);
+		}
 		break;
 
 	/* dst = dst % imm */
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		move_imm(ctx, t1, imm, is32);
-		emit_zext_32(ctx, dst, is32);
-		emit_insn(ctx, moddu, dst, dst, t1);
-		emit_zext_32(ctx, dst, is32);
+		if (!off) {
+			move_imm(ctx, t1, imm, is32);
+			emit_zext_32(ctx, dst, is32);
+			emit_insn(ctx, moddu, dst, dst, t1);
+			emit_zext_32(ctx, dst, is32);
+		} else {
+			move_imm(ctx, t1, imm, false);
+			emit_sext_32(ctx, t1, is32);
+			emit_sext_32(ctx, dst, is32);
+			emit_insn(ctx, modd, dst, dst, t1);
+			emit_sext_32(ctx, dst, is32);
+		}
 		break;
 
 	/* dst = -dst */
-- 
2.34.1


