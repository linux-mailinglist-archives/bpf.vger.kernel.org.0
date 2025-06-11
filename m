Return-Path: <bpf+bounces-60377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474BAD5FD8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE157A41A8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807E2BDC1C;
	Wed, 11 Jun 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYbfs5Xe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC972882A1
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672541; cv=none; b=Yif3vyu6G40go0E5wfygsj3OuPsgsO6+RSqaZ9IOf0Y+Mrl3j8+QlPc4nuVTWM/TS9FSgneoBkNUbTsNM4ez8sBs2avMamJFdX7SkDqpaqF0CavUhGwojqTV4gy0P5z1F6/Cj7/O/OfPAVC4BU7fw2BVfWDTdsZPoBXZpKVEHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672541; c=relaxed/simple;
	bh=CxPHR/OkQppN0R5QQ//2yJo5KgIKjvXF1+OoJsbKjvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2bcLNhwrbRS4evREiUeOsEn67sC1vR4X/2ISmDR6OwwviKJ+49idFXtUCdDR58pv8/VEy+etBo00fjFRHRiOun8KelMhAWeOicAbC+SDatm9MWYpQ5v6w2PtM6FJ/brd0RQV5Q9L+B5ex4Vv38L0qNtL+DuUa2bV2xzSt5hh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYbfs5Xe; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e812ed38d02so199306276.0
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672538; x=1750277338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxhSgEH74NpllEJszHNfUM2SPLzzfQM6QLfkBezvhZs=;
        b=BYbfs5XecEuuFSGe1J6Sf/Xp+/W/K6KkfdeYjxl0GNxUVnlsyQ/2m04bKpGb59X1E6
         ps9LyQhMDMTRXeTC5GrglL5x1FBUcZX7OvhK3jvvtjK3ZE2LtrGbJre0OxbVTBw0VIOk
         v+OYr7xhNxRYk2RTFPV3OxyOQMcWJ4FVl/OVjYZZiZwa0LJMHBemq5jT2Ya2qRRXXIf3
         rLHg/SoLHQh2eFO559olulFHy02AzLPEAEDEuN2P9sNSFKhVKkYV2dO1UsBd7AS71lIa
         WQ+gppZ/CI9pE5at6fmMdoKg4lqgKGaiJIgrA+Ctf4BHspnlJhLvRiGYRv/t471JPKp8
         OHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672538; x=1750277338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxhSgEH74NpllEJszHNfUM2SPLzzfQM6QLfkBezvhZs=;
        b=ubksuenM6O4O4fTnUdbwr3zsynZmBWNKf0r2EG8cp62lDbtwvROO0w/MnBz+eTxWx4
         i9sFJqiQU8hPjng7ccXpZKNZq+SIJPRL13BqSMmYuWC9/k4b8qWpGu8inBANS50AyA9L
         gyV0nP+QVwzFPVRWyJSWGj3fbDxjd7BbnJu2DgVfKu+WNn3W8i9jYdhZXWPrCsHNW/N4
         VqVLlLALocqmiQb4WATsRKSps04WMFE0MBWSe2Wx7FgJ5NGN8Bs8FeNpFk/zki1nIvOl
         afTQiw0mUVjhBNVqdVLR5ZNIcp4hZye6z2ys2M0YypQgD/PtN1Yp8G9cEXZFe6bQ8Ut4
         /Ycg==
X-Gm-Message-State: AOJu0YzB2jizFsixsOkfQZo+KF+jmOo+rFm0eEzR2JFZpNZJvaCAy9FA
	l4r/ZLgzODq2jmmxlnpsY0xjxCcRg7sSsqIF9kyLIiAoib9Bj8aWAu+min6QLWlk
X-Gm-Gg: ASbGncuskzpW2YQ/662hrENg5+eNZj8j3oujeiisEpblIufzzQ8HG4yPUXeFOYbVsCI
	xlarfr1b8YukfFCktZhOpIJqEmFI59zqKcwOFcBEnAnTANC6PXiG49YbpLugboMklQLWWaaEXHK
	CN7gvwgrBfTzKJj3ExYuSBBrjACs7NkKnTxi1cY+poKZBTyeJnO5pZOItxTmM4P8J9iO2TvGZts
	LyRr69/4aeJUxeNP3dqLITgxXUtKAxUaEl/x5wKvTrWFlmZ6PLW4WErSDjTXE3B+51antJQckaf
	em5DCzhtD67u7u2y9lCJzUrh9ZSeKYpqCxe6d4H/AOM53955sPWcEQ==
X-Google-Smtp-Source: AGHT+IE/FFobV7p3CrVyXHJO3XayhZmPsd4ju/NPtmr6/Qj4XF8SpF2pfjg19iDoaF4DZOcJp1j4jQ==
X-Received: by 2002:a05:690c:60c1:b0:70e:2c7f:2ee7 with SMTP id 00721157ae682-7114ec6a9aemr16733357b3.12.1749672538337;
        Wed, 11 Jun 2025 13:08:58 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152062155sm161087b3.13.2025.06.11.13.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:08:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 06/11] bpf: set 'changed' status if propagate_liveness() did any updates
Date: Wed, 11 Jun 2025 13:08:31 -0700
Message-ID: <20250611200836.4135542-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an out parameter to `propagate_liveness()` to record whether any
new liveness bits were set during its execution.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25b50a98558b..e060d1060a37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18856,12 +18856,15 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
  */
 static int propagate_liveness(struct bpf_verifier_env *env,
 			      const struct bpf_verifier_state *vstate,
-			      struct bpf_verifier_state *vparent)
+			      struct bpf_verifier_state *vparent,
+			      bool *changed)
 {
 	struct bpf_reg_state *state_reg, *parent_reg;
 	struct bpf_func_state *state, *parent;
 	int i, frame, err = 0;
+	bool tmp;
 
+	changed = changed ?: &tmp;
 	if (vparent->curframe != vstate->curframe) {
 		WARN(1, "propagate_live: parent frame %d current frame %d\n",
 		     vparent->curframe, vstate->curframe);
@@ -18880,6 +18883,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 						     &parent_reg[i]);
 			if (err < 0)
 				return err;
+			*changed |= err > 0;
 			if (err == REG_LIVE_READ64)
 				mark_insn_zext(env, &parent_reg[i]);
 		}
@@ -18891,6 +18895,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			state_reg = &state->stack[i].spilled_ptr;
 			err = propagate_liveness_reg(env, state_reg,
 						     parent_reg);
+			*changed |= err > 0;
 			if (err < 0)
 				return err;
 		}
@@ -19266,7 +19271,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * they'll be immediately forgotten as we're pruning
 			 * this state and will pop a new one.
 			 */
-			err = propagate_liveness(env, &sl->state, cur);
+			err = propagate_liveness(env, &sl->state, cur, NULL);
 
 			/* if previous state reached the exit with precision and
 			 * current state is equivalent to it (except precision marks)
-- 
2.47.1


