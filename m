Return-Path: <bpf+bounces-70313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7CBB7715
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A75CF346CB8
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931C2BE65E;
	Fri,  3 Oct 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGRhz5jl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8F29E11A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507487; cv=none; b=ZfSfcyWYlBx19ajXEzUC8E+5xl0+2AtDj3jcsBZbfip14UOt9EkDfrQHhTC+qq6tLAt93qnAx69ira3FdHuYt2ZvUcDR/moluQXqDh/4PMZEKPqzOKbzvgtxlszO1vtuRYmiNTLNPy43Y7GLILXGzLw1TU0BmYy+OkyI4YDjIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507487; c=relaxed/simple;
	bh=2LPW56bvAsrUQXIAy9u4vuKPBzlAxzWGIDcHP2/u/yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8TGUPAK7FBaZVnDvYoNWTHzvuVRKT0cvmoOve3734SQUh1bzHldhX1NbbcpbFmFnnByOogjRYaHr/FgeRH2f/VNLhv0vajbnfyfxx0mIBglixQIxQTv2Um4FUCjkH7IeWJCJwGeoAYVy7cyyNWBpohQgd/KJ5rmZAPpJ7t2R6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGRhz5jl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso18117055e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507484; x=1760112284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0kHzOVEgehFRxn+UoOrpFXCI3qfsWn9yS4NQCul2q4=;
        b=lGRhz5jldyHskUbFda6oaKflcIGkJf3CWwtlYyNOMaJRLqcabQmIyCtfOg5kdVz1eS
         cyOR1xvcJG9iAKv913sqnNxXmQmQ2tjdiPT0GVoKGMAovkkdQTB6dYLaBa68/cZSOdsc
         CiCY55tE0T0JQu8CBu680o4FnslyLOicLsKXV3WjSMebSAnIOT/fcmuub39U5PwiYzXr
         enRzxllcyzaM0AH/6hCTq+LKKma6YvpFJT7jfHOcs2Xs5xtWFPGYwc4kSnt7bjZsxbCx
         LDixsfXTKZftkEn3BHxQMT2s5DZT9+uYFKadtzovQMjOsdcXnFtiOwA6ZbsFAPWu6RuM
         HV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507484; x=1760112284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0kHzOVEgehFRxn+UoOrpFXCI3qfsWn9yS4NQCul2q4=;
        b=Bf4UshM3pDMJe/1JUQEBHo7KeosM1ZLB6E6BGP55cs9mWmJUSbKkpI0PjxMHH8aGXW
         //ey++AotSPH2ltkp0kp8yo1PBPImRn5uIT/ZaGe9+3vemJNKNgEcxqB8SvrGniuInt9
         Se2iH7LjUrq1o2EMyDE/tlXD9A7ej7V+zgL44EZOTfSYWlKEyOIrxAuy9aGAoHE5rYZp
         BSfN0eNabH2YKksbDaVzuPcrReX1+nwaOg5nxyHFHnCkasvFcp2pAKgPJw5gilZiDu4X
         m60R/bTrlq/bvfTsF2ZsgXxrx/GWPHGezGi8MlRkpzSQz7kapCx0/dXiAxfPohWlmB1w
         2SQA==
X-Gm-Message-State: AOJu0Yzs4ffo3+2PSakX/EqOgNyXxzEz76S1oyY56Z+2mftSeZ7ePZrZ
	lqDqF3U6UgaiaSiXMrsJHkWNSOtLcTJ3W/n8GwiAsNpVw8cfSxWvydrZd7yrHQ==
X-Gm-Gg: ASbGnctv7A8LdlCmRhLxcfefxW0He/0RKVZM3XqHPK4VIdpHN8yO9aXFyXNHzQ3VZsS
	GyyhyvWLmdzDp3VKRfriqLQm84YwEAKUx5TGsM1uTNBHrNBDAvMRg9ai1NnMH5xSCn/D5eWbRyd
	PYz3vgzHIgaiR77Eu63axPiZm4qrwAclED7381nI/dVX5KwYmpuy5ejlqv56mkVs46p5x+1TdVR
	KMFN/eehdy05c/sWNw3Qmo/0MI8y1SHCmxINyajXbmYcu/e/aZB2zYPlGOTEa3vgkCADN06x//5
	quku3aEZQ/zCRejxrU+lPHp+pRKaliZUE+1f8utQ73bAEAlxuJAu9Qrr0PlV6IBLuYvz2+Q4+7t
	apJkdzyrgvC1txgsf5gjeTDRdCg==
X-Google-Smtp-Source: AGHT+IGMeS5Oz2bOVJ0t/gxvJVDIymcsEbUIumCs2pd8xs9NAki8CNv97O8xnPUVG+/DZGdayetSzg==
X-Received: by 2002:a05:600c:1d05:b0:46e:477a:f3e3 with SMTP id 5b1f17b1804b1-46e70cb75c3mr25104585e9.18.1759507483901;
        Fri, 03 Oct 2025 09:04:43 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e5fdsm36439965e9.6.2025.10.03.09.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:43 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v1 09/10] bpf: dispatch to sleepable file dynptr
Date: Fri,  3 Oct 2025 17:04:15 +0100
Message-ID: <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

File dynptr reads may sleep when the requested folios are not in
the page cache. To avoid sleeping in non-sleepable contexts while still
supporting valid sleepable use, given that dynptrs are non-sleepable by
default, enable sleeping only when bpf_dynptr_from_file() is invoked
from a sleepable context.

This change:
  * Introduces a sleepable constructor: bpf_dynptr_from_file_sleepable()
  * Detects whether the kfunc is called in a sleepable context and
  stores the result in bpf_insn_aux_data (kfunc_in_sleepable_ctx)
  * Rewrites bpf_dynptr_from_file() calls to the sleepable variant when
  kfunc_in_sleepable_ctx is set

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h          |  3 +++
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/helpers.c         |  5 +++++
 kernel/bpf/verifier.c        | 12 +++++++++---
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bd70117b8e84..9da7460e078c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -663,6 +663,9 @@ int map_check_no_btf(const struct bpf_map *map,
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1);
 
+int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
+				   struct bpf_dynptr *ptr__uninit);
+
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4c497e839526..6078d5e9b535 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -581,6 +581,8 @@ struct bpf_insn_aux_data {
 	u32 scc;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
+	/* kfunc is called in sleepable context */
+	bool kfunc_in_sleepable_ctx;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4bba516599c7..f452e22333fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4288,6 +4288,11 @@ __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dy
 	return make_file_dynptr(file, flags, MAY_NOT_SLEEP, (struct bpf_dynptr_kern *)ptr__uninit);
 }
 
+int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
+{
+	return make_file_dynptr(file, flags, MAY_SLEEP, (struct bpf_dynptr_kern *)ptr__uninit);
+}
+
 __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aacefa3d0544..82762eab3f17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3105,7 +3105,8 @@ struct bpf_kfunc_btf_tab {
 
 static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id);
 
-static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			     int insn_idx);
 
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
@@ -13833,6 +13834,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	insn_aux = &env->insn_aux_data[insn_idx];
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
+	insn_aux->kfunc_in_sleepable_ctx = in_sleepable(env);
 
 	if (!insn->off &&
 	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
@@ -21832,7 +21834,8 @@ static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id)
 }
 
 /* replace a generic kfunc with a specialized version if necessary */
-static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			     int insn_idx)
 {
 	struct bpf_prog_aux *prog_aux = env->prog->aux;
 	struct bpf_kfunc_desc_tab *tab = prog_aux->kfunc_tab;
@@ -21872,6 +21875,9 @@ static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
 		if (bpf_lsm_has_d_inode_locked(prog))
 			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+		if (env->insn_aux_data[insn_idx].kfunc_in_sleepable_ctx)
+			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
 	}
 
 	if (!addr) /* Nothing to patch with */
@@ -21924,7 +21930,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	specialize_kfunc(env, desc);
+	specialize_kfunc(env, desc, insn_idx);
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-- 
2.51.0


