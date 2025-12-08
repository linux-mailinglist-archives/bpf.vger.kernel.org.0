Return-Path: <bpf+bounces-76241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2249CCABCFD
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D54300E033
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7798D2E92D6;
	Mon,  8 Dec 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lORSpWZt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4F2F2605
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159781; cv=none; b=c4y6Y4ptpk9k2t3fvvJFN5KqXPV1FFlJvYUfVdAek0H9B0IVOzM4XR6shSGR5iKQdVKRfLiOw3rqrt3pPRIvjzz+ZbmHLpAe2OfrFyrNjkNR7CJyKSsMynsy6oHhwh+ESZORkg8W4RmamrAUcZdVqQq9Br4j/JChE4tgZWp70Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159781; c=relaxed/simple;
	bh=LY6P0dAJYqO06eYTYL9mCKnT2zcFVCemgCDabaB9pto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkHBZHJDvq4e8vDPcjlwdNkqWq59iPw+VukaRjBXOJBoxtQNycgSCw81Zo7YrJ18oD5Fy1mYSFFc9LUAtObYgoqWN0/NQIcNfS/Hy7KpEHOhksqGuCplgHEbfiw1KVlrz9cHFd8uFvdfX26bg/RKoywYWTwHvz8RkP6VE45t2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lORSpWZt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3438231df5fso4993782a91.2
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159778; x=1765764578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDK7I1Ei1vqPWb+trcQ6kq1evFmWu16zYe9jagCHVY8=;
        b=lORSpWZt/w9svGT4KaempIDVgE3oZa1mAzhFdj54I7x/QHZoCjoYLRWFJvykCwJyn4
         YUxB6mdqS7Vyrjryat+2gcAsybKHRHJNat8jls1lsY64fqEAT0Ddqg49fzK1mK20GmRs
         6BAFpDs798FPTIy6forhSSkn0wq3b6/9bROaZnWS+ifpO+WlDZOIscNRAJnhMG0opyzv
         khvXBCFq3kmaJaqBO7c6ql0mM8sJt+UZ4QwZoFADsCdY9k+/7Xk4S+dumIXye+KsBlqh
         kEOBEOmktnuVLGXQrG7GttMOLl/kkW7dlgmzy6R/jWpiW4234VG+K/i89yzLOQt8I2bJ
         aGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159778; x=1765764578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDK7I1Ei1vqPWb+trcQ6kq1evFmWu16zYe9jagCHVY8=;
        b=RGP+VBh0OENTEkO4eKTuUYGpoijoNOzYqZ1qkr5BCSZXNiLbiZJZOArE9DYCLhwfQT
         8QE8IqANFo+ILWQz8iM1mJJ/u01k4BvbJLx8eJgoyAROoQF864g6e7NspTP99LVcvJpg
         OBElUBh21z1yOT5/5KYQ7YOsy8JxV2bFdqwNgNcXvmMABGAslnB+8/eJbxvIJq5zmdA2
         Ynh6pq/9tTmvxTtcfRi9/y3n06g5zbNjTiOTnYn/NGTs02Gdp1AkxtbwfFFPgi0aOtt7
         jsYKcDp4wTkCXyGQlzIRQRoMnoCLAdsBC+BSrI2GrbNV55QZMtQEHDCXRpiTb6lsDZJB
         +9kg==
X-Gm-Message-State: AOJu0YxEuFJYyOsnmpccENK6fX1yCszp/xbeG6IoBAfDfE2fewsUjhY9
	P2qTwotA+pao068KqRBwEcUupF97LZHcRe3PfyhuldrHFqyTVRZHHRmNvn90UIiS
X-Gm-Gg: ASbGncveYXQ7mn6PMthPw5Q0OZXu1K1dkFJpigcjwZQ2boHwiKHnymRJp3YTYfITqsy
	zk5yNYNLnFbxBcZLsP8VocbZ9U2fMKjAfZXDEJ+VdzTYs8b+GE1gfLkt9nmxs/XFOSE/YiLgmmx
	341rMoCOzJh/gHzq4/axmvC0ADrQ8AaR3/GZONozJ4C+HEN1IbpjiBt7nOPBDd8i5k7tVYpcEAG
	+X5w9XjtKoFNgwXX81ZYFzhsXvEaT/Zh0N+9aSIzcRf4MRWVLSew2q4Rx6WbmBOWuOKMY5MZhtH
	dXfSFiC8ujZb0K3Jq5qJRvDHOCE/B+A+VmGMTikH6VKdPM3T7HOkxb4wWITFGdFV2E54ix62cdr
	ozzv8x/CHgoL/URgxwhoqptcS4NrPOII+C3c+Pp+SRFDz+LV7RtWNpcc3Z1+Jpdi3CX55A8kSSj
	ALNCqDWA==
X-Google-Smtp-Source: AGHT+IHnk48N7GfWdmf1kMC4bffUWqJcSiXMIV0msiClxiJbhD7wnlWdxJD9Pbf/YBk3hwohuhOEsQ==
X-Received: by 2002:a17:90b:1c0a:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-349a26135e2mr5899136a91.23.1765159778081;
        Sun, 07 Dec 2025 18:09:38 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea7bae1sm10288202a91.14.2025.12.07.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:09:37 -0800 (PST)
Date: Mon, 8 Dec 2025 11:09:32 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 7/8] bpf: Introduce CONFIG_BPF_ORACLE
Message-ID: <31dc70169ad42d25e0730d50c8816f83b0628980.1765158925.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

This patch puts all BPF oracle logic behind a new BPF_ORACLE kernel
config. At the moment, this config requires CONFIG_BPF_JIT_ALWAYS_ON to
be disabled as the oracle only runs in the interpreter.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/Kconfig    | 14 ++++++++++++++
 kernel/bpf/Makefile   |  3 ++-
 kernel/bpf/core.c     |  2 ++
 kernel/bpf/verifier.c |  6 ++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..390db0bcca3d 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,18 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_ORACLE
+	bool "Enable BPF test oracle"
+	depends on BPF_SYSCALL
+	depends on DEBUG_KERNEL
+	depends on !BPF_JIT_ALWAYS_ON
+	default n
+	help
+	  Enable the BPF test oracle to compare concrete runtime values of
+	  registers with their verification-time bounds. This will throw a kernel
+	  warning if the runtime values don't match the expected bounds from the
+	  verifier.
+
+	  If you are unsure how to answer this question, answer N.
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index b94c9af3288a..647ff7cb86b9 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o oracle.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
@@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+obj-$(CONFIG_BPF_ORACLE) += oracle.o
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fe251f1ff703..f89fdde66348 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1851,11 +1851,13 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 	LD_IMM_DW: {
 		u64 address = (u64)(u32)insn[0].imm | ((u64)(u32)insn[1].imm) << 32;
 
+#ifdef CONFIG_BPF_ORACLE
 		if (insn[0].src_reg == BPF_PSEUDO_MAP_ORACLE) {
 			oracle_test((struct bpf_map *)address, regs);
 			insn++;
 			CONT;
 		}
+#endif
 		DST = address;
 		insn++;
 		CONT;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b39bc2ca7f1..32c0146b9add 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20505,9 +20505,11 @@ static int do_check(struct bpf_verifier_env *env)
 		state->insn_idx = env->insn_idx;
 
 		if (is_prune_point(env, env->insn_idx)) {
+#ifdef CONFIG_BPF_ORACLE
 			err = save_state_in_oracle(env, env->insn_idx);
 			if (err < 0)
 				return err;
+#endif
 
 			err = is_state_visited(env, env->insn_idx);
 			if (err < 0)
@@ -22641,6 +22643,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt;) {
+#ifdef CONFIG_BPF_ORACLE
 		if (is_prune_point(env, i + delta)) {
 			new_prog = patch_oracle_check_insn(env, insn, i + delta, &cnt);
 			if (IS_ERR(new_prog))
@@ -22650,6 +22653,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
 		}
+#endif
 
 		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
 			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
@@ -25303,8 +25307,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = do_misc_fixups(env);
 
+#ifdef CONFIG_BPF_ORACLE
 	if (ret == 0)
 		ret = create_and_populate_oracle_map(env);
+#endif
 
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
-- 
2.43.0


