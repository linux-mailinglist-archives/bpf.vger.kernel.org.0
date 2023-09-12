Return-Path: <bpf+bounces-9812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4D79DC28
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F021C21079
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E11172D;
	Tue, 12 Sep 2023 22:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C38BE61;
	Tue, 12 Sep 2023 22:47:00 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4510EF;
	Tue, 12 Sep 2023 15:46:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-403012f27e1so42464965e9.1;
        Tue, 12 Sep 2023 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558817; x=1695163617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vapbmpx4kHHnDeZPSymjWm+kxhmkjrMGYPDoYN863/0=;
        b=KvwGakzvA8fZIvgUYktGJpztbNfYPIIkemd9w75oQY9amw3HurQ4ojrzlyKVkgytH6
         wN/I9Xls1IogYeV2Gzmjyy99uBC8gycwmzmzd5ZUey1pAjmvM6r1mlQ7VHTDY/O7t1Go
         9RAh6BYAZR041009d3mspkjKXt3FI68FWzdkIDjJLNImRXILAjYtvMFrLOJ2bw9TY8w8
         8FloAVbQy8+Zho+4DOQv2YsNCTPo1bFW5k24DD9K87EhyEf5XWyU6k5sCBhGpuwfyD8F
         +UkyJAJF9RXoXHhXwng3HuX2AoGbnSzbEFC766Mziexjn5Rr6ECjAoDhqppBGqBu3b6/
         MScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558817; x=1695163617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vapbmpx4kHHnDeZPSymjWm+kxhmkjrMGYPDoYN863/0=;
        b=E6kZPQleAdzqVX4UPLHtNBIrdAcvC2oxwqRHbRNMfbVTR+Htj5oAcU4tWUqedMgJTq
         fas0tpW/sqsgeX+0hdkXxjp5wWS68/F/7AJGGptVJw1AuSbs9uokyyZIAHbi85bJP4AH
         +1ijKm9e88Pvj8FGf+JZQCGRtYk6UyRwiaYcjGk6WCCW2sZ2SReTGDnywCcAU4P0JZMO
         EP2AJWxMTCLwer6D7wLZjZZq0VeudTqEUefjjdy45jPN+EmAIbtzUNbKj2UTEenQnkQ7
         dBKuq6J7Ou+2BRrNqFNCEzDbpDgvhSCjqWx2IBl3AGpPkO6U4amkpLiw1GINV/Y3D7Z1
         PIpA==
X-Gm-Message-State: AOJu0YzLTFNo7a+K71gCqcV+/9gg2vAKt2mE7n38VyXvE20kaCdSSg7K
	q05wIgUNA34BCEvrYvQLh9E=
X-Google-Smtp-Source: AGHT+IGYaSde42//e2zWhzE0pBMJ3eH7x1xRhsn/tGbjooCPwkOeTE3BOytCJBgEeqN+vRwsYu0ZSg==
X-Received: by 2002:adf:f302:0:b0:317:ddd3:1aed with SMTP id i2-20020adff302000000b00317ddd31aedmr616529wro.68.1694558817139;
        Tue, 12 Sep 2023 15:46:57 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:46:56 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/6] bpf, riscv32: Always zero extend for LDX with B/W/H
Date: Tue, 12 Sep 2023 22:46:49 +0000
Message-Id: <20230912224654.6556-2-puranjay12@gmail.com>
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
 arch/riscv/net/bpf_jit_comp32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 529a83b85c1c..8f8255519ba1 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -847,18 +847,15 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
 	switch (size) {
 	case BPF_B:
 		emit(rv_lbu(lo(rd), 0, RV_REG_T0), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit(rv_addi(hi(rd), RV_REG_ZERO, 0), ctx);
+		emit(rv_addi(hi(rd), RV_REG_ZERO, 0), ctx);
 		break;
 	case BPF_H:
 		emit(rv_lhu(lo(rd), 0, RV_REG_T0), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit(rv_addi(hi(rd), RV_REG_ZERO, 0), ctx);
+		emit(rv_addi(hi(rd), RV_REG_ZERO, 0), ctx);
 		break;
 	case BPF_W:
 		emit(rv_lw(lo(rd), 0, RV_REG_T0), ctx);
-		if (!ctx->prog->aux->verifier_zext)
-			emit(rv_addi(hi(rd), RV_REG_ZERO, 0), ctx);
+		emit(rv_addi(hi(rd), RV_REG_ZERO, 0), ctx);
 		break;
 	case BPF_DW:
 		emit(rv_lw(lo(rd), 0, RV_REG_T0), ctx);
-- 
2.39.2


