Return-Path: <bpf+bounces-70310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B49BB770F
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37FDE4ED300
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD729E0E1;
	Fri,  3 Oct 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzqfK86p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AF2BD5A1
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507483; cv=none; b=aCdQRtl/Ubhq4WLbOQUNCxU9wixcIHhwGsJMIN6D3U2bukkcLio1J/EXL7pMivVZWcteWW/LjNzWWohDLcDGsIoQrhyVAHMdUgNN2tJjVA4b5EkP6f9IYejjftLd8gPnrFNHoOgdJXUNy6erQ4bXj1TVSpOs+q03rTBZEukK/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507483; c=relaxed/simple;
	bh=27vJA/gRmEbnimy2yDhQ7ceWvNhHrcl06YBg+L1JPX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3ffDYpEIeTYx9i7FunI4jFYJXWrPQ6o9e/s2ZgAXO1y14m++5YcVLJ8ak6I9CEyDDHLq6ayn6ELzHxsGJsFgsa9bUwdI/aUbxNMw3+AtAJJe3rEw6qCjGcdUNbczBosnJF8Bc7C260HKqUmEh1wUGDpA0ci/y1LdTwvr2lVfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzqfK86p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f755aso19512635e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507480; x=1760112280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYrwdmwATzIUzhGRfe5NuZ8Gqz0to2VxMQFy0Vnahjg=;
        b=IzqfK86pyyDTSia/2ODK6/QXV1N2SScWYo2JXWekrDr6HGqGCDIeYEDm+cpYeA3bmS
         fkXkh5vUFKDLZza0OBtk6z3oGcNb+MQ6+pofaGZ7LX5lWJqdELOnO5ZqJ3jRFF77CpKh
         7MM5iHEBvPd/Qhxtd4N1Olp/vcvDF8YjKtWrKccLOtEPR1788Iy2nrecYntNesiAjIrX
         6ZWnGoMP/JMYeeRUERmhM6qnSmHNBZGrrstN0pBPnFzhAkr3I9qNaRzvWHoRY9AYo6+p
         onVYFr8efZiGzRnQ16ckmGNrKAY6bldLpcYJCDjMPGFREllz1HaH8Q37makoZfZgP1is
         1iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507480; x=1760112280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYrwdmwATzIUzhGRfe5NuZ8Gqz0to2VxMQFy0Vnahjg=;
        b=Tdg1dMxMa9juh0mygalKxNyaJBpyGCDJ22QGtrYHervNvxa78M3mxPTTnspI4X64qc
         RC3aVKQt9SIS5tLWF/v1ukxrysTN/fuUeEC8SsmezaN5AgWhv/CEsSehkRMF/mws3VFh
         g8xoyFA8x/rWYoHlvYZWbgAu+dVKsnh6vy5FZIYYCV9Lvu1fpAVrB4wvSCB3mQHK69I0
         6+glDE8TrXX4uGqM78XIH3cYJuIkXbuDV11tLuadLySE5ZkIOvbxyvrM9LN1hl+nfSxj
         5XQdVm7wlvfv0EWp8A7J0ao9qfb9Sr3x98p3I0knyIamNJTZL8VASZrm1W6kQxr6WeEG
         Kyug==
X-Gm-Message-State: AOJu0YyHxAPD0nM5TYA5qnerc/84zfY6Tnh2+Gi5RrsJuZ6Dlol5sU5w
	jc5eS0eCd3dseA7tfgsB3rvIQzgnI0bPuXU2fED1MVJ36FGlO6tA2S6dC/+WAA==
X-Gm-Gg: ASbGncuETwM8B9kjz/vefhKZRJxkzxNNgAC/sSHRx/9emQL9fucz8ULj9zIUPCpCGpe
	9gsFnWG+J1+wdQ3Dfdos3Sm+xyQUvlpKV4lN95isOyAOfNvhu7nhNfZjFBu3unWrDBz0I2wBnt5
	rEmSXp7vo79EvtBHE6hv16LCveGrvL/RaNSSFhe3UFatkZ27+11E7g+R7LWXYWRrUs10fWEVjUd
	ShVKuwnDGLO86ftmQW5qzmSG/hSPqOP+khiTpgEtLbZIqCHAI/+aKA6KFz+geTf96OxSSpHVxUa
	6+VWm0NtNXxEXANni2Zea6fA8nQhnuNSAvZna911D0r2wjCDVB3HkBD57LK/n4X6IpIQp8jj1uV
	QthB4SVqIEUHcsE9wR2f6ITXsww==
X-Google-Smtp-Source: AGHT+IEd86cC9C5f0C99fal6mzAD82TiFWfOQKmbBCScEl0F1RAcf/jcvo/GH7Y6CyhreJmSnS6e8w==
X-Received: by 2002:a5d:5d85:0:b0:3f9:6657:d05 with SMTP id ffacd0b85a97d-4256713ee04mr2184260f8f.12.1759507479886;
        Fri, 03 Oct 2025 09:04:39 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm8562119f8f.49.2025.10.03.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:39 -0700 (PDT)
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
Subject: [RFC PATCH v1 06/10] bpf: add plumbing for file-backed dynptr
Date: Fri,  3 Oct 2025 17:04:12 +0100
Message-ID: <20251003160416.585080-7-mykyta.yatsenko5@gmail.com>
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

Add the necessary verifier plumbing for the new file-backed dynptr type.
Introduce two kfuncs for its lifecycle management:
 * bpf_dynptr_from_file() for initialization
 * bpf_dynptr_file_discard() for destruction

Currently there is no mechanism for kfunc to release dynptr, this patch
add one:
 * Introduce is_dynptr_release_arg() to tell if given dynptr argument
 should be released
 * Set meta->release_regno and regs[regno].ref_obj_id to make release
 happen

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h   |  7 ++++++-
 kernel/bpf/helpers.c  | 12 ++++++++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 22 ++++++++++++++++++++--
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9ab38eaa6af9..bd70117b8e84 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -785,12 +785,15 @@ enum bpf_type_flag {
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
@@ -1378,6 +1381,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_XDP,
 	/* Points to skb_metadata_end()-skb_metadata_len() */
 	BPF_DYNPTR_TYPE_SKB_META,
+	/* Underlying data is a file */
+	BPF_DYNPTR_TYPE_FILE,
 };
 
 int bpf_dynptr_check_size(u64 size);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 44f4a561f845..6f6aba03dda8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4199,6 +4199,16 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
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
@@ -4374,6 +4384,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_file)
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
index 0b4ea18584bb..e4441155a4bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -676,6 +676,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_XDP;
 	case DYNPTR_TYPE_SKB_META:
 		return BPF_DYNPTR_TYPE_SKB_META;
+	case DYNPTR_TYPE_FILE:
+		return BPF_DYNPTR_TYPE_FILE;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -694,6 +696,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_XDP;
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return DYNPTR_TYPE_SKB_META;
+	case BPF_DYNPTR_TYPE_FILE:
+		return DYNPTR_TYPE_FILE;
 	default:
 		return 0;
 	}
@@ -701,7 +705,7 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 
 static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
-	return type == BPF_DYNPTR_TYPE_RINGBUF;
+	return type == BPF_DYNPTR_TYPE_RINGBUF || type == BPF_DYNPTR_TYPE_FILE;
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
@@ -12258,6 +12262,8 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock,
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
+	KF_bpf_dynptr_from_file,
+	KF_bpf_dynptr_file_discard,
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
@@ -12330,6 +12336,8 @@ BTF_ID(func, bpf_res_spin_lock)
 BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_dynptr_from_file)
+BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
@@ -13293,6 +13301,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -13969,7 +13982,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
+		struct bpf_reg_state *reg = &regs[meta.release_regno];
+
+		if (meta.initialized_dynptr.ref_obj_id)
+			err = unmark_stack_slots_dynptr(env, reg);
+		else
+			err = release_reference(env, reg->ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
-- 
2.51.0


