Return-Path: <bpf+bounces-71025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE680BDF97C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07861188676B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9C3375CE;
	Wed, 15 Oct 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEI557vN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B620335BC6
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544728; cv=none; b=TpzNGmPdFJUhzArdsmS5FT9+3fLGGys09VCC+dt/O1BZF290YLyh+fInr2El9f1BYKJVXt2RYjZXZLZWxZT7Jd2+DULsuI9pX1MqVedWuaToSohcp64qiS5CUyo8l1J0XbfbIrmMy5m2bf75PrQpOllo6fCPMp1Em56ejj1o3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544728; c=relaxed/simple;
	bh=yFmYAevXZKJYG8otIO5pENIK5MUWY1syF3MZPhMnN9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkgJpw0g7mZqtXJBn4/8e07xGz3FwzCoMeu49qXDSwr/eFkf+UU8kSEMlAJ4uKEN+mfcI6Qu49CayDSDBxMYObT6s+8bnZtZl257T6TNmbNzieckdLmQkHdtFJ3ABJxMtBOPk57M7SSpjN3+rzNwFRu9xYcTLgd7tejyI4N2Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEI557vN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e47cca387so66795345e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544725; x=1761149525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRNW9wPAeZi99ZlZRQt8uRStAT8h5XI4/QB8NB+sMuQ=;
        b=lEI557vNQM+cIAfCNIqjSAy8bcGKQ1u6eyDDrWY0JfQpGETGL+F4z+3CyStgkiLSWF
         hfS9jeW7pOa8yCIp9ci+NrBwGrW94SLNNOZJPiHsPosGvpFvcWN1loseVTMXEaUEERqD
         goS42/dDxeWD6qr0vOwNYAKV/VXqYDfxNRKiDwf/I8n+Jt/McRR1gZyyp0BNN3qE1E8z
         7NCY0cv3iHoQDdUcs5stmWnNno/tNRhozt5i1CnfuA9xqc47+bc4BJs8zmsqQwXuDiXo
         EhTbHnC2szy4Zp7exo7O3Nzf8XuT1ITDXNlbIMIF0lmgnPpRU4kv13Z4Kkk5hAxGN4YP
         o3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544725; x=1761149525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRNW9wPAeZi99ZlZRQt8uRStAT8h5XI4/QB8NB+sMuQ=;
        b=pDZ+oU7Qf+w4noQ1XtOJ/5D9/+XYMu/KwDl8GJLDWOirj6vPKN25+0/gHB+UX1rUHL
         E1S6nKoulAYziiOD+T5Wvqit9Unxod77gyQfUmB1W1Nlg1fBsMG5uzEOTsuTR+6GmSu+
         dgxylO8vw9pvq8oVOwLR4INm1YU5pQeydc5XkVkcWt/4oqGhtv5gZVpCSOdSUTPUT3Ja
         Su6SphMj14X8daXAcqpmxJ2Uanw7KN2RUyTAXBauB8wbNDDCzAqFQquRiDV0fVhAJN31
         jc7bmeFSko67ms66ZGf/ZF7qHAY4evD43hGiCZ+w2NygSsgEPLqzo6A0WHd8HlAlipZv
         WSGA==
X-Gm-Message-State: AOJu0YyrbopHjBcrDK5+S6XaejOixRYlAN78ighXj4WNwdBIwjjQdW8Q
	l0vNbJC8duwcZ5W4oVhLv85i3vaC/w/699BOO/EnP0U+m223+2sZYOOpXkfoJg==
X-Gm-Gg: ASbGncuWby14AF5tY5f73NuCJehIl69Vp9mq/nMzccbuzwHM6lyziHej7JQOrPyE85F
	5HDACvWN8j8UaH/ze3TzKAC33iNQvjvMK/1lPqNIU11S40fYwljNiAqszvvJFStiUJL75TK8kkT
	dBPxyhXhHoUDi7m8w4RAB8IzB9d4Pkjoup0+qrlT8lBXqLeqIw8Av37wxRkESyUlcPT1cwfOcsr
	SoKC3KPrGFKj7hLb1k1n+ARwx4fAkoZ4Jn74OnrE8EEM06Pgf8YyrZq8xGOS7O43xoza3MKHa+D
	KKNthFRUxFhjKi4TQKd5QFP19egkK8LUtDig6y3cBdXr1C5SqnlKOtEE+EZ3It/rxTB/9j7bnn0
	Fve+vAfs3EYoNU1/nZqgJT2Bq8j9VWr9QNsImVRlydnIM
X-Google-Smtp-Source: AGHT+IHSM4Uhl3+v00IFDLbbTIw7RJ4gfgAyVexPZcIYLr1NnIxGwX/HLYaTjiipUJQzHLIEPtOveQ==
X-Received: by 2002:a05:600c:3f1b:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46fa9a20793mr207857455e9.0.1760544724560;
        Wed, 15 Oct 2025 09:12:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c21805sm39682525e9.10.2025.10.15.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/11] bpf: add plumbing for file-backed dynptr
Date: Wed, 15 Oct 2025 17:11:51 +0100
Message-ID: <20251015161155.120148-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7daddb44c348..1d7d50d0c587 100644
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
index 01541b24d3ee..3841c1c51b06 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4253,6 +4253,16 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
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
@@ -4430,6 +4440,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_TRUSTED_ARGS)
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
index a33ab6175651..7bae81c631cf 100644
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
@@ -12288,6 +12292,8 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock,
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
+	KF_bpf_dynptr_from_file,
+	KF_bpf_dynptr_file_discard,
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
@@ -12360,6 +12366,8 @@ BTF_ID(func, bpf_res_spin_lock)
 BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_dynptr_from_file)
+BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
@@ -13323,6 +13331,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -14003,7 +14016,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
+		struct bpf_reg_state *reg = &regs[meta.release_regno];
+
+		if (meta.initialized_dynptr.ref_obj_id) {
+			err = unmark_stack_slots_dynptr(env, reg);
+			if (err)
+				return err;
+		} else {
+			err = release_reference(env, reg->ref_obj_id);
+		}
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
-- 
2.51.0


