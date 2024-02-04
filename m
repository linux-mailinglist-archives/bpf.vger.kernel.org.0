Return-Path: <bpf+bounces-21153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC3848D56
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E92B21F54
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C22230C;
	Sun,  4 Feb 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT51WD0c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952522307
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048133; cv=none; b=R8u0OJ9xRAHpCyV/Jm3/95OEWwRSv6Mw5MQlXb55mQY9/Qldwxdh0xIrQW+Wo6bjyKOd73X1iHnm1GWnpv0QgUQHoD/Vtwz3K/LhSEWAxnh1Ql2OAy/gsTAmsdBYttxxPGPalr8Vli1znGVsKT1hWfGY9ryxmd29Cn9Y/KAI25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048133; c=relaxed/simple;
	bh=1D+0e4lxqQ2NsJexlaqJwD12opFLMsgwdRObSdCNd/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UikkpVr0Y3vyDyu0kPqxI0eKZjq/LAhZM4/O1QoXn0NVQf1smZIBZWQcWS4H9Ku5xJVMbntMX3hufbkChPHfaxXUlkXYDJdjUv4ooHlGEWX7cDQI+jc7PcS0kUSM9Ate37MDi9Bcx2S6NAB/Lp+bKH5DazS8567gHeSxILVB6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT51WD0c; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d066b82658so51046711fa.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 04:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707048130; x=1707652930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OF9JzOYFGQAwu6uinLNXJVu80ftmVeZXe3o/4abg7Y=;
        b=iT51WD0cILuYkcHEO/bcYXdCJESe2gi2m9rUK5ZVKZ1rX0U+uRKCoJ9KDiZHx54cBZ
         lVg8kCeqPCxbgvjAldNujMjlvf4qvbKUDN+5kxgFtR+N50EYHId2wdhqrnUw0xJEArXx
         xMgIcyyDZj2mvxm0kda1ShIAL7sKT+OaGE+pLkaSVL0OFxsgsYHCuwilT0k4DIRBQSmY
         OZHieWjNZcqYDLXg0MEENnZfnChYfSoTFtUGn8PQLBvWBk9gHJhslOZCJCSTWkg54Xj4
         orjNRhD57XcxWlVCu+qY8lOGHNWfD+lyRfEl92lW5faMzl00vxwk0B8xs+g3MH3AnbBi
         G0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707048130; x=1707652930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OF9JzOYFGQAwu6uinLNXJVu80ftmVeZXe3o/4abg7Y=;
        b=Lb7XReQU1DTLv7oQkCgjTDaKWZcgeryYEuMyZHBlIOAKXOyDjF3b23mokcd9d4SR02
         iqei0RZtxgYSIjfFa+YBUBS4XlAh9uxkNCt/pdmVHoQWpFY1vh2/VqsweZGs/m9ifwai
         KbJa06sFAZLysXxhdnTQ+trCc9mDXj6ZDkyIpZeIXQ6kG8LlxJOZjsHGcTxCkuLVYw6F
         wah3EIdHenPcozivhJViwQJArYRLHEQ6ZT6AgeMdKcZYdoR4SSZB1vj5CFGtHfeU4T4A
         4gcoLoa2gCe0BFBBJTChA8xYct9DBOoG8VGd/RybRCe73O7fHiSBh7fSo0MAyupqURqC
         lS6g==
X-Gm-Message-State: AOJu0YzfWlbcWVliMMtwwTYOSOMEsuHaEs5+N502UgM2+YIP/vhVv0Hs
	R6d48eLusPAUphzgyaeQTo3iTjzb++toPV7+hTbwpAOaHeyXZWmy2hT5Yvvl
X-Google-Smtp-Source: AGHT+IGS9u9NTLlYZGtSAkMCxE8cp8StRjntIY6Nz9ntUu7GExEhuED872De0yriWNupYHj+0brVOg==
X-Received: by 2002:a2e:3c11:0:b0:2d0:a21b:c62c with SMTP id j17-20020a2e3c11000000b002d0a21bc62cmr1152399lja.52.1707048129667;
        Sun, 04 Feb 2024 04:02:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPPM2lT3mxhZDNoJ+r1iAC7TJcRffzDb55A6NbjGRcbTRvKyOnfRAwTdd9166GsiHDZKmAjOPSW6mNakA4Rq7JRF8QMg6vrAAX9W+oMGDkCfAh2lEF4adqRBLBpX/Z+S5AVKWqNJtjKOBlmO8vMQ25k1/G61P0+i3mvmZkw1jXQ1qeY8/tw7SJHCeMh8UUG3U7wUQYH6v66MwFf32lN+jrHAw=
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id m23-20020a50d7d7000000b0055f0f643ebcsm2811620edj.96.2024.02.04.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:02:08 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 1/2] bpf: Allow calling static subprogs while holding a bpf_spin_lock
Date: Sun,  4 Feb 2024 12:02:05 +0000
Message-Id: <20240204120206.796412-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204120206.796412-1-memxor@gmail.com>
References: <20240204120206.796412-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3687; i=memxor@gmail.com; h=from:subject; bh=1D+0e4lxqQ2NsJexlaqJwD12opFLMsgwdRObSdCNd/A=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlv3qDbT1fswmLjWSERvg8ZsenAZizP1pcqp2hs vPluDkg1WuJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZb96gwAKCRBM4MiGSL8R ytUqD/0X8tPUuAwi8Dt+QAcu004jFpFlC5xX2C9H4hHSGy5GTv4lurhg7GdTkiRYRhR46ilh9Zv rU0SZQYfSWce+M37cr5rxZvZ0ohGVqL9oefigL+ftq/5GNOTGZ45bbx1onQaFTfGAPzqBFkd+hW A/+/oS27T2V2+b0r6vM01tPQQu9SRhTxIPXlfZTeBARwtG/j4k1SI7XOmOc1uSRpqzR+9QFiw9a PyWiOFvpvnT7CqzD18Z6mhOih2mH5Yc0knOrHyo3Jn0dVkiDIkpDpEZofamqLoL7KSPAf4I1lr2 CPJ7ryymxd15XV9DbIzSLOpzxzrZ1kzpO34bUm18EQLIpPf/p8Nghfe/kGvY2bTwyk71jQ7Jp0v wnJEcjYAohXBiMgLNfbhngr+i4+vrW+OzHxAf2M4nFESeOB+hy6HR7fbdvvwS144gDLmN3HuGcP KdnfnCdTXLgc7fYjlKSyAJFnQb4dph4dwSEli3oKaSI0LTCXfAwyFE8OcomwuQn3wUQPGvvUwEO L7EMhUVfW67kvjmTVugd2Is0SxQ9LLZVl36G4sXqJC1NKR/jbfar4jpygHuFPN/5Aaby5KRzYqc DtQL7KLrvMzDwhi2qW7oSfN0WX4veYnggwUjtbwu5GEM16ivUbxDSnT7X4Xo2PsSuj/uXMUsCo7 okUCuL1gc0qIZSw==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                                  | 10 +++++++---
 tools/testing/selftests/bpf/progs/verifier_spin_lock.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..f858c959753b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9493,6 +9493,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (subprog_is_global(env, subprog)) {
 		const char *sub_name = subprog_name(env, subprog);
 
+		/* Only global subprogs cannot be called with a lock held. */
+		if (env->cur_state->active_lock.ptr) {
+			verbose(env, "function calls are not allowed while holding a lock\n");
+			return -EINVAL;
+		}
+
 		if (err) {
 			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
 				subprog, sub_name);
@@ -17644,7 +17650,6 @@ static int do_check(struct bpf_verifier_env *env)
 
 				if (env->cur_state->active_lock.ptr) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
-					    (insn->src_reg == BPF_PSEUDO_CALL) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
 						verbose(env, "function calls are not allowed while holding a lock\n");
@@ -17692,8 +17697,7 @@ static int do_check(struct bpf_verifier_env *env)
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


