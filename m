Return-Path: <bpf+bounces-47739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F175A9FF4DE
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 21:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66D83A2757
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294F2A1D8;
	Wed,  1 Jan 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="1PDg7PbS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A71E1C3F
	for <bpf@vger.kernel.org>; Wed,  1 Jan 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735763856; cv=none; b=Gn11Wch7ncskmf06yb5vecoRznlGzmXLvUyure5Offb/icBQtnoeRFk/ITqz3fldAXyNZT9+f7M3CZGbOP2Jz+W4SLm2pxB/oK+DEGyqTAxOdg9ub5dxQicp/6gYnK9t5D9U5A1EtT0dwCROKy4UTYi1QgXI/LWFxTQRTF+ICXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735763856; c=relaxed/simple;
	bh=oOAGYda84KP9Wrh4wgVddZ45vd/zZk8ujluCW22S5iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMkMS8vmt8tHoVBT8Gr7TCO5PFf4c67MXfF0jyI6cH7KW4abTeY+oLtQiEil86x2xepHFW8JI/MEvYlYoOmKQ7tqr0E9F9UXKLKCZZBPccZwyjAwS19j74BdVQ1cWLzE2jTTrM6pNxF2E9kI9QsDAKymXWaHd5HnaR8SePaMc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=1PDg7PbS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a3c85e11so68096791cf.2
        for <bpf@vger.kernel.org>; Wed, 01 Jan 2025 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1735763854; x=1736368654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQvDUW0gd1c4wLq4dSG2XcVxF0NsBXqLmcnzd3qnYms=;
        b=1PDg7PbS8XzuHn3zwA3B15x7Gjr78CzNLzNtXEzJsMR1ogdLNxCf8XaGdn+QXHE8FW
         87d/9180gFj8fM0xn/Inh1o05LZWcTf1vH2YB6UleALUuRBxkxhYl08dbaNF+HopyI9h
         WpdHcPDI+Kr3j0WjXJEGz96s3Ig8sZlMA0MZyAe+Y94sQMwADj17tSe8mgi6ORZjgkZO
         mELpG//WgngFxWsYIUolfnVaK1X9I1f11Li7KBeaev354sakAogDGWk5If7CmEdMsdXn
         LPwZJm2u4QO77TDNGpcp4pU0U4hWawH8r5dpUCFIvTh1iVezT/FpkqT27bbiGsxjuYNR
         PI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735763854; x=1736368654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQvDUW0gd1c4wLq4dSG2XcVxF0NsBXqLmcnzd3qnYms=;
        b=XsizkP7PgPLhOtkhnfeJV018z1f80XjaaFrcaJrw7mmRk5/gyvavUHen/zG2SMDAjP
         LP/xhtxuK9+iwstS/DI0Be8qaIfOvC1J+WQxgiC2KlOdbteOekC9Si2Qo2JopO42JYGO
         /iralzKQnpcDolBmHntGFIz3BaQ6kKCjfpHfKnF2UA2eKXxCHu5TD2MA4xHKtPQN+5fb
         n3X5wPvcL8BbKLqUHdAqtFigf1AFrZT2Xczf1nlW/BiK8Vln3YEmBSHChWVYF2UHBT7V
         HEp7GpaStyRj+t0WDUDUxmAV6aHqOb+7W4KVB64SXjWkmlLbJul3BlO7I/yNtxuN8yEk
         zMUg==
X-Gm-Message-State: AOJu0YxWaQ8UJOjm9gXei0EQWPXuPQoz3ijWdgMtfcv75n/paFU7Y/KE
	k3gCgJmUNScdEGaEOUzYgVtACmLkZrorpYvfvdkMFzomC0timZmUU+RrjC8xn4lUoX77xr471bX
	0W4X6UQ==
X-Gm-Gg: ASbGncuDMg6r0D4F/NAhdKhjokddDmKrlieeDE77aW5LyNlGBtvvljjLz6LVxfJtKfC
	wzwH7hLWxeUF0/2ca85d9PPNJ8/JLwMJZ66Mjp/s/gmZo2SmfCzNc2d6V86/rKSftvPnC5JTfHK
	DmWn3oeiUf2iLfeIwhZsrgN3e8UvG8KoYA1qa/1PhoGtWSjmARzPKvkxu7kBhY9S/Q96KDE+HSL
	R7Rf6DCasdufFZOxltz/Ci+cpiN4uG5cOHxLM6pPu2WSgRYAxo=
X-Google-Smtp-Source: AGHT+IGB1wxPDYCX03TKhlGii6J+8l/w+7wHcWJq8XsKrjVtu6r2fqQ7PcaS4ZtZ+C0PbdfO/O3xiw==
X-Received: by 2002:a05:622a:287:b0:467:76cc:622d with SMTP id d75a77b69052e-46a4a8b6f01mr603498201cf.11.1735763853768;
        Wed, 01 Jan 2025 12:37:33 -0800 (PST)
Received: from boreas.. ([38.98.88.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb30dc4sm128358131cf.76.2025.01.01.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 12:37:33 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
Date: Wed,  1 Jan 2025 15:37:30 -0500
Message-ID: <20250101203731.1651981-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250101203731.1651981-1-emil@etsalapatis.com>
References: <20250101203731.1651981-1-emil@etsalapatis.com>
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
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d77abb87ffb1..f209021914b1 100644
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
 
+static bool is_bpf_loop_api_kfunc(u32 btf_id)
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
+	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_loop_api_kfunc(btf_id);
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


