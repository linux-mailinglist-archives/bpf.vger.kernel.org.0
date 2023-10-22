Return-Path: <bpf+bounces-12908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8C7D2094
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD92817FC
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4281D;
	Sun, 22 Oct 2023 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVqkVxMA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C77F2
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 01:08:48 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBCD52
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso310315566b.1
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697936925; x=1698541725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMBXwYsElRUnbv/J2ohSLKs8sutWufCbyfqA6nV5UMw=;
        b=ZVqkVxMAP+neZM4FB8T89dIl7YFQBiyVGE8/iqtv9QozGNaWlp5f5efLMAUYsKw9or
         J1esj4pMw5g/tnMnl5VkCWfOBb+Fzwm+238L4yWnqmDFTykvPsvbKMtgzp5aXJEt5OzG
         y/GEuJhv6ZznDN2p6OTR6eSE/K+EpeWChI9SDgayAakLTzYVvqFOd9zaMheZyfKJzfln
         ytgIVg0NaNo49pfrlpKnFqEoQ2Ofc5x62v1CF1l3+h+may1hfxmuTfNoAfqGfnN60B+H
         jVpQK0nbC4MrnTzlJ2yBrBCP+3aYM077a4wCrfd+VWrzk4ArW6cd2/GS1CYczsyg/Tii
         PlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697936925; x=1698541725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMBXwYsElRUnbv/J2ohSLKs8sutWufCbyfqA6nV5UMw=;
        b=NPjgX5XzZT9nxnnNIotNSKqfpgheXNW8NtyXA4YE4FUOxEVYropFGcMA/0ezR/mON8
         AQ3g7slCtN4k3JyL4Ir7lA9vvF7E6L38AQEWBKWclTYMkyfhYnYVRO0ycUcMZYC5gsec
         isjNOJfShdC9dCoCY1FrWmyKP4Vp4bCmQSdGxKofRGkxmqKPrcdsdd2PKO2qHBzmPEn3
         sH8EFhlMLamIJ2zwBIKpgtV681UOdw3nsPMaDUiYghZk9B1Wz28YcVvJ/yAxvsaz2DLk
         hK9CCJZgRaKacSTQq47Ardu07xLrI9eqvdSeR/QJ+wELAiJMLt5/zK6M0SGbwWiSdyov
         yMNA==
X-Gm-Message-State: AOJu0Yzttg4kP3wBUAtuNDbaoY5dNWGnk5p3L92BdiQ/7jzOGL1yVhQ9
	dc+K6FILxteSF4RVw7lmAwsZ8ic8A+PI7qk9
X-Google-Smtp-Source: AGHT+IEn2x9um90ptJ5pDdaNA0QMHIVfc1L67oPw6dDi9mcjyunhbPI1fnU4Gq18gnexBoVazs0A7w==
X-Received: by 2002:a17:907:da3:b0:9c6:7ec2:e14e with SMTP id go35-20020a1709070da300b009c67ec2e14emr5064686ejc.50.1697936925157;
        Sat, 21 Oct 2023 18:08:45 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906655000b009c3f1b3e988sm4276143ejn.90.2023.10.21.18.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 18:08:44 -0700 (PDT)
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
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/7] bpf: move explored_state() closer to the beginning of verifier.c
Date: Sun, 22 Oct 2023 04:08:06 +0300
Message-ID: <20231022010812.9201-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022010812.9201-1-eddyz87@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsequent patches would make use of explored_state() function.
Move it up to avoid adding unnecessary prototype.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9bc5d4a25a1..e6232b5d3964 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1817,6 +1817,19 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	return 0;
 }
 
+static u32 state_htab_size(struct bpf_verifier_env *env)
+{
+	return env->prog->len;
+}
+
+static struct bpf_verifier_state_list **explored_state(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_func_state *state = cur->frame[cur->curframe];
+
+	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	while (st) {
@@ -15020,21 +15033,6 @@ enum {
 	BRANCH = 2,
 };
 
-static u32 state_htab_size(struct bpf_verifier_env *env)
-{
-	return env->prog->len;
-}
-
-static struct bpf_verifier_state_list **explored_state(
-					struct bpf_verifier_env *env,
-					int idx)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-	struct bpf_func_state *state = cur->frame[cur->curframe];
-
-	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
-}
-
 static void mark_prune_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].prune_point = true;
-- 
2.42.0


