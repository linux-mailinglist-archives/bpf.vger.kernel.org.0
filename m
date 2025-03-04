Return-Path: <bpf+bounces-53229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B4A4EDE0
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03696171D87
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0826A0ED;
	Tue,  4 Mar 2025 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mesU3elb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C642641E2
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117848; cv=none; b=lQHJDuiyaHYvazq6NwsU6CQ592gqN+BMg/zYeRIC/zzmSfgBqTFw/ZvKbI8PNbcow6D+vIy075lVcu/2KCA6iCHyye42vQSApI9R3YQcL99GVmpH/GcHBnvx4VnpC7/h0WLgm2H2nl/bl/gOQEJKjQyqckzDIwgh2g++JoGJWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117848; c=relaxed/simple;
	bh=D8ZEKVn64Sd5axtddKMZqk8ljAOwuL71ctoGRhSaCQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS2Kb4KNpWAh1ZmtjmxYCnAjNcCWyvPdDXb5mdcpDgBGY/51XFzfh6k3nNcqiPQDMH2zguWmPP9FY30RD3lweXRe4sxksZ1zBaQkvgH4iHeKlFI3fOT7FxLOYcPDPzh9WhoseoV21L+Ng9ysaRglOmXT+1Yrhm0LPCpQygaj204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mesU3elb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223a7065ff8so71656105ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117846; x=1741722646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coac0IMqhgbNlsTguy9T8pdlS35mZJeiVU0PCL9zvew=;
        b=mesU3elb/xn+CWqgJNHdWUnHZGU8U3M936nJVZHZLFaN8eZJAenutyZaqDeiI59KBV
         alAi5ZRutz5a9jt+favqdYN9GxAHeXOQcnHs++HxfP7bAD13LF/fkQhPzTTXNmUTUzMA
         VGPZmk+UScsXh6+whaEtJNWjs6e3jSNssZJrOMiRRfGplq+XKkNKRMmx4ZS7BPcZ4qCD
         uE8psri6bG0WEzbR+SBqrYVz1b/Y9rHYQphv/E/te6d8lCM4AKUAlgmAYYIeVenJMagw
         3CPpoYxR3pI/vocaGH2P/K8fgncwD611teknk5O0a9WkXmKuuiXwP+cw7SbY/YDhI0u0
         kkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117846; x=1741722646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coac0IMqhgbNlsTguy9T8pdlS35mZJeiVU0PCL9zvew=;
        b=KddaHPxs/Qr5hf1ZWA/ofhURqVWjawYI5EKEPZfYvta6bEYjdifcMJEuCVzeB/Smmb
         zDx/lDM6oxpLJaOBhrpj611cS9bHGhAQ+NNg17y7wTtz6ognWHtB+qPlN2mJhqlfKElg
         xgMd1pc8oBI3bBGzKXCkq05NflYLTtac9Iq9NICPuaXU4No2fmZ2vNQArRD31eHjNDta
         67Ng0IX/qzBAZz6JZBoxurU4Oi0cKXeggN7/ZGC5b6AO0SjlW3NDY/9OFyh17K7NpLTR
         WE+7u5RGRgFq3uxuN54Pfi3yhGtS2pKM+bjKFcJCHGrhbGXk290lsIn7NEJXce29CyI6
         RkaQ==
X-Gm-Message-State: AOJu0YyEXWjdaUiH+bnkmkZeTeKBPKY0E1Z2EnM9NJRyMiFeEVN3up+/
	bYYvNPwGSgrgu7Ylj9Rx32P0XJq0Jv43UFT0kU9qX2HlsCrZ3WxYLW001w==
X-Gm-Gg: ASbGnctlA1xurtYwtc+G3acc7N7wrGUVmuhNfHgIcqIBQzebm/pi97uvwODRneNv1ZA
	JhYTlL4YYlCdCixe29359JLa3fkmcYX1SfQY03RIvuwrv7GApiZdSYFwVzwczvLyWREtoXDVtuk
	ecbFxR8vA6LG134dZU4msLbbrEbHMzMtgK1JpYw1yk50YY7jHmFlEVH6r+Hunje+U4UZCHT+69T
	j5LPt/A7NyVESTDlNsu4qFytYbdKPV/K0MS3lgOd7xe2pMnTVDZ/dVhL27N+EwI8+/rHl0ajcDR
	rR7sD88Vm6SVdls+XoSfWniW9TUdv+csIVy3B4hK
X-Google-Smtp-Source: AGHT+IHHTcK2Gr8dZR8E3CxF03gTZZ6R+7Qj3yyZZiIXR+c34Dhkvbu8rMAXxdOx6Xvei/ivmKUjLQ==
X-Received: by 2002:a17:903:186:b0:21f:7082:1137 with SMTP id d9443c01a7336-223f1ca2630mr6220205ad.22.1741117845784;
        Tue, 04 Mar 2025 11:50:45 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm98560925ad.126.2025.03.04.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:50:45 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/5] bpf: get_call_summary() utility function
Date: Tue,  4 Mar 2025 11:50:21 -0800
Message-ID: <20250304195024.2478889-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304195024.2478889-1-eddyz87@gmail.com>
References: <20250304195024.2478889-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor mark_fastcall_pattern_for_call() to extract a utility
function get_call_summary(). For a helper or kfunc call this function
fills the following information: {num_params, is_void, fastcall}.

This function would be used in the next patch in order to get number
of parameters of a helper or kfunc call.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 121 ++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 64 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25910b740bbc..5cc1b6ed0e92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17019,27 +17019,6 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
 
-/* Return a bitmask specifying which caller saved registers are
- * clobbered by a call to a helper *as if* this helper follows
- * bpf_fastcall contract:
- * - includes R0 if function is non-void;
- * - includes R1-R5 if corresponding parameter has is described
- *   in the function prototype.
- */
-static u32 helper_fastcall_clobber_mask(const struct bpf_func_proto *fn)
-{
-	u32 mask;
-	int i;
-
-	mask = 0;
-	if (fn->ret_type != RET_VOID)
-		mask |= BIT(BPF_REG_0);
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i)
-		if (fn->arg_type[i] != ARG_DONTCARE)
-			mask |= BIT(BPF_REG_1 + i);
-	return mask;
-}
-
 /* True if do_misc_fixups() replaces calls to helper number 'imm',
  * replacement patch is presumed to follow bpf_fastcall contract
  * (see mark_fastcall_pattern_for_call() below).
@@ -17056,24 +17035,54 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
-/* Same as helper_fastcall_clobber_mask() but for kfuncs, see comment above */
-static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
+struct call_summary {
+	u8 num_params;
+	bool is_void;
+	bool fastcall;
+};
+
+/* If @call is a kfunc or helper call, fills @cs and returns true,
+ * otherwise returns false.
+ */
+static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+			     struct call_summary *cs)
 {
-	u32 vlen, i, mask;
+	struct bpf_kfunc_call_arg_meta meta;
+	const struct bpf_func_proto *fn;
+	int i;
 
-	vlen = btf_type_vlen(meta->func_proto);
-	mask = 0;
-	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
-		mask |= BIT(BPF_REG_0);
-	for (i = 0; i < vlen; ++i)
-		mask |= BIT(BPF_REG_1 + i);
-	return mask;
-}
+	if (bpf_helper_call(call)) {
 
-/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
-static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return meta->kfunc_flags & KF_FASTCALL;
+		if (get_helper_proto(env, call->imm, &fn) < 0)
+			/* error would be reported later */
+			return false;
+		cs->fastcall = fn->allow_fastcall &&
+			       (verifier_inlines_helper_call(env, call->imm) ||
+				bpf_jit_inlines_helper_call(call->imm));
+		cs->is_void = fn->ret_type == RET_VOID;
+		cs->num_params = 0;
+		for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
+			if (fn->arg_type[i] == ARG_DONTCARE)
+				break;
+			cs->num_params++;
+		}
+		return true;
+	}
+
+	if (bpf_pseudo_kfunc_call(call)) {
+		int err;
+
+		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		if (err < 0)
+			/* error would be reported later */
+			return false;
+		cs->num_params = btf_type_vlen(meta.func_proto);
+		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
+		return true;
+	}
+
+	return false;
 }
 
 /* LLVM define a bpf_fastcall function attribute.
@@ -17156,39 +17165,23 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 {
 	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
 	struct bpf_insn *call = &env->prog->insnsi[insn_idx];
-	const struct bpf_func_proto *fn;
-	u32 clobbered_regs_mask = ALL_CALLER_SAVED_REGS;
+	u32 clobbered_regs_mask;
+	struct call_summary cs;
 	u32 expected_regs_mask;
-	bool can_be_inlined = false;
 	s16 off;
 	int i;
 
-	if (bpf_helper_call(call)) {
-		if (get_helper_proto(env, call->imm, &fn) < 0)
-			/* error would be reported later */
-			return;
-		clobbered_regs_mask = helper_fastcall_clobber_mask(fn);
-		can_be_inlined = fn->allow_fastcall &&
-				 (verifier_inlines_helper_call(env, call->imm) ||
-				  bpf_jit_inlines_helper_call(call->imm));
-	}
-
-	if (bpf_pseudo_kfunc_call(call)) {
-		struct bpf_kfunc_call_arg_meta meta;
-		int err;
-
-		err = fetch_kfunc_meta(env, call, &meta, NULL);
-		if (err < 0)
-			/* error would be reported later */
-			return;
-
-		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
-		can_be_inlined = is_fastcall_kfunc_call(&meta);
-	}
-
-	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
+	if (!get_call_summary(env, call, &cs))
 		return;
 
+	/* A bitmask specifying which caller saved registers are clobbered
+	 * by a call to a helper/kfunc *as if* this helper/kfunc follows
+	 * bpf_fastcall contract:
+	 * - includes R0 if function is non-void;
+	 * - includes R1-R5 if corresponding parameter has is described
+	 *   in the function prototype.
+	 */
+	clobbered_regs_mask = GENMASK(cs.num_params, cs.is_void ? 1 : 0);
 	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the pattern */
 	expected_regs_mask = ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
 
@@ -17246,7 +17239,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	 * don't set 'fastcall_spills_num' for call B so that remove_fastcall_spills_fills()
 	 * does not remove spill/fill pair {4,6}.
 	 */
-	if (can_be_inlined)
+	if (cs.fastcall)
 		env->insn_aux_data[insn_idx].fastcall_spills_num = i - 1;
 	else
 		subprog->keep_fastcall_stack = 1;
-- 
2.48.1


