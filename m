Return-Path: <bpf+bounces-23236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961A86EE0C
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 03:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E2E1F22B54
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134B7462;
	Sat,  2 Mar 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LavaKYFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CA748F
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344824; cv=none; b=VMiKAYxQ9AQzl+J0X4n3u6G4pAUmeZEUapP3gDf2nfuvmcRKBjUVHZWLnaxVvu6Bp14X35gOwRpkff4LWOlIFH9QbmhmjwEThjNMsFIcQcuZN3pvX2hu6W+ixbOvnVIwHAgTNj8qLHVA2+W8M1F5RbVVj8uBR3pmwmAfR16vda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344824; c=relaxed/simple;
	bh=akdntC4nVa+YOwmKF6b+MaS3stoEqP/VqBaZylztzHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdA2W6Zqz9JJD8Zw1wd8Gu7l7JjLRQy3hn0dTLUR+ae031nj3BhogpmZgtXv7oqAMnbBU6VHwQOsPWGa8fcMRAtzz5WMdVNjBlY9VN7ADZhzoWOJExKOAex3K7MAtiHUFHFZM5iI74Dc/eQY5e0AzLh7Pf78E9mundZR2d6iFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LavaKYFo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so1903369b3a.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 18:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344822; x=1709949622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8UvB+/gIXT2YbqwUerz2E7fjQNxorE1nYuj5hGsf7A=;
        b=LavaKYFoMvdvaDu0LN7SDeZ8SP2dr3qe114H+vW+xXaCvek8iXdqB7GmXuTF+Oev8n
         ZLMRwid1d+CyhuvovruaFQAzhLsjzk1OzReLtcbgZ02UlTwlgbeLOFRox+jher6/6jk+
         NzEXrO5s3wh0c6a6Ih/u7kXReKfU+faPOmgKAcB0uLw7YXP+QmlRSDmkaph9t0y6VFkD
         udFK5SW4kSf30I7K33PpLcAcbawUoh5FTtpDpzQfO7AYyVZdUlDolAYaJf8Uk8OISxYT
         xT0wOxZcec6IuubndY3jlbPKXVYGmsOQv8S2otqPKZblwST2WX91u7oXOPsJsgbKIkV1
         Pt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344822; x=1709949622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8UvB+/gIXT2YbqwUerz2E7fjQNxorE1nYuj5hGsf7A=;
        b=cUFY7Z5VjkGaXhMwihb8jV+g9kW2tazpUI49atwGU0R7hVjKiGSo7oOW1ZlmpdNcVB
         fYHkkKTaotaeJ30C0wS2oyx0pCNOLBUOlW8yCEWwQxphYZ52Xt/zkzIHkdyCGFZ0e3+k
         q+YmPS8GoBzbNbCdYSpB36XTCWKzQB7rwMvN6eUTjB07EBL/0ARkRq6SlwJcJsVWFzWJ
         4a9Y57ZvCftxgb54dHPr1LqZ8aNEXaGYImNP/1jVp9dXNUXjy9FVDksk/2WvN45j9Y/9
         kq8lYOarfIOCAEaU6vIIGh4zprKNVcTS+wwo4dHH1KISNzEtotyTR1vMN8O7lOWgPZOf
         2/mg==
X-Gm-Message-State: AOJu0YxaFQ+/7puzZGnHZh9h1janNQd+E1aMjn6UMkQCp1yL6OGaJbki
	ASIMdUqCxR8asQJxxOBPMHNcg+VQglmfm9ObXLl++nvQ29hQ0qBpZ0J2rJam
X-Google-Smtp-Source: AGHT+IG4vTvyUf3C31dG5w/W5pPdr2dfZHyxJ+toZuRUqp94Lx8oC+T62EA2um1bTjlXG49xMgTXYw==
X-Received: by 2002:a05:6a00:8d07:b0:6e5:e1d6:f537 with SMTP id ik7-20020a056a008d0700b006e5e1d6f537mr1095995pfb.14.1709344821333;
        Fri, 01 Mar 2024 18:00:21 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id t66-20020a628145000000b006e053e98e1csm3717508pfd.136.2024.03.01.18.00.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Mar 2024 18:00:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/4] bpf: Recognize that two registers are safe when their ranges match
Date: Fri,  1 Mar 2024 18:00:08 -0800
Message-Id: <20240302020010.95393-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When open code iterators, bpf_loop or may_goto is used the following two states
are equivalent and safe to prune the search:

cur state: fp-8_w=scalar(id=3,smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=11,var_off=(0x0; 0xf))
old state: fp-8_rw=scalar(id=2,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=11,var_off=(0x0; 0xf))

In other words "exact" state match should ignore liveness and precision marks,
since open coded iterator logic didn't complete their propagation,
but range_within logic that applies to scalars, ptr_to_mem, map_value, pkt_ptr
is safe to rely on.

Avoid doing such comparison when regular infinite loop detection logic is used,
otherwise bounded loop logic will declare such "infinite loop" as false
positive. Such example is in progs/verifier_loops1.c not_an_inifinite_loop().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63ef6a38726e..49ff76543adc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7830,6 +7830,11 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
 }
 
 static void reset_idmap_scratch(struct bpf_verifier_env *env);
+enum exact_level {
+	NOT_EXACT,
+	EXACT,
+	RANGE_WITHIN
+};
 static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_idmap *idmap);
@@ -16286,8 +16291,8 @@ static int check_btf_info(struct bpf_verifier_env *env,
 }
 
 /* check %cur's range satisfies %old's */
-static bool range_within(struct bpf_reg_state *old,
-			 struct bpf_reg_state *cur)
+static bool range_within(const struct bpf_reg_state *old,
+			 const struct bpf_reg_state *cur)
 {
 	return old->umin_value <= cur->umin_value &&
 	       old->umax_value >= cur->umax_value &&
@@ -16453,12 +16458,13 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap, bool exact)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
+		    enum exact_level exact)
 {
-	if (exact)
+	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (!(rold->live & REG_LIVE_READ))
+	if (!(rold->live & REG_LIVE_READ) && exact != RANGE_WITHIN)
 		/* explored state didn't use this */
 		return true;
 	if (rold->type == NOT_INIT)
@@ -16500,7 +16506,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
-		if (!rold->precise)
+		if (!rold->precise && exact != RANGE_WITHIN)
 			return true;
 		/* Why check_ids() for scalar registers?
 		 *
@@ -16611,7 +16617,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap, enum exact_level exact)
 {
 	int i, spi;
 
@@ -16775,7 +16781,7 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, bool exact)
+			      struct bpf_func_state *cur, enum exact_level exact)
 {
 	int i;
 
@@ -16802,7 +16808,7 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
 			 struct bpf_verifier_state *cur,
-			 bool exact)
+			 enum exact_level exact)
 {
 	int i;
 
@@ -17182,7 +17188,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx) || is_may_goto_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_reg_state *iter_state;
 
 					iter_state = get_iter_reg(env, cur, insn_idx);
@@ -17194,13 +17200,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				goto skip_inf_loop_check;
 			}
 			if (calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true))
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
 				goto skip_inf_loop_check;
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, true) &&
+			    states_equal(env, &sl->state, cur, EXACT) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
 				verbose_linfo(env, insn_idx, "; ");
@@ -17257,7 +17263,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 */
 		loop_entry = get_loop_entry(&sl->state);
 		force_exact = loop_entry && loop_entry->branches > 0;
-		if (states_equal(env, &sl->state, cur, force_exact)) {
+		if (states_equal(env, &sl->state, cur, force_exact ? EXACT : NOT_EXACT)) {
 			if (force_exact)
 				update_loop_entry(cur, loop_entry);
 hit:
-- 
2.34.1


