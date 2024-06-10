Return-Path: <bpf+bounces-31760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6587902C3A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C55FB2146B
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC6152161;
	Mon, 10 Jun 2024 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR51NDiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD151BC39
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060947; cv=none; b=mDy+rt7pB4fpbutpyYo+1wiT8AaoULarLJsC3VYyNP4bHCKP/DTvfB5U3ZMDLO5xwIjwSrx6ZY0jPyBGhL/be0HZmhBILnVJgdiYS36uGWZWMFecJ0noVbRlBjg/You2A4A7PWZhso+a6ClPtPqg7XjBqg3G7bS8qb0qrLvntQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060947; c=relaxed/simple;
	bh=KNec9Zit4bjSuhTA/z+LM9H52JJyE0ka3/uhqHIcAFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rr/jdvmvBDAU0WliGxMqYUzaOMRjjuV8yUhKYZ83pV++szlZLI4Kyr6H8mzibzgvVZPVwd7v4PA+CE2JkpR4omg9LJFZrD72OgSh0qg+dNrifNsKBaN3WSFubHCbHTlpbIni++Nbszx+K6Av9JHFjOF2Tu0u/m9Pi1K/kluUKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR51NDiZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5bad217c51aso1458754eaf.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060944; x=1718665744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgT1zkNiY0iAAS+b/L8aq/x21E4RdslfjECetyQOAzs=;
        b=lR51NDiZNOmNryA8w1EaROkjcjmRxy0dLDCTcyuvpEY2agfE++dbPIAvHX/a4AMCGl
         oldUwwcBlAtAR9m/W3HQXth7uplyeZB5sgbv+5J7C5Fjle+Put8c7ZtW2kylku+u/h6o
         BIOa3dljF/z2gdztgM0xZZ2j16wrB8ZMHlIR3exzkkx7eivh9e1/htjYuBKOwCNoK1xe
         bAclBQPCoAK0RXyS0sNUdu7OrNtV5Na+C4o6mhtmEEjWir6IhiqU7m8FpPhoh9KNIvq+
         OMjVGN3q+4kpYDb4xiLFdLoB0kR6938WgVx3k9dEgeB7OAFZGHqYaHG8WuDkvsR1urb1
         FpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060944; x=1718665744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgT1zkNiY0iAAS+b/L8aq/x21E4RdslfjECetyQOAzs=;
        b=CX47MLVeZ1B89aMY2KaGCF8ZNrexTdE7W/ftyBq8J/FG/xmuaJMugerFto8EAghBhr
         rksQ3yLZL1MrPKZ7VvoUIz46fFTFJPGNAvdt6QkpU+DXFzoPefkHpkhvYL7q9ELCsCte
         5/+W9Hq5tlZ4oJryf59XsLm4ggPxT3IEmMItSxc/DNHtvEes3RUaSTjJrLnJzv7I8NaZ
         im5xPgo9+d11tM5kkIUn0SzJF2DSvex7+srUqeY/kdxLRo3QCyvxgbs7cq67WUWGdI69
         QSYEqxOYSUNwqQuZW1cottBUWiM0y0ncr+XgIRQaWvM7gquktoZzRjoFPHvr7JZl2nWN
         /qmQ==
X-Gm-Message-State: AOJu0YwRnn98nR6mr8OrpLk2PqSoAO17UDPVWRT8BV1aIKNFtlywN/DE
	j/e40tngjhbsSN9pQZrV16O8vuhCnjmKPNkNsewXQiwZ5VUwGM/B1eT8Wg==
X-Google-Smtp-Source: AGHT+IE2dUwnGOyQNiJ/M/WoRZ3gIiRzxaPCMBUB42b2nZ1fofWuezyxQy3FWakYzxD68CW1hh/E9Q==
X-Received: by 2002:a05:6358:722:b0:19f:4be7:434c with SMTP id e5c5f4694b2df-19f4be75050mr582082355d.16.1718060940596;
        Mon, 10 Jun 2024 16:09:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:cfaa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e925d13b6esm3701828a12.37.2024.06.10.16.08.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jun 2024 16:09:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/4] bpf: Track delta between "linked" registers.
Date: Mon, 10 Jun 2024 16:08:47 -0700
Message-Id: <20240610230849.80820-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Compilers can generate the code
  r1 = r2
  r1 += 0x1
  if r2 < 1000 goto ...
  use knowledge of r2 range in subsequent r1 operations

So remember constant delta between r2 and r1 and update r1 after 'if' condition.

Unfortunately LLVM still uses this pattern for loops with 'can_loop' construct:
for (i = 0; i < 1000 && can_loop; i++)

The "undo" pass was introduced in LLVM
https://reviews.llvm.org/D121937
to prevent this optimization, but it cannot cover all cases.
Instead of fighting middle end optimizer in BPF backend teach the verifier
about this pattern.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 12 ++++-
 kernel/bpf/log.c             |  4 +-
 kernel/bpf/verifier.c        | 89 +++++++++++++++++++++++++++++++-----
 3 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 50aa87f8d77f..2b54e25d2364 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -73,7 +73,10 @@ enum bpf_iter_state {
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
-	/* Fixed part of pointer offset, pointer types only */
+	/*
+	 * Fixed part of pointer offset, pointer types only.
+	 * Or constant delta between "linked" scalars with the same ID.
+	 */
 	s32 off;
 	union {
 		/* valid when type == PTR_TO_PACKET */
@@ -167,6 +170,13 @@ struct bpf_reg_state {
 	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
 	 * to a specific instance of bpf_iter.
 	 */
+	/*
+	 * Upper bit of ID is used to remember relationship between "linked"
+	 * registers. Example:
+	 * r1 = r2;    both will have r1->id == r2->id == N
+	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->off == 10
+	 */
+#define BPF_ADD_CONST (1U << 31)
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
 	 * from a pointer-cast helper, bpf_sk_fullsock() and
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4bd8f17a9f24..3f4ae92e549f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -708,7 +708,9 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
 	if (reg->id)
-		verbose_a("id=%d", reg->id);
+		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
+	if (reg->id & BPF_ADD_CONST)
+		verbose(env, "%+d", reg->off);
 	if (reg->ref_obj_id)
 		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 	if (type_is_non_owning_ref(reg->type))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a3d2ced78d..25c74ceddd42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3991,7 +3991,7 @@ static bool idset_contains(struct bpf_idset *s, u32 id)
 	u32 i;
 
 	for (i = 0; i < s->count; ++i)
-		if (s->ids[i] == id)
+		if (s->ids[i] == (id & ~BPF_ADD_CONST))
 			return true;
 
 	return false;
@@ -4001,7 +4001,7 @@ static int idset_push(struct bpf_idset *s, u32 id)
 {
 	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
 		return -EFAULT;
-	s->ids[s->count++] = id;
+	s->ids[s->count++] = id & ~BPF_ADD_CONST;
 	return 0;
 }
 
@@ -4438,8 +4438,20 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
-	if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
-	    !tnum_is_const(src_reg->var_off))
+	if (src_reg->type != SCALAR_VALUE)
+		return;
+
+	if (src_reg->id & BPF_ADD_CONST) {
+		/*
+		 * The verifier is processing rX = rY insn and
+		 * rY->id has special linked register already.
+		 * Cleared it, since multiple rX += const are not supported.
+		 */
+		src_reg->id = 0;
+		src_reg->off = 0;
+	}
+
+	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
 		/* Ensure that src_reg has a valid ID that will be copied to
 		 * dst_reg and then will be used by find_equal_scalars() to
 		 * propagate min/max range.
@@ -14026,6 +14038,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
+	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
@@ -14048,11 +14061,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
-	else
-		/* Make sure ID is cleared otherwise dst_reg min/max could be
-		 * incorrectly propagated into other registers by find_equal_scalars()
-		 */
-		dst_reg->id = 0;
+
 	if (BPF_SRC(insn->code) == BPF_X) {
 		src_reg = &regs[insn->src_reg];
 		if (src_reg->type != SCALAR_VALUE) {
@@ -14116,7 +14125,41 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EINVAL;
 	}
-	return adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
+	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
+	if (err)
+		return err;
+	/*
+	 * Compilers can generate the code
+	 * r1 = r2
+	 * r1 += 0x1
+	 * if r2 < 1000 goto ...
+	 * use r1 in memory access
+	 * So remember constant delta between r2 and r1 and update r1 after
+	 * 'if' condition.
+	 */
+	if (env->bpf_capable && BPF_OP(insn->code) == BPF_ADD &&
+	    dst_reg->id && is_reg_const(src_reg, alu32)) {
+		u64 val = reg_const_value(src_reg, alu32);
+
+		if ((dst_reg->id & BPF_ADD_CONST) || val > (u32)S32_MAX) {
+			/*
+			 * If the register already went through rX += val
+			 * we cannot accumulate another val into rx->off.
+			 */
+			dst_reg->off = 0;
+			dst_reg->id = 0;
+		} else {
+			dst_reg->id |= BPF_ADD_CONST;
+			dst_reg->off = val;
+		}
+	} else {
+		/*
+		 * Make sure ID is cleared otherwise dst_reg min/max could be
+		 * incorrectly propagated into other registers by find_equal_scalars()
+		 */
+		dst_reg->id = 0;
+	}
+	return 0;
 }
 
 /* check validity of 32-bit and 64-bit arithmetic operations */
@@ -15088,12 +15131,36 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			       struct bpf_reg_state *known_reg)
 {
+	struct bpf_reg_state fake_reg;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+		if (reg->type != SCALAR_VALUE || reg == known_reg)
+			continue;
+		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
+			continue;
+		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
+		    reg->off == known_reg->off) {
+			copy_register_state(reg, known_reg);
+		} else {
+			s32 saved_off = reg->off;
+
+			fake_reg.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
+
+			/* reg = known_reg; reg += delta */
 			copy_register_state(reg, known_reg);
+			/*
+			 * Must preserve off, id and add_const flag,
+			 * otherwise another find_equal_scalars() will be incorrect.
+			 */
+			reg->off = saved_off;
+
+			scalar32_min_max_add(reg, &fake_reg);
+			scalar_min_max_add(reg, &fake_reg);
+			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
+		}
 	}));
 }
 
-- 
2.43.0


