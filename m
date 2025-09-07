Return-Path: <bpf+bounces-67682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A827B4812C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 01:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC748176016
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 23:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7C230BF8;
	Sun,  7 Sep 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi6t9rRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC71B6CE9
	for <bpf@vger.kernel.org>; Sun,  7 Sep 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286274; cv=none; b=a5hMH08oRkcu4gR/tr13ZG5Ypxe+/W28ZKoXreLH+DNGUBWPci2hKEvDStf3WI1OeVpYV/IFaE5YDzN05YCQcrB+/AIzm2qWKZDUiOAMk9ElBagw0zYf67zPVyemJs31crJN2fmfBQFF/R4jmA5ypp0gHjnqICIqil6kiZ8ezQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286274; c=relaxed/simple;
	bh=0DVT4DJ2RiRDJUGr2y94jxr0AAfXHrvBu+ehieUMLOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSUFL4BVKfO1QWuwJMRGX3sBP3SJDhBAo1f1oBL8c4Vfl8JVBW8oKmb7/UmaAuc2RU+Yb8Um5LjJG58cKijKeXh7GzLxg8NeWTk8CibxUGVuwKq+chRq0rTvD2J3uQ5juF4N5gWdsB07+6PDSlR9cw2XKwOQa3jiij1MTe12/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi6t9rRU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b13313b1bso27545075ad.2
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757286272; x=1757891072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWjhkUHjjkw2spoEUmPOo+Hhx40OHRNtRBEHp9hRMmA=;
        b=hi6t9rRUAJRRCUjP2EpETtQrV4jADUlRNKD+cq/hz1W4lr/PxO2ItVo3EJjKUFkTqT
         RcVCD9xcGNYpMH/LlvtAAaB0I0qFPwGLRYpFlJD2eL+1NdG9dwQoP8nJwlywnf3RccXM
         EBCKoJOD237uGQSzAsVHv1A3AG9q2YyTlGlA1P6GOdsD8xP2BZrjGsVuOuL92KEcQIGx
         ChBNQR3m0WotDtj6pON+xbAMW1hGaYA9hcOsqL1qdzHE8K6MR/ephh17jZkwexCWK6wf
         WNwzg3VkEIKOOPWmJJQ4cxyvBa65DqHliqx3ukjlUpHOMgRBhn448A4jUJfpbbDaBS3e
         BkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286272; x=1757891072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWjhkUHjjkw2spoEUmPOo+Hhx40OHRNtRBEHp9hRMmA=;
        b=pB4UFC3cyWpXBaNcjzILHmDwdfTTID082TJXxsxIIDgp1/SI4mxZL9v7vQq9j2iUA5
         dOpVqT03RfNOb4DXHgHkfEe8WexAtzbgbPehYHmalWvtdw/9Yo/TnMuyupgB9tSTi4TI
         uCJmCste91oL596So1/uBZRVonJpqKcAG+bOT0/Quixyyptnzhog63z3pEBqBbDqRCTD
         54vSMLmMR2tnD1HDs+PAv2MjK6Ez7YpBj3ZYeWKFtg96hTIC00wCfm+bcLMbYK1juAbM
         WWim2meIcfVR/HZvZjPf1opksYPAqW+pSHRlEMJHmKWQammvlkbkE4Y5W7asL+FvSyu3
         fzCA==
X-Gm-Message-State: AOJu0YyKIxEKDCh2faUWR8THNG9FbUnU7qpt1+Va3ZB4V/KFtEB17ynN
	qcAz+ehYYWAcNfU+L6Nh6OmmjI3bDyGucZSquDubkwRUf5C2iyGlBNzdXTnzxwE2
X-Gm-Gg: ASbGncsG7h8m0xB12WCr0T7pFZ8V+imv9beC0LM9n2YvBcCtGBcwak9qQcjvAZumKAH
	nTfgo9o1arCG1d+Xqk5TV0Zke/GldV3cQNYJXtO3DEBFApFDzeyBzHcnvxf7WKU9iqBhROTYRDT
	XQJbxyUQZeGL7zkbfI5kJSfwfLcN/F7IJHfo9zA2qdliOtC79jYf6jjPl9F8/LH2fhY1RV446RU
	j6Bmb9Mjv9cd1aWRMWKdYHlsgSchsglxyQW3GbGssraOMGZhWxSNrtauy5qXDAR6LTmZEZAQcMd
	0dNGYs/yDlSWcwOkZRvlsKCpMgEX/DhlC732xdwjKuPG1h558oQUA4+akR/lmCebMCUOTXedPeK
	RwxAdQr3RJLJ/Vp+xUhEH4t7QbU4hJ9bN2GDSnLgb1HjwdwCGxA2A2uKBJnkUaF9sUgzdIRuzMx
	jsRZLPHCu2kYMcdXCSd2PlXWRsxJnJGcI=
X-Google-Smtp-Source: AGHT+IGF2LlBk8MgY82dhukvpRaPUI/wwgyCxQDYWEQ3Y75yTj2C+ot71kfjEIdT/cj44iwYu+Aixg==
X-Received: by 2002:a17:903:1ce:b0:24c:ba67:95 with SMTP id d9443c01a7336-2516f04ed3bmr63128065ad.9.1757286272081;
        Sun, 07 Sep 2025 16:04:32 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caf245690sm111254675ad.10.2025.09.07.16.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 16:04:31 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com,
	rjsu26@gmail.com
Subject: [PATCH 1/4] bpf: Introduce new structs and struct fields for fast path termination
Date: Sun,  7 Sep 2025 23:04:12 +0000
Message-ID: <20250907230415.289327-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250907230415.289327-1-sidchintamaneni@gmail.com>
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduced the definition of struct bpf_term_aux_states
required to support fast-path termination of BPF programs.
Added the memory allocation and free logic for newly added
term_states feild in struct bpf_prog.

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 include/linux/bpf.h | 75 +++++++++++++++++++++++++++++----------------
 kernel/bpf/core.c   | 31 +++++++++++++++++++
 2 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a8..caaee33744fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1584,6 +1584,25 @@ struct bpf_stream_stage {
 	int len;
 };
 
+struct call_aux_states {
+	int call_bpf_insn_idx;
+	int jit_call_idx;
+	u8 is_helper_kfunc;
+	u8 is_bpf_loop;
+	u8 is_bpf_loop_cb_inline;
+};
+
+struct bpf_term_patch_call_sites {
+	u32 call_sites_cnt;
+	struct call_aux_states *call_states;
+};
+
+struct bpf_term_aux_states {
+	struct bpf_prog *prog;
+	struct work_struct work;
+	struct bpf_term_patch_call_sites *patch_call_sites;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1618,6 +1637,7 @@ struct bpf_prog_aux {
 	bool tail_call_reachable;
 	bool xdp_has_frags;
 	bool exception_cb;
+	bool is_bpf_loop_cb_non_inline;
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
 	bool jits_use_priv_stack;
@@ -1696,33 +1716,34 @@ struct bpf_prog_aux {
 };
 
 struct bpf_prog {
-	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
-				jit_requested:1,/* archs need to JIT the prog */
-				gpl_compatible:1, /* Is filter GPL compatible? */
-				cb_access:1,	/* Is control block accessed? */
-				dst_needed:1,	/* Do we need dst entry? */
-				blinding_requested:1, /* needs constant blinding */
-				blinded:1,	/* Was blinded */
-				is_func:1,	/* program is a bpf function */
-				kprobe_override:1, /* Do we override a kprobe? */
-				has_callchain_buf:1, /* callchain buffer allocated? */
-				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
-				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
-				call_get_func_ip:1, /* Do we call get_func_ip() */
-				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
-	enum bpf_prog_type	type;		/* Type of BPF program */
-	enum bpf_attach_type	expected_attach_type; /* For some prog types */
-	u32			len;		/* Number of filter blocks */
-	u32			jited_len;	/* Size of jited insns in bytes */
-	u8			tag[BPF_TAG_SIZE];
-	struct bpf_prog_stats __percpu *stats;
-	int __percpu		*active;
-	unsigned int		(*bpf_func)(const void *ctx,
-					    const struct bpf_insn *insn);
-	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
-	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	u16				pages;		/* Number of allocated pages */
+	u16				jited:1,	/* Is our filter JIT'ed? */
+					jit_requested:1,/* archs need to JIT the prog */
+					gpl_compatible:1, /* Is filter GPL compatible? */
+					cb_access:1,	/* Is control block accessed? */
+					dst_needed:1,	/* Do we need dst entry? */
+					blinding_requested:1, /* needs constant blinding */
+					blinded:1,	/* Was blinded */
+					is_func:1,	/* program is a bpf function */
+					kprobe_override:1, /* Do we override a kprobe? */
+					has_callchain_buf:1, /* callchain buffer allocated? */
+					enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
+					call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
+					call_get_func_ip:1, /* Do we call get_func_ip() */
+					tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
+					sleepable:1;	/* BPF program is sleepable */
+	enum bpf_prog_type		type;		/* Type of BPF program */
+	enum bpf_attach_type		expected_attach_type; /* For some prog types */
+	u32				len;		/* Number of filter blocks */
+	u32				jited_len;	/* Size of jited insns in bytes */
+	u8				tag[BPF_TAG_SIZE];
+	struct bpf_prog_stats __percpu	*stats;
+	int __percpu			*active;
+	unsigned int			(*bpf_func)(const void *ctx,
+						    const struct bpf_insn *insn);
+	struct bpf_prog_aux		*aux;		/* Auxiliary fields */
+	struct sock_fprog_kern		*orig_prog;	/* Original BPF program */
+	struct bpf_term_aux_states	*term_states;
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ef01cc644a96..740b5a3a6b55 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -100,6 +100,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
+	struct bpf_term_aux_states *term_states = NULL;
+	struct bpf_term_patch_call_sites *patch_call_sites = NULL;
 
 	size = round_up(size, __PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
@@ -118,11 +120,24 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		return NULL;
 	}
 
+	term_states = kzalloc(sizeof(*term_states), bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	if (!term_states)
+		goto free_alloc_percpu;
+
+	patch_call_sites = kzalloc(sizeof(*patch_call_sites), bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	if (!patch_call_sites)
+		goto free_bpf_term_states;
+
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
+	fp->term_states = term_states;
+	fp->term_states->patch_call_sites = patch_call_sites;
+	fp->term_states->patch_call_sites->call_sites_cnt = 0;
+	fp->term_states->prog = fp;
+
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
 #endif
@@ -140,6 +155,15 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 #endif
 
 	return fp;
+
+free_bpf_term_states:
+	kfree(term_states);
+free_alloc_percpu:
+	free_percpu(fp->active);
+	kfree(aux);
+	vfree(fp);
+
+	return NULL;
 }
 
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
@@ -266,6 +290,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
 		fp->pages = pages;
 		fp->aux->prog = fp;
+		fp->term_states->prog = fp;
 
 		/* We keep fp->aux from fp_old around in the new
 		 * reallocated structure.
@@ -273,6 +298,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 		fp_old->aux = NULL;
 		fp_old->stats = NULL;
 		fp_old->active = NULL;
+		fp_old->term_states = NULL;
 		__bpf_prog_free(fp_old);
 	}
 
@@ -287,6 +313,11 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
+	if (fp->term_states) {
+		if (fp->term_states->patch_call_sites)
+			kfree(fp->term_states->patch_call_sites);
+		kfree(fp->term_states);
+	}
 	free_percpu(fp->stats);
 	free_percpu(fp->active);
 	vfree(fp);
-- 
2.43.0


