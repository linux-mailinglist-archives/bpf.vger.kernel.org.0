Return-Path: <bpf+bounces-74623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E48C5FE40
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 395F14E70A0
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6311F3BAC;
	Sat, 15 Nov 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzhKRD0K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495719F127
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173579; cv=none; b=SjH0x5BYrDl5o/Cgp8i/1+gcVU3jg0J33cYSR7rznt4/HQBjma68PvIqCyw5NpEhiUwU+67tOCkpaZtg+73nzhiCL1wbwKwVZVuhj0lSSvrjRGW4RgIpTYYE9i/hrquf4dqYLZz/wz7mlWVu80nc4bOUkIZcQ7aiGO9Lr1VYkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173579; c=relaxed/simple;
	bh=yB1eDRE33zRXNdndH8N32mkNLep0BPAw8nk/vLl4eAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ4lhxWqr0trt+A2bHsd/hfwcj/MYG3L5GEEvwQ9nfa0fXmvHxFUY7JxiY1OFBlv6kZH2w51fyrXUgnAdE4w5W1mnnutxofcHbpcr2nkey2Zk1UTDNpe0RvtFt4tyEOGb2vKZQslXOFVu+jXfirRUGTrStdqYnSBq/SzwAIyjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzhKRD0K; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1175051b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763173577; x=1763778377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghpovdBxFfxriUeKX3qALpZF1AcpoAwx1e5Jl3r/naY=;
        b=EzhKRD0KnsFlYtS8muFBC3TNunbk1Ml6Wh2JKtPrhJKrU/Dfh5aRnK17GBvtsVSE6a
         ZuS/x0aGIFDEkRYhfRWV1eHNZ12+AvEJNQJBect21VGU5R2KLF7ocGYccDR5lqMV5qv/
         lJ10misMn2NhoQ8boS0gJ9YS4PTGnWxjOLho4uRA+YKtwOmjPTkEB2rpI7sGpp6R9IYD
         AIGVZGwW/s61QOJXHruXPZLdL05bIy7YbBy9oIKobCw9Te7z8+JZim3KGGpDpaJDSaj/
         N+I2fce/zGz2xfHMotQHP2IEgSLV8wytmo9okCpRT0ucBHKKqdpRPjZxCpMDAXOzPWEC
         XwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173577; x=1763778377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghpovdBxFfxriUeKX3qALpZF1AcpoAwx1e5Jl3r/naY=;
        b=evz45ekNYuq1Y0fFCgfVEmrtu08lM8yFmxTPBn4zvd3Tp8RIz6P6dP8TsoCJrEhZ80
         ZmE35no9ipcRda/NqCsq2Z678d/D3Y6yaL+RKvPJBdZo+RucoLe5nc3ZqKctKG5ivfEg
         pG2yB8qpKPYUpDQTXKVLPvEY4orX/rOdoShwpGgb9DR+WPIzWUDCeUWTUAEZQmhZCqSG
         r5KiRSpaIeB+0jn4Zhevp2Q6KQULXc0XLavInnebaBM75xA+Px0czgF38eSpts91zB+v
         uB8S2VMAH+Lij+Y+z17GDzfShUrRNWuqEO/BTbYfxvzmmmc3YdgRM1TQwphIvLumuLaa
         YHGw==
X-Gm-Message-State: AOJu0YzckOA34oLI+BENbeugOG/QGnSKWrmFW3hiYgHVahv1LdLLnN0X
	VQ6DpLQjZb140uUEE3gBwzXvJrfxKoKvbpVIAjpU20ZW2uihXnvc8NtvRckDmw==
X-Gm-Gg: ASbGnctqgtyiALXLUMgoP6ehdsRgYV+MbYv3H3KfE4gSwlKjsj3VCTRh4Xa/fNiPWsx
	qzlnQDR20mAidR0dKUopUooa8LuDiuS93OteWE+3pKxUx3yr+6GqHlAqa0kvz+uSq0E5B4C4BaU
	b2DVVFr2JoL1LlP40Y1sSoKmdYFSJCJZH6zPNnqdGQCqVecLeuN9LtpPzb1JhucDLxvykyghWd5
	XPwmeVkgENnArt+h7qUee9r5B/do/1XuwrR2FDiavl0PAg/llFevJZIuhM3x2vbvIBKvIHxIeXh
	9Vd5Ar2n2t39PKVKU38b1LepWiyMkuwnIdd36UZgz112UZCM1SkDMgqZLpWoJr5bHQ1rs7YYDaw
	i0HUnH4uQVSdGHEQNunnQ4Ap/RKhpjsxkQ1PLEOHUpszalgSU+SiZeZDMM6tcovG040+Cvd8NZE
	jDSS76lfTPzSxCvPxrhSI5Sptl9BB7/rvDWIKhP1eTjly9p+vqMOtwTIw=
X-Google-Smtp-Source: AGHT+IGyNayktaeABVDJH70WrFISwrPOudBBIminvuZcJiiQ8goKn0VrFeRXpi2WDMWd1anUdLNwSw==
X-Received: by 2002:a05:6a00:2408:b0:7a9:c21a:559a with SMTP id d2e1a72fcca58-7ba39bc0c02mr6224811b3a.8.1763173577123;
        Fri, 14 Nov 2025 18:26:17 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d332asm6570716b3a.25.2025.11.14.18.26.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 18:26:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sunhao.th@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 1/2] bpf: Recognize special arithmetic shift in the verifier
Date: Fri, 14 Nov 2025 18:26:10 -0800
Message-ID: <20251115022611.64898-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
References: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

cilium bpf_wiregard.bpf.c when compiled with -O1 fails to load
with the following verifier log:

192: (79) r2 = *(u64 *)(r10 -304)     ; R2=pkt(r=40) R10=fp0 fp-304=pkt(r=40)
...
227: (85) call bpf_skb_store_bytes#9          ; R0=scalar()
228: (bc) w2 = w0                     ; R0=scalar() R2=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
229: (c4) w2 s>>= 31                  ; R2=scalar(smin=0,smax=umax=0xffffffff,smin32=-1,smax32=0,var_off=(0x0; 0xffffffff))
230: (54) w2 &= -134                  ; R2=scalar(smin=0,smax=umax=umax32=0xffffff7a,smax32=0x7fffff7a,var_off=(0x0; 0xffffff7a))
...
232: (66) if w2 s> 0xffffffff goto pc+125     ; R2=scalar(smin=umin=umin32=0x80000000,smax=umax=umax32=0xffffff7a,smax32=-134,var_off=(0x80000000; 0x7fffff7a))
...
238: (79) r4 = *(u64 *)(r10 -304)     ; R4=scalar() R10=fp0 fp-304=scalar()
239: (56) if w2 != 0xffffff78 goto pc+210     ; R2=0xffffff78 // -136
...
258: (71) r1 = *(u8 *)(r4 +0)
R4 invalid mem access 'scalar'

The error might confuse most bpf authors, since fp-304 slot had 'pkt'
pointer at insn 192 and became 'scalar' at 238. That happened because
bpf_skb_store_bytes() clears all packet pointers including those in
the stack. On the first glance it might look like a bug in the source
code, since ctx->data pointer should have been reloaded after the call
to bpf_skb_store_bytes().

The relevant part of cilium source code looks like this:

// bpf/lib/nodeport.h
int dsr_set_ipip6()
{
	if (ctx_adjust_hroom(...))
		return DROP_INVALID; // -134
	if (ctx_store_bytes(...))
		return DROP_WRITE_ERROR; // -141
	return 0;
}

bool dsr_fail_needs_reply(int code)
{
	if (code == DROP_FRAG_NEEDED) // -136
		return true;
	return false;
}

tail_nodeport_ipv6_dsr()
{
	ret = dsr_set_ipip6(...);
	if (!IS_ERR(ret)) {
		...
	} else {
		if (dsr_fail_needs_reply(ret))
			return dsr_reply_icmp6(...);
	}
}

The code doesn't have arithmetic shift by 31 and it reloads ctx->data
every time it needs to access it. So it's not a bug in the source code.

The reason is DAGCombiner::foldSelectCCToShiftAnd() LLVM transformation:

  // If this is a select where the false operand is zero and the compare is a
  // check of the sign bit, see if we can perform the "gzip trick":
  // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
  // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A

The conditional branch in dsr_set_ipip6() and its return values
are optimized into BPF_ARSH plus BPF_AND:

227: (85) call bpf_skb_store_bytes#9
228: (bc) w2 = w0
229: (c4) w2 s>>= 31   ; R2=scalar(smin=0,smax=umax=0xffffffff,smin32=-1,smax32=0,var_off=(0x0; 0xffffffff))
230: (54) w2 &= -134   ; R2=scalar(smin=0,smax=umax=umax32=0xffffff7a,smax32=0x7fffff7a,var_off=(0x0; 0xffffff7a))

after insn 230 the register w2 can only be 0 or -134,
but the verifier approximates it, since there is no way to
represent two scalars in bpf_reg_state.
After fallthough at insn 232 the w2 can only be -134,
hence the branch at insn
239: (56) if w2 != -136 goto pc+210
should be always taken, and trapping insn 258 should never execute.
LLVM generated correct code, but the verifier follows impossible
path and rejects valid program. To fix this issue recognize this
special LLVM optimization and fork the verifier state.
So after insn 229: (c4) w2 s>>= 31
the verifier has two states to explore:
one with w2 = 0 and another with w2 = 0xffffffff
which makes the verifier accept bpf_wiregard.c

Note there are 20+ such patterns in bpf_wiregard.o compiled
with -O1 and -O2, but they're rarely seen in other production
bpf programs, so push_stack() approach is not a concern.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..c6e9bf38815a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15470,6 +15470,35 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	}
 }
 
+static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			      struct bpf_reg_state *dst_reg)
+{
+	struct bpf_verifier_state *branch;
+	struct bpf_reg_state *regs;
+	bool alu32;
+
+	if (dst_reg->smin_value == -1 && dst_reg->smax_value == 0)
+		alu32 = false;
+	else if (dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0)
+		alu32 = true;
+	else
+		return 0;
+
+	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+
+	regs = branch->frame[branch->curframe]->regs;
+	if (alu32) {
+		__mark_reg32_known(&regs[insn->dst_reg], 0);
+		__mark_reg32_known(dst_reg, -1ull);
+	} else {
+		__mark_reg_known(&regs[insn->dst_reg], 0);
+		__mark_reg_known(dst_reg, -1ull);
+	}
+	return 0;
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -15563,6 +15592,9 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
+		ret = maybe_fork_scalars(env, insn, dst_reg);
+		if (ret)
+			return ret;
 		break;
 	default:
 		break;
-- 
2.47.3


