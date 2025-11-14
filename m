Return-Path: <bpf+bounces-74452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD5C5B110
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 04:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45D0D351510
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC922566D3;
	Fri, 14 Nov 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuSo/IKc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F6242D86
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089844; cv=none; b=tPjVca1XsaYT+abnnZq3KAa7mEObR3Kd4GKliQF+Ks0Ge9WYH4L40ZzweytNewLPNaXu5uabx6kWKUyYt8K3VGpV+R6aYfJqGpe/+5ThJpMRMoG1GAeQGBFfb8kqkl6n0QyihBhaz8NUogqa1H2TzBpU04Cufmo52fS/Bz9qJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089844; c=relaxed/simple;
	bh=n7IJtqUrM6ayVFasz3f65kak5gsgk7lMOn5ezt4MlT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qy22awmG9D/wB71bfbBZBow+LfM1NqXslO8KQq+OGBdcF3MpbogylEu9Btl4PISnQHftcUHUHysywWISv1zrjlsJsE1Y6KNSQHGlJCw6nfIo2sKG8o8gmBTbIezEvhMOnIFgCrFbZySLsQU1iZ7Jh7ox5Tg/Zc0ZfCHTCnu/6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuSo/IKc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2984dfae0acso18040255ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763089842; x=1763694642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gIcXL4ZhH2i804/wKVpG9b27FvtDDutopoAv8NfroI=;
        b=BuSo/IKcAYkiwf6DYt05+13TXUCmRAG68lpn/MEiqdaaZSb4jc7ikBNLWUs9++pHT4
         KNjB4YvroUwEmXFvdaUi4EmXKOoaCSYWErlc6lMyHIXcwuPuLPlq0Ms8WSAfDEwf0Nal
         DJp9lIbRLHRX6Lq8nXQf8+g5Sy2FNXf1zlzVvro9o/tGxT4lQ0ymy/Htp8H09Hdp30G5
         gAtntLs1nSoRqweJkunQ+ooKQE5K47zrNgrn8P3FFD9eq5vUM7aQ25E1uMUmxfJJkDBJ
         fg+8QlBhpv6fHg5e4YWCc5AY6MdibF1rTEiD1qb7VpnF394sUlkjcFRznDqpS5M23HKZ
         oinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089842; x=1763694642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gIcXL4ZhH2i804/wKVpG9b27FvtDDutopoAv8NfroI=;
        b=YbHX1BJWBt9Q0eBVqT580hyIX7T5e5Alm0j3JLJn4wSrFGhSt2Z9F0goIHs7auKwUX
         7CB7qfGXaUdGUnW+YMRE1tprTri/izaT0B/4sFOwZ9LZIt0+2d6foiKZFBySylycE37/
         1ErTsGEPDIlp/QiWwq6OtXLQESm+oO9XQ3AhsNtNWIr/09R5DYO9gbLifQYTZVdJDJuc
         tdpLHU83XrhXk4CQpKiI/+g4u+QGRuaWZpMANjMyV4DwwYkpG1XV4F6egPSqZztg4Y8T
         NiRPwpmeXjQWpGk/nx/bwxz0VSBeUA8GaP+5QX44/OJhpQUKLhwF/FMfhxKJ2pUy2G4e
         H38g==
X-Gm-Message-State: AOJu0YyIrI5o63a/VPKfCu3EE0Ca81zVWCtByZpUwtAAMrVrOv9MKAJT
	X6dpBszASMZQz1XsBqo1nja8HHnavrylpHZhLIMCnElPNaEBMjq//QKQAbFIKQ==
X-Gm-Gg: ASbGncu3T53b2Zj5yhUE3ws85z+I4bdnC76W6KueWOjp8KbiZUww6TzlqEz+l5H6kJH
	Pss1mancFa5rHLT4Px91/jXA3Rulq2nhtUd+2DcU505iIy9YscKmrBnwJERwuSGTonCXzRr7GGZ
	yzZLshBMONQqJpUSKujWkg6Ccu67Ypi62jAprCUHH7rskj8goqS3Ddh3sJOTLX/kaL+8vFIe5ms
	o+llcSDNSQpnCND40L8Y0RTGLr58bJ6Z01/5cFMY+Q3yIZVEhDD7XNZzM+mQFd1UfmJriefHTIn
	M23akURwgxwVNSoHThVmqIQBATsyZUAM1YqzIlIbrbGPPCsOvjeeVg8BMpWU0l9CTsPYti8F7mS
	4Sw/3Q1BZ1JzWmMjSCLcoNdJYmTfwINtzQA7kCvUawBcskx9Ll1By/AfPZW7ibbtwzl6oTRI16k
	TzMr8i+2qJV73kFQFL1FK0tfhkQnnjy8zJuRh2EpeLpB2WXP7N5PjdK0Y=
X-Google-Smtp-Source: AGHT+IEHwpvkuYNVVoTpCW4db9KNDbo1TsleKLbp2Zs0DXVAExPC0VOGE9mj1KxgBsmhZgiOn0j0Jg==
X-Received: by 2002:a17:903:1ae6:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-2986a75258fmr15867535ad.41.1763089841640;
        Thu, 13 Nov 2025 19:10:41 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccd14sm38511965ad.106.2025.11.13.19.10.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 19:10:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sunhao.th@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in the verifier
Date: Thu, 13 Nov 2025 19:10:38 -0800
Message-ID: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
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
which makes the verifier accept bpf_wiregard.bpf.c

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..fb6d6fe71e42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15440,6 +15440,33 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
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
+	__mark_reg_known(&regs[insn->dst_reg], 0);
+	if (alu32)
+		__mark_reg32_known(dst_reg, -1ull);
+	else
+		__mark_reg_known(dst_reg, -1ull);
+	return 0;
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -15533,6 +15560,9 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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


