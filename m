Return-Path: <bpf+bounces-79060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349BD252BB
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92666300A7B5
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9C3AA19E;
	Thu, 15 Jan 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUzrk1ab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF953A9DA1
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489466; cv=none; b=N9+h0R6PlZ0qq3jJJqUAd37z7fehFajaR1R6Q/yrbIZWIYUguv0RZ0f0a9wmXThgZ8M0gAXPrY9z13xv23qDRNR9kWwXNFhwouBJ8lU+3AqP8/vpTzfY/Nl/ZULwBhdYW+iWNLfDCTxtZJmOr/7hHEYJdkVxZiE/fKm3LsoThGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489466; c=relaxed/simple;
	bh=gohZgJ3UzhdeCz3r8nYsKbGc+x6zYf73Hq3q96clfMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E2raZR1yqAWRTrXLvRYL6qGq1B6iJjbXUXwmjNSKYF+B7kY7yLcegAOL3JffvCxza8PziE3v14rmqk18KAxiaRCdTWb7lPzBgwS8BdQG1VYWaYWjMH3hEW+xi/BiyOWWa4Q39Xu9YjW0mzZBGYkqbkCSmsAkzoqaPM1aobntYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUzrk1ab; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12339e2e2c1so654605c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489459; x=1769094259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eehhj16F++hI4m+1Pleke9yunTvqMtKyr82Xytjlo0s=;
        b=dUzrk1abWu56ydbn8WEtumCRSA7WHmp4biYjA0RkW/PC9CJEsza3P+BkYTaeWVUKff
         zRYQm9vizxR1dxbDRNW2a7kyvTcswnEI9Hd4rsbxLRNLEsKopgoRipNqRSAHi5QBs3aV
         Hb51igT9f8KoK8g13Orc2JRyaFqdTRPkSi+GO5vv6Ax9/nsA2HacDt8VUj1pnhTTpmmi
         zSsv9RewKNEt63ngrFcRWL5pUmObVo+fDMDbWVoDErKfpewJ/0zjCvVjWclhDNmAOeJt
         3ceW9FFn8E1d3uCszv9zIWUldnWuutUKUooFVOBd5w5boAmJ3/GP+gICq9YbMPdatBnU
         f1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489459; x=1769094259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eehhj16F++hI4m+1Pleke9yunTvqMtKyr82Xytjlo0s=;
        b=i8onNCQNAIvVQ9c/EWz5LKaCy8hKo8GWilioZKe6R1vQILYx2Nba8MmFjsZ6YWqiDh
         uxiFlPs8Fd9gJ8fmnaExh7FitQd8ZbFxmF9dMquRVoKi5GM30v/lsxAsRGzfY3qR3bF8
         SBmAjfgHPL4sf4zNsm6H/A0gex9HTZhTB7K4tItIm+pa49swmvtK8oU+l49UBaKAk2Fb
         mMKXws24cMcMNL4IxsMX9eBFMEQ40wdVFDjeKBKZv1XJQiyfa4qT/w+eO+4xYkuqx+Gk
         lAzbrljx4da9wDC1F6e+XEZ/fJXlevxS3ohIhc9A9fl/MUMypSPCbriQ+IMLN9glsxer
         TMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg3jQHWlAwJcYTN5GhCl3PNT98VxyTlwwHbDIWU14NC75aJXELP/zIlfQvkVO3U4YOQtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22mkAGTrQdDjR3YrtO+IqBd7c8tzdFsCykSyWt4nQZE8yWSMU
	oWpBSwzf4Dy1UdeNAU38zhU5V+8sepEoD/ysX6BbDJB7MdYa4LRGg2p4
X-Gm-Gg: AY/fxX4Un8DsPB/kXs8WVun4wd2xXuNg+i8OYUOvjzNJ48jDfyy/FhWA1Oz+mvE7aBB
	DqzYWVnplkQ83l4kON3/7c3vnTtd4alEs60gLAkopq+diHVRfnpkzQWeN7mCK5xY+st7tuWARBu
	f43c3vXWRo+vD+ZC0rRGmwoSKzuEADZf9qSqEb6RSwwM0zXjlaMEcazAsllTwERRm/yDrwq9444
	hpMFNDE/fbWz4QeRSj8MdyJc5aFTp/nZWXEpIJq87s1kN05qpbng2jiy3/vrRpV55Ud6QVfmcJ8
	sclZTx9CNxh7fYmknmQvVSqFG60Hgwps/T+d55Imn2tVZY9+02hejs+urtim6AFvkJLSR47cwez
	kiV5B3sq+ppWH5RmCryNmhvMrm8pr1uF1ESyVopxZEGto692HBdP2lrFcRJNgQFUknSf3U2bf/5
	mi/vAmyIuMf/lMsy3bBqHAa1U=
X-Received: by 2002:a05:7022:f512:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-1233d060fa8mr2315202c88.19.1768489457287;
        Thu, 15 Jan 2026 07:04:17 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm34342659c88.2.2026.01.15.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:04:16 -0800 (PST)
From: wujing <realwujing@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@gmail.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] bpf/verifier: optimize precision backtracking by skipping precise bits
Date: Thu, 15 Jan 2026 23:04:05 +0800
Message-Id: <20260115150405.443581-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backtracking is one of the most expensive parts of the verifier. When
marking precision, currently the verifier always triggers the full
__mark_chain_precision even if the target register or stack slot is
already marked as precise.

Since a precise mark in a state implies that all necessary ancestors
have already been backtracked and marked accordingly, we can safely
skip the backtracking process if the bit is already set.

This patch implements early exit logic in:
1. mark_chain_precision: Check if the register is already precise.
2. propagate_precision: Skip registers and stack slots that are already
   precise in the current state when propagating from an old state.

This significantly reduces redundant backtracking in complex BPF
programs with frequent state pruning and merges.

Signed-off-by: wujing <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/bpf/verifier.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6220dde41107..378341e1177f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4927,6 +4927,14 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
+	struct bpf_reg_state *reg;
+
+	if (regno >= 0) {
+		reg = &env->cur_state->frame[env->cur_state->curframe]->regs[regno];
+		if (reg->precise)
+			return 0;
+	}
+
 	return __mark_chain_precision(env, env->cur_state, regno, NULL);
 }
 
@@ -19527,19 +19535,23 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			       struct bpf_verifier_state *cur,
 			       bool *changed)
 {
-	struct bpf_reg_state *state_reg;
-	struct bpf_func_state *state;
+	struct bpf_reg_state *state_reg, *cur_reg;
+	struct bpf_func_state *state, *cur_state;
 	int i, err = 0, fr;
 	bool first;
 
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
+		cur_state = cur->frame[fr];
 		state_reg = state->regs;
 		first = true;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
 			    !state_reg->precise)
 				continue;
+			cur_reg = &cur_state->regs[i];
+			if (cur_reg->precise)
+				continue;
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				if (first)
 					verbose(env, "frame %d: propagating r%d", fr, i);
@@ -19557,6 +19569,9 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			if (state_reg->type != SCALAR_VALUE ||
 			    !state_reg->precise)
 				continue;
+			cur_reg = &cur_state->stack[i].spilled_ptr;
+			if (cur_reg->precise)
+				continue;
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				if (first)
 					verbose(env, "frame %d: propagating fp%d",
-- 
2.39.5


