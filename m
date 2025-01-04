Return-Path: <bpf+bounces-47883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05916A016B2
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFACE1634F9
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBD1D5AD9;
	Sat,  4 Jan 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="eQJbMpFC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DD15A85A
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736022334; cv=none; b=Y1kXxX5TGFNAWiSbiv2tL59knXxBqHU3tLBhHAuN9AGRcv0djSJzVUyX28KuGaLtJnjjjnBVivdLJU7rUjYW11THX7G4174U7fLepvnGGguceA4qP0v7jYzSln7ukvsYs/HgkszSf+C71DAki5kLvq9DJSRPtvNiOnI5Rhzgcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736022334; c=relaxed/simple;
	bh=Aig17z0fUyDdNaCgQ0nmX92rxa8jXCAn/41TWtttD0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7aGs3gl6qO6HWYNW3id4p4kP7xQ/w9IvFMWozDOL/cv8jTDGY+0zHq/QrHqImLBVAuEtF2gL2fx+9dIFFp/iTXAYVFkL6BAQXmePS+jz3sxaGDnLefdCoHMZ0mq2yde7zlC3+8rmy7+iL7h3ez3CiBhD/wqivtsSRWEp477hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=eQJbMpFC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso1165304785a.2
        for <bpf@vger.kernel.org>; Sat, 04 Jan 2025 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1736022331; x=1736627131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqUYjmLWWgNE4Yev5OAuUk4FSdcf5Ej+nTRpHHILuUg=;
        b=eQJbMpFCNbEhDcDtUmN8KYn55Kd4+CpNlVN8gpn8FgjZ6CT1qoYJSb+A7eJ2h23opl
         VmJUKi9eUXjXD8kxkf58ZspI017ieFCsgn9VBYicfgpbcwA8h8yBepgqrOd9FbtaphIB
         AMMi6w1Fb0btQmrssBGJbqd65qcq2jxiXkGTqS2s0X49PNNAhd/fqiObu5GB7NKJVG0+
         +DX8sHCHZ3nUV+u6SQAIkX8f99Bddod1HXI7XOk/5XCzcXvsaVMagoab709BET1e0CrG
         aQDEPXu3znbnUvn5ANEJYi4z5Bn0PBj1VfpeST0RCzU9FD7FfPNMsAjL57hKSrirlsB9
         aj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736022331; x=1736627131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqUYjmLWWgNE4Yev5OAuUk4FSdcf5Ej+nTRpHHILuUg=;
        b=JnDIe3G2gS+5yoe8lfQZlxi2AAqp2FK2EP3opGX3ZSgCvgQkJLYlRUueYFMyXe23++
         0CxsVwYN0DGuFCnrXO6puXySxa9G7cyLgFPRtbkgsCO/Hm9bcjbCIK3yjeuE9ZAsji8n
         4N0gwn+xGPlaK9qTDyX2F7lz1/cjU4UBKtqfzhuzTO8w8jygKW9yJgesMSizgU03NhC9
         La0eJ8PvsaDfeBOtr+koKV2vYsmgwbBCMYOdIZJKF/gbWE2zejVELNZ45mX1mVwURZNF
         59VQQAem2eIZnYZZxT0KHvAjLI3yYtDu8y2RC/eylBin0Yrt+BmL2Jb7e37OLIMswauM
         2v/g==
X-Gm-Message-State: AOJu0Yx+7AVUK0mzClBzojE1r1ZcfE2c5Gh42C4GDGUIc+IZxXsUAr3t
	I24s+bi34YDD6JvbiXX4HTxva0dhJPwxqvTCevTlus2t2fLEut4iiJGlaiOSNZXnC1YXkOQy//V
	DEhdJ+w==
X-Gm-Gg: ASbGncuQYgg5PfF6DckQXvOyUZqnurtnWfHZRu2fDuPXmE4zNinBvu7pHx9qzBVN7rw
	eKBk8jvxma9ZcwzV92djKa1nIr+nWlBJo0bLDgQuG1Kv3hiB+GrE/kFSfOPPzyJiNaPJGevaf7R
	p4auK85dIyjPz8d/tIYKw+1mLg0XVsooyAFuueYCydTU7ls+o14eAyKb3ATqD8UqSwl0IjxdJSu
	eOjUSfOurOhRPjnHfwYhmlmltKRTy1Y4EYHzEPLeS4C0Rt/XAM=
X-Google-Smtp-Source: AGHT+IGWzxnnSkpBH5x8L3y8CFCC8Aa/pDuzS7g+WOwfFsySTseo8JdX+bkx7QEu14oVYzmXGTm7CQ==
X-Received: by 2002:a05:620a:2629:b0:7b6:d9b6:b53 with SMTP id af79cd13be357-7b9ba83f37bmr9823982985a.60.1736022331641;
        Sat, 04 Jan 2025 12:25:31 -0800 (PST)
Received: from boreas.. ([38.98.88.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30d7e2sm1376162085a.59.2025.01.04.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:25:31 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
Date: Sat,  4 Jan 2025 15:25:27 -0500
Message-ID: <20250104202528.882482-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104202528.882482-1-emil@etsalapatis.com>
References: <20250104202528.882482-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Add the bpf_iter_num_* kfuncs called by bpf_for in special_kfunc_list,
 and allow the calls even while holding a spin lock.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d77abb87ffb1..b8ca227c78af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11690,6 +11690,9 @@ enum special_kfunc_type {
 	KF_bpf_get_kmem_cache,
 	KF_bpf_local_irq_save,
 	KF_bpf_local_irq_restore,
+	KF_bpf_iter_num_new,
+	KF_bpf_iter_num_next,
+	KF_bpf_iter_num_destroy,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11765,6 +11768,9 @@ BTF_ID_UNUSED
 BTF_ID(func, bpf_get_kmem_cache)
 BTF_ID(func, bpf_local_irq_save)
 BTF_ID(func, bpf_local_irq_restore)
+BTF_ID(func, bpf_iter_num_new)
+BTF_ID(func, bpf_iter_num_next)
+BTF_ID(func, bpf_iter_num_destroy)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12151,12 +12157,24 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_rbtree_first];
 }
 
+static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_iter_num_new] ||
+	       btf_id == special_kfunc_list[KF_bpf_iter_num_next] ||
+	       btf_id == special_kfunc_list[KF_bpf_iter_num_destroy];
+}
+
 static bool is_bpf_graph_api_kfunc(u32 btf_id)
 {
 	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id) ||
 	       btf_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
 }
 
+static bool kfunc_spin_allowed(u32 btf_id)
+{
+	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id);
+}
+
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
@@ -19048,7 +19066,7 @@ static int do_check(struct bpf_verifier_env *env)
 				if (env->cur_state->active_locks) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
-					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
+					     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 						verbose(env, "function calls are not allowed while holding a lock\n");
 						return -EINVAL;
 					}
-- 
2.47.1


