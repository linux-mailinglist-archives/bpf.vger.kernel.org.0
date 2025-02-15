Return-Path: <bpf+bounces-51657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E607A36D96
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700511896BB4
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFA1A5BB8;
	Sat, 15 Feb 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZanGhunS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954F1A2385
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617483; cv=none; b=rXpQrAxvMrHV2LcP0RDkjKTJCTokQWnMZzJY4AjQd73u7z6JKRhBc++KChgyCb3kUJI3kwHsrXb/RcysbD32MMAERPxD3DK5By3Md+5lCJ7E9fv7FRr54j8Virom83rg1dc95UyYGaBqck2ncqz6Va245Cdrpmaz07qikxtC1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617483; c=relaxed/simple;
	bh=KjcnHc5O6yZ6ppWi6UYnAuBXdE/nWJsH0bTv1HOHTik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAkZmrIWnYRyExqEedJotA7oIrDqU+zKEFAulRlvGe277RtLmFx/BW8NJSkJbrQg80pXfSIYm5RPFB3BM/AG9Jfjm9fEIwqt0DR3tGw1T2jBp+xC9/bhv58JRPR7RD3Ay2dCzoN39eaaaE4m5YMlqgOpiS1y5DoSGMHnw0MDeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZanGhunS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-221050f3f00so8520025ad.2
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617480; x=1740222280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaPZFkGYvP5xO3AbmsaBLhATdZxWoTWdvu2m54yy0IE=;
        b=ZanGhunSFN3S6MYe7zEA7pbJKeebAZWOa+btW2tWouhZkArUICpbV2ziNJ+3IWtvZA
         QbvJJbF26CeQuSMDiuPWFo01YEkAX1Y2qAzXB7WA5Z7ZuJ6kXCC/Df2aS9dbNL+3RZ3h
         N36rcoDOWp2V71VwfHDLSEWIXaCqaTrV4q0KYNYvMZT3TPimmmw1vy5RNULr2A2d2Rw4
         fz6XcWVDRGDIQoK2mPTlm1DEcqsGaYmV0KCJvjR+e+b+jc2XtvBOAbSrcrkqJKv70mgX
         VxV1q+t8zX+y79pAl0rAsDOEOPPsgt9g5wNmLBndWY9ZkpDjoB8UisqoWgGZ21Y+A2BD
         wfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617480; x=1740222280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaPZFkGYvP5xO3AbmsaBLhATdZxWoTWdvu2m54yy0IE=;
        b=qevB/cdKlAkd+AeAukFIKVrP+E4p99gxIvRvuyxDA45YBw3PKBUka1QWobVyDiZg6E
         TwlJaSoQdJcbcdMZ/Lke8XSqE2f68pgRhollRiZfji2OwoNw3kDUmhVvvnuTsnqpUELG
         C2dRg6k8/nBcQe3+Bp4g4pcJtt57hetEBrMParO7NGDNjZxK82hqUPLOkjBFPTSfXEF6
         D63aFAUMtPXSrl7AA8oYsUkjnXyF5DW5ynm88H5M8TBD8fB1AgUanlTFvc/YtINVN8eg
         PC9jrOmO92feSWd/6YAUW16g9uIiR+hjuoXl0rKtm8Um91lqrX2PIftTC/+/8WklQyR1
         +reg==
X-Gm-Message-State: AOJu0YwAZAqHPsLjCcTwZwAPc6EcXmJqC15TlNbJFzKzPBoI5ggJk99c
	Xqd6zxgenJ+sPXty/J/FOfVAQa4UFHyHnD0tkSoJq9p5X0ugKuiEqVISUA==
X-Gm-Gg: ASbGncvJa8G7o980z1nCBZghCJ4Udp6XB+No32i6oMODZJU+GQtXeC3BQSIMBu9TO60
	GFO8hu+MyHeVbQ0XxxlIYcksSGib8waMBm/iO+dSIXKAO4Q5eW84HmUnrVRECx1CogfeUkiOrnM
	L+lh7wzrZnhcVgNP9IY9TC9vajpnSJeA5qt3tnQCjyh/toBQO9Y43qeOC3wcTGQi2ePKmD/UpJT
	qmc5oZFNFHNq9aai11cib2DsThI1y3ZgGJWMFhtrPfeC058OgXRNilicf1xN6xqYxq+0X0d9QSw
	D7jPGbAFjO4=
X-Google-Smtp-Source: AGHT+IHS1L2hwnJZ0t4yRPC354bW8OH3WLRedIoGORTfHaV8io19mY2P+H+yvQkVNVe7qBTB2MU6BA==
X-Received: by 2002:a05:6a20:729f:b0:1e1:a716:316a with SMTP id adf61e73a8af0-1ee8cb5d182mr4819128637.10.1739617480457;
        Sat, 15 Feb 2025 03:04:40 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:39 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 10/10] bpf: fix env->peak_states computation
Date: Sat, 15 Feb 2025 03:04:01 -0800
Message-ID: <20250215110411.3236773-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compute env->peak_states as a maximum value of sum of
env->explored_states and env->free_list size.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f920af30eb06..bbd013c38ff9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -772,6 +772,8 @@ struct bpf_verifier_env {
 	u32 peak_states;
 	/* longest register parentage chain walked for liveness marking */
 	u32 longest_mark_read_walk;
+	u32 free_list_size;
+	u32 explored_states_size;
 	bpfptr_t fd_array;
 
 	/* bit mask to keep track of whether a register has been accessed
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eadd404ab9ab..b92d5eb47083 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1598,6 +1598,14 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	return NULL;
 }
 
+static void update_peak_states(struct bpf_verifier_env *env)
+{
+	u32 cur_states;
+
+	cur_states = env->explored_states_size + env->free_list_size;
+	env->peak_states = max(env->peak_states, cur_states);
+}
+
 static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
@@ -1659,7 +1667,7 @@ static void maybe_free_verifier_state(struct bpf_verifier_env *env,
 		list_del(&sl->node);
 		free_verifier_state(&sl->state, false);
 		kfree(sl);
-		env->peak_states--;
+		env->free_list_size--;
 		sl = loop_entry_sl;
 	}
 }
@@ -18809,6 +18817,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			sl->in_free_list = true;
 			list_del(&sl->node);
 			list_add(&sl->node, &env->free_list);
+			env->free_list_size++;
+			env->explored_states_size--;
 			maybe_free_verifier_state(env, sl);
 		}
 	}
@@ -18835,7 +18845,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
-	env->peak_states++;
+	env->explored_states_size++;
+	update_peak_states(env);
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
-- 
2.48.1


