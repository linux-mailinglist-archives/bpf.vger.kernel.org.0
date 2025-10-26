Return-Path: <bpf+bounces-72281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC9C0B35F
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 999244ED221
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553426B942;
	Sun, 26 Oct 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRTzT57u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF42C2ACE
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511157; cv=none; b=i/dYsjdAo80ynCJHR2Y8XzRNkAhu4w/17ni3snXfN/38ZZFoz4M2hGEQruu5shd+Qz0pfmIB1GDJ2LO1cCZ7xDualzzgk8/oLbGIG3LiG6Nb8te54LiQFlZuifZ6Y0fKFClgjuX+4kOpdISwHH9gePDyL5hszNCPKaul9JA6uUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511157; c=relaxed/simple;
	bh=rgeBEYp16ii33bvG77/ywFXFgZfKeNT7+wpF9eGPy0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXn8Hm9TiJywPRy3akvQzqz2R3WkYXSbUXH614Ms3aAwrp7ulbI8X6oR+YFBMMuadBY/xb+XU7teyCoBeAr9DHpqTvSNtd636o52Q3O/tHTvB5zbvdLYJ5AbfYTo4A6/j0EgLncYXj74zjNuEZ+QL37UzkmQ4p2zNW58qeRmrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRTzT57u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso5661555e9.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511153; x=1762115953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIBjvpB/1MhGus5255RsZZc8tzvb/j5ICxk0N6Qq05M=;
        b=jRTzT57uBP48ZCP5nAchCkyVaeRxgf6m9hMfFrDDbotN4qkMWUZn/Z0oGw2pJs4VvW
         NrGTE+/DM3tMaTB9XALfb8IliQO5LAobdFyHfIVm05trbfL93rP68XTlbq+J4ACLm9dW
         xEjltA9ePVF30hekQLvibA9BmDRwUfKk0FUJWTwOxtEYBgo/Y6MKoDn20IssXDrIUOVz
         TQzHkllYtlL/bCAUDlTvTldKwB0sfkYmX3Jcv5q7+T1Did8Rs/Glt9bfHGwGwTnHTGNT
         LbiHWDEXts2ooqJAYejDoijbMkaKU726jn+VLauvwWM6CGjxLG4yn6y0H3+4nocfyrRK
         QwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511153; x=1762115953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIBjvpB/1MhGus5255RsZZc8tzvb/j5ICxk0N6Qq05M=;
        b=SBtFBjBOkOmpJpa7+rdzYovxStQW611oG+hVQ1cydtGGJzgKKURO8fueCmztmWPEjS
         TSP8gMlhdn9x9aiid7AgDX96SVzZ3jvWyGT9xlrrtKMyeCWUCQX2+rig39mVB1C+NM0t
         z/zHJP9tqeEgJ0edURoXtpPXRt/5igRxVG/WldDQZ+Dxwh+WhRBgcldS0t7K69SEBhTt
         2Yw2ao6nTYsgBfy+20P5lY/12UMV/Ium43rFSfu0Hxvl3M16RPWnOaRqas+U4/b6LU49
         WegZAKkM0eClQ1o9bsdIfx1duMObcZoT7CidN367uv2kMKq9KxGPcAt4NKY5JSPcM9t0
         j+mQ==
X-Gm-Message-State: AOJu0YxyvTDsbiYqKc5rmD+hSc0FgfkK/3E4yL8XhNg3xrIqkOI+7wIO
	Hu1961IG8jC8lxcrlY/C6VSZcC2lplSaHx6h6BPNauhGsNZv0EMuqxTZulgdfw==
X-Gm-Gg: ASbGncvtMYjpo8P+ckIlrA1ae3vdY9up7TXbfB19Ryd+Wnve+3+3MqbPPbHc+DXdp84
	vgOU71txfYIxjnpTbAR9sAsmccsGuD0lQZDeSND96NDfQRY+IRWQIUgTdwHEBQDHii0hP7ttJIo
	zrqOOlZGbk9/jFNT6i0ZxXx/NYi631DVOH5PwqeXZbHbmgg4vgk3PDtY0QzACWY+DHmCKN+Qckc
	Go2CR02ZAASc7qdsoFXkBeEkX5M+CvGpYB3XZITZkz/IlsY9aWRxl7kwY+DHfg+IJvHeCUwqt2+
	wQtUk05xx2aE0oc+BWM0LDGCVsBZ7gs08GuYSqHoICbC/dClKD6gtg/eNQrsAiM8+CUo1HC91hx
	4vvBEiIVvdQdcRwYprcXyYfCwAiOMB4EbAnttDe/00a3MqZy127nUWzz78OY=
X-Google-Smtp-Source: AGHT+IH0WMFWR0+TkFl6axPye8KNU2AZyRe34VTJGXXnaQIqJcKTClIrp1vECjcO0fRC14LFjakCGA==
X-Received: by 2002:a05:600c:34d0:b0:471:1717:409 with SMTP id 5b1f17b1804b1-471179071b4mr241455955e9.23.1761511153392;
        Sun, 26 Oct 2025 13:39:13 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm10461025f8f.24.2025.10.26.13.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 06/10] bpf: add plumbing for file-backed dynptr
Date: Sun, 26 Oct 2025 20:38:49 +0000
Message-ID: <20251026203853.135105-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  7 ++++++-
 kernel/bpf/helpers.c  | 12 ++++++++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++------
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 907c69295293..14f800773997 100644
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
index f60cfab95230..cd48ead852a0 100644
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


