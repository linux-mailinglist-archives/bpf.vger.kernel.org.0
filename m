Return-Path: <bpf+bounces-21179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8593D849118
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE951C215C9
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51C32C8E;
	Sun,  4 Feb 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMYCfISa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D32C69E
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707085435; cv=none; b=eRRdyItjnoCAGqNRUt3/BigvzfAlHjSMijMg7z5NkAIALXZxvfQ58Q2tT4lozRZFJjxswwkY1v2sBsWgVOxGk0pCOV+A+HJBZwhfxDD3CqAAvWiUnrR/mHM3I5vdqLNO698+8oSJPb+uQ7F5InGEQyuRmljvB2wqZ1S5YYO8mrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707085435; c=relaxed/simple;
	bh=f++ohieD8ClMSW1AetryGM/gVPfZDbl+hUxTIaM/wgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwT3BKwmNjXTcntTLYBcJ4yxBtWAj+mRpnMxvYOW1vLmUsNW3CMdvN0nqzplFY45BdPMf4YhOVPl/1X7Z0+GhNwqd36fzwkfQVDJ2L5bSKJ14ezJw98DjaXmR7iggFrSQnS2TPKTs6uwafhNPhua7NyHARYqXgh5nzB8/qxzyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMYCfISa; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a3604697d63so581670766b.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 14:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707085432; x=1707690232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONe4W89vBZk35RcjhZ55nD6jdsU8ohKno5y3DhM6GMI=;
        b=hMYCfISaXNtKlfP1LqzUO1WQDH/cYGQfrZv71TMhkfAD6wAqI3FZ1GD3FjZEyrziYJ
         F2fWcir6BbxKTqLJbcUxqedz8Nk1aMXdHe4zR+CbkW8ozfPMncTr8Om3t4+sp0zE5hCw
         CfnS3QYhB7f//D4tTJ7s4Bdl5fXlGzjx18y8rN8FqEuM8XjCDSNZpquP5w0UYu59gThw
         XHOngPAw0lyRa/q8qrpniDkQp1WCSVlq0Bvf05R8kQmYFfFcLiRDHEiaTWlZAmay8CUI
         Gc/F7Ec0/+pVTzQCoraVF6U4p5ERY6D32F1TgxiTKcTRfdsOdjbp+TOH0eYDcAxDQxxP
         Du9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707085432; x=1707690232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONe4W89vBZk35RcjhZ55nD6jdsU8ohKno5y3DhM6GMI=;
        b=pgjQt8i30MO9+LecMjOwYcTrmQDB00usGPZqGcLv5B39td9+k0D0UbasbEK+sXJ/O2
         Q1+mhvBVDxdOCcdt6IKn+kwmIt5fKCpamM7vPNFLEr817GXpPgQ7cvE1XoOptgycpwmX
         bfAO/9OiYAHRBiHyWgt1TyU7hCvdYxiwO+Rs53HAndEy+7Jby03yFm5GhYRXUbNBCJ8j
         HAupT0yOtttvClCYOoM9jbXV9WLbzbD3dhXfZAXPg9/4yQv0dGpFDBrlCuSaZyI+QA94
         AjoK4su3as4VkRMW7ufAxBM4aqyKrQnPAseFFO4WwRLb4oRpKnmkHhgPnwANWh1Ii1gC
         ZGCw==
X-Gm-Message-State: AOJu0YyDHS1+JahL1X//ggNkOkYTmDi2+UMVWHjBpoBudCFJdi0dinTp
	n/+Rgd6D/Q0AYX+PPeN+KfzT1HaSsBRJmW3pGmIeJZWmbeayh2kH/oS9BTyxbQU=
X-Google-Smtp-Source: AGHT+IG02B1vpJSvRuf/NX2DfQivVC90vdYrTRd46fmlSPdkgfJlpsgkTAvF+r7wevifobLTpkQhEg==
X-Received: by 2002:a17:906:fb8d:b0:a36:7b8c:8a10 with SMTP id lr13-20020a170906fb8d00b00a367b8c8a10mr9585199ejb.74.1707085431961;
        Sun, 04 Feb 2024 14:23:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkS6OTRVmy8JwBB0V2giB4cvwipmHEEr1sCiKbAeDSEsr0Dlt3LJm9YYT/KYlsoYc7f6llckZ3XTcqwZeKhVGNbIFlvb3R3olmNT0V8oy5u0jR/HwHJfgIU2xYpQ/QWWyhND7N+NzyXSV7shVxiMxSH4kTWbNefjdAz6U69Vd94K8CFylb+ao+CbG2E/H03rrX9LRraGr14nFEXBNpKm7ePtgiT+WZepshGkXXc2LpTpuV
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ub14-20020a170907c80e00b00a28f6294233sm3553903ejc.76.2024.02.04.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 14:23:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Allow calling static subprogs while holding a bpf_spin_lock
Date: Sun,  4 Feb 2024 22:23:48 +0000
Message-Id: <20240204222349.938118-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204222349.938118-1-memxor@gmail.com>
References: <20240204222349.938118-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833; i=memxor@gmail.com; h=from:subject; bh=f++ohieD8ClMSW1AetryGM/gVPfZDbl+hUxTIaM/wgo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwAwrzIJDbB3UIEEArgqQa6Pi28/ux1TWi2Trz J2XFVyPdwKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcAMKwAKCRBM4MiGSL8R yscpEACQi8MFStbOr67vz+3++Arv8v7U79ZO58tnXR3QRp0VECjk2p8jTNmqasXSiB5l3rv9/Z9 XZMcP7lJHZC7Nv692duxW/HjldDUY1PbrZ8dL332i1RBM0EJ4ZpDRVsnItrRwZuV2Nhsnr+zQR5 4UGY8h1z6zkE+ckKxeK3dERDW1A2X9E/HZys/L/s0uCwcjGtxriLxqSlJkOOt+r4lZExSVeRy6H dYchAB1WEs/XontsJ3y63Aa0fuOkElhMLV9N0UAhxmvU16HGojXkkMz5grs7W+wxSskv29ZvM0V iRp4yNw321IC/FmOjKGZxJ5OSZMAzCKf8mwOuGUCd0DErUFcCDeBQs2LJyz9RbklIw3u7ySVqqT cL4NpIagO+qJy4MtNDt+GmkLV/wL+OGgGUEbDMVBmDD7JWOGeVsmFW5MYW38m8jkoJkuAxA7/eQ B51abnuKB5LfjnIi/dgqy6SfjarILv0QG1Dou0fyo7TQkHM3LJALBiQWgYrxSlq2lBLOmTa2RG3 kTR9ofyHnuiwiKEbSD8nmvGOJcQwKI66YDFkqZLxB9+pjeEh6G+IHHVNLLd7EdUGtfZMu1QoIka APi4Mc0AyvllOp7gO2eL1S5SpBoUzcg0JtNq8DBqEx+i9r0Bi5qJ+2Z6+kYlvOAVIRGrkluRxcy fK18Jg9cAQLL2xg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, calling any helpers, kfuncs, or subprogs except the graph
data structure (lists, rbtrees) API kfuncs while holding a bpf_spin_lock
is not allowed. One of the original motivations of this decision was to
force the BPF programmer's hand into keeping the bpf_spin_lock critical
section small, and to ensure the execution time of the program does not
increase due to lock waiting times. In addition to this, some of the
helpers and kfuncs may be unsafe to call while holding a bpf_spin_lock.

However, when it comes to subprog calls, atleast for static subprogs,
the verifier is able to explore their instructions during verification.
Therefore, it is similar in effect to having the same code inlined into
the critical section. Hence, not allowing static subprog calls in the
bpf_spin_lock critical section is mostly an annoyance that needs to be
worked around, without providing any tangible benefit.

Unlike static subprog calls, global subprog calls are not safe to permit
within the critical section, as the verifier does not explore them
during verification, therefore whether the same lock will be taken
again, or unlocked, cannot be ascertained.

Therefore, allow calling static subprogs within a bpf_spin_lock critical
section, and only reject it in case the subprog linkage is global.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                                 | 11 ++++++++---
 .../testing/selftests/bpf/progs/verifier_spin_lock.c  |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..7d38b2343ad4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9493,6 +9493,13 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (subprog_is_global(env, subprog)) {
 		const char *sub_name = subprog_name(env, subprog);
 
+		/* Only global subprogs cannot be called with a lock held. */
+		if (env->cur_state->active_lock.ptr) {
+			verbose(env, "global function calls are not allowed while holding a lock,\n"
+				     "use static function instead\n");
+			return -EINVAL;
+		}
+
 		if (err) {
 			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
 				subprog, sub_name);
@@ -17644,7 +17651,6 @@ static int do_check(struct bpf_verifier_env *env)
 
 				if (env->cur_state->active_lock.ptr) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
-					    (insn->src_reg == BPF_PSEUDO_CALL) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
 						verbose(env, "function calls are not allowed while holding a lock\n");
@@ -17692,8 +17698,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 process_bpf_exit_full:
-				if (env->cur_state->active_lock.ptr &&
-				    !in_rbtree_lock_required_cb(env)) {
+				if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index 9c1aa69650f8..fb316c080c84 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -330,7 +330,7 @@ l1_%=:	r7 = r0;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: test10 lock in subprog without unlock")
-__failure __msg("unlock is missing")
+__success
 __failure_unpriv __msg_unpriv("")
 __naked void lock_in_subprog_without_unlock(void)
 {
-- 
2.40.1


