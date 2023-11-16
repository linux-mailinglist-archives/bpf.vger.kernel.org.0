Return-Path: <bpf+bounces-15137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7687ED931
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACE71C209E4
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AE53A8;
	Thu, 16 Nov 2023 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deaKj7Ud"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFAA8E
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c3aec5f326so300700266b.1
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101115; x=1700705915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLRhKijTuooDK1FzcypZdlDlO9RLr9QHa9Z+7Zr+Jlw=;
        b=deaKj7UdUnt8cqoffu7937A1bEI6B3gS73bhQvxoIhMZ3QnRLeqA6lrrjdunq/TZx2
         ruQUuYPldP7OyUlO9rYr5F10HBMR+K7E2NNlnxHVzTpQ5qDc8l9O2Q1JlfkCbK8xjb2q
         aOOq7xd5Y6ko4QzYM5s8U4Z0ocN5gOj070x3KUNR/qWU2OlSS5hEVO8YkSSHeq4F0JVK
         Skibjxqrsx5R+HqYcC6HMDQSMwn9gyCRHuDOvhyeSfO6DkDptnVclsH7+tHgKPaCMDBh
         iLmIkh5WJgrcNlO9tafsUnlKdJht1u1G5YjJO6RAMaEB3E0IF2Edfheo+igot6zqt1uA
         CNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101115; x=1700705915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLRhKijTuooDK1FzcypZdlDlO9RLr9QHa9Z+7Zr+Jlw=;
        b=qpdfuREv6PQXFtD7PalCAUU0f0yCMKD2JPqR1p6iyD7fdAv1h1EJfXiz9jhkSqiRgo
         JTC9CdNAuN62etJGxRzyjiT0UhMvW9jg3yOl8CkbZ785lREG00jLWdizU/QfzX3YDidK
         OpFuMgc40wkTO9Q+oswHL4TBXbHDzoadvB8E10gYwawR1J++xdWB0DrVHT+5seTrRGki
         1TBkRwOKr2sg797a7Qx2NagQEW2GymH3VCZQOdrnHFN6k2LmJSbpdUuOAXh9S5n84pa1
         1BOI7K/d9TGb3ugNRDI3Bgm2fk7gg/U7BUw6nwl//xskpUkoRWaGfpoWvKqCZXFkfsRT
         PjvQ==
X-Gm-Message-State: AOJu0YxJIfjV2heb0VvqZcnrAF9yW9oAsdU0oqCtgWpMKM7l035zWIMH
	E/AA4fED9xNU/eRbciJ3mVZx4/ysLfczKQ==
X-Google-Smtp-Source: AGHT+IEBbZh3mEfOmX560kQbZ2PhScTs9EKfWay3hGIeLa+NkTIs1FyL7qnBfoYhhjo0tAmsfXRJJA==
X-Received: by 2002:a17:906:8411:b0:9e8:2820:eec8 with SMTP id n17-20020a170906841100b009e82820eec8mr278623ejx.35.1700101115026;
        Wed, 15 Nov 2023 18:18:35 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:34 -0800 (PST)
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
Subject: [PATCH bpf 04/12] bpf: extract __check_reg_arg() utility function
Date: Thu, 16 Nov 2023 04:17:55 +0200
Message-ID: <20231116021803.9982-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9ae6eae13471..0576fc1ddc4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3580,13 +3580,11 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
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
@@ -3627,6 +3625,15 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
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
@@ -9522,7 +9529,7 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		__check_reg_arg(env, regs, caller_saved[i], DST_OP_NO_MARK);
 	}
 }
 
-- 
2.42.0


