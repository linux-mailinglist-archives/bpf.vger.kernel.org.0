Return-Path: <bpf+bounces-9815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823A79DC32
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AED62813EA
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55F14F6C;
	Tue, 12 Sep 2023 22:47:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18114AB1;
	Tue, 12 Sep 2023 22:47:02 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153210F4;
	Tue, 12 Sep 2023 15:47:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c65820134so5762419f8f.1;
        Tue, 12 Sep 2023 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558820; x=1695163620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhUNqTKNJ5t40WxcJkQJJc6NwQozn+LNI3JL0/ULous=;
        b=dsh8CodRO/rjPAwHsY5JMfDmx8BK07PZ4jrSu27Py0Tef5Mr+XoxzwVHp7iuX7a51c
         Dvikoo4hYXxMHrL8vcxwFNL8zxnaLK6MTHe/4xOQqWoHVBm4WgDyJhCBNXN730LSYUgk
         SF2JWi3oU99EMGbDqsVqFrDp8liz8DHqJV3hPMhNuN0V87V749ae1wgCGtkDHlBT/JHP
         fbRNxYZrDe2FcS9TZvws1003xu03L32J2uo/Q0k+OZtsDkCenl7mEk8qnYqcqaYg/gSM
         WJNk0DaBfxkneFNf6zZmFyrhqimnuQX7IElCVRKWBCaNvaV5/gXp3KBD1+i7G86O5htO
         1ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558820; x=1695163620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhUNqTKNJ5t40WxcJkQJJc6NwQozn+LNI3JL0/ULous=;
        b=sWI9ps6tej+A/643AqH/qPTq7bSRsWooXjxvOwPmFleT1zV/3KDsLPwUQQQ93Xtons
         Uwea9uDI5mYZBdmm2xNNKUlTdQgssv44a35Lb+2yyIfEuSf0RFWiJG5TUraqjXfS7X8q
         bbmhCisDBa4RiR31Ub41DgwEyzpY70T6YxORUzFEULhd4B9UFSVduF372VIUqwEQGu3I
         NJKngj2bwhmFH7VLVkCVHHsmcml9zcfnkDkz5LZGbinpbMLtNUV70xQbezaNCRWpTXo5
         la9/i1yB6McKi+CemJZvQd38uANxuEwsVicUBPwgIQav0+8eQtsYOwkyIQtlFllFkxiU
         Fqsg==
X-Gm-Message-State: AOJu0YyS1ChUxTAQZCE9oQNPsTcPdAF9R7btvAuGG9ezuKf1hhLrx4uZ
	hCw+QijRnbYnW0OegWemGQw=
X-Google-Smtp-Source: AGHT+IFgAH0fOtyaF0ehV56I8y/PX0drowIs04cM59dILrqCnUI/euGHNvJaohPj3FXuSexhWOZw7g==
X-Received: by 2002:a5d:628c:0:b0:319:7a9f:c63 with SMTP id k12-20020a5d628c000000b003197a9f0c63mr718103wru.50.1694558820430;
        Tue, 12 Sep 2023 15:47:00 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:47:00 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/6] bpf, powerpc32: Always zero extend for LDX
Date: Tue, 12 Sep 2023 22:46:52 +0000
Message-Id: <20230912224654.6556-5-puranjay12@gmail.com>
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
 arch/powerpc/net/bpf_jit_comp32.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7f91ea064c08..0a952a2cfaac 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -936,14 +936,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 				/*
-				 * For BPF_DW case, "li reg_h,0" would be needed when
-				 * !fp->aux->verifier_zext. Emit NOP otherwise.
+				 * For BPF_DW case, "li reg_h,0" would be needed emit NOP otherwise.
 				 *
 				 * Note that "li reg_h,0" is emitted for BPF_B/H/W case,
 				 * if necessary. So, jump there insted of emitting an
 				 * additional "li reg_h,0" instruction.
 				 */
-				if (size == BPF_DW && !fp->aux->verifier_zext)
+				if (size == BPF_DW)
 					EMIT(PPC_RAW_LI(dst_reg_h, 0));
 				else
 					EMIT(PPC_RAW_NOP());
@@ -974,7 +973,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				break;
 			}
 
-			if (size != BPF_DW && !fp->aux->verifier_zext)
+			if (size != BPF_DW)
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
 
 			if (BPF_MODE(code) == BPF_PROBE_MEM) {
@@ -982,20 +981,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				int jmp_off = 4;
 
 				/*
-				 * In case of BPF_DW, two lwz instructions are emitted, one
-				 * for higher 32-bit and another for lower 32-bit. So, set
-				 * ex->insn to the first of the two and jump over both
-				 * instructions in fixup.
-				 *
-				 * Similarly, with !verifier_zext, two instructions are
-				 * emitted for BPF_B/H/W case. So, set ex->insn to the
-				 * instruction that could fault and skip over both
-				 * instructions.
+				 * Two instructions are emitted for LDX.
+				 * So, set ex->insn to the instruction that could fault and skip
+				 * over both instructions.
 				 */
-				if (size == BPF_DW || !fp->aux->verifier_zext) {
-					insn_idx -= 1;
-					jmp_off += 4;
-				}
+				insn_idx -= 1;
+				jmp_off += 4;
 
 				ret = bpf_add_extable_entry(fp, image, pass, ctx, insn_idx,
 							    jmp_off, dst_reg);
-- 
2.39.2


