Return-Path: <bpf+bounces-39990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF67979E3E
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5E5281510
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A914A62A;
	Mon, 16 Sep 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/GlrFEI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC24AEF2
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478301; cv=none; b=oiRJ0x6Omt/WHkVKC4FJCRBlkBxgU3iP3FMG7upDwsYg9jANeJds7oUG2Qzu0+lAsdnz/Yij4beJ5KSXcyfeXq67qzVwOVbDyvhNEXo5rL5X5HcyjncW0+bbeUC4Ra3kj4wdN0UBs3KyMSI3AsAH99IoMihKsZXmQZcXDKeeoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478301; c=relaxed/simple;
	bh=vXB1ltdueuJTPO9Ur04wBgDjbhC/Js9Buiqj+gYXNOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMpaP22ldgX14rrjKa467icBEiLg0gISMO8LMB2hVOq2uZQiYq0xsyfKI4m084EYzTfZ2kU3rlWt/CRKBYXZsBh68aShpVPkruS49Gzw0TlpLLSAzm29JR+Rqw7p3V0SRKZ7Ny+E1oz3ZiX4Y3lYsc19ePp2Ak85IIkCSGXzd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/GlrFEI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055a3f80a4so27222535ad.2
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478299; x=1727083099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbxFz7dV+ZWVbIZIwQdM92e5BVqo4TzVLga0n5ZdWjQ=;
        b=I/GlrFEItO2GYoWsqJaQLAwrjRpWUoK3+6kNzcSorLLk/B4aDi7OmHNrcyhh5wLJSU
         pURzp8SxJiVwR5aixFZ0vwrcFM48vspQeh+0EDeAqAb4tBu9CfuSgTIAb2U2mInR7GGp
         TFA/23GhTV3Lz8Q0P205hIgOsVcBs90EAX1fWyQN0xGvHgAj4rbRnjvFc5wGx09Jj9G0
         AxETUxO8Ur5RZM4r+atmZInaYbAWf3X91CiKhXMyc4xqsa0XOFaOxY2YkE5kODutZnNT
         89rAPZhhPHkRiMqDp59RceSQhFu/sFN2a+K6iXNFCllGg7Elvyzr1IuGveMnMsVr4PFj
         nGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478299; x=1727083099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbxFz7dV+ZWVbIZIwQdM92e5BVqo4TzVLga0n5ZdWjQ=;
        b=hw5o2BrJL32qK1H77W66t4tARRanvkLQhGYV7Xa7nd/Xj5hvkf1azz5UZqaWjhQZ2f
         x0vkCBBYJqiFRQ1wHc1j2f8IZd1p3MuR1XLWcs6RLd8xq+qlnLLumUDTfYu4tCOpQD7j
         A2hVVLsJk46cWvZM0qhmoD6l/PnuLHyolnX3pm6kde/lcityTYl1Qm1i4E/FjVaTv20R
         lkccAMnGA/YDSzfMdLxW6bigV4OPyNqfAbb2qxXmmpdtZ87MmEm8iwP9bnejpokEa2oO
         3DZPbY9fCnKJ2x17c/WhvP4hQ5XE7uoZJdtEDziXFNVVHC4JTf62rRDZ831yf3HPHftW
         vjVg==
X-Gm-Message-State: AOJu0YzyqF6qHmGPpSu6NQb0c8twHn9WLRPL4rZSH5LYUXHvtPRTBNBx
	z7afKIFoMuyjl2owWWmGV2J9YOyA8C3SGEcoBtaoRRxXY+dnO2w0lkTkfw==
X-Google-Smtp-Source: AGHT+IHD/k9jIP+Hsb+wcBHraD2Ehqtais5TIxtz2CIjmmKPgunztZxyf8msaTpmQbuScVvXo7iRug==
X-Received: by 2002:a17:902:c411:b0:206:b7b8:1f0e with SMTP id d9443c01a7336-2076e319544mr217856865ad.1.1726478299528;
        Mon, 16 Sep 2024 02:18:19 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm32882195ad.38.2024.09.16.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:18:19 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	arnaldo.melo@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 3/4] bpf: use KF_FASTCALL to mark kfuncs supporting fastcall contract
Date: Mon, 16 Sep 2024 02:17:11 -0700
Message-ID: <20240916091712.2929279-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916091712.2929279-1-eddyz87@gmail.com>
References: <20240916091712.2929279-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to allow pahole add btf_decl_tag("bpf_fastcall") for kfuncs
supporting bpf_fastcall, mark such functions with KF_FASTCALL in
id_set8 objects.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h   | 1 +
 kernel/bpf/helpers.c  | 4 ++--
 kernel/bpf/verifier.c | 5 +----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b8a583194c4a..631060e3ad14 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -75,6 +75,7 @@
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
+#define KF_FASTCALL     (1 << 12) /* kfunc supports bpf_fastcall protocol */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3956be5d6440..d80632405148 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3052,8 +3052,8 @@ BTF_ID(func, bpf_cgroup_release_dtor)
 #endif
 
 BTF_KFUNCS_START(common_btf_ids)
-BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
-BTF_ID_FLAGS(func, bpf_rdonly_cast)
+BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_rcu_read_lock)
 BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f35b80c16cda..80a9c73137b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16199,10 +16199,7 @@ static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
 /* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
 static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
 {
-	if (meta->btf == btf_vmlinux)
-		return meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-		       meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast];
-	return false;
+	return meta->kfunc_flags & KF_FASTCALL;
 }
 
 /* LLVM define a bpf_fastcall function attribute.
-- 
2.46.0


