Return-Path: <bpf+bounces-53149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52812A4D080
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0145A7A8EEE
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534C13A26D;
	Tue,  4 Mar 2025 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lPbLWDL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04918D
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050393; cv=none; b=Oyy3qdG28ORHboR6XLGddK8AUa9q9Wq7NVSvrQkO7aErq6JyI+o6MEjDX8qTYGbDvTra4VPpws+i9OJXmKmeDvUboDYNf2N9Pi2C2n/tni1lSabD7BvNu7lkUIJCxAopplwJ0/s5y5jMdxKzA59aXZ3Wb1BEwD5lCYxoZxARUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050393; c=relaxed/simple;
	bh=3s+Yrmj5yMBXmNPTntJWviC8ExUfdF4PHTRQyWTWZps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mgepr2zrhkinC51JbJSu4nFJVigzOlY7gDqcJ9nr9vpouOs5LHev5EUMd36IDcETP4l/4Yx4pudu1auKDGp2fNSo5gzPYoI9rCASg21OlZfvytjU8Q70aV3wkvLgKHlCVB3eiLPKMdT9szrKLlL5O4QWEh2xjBiA9E4/UTL1gzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lPbLWDL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fdfdd94so9925458a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 17:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741050391; x=1741655191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BuDMmX0jHHwSlxRNuzBpxukuM3wSJDBUPrtSODIeAg=;
        b=2lPbLWDLxg/XaNlFPrsmvqSbC8MF92UEBpJ8dXi1z83exZVnw3Zck7nY9bUM5a85sz
         IBBUn3N2puJizhjV3aIutqJ5pC841kE9bQyFE4ROqPznC8Hezky0dlmNGzOWnVapSXow
         TcP19qhDz0Fp+fIZBGoKgWw7M4vh8rGxcCZdncjBx3Hjn3PopjsGXWWT33XSLLyCvmTQ
         Ly70KVDnPFd3i7hdmrZJb8mJ/RVI3JBiKnlKDcn9UFccEfIrB5dtf7PUkBVvtOvPxXSE
         Jgb2YWpSOQpT9PRKcIWHzQAiJzdry6cVMqsieGL13a1zdK+Xo/xOKEawBgQyNMntakIn
         LgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050391; x=1741655191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BuDMmX0jHHwSlxRNuzBpxukuM3wSJDBUPrtSODIeAg=;
        b=ffl1bvCm1vEHXV/nnKHtjCTrszhLdLMPBAICi/CU+/OGJQHiftM4i03Eh/X30HH/Cq
         jBM/KD5kNHw11D2kaiRCJvkwaOIqe6qHiFsAseGtdExUPPAGJBB/PIXcjz24aBAT6+OJ
         FypGnKVpM80YsQwBBJGS8hftMVbxd2IvDidymwRBf413FTufyegz/kHcP2yQmq3ApO17
         Hvnks03KuonMGrteUJ21umKVmsFGj5z4Eeinqs9f8Fv9cyz7iKLcfse2R9oU/3FxYm0i
         5tSlxgycZegqHaI7n3/wlyD7f7xVIL+EQPaIWOBloRdCShbLSLwTvLWu3EflPobEe07l
         pAig==
X-Gm-Message-State: AOJu0Yw+oH6tQqKL7mWjcsTIbbkYhBQAuo+Sx4CH/EhrUPT0Cg9mTuRL
	bznnjotbzgWSgAFrCaXXnqTowMNa5GKtdkqVv1Lf3S0ARIzLhCTYulTOWvQMqH3DiwJU4sq94uo
	D5McomKllNZiNCNWdiTaOBbNoL7MF/2IceEHwk/njZsjcx5Uzj5+XSM3HZc4LBGSuORyc0A/hjq
	W+joPp9DgkybRMqujd5Yt9dAZezD5/0kjqxNchPkg=
X-Google-Smtp-Source: AGHT+IEcZse/PxUWK6noSaGV/op7yUGHmHrKSD2SI170M3zfS2vOWknK1IqYRQYIDagchmJojH0eZ7OMjoMWEw==
X-Received: from pgar1.prod.google.com ([2002:a05:6a02:2e81:b0:af2:3c1d:c03c])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da6:b0:1f3:3538:6f6 with SMTP id adf61e73a8af0-1f33538094amr3507137637.9.1741050390934;
 Mon, 03 Mar 2025 17:06:30 -0800 (PST)
Date: Tue,  4 Mar 2025 01:06:27 +0000
In-Reply-To: <cover.1741049567.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741049567.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <ba92057b7502ce4c9c9b03b7d637abe5e178134e.1741049567.git.yepeilin@google.com>
Subject: [PATCH bpf-next v6 3/6] arm64: insn: Add load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add load-acquire ("load_acq", LDAR{,B,H}) and store-release
("store_rel", STLR{,B,H}) instructions.  Breakdown of encoding:

                                size        L   (Rs)  o0 (Rt2) Rn    Rt
             mask (0x3fdffc00): 00 111111 1 1 0 11111 1  11111 00000 00000
  value, load_acq (0x08dffc00): 00 001000 1 1 0 11111 1  11111 00000 00000
 value, store_rel (0x089ffc00): 00 001000 1 0 0 11111 1  11111 00000 00000

As suggested by Xu [1], include all Should-Be-One (SBO) bits ("Rs" and
"Rt2" fields) in the "mask" and "value" numbers.

It is worth noting that we are adding the "no offset" variant of STLR
instead of the "pre-index" variant, which has a different encoding.

Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
           ID032224),

  * C6.2.161 LDAR
  * C6.2.353 STLR

[1] https://lore.kernel.org/bpf/4e6641ce-3f1e-4251-8daf-4dd4b77d08c4@huaweicloud.com/

Acked-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h |  8 ++++++++
 arch/arm64/lib/insn.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 2d8316b3abaf..39577f1d079a 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -188,8 +188,10 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
+	AARCH64_INSN_LDST_LOAD_ACQ,
 	AARCH64_INSN_LDST_LOAD_EX,
 	AARCH64_INSN_LDST_LOAD_ACQ_EX,
+	AARCH64_INSN_LDST_STORE_REL,
 	AARCH64_INSN_LDST_STORE_EX,
 	AARCH64_INSN_LDST_STORE_REL_EX,
 	AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
@@ -351,6 +353,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_acq,  0x3FDFFC00, 0x08DFFC00)
+__AARCH64_INSN_FUNCS(store_rel, 0x3FDFFC00, 0x089FFC00)
 __AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
 __AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
@@ -602,6 +606,10 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     int offset,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
+					enum aarch64_insn_register base,
+					enum aarch64_insn_size_type size,
+					enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index b008a9b46a7f..9bef696e2230 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -540,6 +540,35 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 					     offset >> shift);
 }
 
+u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
+					enum aarch64_insn_register base,
+					enum aarch64_insn_size_type size,
+					enum aarch64_insn_ldst_type type)
+{
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_ACQ:
+		insn = aarch64_insn_get_load_acq_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_REL:
+		insn = aarch64_insn_get_store_rel_value();
+		break;
+	default:
+		pr_err("%s: unknown load-acquire/store-release encoding %d\n",
+		       __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    reg);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+}
+
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
-- 
2.48.1.711.g2feabab25a-goog


