Return-Path: <bpf+bounces-44279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE729C0D48
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4807284C66
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37FD216DE6;
	Thu,  7 Nov 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIBxGJhM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53F217313
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001881; cv=none; b=jTnkJN3u5OSRAXgHNmo/fi/1+ceSyQjzvOu9+oyPabXiV92T9DzH3jYNXK7aXv8LuFMyK87Gkiw+82IDlxRwu7kEXM686nNiJ0AlChDidBQHRVI2TEu8LQBNMLc8Rl143q8HoTrLWNBe6C7ari7Ytf3DGV9QDBS/jS2l3YaW6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001881; c=relaxed/simple;
	bh=yC6camVXIk/xRcIU8qIwqNOnbw72qvOetKv7cwVoCYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaYNjYQ2kJiAXoheEx57YnwLIxcOWssa5eeao+x8eGy7tbBazOOU/zp8bZTpbtOkNBtZmfJjKfCPhq+vLUs2fHunoSu2r9TdKTVJ0iIZaxASxnbWrD4b9xqVsMIDHvGGj5bDTHKkP29TzHfnaqdxyiTabHBrFwLuryQDQZDbv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIBxGJhM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso1019777a91.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001879; x=1731606679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojt3Ivwv83MH7Y1PX4JTlFjGu3ruupwSDqo6WoZBu3g=;
        b=KIBxGJhMQGUQlG2T1Ip82ghZS5dcHmsp4TJ2zS0wFB2B3YIJLKQpKp6i9GmDhGX8dl
         T+rjchbxvQAtuXo5ijC8rr+tAWr4Ovy6Oo8u0X1KO9xclJ/L8SMbzvp7CG0cCXCSHcDv
         RF2LBDc+W2bt28HeENtCY5w/JDfqtRd/1VVajt3bjRLYOW8JY0xOY4tkVGF8OcSzqzIF
         MH/3lWuorAKSLcLvgpTozuhRnKLrHAKclKud3sw9smiEyzaYmC1olNTlbsAwmi89Gxls
         aPoyw64IubJKoaxQ4JhwHg4F1vcm3ZhFiQLqTEO5HMrgHpd7NhIwcaLGLpVNlg308w5J
         VuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001879; x=1731606679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojt3Ivwv83MH7Y1PX4JTlFjGu3ruupwSDqo6WoZBu3g=;
        b=BOECgn88VHhYIc12/FZjx97GCqSxAmM8ZZWiZy+kANTXWE8jZs4kIm5XhXFh5SK9Cj
         Z6RmExkJ2aFuv2kTZ+vl7LYvBZMaNHkOfxHt+j/VKoTBEcfZC7OwlwYhm92qFzvy46/L
         zSknhtkOtlK5SFlRG3Y+IcDabqG6MD8TfWYAikz2dCzaxVEVRoarjszWM5qUzoLUKKQp
         GfehTS0AfzEGV9UiWx5jf5IUlm3rHjZYPwc9olqgkXvwAzGKXfpm/PSv9flbon/5RetQ
         CyI5oiHPPDdorQhMLMwVFuwJCQ5zp0YfJJreJTa7LXUZsnqLTIi8rCkbsS6WfV/KsXng
         HMeg==
X-Gm-Message-State: AOJu0YykQgnMRmaa+KFOJvxX8hkKiMuO9ly5OjuYnYzin/x6brjdJNXd
	WQyTvcY3s0Q7diuYbgn/gXl3c6ykIjjWu3T+6y6AHcVHNnLP4JJOJgQG8ftg
X-Google-Smtp-Source: AGHT+IE3RL0EZ37sjpjRPEVVZtbV97P59nQ8TuLncxpAbQgMgD3F+OUvWSm4B74RQvbpnQv63Chglg==
X-Received: by 2002:a17:90b:3811:b0:2e9:2329:8d98 with SMTP id 98e67ed59e1d1-2e9b16ef07amr50173a91.8.1731001878915;
        Thu, 07 Nov 2024 09:51:18 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:18 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 06/11] bpf: KERNEL_VALUE register type
Date: Thu,  7 Nov 2024 09:50:35 -0800
Message-ID: <20241107175040.1659341-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up patch adds inlinable kfuncs as subprograms of a bpf program
being verified. Bodies of these helpers are considered trusted and
don't require verification. To facilitate this, add a new register
type: KERNEL_VALUE.
- ALU operations on KERNEL_VALUEs return KERNEL_VALUE;
- stores with KERNEL_VALUE destination registers are legal;
- loads with KERNEL_VALUE source registers are legal and
  set destination registers to KERNEL_VALUE;
- KERNEL_VALUEs do not have any additional associated information:
  no ids, no range, etc.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/log.c      |  1 +
 kernel/bpf/verifier.c | 24 +++++++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2bcc9161687b..75f57f791cd3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -941,6 +941,7 @@ enum bpf_reg_type {
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
+	KERNEL_VALUE,		 /* pointer or scalar, any operation produces another KERNEL_VALUE */
 	__BPF_REG_TYPE_MAX,
 
 	/* Extended reg_types. */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4a858fdb6476..87ab01b8fc1a 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -463,6 +463,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
 		[CONST_PTR_TO_DYNPTR]	= "dynptr_ptr",
+		[KERNEL_VALUE]		= "kval",
 	};
 
 	if (type & PTR_MAYBE_NULL) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4ea7fd8a967..f38f73cc740b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2388,6 +2388,12 @@ static void mark_reg_unknown(struct bpf_verifier_env *env,
 	__mark_reg_unknown(env, regs + regno);
 }
 
+static void mark_reg_kernel_value(struct bpf_reg_state *reg)
+{
+	__mark_reg_unknown_imprecise(reg);
+	reg->type = KERNEL_VALUE;
+}
+
 static int __mark_reg_s32_range(struct bpf_verifier_env *env,
 				struct bpf_reg_state *regs,
 				u32 regno,
@@ -4534,6 +4540,9 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	if (allow_ptr_leaks)
 		return false;
 
+	if (reg->type == KERNEL_VALUE)
+		return false;
+
 	return reg->type != SCALAR_VALUE;
 }
 
@@ -7208,6 +7217,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == PTR_TO_ARENA) {
 		if (t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
+	} else if (reg->type == KERNEL_VALUE) {
+		if (t == BPF_READ && value_regno >= 0)
+			mark_reg_kernel_value(regs + value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(env, reg->type));
@@ -14319,6 +14331,13 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	if (BPF_SRC(insn->code) == BPF_X) {
 		src_reg = &regs[insn->src_reg];
+
+		if (src_reg->type == KERNEL_VALUE || dst_reg->type == KERNEL_VALUE) {
+			mark_reg_kernel_value(src_reg);
+			mark_reg_kernel_value(dst_reg);
+			return 0;
+		}
+
 		if (src_reg->type != SCALAR_VALUE) {
 			if (dst_reg->type != SCALAR_VALUE) {
 				/* Combining two pointers by any ALU op yields
@@ -14358,6 +14377,9 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				return err;
 		}
 	} else {
+		if (dst_reg->type == KERNEL_VALUE)
+			return 0;
+
 		/* Pretend the src is a reg with a known value, since we only
 		 * need to be able to read from this state.
 		 */
@@ -15976,7 +15998,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	}
 
 	if (is_subprog && !frame->in_exception_callback_fn) {
-		if (reg->type != SCALAR_VALUE) {
+		if (reg->type != SCALAR_VALUE && reg->type != KERNEL_VALUE) {
 			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
 				regno, reg_type_str(env, reg->type));
 			return -EINVAL;
-- 
2.47.0


