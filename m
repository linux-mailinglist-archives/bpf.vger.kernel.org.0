Return-Path: <bpf+bounces-29525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A428C2A86
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D38B21A3F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B815028C;
	Fri, 10 May 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeNCyg5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169E4E1A2;
	Fri, 10 May 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369060; cv=none; b=nQTabKKPsbGuWAe63JVnBv2zhIdGoa0yG3SaXF9Xi9nuuyyCk9cckTG30bEzGlsH6Mmk6UIIXfiv5Zo+ETfbVfo3ytsGynOVO/b0EZuG8IJhkWQmr0CwHHE62HFoc+7j1T9r0/ASNI/h5L4sZrecxXyV+cLlfnS4+LNXBC/N/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369060; c=relaxed/simple;
	bh=CR7ZGBrrR73rmPsA8ZlyLKpezlNbf+aOQYW9pxfs1sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMQhqIXlpmwzsZeddpwUsg29LKKh8MrYOKgwMly0wqz4OJTGf3xePoeF4M+huZnMDHekoANyPby4vLIzEUMogiB3LkRInOyr3q6f98z/kHFapDtbyVJP0U7LzVzBPmIdYvAw31n/Y7yTsmaIHHuDzAIzS0/waUClpISN4B5zEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeNCyg5x; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfcbc4893so7532801cf.2;
        Fri, 10 May 2024 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369058; x=1715973858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9a/RePxiUW4k3uhOxmW6u08M40VUxUFwzco5EbUNc0=;
        b=JeNCyg5xuDt/th2C7VAkAhXdaTaAiXaLqO+rzXAbDtOCvnkrkbUE4LDVZbKXC0NqrT
         hPNEyO0mudmNpLjEnYsGomvgSiT+MY3Jd7ZNh8Sq2j+mMmPx+u5xxOM638IIvEIph4jy
         F18h8Fl+PicJ79mem5eInejQI8fSACFbGMmaPc7EzUCAIl3lAIbvfMi+slPPfxOY6dEP
         E8xBGKL6uEtturW4vWPcJiv9ErUy+lJp/gDbcxTjOmBzqU6jutSFKhCe/KgxKGvce6gJ
         k9XKA7a4xnQnEXp3olvQ5+OYy8oc28Brv5+z1hz+SNIEdmnrhPGBlTlq9rPPq7cZeSBr
         MZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369058; x=1715973858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9a/RePxiUW4k3uhOxmW6u08M40VUxUFwzco5EbUNc0=;
        b=vCbf14aSswJuwYSVDayfYgkv+sye3E/HFQuYsUKUoCDGsv8ZUAYcABeabYoWHCtFl/
         lYoOl9BXKBuz8JhFmeMSR+G8o+vS9iem5zD6B533abx3EfdfM/AQETujU05BTvA1oafc
         p083/DHjBbQhF0lVyJkwJtYPkyCSc6Zl1oQ9U3tdEHMzr46Cmws4Hz7XzqvV0wcKs3Kx
         0jSydOoP2MHfhxaiiAMTDgbHdf9QhHEARnv+bO/zUidqwzjJJiL6qMgGF0Aw96iEdHjk
         gpYhMkmD+gZ7DTyYzX5ylveeFhQ308wCvOKzDtqZ3nIwXOHe4lpzUFPOsvPX8cZVPL8C
         DFdw==
X-Gm-Message-State: AOJu0YyWO24QTHx38UiqWv9ZVvt7clihS5T29DYy76kXGEWMYQH4Auvf
	wYjWx2XmNyuopnBNPFkgUXmvHSOXsIaCNFrEFEvLAbECPymEyPQc8i2seg==
X-Google-Smtp-Source: AGHT+IHGYwgAYVc1lAXO8jJHVThO9Wh4re+Kr0NbMB6VMM2aDHzcaVGso/h6KW7cH7FrINXv2pe3tw==
X-Received: by 2002:a05:622a:5c8c:b0:43a:dbbb:a19d with SMTP id d75a77b69052e-43dfdb72e46mr44227511cf.33.1715369057814;
        Fri, 10 May 2024 12:24:17 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 07/20] bpf: Allow adding kernel objects to collections
Date: Fri, 10 May 2024 19:23:59 +0000
Message-Id: <20240510192412.3297104-8-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow adding/removing kernel objects to/from collections, we teach the
verifier that a graph node can be in a trusted kptr in addition to local
objects. Besides, a kernel graph value removed from a collection should
still be a trusted kptr.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf_verifier.h |  8 +++++++-
 kernel/bpf/verifier.c        | 18 ++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7cb1b75eee38..edb306ef4c61 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -864,9 +864,15 @@ static inline bool type_is_ptr_alloc_obj(u32 type)
 	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
 }
 
+static inline bool type_is_ptr_trusted(u32 type)
+{
+	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & PTR_TRUSTED;
+}
+
 static inline bool type_is_non_owning_ref(u32 type)
 {
-	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
+	return (type_is_ptr_alloc_obj(type) || type_is_ptr_trusted(type)) &&
+	       type_flag(type) & NON_OWN_REF;
 }
 
 static inline bool type_is_pkt_pointer(enum bpf_reg_type type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d4a55ead85b..f01d2b876a2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -413,7 +413,8 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 
 	if (reg->type == PTR_TO_MAP_VALUE) {
 		rec = reg->map_ptr->record;
-	} else if (type_is_ptr_alloc_obj(reg->type)) {
+	} else if (type_is_ptr_alloc_obj(reg->type) || type_is_ptr_trusted(reg->type) ||
+		   reg->type == PTR_TO_BTF_ID) {
 		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
 		if (meta)
 			rec = meta->record;
@@ -1860,7 +1861,8 @@ static void mark_reg_graph_node(struct bpf_reg_state *regs, u32 regno,
 				struct btf_field_graph_root *ds_head)
 {
 	__mark_reg_known_zero(&regs[regno]);
-	regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC;
+	regs[regno].type = btf_is_kernel(ds_head->btf) ? PTR_TO_BTF_ID | PTR_TRUSTED :
+							 PTR_TO_BTF_ID | MEM_ALLOC;
 	regs[regno].btf = ds_head->btf;
 	regs[regno].btf_id = ds_head->value_btf_id;
 	regs[regno].off = ds_head->node_offset;
@@ -11931,8 +11933,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_NODE:
-			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "arg#%d expected pointer to allocated object\n", i);
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    reg->type != (PTR_TO_BTF_ID | PTR_TRUSTED) &&
+			    reg->type != PTR_TO_BTF_ID) {
+				verbose(env, "arg#%d expected pointer to allocated object or trusted pointer\n", i);
 				return -EINVAL;
 			}
 			if (!reg->ref_obj_id) {
@@ -11954,8 +11958,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			} else {
-				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-					verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC) &&
+				    reg->type != (PTR_TO_BTF_ID | PTR_TRUSTED) &&
+				    reg->type != PTR_TO_BTF_ID) {
+					verbose(env, "arg#%d expected pointer to allocated object or trusted pointer\n", i);
 					return -EINVAL;
 				}
 				if (!reg->ref_obj_id) {
-- 
2.20.1


