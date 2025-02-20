Return-Path: <bpf+bounces-52020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B3A3CE8A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BD53B324A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1B18E764;
	Thu, 20 Feb 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD9ic9Vy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168892AD16
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014453; cv=none; b=CNTYfToSIWgs5WR3HxE46FhfzvmXTMPFSR5xPRgPCVYtwOgn+lmmVIsMm3IbBVrndlyAhl2BQVny9izyMVyNLwH67LAOUH8g9BtXrqIPZM0PpR07POk9nxQkqwKg1usW+EkxacKhQIgj92j0531ZLI2zsh65LzqKhqBOOJ3JHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014453; c=relaxed/simple;
	bh=8BEtdyFL+la1SWhGjdvnuHQmk94dfd7pWP8oR4rmWzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T5fgwqP4Xy5eysyNpQRKQjVde7i+6Uv/YFE7CdBTS87TChOZgAkLzO0YXAHNCQLPE1BzWJdD/hkU5OF2ebDC2J6nu/3Do8osdpZ/8qgag4W34yumvRqhKrn1tswScZuTTXeapqI05FdrH0jkw3fv/yr94RQFAA9OjcI8SzHVsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD9ic9Vy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e62c4fc2so7510805ad.3
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014451; x=1740619251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVw9FAeQI7lCZwFZLEeeKDcfx7NZFxNIup/gnaKUq1Q=;
        b=tD9ic9VyzQSbZsr3+usJdbzn6jBeZGgu62yH2EqklfdWkTkPsRPQvU9WJ0GnUuaU/t
         YIJZrjSlHixsEPcaqMkZ7PdmVcy5n1aWH/H5byfayecgwZhnpU8YlLcH/IJYAlk32Cve
         LcaYSBdZszb4PEMuMKSPf7IcSPVQu64siQEe6uyZhwQN6aT+850cHyJfpfb4cQ9IeLBz
         R19/ZcEBiLje0LrbIm1s6bOTngS3AJuWVhunr9mHFCDiggzNarqt4Xx2oGuQqdavTRzp
         /K//8E8KmaIER3D35J5ZWAx7jsh7b2B52/Drja7uy1iB5X00d+yDYTmmsmbXgmlwkP/j
         LG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014451; x=1740619251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVw9FAeQI7lCZwFZLEeeKDcfx7NZFxNIup/gnaKUq1Q=;
        b=f8cus9o3/Mw9Jx7fdkoJsq2Q3e+3b96iCcmCSMYNIWQ1+pGFBAH8ExMQ1/NNx/n3Ku
         l/OeWXf83eoju2bVH+e9yLHqKpi5cCRvl5CHyZbPhLVSuaGcKFn9R215VZExibCKJ2xN
         daUaTqt5W5Kq/4OP944b+P2LukyNliAtwhKfB9x+oCoGuh2WZH17j+8Q47c51GqeOJjv
         Esw9oex5i/gt3TXBqNktZCN118olBui44fc1WTFlnhqTCPu1w/SQPAwUZ6xnTYF+8lZc
         wsX0yrOxGzcMmWbBodnYXRGGWxo3BzqVNvjAXFWtQgaVhOws0rpCbjnhpB9NGD8+HfVS
         /zGA==
X-Gm-Message-State: AOJu0YwF7dSp4nm3Sgg+IIuIXTYmLhrpFUx0Pdnc/3oXu0qxu7gKlXSO
	vlqKQIF3B4FnFm35fUffGljd3WTjg/DrRnWWRZXoQAPxWx+GBtGXTvHOVYA1zGnLFUJUtutqrPN
	p1FOUcAQNT4Tc7r4ndMZr2qr+1djof8Ap1kVq4AEjv3c2bxEog6UG1+T+aHtZiS+mo7Gf2Y0CvU
	ePauYd7jI9I1Bj89nCH/278O/IAcY9Bcq/rsEdJy0=
X-Google-Smtp-Source: AGHT+IELkZhp3dnu1j1hrZyZSNzylf6/SsN58EX3cCnB9zawb1C1aTd09ns9uhXgPWFn3IcwfNEV46XMOLhkTw==
X-Received: from plbbj7.prod.google.com ([2002:a17:902:8507:b0:221:7c80:aeff])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c3:b0:220:ef79:aca9 with SMTP id d9443c01a7336-221711c8dd8mr102260065ad.53.1740014451316;
 Wed, 19 Feb 2025 17:20:51 -0800 (PST)
Date: Thu, 20 Feb 2025 01:20:41 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <91e99076cf23e75e4831c75b38f8cfa84d7da34b.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 2/9] bpf/verifier: Factor out check_atomic_rmw()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
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

Currently, check_atomic() only handles atomic read-modify-write (RMW)
instructions.  Since we are planning to introduce other types of atomic
instructions (i.e., atomic load/store), extract the existing RMW
handling logic into its own function named check_atomic_rmw().

Remove the @insn_idx parameter as it is not really necessary.  Use
'env->insn_idx' instead, as in other places in verifier.c.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 53 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21658bd5e6d8..63d810bbc26e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7615,28 +7615,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
-static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
+static int check_atomic_rmw(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn)
 {
 	int load_reg;
 	int err;
 
-	switch (insn->imm) {
-	case BPF_ADD:
-	case BPF_ADD | BPF_FETCH:
-	case BPF_AND:
-	case BPF_AND | BPF_FETCH:
-	case BPF_OR:
-	case BPF_OR | BPF_FETCH:
-	case BPF_XOR:
-	case BPF_XOR | BPF_FETCH:
-	case BPF_XCHG:
-	case BPF_CMPXCHG:
-		break;
-	default:
-		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
-		return -EINVAL;
-	}
-
 	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
 		verbose(env, "invalid atomic operand size\n");
 		return -EINVAL;
@@ -7698,12 +7682,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >= 0)
-		err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true, false);
+		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_READ, load_reg, true, false);
 	if (err)
 		return err;
 
@@ -7713,13 +7697,34 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 			return err;
 	}
 	/* Check whether we can write into the same memory. */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
 	return 0;
 }
 
+static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
+		return check_atomic_rmw(env, insn);
+	default:
+		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n",
+			insn->imm);
+		return -EINVAL;
+	}
+}
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -19187,7 +19192,7 @@ static int do_check(struct bpf_verifier_env *env)
 			enum bpf_reg_type dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-				err = check_atomic(env, env->insn_idx, insn);
+				err = check_atomic(env, insn);
 				if (err)
 					return err;
 				env->insn_idx++;
-- 
2.48.1.601.g30ceb7b040-goog


