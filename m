Return-Path: <bpf+bounces-71629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F5BBF881E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B06254FB087
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E727990A;
	Tue, 21 Oct 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gukmele2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F462773D3
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077032; cv=none; b=kIAtJSpKT5I2VAW9rea7N3fA6bIz60jjEOMPObsYJ1VuVkJZZnN4I+oRb2f01TUpgWVcsNjjAPRvy7hWS55/G4DpcOC2efdSah4D0CUJvPbVVzlWw7+NbAuJrrA6uZ+OHRt1HQaodyeBsqKRy+c0jjeL6n9L02+QNMM59Ai1Rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077032; c=relaxed/simple;
	bh=guvxz/4Y2ZVuT8R3iDMy3moUsjKbgvHQkcHsup2izvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9LZpfJdUWj/loC+9idxaoN4LbqVMAQh3kEXsMYFRVWPrNeM3O7uqjHqi3R6u/8hbYfEHJaKlk5xcPCMr4iC6P5bU9yy4HGS/cxaUo9ZaZ4UuMUVV7K9D83FIIQVTzaVnZLif4tEkKHnmL2iDSnxzyT3uE3APnwh2NhbFKksGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gukmele2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711b95226dso48988365e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077028; x=1761681828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22D3Rv+K2WFLf1nCvexNjdUGTn5p5xdmOVR7WliBJ+M=;
        b=Gukmele2tYucBNJK+tSxShwi9qpXzjFji17shK8geiae4pUNjO5ISQlnJhxcpDN/Gk
         Ud2Qs3UMACn+hSYEvgFZrAlM/0djXt3B0xH42GlrzTvFUQfEm0J1lJFUpVeMr1wjvraL
         P82vLfp84XvpuUVChaYANoLXJSvzq8as+gxwjZ6Kjg6o4bSLzBVGhLHb9ocCnCcj3Dhz
         pG0qEJVl4hPpmP4bzHlBHNPT358T28T8oxJdDt6jex9g3Lm3xSfokw9hD/1N2RTWNby/
         uSzFabKgIWLYBEApRrDtyjqJti5Qrd0tep8F3XP3XADMNBgmOhO06Ww7RoYr/jXQ3XjS
         IpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077028; x=1761681828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22D3Rv+K2WFLf1nCvexNjdUGTn5p5xdmOVR7WliBJ+M=;
        b=DVV4jZz4QkdWYaNcyvhUMn0U6foJUvzlpQyUwwkYMZHfspD7HIWh1iVgPCf0lWSq6k
         Ki9UJpXtvMS9YFZydIYq4+2Fr1Jn4U109s4KvjYTyJjB9i5Qq5A/8nXffxqm6uWCaSLk
         OnxDAvGMqRvQYkdEYAYT9C913qdArqkyl6MaapmYxW9LZwGD0s6E86XMny+6Rrd8HozI
         nixl04ojy4z9kIwmF4nTldW0YgZWfZHOz/1ChCYnt8aZqxyRM3iWUwQ22TvGj+tFb19E
         HaJJNefjQZhUOSrOmpDeJQ8C00nVlQA9cR7md7UQFp12ci8xdBmYr76li0oCpaixyjJ2
         XGvA==
X-Gm-Message-State: AOJu0YwGEts1oMP+qfh8VoRE4NBu+eaq01FO9PCwpJkfCn1SlOV2VfFy
	N65RWI8cr0Y3NsaZi9YMdXlmlKWXFz/O6h48AHjRP5ZeN7IUVL2uAscUtzNybg==
X-Gm-Gg: ASbGncs/cBgPLEec6g7/xBhWqR3FjQyXhyMiXnAvefD3EmjER3UcKD7yEU2FsMtukAM
	0A7ZQRvJ8PTl1qFKXQk/Iqtczcn/6JJF2Xu7eiF0UWme5gVh8qyYSA35OW4kxpzkbilXnuhT3wB
	DvkFDkY5CXDLR/M5Qc7cmgb8HDl8zzrQ/AQpsFTPYqEeiCdpk5vkX9lGiOBzH0P/4WKxdcqXVlc
	ayJG5t9g18vAtYUp9U0cfsJ8g2zXMyoN46NZj4tLwt4EKrFWwrEI62OLAIHiHsiOoUfgN2ilyXC
	tMpk+LhkxHcfiNJFj8kSDK6XXuathBGwj5HV9hB2WoC23aXpockdBYBCJ4cO6I5IcMOh6gB5LtX
	/KL0XHsrSnlvE45czPEoczXhjoOD2Nbq5n0C0sSENg0Cd7fnYT4jEgOtHeviGlRDpvPrvVRk=
X-Google-Smtp-Source: AGHT+IEdV7ZrgLjbv7XG44Pgv6jvoJxeYe6Bcyi3z3C9IDR4wepQYQwdn/CZV1nRTy/PG9vnqNDthA==
X-Received: by 2002:a05:6000:26d1:b0:425:7f10:d477 with SMTP id ffacd0b85a97d-42704d51136mr11002654f8f.2.1761077028479;
        Tue, 21 Oct 2025 13:03:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a75bsm22113354f8f.23.2025.10.21.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/10] bpf: add plumbing for file-backed dynptr
Date: Tue, 21 Oct 2025 21:03:30 +0100
Message-ID: <20251021200334.220542-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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


