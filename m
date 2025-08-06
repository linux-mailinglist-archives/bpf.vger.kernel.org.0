Return-Path: <bpf+bounces-65151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C0DB1CD3B
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 22:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA7C7B3964
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516152C326F;
	Wed,  6 Aug 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTyvqRFW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6532BDC21
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510981; cv=none; b=tRk0j3ZmthX9dwa4OcFIClUBA8O3R2tSQHwS5seXccHPFIvpaBOY070+TbM6WZsx8ay8e3SJ6PGiZZb0DZUUEyjyzKAxW9VqKmwtJQp4tTI990Uyxn2yxlwG1o00efiTRPvgYu/QkHuuIu0UhAGH1ygzhT5TgReNdLgV4Y6Efgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510981; c=relaxed/simple;
	bh=PsqzPPJeZm2P3aZhQnsgt/lQJwBXbAIKH8TWJUrqGJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fx+OIMqDo+pmnkW+LTi+jwCYH4EOgOQxFhm4AuwuB4I8KM5wwE3yKEt7QoOOmN+SlJK0EiHwXOFBLlgNCG+Vr1hlSFUz1isHAnSr5DQMxQ3KSMZ/YgFETLvUCeoM8H43v23vO5cnU3nFGGcUZVhug4qbD8pMZ4yVumDTdrU1Tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTyvqRFW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dc5bcf49eso2621265ad.2
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510978; x=1755115778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoLvRXbqGT9QNp5pd/IepMi5j3lhreX2uA780MNw/A0=;
        b=MTyvqRFWp1mUg2oJbHMNRA6j7QHglWb9R4nVqqWrWtbD6EkH2dsExGNx3QUsxhiNsF
         5CL4vMkoek9UyfDlRFsL/sqZ8Z/ucVubYyzk0bnwAJenSgio6v60jpsl65yns3lXO87l
         mZGPYZWWCgl/imzQbSVzJKu57p02Ah+gggXKCiFCVL7dLKZY2/Srmd80jPkEbRPBdI9e
         fJY6YINsGlPZ4zcXYADQcn1kr8SPCSlrXhHbFOQexlsi8rJZ7fpyUW3zhToEDjda77GY
         mLxmx/ImBobX6Gkczbw1wnSKP/9BicIWAm0mcEEgW58RWm08XESzMaNEyRRdIHzzJUnL
         vU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510978; x=1755115778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoLvRXbqGT9QNp5pd/IepMi5j3lhreX2uA780MNw/A0=;
        b=WCAVk+GRMooX+9ls7JuQRGnCU0Nv6kjv4iSIB3Mki8ZkbIgE0TsCVKC5vRpHcT//U3
         1Va8EwF4Pa1w0bb7toND+WkkQ5stQX0X36Vc9qTz9gyO6Kh1xQzRZP7UlmqrfZ1GLztP
         snePBmMxwGP880ljCcj15R1B2YhXQFZV25u2U2tMUTW9LhxZVad6NLKiLP9/c2KIEtQ7
         eeo7xFpcAzYGrOB8KvO8NepMYQotggwKlUVoiSxHIbJ4mRgWzT3Ke7c5DVJdL6PIG990
         9JNV6aGs1rdUAEPzwPyBmSBLeK8+J2HXmZkcRSvaGJRB+tIGM/wHbRNcfC25+RrpAOqG
         cWfg==
X-Gm-Message-State: AOJu0Yy25jgvAO8Pz8utI6s+lzJt45tmSZgUm14rdrhWwLBctdv/8fGR
	gjxiXSGcZOyi0ztQ9iU3pUC6prECkUBkkaBAzKeqlrTltJjVt8PssiL7vhPOg/Pp
X-Gm-Gg: ASbGncudEscjPp4HTmzDfHmkidbDhTq/sLI+vjufmmOLNL8NPdD5b+x3KqwEBlHu5Cn
	VHVFDs+2rLdR0NgJ9rc/BWigvi2PtD35Q6xw/ccgq3/KucCcwNhnjnHIUq9R5M5S9naXVz2iv+R
	jRIGBL8hiV36m+p74GyBULtGmqBpxdkyKU+lDAj3I81e9BiSVkT79YCZjxsAWDbGTp58OXeSzla
	MkqztzuC8bOYK/NbcCF21MXdLNdFwBHj/+A+TStWM6S+wNdNU6Te8aUm9UCITTXTzx1YYXN7rEO
	RqROwSAsCMcZ9zQOI2jsBVZayo1zLbvUCnEpGVGMggb4fH2fEtxvfPl6hDLXNnkKEQmkmZcUvwY
	MwHWQjQTeOjIFmjlm6mVy7ZCvoOB7GwXziREB0XEADqRS
X-Google-Smtp-Source: AGHT+IHGRbZnSaj0vrMK/UWnL+UA5AytHVnJUhHWU6w6il45Z++8HDbyw1wO9guLylM+z3xqL7JmIA==
X-Received: by 2002:a17:902:e804:b0:240:aba:fe3b with SMTP id d9443c01a7336-2429f32bd84mr67631505ad.16.1754510977767;
        Wed, 06 Aug 2025 13:09:37 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef595esm165032665ad.13.2025.08.06.13.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:09:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 1/2] bpf: removed unused 'env' parameter from is_reg64 and insn_has_def32
Date: Wed,  6 Aug 2025 13:09:27 -0700
Message-ID: <20250806200928.3080531-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.50.1
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


