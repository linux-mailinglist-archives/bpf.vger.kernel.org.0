Return-Path: <bpf+bounces-9831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3E79DCAF
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F19281F37
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F214F81;
	Tue, 12 Sep 2023 23:32:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE001429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:23 +0000 (UTC)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3720310FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 38308e7fff4ca-2bfb1167277so9828191fa.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561541; x=1695166341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6fOZXSAiZjm2cSMS2cSkgEH3WnXEVvnoYLQHmSdkEw=;
        b=FX2IXR1mgJSexOYP8d1N0iCT87w8vgnsS9tKFxvma+2b9vNL++NVmak7A4Ssg6D8RP
         ZihGOT9Uy5dEj4YyhEFFZ+EM1qYdiqdyhKAx7zeqX4xDQGnKUy5gm90gLIsXwUyNZpQ1
         wMjLEMW0fsktwFpB69kte6/yVqql4qjZjZH1f17h7uizyRiqKoZWKiBin8dTqnunsh46
         y0Ighm+kdsl42MeQ1usIksXWOcLEUxH24TvqChegZvyZM9Nnr8/t7BnANuWDY5qo8db2
         Bx24/XJT5f9MeEBetVrSEFLcknCvwCOLssITeKtJ6BelaRF5czn9mQ/p0AfBGJhnqv49
         TqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561541; x=1695166341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6fOZXSAiZjm2cSMS2cSkgEH3WnXEVvnoYLQHmSdkEw=;
        b=Y45E/v8f9N6iEJrLDYN7iTJFtcjdCngfAdNITHXH4jC/sWV6JOnBQiSuE1Zf/XSPam
         NbDpxTjHsROOWgXfpb82oOPZDIYJ1peY7vyIf/HtkAz9PcJd5PC3+75X1uvgOAQJT2G2
         tDcX2YSUp6HO4AkLwp2MJl95MPlTbTgNnBEHluhDtLNtZagddKVNT5toH5mk6whhi9vB
         sVK6MLwlVR/sXPdBZfXSpghgJlZbmSObLoWExpfVBced67Se4MP3raXuKr1R2dxt+OhQ
         CI5rITGfqmi/pecpQaMJWEX+XP20Quu4S07Q0x/Eycd+nlrcIuXOkrUt6RgbzBYUctqh
         P2Yg==
X-Gm-Message-State: AOJu0YwmKQVBVhVlL/TIZRsFWFuO3pxcP9vTa2AwFAJWB8gXIz/z4X0j
	4v96sXE08t68Iyb2VhVUFxI0Z2HCuo0fDA==
X-Google-Smtp-Source: AGHT+IECRtOEGE6Pc4SrptqysMKVfxW4SXncDzXfaMr18UQjetnzVOj3yQA29KotoHZLMLW8H5xPMw==
X-Received: by 2002:a2e:8206:0:b0:2b9:ee3e:2412 with SMTP id w6-20020a2e8206000000b002b9ee3e2412mr923831ljg.22.1694561541217;
        Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b0098951bb4dc3sm7446788ejb.184.2023.09.12.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 07/17] bpf: Perform CFG walk for exception callback
Date: Wed, 13 Sep 2023 01:32:04 +0200
Message-ID: <20230912233214.1518551-8-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=memxor@gmail.com; h=from:subject; bh=KMEC7C7g+3JkHUGpCQErdFOWVieZ1zfyS4CL+h7sjbw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPStFiDWp5kvthNHypcBbyK+NuFN02qSh4BXx oi/B9OqD1uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R yqdzD/4vQmvKR2caqfDxCdUhOpuWr03ecOG+K5gkL9Lrk0IJ8fHHYzKR0r26E6D2EODlxC0aNlF uWWkFhDaFppbgRVw4lREov7qksVtG0cVGij+Hjg1VWw/yVD9ebQanP3IcdHAQhJu/LqsxVNyHXp PLQIaDrYBsiRwQG4Lsthn7xZcmxN66EN0gn1kDmnKiNJAiMk6h9+IANwKHnbPyC3JNqvofDInDq o+QVra8QRPCyZvqoE1/ucxQyG1O+WFNLxDMEtAb7g522nP+p7TLaVH3JYCfT9oCGPjLEi1ABTNU de/RRxOyf6Gczmy8ZR5tFebC2+TqR1j42SAYZ4yapYBkK/0cL0Kr3ZeWkCFaPe6GxzY/kziwvvz aI/PGGsFjWEAqsmb0Zi2BvX4wSu4M93/rFi/c2FXaHpRXTSWUw5m1stho5nIJ1/cE8yRwi9Iozj HYkPfYKT1DTx1oKWsFXCf6k/qGpq2xedj00Y6kED7sXhfTLphbSwEVbVrcbPWHpjBMDi5MRV2I7 SQhpo6S5bUkt78FwdUtIK/qJUfJDWbvf0rwaBcvQ0/TYUUl6lry/D1JXk2crARZVHfKMJ0+guj/ Qs7EDYJGO00OfkVhz36ULg044eh6+TLp57GiUq4uwFe3NyFlvDgepaVaRv8lFB+nGwwGMRVj9fw FGhGSRo0YOF26Gw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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
index ec3f22312516..863e4e6c4616 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15126,8 +15126,8 @@ static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
 	int *insn_stack, *insn_state;
-	int ret = 0;
-	int i;
+	int ex_insn_beg, i, ret = 0;
+	bool ex_done = false;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
@@ -15143,6 +15143,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 	insn_stack[0] = 0; /* 0 is the first instruction */
 	env->cfg.cur_stack = 1;
 
+walk_cfg:
 	while (env->cfg.cur_stack > 0) {
 		int t = insn_stack[env->cfg.cur_stack - 1];
 
@@ -15169,6 +15170,16 @@ static int check_cfg(struct bpf_verifier_env *env)
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


