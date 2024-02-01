Return-Path: <bpf+bounces-20900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834B84502A
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2910328FEDD
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F73C47D;
	Thu,  1 Feb 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndk6VAAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AA3C465
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761291; cv=none; b=PT3D1RrHdV0VINulO5Czje+7nqDf620j3ALsSsA3GVT3anNmvdtseCm/Zkybo3JUP4qe4ASqz/lc5mRpt/oM8IduCGk7SNUp2poKA6pMpNV6qO4SG71q0LDnKSSqzrrZ6KHcWLRYi/5OWpsF/eXO7aPModE52o7pP3xU4pRbwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761291; c=relaxed/simple;
	bh=Nohh56u+465Lt6chQfJ/XP9DJ0vNzIUQddkXi+4GSAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPZX5Uq9i0lS6QUTPV4yLsftqH7Odtc4/xVrTUuGjveT8Roa8RFsZ5Z+qAcrp2S3PZB0LTzuebNEtk6cG0QIzZ7Lxugqsk96kp2GW7kSWnfEri1UFzzfnnv4btHiG05s5ELyVKQ8/eBb90B3BV/+E6iAC/rt9wKAg9g2oWko+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndk6VAAr; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a350bfcc621so51354566b.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761287; x=1707366087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skBcnJ7cz4044hjwmIqAd593TGS+mKC7y1F5stomKew=;
        b=Ndk6VAArhJj7dKGiNlVHmHJzsA/tNET3WUa3vMI06/xgGXs0l911aYokCbfIxpBOdN
         sOjgIDWsa9tl3AsJQEL8plN2DfhRVMyXrkNokdBEuuiKP0zltjM9oGJiGNoayZT48guS
         VNeBvaTM/6x+zUniXKFFnCIOHlU5ylRvf9u/ff+PYPdbY3hB504V9wpJjluHlFpdkor0
         yRdJxcJShy75vHVseOMInowg5h5t2agGHO3Ibm8DzSXGc2kPuaQffJdLFF2tfW/u1HWs
         gJoOEbio9ao8T+ifrv5oiMz9S25ZhnKB6zzqg3p8t4sJ0Kmh2QcL1P7xeewY5mbHNb/j
         fZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761287; x=1707366087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skBcnJ7cz4044hjwmIqAd593TGS+mKC7y1F5stomKew=;
        b=qoWvFAzTO9+yS4KpmRZ1PtTlpgR9GMTIi1+ZOJmwvxKcP4Cwmlell0l5slsjapQfJJ
         +YNPlJ7Y+g6+J61wqqjXVqhqN4GjEVn8c7eUWa1fYgjjAHBx0IfS24RyI/LjoWLrzLTL
         idzdWYiTfF4J6gRT9rQxHZlL+xJ/SDXmHYUfi1R6nwdrrVbbte9D5hLDImFwWDebBdHY
         1HtB5M/1MiLER3MhbHEE4+aOMsCKeCP4oXiKCzhui6CiCfApOBkZx/wLcnVDJDbHE6i3
         OFoz/d8o5CVdoh4VRLIfWIGg9wajN7qBBO+3Yif6WeVj58fe39wKOdYUtlW9AGBmICdy
         KkXA==
X-Gm-Message-State: AOJu0YwRETs3OVRVi2H0NExuMheXwxck9Xvg7pYiqB4dOUjwSJUjLCju
	N0yoyzRmBAJ+nnhrq9ZpgD6OsIM9UCKaRkBFxJdsazQvjBNain3USavzQaFOXr0=
X-Google-Smtp-Source: AGHT+IHVOkWtXVUsCPMcDhaFkGaQQ9bEaa7mOE57s5PBMbNFYv6GPUBkZapD0XwDpzNY/ircsZyMVw==
X-Received: by 2002:a17:906:5fca:b0:a35:fe4c:e76b with SMTP id k10-20020a1709065fca00b00a35fe4ce76bmr2472891ejv.66.1706761287458;
        Wed, 31 Jan 2024 20:21:27 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm5501189ejc.31.2024.01.31.20.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:26 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 11/14] bpf: Release references in verifier state when throwing exceptions
Date: Thu,  1 Feb 2024 04:21:06 +0000
Message-Id: <20240201042109.1150490-12-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4957; i=memxor@gmail.com; h=from:subject; bh=Nohh56u+465Lt6chQfJ/XP9DJ0vNzIUQddkXi+4GSAM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwPsiKlloCSbpR7rik/dNtDX+6A8hr6oc7GV M0SCVqepNGJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDwAKCRBM4MiGSL8R yiZyD/9Bd4fZYPWh2vicTpzbCpV15itcFK8Q2Y1R3CYF7WlMCv5mGpknNN1gp6CI7T5DpNDlN07 AGYhlyp9HL4avvEK/SCVt7lY6MpBWzsYfGZorVs76I5gwOSl1FEoaeg4zMOxQn285A0oJAcpWxD nooIpE+FAbBo0df+J3dZpF2q8mlhR8q4nvGt4L8YfCuA7PPrEHceTLfEh58+uFRilDpwfqqtTOs 3PdWGCv+anez1hCX4wUhXivubj1/k0iCb3694L99k7ARGXOCcZIGjnlUs6VrOawGA8qfmEOKEb8 8EHvmDfFLbPIanmBqsDZz4i5HUzFI/ltTJy96zJI2b66xLnOwus3HVeE/pFdSlLZ4xwN4JDCdJ/ NSbC4kGI1Q74bs5zh7wneS8ndQeuYkpJGECJZlGcTTBTns9+6td0o3Jf2g/adRFIL/U1Ld2WTtn Lhi5hJnA8xcVQaTRzNwCtMBDRKm1ILVjqdVm34hyjG7wV9iLmby7Lgprnas39U9fRewcO4TixFx Go1SKgdlj/U00P9aoG4gDNxeU4cJNol1cH57M4rPQWhAgQLq8+8QHurNC9ODPsC6+J/fyQzvdq3 AYBc2s03I40JDlKnJjHncpLDcUEfyNKFWpOW0TH+9Tqx3eQvsmAukoTpJOLPBecSMv2p/1ZJbZ+ 0NMuWgcNXRsQAXw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Reflect in the verifier state that references would be released whenever
we throw a BPF exception. Now that we support generating frame
descriptors, and performing the runtime cleanup, whenever processing an
entry corresponding to an acquired reference, make sure we release its
reference state. Note that we only release this state for the current
frame, as the acquired refs are only checked against that when
processing an exceptional exit.

This would ensure that for acquired resources apart from locks and RCU
read sections, BPF programs never fail in case of lingering resources
during verification.

While at it, we can tweak check_reference_leak to drop the
exception_exit parameter, and fix selftests that will fail due to the
changed behaviour.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                          | 18 ++++++++++++------
 .../selftests/bpf/progs/exceptions_fail.c      |  2 +-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3e3b8a20451c..8edefcd999ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10221,6 +10221,8 @@ static int gen_exception_frame_desc_reg_entry(struct bpf_verifier_env *env, stru
 		verbose(env, "frame_desc: frame%d: failed to simulate cleanup for frame desc entry\n", frameno);
 		return -EFAULT;
 	}
+	if (reg->ref_obj_id && frameno == cur_func(env)->frameno)
+		WARN_ON_ONCE(release_reference(env, reg->ref_obj_id));
 	return push_exception_frame_desc(env, frameno, &fd);
 }
 
@@ -10251,6 +10253,8 @@ static int gen_exception_frame_desc_dynptr_entry(struct bpf_verifier_env *env, s
 		verbose(env, "frame_desc: frame%d: failed to simulate cleanup for frame desc entry\n", frameno);
 		return -EFAULT;
 	}
+	if (frameno == cur_func(env)->frameno)
+		WARN_ON_ONCE(release_reference(env, reg->ref_obj_id));
 	return push_exception_frame_desc(env, frameno, &fd);
 }
 
@@ -10283,6 +10287,8 @@ static int gen_exception_frame_desc_iter_entry(struct bpf_verifier_env *env, str
 		verbose(env, "frame_desc: frame%d: failed to simulate cleanup for frame desc entry\n", frameno);
 		return -EFAULT;
 	}
+	if (frameno == cur_func(env)->frameno)
+		WARN_ON_ONCE(release_reference(env, reg->ref_obj_id));
 	return push_exception_frame_desc(env, frameno, &fd);
 }
 
@@ -10393,17 +10399,17 @@ static int gen_exception_frame_descs(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
+static int check_reference_leak(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *state = cur_func(env);
 	bool refs_lingering = false;
 	int i;
 
-	if (!exception_exit && state->frameno && !state->in_callback_fn)
+	if (state->frameno && !state->in_callback_fn)
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
-		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
+		if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
@@ -10658,7 +10664,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
-		err = check_reference_leak(env, false);
+		err = check_reference_leak(env);
 		if (err) {
 			verbose(env, "tail_call would lead to reference leak\n");
 			return err;
@@ -15593,7 +15599,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * gen_ld_abs() may terminate the program at runtime, leading to
 	 * reference leak.
 	 */
-	err = check_reference_leak(env, false);
+	err = check_reference_leak(env);
 	if (err) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be mixed with socket references\n");
 		return err;
@@ -18149,7 +18155,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 * function, for which reference_state must
 				 * match caller reference state when it exits.
 				 */
-				err = check_reference_leak(env, exception_exit);
+				err = check_reference_leak(env);
 				if (err)
 					return err;
 
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 5a517065b4e6..dfd164a7a261 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -354,7 +354,7 @@ int reject_exception_throw_cb_diff(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("exploring program path where exception is thrown")
+__success __log_level(2) __msg("exploring program path where exception is thrown")
 int reject_exception_throw_ref_call_throwing_global(struct __sk_buff *ctx)
 {
 	struct { long a; } *p = bpf_obj_new(typeof(*p));
-- 
2.40.1


