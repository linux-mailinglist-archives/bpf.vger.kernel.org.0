Return-Path: <bpf+bounces-44442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D49C2FD8
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286181F218FE
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A991A3047;
	Sat,  9 Nov 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4HQ8ar4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA4143725
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192771; cv=none; b=NPph3JN36mx7hi9If/WFCS4MinAxQCZ6qprL6NwqsmNua8RVXx/ueboegRBHgyoCw5FldBeN/TShOrqITs3PTXuso3XZLYGA9P/FWiViqPEAMIRGP32ebKEq1PLlIJuB0sPZwTcfiB38LKuFAeLVp6yGzbCK54zdcrKyZjCVch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192771; c=relaxed/simple;
	bh=M0IsXjn6dSMydpILK8oj7gvtxwjdTNysOp41kJknPhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkpgfTrt6JlZBQ78+SMj4QAwsOD0pfiiiwQHrbqZfwLF6wavfuMK1YmjIQTigEFS0GVRbw810vkCE59K2FmExops23WOIyHxnwoiu5BjILzPbZVxSbYpJy2Wp1HJJSyQ9DtKmhrbWURnM9mlZygpWHjD7pCt4Aic4KMOgFUAaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4HQ8ar4; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so2512138f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731192767; x=1731797567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNpVZcX6g4mDzqjLsJIXfg8I2iznqpWFa62kxrZlXaE=;
        b=i4HQ8ar4ky5PP97zVqbHqwTIgq4CnvJ6xCDEdSReW/5E83/Fl7Uf8ms5jw8J/j+QFI
         yAQevZjawx0xQtMCVY0GQbDQnmAytk2vBMqFfbxvvQl3dIhEpyTo34nM/odkoFRxaG6I
         pGxxBZFbfJH0RaaKsgdVqF+Hb+m2xGtYUiH/lxh/fz7s6eIw8YAF70Zt8mLZNuyf04Q2
         Hc2hX2R6dOEvfL/sDmpGnyldZx0147dLgjh3mOocUTPGtOS08ZSUrq67HXio4iYrWk7e
         hOKMKAHJI8F4sEONR/cqxDrnxqOgI1zqniSQBMNs65GY8CQOs9PGAO2RLigMM3yuU2l3
         Thwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731192767; x=1731797567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNpVZcX6g4mDzqjLsJIXfg8I2iznqpWFa62kxrZlXaE=;
        b=ibAhSATPri7OrBXT0j/gBZXRMPZH0fubfWxn/SBYDqWlWHfslM9UOnbyNId1hwI2P9
         OKaNJB9wUn9QnX8wiu2VoVuLOszO8ufdEoCmjvzRPlCf9AGisJsTx8Kp/QPJ5Iku9I9l
         Xs94aXW2HfpTgp56fRMxVoHwYEmzoeKy6JBG6/oNgkLgTaE79JmzmLVDAHlm1PLWJdGi
         it897ECr9SLj6aqhn2UUX3tBhjZdOoqJ7rMwaWNeHOKd9+/3LvAH85ijB26tm6dhIvTT
         83dD/7EKT1aMA0bECSGEdY1S/NIo5o2mO0iRRNBZuCHc3TyXN8SxMTM/P2yDcOX4O4Rc
         VQYw==
X-Gm-Message-State: AOJu0YzGLyDjNTyCQRlKS3AGDXYPdST9ehnMdhLhl0rDcB0xapXN8+4a
	et7tZRmVLTs1oAaMqzeJgHqZsO/MLXqtaZ50vILm/cwJYhaOEhCP/0WII4DCKWU=
X-Google-Smtp-Source: AGHT+IH6CoV7At04fYH3tVG+jBE3t/kx+43RCsw7tbbP6fHydvckca2WMQa1T9EzMF0A0p0/ujHSbA==
X-Received: by 2002:a5d:5f48:0:b0:37d:498a:a237 with SMTP id ffacd0b85a97d-381f171ccc1mr6738650f8f.8.1731192767082;
        Sat, 09 Nov 2024 14:52:47 -0800 (PST)
Received: from localhost (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea93esm8714156f8f.66.2024.11.09.14.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 14:52:46 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 2/2] bpf: Drop special callback reference handling
Date: Sat,  9 Nov 2024 14:52:43 -0800
Message-ID: <20241109225243.2306756-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109225243.2306756-1-memxor@gmail.com>
References: <20241109225243.2306756-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826; h=from:subject; bh=M0IsXjn6dSMydpILK8oj7gvtxwjdTNysOp41kJknPhQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnL+ea/mpTqaPJ7mIm+HR/B1h/necjQU9RnltGo5Wj W8oDgdqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZy/nmgAKCRBM4MiGSL8Ryv8gD/ 91G9fgBhN3NwZ5Ex8RH/6KEjv4zdbKcfEvqNDM6n+8EAbTaPx6N4NQNZtud65L4Mz5Nvj3OqNOZkQn 9HC/yNCPI/vdyMXIR9Ys+FhBg00+je2lFbrQ3BhClGJCWC3oEExEqp9yU7W/no8TVb/69cumiSUQCF 0RET68/fjO/0nPvvJCo9u03VTNRqyF0PWKingEAePUVNqII0spHBSHFFBYnmcMOF6vfPY83zByV32w G7CTti6FQU7b2q5C54aJUSSTonVcyxGUIXrrzWolMj5aKQPdYhlmlR8OD3BeZhnkVcpWOTIccsOVNz lfs+LKzr/lXB/mb0Dp6HVZzX1brnUY2lLj5wMXbk4QkvIJFMCaICnI/aHGzH7/qOUZhFk+sGwl1p5n mmoXtDt43RtBgZ7KwVeO34bh/qHRVuhsiWR95hiYccificOIBRgizpkrGlEwFu6/PgtElh80mo2vEc kqFV6KDOanu0tpBe5RPRS5zWDPvQOh88hQx0tLbfibv+MsDBXKRnDjSD1cHvpAuXhi4S0UXvUymTAN JjQ5orCp0xaSnKgq/BsjGrj+jJtHJiOTVN7f0E2p/TqoTI+3g1dNDKd0cp6vQH0Dw59HrFGdRkRK09 5CR8+eGYgyY5BVcwTfXVCjjP+0zlSsD82nutOe4Rm58jXK/O/SenznUw61lA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Logic to prevent callbacks from acquiring new references for the program
(i.e. leaving acquired references), and releasing caller references
(i.e. those acquired in parent frames) was introduced in commit
9d9d00ac29d0 ("bpf: Fix reference state management for synchronous callbacks").

This was necessary because back then, the verifier simulated each
callback once (that could potentially be executed N times, where N can
be zero). This meant that callbacks that left lingering resources or
cleared caller resources could do it more than once, operating on
undefined state or leaking memory.

With the fixes to callback verification in commit
ab5cfac139ab ("bpf: verify callbacks as if they are called unknown number of times"),
all of this extra logic is no longer necessary. Hence, drop it as part
of this commit.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  | 21 +++-------------
 kernel/bpf/verifier.c                         | 25 ++++---------------
 .../selftests/bpf/prog_tests/cb_refs.c        |  4 +--
 3 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d84beed92ae4..3a74033d49c4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -265,23 +265,10 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
-	union {
-		/* There can be a case like:
-		 * main (frame 0)
-		 *  cb (frame 1)
-		 *   func (frame 3)
-		 *    cb (frame 4)
-		 * Hence for frame 4, if callback_ref just stored boolean, it would be
-		 * impossible to distinguish nested callback refs. Hence store the
-		 * frameno and compare that to callback_ref in check_reference_leak when
-		 * exiting a callback function.
-		 */
-		int callback_ref;
-		/* Use to keep track of the source object of a lock, to ensure
-		 * it matches on unlock.
-		 */
-		void *ptr;
-	};
+	/* Use to keep track of the source object of a lock, to ensure
+	 * it matches on unlock.
+	 */
+	void *ptr;
 };
 
 struct bpf_retval_range {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3f06a4410d8..45cd620a4032 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1358,7 +1358,6 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	state->refs[new_ofs].type = REF_TYPE_PTR;
 	state->refs[new_ofs].id = id;
 	state->refs[new_ofs].insn_idx = insn_idx;
-	state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
 
 	return id;
 }
@@ -1391,9 +1390,6 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
 		if (state->refs[i].id == ptr_id) {
-			/* Cannot release caller references in callbacks */
-			if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
-				return -EINVAL;
 			if (last_idx && i != last_idx)
 				memcpy(&state->refs[i], &state->refs[last_idx],
 				       sizeof(*state->refs));
@@ -10270,17 +10266,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		caller->regs[BPF_REG_0] = *r0;
 	}
 
-	/* callback_fn frame should have released its own additions to parent's
-	 * reference state at this point, or check_reference_leak would
-	 * complain, hence it must be the same as the caller. There is no need
-	 * to copy it back.
-	 */
-	if (!callee->in_callback_fn) {
-		/* Transfer references to the caller */
-		err = copy_reference_state(caller, callee);
-		if (err)
-			return err;
-	}
+	/* Transfer references to the caller */
+	err = copy_reference_state(caller, callee);
+	if (err)
+		return err;
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
@@ -10450,14 +10439,12 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	bool refs_lingering = false;
 	int i;
 
-	if (!exception_exit && state->frameno && !state->in_callback_fn)
+	if (!exception_exit && state->frameno)
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
-		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
-			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
 		refs_lingering = true;
@@ -17710,8 +17697,6 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
-			if (old->refs[i].callback_ref != cur->refs[i].callback_ref)
-				return false;
 			break;
 		case REF_TYPE_LOCK:
 			if (old->refs[i].ptr != cur->refs[i].ptr)
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 3bff680de16c..c40df623a8f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -11,8 +11,8 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } cb_refs_tests[] = {
-	{ "underflow_prog", "reference has not been acquired before" },
-	{ "leak_prog", "Unreleased reference" },
+	{ "underflow_prog", "must point to scalar, or struct with scalar" },
+	{ "leak_prog", "Possibly NULL pointer passed to helper arg2" },
 	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
 };
-- 
2.43.5


