Return-Path: <bpf+bounces-20897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5217A845027
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCA81F28991
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7363BB2D;
	Thu,  1 Feb 2024 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMj4H35I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CD3B78D
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761287; cv=none; b=qefCVDZUeDIeJwglEYYj2HBAFddpYMRURfIajVr/PZjztNJzyfMSGiZH+0n9LYERL0Yhtx2kCNfbK3jaFCB5huCz4LJSDRXIlJHXpWtfpla5lCqQ1Fe1uRQh1HOB81pZNzE59UvWmCwgJGIc2VOMWDX8AEFk8riRsEjf8uMUZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761287; c=relaxed/simple;
	bh=Rvduhhs9SqJSr3lnxyZEUmCv0lcQNLMp4Px4fRQyQD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCM6QMUljZrnUwlfSuVoOFCIMTtivZ4b0Svgmm8pqY/NaiGA6wV0jB3xAXE4PmZeM/9IRi0hcPPQ1FEH21hDnQULyLnMZKTQPH1SVJdmTtqE82cgXpPxS4E8aiRvejNDA38hCc4Obc/Sg/hP8zvVVbuhYohHzq7AYoGflePF+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMj4H35I; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d043160cd1so6555291fa.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761283; x=1707366083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8fvce7p2wAAkT/EkHD52Iuw7K3tvalS7pMOB11qeDI=;
        b=DMj4H35IR+rRMIo5K1vjrTrYiNSuDP/ujTsy9xUneq7pNvk+eFOtaj0YLPN/lvTv6e
         sDj0qTI2yVwoIumDh5urWZbRPb/2sOVhEZp0uwCsndEl0pMaUZioM1DIB1HyOKUgvzRb
         ExN1PN/OAwPX7tBUYS1xTrz4jonVdhXjGd1qN7gR2mg8Zonf9MGt8tZPZFiZRSD3kN4Y
         LhzgPC+1m8mCS1AvmRo8X0sNxaiUWJVSgc3S7ItlDv/Jr66R9AAUEgd9WKsMSuzVFCfs
         0baGcpjdBi1XnqQOUQadNI4HykWqBJy8eI34AB1bHU0dYa6vyjqDmeQZ93f1duomJGS3
         9YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761283; x=1707366083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8fvce7p2wAAkT/EkHD52Iuw7K3tvalS7pMOB11qeDI=;
        b=DvL9ZcA3na+JNg8xVXIH9FhD0pLbKOGge+TXoUXbWv6ax1FWQXc8/PJHiFANru/ld6
         T3R5QRcBA2k2pXQuC5r0epXenb8xjxtZDjUbd3D0gS797sIcKpynk3wAwDSa1frPIUNi
         nCynunmHsyaVYj4/x9roBOgSL74HMdeJJ9LYY1nLDjnA7HTXUKONE/w/2kznDfnmgCGw
         +zzrU4hRtlF6C1iMyBDDgUaim4ssVWLJK1HVjWnuJUE2XGaexiLOgZtQoegBlqE9z5Ta
         7mzbhgvAIsrmG6O7gcEH207YbYB7rQ9ZekhjtjksR5uRPT1r543I8g7GTrNbjoxKYf/g
         gLwg==
X-Gm-Message-State: AOJu0YxHmfEjWoUL+hZMZQEW5Voc7dlOHWJuuzza5gf1x4crKURsecHI
	Jg09+qxSOZf0wSRtMdBdw2/XddHKv7dD8GML8DvWlOBQLuG8j9HL5GNrvZDv
X-Google-Smtp-Source: AGHT+IG/ELi2M+tAqxNjM45pJTMr2zKRZ1nxfU9IC+lDjq/dpIC/i/YP1D0XgMOJwiHxPuRlY8NpGQ==
X-Received: by 2002:a2e:2c06:0:b0:2cf:1aa1:beaf with SMTP id s6-20020a2e2c06000000b002cf1aa1beafmr2351314ljs.42.1706761283238;
        Wed, 31 Jan 2024 20:21:23 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id c8-20020a509f88000000b0055f43384da2sm2252707edf.56.2024.01.31.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:22 -0800 (PST)
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
Subject: [RFC PATCH v1 08/14] bpf: Compute used callee saved registers for subprogs
Date: Thu,  1 Feb 2024 04:21:03 +0000
Message-Id: <20240201042109.1150490-9-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012; i=memxor@gmail.com; h=from:subject; bh=Rvduhhs9SqJSr3lnxyZEUmCv0lcQNLMp4Px4fRQyQD8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwOx+WhL0UXhC7OxmrLqpP+SYybZBX63Bc+T Ili6dTdPbeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDgAKCRBM4MiGSL8R yiWXEACeROP15jWMVl4+a2zSzs36yger9vW/bybWdk1acxSJQua6modZZytpylahFRUgit+A8nw IShoG4MF85djBbhEBL7ZniL6r081tBujc8b3+k6Vu/6ootzDdU8quzQXYS69gXoNAVTcA9pQ3Ed ACzaypCBx8nZ12T66W2V+AO5QnPJjvTZPTBt8ANcfnEaUXBmNazNBHBvPWKLOXanNWkqfnJnp8Z j+EGR7X0BXGjD9d8t1cbudXNYXJz2miCP9N7+wZ95s+AIjFCNfkx0qAqeXxbu1CyIvL4SCwaDG3 4qrJwc2rKO0ncUP53RAIKDjdnRd62BviPRC8whGJsRHlJ7JQXErw+m8JKleXJG94IvtHuzgXjr6 SDAJaT4Sav4ktIbdfqG7GdcthXve9tNbirPR8SLZpvZathC5PHhMWMPJSCpziqWL0DvpzFln/F2 ICBPdmHkECofqQ6oScBJH2yX0w8DTpmJp1PYVoaFypeXq1elVq2hp4tMiK8+JPCAl0d4K0dQrqm uWu1TJJkg61EQ/Q30dKXn6TR3fjAr9TlBrHb0Zm24iFJP+kAJm1ATEszJzE75pEsmMtL/c5nsab 7Y+rXe+OCvk2S13Mz8gQoy51FucdzM3ym5igWInQ2hNzYHH9+VXk/HX0rwfcFmMRrF3xoXnutX6 i2PYhpOsYBxqGTA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

During runtime unwinding and cleanup, we will need to figure out where
the callee saved registers are stored on the stack, so that when a
bpf_thtrow call is made, all frames can release their callee saved
registers by finding their saved copies on the stack of callee frames.

While the previous patch ensured any BPF callee saved registers are
saved on a hidden subprog stack frame before entry into kernel (where we
would not know their location if spilled), there are cases where a
subprog's R6-R9 are not spilled into its immediate callee stack frame,
but much later in the call chain in some later callee stack frame. As
such, we would need to figure out while walking down the stack which
frames have spilled their incoming callee saved regs, and thus keep
track of where the latest spill would have happened with respect to a
given frame in the stack trace.

To perform this, we would need to know which callee saved registers are
saved by a given subprog at runtime during the unwinding phase. Right
now, there is a convenient way the x86 JIT figures this out in
detect_reg_usage. Utilize such logic in verifier core, and copy this
information to bpf_prog_aux struct before the JIT step to preserve this
information at runtime, through bpf_prog_aux.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 83cff18a1b66..4ac6add0cec8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1460,6 +1460,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool callee_regs_used[4];
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 04e27fce33d6..e08ff540ec44 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -620,6 +620,7 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
+	bool callee_regs_used[4];
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 942243cba9f1..aeaf97b0a749 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2942,6 +2942,15 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		    insn[i].src_reg == 0 &&
 		    insn[i].imm == BPF_FUNC_tail_call)
 			subprog[cur_subprog].has_tail_call = true;
+		/* Collect callee regs used in the subprog. */
+		if (insn[i].dst_reg == BPF_REG_6 || insn[i].src_reg == BPF_REG_6)
+			subprog[cur_subprog].callee_regs_used[0] = true;
+		if (insn[i].dst_reg == BPF_REG_7 || insn[i].src_reg == BPF_REG_7)
+			subprog[cur_subprog].callee_regs_used[1] = true;
+		if (insn[i].dst_reg == BPF_REG_8 || insn[i].src_reg == BPF_REG_8)
+			subprog[cur_subprog].callee_regs_used[2] = true;
+		if (insn[i].dst_reg == BPF_REG_9 || insn[i].src_reg == BPF_REG_9)
+			subprog[cur_subprog].callee_regs_used[3] = true;
 		if (!env->seen_throw_insn && is_bpf_throw_kfunc(&insn[i]))
 			env->seen_throw_insn = true;
 		if (BPF_CLASS(code) == BPF_LD &&
@@ -19501,6 +19510,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
+		memcpy(&func[i]->aux->callee_regs_used, env->subprog_info[i].callee_regs_used, sizeof(func[i]->aux->callee_regs_used));
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
-- 
2.40.1


