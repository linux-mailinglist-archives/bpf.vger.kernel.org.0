Return-Path: <bpf+bounces-71470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5BBF3E33
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00EC18A61A9
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC122F1FD1;
	Mon, 20 Oct 2025 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAmBQXGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A72F12B1
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999155; cv=none; b=DMY0ArE2RF3qrzLEtDzdXPwxiWpDLYTAxKT/I8ZKAdaEyBe3rpW69zqGG7sHkC+CMQifCpV+L49hcvqc4BRHJ/lkx+eimORXdyVrbZFGvVJuVAcscsEr+blMK85RG1S3NkUyOLmpMIEjqbu9y5Ko7SoXghkX37ssw54HCJnMg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999155; c=relaxed/simple;
	bh=gB+8x6dGeRvwrkg/EB6T29idDkhNjzAfygV8qOJPywE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctsXA+s2MPpnEJHQ3qAtz6GT/3I1iEK5RdxFOYzmzhJIhCi9PtXoj843q2q5LK5OOqE6/mZB2i79UJ2syU7OLn2b8e5YJR5OUJtMwsxX5QMdF+UcdA6KmiLe8L7fOG0szpH+Ez548LNkeTzLj6BLMyiqN7URXnqYqcml7kaP84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAmBQXGJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so4198475e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999152; x=1761603952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVP3QOWS+zevtPZR8gz8c2WsSkL9+Dqlpayrtaa42mc=;
        b=eAmBQXGJndbohRXFrhNE5a2DTzoIAFVu6csNL/swje6JAZaPXwyORysItUWcXzkkq+
         fB1cvSYc6ZXk2LkrAV4AoHjzcBzvYH1R+CAo02RbAmaleP6iRs1n1tH/OzCFC2hWFLNO
         RIe4sSFht/6LLaTidIn7dGhjiJxEMnnmQg9DhiTdJ4mIl+qahfN4SZF46FFejCr6PLSy
         /suWcAI++UNCxwGZR60wSqgGwPHT5lbLdm+iURaEVTgc3L6E7xzZojOjkrnGnR6gm25H
         adNVgfJb86V1zKEyoK3cKmf+tGSJsIcGuiV/8D+96iYKLkFXWVRUs8TJP4npYnx493wA
         vFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999152; x=1761603952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVP3QOWS+zevtPZR8gz8c2WsSkL9+Dqlpayrtaa42mc=;
        b=jXS8HtvWFSX72JDrGlQwrNBtB7/oHNZOggG0jTWgdNt0BhR7Knet+HbtBJrB99lTR7
         LxhNiQnkYTup9Tmvtfai3lUpEhZrYqVKPLWlpVZyzytlWOEO7feeVf2zijCXvBIic50J
         HpY+khRvxOBlRVCtC0OCsqFMzGT0ykIzkv2LuY2TnQFoyoA0CZzwy/OTstMRkJMzbQwC
         KExa8Y4kszdZh96dMbid9fXIs/Vo09HVyB2oPdk+WGg75xoTPGGzgXBxfEu1VQELq8qo
         lwzw76gKp1BP/lVcDrA/5wh2jZD0Pkya/WJIxL4CkOsSzVDjJfIybtQnOFjqOkCi2lq4
         8Qfw==
X-Gm-Message-State: AOJu0Yysp6iqrcqD+2HeMI5MxeRBiVLqreHGe14x5d8kAoNyYE0Ef4gy
	fqThCAOmTC6HOaU+qdsONKD7gkChkZqgbKv9r1wjEIGOllVKenn9/4/2o798rQ==
X-Gm-Gg: ASbGncsZJ/TVmYS8EeM6JKN6Wxs/hFl6x6s4GGbWRLdEYg82gtGxQVrXlGIXHxWWX9a
	JbqwgubP9MXiLO93y84a1X55tBMRlFazeGCbgafVDV9Xc8O2Q9+sn/GeMzQcQs3SyyCheQT+PlH
	6Vm2cnUIOhdc4DEcraaQb4x6u2HtjvWXG8W7A4poMpkeWxJ9yQkVV5Wezj5SPoLwaLOonKwJmwj
	2yFw5pB0MxmJSMoN/z6OqrjEPebend2biA/QnEAgYdbntMdsmodhFPplUIXYdEICQO7sNZ1uayP
	nTet6QWwQjt91umlJA3NhpCeia9CB4GQeJTuI1/v1LMeGfUopK7n9Ah+gpOksc5Ls5Wd6ciRJlb
	T1reRaPfqlHJFbzyHmHDSjMAfpPk1KBkCZRmcU+aU1dkBwUI1ohVpAr9DxbQSJlqaFXajCA==
X-Google-Smtp-Source: AGHT+IEoUObCeuOdkNsXe9fVj/yk3vmYgndIS2wUL1WqAF3asIwQ125wxEUemMxt6l/Siq8vGzwJ0Q==
X-Received: by 2002:a05:6000:400a:b0:427:492:79e6 with SMTP id ffacd0b85a97d-42704d83d9amr9340863f8f.2.1760999151890;
        Mon, 20 Oct 2025 15:25:51 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c43f68sm2784365e9.5.2025.10.20.15.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 06/10] bpf: add plumbing for file-backed dynptr
Date: Mon, 20 Oct 2025 23:25:34 +0100
Message-ID: <20251020222538.932915-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add the necessary verifier plumbing for the new file-backed dynptr type.
Introduce two kfuncs for its lifecycle management:
 * bpf_dynptr_from_file() for initialization
 * bpf_dynptr_file_discard() for destruction

Currently there is no mechanism for kfunc to release dynptr, this patch
add one:
 * Dynptr release function sets meta->release_regno
 * Call unmark_stack_slots_dynptr() if meta->release_regno is set and
 dynptr ref_obj_id is set as well.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h   |  7 ++++++-
 kernel/bpf/helpers.c  | 12 ++++++++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++------
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 349bc933fa17..b600230f8b07 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -792,12 +792,15 @@ enum bpf_type_flag {
 	/* DYNPTR points to skb_metadata_end()-skb_metadata_len() */
 	DYNPTR_TYPE_SKB_META	= BIT(19 + BPF_BASE_TYPE_BITS),
 
+	/* DYNPTR points to file */
+	DYNPTR_TYPE_FILE	= BIT(20 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
 
 #define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB \
-				 | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META)
+				 | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META | DYNPTR_TYPE_FILE)
 
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -1385,6 +1388,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_XDP,
 	/* Points to skb_metadata_end()-skb_metadata_len() */
 	BPF_DYNPTR_TYPE_SKB_META,
+	/* Underlying data is a file */
+	BPF_DYNPTR_TYPE_FILE,
 };
 
 int bpf_dynptr_check_size(u64 size);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a2ce17ea5edb..bf65b7fb761f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4252,6 +4252,16 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
 }
 
+__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
+{
+	return 0;
+}
+
+__bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
+{
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4429,6 +4439,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f50533169cc3..70221aafc35c 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -500,6 +500,8 @@ const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "xdp";
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return "skb_meta";
+	case BPF_DYNPTR_TYPE_FILE:
+		return "file";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 157088595788..4c8fd298b99a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -692,6 +692,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_XDP;
 	case DYNPTR_TYPE_SKB_META:
 		return BPF_DYNPTR_TYPE_SKB_META;
+	case DYNPTR_TYPE_FILE:
+		return BPF_DYNPTR_TYPE_FILE;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -710,6 +712,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_XDP;
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return DYNPTR_TYPE_SKB_META;
+	case BPF_DYNPTR_TYPE_FILE:
+		return DYNPTR_TYPE_FILE;
 	default:
 		return 0;
 	}
@@ -717,7 +721,7 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 
 static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
-	return type == BPF_DYNPTR_TYPE_RINGBUF;
+	return type == BPF_DYNPTR_TYPE_RINGBUF || type == BPF_DYNPTR_TYPE_FILE;
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
@@ -12291,6 +12295,8 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock,
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
+	KF_bpf_dynptr_from_file,
+	KF_bpf_dynptr_file_discard,
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
@@ -12363,6 +12369,8 @@ BTF_ID(func, bpf_res_spin_lock)
 BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_dynptr_from_file)
+BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
@@ -13326,6 +13334,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+				dynptr_arg_type |= DYNPTR_TYPE_FILE;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
+				dynptr_arg_type |= DYNPTR_TYPE_FILE;
+				meta->release_regno = regno;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
@@ -14006,12 +14019,18 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
-		if (err) {
-			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, meta.func_id);
-			return err;
+		struct bpf_reg_state *reg = &regs[meta.release_regno];
+
+		if (meta.initialized_dynptr.ref_obj_id) {
+			err = unmark_stack_slots_dynptr(env, reg);
+		} else {
+			err = release_reference(env, reg->ref_obj_id);
+			if (err)
+				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
+					func_name, meta.func_id);
 		}
+		if (err)
+			return err;
 	}
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-- 
2.51.0


