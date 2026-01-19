Return-Path: <bpf+bounces-79509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6ED3B7B3
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46BE93022828
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80802E6CD3;
	Mon, 19 Jan 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XkmWZtkC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EA2E1C63
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852441; cv=none; b=U3CSJ/cMpjOhek1YL5M1WfmYQZ2kMozChiuzqvKUrIWweW77GDsXpJMravjW5rIX7yvo8Sy3K/R0rI5VkB21YrgdxDhHpo/Z0VR/HzYo79VzdTnoq/aEo3JaTPUOPVNNZDeAEIp5x9ZemjTL8tHl78r5eIuUyGxOeLNGMWJ+8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852441; c=relaxed/simple;
	bh=/5IMx0LOwuQ/fS0PMXv1p5ahtkG0Y2Gl9YyfrVMm1ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCgDQQHR2VfkkFka1Dut5YezNevkAYNUc/R9SKfnxsh/aGLGpZxWbKgP7ksRk32q9XXUyg1w5Bsq2e2vKniQzfgzk4kEYOVASxftDghwR993/1GpDXhWoZiqHxbGdGpw9bkc7XxM1bE/6QeT6T8dd45oCcbyGOJRayc3WLQS/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XkmWZtkC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b874c00a39fso819751966b.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852437; x=1769457237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jw6yvURkg8g/BKg+NPk3pygfQGmZuDFMac0kNaeW1wU=;
        b=XkmWZtkCMiHIy5IhhrPY7Xnw/Sbtgqr9+HJQy3YeYbjsnK4riBaKm5r0wP8he9cNCk
         EcSesBnWJil4qUMudj/PGxNCVjT2cb3WjAFa5e/Ni/DdkYqbcOIKv6J9SI4ad/zxVD/X
         iSMH+Ku93hQRyN4/xPK0lVsDJAbA6wxDR6a9VmzaS1QDONu/JiHTmYwKgKocs5/7Y/OJ
         MV1PXpnJIptCifIDEeYcBiLgEjIpAaxdjuEESy7mr1MHe1Nb49N2YuSNjt3U3affPQk1
         RyWfdtgM2MQ7rEhL8sXO3dGC72+pPURb/pE9772Q3APBdw3xolFcLP0OsI7Qg12J21Nt
         A2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852437; x=1769457237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jw6yvURkg8g/BKg+NPk3pygfQGmZuDFMac0kNaeW1wU=;
        b=Ci6A2WNxaL+AwaK9EpLtDbcDxD1IqSKOG0TcFq9Y/jRbWK09EZOe555my9M/h6b115
         f+sKDJVgX4lkVs7K45hNRv9j8cHYZmdcjKnyBwVyz0KK+HjTadLcIhGI/q7wLhTTEB4Q
         AFjCj90oNflhl5nNJvcUYXtx18DPWYAaaSCAUS4Mkgctup5ejl86MeCq9xQ6STgm+L/9
         cE0/vcCPB0mkYC2SaIzJLRjUY0uUyskfQBsBHNnNgfDj96FvyrfOSK1y2JhmmvejftYa
         YFRvq9OhPCODmlGp8p7F8I1OdzQzsNzMFjjQ0baYITQGtCFR2ufTZnA7C4+X/wWizrwI
         llDg==
X-Gm-Message-State: AOJu0YxKXPdBSKYrIzT7MSQf37Da3LLwWe/1xoPHxnOEeRxtkRGtQO7a
	eKy4/+FcolhP767Wb3bNphw8qZbPFeUwqM8RuGT7XUh+UefauEiATd+uGLJGr4E7Vag=
X-Gm-Gg: AY/fxX7NmPTK8NZd5/biBOp+Bb/Ezzem0XOl+jJLsZ0V+oPidFXrEjPXnvPyhURRNHD
	2/9L1o8mK5BrpzPeNb6bLq4WIEz/ESz1CAfL6L6XzA93pUab4O6BBCnSNBZCRN/fC9kfBbBsTKc
	q0mA73wa3xUetMH5ESpttVxqi07gpBkvQGK2h2/5rgXNmYSyJ11JDRWt9M1noHGyCMtzSzDet43
	ZjFknsJr9fSo8sArmKakPebypCoVkKd03D8RKOvh5p87I/RWoYiWY8Oha38f4wbm7DxH0iVLCuv
	U7aHxuysRwjxi0SkF3xb94Gkzmlg7p19btyaAcAj+GPeNKGbsRS/W6+PQs72Ufan9rVw5eOLVK9
	HI3Kcd95Y8FFBE1Cs4EXoJKXMedADCXmqQaO52x0RVWj4R9LNQT/slvVcOcYWrynuaX+u6/j4p/
	V/SbHhG7BDYrHTwlxm1PZTsLiXIlFk7zthQZwfqldaQf5LFNxVTcVJAQqqOks=
X-Received: by 2002:a17:907:6ea8:b0:b87:59a8:4c8 with SMTP id a640c23a62f3a-b8793857864mr1124290666b.5.1768852437067;
        Mon, 19 Jan 2026 11:53:57 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a350dbsm1194543166b.69.2026.01.19.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:56 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 19 Jan 2026 20:53:51 +0100
Subject: [PATCH bpf-next 1/4] bpf, verifier: Support direct helper calls
 from prologue/epilogue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to remove support for calling kfuncs from prologue & epilogue.

Instead allow direct helpers calls using BPF_EMIT_CALL. Such calls already
contain helper offset relative to __bpf_call_base and must bypass the
verifier's patch_call_imm fixup, which expects BPF helper IDs rather than a
pre-resolved offsets.

Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
with resolved offsets so the verifier can skip patch_call_imm fixup for
these calls.

Note that the target of BPF_EMIT_CALL should be wrapped with BPF_CALL_x to
prevent an ABI mismatch between BPF and C on 32-bit architectures.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 24 ++++++++++++++++++++++++
 net/core/filter.c            |  3 +--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..e358f01c300d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool finalized_call; /* call holds resolved helper offset relative to __bpf_base_call */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..15694a40ca02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21801,6 +21801,19 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Mark helper calls within prog->insns[off ... off+cnt-1] range as resolved,
+ * meaning imm contains the helper offset. Used for prologue & epilogue.
+ */
+static void mark_helper_calls_finalized(struct bpf_verifier_env *env, int off, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		if (bpf_helper_call(&env->prog->insnsi[i + off]))
+			env->insn_aux_data[i + off].finalized_call = true;
+	}
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -21867,6 +21880,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
 				return ret;
+
+			mark_helper_calls_finalized(env, 0, cnt - 1);
 		}
 	}
 
@@ -21880,6 +21895,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
+		bool is_epilogue = false;
 		u8 mode;
 
 		if (env->insn_aux_data[i + delta].nospec) {
@@ -21946,6 +21962,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				 * epilogue.
 				 */
 				epilogue_idx = i + delta;
+				is_epilogue = true;
 			}
 			goto patch_insn_buf;
 		} else {
@@ -22101,6 +22118,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		/* keep walking new program and skip insns we just inserted */
 		env->prog = new_prog;
 		insn      = new_prog->insnsi + i + delta;
+
+		if (is_epilogue)
+			mark_helper_calls_finalized(env, epilogue_idx, cnt - 1);
 	}
 
 	return 0;
@@ -23477,6 +23497,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
@@ -23488,6 +23511,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+		env->insn_aux_data[i + delta].finalized_call = true;
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
diff --git a/net/core/filter.c b/net/core/filter.c
index d43df98e1ded..aa0fabcd21d1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	/* ret = bpf_skb_pull_data(skb, 0); */
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
-	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			       BPF_FUNC_skb_pull_data);
+	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);
 	/* if (!ret)
 	 *      goto restore;
 	 * return TC_ACT_SHOT;

-- 
2.43.0


