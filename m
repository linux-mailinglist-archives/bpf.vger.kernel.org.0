Return-Path: <bpf+bounces-65172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E15B1CFFB
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 03:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABB7567197
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB30B186E2D;
	Thu,  7 Aug 2025 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuRczfXH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517D225D7
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528543; cv=none; b=AUQepE5l+R+bn/R/7nUIcVDHqlmRkylca/Oipkcf+snfeDYSXRPPe3yXxnq8UuyTaut6dL3ZvDZ7u426NZoviUXD/Xm9LhWsXEM65dqEpMt6T61fNIWw4SuMMry7buRvSLVr5OOTirjQi39qDmzHNmbM7JrDiutyYWp5JbuGNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528543; c=relaxed/simple;
	bh=PsqzPPJeZm2P3aZhQnsgt/lQJwBXbAIKH8TWJUrqGJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpap1nInnaxNRp0VIZ9lWDVvEMb256AVH+WpGy7JGGkdS0qH2DQVOO9Lm0ulvoFrqn59VBmjDzL8E42EG4bxBhYeAAmSIn1cTcGgx5awz2LYFWkWM8hGH8bZ/JgZH7ypYQ+mACp5SyuZhC8SmzDoxPlfSxTezE3LqOJ3rfUxUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuRczfXH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b42348bae1fso258136a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754528541; x=1755133341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoLvRXbqGT9QNp5pd/IepMi5j3lhreX2uA780MNw/A0=;
        b=QuRczfXH+mXvalLmeVueuFYvJAewTNT0wbUmnfxoP1b9693BTR3xgZ9qwgGNp5Neec
         7HjgYQkrRe8AwAHScxBX6vfqfTEjNRgxsImJOPu7kSZjVyIsDY45Z4ZdFIznyJtBFspM
         zihOndeR75a7AXFYKT+bDrWp3k0G0D2q2C+67cDdxWXLsN8NuMc1yrRwuDmu9Q2ruf//
         qT4XKPbOAfRuE/U2fpJYf5QvOFYmAFlMgDwuy2Uzq/0gH9Xt3OjvuBBYNxli0iKX26QZ
         qoCSF1vHJclt9OeOKJDTEtg/I8j2itvSwyA84t/eT4cz/rxTaqYtB5BqMDmdi00uPAaB
         JL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754528541; x=1755133341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoLvRXbqGT9QNp5pd/IepMi5j3lhreX2uA780MNw/A0=;
        b=RVQ8gcLYpP+7p8VsBs3z3rJRdy15d/soLDMsL6MLeEJRwpTDEaEsFUJftLCT6TBMF0
         jMGtOigJsvXwLYD4+Z8dlnpFB1FiQQOfWpeGAlivxrZ5KXCAIYn2AeOmkU3cqd0qvOiM
         dxY/kUa728ECSgj6GloHnQghCT9gCYv4e4zSLpmsy7/tue3aBkjhx0ZhYqwTXXLD1dSt
         Pv22T9A1Qad96izNZ2k5bSSG2dL3csudjzTNIAJwI5EdiaC9V0B5KaOV6SSTnvBy0IAy
         QrHHQ1qpcmImYeUjbYJdIlyIFeHFUn27ZBnGbm4TvaOGEivS93aehQk8Soi8lG4knBxG
         9WYA==
X-Gm-Message-State: AOJu0YyshX3b+R2bXZgzyH3fCtg9pdGALDBacBPUJJ+O5T3IajulTv/R
	MNpmdQvZbRuqKyWqrHlRptAjXeppRrkYRmLzeziT5NODvRc6kEzjWlkdVUCiGagt
X-Gm-Gg: ASbGncuoSAUBa/HiktuGxGN6iVO65Npu4rDGkuzJMYlrQQF8x3fhW8n+HU91wkwoQDK
	Q54BZ3t0GtT5GRK7WKyYmuthi/zSjMQxBDSlxYoIq7UsHB9Dx0rB5ChQtnfP6+6ANhO7X47Fbeh
	/Ws07ssnFuTEjwipBZKGqC9tlhXIKa3Ru5WbG4VHui/d7g1Qzi3jL666yuQbFbT7YLqB430TPUx
	DqrovcNU90PdPyV37P1XOeJRuJM0FsLu7kNgq3ZUoVUE9hfOSBhw7s5yViFIO4yzHfayHRcxSE7
	3Q6fOT41IGueug1sR4S9R17Q/9DH453cMyCKmfg62CJ2RYhs2UOPh+8UmRNoIz4vlnF33mEpl5R
	8SiqlXzE/d0aLdVu01MH2JYe8nZM+k472SGKna2rkHWE+moRuDYCRurc=
X-Google-Smtp-Source: AGHT+IFhgf3ASamnIPx4kfw3EMJHcbPouFvDOnVK2BV8RJGknLsvS8dYjxbRtTztM8urZLIwrKDUAw==
X-Received: by 2002:a17:90b:54c6:b0:321:7a2f:9865 with SMTP id 98e67ed59e1d1-3217a2f9bf7mr4859a91.13.1754528540579;
        Wed, 06 Aug 2025 18:02:20 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7828a0sm14483348a12.2.2025.08.06.18.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:02:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 1/2] bpf: removed unused 'env' parameter from is_reg64 and insn_has_def32
Date: Wed,  6 Aug 2025 18:02:04 -0700
Message-ID: <20250807010205.3210608-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807010205.3210608-1-eddyz87@gmail.com>
References: <20250807010205.3210608-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parameter 'env' is not used by is_reg64() and insn_has_def32()
functions. Remove the parameter to make it clear that neither function
depends on 'env' state, e.g. env->insn_aux_data.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0806295945e4..69eb2b5c2218 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3663,7 +3663,7 @@ static int mark_irq_flag_read(struct bpf_verifier_env *env, struct bpf_reg_state
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
  */
-static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
+static bool is_reg64(struct bpf_insn *insn,
 		     u32 regno, struct bpf_reg_state *reg, enum reg_arg_type t)
 {
 	u8 code, class, op;
@@ -3774,14 +3774,14 @@ static int insn_def_regno(const struct bpf_insn *insn)
 }
 
 /* Return TRUE if INSN has defined any 32-bit value explicitly. */
-static bool insn_has_def32(struct bpf_verifier_env *env, struct bpf_insn *insn)
+static bool insn_has_def32(struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
 	if (dst_reg == -1)
 		return false;
 
-	return !is_reg64(env, insn, dst_reg, NULL, DST_OP);
+	return !is_reg64(insn, dst_reg, NULL, DST_OP);
 }
 
 static void mark_insn_zext(struct bpf_verifier_env *env,
@@ -3812,7 +3812,7 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	mark_reg_scratched(env, regno);
 
 	reg = &regs[regno];
-	rw64 = is_reg64(env, insn, regno, reg, t);
+	rw64 = is_reg64(insn, regno, reg, t);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
@@ -20712,7 +20712,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
 	 * original insn at old prog.
 	 */
-	old_data[off].zext_dst = insn_has_def32(env, insn + off + cnt - 1);
+	old_data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
 
 	if (cnt == 1)
 		return;
@@ -20724,7 +20724,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	for (i = off; i < off + cnt - 1; i++) {
 		/* Expand insni[off]'s seen count to the patched range. */
 		new_data[i].seen = old_seen;
-		new_data[i].zext_dst = insn_has_def32(env, insn + i);
+		new_data[i].zext_dst = insn_has_def32(insn + i);
 	}
 	env->insn_aux_data = new_data;
 	vfree(old_data);
@@ -21131,7 +21131,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
 			 *       here.
 			 */
-			if (is_reg64(env, &insn, load_reg, NULL, DST_OP)) {
+			if (is_reg64(&insn, load_reg, NULL, DST_OP)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;
-- 
2.47.3


