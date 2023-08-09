Return-Path: <bpf+bounces-7339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9CA775E06
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAA1281B17
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EF17FE9;
	Wed,  9 Aug 2023 11:43:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212917744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:43:05 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB31FEB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:43:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-99c10ba30afso172514366b.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581379; x=1692186179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSsvbI7ahExjrKursMU/KjRLhJR0LGF6w7wqZb7DClE=;
        b=MwnF17OxdlSApLkjGfg/tSJRCBBhJRX1+NqDHdn6EIUlBtLd8PbaraOVOHKMrEu27i
         OwqmDdgwqfElk/z2OUzwcC5TkpC9erIlHyyGbQfhg7FMDRqSXsg0eQUVu7S6/TvILDf0
         2dCFzXDabv3p7JovNA5G9ai9ly40cdgrMU/8PMPVuOaWFiqsiWahVOTwodMhDeTdKW11
         N+8knHVi+cdIhqqc9BQyl4+zSJSSgmLxPiO+6LsCLoFfOmK+wr6WeqZ+5D4T+5tBbOWA
         MIfJBGgT+99rQjp2SpB235BNCDyHztOAyXZaJaPaPVUBVfnLXQeQc6iyermXmdkztaXp
         ZSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581379; x=1692186179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSsvbI7ahExjrKursMU/KjRLhJR0LGF6w7wqZb7DClE=;
        b=M69mLceXvYK4GMZc4Vo7JR0TezI73KaC52EOXAZ9atwaOboOgLCG0Q+Xt7M9m1Yegq
         xWGrAUSrfS3/UFhUII+Kjn9LopOnnuT+OBI4S4qfGMAZuJsv11NCxkYriNdT0JGRI37T
         2FD18AKKiNqKsvmBYvtEKfsEIabd8quKRe5oK0t7j/L6aAhx3cn1ciwu2xE8MmmAI77P
         VqsG8I5MHxxCv+XaHmj4PO5gh+V7gnqHS8SQTihqrCUaJ5dfRJe4SkeyGD6G/O3giG0x
         pm4eUjNj9HSAsmYpbtUITeN2ob8zuF1hnTcTQ7k+/Lv5gtoTeWeqQybxUaLt4ecf+wbT
         uLJg==
X-Gm-Message-State: AOJu0Yw6KIxASwBZnLMwmdFBsQBM2Y8+w0mu7KV5HITo92eYxsts+Ukp
	asBT0/RNHD4rfHppA9xNe+koNi9vlCru0QFDsfk=
X-Google-Smtp-Source: AGHT+IGJRAjlSLkxcQW4atBAZZ5yzl6GRQ2guDKPMf6r+ykTHxto1dhhDM02QtkkwCxuLDNUC20log==
X-Received: by 2002:a17:907:b17:b0:99c:ae54:6654 with SMTP id h23-20020a1709070b1700b0099cae546654mr2612066ejl.14.1691581378770;
        Wed, 09 Aug 2023 04:42:58 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099cb1a2cab0sm6512869ejy.28.2023.08.09.04.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:42:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 06/14] bpf: Perform CFG walk for exception callback
Date: Wed,  9 Aug 2023 17:11:08 +0530
Message-ID: <20230809114116.3216687-7-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=memxor@gmail.com; h=from:subject; bh=LCuy1hed9QK0LVfEql4qQ5HH4jsTZAd6/XT0xD0ZFDY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rILTjNeyyjihAo6DRyCHUOgdyPQWjE58yxZ VoNZXZ9S1iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yAAKCRBM4MiGSL8R yvPKD/0TTRlAV07UMeF9+txR1RgAunci/eEnl13fQQ/uqgvNfD56PeN8yFgzLlpSASSOwiGweYA srwzC9V4xDGYhM+aiHjUEgLi1e8FnD7vcdjiyHEMy1p69wmqNOIRxazeq7wftzrZCpIx+luug3G peHzF02RZFX6CyvqMKFFEYAc+JqxiOKX3y9v8VI7VRapYn6ztZ1OpDfSq1+HRg/+09CUtwHZ2qr hpX8+VQI5A3kPT9F5l2ck/xmkS91BZb7TaHGLw5mgJyTtfEWcm5BokhbnVKRvGAmaUC/0aJ/c/s 3+fyauMLoShZJE653YBPVxn8JKWM8xaYvkWWF1Gzx++yasfiF7Fd7zpfxq5U2zeEQyqKzZ0tkYB U3ns/pod18nGFatAaSOwF0DmkxkgU1Qe8x5StNNrOUIANP3gfVAJTox+SH0lkSoII1wvb+JARbm un+MPwYnCHR+ysyI08FLdzq1LxWkwc3exM+DCn7tldwa0SlFHs1ymkTef0A9lnRJ0etO39xiLu3 +xVX0qfTIB0rE0M9tpY4MGfpwZzLCL/vbFdAxoE/1f0lRHBqR3rTxgHdvpc/JkIi0vNIqCK3AgB +td3Vw9nSdD34juN3aE54edlKTHSH18Wj+LYMp9DPlUAGO3fEuV3PL9QFF9Q1iB8lb4Eg4VLWFt +hgDg8dzBG84txg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since exception callbacks are not referenced using bpf_pseudo_func and
bpf_pseudo_call instructions, check_cfg traversal will never explore
instructions of the exception callback. Even after adding the subprog,
the program will then fail with a 'unreachable insn' error.

We thus need to begin walking from the start of the exception callback
again in check_cfg after a complete CFG traversal finishes, so as to
explore the CFG rooted at the exception callback.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9d67d0633c59..c22ba0423d27 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15029,8 +15029,8 @@ static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
 	int *insn_stack, *insn_state;
-	int ret = 0;
-	int i;
+	int ex_insn_beg, i, ret = 0;
+	bool ex_done = false;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
@@ -15046,6 +15046,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 	insn_stack[0] = 0; /* 0 is the first instruction */
 	env->cfg.cur_stack = 1;
 
+walk_cfg:
 	while (env->cfg.cur_stack > 0) {
 		int t = insn_stack[env->cfg.cur_stack - 1];
 
@@ -15072,6 +15073,16 @@ static int check_cfg(struct bpf_verifier_env *env)
 		goto err_free;
 	}
 
+	if (env->exception_callback_subprog && !ex_done) {
+		ex_insn_beg = env->subprog_info[env->exception_callback_subprog].start;
+
+		insn_state[ex_insn_beg] = DISCOVERED;
+		insn_stack[0] = ex_insn_beg;
+		env->cfg.cur_stack = 1;
+		ex_done = true;
+		goto walk_cfg;
+	}
+
 	for (i = 0; i < insn_cnt; i++) {
 		if (insn_state[i] != EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
-- 
2.41.0


