Return-Path: <bpf+bounces-44447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBBD9C3008
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 00:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72156B2130C
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193261A38EC;
	Sat,  9 Nov 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKJDyv9/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E961A3029
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731194078; cv=none; b=nSYP7X55d8hOiDgyLXvZMJXMVXGf06HBzs9m1yvEaDB0pQk3lf45QtN5YP7JMESFn4QYZ8dXDXPxTOZI5ZtHvhqZ8wgt2qdLteHHZdxzJA+SJBVHXAaHWxLM8mys2DA8ns5tAhRupQCKaBZ4d/Kphf4mszC/U43iUZA0MLWhG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731194078; c=relaxed/simple;
	bh=Yb1r8XUcd5i3l/lPzmoseupI0sJzrnKxfqccjBWtRik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd82C3mQ8JRtzq/UNZyWYFTTtEJSeZCBc03QsMV4G4WsHArgjSh1QEXxvozybftN39ABbXQOLZ49X1ziDmOt5b9FpjpuWybM/i0/eFdzKfXyJsiASRb1TjfdOl7HL2NBb+cCDRNre+VvOjGJoY0SpdR4GIxuGD9bbFT5ExpDVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKJDyv9/; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-37d4c482844so2262691f8f.0
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 15:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731194075; x=1731798875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE9zDlh0MPaupUGujUwJJ/0ei6AnoZ74CmtivGQynQg=;
        b=MKJDyv9/TkfPdBZq1eee3nuOm1LQeNsTP9MymlyxCIRIUlsLlqEjCIV3l3A+J7xWu1
         XOZ0yRf0PpWNXw8Wajmd0gSivTsn2irML6y2cjJ+X2b5IirypbxUsaM65jd4OOXzqLHy
         jXASaKyaP0m/JNg/A3LSkhWFrZsOzI7vsXDx3pBe+fZeDJ0mUGO5pCH/SPHr5WEvBqFS
         7Yn6FLLdxkd6RMsyna27tjcUri2C4NQ58TcW8Fop8UZKwTcdMXNWB4gYTM2pC9Hal7qf
         qhwgVWNxF/3Ii+0flv0Qswfofv9BVrTsUTzr79HYA9/1SALccZNwAe7La1MYq7aCIUNu
         17sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731194075; x=1731798875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE9zDlh0MPaupUGujUwJJ/0ei6AnoZ74CmtivGQynQg=;
        b=N5KWnDNoVOToBBGOf7xveNnaMIk/0txz5KdaAlvRxsSMKIir2JcHBMtfDN2SY1Q46W
         QWI1RmUSFSTqnTy8qsadjZPae61mTued86GnSqrnTR9pfHk5o8LrWg/WjCwiJPurR0VU
         C9iAy6sE9rsXUIUe5z3YyLveLAOtOfXxa3YCMNpwqxuYcfr1LSAndDmSMvvdaIKMT71+
         VkMrV0V07ls67URe1TXb8Qlsm++a2dV+pGqpDRP89o0ynjcGfDn4S+hy2XJpUfaK81Gh
         lzU5UInd85vWl9AAMZ2NnAor5TINt600MZE7h5FWkJnbZXAnDWaRLezQCJNkzRimDyd9
         v0SA==
X-Gm-Message-State: AOJu0Yz4Zhhric3Q7cOmPsIDTSk3CQguQUSruAvK4eyGetuikFL8k7jx
	/BaApnp1BdcW+X1JeTXoUPcsc9PTCKa0nxli+EZgLTlKV7UaCEvJTG9sdUPzF00=
X-Google-Smtp-Source: AGHT+IGQQBdzbj3uMdIMCWUqCTX4yy9ut4wBBWo8tEdX2vRn6Z3gU2PzFlQxY9UvMzwA9NXMWwIzYA==
X-Received: by 2002:a05:6000:144a:b0:37d:53a7:a635 with SMTP id ffacd0b85a97d-381f188c79dmr5627287f8f.51.1731194074809;
        Sat, 09 Nov 2024 15:14:34 -0800 (PST)
Received: from localhost (fwdproxy-cln-032.fbsv.net. [2a03:2880:31ff:20::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5d29sm124803655e9.39.2024.11.09.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 15:14:34 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 2/2] bpf: Drop special callback reference handling
Date: Sat,  9 Nov 2024 15:14:30 -0800
Message-ID: <20241109231430.2475236-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109231430.2475236-1-memxor@gmail.com>
References: <20241109231430.2475236-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826; h=from:subject; bh=Yb1r8XUcd5i3l/lPzmoseupI0sJzrnKxfqccjBWtRik=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnL+wOG7FBdVSqRO7mhyoHFiqsuSnBlfOuxUkYr0J6 +wsF9zaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZy/sDgAKCRBM4MiGSL8Ryu6TD/ wJGSMjngvUhbl7Dnison5iKO2yJKTeasm9vU+/Ng/YxAwS1EQF/+F8xU7AF7zM1p3YUSM8hC2nDIFd r0enScmlldo5RD6stS4J/jKuLrfAExWqJvs1x5O0D54wglgDzVN3jlqbqvJimNH3wfgrA0c2mO2MAb J7/OL3XdD9+W7GsnZuzZAzijT3Y9XG8HpLfCBdPsgG2/TR6rzDGeWnRf0KQWzYRwG2IFUFPCdlpDAq trm3QiAqftInqsjGhGcf3Yg9oz9PAaVZE3JEg7dCsDE3Gih5PziUCAG/15sYbLN0wuEM0V7XtQCUD9 qyN1+WeOWumz4P7Yifl6a+s5/3vYE3302qx39Ll752CBFtBWPPGVdLN2p/WkaIVm/PlXKb5eYmmaQf PviYvNB/6tXBIMtAXDOqj1UdnXBiRe9Kc6vIOdM0BaoIybwJsJ0uwwK12KJpUBlWe90348+Krin8j4 7EI10IFVaY868pOqa81MZrw9sKqBb7HHJ6vsdFYPIXzLrB8v0mB97HSeYd+HlLwZlxTuA8wwAAB+mX v+WT95iooOglPhGqICOvmTQyKX9BFoZhFhZKhB2BUg21wnfiteuAwIAPF1V9rkbxRbKJ5RnVIhPiGU mjxiwlkhhhGZeQLWuokKt2qYA/ZppyoqSl4VGOxlYX5DcwzpBbXYz6gErUbA==
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
index d55ca27dc031..9f5de8d4fbd0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1358,7 +1358,6 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	state->refs[new_ofs].type = REF_TYPE_PTR;
 	state->refs[new_ofs].id = id;
 	state->refs[new_ofs].insn_idx = insn_idx;
-	state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
 
 	return id;
 }
@@ -1392,9 +1391,6 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
 		if (state->refs[i].id == ptr_id) {
-			/* Cannot release caller references in callbacks */
-			if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
-				return -EINVAL;
 			if (last_idx && i != last_idx)
 				memcpy(&state->refs[i], &state->refs[last_idx],
 				       sizeof(*state->refs));
@@ -10267,17 +10263,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
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
@@ -10447,14 +10436,12 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
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
@@ -17707,8 +17694,6 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
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


