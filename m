Return-Path: <bpf+bounces-51927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096CA3BEBD
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 13:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2913A17262F
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48101EB1A6;
	Wed, 19 Feb 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+gdOt6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC861E3796
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969484; cv=none; b=bQJoyEuYYaQAUcZaXPaHwnSDrbWdSLvwW3ac24AnXNW2xUhV2BCaALzL4vfrFjERUxfq8Zrmb0Vgc1Nl9tSuTbQQ/34SZojzFO2Esp9uYBn0i9mEcUud5dchCp4PoKVYq3jS9n2BuvNv3BJhiyOAgk4Kb2V92i77hsKkbiiZaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969484; c=relaxed/simple;
	bh=8G9cLxAvypL3qfyZjN/+3hf7TwidPa82ZNgJb98Kzqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsbTnrVoSlvEux0dZMsz+iYB/Bnso3iHO7SbnPEoYuUt6yMZY9T7pzHQna4GmPWEqDdg0D2hvA5egWviGQWCzBSeE+uGAb8dKBzR2sU7oHfQNGTtFt2c2Q0fsaeas0KU/K8jfIMsAJ5yuJTqmEW/VN2fRtHeA0FMkTfo23RUMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+gdOt6C; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38de1a5f039so6514821f8f.2
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 04:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969480; x=1740574280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIeRDuEQDJkRWKho9FTQqBld64RQ4vD7IboYKGechdw=;
        b=M+gdOt6CSCmnYdlFtxu8cj9p+n8mEUJGwMYNf/nKjPE5LRwGcEX7Qr7EaGgE7TKDeB
         Zu8g9k53Nnz8vxqiXsH6qHI2wA5AcwBbjVZ4rgNwbSrlILmmbDEhliS0UCU1Xu/ZAID3
         lFi/W175lvYGkgpceaUgEe/2fsYKmp8pze8owBSm/bibqBhBa863ihguzGQENmcnRbLo
         HWUjfJLaBv/k2g8qoWBwfNInMY1Suec62BlPqSyqqs/Zrr+b8MbNkg8pOY6cgbo5J9QU
         6aTaKnBS31XpUni230d+BVWCUK/taWNFp2v7iO7TlVCCDHVFmmULFP2mq/hkhbaTP9HR
         F1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969480; x=1740574280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIeRDuEQDJkRWKho9FTQqBld64RQ4vD7IboYKGechdw=;
        b=AXLg9+eZmKzX1x54iAoLwcuHsfH8rmtkOz727vILL71SybwFOFKuDUfuhsoNDK8L4q
         ptKwGZSckqfbHaAhGWy54l2sH1lmfn8HGZFay/hQzILOYf03848wZ3bWB97VdL49ZQs8
         vQggsxqtOCJA714c9cOpfY1t2B6lT1fcpd2W4SPbr+Bt0uibf2gHaouJOhdrEm26iLwk
         LNHn0mBZg4/HRg93EzsZCku0HiSXAh70OluS2kQR8GMZSzUmXVULV6pcAwVxsmV79xCF
         2cDjSE8Qg6T1wuiHMaSjPGhTRI/0hhjGexismlRCw151uabYUSfgBEUpmiBWADDE2Czu
         Aekw==
X-Gm-Message-State: AOJu0YynJKxLlpsVECh6m32oTEEwchyslWmVswywdHfwQ8ggsF2h2KVX
	65GreC2Xy2eq2VozBTdOKWHRx7eS2Z2HNklIcMWXPkZPTSftp8NMzcJY+aC0NdI=
X-Gm-Gg: ASbGncvb459Uvy4TRre1Q1beJ1l0B/XoOn4weMTmSmh6Ds5n/Rzx2wcbQDi4xZivJ9A
	H+AKNizU9e7UrqcRwqWcyI4zmQSTc5jmnhP+UGH7fQNxiCUzZgskn75UhCsgOKzTQn6rA8SyPI3
	gTIp9YDpf0qLjFawvsX17rpT8VU2SstL29H/QcYPCoZg3saim0iaU+geEjMCmX1JV8KVGIn1r2d
	pEnkHULeZ8+AD4FC7AscVrZuRnqp+A/QsjZefsGH3cv1xSz8RS7WmbOfWHATQIY/imM8yEkEMTS
	cWrk4Q==
X-Google-Smtp-Source: AGHT+IEcJTO5jRAZqNl76FhTcH6n+pwCRVwek8J1hfPij+T1d3605JEvFvpvspaQcRbwGoZN0uEjeQ==
X-Received: by 2002:a5d:6547:0:b0:38f:2073:14a7 with SMTP id ffacd0b85a97d-38f33f56437mr12440555f8f.47.1739969480217;
        Wed, 19 Feb 2025 04:51:20 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbab339807sm451070766b.162.2025.02.19.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:19 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
Date: Wed, 19 Feb 2025 04:51:15 -0800
Message-ID: <20250219125117.1956939-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250219125117.1956939-1-memxor@gmail.com>
References: <20250219125117.1956939-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4319; h=from:subject; bh=8G9cLxAvypL3qfyZjN/+3hf7TwidPa82ZNgJb98Kzqs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBntdMyuitJbXurYAPP877ZrjIDICyY8wgtXeFjrVMW tc5Y6+iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ7XTMgAKCRBM4MiGSL8RyuYKD/ 0fU4SSH/2HVZEx7zpWlQlO1cgACGO+30besXPtm0T4v4pGYZA/Bc3sXtpv6jPoRMG2j7hfmdKq0+UZ UHycWs0OEEG22tQ0ZOjFN29F9IhuLUryLrMnYMOFhKqUl6bDwmLTqoOfMGj5Z6TDTRmLCNrQ8gsUd0 BgznzSnDqFSMAM4YGh8L0JGJhj2qtvHK4qFgfCVdyEcbGn3XfScYCms83igPSwgt+j0IfGtYZI+eDo F0EwSydhqcBHpHU8cRwTdZI5LjjLnYJyfISZES46VGvdU6257ZY1yscb+CeBNA+whLbVPFs2OFQfhY F94Mm4lRDK3XnI4MNnLplRqvLG64s2wiWHZGRjKqDp/345XZP6uUyJHUue6CtHZKrJJSwgzczQXQjj 2L5sKZRVeodTOFAeP+kgU9/2sSfyM9ZlXhhiKy/QR2sKb2pa7+dqu+cIj42Lu40ciJkkQnkWov2y0p U1BqW/MstzaffyY7kzd3t2p0w1B1djMta2xD6RdPal/iQQTFHUtUZDRWW8wKx3cA/G7ckQiQSRj549 OuGgKPSpoLBfoyN6Rzi9ujJnGolUEOgM+RD7tp62BRvdXDxD1d7qqVmexj7Nsv+lOmjMK3wOpkgGnL A3qx+29n2DnfyHG1dLzunBUXZkZjUe+KVyAXFDVUZAsMzUogsUqOnlb1pRtA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a pointer
to the underlying packet (if the requested slice is linear), or copy out
the data to the buffer passed into the kfunc. The verifier performs
symbolic execution assuming the returned value is a PTR_TO_MEM of a
certain size (passed into the kfunc), and ensures reads and writes are
within bounds.

A complication arises when the passed in buffer is a stack pointer. The
returned pointer may be used to perform writes (unlike bpf_dynptr_slice),
but the verifier will be unaware of which stack slots such writes may
end up overwriting. As such, a program may end up overwriting stack data
(such as spilled pointers) through such return values by accident, which
may cause undefined behavior.

Fix this by exploring an additional path whenever the passed in argument
is a PTR_TO_STACK, and explore a path where the returned buffer is the
same as this stack pointer. This allows us to ensure that the program
doesn't introduce unsafe behavior when this condition is triggered at
runtime.

The push_stack() call is performed after kfunc processing is over,
simply fixing up the return type to PTR_TO_STACK with proper frameno,
off, and var_off.

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e57b7c949860..ad57144f044c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -329,6 +329,12 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		struct btf_field *field;
 	} arg_rbtree_root;
+	struct {
+		u32 frameno;
+		s32 off;
+		struct tnum var_off;
+		bool found;
+	} arg_stack;
 	struct {
 		enum bpf_dynptr_type type;
 		u32 id;
@@ -7287,6 +7293,7 @@ static int check_stack_access_within_bounds(
 		min_off = (s64)reg->var_off.value + off;
 		max_off = min_off + access_size;
 	} else {
+
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
 		    reg->smin_value <= -BPF_MAX_VAR_OFF) {
 			verbose(env, "invalid unbounded variable-offset%s stack R%d\n",
@@ -13017,6 +13024,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->arg_constant.value = size_reg->var_off.value;
 			}
 
+			/* We need to simulate a path where return value is the
+			 * stack buffer passed into the kfunc, therefore store
+			 * its metadata here.
+			 */
+			if (buff_reg->type == PTR_TO_STACK &&
+			    meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
+				if (meta->arg_stack.found) {
+					verbose(env, "verifier internal error: only one stack argument permitted\n");
+					return -EFAULT;
+				}
+				meta->arg_stack.found = true;
+				meta->arg_stack.frameno = buff_reg->frameno;
+				meta->arg_stack.off = buff_reg->off;
+				meta->arg_stack.var_off = buff_reg->var_off;
+			}
+
 			/* Skip next '__sz' or '__szk' argument */
 			i++;
 			break;
@@ -13598,6 +13621,34 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	/* Push a state for exploration where the returned buffer is pointing to
+	 * the stack buffer passed into bpf_dynptr_slice_rdwr, otherwise we
+	 * cannot see writes to the stack solely through marking it as
+	 * PTR_TO_MEM. We don't do the same for bpf_dynptr_slice, because the
+	 * returned pointer is MEM_RDONLY, hence cannot be used to write to the
+	 * stack.
+	 */
+	if (!insn->off && meta.arg_stack.found &&
+	    insn->imm == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
+		struct bpf_verifier_state *branch;
+		struct bpf_reg_state *regs, *r0;
+
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+		if (!branch) {
+			verbose(env, "failed to push state to explore stack buffer in r0\n");
+			return -ENOMEM;
+		}
+
+		regs = branch->frame[branch->curframe]->regs;
+		r0 = &regs[BPF_REG_0];
+
+		r0->type = PTR_TO_STACK;
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		r0->frameno = meta.arg_stack.frameno;
+		r0->off = meta.arg_stack.off;
+		r0->var_off = meta.arg_stack.var_off;
+	}
+
 	return 0;
 }
 
-- 
2.43.5


