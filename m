Return-Path: <bpf+bounces-62199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF0AF6581
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EA1172E42
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB52566DD;
	Wed,  2 Jul 2025 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsiZ37XM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877B1EFFB2
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496139; cv=none; b=cyZkq5vLZ4LFhxQasNBWOC+rTs7BqG1dROx0xdHhIhX/HoWDEE9mv7h+VcxaeIjqw/k8oNjYWc2BzLMW2THE6sM9OjbxDZOvxv8hBO8QRBekwJcyGlN7+KGqsgBfztB5g86a7QMvmFPTwu6smNQoQMyVFOr3TkIeW86CyvmptzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496139; c=relaxed/simple;
	bh=sCDk/2IUmXhw6JTxpUKyumEcEOpWzBxA33YmjANIQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzAW+0pZBl2g+hqtnRz/xuIRUje7Rm8gQDqBDU0l8UJxDNkPia8wUVKNqAbVeAM5vEQr/7XJz+rr0Su6oRlO8I6/VYZRzHR+R8ZUnphY/OrFIHIo7zjPpRuqgXvz9VU+raGS6CVPbf2rFWNm+IL27MkWyC76MGTbBBntgTChkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsiZ37XM; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e75668006b9so4913003276.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496137; x=1752100937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXnaMqOI/icLjh8IXVFEa0JDjgr+IXaoTGrHpYJODI0=;
        b=SsiZ37XM8yUpxy34ktNNoqC7u1Wwi+m9/Nl/E6Mzh/HWwGkzgYH4Rw39321ETstrbN
         c5KMvhWxBQGtAzAy0UiIm22uUK1qEhSzJDILI7tLHUY5U8IgyQ4lQghscategrNqWnEb
         0W/IFZlyaqzpqY55NoOMMMeFbz3UPhsacI7rQ4UR22FpqnAwflr0L2mDenRpIm1RyWMW
         TN7N514/JHk82VT8zOS2ib5TcVE/eD2q2xhX+cPwvb/rrroQzz1QAreAYeG9Y81TCnx+
         qt+cQPbepX6aWkeAHpwQ87pyyF5EeJnkLJYapxmqTpD1tP4JuOUL9yIub+F/d5Qp/81H
         6T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496137; x=1752100937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXnaMqOI/icLjh8IXVFEa0JDjgr+IXaoTGrHpYJODI0=;
        b=nKQhe/aNDtQx/C0hmw8oU8AkwQDrbI9GDjcWJLwlTpzdn5+LmokgdM5vtFywX5xPhl
         QKs3b9OnmKI1GsipV2cW2/uBRmNV7q+KFGrlnuLBCFrjzs4S1ZUAgi2LaHI8oEExLdl6
         4i061K1q3H8AWdSBovNXdBfy0eQd5VUhl3zpK4GuYZhpd+azbmpDYm1mKZBAYQiBERNX
         A/WMWHZiaeEwg+qt1cPk/VU5X+UommubeUie8HIKhPkBtNKddK6B+Thndh/hj75mnkus
         UkYfUIXcHCEhzzKPGlczey1RfBHOsILlEhZmcQPiom5kd9rsLO6Gv4aoPfO4nnb6qC/P
         DOAA==
X-Gm-Message-State: AOJu0YzamgMp2lHLk6/dvLad02PPG0MmqzMYDw8b5WYWvJyMd2L6JXkb
	RmauGfranVbWRYbxtDj1RF/iggP7CsuDCmQ2w0Z9SVzrdqzy3Za/AJiCNI2my8Wh
X-Gm-Gg: ASbGnctxJQWmYxVzQazXWoJA8UTelKq6MA9/RTrRuWCBywUd0WUigEsI+3kuEpSKugx
	aytW3VO81cnyaEv9kglfgnr0vebA7gCWeHyjQZWLgvt5Rtvbi7WF6rzJ9p3/JCf3pw5becRnLdl
	WzJ9iMMfjwR6qwRkht5pNS5cfqznhfZl6yj8lecn0tmHO91RpufpyUngaLXsyvWuFH1TvplfSZw
	QKSPcP5eIkhXPWMN7L4qP/30AVbsX7R551bun9USsyvvN3B/3IrzvWCxnr9gzM6EH+raZi7CosC
	9OcK1zxbacBHgJmeDvrYFPOZpAxMSe9jMryubKJCxOrf2eNP9CtVsQ==
X-Google-Smtp-Source: AGHT+IHQ6E2tbeVBNf+qKeMHI1L5JWswVdOXojGUFzrtcnXHhTBPAUP0ip5lLVOFwgATGQxzsPU2sQ==
X-Received: by 2002:a05:690c:4905:b0:710:edf9:d93b with SMTP id 00721157ae682-7164d2c9984mr80199377b3.11.1751496136502;
        Wed, 02 Jul 2025 15:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7164de8d62fsm4923167b3.101.2025.07.02.15.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:16 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 1/8] bpf: make makr_btf_ld_reg return error for unexpected reg types
Date: Wed,  2 Jul 2025 15:42:02 -0700
Message-ID: <20250702224209.3300396-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-functional change:
mark_btf_ld_reg() expects 'reg_type' parameter to be either
SCALAR_VALUE or PTR_TO_BTF_ID. Next commit expands this set, so update
this function to fail if unexpected type is passed. Also update
callers to propagate the error.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 59 ++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52e36fd23f40..b6d26e8bd767 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2795,22 +2795,28 @@ static void mark_reg_not_init(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, regs + regno);
 }
 
-static void mark_btf_ld_reg(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *regs, u32 regno,
-			    enum bpf_reg_type reg_type,
-			    struct btf *btf, u32 btf_id,
-			    enum bpf_type_flag flag)
+static int mark_btf_ld_reg(struct bpf_verifier_env *env,
+			   struct bpf_reg_state *regs, u32 regno,
+			   enum bpf_reg_type reg_type,
+			   struct btf *btf, u32 btf_id,
+			   enum bpf_type_flag flag)
 {
-	if (reg_type == SCALAR_VALUE) {
+	switch (reg_type) {
+	case SCALAR_VALUE:
 		mark_reg_unknown(env, regs, regno);
-		return;
+		return 0;
+	case PTR_TO_BTF_ID:
+		mark_reg_known_zero(env, regs, regno);
+		regs[regno].type = PTR_TO_BTF_ID | flag;
+		regs[regno].btf = btf;
+		regs[regno].btf_id = btf_id;
+		if (type_may_be_null(flag))
+			regs[regno].id = ++env->id_gen;
+		return 0;
+	default:
+		verifier_bug(env, "unexpected reg_type %d in %s\n", reg_type, __func__);
+		return -EFAULT;
 	}
-	mark_reg_known_zero(env, regs, regno);
-	regs[regno].type = PTR_TO_BTF_ID | flag;
-	regs[regno].btf = btf;
-	regs[regno].btf_id = btf_id;
-	if (type_may_be_null(flag))
-		regs[regno].id = ++env->id_gen;
 }
 
 #define DEF_NOT_SUBREG	(0)
@@ -5964,6 +5970,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	int class = BPF_CLASS(insn->code);
 	struct bpf_reg_state *val_reg;
+	int ret;
 
 	/* Things we already checked for in check_map_access and caller:
 	 *  - Reject cases where variable offset may touch kptr
@@ -5997,8 +6004,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
-		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_field->kptr.btf,
-				kptr_field->kptr.btf_id, btf_ld_kptr_type(env, kptr_field));
+		ret = mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID,
+				      kptr_field->kptr.btf, kptr_field->kptr.btf_id,
+				      btf_ld_kptr_type(env, kptr_field));
+		if (ret < 0)
+			return ret;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
@@ -7297,8 +7307,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
-	if (atype == BPF_READ && value_regno >= 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+	if (atype == BPF_READ && value_regno >= 0) {
+		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -7352,13 +7365,19 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 
 	/* Simulate access to a PTR_TO_BTF_ID */
 	memset(&map_reg, 0, sizeof(map_reg));
-	mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID, btf_vmlinux, *map->ops->map_btf_id, 0);
+	ret = mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID,
+			      btf_vmlinux, *map->ops->map_btf_id, 0);
+	if (ret < 0)
+		return ret;
 	ret = btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_id, &flag, NULL);
 	if (ret < 0)
 		return ret;
 
-	if (value_regno >= 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag);
+	if (value_regno >= 0) {
+		ret = mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.47.1


