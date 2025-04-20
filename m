Return-Path: <bpf+bounces-56287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE35AA94787
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A86E16A6DD
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C771BF37;
	Sun, 20 Apr 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpOwkumT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3981E32A0
	for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146570; cv=none; b=spdY/Q5fkQNIvcsUe0bySOiSNMhrfyTrXQNTsz+VEDyRlGddySf1pIeqGiMg2w/DoHL8soi2TG/Cf6X4a0I7vobIeDkFTNj5yaS4a8bocZgaDZ9wRCJ0y2/QT0Y7epBodMKMF0WUJ03H0Jhjhw9Yh6BjE94LTKvn2AUkLWR/UvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146570; c=relaxed/simple;
	bh=d+o5PYxfBQseV4QcvQ0p293KgwfzP+u3uIboLYy5ppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5lcMNKNvSoBU31Ov0PdL28xeG1gB46bto6pmDdX0ritUtWRNSSyuy0QoME/PjJkGpRGDHvTKSllyn/hGAaJXUs6qcUcSOTfTMqF4aODdRbE8c+Up/+W1Ws/ZW9X4HwP0GnSHIk2wa6HEy1sdJ0mZPWt/0++2ifWIXx7wvsqZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpOwkumT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774193fdffso45564101cf.1
        for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146567; x=1745751367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RCt5Bpm8sCGuMPV1vexYhG2Sgi3wKCbATe8Qq3sT4I=;
        b=LpOwkumTskzd0iHNoR7HtVulMiMEADWZNpeTYTwLo6rskQBSoTma/PglvQNIaOsiFA
         k6HenNkkMiVsdG5umW28FqTz6ctLe7O4WQRwamurCTgLMvAf8Edxl++BeqyZXAk5S5Q/
         G4/YCFiOk4sNylaVj/XucYovCgU8g0ilIwGrEID4ee8ALphrU8lhm7NfKxee9SH0RJJt
         GOzDynswokf/9+EQUodshNe1cVkfo3PBpiyTzBY/leY5uDKgCJIedXA52XUppQhsOvka
         5aWmQmvthlWa52lO/x+ePR6YO9l2nezQcfWDix0lPjU6oTPVyBZJRCjFy8h7HJd1/z2h
         b03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146567; x=1745751367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RCt5Bpm8sCGuMPV1vexYhG2Sgi3wKCbATe8Qq3sT4I=;
        b=Iv/vjeAplYbwzYZWaBEyPWcOyoGkTvyfvXBDtvnNRV9gWhwyd1v7SJWmy8QqW6621k
         /guRhMO/PYTYL2CpqfUmrp/FwkXVnYnBlmEwol4GEu1QJvi/kEGMBCsV2z5TeqY2NW8Z
         5/gpsz4jMNNblVbp6ZXqEdL7TMsB0PowbuyC+1NeKz7GiBAYQh8Z5m72or2wX9DyzIse
         xeQCihR5A+NcdhfLjkbf7gAjDche/DGtL2wSqrVjCXjJanCU/eUDYz6ZLX6NvcIhElU5
         1dyoOi2gM2iQ6MLgCMeYu9m0fcaVGFB12QOI3+wd/m3r/3PIoEQxPbHjr/3Ig4GlhNbM
         drCA==
X-Gm-Message-State: AOJu0Yz3aGaW7hnW7GAcIBKoQ8HkeOey7zfFFKNRgfJd7nz+ANQ/h7xg
	z39Zxhu7ZHxDQjRbHe0Lf+5r5HR1V2mOoajCpoDPicW7MazS4YMepnF2t4x4
X-Gm-Gg: ASbGncuh9aFjwRgmcXGavkjHUvo4wxjLyyW+CEJFTBePJXs4CcVlZ1MbcU9FjZRtNvB
	X5ghqmnMPyOAzIzQdQ0bAg2DSo9GO0W8yhq84cPmAoZcJvMiYPoVUJjRq7jNSF8olmEKNkzKFyX
	s5Qx14tyii02ja9pUkfD+G//rig3mQ6yO89rXct+fcm0yemmv1lyRxOkViArIWQFFjqUhr1b/WL
	gnL8c26H1urzXML2nE3+DGrByXZp71g+ccmt40wyloaQ7h3ZyZSYPXgVSCzlN74z8AKBgl74dje
	qHppoCLwhQlZu6/AxfrcqxGFiOwJTQ1qSJK4oM/k0KrGZhsJ
X-Google-Smtp-Source: AGHT+IHL+wcX1r9d2OTNySr9cBRWl5XNiZRbslcfYKXI7uQvW1fsTe7uPGXRpK0uAebg34O9Otw4/w==
X-Received: by 2002:a05:622a:18aa:b0:476:add4:d2bf with SMTP id d75a77b69052e-47aec3b755dmr113012021cf.22.1745146567049;
        Sun, 20 Apr 2025 03:56:07 -0700 (PDT)
Received: from rajGilbertMachine.. ([2607:b400:30:a100:a5e9:b904:d3d9:b816])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4c608sm30851771cf.41.2025.04.20.03.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 03:56:06 -0700 (PDT)
From: Raj Sahu <rjsu26@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	Raj <rjsu26@gmail.com>
Subject: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF program for termination
Date: Sun, 20 Apr 2025 06:55:21 -0400
Message-ID: <20250420105524.2115690-4-rjsu26@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420105524.2115690-1-rjsu26@gmail.com>
References: <20250420105524.2115690-1-rjsu26@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raj <rjsu26@gmail.com>

Introduces patch_generator which generates patch for each BPF
program, iterate through all helper calls and stub them with
a lightweight dummy function.

Also introduces a new patched version of bpf_loop namely
bpf_loop_termination for early exit from the loop.
For bpf_loop inlining case, we modify the return value of
the callback function to terminate early.

Signed-off-by: Raj <rjsu26@gmail.com>
Signed-off-by: Siddharth <sidchintamaneni@gmail.com>
---
 include/linux/bpf.h      |   4 +
 include/uapi/linux/bpf.h |   8 ++
 kernel/bpf/bpf_iter.c    |  65 ++++++++++++
 kernel/bpf/core.c        |   3 +
 kernel/bpf/helpers.c     |   8 ++
 kernel/bpf/syscall.c     | 216 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c    |  16 ++-
 7 files changed, 318 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5141f189b79b..5a174b536190 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3400,12 +3400,16 @@ extern const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
+extern const struct bpf_func_proto bpf_loop_termination_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
 extern const struct bpf_func_proto bpf_set_retval_proto;
 extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_dummy_void_proto;
+extern const struct bpf_func_proto bpf_dummy_int_proto;
+extern const struct bpf_func_proto bpf_dummy_ptr_to_map_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9b9061b9b8e1..d1d1795eefd4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6033,6 +6033,14 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(dummy_void, 212, ##ctx)			\
+	FN(dummy_int, 213, ##ctx)			\
+	FN(dummy_ptr_to_map, 214, ##ctx)		\
+	FN(loop_termination, 215, ##ctx)		\
+	/*
+	 * TODO: Remove these dummy helper interface because we
+	 * are not exposing them to userspace
+	 */
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 380e9a7cac75..e5dceebfb302 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -6,6 +6,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/rcupdate_trace.h>
+#include <asm/unwind.h>
 
 struct bpf_iter_target_info {
 	struct list_head list;
@@ -775,6 +776,70 @@ const struct bpf_func_proto bpf_loop_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_loop_termination, u32, nr_loops, void *, callback_fn,
+		void *, callback_ctx, u64, flags)
+{
+	/* Since a patched BPF program for termination will want
+	 * to finish as fast as possible,
+	 * we simply don't run any loop in here.
+	 */
+
+	/* Restoring the callee-saved registers and exit.
+	 * Hacky/ err prone way of restoring the registers.
+	 * We are figuring out a way to have arch independent
+	 * way to do this.
+	 */
+
+	asm volatile(
+	"pop %rbx\n\t"
+	"pop %rbp\n\t"
+	"pop %r12\n\t"
+	"pop %r13\n\t"
+	);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_loop_termination_proto = {
+       .func           = bpf_loop_termination,
+       .gpl_only       = false,
+       .ret_type       = RET_INTEGER,
+       .arg1_type      = ARG_ANYTHING,
+       .arg2_type      = ARG_PTR_TO_FUNC,
+       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
+       .arg4_type      = ARG_ANYTHING,
+};
+
+BPF_CALL_0(bpf_dummy_void) {
+	return 0;
+}
+
+const struct bpf_func_proto bpf_dummy_void_proto = {
+	.func           = bpf_dummy_void,
+	.gpl_only	= false,
+	.ret_type	= RET_VOID,
+};
+
+BPF_CALL_0(bpf_dummy_int) {
+	return -1;
+}
+
+const struct bpf_func_proto bpf_dummy_int_proto = {
+	.func		= bpf_dummy_int,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_0(bpf_dummy_ptr_to_map) {
+	return 0;
+}
+
+const struct bpf_func_proto bpf_dummy_ptr_to_map_proto = {
+	.func		= bpf_dummy_ptr_to_map,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+};
+
 struct bpf_iter_num_kern {
 	int cur; /* current value, inclusive */
 	int end; /* final value, exclusive */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 27dcf59f4445..acc490155b87 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3003,6 +3003,9 @@ const struct bpf_func_proto bpf_snprintf_btf_proto __weak;
 const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
 const struct bpf_func_proto bpf_set_retval_proto __weak;
 const struct bpf_func_proto bpf_get_retval_proto __weak;
+const struct bpf_func_proto bpf_dummy_void __weak;
+const struct bpf_func_proto bpf_dummy_int __weak;
+const struct bpf_func_proto bpf_dummy_ptr_to_map __weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..9106c63b9851 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1965,6 +1965,12 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_ns_current_pid_tgid:
 		return &bpf_get_ns_current_pid_tgid_proto;
+	case BPF_FUNC_dummy_void:
+		return &bpf_dummy_void_proto;
+	case BPF_FUNC_dummy_int:
+		return &bpf_dummy_int_proto;
+	case BPF_FUNC_dummy_ptr_to_map:
+		return &bpf_dummy_ptr_to_map_proto;
 	default:
 		break;
 	}
@@ -1997,6 +2003,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_loop:
 		return &bpf_loop_proto;
+	case BPF_FUNC_loop_termination:
+		return &bpf_loop_termination_proto;
 	case BPF_FUNC_user_ringbuf_drain:
 		return &bpf_user_ringbuf_drain_proto;
 	case BPF_FUNC_ringbuf_reserve_dynptr:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..fb54c5e948ff 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -36,6 +36,7 @@
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
 #include <linux/tracepoint.h>
+#include <asm/unwind.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -51,6 +52,17 @@
 
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
+static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
+#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
+	[_id] = & _name ## _verifier_ops,
+#define BPF_MAP_TYPE(_id, _ops)
+#define BPF_LINK_TYPE(_id, _name)
+#include <linux/bpf_types.h>
+#undef BPF_PROG_TYPE
+#undef BPF_MAP_TYPE
+#undef BPF_LINK_TYPE
+};
+
 DEFINE_PER_CPU(int, bpf_prog_active);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
@@ -2756,6 +2768,207 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
+static int clone_bpf_prog(struct bpf_prog *patch_prog, struct bpf_prog *prog)
+{
+	int err = 0;
+	patch_prog->expected_attach_type = prog->expected_attach_type;
+	patch_prog->len = prog->len;
+	patch_prog->gpl_compatible = prog->gpl_compatible;
+
+	memcpy(patch_prog->insnsi, prog->insnsi,  bpf_prog_insn_size(prog));
+
+	patch_prog->orig_prog = NULL;
+	patch_prog->jited = 0;
+	patch_prog->type = prog->type;
+
+	char *patch_prefix = "patch_";
+	strncpy(patch_prog->aux->name, patch_prefix, strlen(patch_prefix));
+	strncat(patch_prog->aux->name, prog->aux->name, sizeof(prog->aux->name));
+
+	return err;
+}
+
+static bool is_verifier_inlined_function(int func_id) {
+	switch (func_id) {
+		case BPF_FUNC_get_smp_processor_id:
+		case BPF_FUNC_jiffies64:
+		case BPF_FUNC_get_func_arg:
+		case BPF_FUNC_get_func_ret:
+		case BPF_FUNC_get_func_arg_cnt:
+		case BPF_FUNC_get_func_ip:
+		case BPF_FUNC_get_branch_snapshot:
+		case BPF_FUNC_kptr_xchg:
+		case BPF_FUNC_map_lookup_elem:
+			return true;
+		default:
+			return false;
+	}
+}
+
+static bool is_debug_function(int func_id) {
+	switch (func_id) {
+		case BPF_FUNC_trace_printk:
+			return true;
+		default:
+			return false;
+	}
+}
+
+static bool is_resource_release_function(int func_id) {
+	switch (func_id) {
+		case BPF_FUNC_spin_unlock:
+		case BPF_FUNC_ringbuf_submit:
+		case BPF_FUNC_ringbuf_discard:
+			return true;
+		default:
+			return false;
+	}
+}
+
+static bool find_in_skiplist(int func_id) {
+	return is_verifier_inlined_function(func_id) ||
+	       is_debug_function(func_id) ||
+	       is_resource_release_function(func_id);
+}
+
+static int get_replacement_helper(int func_id, enum bpf_return_type ret_type) {
+
+	switch (func_id) {
+		case BPF_FUNC_loop:
+			return BPF_FUNC_loop_termination;
+		case BPF_FUNC_for_each_map_elem:
+		case BPF_FUNC_user_ringbuf_drain:
+			return -ENOTSUPP;
+	}
+
+	switch (ret_type) {
+		case RET_VOID:
+			return BPF_FUNC_dummy_void;
+		case RET_INTEGER:
+			return BPF_FUNC_dummy_int;
+		case RET_PTR_TO_MAP_VALUE_OR_NULL:
+			return BPF_FUNC_dummy_ptr_to_map;
+		case RET_PTR_TO_SOCKET_OR_NULL:
+		case RET_PTR_TO_TCP_SOCK_OR_NULL:
+		case RET_PTR_TO_SOCK_COMMON_OR_NULL:
+		case RET_PTR_TO_RINGBUF_MEM_OR_NULL:
+		case RET_PTR_TO_DYNPTR_MEM_OR_NULL:
+		case RET_PTR_TO_BTF_ID_OR_NULL:
+		case RET_PTR_TO_BTF_ID_TRUSTED:
+		case RET_PTR_TO_MAP_VALUE:
+		case RET_PTR_TO_SOCKET:
+		case RET_PTR_TO_TCP_SOCK:
+		case RET_PTR_TO_SOCK_COMMON:
+		case RET_PTR_TO_MEM:
+		case RET_PTR_TO_MEM_OR_BTF_ID:
+		case RET_PTR_TO_BTF_ID:
+		default:
+			return -ENOTSUPP;
+	}
+}
+
+static void patch_generator(struct bpf_prog *prog)
+{
+	struct call_insn_aux{
+		int insn_idx;
+		int replacement_helper;
+	};
+
+	struct call_insn_aux *call_indices;
+	int num_calls=0;
+	call_indices = vmalloc(sizeof(call_indices) * prog->len);
+
+	/* Find all call insns */
+	for(int insn_idx =0 ;insn_idx < prog->len; insn_idx++)
+	{
+		struct bpf_insn *insn = &prog->insnsi[insn_idx] ;
+		u8 class = BPF_CLASS(insn->code);
+		if (class == BPF_JMP || class == BPF_JMP32) {
+			if (BPF_OP(insn->code) == BPF_CALL){
+				if (insn->src_reg == BPF_PSEUDO_CALL) {
+					continue;
+				}
+				if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL){ /*kfunc */
+					// TODO Need to use btf for getting proto
+					// If release function --> skip
+					// If acquire function --> find return type and add to list
+				}
+				else {
+					int func_id = insn->imm;
+					const struct bpf_func_proto *fn = NULL;
+					int new_helper_id = -1;
+
+					if (find_in_skiplist(func_id)) {
+						continue;
+					}
+
+					fn = bpf_verifier_ops[prog->type]->get_func_proto(func_id, prog);
+					if (!fn && !fn->func) {
+						continue;
+					}
+
+					new_helper_id = get_replacement_helper(func_id, fn->ret_type);
+					if (new_helper_id < 0) {
+						continue;
+					}
+
+					call_indices[num_calls].insn_idx = insn_idx;
+					call_indices[num_calls].replacement_helper= new_helper_id;
+					num_calls++;
+				}
+			}
+		}
+	}
+
+	/* Patch all call insns */
+	for(int k =0; k < num_calls; k++){
+		prog->insnsi[call_indices[k].insn_idx].imm = call_indices[k].replacement_helper;
+	}
+}
+
+static bool create_termination_prog(struct bpf_prog *prog,
+					union bpf_attr *attr,
+					bpfptr_t uattr,
+					u32 uattr_size)
+{
+	if (prog->len < 10)
+		return false;
+
+	int err;
+	struct bpf_prog *patch_prog;
+	patch_prog = bpf_prog_alloc_no_stats(bpf_prog_size(prog->len), 0);
+	if (!patch_prog) {
+		return false;
+	}
+
+	patch_prog->termination_states->is_termination_prog = true;
+
+	err = clone_bpf_prog(patch_prog, prog);
+	if (err)
+			goto free_termination_prog;
+
+	patch_generator(patch_prog);
+
+	err = bpf_check(&patch_prog, attr, uattr, uattr_size);
+	if (err) {
+		goto free_termination_prog;
+	}
+
+	patch_prog = bpf_prog_select_runtime(patch_prog, &err);
+	if (err) {
+		goto free_termination_prog;
+	}
+
+	prog->termination_states->patch_prog = patch_prog;
+	return true;
+
+free_termination_prog:
+	free_percpu(patch_prog->stats);
+	free_percpu(patch_prog->active);
+	kfree(patch_prog->aux);
+	return false;
+}
+
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
@@ -2765,6 +2978,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	bool bpf_cap;
 	int err;
 	char license[128];
+	bool have_termination_prog = false;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2967,6 +3181,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err)
 		goto free_prog_sec;
 
+	have_termination_prog = create_termination_prog( prog, attr, uattr, uattr_size);
+
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, uattr_size);
 	if (err < 0)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..57b4fd1f6a72 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -513,6 +513,7 @@ static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_for_each_map_elem ||
 	       func_id == BPF_FUNC_find_vma ||
 	       func_id == BPF_FUNC_loop ||
+	       func_id == BPF_FUNC_loop_termination ||
 	       func_id == BPF_FUNC_user_ringbuf_drain;
 }
 
@@ -11424,6 +11425,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
+	case BPF_FUNC_loop_termination:
 		update_loop_inline_state(env, meta.subprogno);
 		/* Verifier relies on R1 value to determine if bpf_loop() iteration
 		 * is finished, thus mark it precise.
@@ -22470,10 +22472,12 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_prog *new_prog;
+	struct termination_aux_states *termination_states;
 	u32 callback_start;
 	u32 call_insn_offset;
 	s32 callback_offset;
 	u32 cnt = 0;
+	termination_states = env->prog->termination_states;
 
 	/* This represents an inlined version of bpf_iter.c:bpf_loop,
 	 * be careful to modify this code in sync.
@@ -22502,7 +22506,14 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	 */
 	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
 	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
-	insn_buf[cnt++] = BPF_CALL_REL(0);
+
+	if (termination_states && termination_states->is_termination_prog) {
+		/* In a termination BPF prog, we want to exit - set R0 = 1 */
+		insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 1);
+	} else {
+		insn_buf[cnt++] = BPF_CALL_REL(0);
+	}
+
 	/* increment loop counter */
 	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
 	/* jump to loop header if callback returned 0 */
@@ -22535,7 +22546,8 @@ static bool is_bpf_loop_call(struct bpf_insn *insn)
 {
 	return insn->code == (BPF_JMP | BPF_CALL) &&
 		insn->src_reg == 0 &&
-		insn->imm == BPF_FUNC_loop;
+		(insn->imm == BPF_FUNC_loop
+		 || insn->imm == BPF_FUNC_loop_termination);
 }
 
 /* For all sub-programs in the program (including main) check
-- 
2.43.0


