Return-Path: <bpf+bounces-68722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB548B82364
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CB71BC38AE
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E493128A9;
	Wed, 17 Sep 2025 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DItdIes6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562F3126AF
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149721; cv=none; b=q/GKEblqT8iP//n7adt6FomomHRPu+zlA5P65Apob6n4xCK7o+DE+FdP0JmOJSfUX4t1YELO4h42G1ovMxT0YUkVDMXJQ++Uj6DIaF4egEJkZ4fDZFjIsG5PYOeGsrC+ChILJcj96gD/+2r7el0j5KF21uY9id6XfZXDmq62t5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149721; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3qUQ3yAYdxkyaS8GjW39JYXyYkfa73z8Way2y7Bf/Dad0KWrHXwtYIj8sD+LnSFTZvDvupvVxMieA0qztk9hKpW+4MISDwfVSH8HT3kkElmvXHN0cXWzYXRkDJEgpz5dUlosIWpETB541xnsR1jmm1oFId5iKE+NiSyOzLRLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DItdIes6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7761b392d50so486759b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149717; x=1758754517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=DItdIes6yb2LEXKS4T6o14J47XkhH7sHd2L/cf9P+mL72f1mcpqVNlLUfA6VK4uG5q
         Z1b2bLQF+BSA3GwazBUyDup3Oj93Z3mFWaUESsJeTQQR7JyqghCtCL1mVZ0ROz75xzF9
         frdOLemMLb5FqCHACWEzxQZpn4BIBBCd9IJIo6KzMvwJrNSH8WlXHZ9xp3M+1gDBa1yd
         l2YVH9KDXOEgIHO/R3VIQpPXGa6rHZRey67ARc9ade8WfoI9dNBIIhPdhxHe2I8Y6Yf6
         fdbYC6Ns4Byih+kKcZI4d0e2/KHGX3S05xUb+/LZ6gi6SEU5j1jXTGQyc+M5kDszEfc9
         RVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149717; x=1758754517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=kZrCfnQRloAdJqQlS8BNTZmURzJ4NAvf1pTDo/iEgV2RkOf45JuYMRWFG1RnB/5QQn
         e2Ez3qOyNZVFqqURHtNej567p8MNyPZVkf978WXSzCjdCLwCwn1Ioh44KHy6+xzcY5VH
         XAQPnRmcQmO5Zr34ek/pR2WOINUxrmP47fS5weOUO4xwGvaE7Z7/Faz0mFFO81qcPUqb
         JeuQ4PKmzX6daFgYBbpZzixIEvAsgo+8/YDjBKfJNs35Ojpt8cNPN6whtATqg3hQLrCD
         NksRRHGqMfAcHzy6MtRPbgkRcV2dZlIQGsNXBwqTPWUEa/LrOHwVZaBUuC2IR9bCwSRC
         Ow1A==
X-Gm-Message-State: AOJu0YwQOpEtdHRXDQ8vqGTAkEyG1wnLsKiPmtjcgxetcoAwqfgqfhWU
	/m+J2isoH3OcsyS3ZY9EGZZj4HUtH5c2KvdVhf47iUE4fucKIx/BiskLuZz03Q==
X-Gm-Gg: ASbGnctXAFSRAk+RtTHSStTcg3M04c2AEHrI2f+5hhKx9e4IieRK4cD0YGrlhQ6aq4U
	9ZGmzoJI3QF1JCbT2cMRuthSfRemm6BxgRjvU8HmDisaiATByQcCPb2/71OR/2ergovwcNg9UL3
	ZtKc8uSGiJXgCl27XrYhK+U9KTwGd8ZxZ0jzO6sAegMGYzgR858RjbA7VPNNVFPcYGy273w1uDA
	jI/gWyRpWKWNRpXNPy1RVmPBxXKP+w0XJwCJERz8lxRCRaGlsXtjXCkhZWEBEoy3cAH05Z74g8d
	/SfgQWevsQ7seiHvra5wk9duKvYsX6b5fsz6CrKRBaoMuldVLdCR96E1LWqH03zuCVX6XQstS//
	9xA2kSvGgEGJ8tinHSsLWw67fX8N4RYmUDU/myzcEUYE=
X-Google-Smtp-Source: AGHT+IGf4dMR+5wRnSzr9VNnkG+v2fzxz7wCOoftR/K3LFxTrmZBg/cv+EnRZcOkZ8GZjcX+SnyzVw==
X-Received: by 2002:a05:6a20:3d05:b0:251:1b8c:565c with SMTP id adf61e73a8af0-27aaf1ce7admr5424585637.31.1758149717492;
        Wed, 17 Sep 2025 15:55:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm443892b3a.94.2025.09.17.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/6] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Wed, 17 Sep 2025 15:55:10 -0700
Message-ID: <20250917225513.3388199-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_pull_data() may change packet data and therefore packet pointers
need to be invalidated. Add bpf_xdp_pull_data() to the special kfunc
list instead of introducing a new KF_ flag until there are more kfuncs
changing packet data.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db..ed493d1dd2e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12239,6 +12239,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
+	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12289,10 +12290,12 @@ BTF_ID(func, bpf_rbtree_right)
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_from_skb_meta)
+BTF_ID(func, bpf_xdp_pull_data)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12362,6 +12365,11 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
+static bool is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -14081,6 +14089,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_kfunc_pkt_changing(&meta))
+		clear_all_pkt_pointers(env);
+
 	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
@@ -17802,6 +17813,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.47.3


