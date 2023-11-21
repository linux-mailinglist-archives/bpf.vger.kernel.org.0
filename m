Return-Path: <bpf+bounces-15486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0385C7F239A
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3521E1C21902
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF113AE3;
	Tue, 21 Nov 2023 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYl49w67"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4ACC3
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so6890174a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532447; x=1701137247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJbiS5BwiUeTJjEaAsd6jNDeKmo1OJ7cmy0nILh3kEY=;
        b=IYl49w67uUX9q4Va3GpFOcZeuo0j528gq5GAu5FIYwMjegpMWqmGHj4zktSsoHRkMQ
         x6A8OTSxc8JNRuKxYwxMyEt9b7n+oIu4CrpOH1AwPCk26f4DV6alcKSofjVEGbjI9yob
         2AaKyJ8thxUP+uQYf9LGWuepVV3dXk3Z0QYbbEvJ32/YphEWbd/Rn0AP/1ZhRDTgN+M4
         /FG7r92zz7OBbDMB8Q8L56+AM1DQtSCVKC678CX8+7FO3klj5sn+D99++YDCfZ43iT8n
         9UQ5BxWdTq+yERBWzXythX2jnhLs2x5981hyvMIz3hzVjJB7Vo30A9W3W0fhtpmT+14M
         ecMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532447; x=1701137247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJbiS5BwiUeTJjEaAsd6jNDeKmo1OJ7cmy0nILh3kEY=;
        b=xSonoRmVCDAR9MQtblQroq2UgOEoWBXw6LVNvHPivIvLb2qC2DwloZTmMMCM87CyPb
         i0m8msKSi51LDmWmoYYTzkhD+PzAqSmVJn3Kj1ApqCGiZS1ZKIScq7voePtsQ2jeYztA
         +ThrjVeAvaidU6v0eWGbaFeKgRoFOvDeCeeGZXNoVKR0me9s4tUuOL47++VaUh2JEmX0
         xC9wW8rAAuf11pcHo2GL8YZ7bZUNy0gKEbBmZYi8OQtr9n73MX3Gf8VUGfHlxxZ96Bdn
         +OZgChHTpamPRXOVEHJczVsL9ksa6GG9gYC4BPeN5NWxYoqvOGb565BE3z9rw2/1glkX
         kUqQ==
X-Gm-Message-State: AOJu0YzzBThyXlnQBeYt6NOo9ZVP9dtkTW/RXQV1w51oNzYifbplwQ9u
	xu5a1J8Xq3KGyiWoZbRsoPGBUfWUadviNw==
X-Google-Smtp-Source: AGHT+IGgtmbSv2qBEtFN1+uYnQNI3JSi8NQRgwah7oERgxKF+JYZ2976xkPhto5rfboBvjiFuEuC+Q==
X-Received: by 2002:a17:907:c71b:b0:9e6:4410:2993 with SMTP id ty27-20020a170907c71b00b009e644102993mr9212380ejc.18.1700532447477;
        Mon, 20 Nov 2023 18:07:27 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:26 -0800 (PST)
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
Subject: [PATCH bpf v4 04/11] bpf: extract __check_reg_arg() utility function
Date: Tue, 21 Nov 2023 04:06:54 +0200
Message-ID: <20231121020701.26440-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
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


