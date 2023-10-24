Return-Path: <bpf+bounces-13076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAEF7D43AB
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E1928179E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203CB139B;
	Tue, 24 Oct 2023 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpWVB13I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9D10E5
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:09:33 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBA610A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso5910105a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106170; x=1698710970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMBXwYsElRUnbv/J2ohSLKs8sutWufCbyfqA6nV5UMw=;
        b=bpWVB13IspdynqTzFlvq9fjPn60iMiZrmbHhNyyd2gR/FV06gyEKnC1pRsrlQj3WdK
         KychS7jPpwzdpKxJrzQjjtZd0AuqBEv142vxlJ9b/tT9DlB8vPhZzdSPyNslvZ28tgs6
         EdoY5ivuvhJn7qeN7Is5/aV0osuVu36C1H94HYh8NuHw1/Y0SKjOzglOKXnr0cqTHHkx
         YGFGXalqK+sBRzQvEL+97B7IQisAaDX7Q835/ljBcn+DX0PghF5HPAAWBv5OfgwSBat0
         7jPwSJysEKtwYSiLChOJv+41MYj7PPsSUgtnMNu9vW8hKiqAxyy/5j9YdH9MtJqGhzJY
         Hw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106170; x=1698710970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMBXwYsElRUnbv/J2ohSLKs8sutWufCbyfqA6nV5UMw=;
        b=STyMJbO5C+SndWYBkJPXlaAU5CO2C7GM44vfIAUfPu549oGx5dVw4ImlJYrq2FjsL6
         pqnufYGbfYDUSX9Y6xgZHrZbF/Of7i8sQs4z4TgYNYPeofFrNn7pi/7wpfAbEe06kX/6
         gIIwlaiwBy4g/sEyhYlDifIeT8G6DMRxP9UvaopGPNPiuOZUvDpNYccOOVz8Z54WXoL3
         THLaU6rLwKDlJyLASrqwqihg7zrK5EGrFoNuJfRtAAJUw8vhaGcjYSjt+6ma8Ei6/FJ4
         +LJsfL+MHaq2g8GpnMFCgQPhTRPUg1oVv0tkU6ZhQ9NI1+cN4qbe9/Ec+Zv5BT/93qN6
         8KPg==
X-Gm-Message-State: AOJu0Yw0mRzhtYCXxenEMbadkQ6pYiW+Z3MmMZIwdSnzItxxBLe0K19b
	4CCX6rMV0cu10ZQlAbEDc9f0SkkAVtIHKDpy
X-Google-Smtp-Source: AGHT+IGQwHH+6bWaZsklPukLOh/ub529fmxCoQ594vwwXjbrYcrqcwSQFlMTpRFYrCvTSmNOV7O+JA==
X-Received: by 2002:a17:906:6a0e:b0:9be:45b3:1c3d with SMTP id qw14-20020a1709066a0e00b009be45b31c3dmr6860949ejc.48.1698106170258;
        Mon, 23 Oct 2023 17:09:30 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm7264516ejw.158.2023.10.23.17.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:09:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/7] bpf: move explored_state() closer to the beginning of verifier.c
Date: Tue, 24 Oct 2023 03:09:11 +0300
Message-ID: <20231024000917.12153-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024000917.12153-1-eddyz87@gmail.com>
References: <20231024000917.12153-1-eddyz87@gmail.com>
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


