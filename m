Return-Path: <bpf+bounces-9816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F024879DC39
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F1282512
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B114F9C;
	Tue, 12 Sep 2023 22:47:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC014F89;
	Tue, 12 Sep 2023 22:47:03 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9910F9;
	Tue, 12 Sep 2023 15:47:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401da71b7faso72322075e9.2;
        Tue, 12 Sep 2023 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558821; x=1695163621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kqE25xddEGWdkAd5IJWaOPr3bcznXZB6DbOZ/MzuKY=;
        b=CoRXAahptuRkL8SsIVeDj3ObxXrfCw8u4+j7VRtnnA9lLibob9UB23lXRhbob5ONXX
         HsJ2pBd9R3/50QfiB/xYttGbWUMGq+YFqHubDAfZkg0JGy2daXNJYVkVYIZOHQZ33bsa
         pPTnc/LkGz177lSMT7qpBqhZ4d6ZfWAH6gummX1vVxgaX/p5KnFUr5KqmJPjCioizIk1
         VErLKbwO+4JPsz8knfA9YCAlbLcALCZe7hQCc8z/Ujt7fyELW2O8SgZn54VbwUOVhcVr
         Ld80KKRNvQzLH3JRZ+z68txpk5O9nT/UBsQ1DQ28K/DHUiCs908ZmE36oh9IrM9x+Cv+
         YRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558821; x=1695163621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kqE25xddEGWdkAd5IJWaOPr3bcznXZB6DbOZ/MzuKY=;
        b=MinWX+D11KDq8mHbaGbwstMgF7noRAZ8kR1sDwa9381tj9taGmpVzUGLUZ1cN0DWXB
         gr2e0p/DnKArvhoBuZW9LFF4xAhJR6RYnI9dXmaBIipLAjmaBllvijbprmacNF5NfbJC
         w7jSn9Ao3VgyHKFdfeLAPgJjJ955NtiDSa48YP6eB70k7YE8t0wHGD3TST7c/0HaufdR
         2pl5cbQK/hV4tZY9rCK5QLCXLiH4bCCFnyAwM7qV3fxHxvjHnAkxH3KtlTkcV8DKEj2b
         BXLYloOe/xlvIT46aCMa0AoMIjC1WhYvmtW1vfp6UtRIKDFbCwetWom0MyoUc/uIDS34
         c5RQ==
X-Gm-Message-State: AOJu0Yzm5JRZjjlUY/xOuekpfMM4zJ8cc/ffQa+A4upT8JCBEEC6l8WD
	HHnZYPKNg890sdbK2x5g5aM=
X-Google-Smtp-Source: AGHT+IFtRPmqCA45qZeOfe4gap2/v8LgzERhETar42HTdZcTU3NFDWNWl1Q7ouaYhNuNBRQewOmqOA==
X-Received: by 2002:a7b:cbcc:0:b0:3fe:db1b:8c39 with SMTP id n12-20020a7bcbcc000000b003fedb1b8c39mr604002wmi.41.1694558821453;
        Tue, 12 Sep 2023 15:47:01 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:47:01 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Wang YanQing <udknight@gmail.com>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 5/6] bpf, arm32: Always zero extend for LDX with B/H/W
Date: Tue, 12 Sep 2023 22:46:53 +0000
Message-Id: <20230912224654.6556-6-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912224654.6556-1-puranjay12@gmail.com>
References: <20230912224654.6556-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JITs should not depend on the verifier for zero extending the upper
32 bits of the destination register when loading a byte, half-word, or
word.

A following patch will make the verifier stop patching zext instructions
after LDX.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..757a99febba5 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1081,20 +1081,17 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 	case BPF_B:
 		/* Load a Byte */
 		emit(ARM_LDRB_I(rd[1], rm, off), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit_a32_mov_i(rd[0], 0, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_H:
 		/* Load a HalfWord */
 		emit(ARM_LDRH_I(rd[1], rm, off), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit_a32_mov_i(rd[0], 0, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_W:
 		/* Load a Word */
 		emit(ARM_LDR_I(rd[1], rm, off), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit_a32_mov_i(rd[0], 0, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_DW:
 		/* Load a Double Word */
-- 
2.39.2


