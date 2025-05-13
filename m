Return-Path: <bpf+bounces-58085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA1AB49C3
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 04:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5BF7AF619
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1D1D47B4;
	Tue, 13 May 2025 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz9gmq4o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242931C683
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105072; cv=none; b=IXLpMqaoNtkRU/HgHvaiEhmPAelrjBly3CVXqgVVOYSFB6mTzKcRHbefyGG/YtfRsi91hKNwW0N4wymq/NkLRBawuBwTeqEa7UY1TTB8gIEnvSay+fMHc6ZwRf/Q8c3ErwBwGFe2TL8yOItO4M7fsNuwuMn9WJZ8caUqWmDUCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105072; c=relaxed/simple;
	bh=SyyBlPPKy6Bd8qGv9bdhXvxuEtsDqwZeRvocL9cHtTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snbXevt7JTMqhs1erZq6i3Ctgw5xCkdhI48aPKKJMoxIFU1QE4h1GdoMtU5XAt2UjuyX9YoQlFjkT5leZ8RMPF4GnbSGni1D2hkhtYN5DKKqX36pDHsAvTkjlw73CtS07JB+sVnkwc6zX3Lz0lxy3h78AXRENQYS5moDKT/DdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fz9gmq4o; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so659945e9.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747105069; x=1747709869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mM91ATpq+AwaBg+v30ZwLoSTsQ/uvZIzpyhQJYUG898=;
        b=fz9gmq4oKVMDSUA0F2L8SUbhDLKN5XkYFXAuHmb9jMGVRfW7wYxfbdnx50Z4Da9Vw/
         MpWBOA6K+/PJITrnp8hGPCdP7MREJUqMiLDVzgCfv9XYKGa85g4cz7iHGJMEOXhefZLA
         I5xJqr+l/7QfKoId2Q0sx/eWYzkbGRRJnWWiBAC0+NlKR3Gti0BxslN+cHCb31ExLYew
         d0D5y8rEiPKJDe1eNMwiJgY4098XfjIeESy6FYIm5eZXDKjsJNuXz0g9SJZgl/hMtW6j
         QRQohkfK/ocrsYHwChaBmxB1h/pgt8I/yVpUMnUaxmiXSdbS6JL339pHcTbgJ9E94rkK
         cmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747105069; x=1747709869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM91ATpq+AwaBg+v30ZwLoSTsQ/uvZIzpyhQJYUG898=;
        b=O26adSdjsyyWzY0w/LM2HPn9O8LrAP0w6bptaz19dh5ak7dCPi1A4YDnH4g+IrzFaZ
         3NkKTr516lLAUMahgCA8owbJFOMTAOYd3MiZluMYgu1a3vsf5CoH37yNhxpYgspGiRxH
         4ia4zM/xaL9IWxE8G0O5ntobsIGn5kuOKWl1/hEadCryBU5/oVyjSZ1utHakMEQxXbhD
         oXc+XtcUMkbzGJN2llV/wzcDntnjwijYduDAvkl/6+nfde2wfSX3SxxfWE/P1rmENhP2
         AGXrIJPHy7+tYeYu2kMC0/im1l8LREUPW2xifXr2GI6+E4QDDkw9ylTmgovpVLqFl7CH
         P9Pg==
X-Gm-Message-State: AOJu0YwenUkTr3+sl5VSK6wlJn7dIThEjJ4CxY6eVEu4rRHtAt33+XAJ
	JQ4CzUlixoDSqhwYT9/3Mi5yQrMemZwjpEZFVm8ceQl6RfYY+QzaHlhrEfTffwdb+w==
X-Gm-Gg: ASbGnctGQfjcrAXaylKJi1Oe0wuRK4N5KEHzLKw9mxYFkFhSyCrfkxAjW82d1CD+Gqr
	FjuFxwl/TnjUepiK3zyc9fW0ORNkk7Fgqc3nZbJC2RaE/WpMa3hkxKVvVqBVkcXPOIv9FE9RkZC
	5F6K567FcCiiOR8N0nHSd4Lweg3O2n8cLkgj/MED9xnpk3j2o9Hs81TRVFfykoAsuALnweNDJRI
	Qs4KU9RlUCg+akVaKUC/bMsqi7sljsk7UnWXySgOgBYh6waaINjQSuTzMzFLvWpR4lBPXs7UZaz
	1J1L7m+Rk0WGgJJaUFwxlckZhz6PS2/BwgCAj41+J03cFYzo+xgC
X-Google-Smtp-Source: AGHT+IGOFPYCcKwyGz2zbzGXbG+wJBxVwirbeIYwXeLU+2pBSU6DDUXD2PSLeutqWyWj/V3ljqeiHQ==
X-Received: by 2002:a05:600c:a42:b0:441:d228:1fe5 with SMTP id 5b1f17b1804b1-442d6de0f78mr111446405e9.33.1747105068680;
        Mon, 12 May 2025 19:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm146359015e9.19.2025.05.12.19.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 19:57:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] bpf: Add __prog tag to pass in prog->aux
Date: Mon, 12 May 2025 19:57:47 -0700
Message-ID: <20250513025747.1519365-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3962; h=from:subject; bh=FfO5xvMJEViiSbyKQO6Si8LX+lFYuAFcyVRBoQUbfkg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoIrRq6RWIeoJo7SdxBjwS5QrzgL4aJAjJVcR6z3Jj ffAmmG+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaCK0agAKCRBM4MiGSL8RymR0EA CZKT47/TcN7Mz+vBKhp9tRvWtsd8yx2fvHUVpJvrMwxK33pxCc5aIo9ZFC5DsnUYLLrPk/s6dQ7D7U GaKPdEzSAoPk+mtVdLuJzoe/H+zhXd0eO8887ADWt3qpG1D48p6Q8eEwQGoOJX2wDaBpvw3LAJ+oGx 4EdzmyDFlqmpWH0StE2+PuqOfutXobVYKw2X7H9uhQ9qRe5zNsEWnkAwc1EM3dZ02RWAYnjHuJf3lP bcbGnruvcsnVsNg5YdKU/XVJtB3CBgBtJlgNZh7Mc84Tu5VZm0oRX8SRBtHDSdW+/8xnKStzX2JSxq qrR8kNiF9200gZdzzzcK1mcgTPcMwhOE73ltZTq1BQ8N3GLPUeVM4yzMHSRS4JOS4GzygUhMQMlh8D EdamA3GHPtGX3Kl1pgjMzQbv1nXiYTwqz9TcYxkkN6a7SiSLAg/uDL1FNMGnVt92LTMrFg9BBeoD8G mnhDPrscAkj3bS0kjdWIqd9+mgDP/avLxQZqm7lJEdtOVY5IFA3E32WwiMRg4gsHaGdofouNH7WqBB h05JASjugP06N/eeYnLTlLjQNyTooLPksIFQCAnrjoIGOXWGccnM8rCIhJpJ+Rq8V4BKSGDJdYZbrp T/c9U4DGHrpUdVxXDLYkAy3QiXxFmBCw2Ce30hkGv4MMbSTReBheD5ttoUFw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Instead of hardcoding the list of kfuncs that need prog->aux passed to
them with a combination of fixup_kfunc_call adjustment + __ign suffix,
combine both in __prog suffix, which ignores the argument passed in, and
fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
passed into them without having to touch the verifier.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v1 -> v2
v1: https://lore.kernel.org/bpf/20250512210246.3741193-1-memxor@gmail.com

 * Change __aux tag to __prog. (Alexei)
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/helpers.c         |  4 ++--
 kernel/bpf/verifier.c        | 33 +++++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9734544b6957..7dd85ed6059e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -606,6 +606,7 @@ struct bpf_insn_aux_data {
 	bool calls_callback;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
+	u16 arg_prog;
 };

 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fed53da75025..43cbf439b9fb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3012,9 +3012,9 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 					 int (callback_fn)(void *map, int *key, void *value),
 					 unsigned int flags,
-					 void *aux__ign)
+					 void *aux__prog)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__ign;
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__prog;
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;

 	if (flags)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28f5a7899bd6..f409a06099f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -343,6 +343,7 @@ struct bpf_kfunc_call_arg_meta {
 		int uid;
 	} map;
 	u64 mem_size;
+	u32 arg_prog;
 };

 struct btf *btf_vmlinux;
@@ -11897,6 +11898,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }

+static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__prog");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -12938,6 +12944,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;

+		if (is_kfunc_arg_prog(btf, &args[i])) {
+			/* Used to reject repeated use of __aux. */
+			if (meta->arg_prog) {
+				verbose(env, "Only 1 prog->aux argument supported per-kfunc\n");
+				return -EFAULT;
+			}
+			meta->arg_prog = regno;
+			cur_aux(env)->arg_prog = regno;
+			continue;
+		}
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "R%d is not a scalar\n", regno);
@@ -21517,13 +21534,17 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
-	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
-		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux) };
+	}

-		insn_buf[0] = ld_addrs[0];
-		insn_buf[1] = ld_addrs[1];
-		insn_buf[2] = *insn;
-		*cnt = 3;
+	if (env->insn_aux_data[insn_idx].arg_prog) {
+		u32 regno = env->insn_aux_data[insn_idx].arg_prog;
+		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
+		int idx = *cnt;
+
+		insn_buf[idx++] = ld_addrs[0];
+		insn_buf[idx++] = ld_addrs[1];
+		insn_buf[idx++] = *insn;
+		*cnt = idx;
 	}
 	return 0;
 }
--
2.47.1


