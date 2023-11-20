Return-Path: <bpf+bounces-15443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEF7F2113
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863EF1C216CD
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B93AC28;
	Mon, 20 Nov 2023 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlVkgm07"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC548C4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a0039ea30e0so139585166b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521207; x=1701126007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJbiS5BwiUeTJjEaAsd6jNDeKmo1OJ7cmy0nILh3kEY=;
        b=FlVkgm07sQ6Ssg7pnD5MKQO3680ROyA+GmTLYcoVJVz6acDZ5DAt1MV8JfyhI05KyL
         PZnTMt+bGycqPWv7SatmXf9mTC4afsZFWeoOinC6cCDLCD5LX/IkxEz534PBN6Ob2rFL
         kEbAvRRNGrLr03ijxS98xB1w1OMEUaND44MCda2zVBvu2X0iyfPSiPRbgSjzp548tBm6
         lDBUOMJI4p1y0h7kTnZKwzTvrLWXK4gRdoKNEGnguHxf3+osijk4508LxmtpWs+/y+mJ
         0IX1Y6ljf/jmA0Qp8tKoMV+Ol2QN+S/Oi0LfSRTkUhSDndeQe2LI4diKqvK7mKbjKubS
         YF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521207; x=1701126007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJbiS5BwiUeTJjEaAsd6jNDeKmo1OJ7cmy0nILh3kEY=;
        b=qd5qIQRP7OS7N3iOCHYR5Dz8VUQIyuOnYMi+Tz1qN9Ja3tLZxhrcJaKF5ggOLpY4oc
         eyqJlbdWPKT3yd6r1TwQ0jnjklFY4oXxijJ5Cl42dJnZb4QGU9tIbAgvts1fCS4Hk1q2
         IZUKa5bXT9FVGY+lRVic3nlGph8/flqbjw2XAnay0E8kSb54tgvcSNbN+PzwtDqIdz5L
         BKMQLSoJI0D8ZSB1gW6pHyvIOfxCvWRMMtEX7W43utOzC7c6HPrlO64INMJnJzFeAIPB
         Ph0ztJzG/tMtDfi1q3Rw5tIrhsTKseVweMecXenW0IFta5gCtPmyz34WyaQyXPFuBHHT
         y0IQ==
X-Gm-Message-State: AOJu0YypbSJgP5kvXd2VmYx43Jc0wqSvQjMJ/27EyntwWPwn2H5a/UW9
	qZpOKtoUs6pNRF8IOxbi6IS82GB8HYxYrQ==
X-Google-Smtp-Source: AGHT+IEME8vfKPxf/vd9benCX5cCeUprMjT9vGTZ3DRQudzjF8xdkILJ80AFzwrkhVbsGrU6YJ0Sww==
X-Received: by 2002:a17:907:d043:b0:9e3:f24d:5496 with SMTP id vb3-20020a170907d04300b009e3f24d5496mr9219735ejc.28.1700521206633;
        Mon, 20 Nov 2023 15:00:06 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:04 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v3 04/11] bpf: extract __check_reg_arg() utility function
Date: Tue, 21 Nov 2023 00:59:38 +0200
Message-ID: <20231120225945.11741-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120225945.11741-1-eddyz87@gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split check_reg_arg() into two utility functions:
- check_reg_arg() operating on registers from current verifier state;
- __check_reg_arg() operating on a specific set of registers passed as
  a parameter;

The __check_reg_arg() function would be used by a follow-up change for
callbacks handling.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6da370a047fe..e6e1bcfe00f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3439,13 +3439,11 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
 	reg->subreg_def = DEF_NOT_SUBREG;
 }
 
-static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
-			 enum reg_arg_type t)
+static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
+			   enum reg_arg_type t)
 {
-	struct bpf_verifier_state *vstate = env->cur_state;
-	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
-	struct bpf_reg_state *reg, *regs = state->regs;
+	struct bpf_reg_state *reg;
 	bool rw64;
 
 	if (regno >= MAX_BPF_REG) {
@@ -3486,6 +3484,15 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
+			 enum reg_arg_type t)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+
+	return __check_reg_arg(env, state->regs, regno, t);
+}
+
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jmp_point = true;
@@ -9350,7 +9357,7 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		__check_reg_arg(env, regs, caller_saved[i], DST_OP_NO_MARK);
 	}
 }
 
-- 
2.42.1


