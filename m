Return-Path: <bpf+bounces-58895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5670AC3107
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436C9189B590
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA01EF37C;
	Sat, 24 May 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGBr5i4q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F11C84DE
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114392; cv=none; b=EQGclIk4JP4vfcpqOUgUqdISSRV0lX8mYMJ3RuDLgJvf5y0jsAmIUO4zjQPoc0FVj5RVm9+u+Hnqyxz75gAZ1nsdzDslg2n5bpWbCrsdMrsasAwbBDXZbcwFZ8Nq2fbkd3ySUzc9tZHvxvorVhcgZmlweT1r3s5Q6F3ayEuZrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114392; c=relaxed/simple;
	bh=JQNOSxDqmGewI1f0fWmhMu5/TBSBpX5s0pkoGxqk9cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4kb/Lk+HPxgnW7PYqAo1j13SqpyBaBerpul/yniTI2+30/sOHWDGUlcGQp+7Ift0dJzXBcLW25CpqnoEArayIQqMDQFsF7q4RJhliqjR6qOZizAOD6CdhkPZoZh3YPDnh/Vo4ltnrwOJT9NLsyaswcHVbJfWsTEY7RRwX6W9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGBr5i4q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c5f3456fso786218b3a.0
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114390; x=1748719190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r5uDYkiDw5wEDukU7LO2lcsuEEFsFNNwNP5JvQmFWE=;
        b=eGBr5i4qdyhyP/HPkr8R7EeLsMSdwhnHm6G2R6ycNcvc/V2jua0qbW+BscmwFpESVH
         AncXmdzx84+/X5YWXuoRKDjWzEtIDxuPNODbHhu/OYUg4OuFpU106nvNMFu4whtuGppR
         qq0trljcy7WKX3XGN7/HS4oZzuUM0R0QIqdCk3RMj3PIizUoWbzXuy+64ki0DTG8Osfl
         TBBGbH/3dRgY2WMhekUdmMciMZ/8IUxbpF+UvcTfVY7/B8kvYHh2KXru3piKXIfKaKe8
         DXMIXNJ0b87P9LgLjTZRj9AydttaR7mqb51C9Ret0wHXpKhs6gW1KNY9DEtwKhHQaY4l
         ayIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114390; x=1748719190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r5uDYkiDw5wEDukU7LO2lcsuEEFsFNNwNP5JvQmFWE=;
        b=vcrpC3hSdnSHLLVvUkJyV1u9WfjMwXxY52uEGI0snOJXVauN9QWqQBV0TpQP3Leg3X
         Bxd8WKEIyPT3W+ofMzlrz4+TzkgcF2BvTMDCgB7WOwIBpGRItyLNdxca06E2FhX9D0Fg
         HyAWO4wrB+94kDtBZ8xt25r9hJDAllF6DkrzIs1J3MVnPXNnmMkCIuJnbE60mPC2nlVF
         6xVk7Dz1C900nILWFP0o1r5wN2yT+Kxpe/xAJMYe1a1zYEsnFTNbZfVDVBQZv7CtmHMp
         Aa96cRUDQPZSSuzAagtIJzJRgvCFzB6362EAtvkTZRB1+pFm4JTRDEqQT0QkdCGSV75X
         faog==
X-Gm-Message-State: AOJu0YxhyJm7Ng1kQasU1T1DBgn31pJwW69E51gj2mwSxAYmEP4TJ/dG
	+wZHqkt2SkpyWbVzl+7b5Wn8amW0xsitEg/ALWXVy5+vzJuUXNvVcHi8io9wlGDg
X-Gm-Gg: ASbGncvpaoUS384CYhnTo5Kx+OudT16fTuHhh057sdhqhkc/RFon8+w7yRqRPadx2YN
	F/1CLeiNIMCHBKks7WhXhceQ87qVpUL45kHzCgLKIzHDnf+vNK/+OcB7Z+xvbZVOLzwV8EBKREW
	DOeIkycVjEojEnWaPBEoeznU6OS6A5O2fkywy5k2Lz6xqqC5B1emYFyMfBef+RAujyLQies1+/d
	e0EKWyqgjFDKhz5Av/VgdWS8Iwt4vGz61FOKeuRefu7EtRyTCk4QgYS4AJrD0R6vM8sid/5TKc7
	uGXMBPWrpKTDoc/1PChVB5471OvPqG2BJqWPVZvgrOdhN+g=
X-Google-Smtp-Source: AGHT+IHXmgl0G1vEe6y0TBkKQJT3RE0CsufA3i3jUyfufjHlLLKDv2fcKXTrxoD3USXIuzBTgqTCfQ==
X-Received: by 2002:a05:6a00:140f:b0:742:a0c8:b5cd with SMTP id d2e1a72fcca58-745fe035e53mr5791264b3a.19.1748114390496;
        Sat, 24 May 2025 12:19:50 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 03/11] bpf: frame_insn_idx() utility function
Date: Sat, 24 May 2025 12:19:24 -0700
Message-ID: <20250524191932.389444-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A function to return IP for a given frame in a call stack of a state.
Will be used by a next patch.

The `state->insn_idx = env->insn_idx;` assignment in the do_check()
allows to use frame_insn_idx with env->cur_state.
At the moment bpf_verifier_state->insn_idx is set when new cached
state is added in is_state_visited() and accessed only in the contexts
when the state is already in the cache. Hence this assignment does not
change verifier behaviour.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 23c7136ab6ae..13bbe63dab00 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1963,6 +1963,14 @@ static void update_loop_entry(struct bpf_verifier_env *env,
 	}
 }
 
+/* Return IP for a given frame in a call stack */
+static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+{
+	return frame == st->curframe
+	       ? st->insn_idx
+	       : st->frame[frame + 1]->callsite;
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
@@ -18765,9 +18773,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	 * and all frame states need to be equivalent
 	 */
 	for (i = 0; i <= old->curframe; i++) {
-		insn_idx = i == old->curframe
-			   ? env->insn_idx
-			   : old->frame[i + 1]->callsite;
+		insn_idx = frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
@@ -19460,6 +19466,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		state->last_insn_idx = env->prev_insn_idx;
+		state->insn_idx = env->insn_idx;
 
 		if (is_prune_point(env, env->insn_idx)) {
 			err = is_state_visited(env, env->insn_idx);
-- 
2.48.1


