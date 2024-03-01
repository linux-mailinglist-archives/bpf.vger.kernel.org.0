Return-Path: <bpf+bounces-23108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D986DA43
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 04:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7723BB23C77
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 03:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFB4F215;
	Fri,  1 Mar 2024 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi30D4KW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87F4D9FF
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264273; cv=none; b=ue5LZVKLKctliTnJ7sjZeYc0Jx+qFeprYHi/sPJNk5JfhQMmnJpNud3Zt6lRY/9mMe2LajUv5/SxzHXAFFogV+UoNLub75/fOclfGkB0tbKX3vIQveYMlrvlcaGGNBlg95DGGJnCTOjC+BEr3RAOknG7o78j9WbkBfWSFet93xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264273; c=relaxed/simple;
	bh=v+i1xNP+MMaDbawrrYfHonirE7BFMQrVo6aakKyHUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdPn03PrDJzVzVHXaAg8LVKACQntvJCtZCJKrZCAjLsN4Drwy0w2pQZfoniycK4fSNdzWoEejYz6jlI3MA6AdIAcmz8aQiUxF9zzSNnT653VClvM9r+UotUTHkiAdic/nmUbZIfPFQF68ueUOSwqnBfedVLkCOPN8QZfbSYzZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi30D4KW; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e49833ccdfso725735a34.2
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264270; x=1709869070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO2DJFIYuvfvPUA0kwCOKexWJV9f55jrodWw6Fp2x00=;
        b=Vi30D4KWbDC0udJmLik7Js38PJFYLQcnJvWV3GUSZAobGaC5riQt9vCSx+GElmJjct
         /15QblYl3oqsdVpuHv3W5f2yz40YHof6MUATtSy7pStK9VWhdVzqYmeHM0cnAjiJ4bjS
         qQDTZQT0lg/1BRY0qCUstbrAqFs8MagcOfSvJDmx5q92PfvFmRkt3jtX4PMNBiZo9WaB
         h1PRx2wgON2/AJ5hp6j84yLg3SfMt7atmhYhRIDN7ObkTbglWFfVJ/KO4fXYkWGGpaHv
         5nrtSbGPcDzthVceYaJv5zK27hJ/5zl/jbbPnY4T4gNe2AUQk0fgw19F6Uc3WjyfKD58
         rT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264270; x=1709869070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO2DJFIYuvfvPUA0kwCOKexWJV9f55jrodWw6Fp2x00=;
        b=uopXX+lry3Ts+n53PEekJbfzbi52CWUlVuowVG9QcuJVWDGMLM5u0NVHWXagfY3n85
         lHsKqWu6MXSGYrXIlqNrM+WIqXuRDc6OQl432xOax4HCHrRgkIbx0Rj73sHswL066TAr
         9p6cofQ0QhYARrvq3z1FCZpWYy2UXKB4H+gnQAjRau1a6Mhw/qbHY9kCuE07pkJ4tIiM
         LBPfif8gZy1M/V+4VaawM2YbeV0WpF3N6Is8iv+qvGzcOtapegAsUFKDi5NB8kbki3NF
         auXkEvB3ztBey8a+dZEdk6MPK+Ust56F+Rug5FRrVT1VzvQ1wQYk5zEMo593JH8iE2pq
         PFWA==
X-Gm-Message-State: AOJu0YxIWE1VWh8PcJ/UpScKp4EKqCV8oHj3OOeWAhN2C0rAPChds//T
	BXBQoQ2jrbaYCKg1se+qTAJ9z9VtXft+4WUEYilYi7LC93sS1b/NXBoFxDxh
X-Google-Smtp-Source: AGHT+IGXkfsUPu92KpIKps1Kr6pBKmgy9WgYgSZm1PDbNAel+2PnHlARDLujFeZN22Lmc6F61+LwYg==
X-Received: by 2002:a05:6830:ec9:b0:6e4:a1a1:8d78 with SMTP id dq9-20020a0568300ec900b006e4a1a18d78mr678201otb.2.1709264270482;
        Thu, 29 Feb 2024 19:37:50 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id l20-20020a63da54000000b005cd8044c6fesm2088987pgj.23.2024.02.29.19.37.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 19:37:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/4] bpf: Recognize that two registers are safe when their ranges match
Date: Thu, 29 Feb 2024 19:37:32 -0800
Message-Id: <20240301033734.95939-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
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
index a50395872d58..f3b1ffc66ee6 100644
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
@@ -16281,8 +16286,8 @@ static int check_btf_info(struct bpf_verifier_env *env,
 }
 
 /* check %cur's range satisfies %old's */
-static bool range_within(struct bpf_reg_state *old,
-			 struct bpf_reg_state *cur)
+static bool range_within(const struct bpf_reg_state *old,
+			 const struct bpf_reg_state *cur)
 {
 	return old->umin_value <= cur->umin_value &&
 	       old->umax_value >= cur->umax_value &&
@@ -16448,12 +16453,13 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 
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
@@ -16495,7 +16501,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
-		if (!rold->precise)
+		if (!rold->precise && exact != RANGE_WITHIN)
 			return true;
 		/* Why check_ids() for scalar registers?
 		 *
@@ -16606,7 +16612,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap, enum exact_level exact)
 {
 	int i, spi;
 
@@ -16770,7 +16776,7 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, bool exact)
+			      struct bpf_func_state *cur, enum exact_level exact)
 {
 	int i;
 
@@ -16797,7 +16803,7 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
 			 struct bpf_verifier_state *cur,
-			 bool exact)
+			 enum exact_level exact)
 {
 	int i;
 
@@ -17177,7 +17183,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx) || is_may_goto_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_reg_state *iter_state;
 
 					iter_state = get_iter_reg(env, cur, insn_idx);
@@ -17189,13 +17195,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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
@@ -17252,7 +17258,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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


