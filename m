Return-Path: <bpf+bounces-13395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1907D8E5C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E32B2156F
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F079DE;
	Fri, 27 Oct 2023 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d62LNUpt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99688BEB
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:01:19 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F961B4
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b93ddb10b8so356333a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386477; x=1698991277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju1+333w2vHRlYpxQccqOWvW/oF44n6WKsFZFqcRgwI=;
        b=d62LNUptod+As6hYJnQ71t2ae29MYpkTS/35LvzuAUQsUCSQ9EMbj32fgrbnwdKxHx
         l32+fNWKzpAQmCnsVRW3VVMo5+K33Fk/FgNO+/zvXE2CDck+KlX9VzdUJeK4osxrLTW6
         1gNRqaatDekj4mPShHUcW9PsVcWpo64mIU+zZn5iZdNDljL29sb81lcSOfBIuADsqy6o
         3uspBTfHopLEsjISFSUNZ2HkS5kLu2QqEPAaZFOWsl6x5kgIs032pOrI9w6JM2Ihb8zw
         or/gPrYSMMGfTNFJY9HJuNC/JIoDO688+hF+VGJOcZ6lwqIyPTH6roYEmEmWgxb+kiQC
         SxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386477; x=1698991277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju1+333w2vHRlYpxQccqOWvW/oF44n6WKsFZFqcRgwI=;
        b=P//f/6a6T/vjuJ2JBJvAr8Sj2Cf+T1CVkR5r7zBqdNqxJH2dxzIRET3uHQ7yx0jWZy
         YHQscuBJ/HDwMQNtLN3ce9b2PY6X8tWECrahaokHBvxJx5ac17tbKRZSLePeFLoWbYuF
         YV+iPFCV7Q7kEU00Xszvr668ddB1qY6mTEr1O9zYbDZ6zp5NK5ejIGR6uVrvs2m1a0oc
         M8iuLy/c2b63x+3dUWES/+WY0fkwc9MhjWtdHySZ9nHhHJ7uBq76JPlyL6PsM55YNzPg
         1cRpOZ3ymSTbu4zGShMvf4fPTc/Mu9zbWG8OER505jSb6RVxR+IJALvIsSWflInRlRJ+
         0/zA==
X-Gm-Message-State: AOJu0YzftQ/LHtO+V/sRg2Zffi6Zj4IzgOQqq72ay8BEJL1RWuQL58DW
	0I9ZUVdiCqP3tpIFAtUkEOU=
X-Google-Smtp-Source: AGHT+IEi6zWufaoGL7LwP/y41ik7Gw7wqoxmlOg6OH5y2xkeUU5UrPt5OnGZ+hsmY71N8RdwgRsZQw==
X-Received: by 2002:a17:90a:be0e:b0:27d:2ce9:d6d5 with SMTP id a14-20020a17090abe0e00b0027d2ce9d6d5mr2390073pjs.12.1698386476634;
        Thu, 26 Oct 2023 23:01:16 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.47])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a1fc200b00277337818afsm1113667pjz.0.2023.10.26.23.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:01:16 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/8] LoongArch: BPF: Support sign-extension mov instructions
Date: Thu, 26 Oct 2023 18:43:32 +0000
Message-Id: <20231026184337.563801-4-hengqi.chen@gmail.com>
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

Add support for sign-extension mov instructions.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 0c2bbca527ef..ac9edf02675c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -472,8 +472,23 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		move_reg(ctx, dst, src);
-		emit_zext_32(ctx, dst, is32);
+		switch (off) {
+		case 0:
+			move_reg(ctx, dst, src);
+			emit_zext_32(ctx, dst, is32);
+			break;
+		case 8:
+			move_reg(ctx, t1, src);
+			emit_insn(ctx, extwb, dst, t1);
+			break;
+		case 16:
+			move_reg(ctx, t1, src);
+			emit_insn(ctx, extwh, dst, t1);
+			break;
+		case 32:
+			emit_insn(ctx, addw, dst, src, LOONGARCH_GPR_ZERO);
+			break;
+		}
 		break;
 
 	/* dst = imm */
-- 
2.34.1


