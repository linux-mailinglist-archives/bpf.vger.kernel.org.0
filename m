Return-Path: <bpf+bounces-34642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647892F8BD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEC1B215D2
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68182154C09;
	Fri, 12 Jul 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhItA0dN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1A13F439
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779268; cv=none; b=k/a2hiWDAEwa+uHGLVxqpRBzAvlG9tGAuOMJuSe5NOm5hQ6UazRWnmLBUQNRFUdfxtiAANMmVpXbZimHq8QifAeSqsOSHnaWbnQIw6Pm7hM57wpSkCNUlzqe2ugeJOWQj+GNHvqJLRj7AoPdS0Knj9DiD8SkQssmGSxfg17s0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779268; c=relaxed/simple;
	bh=TgYjiAZYqqzS3zDX6P4Okluhp9fFgIXHODSjz8qNH+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUn4CeQU1m8r51XKLHkNFvYZr0qKcwiDecP60d3EG6PsKzxfVLcfbfIyX48HeQm3wRd9KS8W4e73q4BN2mFRlz8oIQWHbJGKMXMXpCPytcqvfQZWe7Z9zKWA/xu4WyccpfCZELilH2ccdu65DmkhQBUHFvYLWXYmtU47rARES7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhItA0dN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE57C32782;
	Fri, 12 Jul 2024 10:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779267;
	bh=TgYjiAZYqqzS3zDX6P4Okluhp9fFgIXHODSjz8qNH+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhItA0dNIfMoDhjMr2uUUrxLcxKXZp/ZVyusEVFfDezJfNnekHOa1PIgF8gOo1cfg
	 aeO+knzSlB/+RmouOXkL5y3tNR0ruCCrPpXXdSGBoDA2BdA5z10ebqXG/9FWa22V7M
	 kYtt4UH5hAr4tS3HaHF7vD/W2uDwQPKJoj7NrSZvosNwOLbTFzIkz3B243rWRCc5/x
	 CcKD1W2Wj6zQyjijfHYGVRL0p9JBu4l9OpzB8NvDsruYg7wiRq3tZWMsPEOvics5GD
	 Ji0exViGX60TeKKuXHcXr2UvSEERSFEaFo+Wof63OUOUIxJUmcweFwEGw5DBIJdcjA
	 MkqjNPY90im9g==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: verifier: Fix return value of fixup_call_args
Date: Fri, 12 Jul 2024 18:14:12 +0800
Message-ID: <9a002aaf658c4dfb3997cf9c5981b3b2350e5c30.1720778831.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720778831.git.tanggeliang@kylinos.cn>
References: <cover.1720778831.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run bloom_filter_map selftests (./test_progs -t bloom_filter_map) on a
Loongarch platform, an error message "JIT doesn't support bpf-to-bpf calls"
is got in user space, together with an unexpected errno EINVAL (22), not
ENOTSUPP (524):

 libbpf: prog 'inner_map': BPF program load failed: Invalid argument
 libbpf: prog 'inner_map': -- BEGIN PROG LOAD LOG --
 JIT doesn't support bpf-to-bpf calls
 callbacks are not allowed in non-JITed programs
 processed 37 insns (limit 1000000) max_states_per_insn 1 total_states
 -- END PROG LOAD LOG --
 libbpf: prog 'inner_map': failed to load: -22
 libbpf: failed to load object 'bloom_filter_map'
 libbpf: failed to load BPF skeleton 'bloom_filter_map': -22
 setup_progs:FAIL:bloom_filter_map__open_and_load unexpected error: -22
 #16      bloom_filter_map:FAIL

Although in jit_subprogs(), the error number does be set as "ENOTSUPP":

	verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
	err = -ENOTSUPP;
	goto out_free;

But afterwards in fixup_call_args(), such error number is ignored, and
overwritten as "-EINVAL":

	verbose(env, "callbacks are not allowed in non-JITed programs\n");
	return -EINVAL;

This patch fixes this by changing return values of fixup_call_args() from
"-EINVAL" to "err ?: -EINVAL". With this change, errno 524 is got in user
space now:

 libbpf: prog 'inner_map': BPF program load failed: unknown error (-524)
 libbpf: prog 'inner_map': -- BEGIN PROG LOAD LOG --
 JIT doesn't support bpf-to-bpf calls
 processed 37 insns (limit 1000000) max_states_per_insn 1 total_states
 -- END PROG LOAD LOG --
 libbpf: prog 'inner_map': failed to load: -524
 libbpf: failed to load object 'bloom_filter_map'
 libbpf: failed to load BPF skeleton 'bloom_filter_map': -524
 setup_progs:FAIL:bloom_filter_map__open_and_load unexpected error: -524

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0263fb5ca4b..aa589fedd036 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19717,14 +19717,14 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	if (has_kfunc_call) {
 		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
-		return -EINVAL;
+		return err ?: -EINVAL;
 	}
 	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
 		/* When JIT fails the progs with bpf2bpf calls and tail_calls
 		 * have to be rejected, since interpreter doesn't support them yet.
 		 */
 		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
-		return -EINVAL;
+		return err ?: -EINVAL;
 	}
 	for (i = 0; i < prog->len; i++, insn++) {
 		if (bpf_pseudo_func(insn)) {
@@ -19732,7 +19732,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 			 * have to be rejected, since interpreter doesn't support them yet.
 			 */
 			verbose(env, "callbacks are not allowed in non-JITed programs\n");
-			return -EINVAL;
+			return err ?: -EINVAL;
 		}
 
 		if (!bpf_pseudo_call(insn))
-- 
2.43.0


