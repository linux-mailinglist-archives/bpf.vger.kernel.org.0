Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17D1B829D
	for <lists+bpf@lfdr.de>; Sat, 25 Apr 2020 01:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgDXX7p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 19:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXX7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 19:59:44 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2937C09B049
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 16:59:44 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i14so9141972pgk.5
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7IZQ5Esc4VsqQddtFMvKYbYhT3LOBRblBO35odUvyU8=;
        b=WGazjcU3zaatXcU6bEN0mo1cC3qycEd13ZR+fWqmN88sXIGK0E+9ypbFtObAByzLqo
         UkxLsrZsLVSciM299tXAuRM8jQenpnr//y5RgIT+Ft+Sr2faG1Gj6gAIBRQeGWYgvmqh
         ZSu9AJvVX1T9T/4RLpzK2NWGUttHxYlE8Vcc7ix74aMHnV67Fq6b/asHG0JUW8aMYFQY
         ZMhpuXsdvAjxHxPhnrx1w5VdwCnEmLN0B+o11mT5MUWpQqA7UgnJjP3U6j6KNemMnvdn
         UuofCKbXgu7WkIIGo46p9JPHtY4/ut6sFKVabyHArHhvFzeK9NI1hqHgAln/6GOESoGh
         85yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7IZQ5Esc4VsqQddtFMvKYbYhT3LOBRblBO35odUvyU8=;
        b=AGYBCwNEXN3moma3Ep7dnLH1LhEsKP8jIJsFgZBVHj9UwyGYkvGS5s8QIZTm9LlZ8o
         5tKvmQdJoQU2rKXDrrV7S0V+78DSeRGHU3WuetTtL4JDuseFJIaNJNhF7pw8FaGCOXc2
         wILd4NpLj0V5Lxh9w+Dp/8TFesi/nYAmZFsGD23doNhTXL4/hje5VnQuz6Md1bF3RQcW
         0DVz0fxY+s8f07Sl+on7ekJITYQ9sMWnWRq4B1AX2461jIX0MQ3ABYFu+/pMZ61wEgNs
         TLeGZ5iD/qB2a5V8dOG71IPUcx+Eyb5xTbHYtDJOTR5oqCIbAwGIyGXlXlYPcMEaTpQM
         +fsg==
X-Gm-Message-State: AGi0PubteN4q3CSBUO1CgMWA0SsbhYqNFsPSWzD4bhhDIFBR/OuMYuFm
        F5i3WSrBA+n8M59QSpt38IDDZE4=
X-Google-Smtp-Source: APiQypKrwokGMUyHUu0PDPOivQ+R+FqihGXlZfuORtv3eHFtWAG8IiVx4UcQmpVXgNtjLL5PMT0DEsk=
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr9563546pjq.73.1587772784051;
 Fri, 24 Apr 2020 16:59:44 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:59:41 -0700
Message-Id: <20200424235941.58382-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH bpf-next] bpf: fix missing bpf_base_func_proto in
 cgroup_base_func_proto for CGROUP_NET=n
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

linux-next build bot reported compile issue [1] with one of its
configs. It looks like when we have CONFIG_NET=n and
CONFIG_BPF{,_SYSCALL}=y, we are missing the bpf_base_func_proto
definition (from net/core/filter.c) in cgroup_base_func_proto.

I'm reshuffling the code a bit to make it work. The common helpers
are moved into kernel/bpf/helpers.c and the bpf_base_func_proto is
exported from there.
Also, bpf_get_raw_cpu_id goes into kernel/bpf/core.c akin to existing
bpf_user_rnd_u32.

[1] https://lore.kernel.org/linux-next/CAKH8qBsBvKHswiX1nx40LgO+BGeTmb1NX8tiTttt_0uu6T3dCA@mail.gmail.com/T/#mff8b0c083314c68c2e2ef0211cb11bc20dc13c72

Fixes: 76800cfc27c6 ("bpf: Enable more helpers for BPF_PROG_TYPE_CGROUP_{DEVICE,SYSCTL,SOCKOPT}")
Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h    |  8 +++++
 include/linux/filter.h |  2 --
 kernel/bpf/core.c      |  5 +++
 kernel/bpf/helpers.c   | 73 +++++++++++++++++++++++++++++++++++++++
 net/core/filter.c      | 78 +-----------------------------------------
 5 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 25da6ff2a880..5147e11e53ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1215,6 +1215,7 @@ int btf_check_type_match(struct bpf_verifier_env *env, struct bpf_prog *prog,
 
 struct bpf_prog *bpf_prog_by_id(u32 id);
 
+const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -1365,6 +1366,12 @@ static inline struct bpf_prog *bpf_prog_by_id(u32 id)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline const struct bpf_func_proto *
+bpf_base_func_proto(enum bpf_func_id func_id)
+{
+	return NULL;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
@@ -1531,6 +1538,7 @@ const struct bpf_func_proto *bpf_tracing_func_proto(
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9b5aa5c483cc..af37318bb1c5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -863,8 +863,6 @@ int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog);
 int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
 			      bpf_aux_classic_check_t trans, bool save_orig);
 void bpf_prog_destroy(struct bpf_prog *fp);
-const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id);
 
 int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_attach_bpf(u32 ufd, struct sock *sk);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 916f5132a984..0cc91805069a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2136,6 +2136,11 @@ BPF_CALL_0(bpf_user_rnd_u32)
 	return res;
 }
 
+BPF_CALL_0(bpf_get_raw_cpu_id)
+{
+	return raw_smp_processor_id();
+}
+
 /* Weak definitions of helper functions in case we don't have bpf syscall. */
 const struct bpf_func_proto bpf_map_lookup_elem_proto __weak;
 const struct bpf_func_proto bpf_map_update_elem_proto __weak;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bafc53ddd350..dbba4f41d508 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -562,3 +562,76 @@ const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto = {
 	.arg3_type      = ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type      = ARG_CONST_SIZE,
 };
+
+static const struct bpf_func_proto bpf_get_raw_smp_processor_id_proto = {
+	.func		= bpf_get_raw_cpu_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_5(bpf_event_output_data, void *, ctx, struct bpf_map *, map,
+	   u64, flags, void *, data, u64, size)
+{
+	if (unlikely(flags & ~(BPF_F_INDEX_MASK)))
+		return -EINVAL;
+
+	return bpf_event_output(map, flags, data, size, NULL, 0, NULL);
+}
+
+const struct bpf_func_proto bpf_event_output_data_proto =  {
+	.func		= bpf_event_output_data,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_CONST_MAP_PTR,
+	.arg3_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_PTR_TO_MEM,
+	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
+};
+
+const struct bpf_func_proto *
+bpf_base_func_proto(enum bpf_func_id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_map_lookup_elem:
+		return &bpf_map_lookup_elem_proto;
+	case BPF_FUNC_map_update_elem:
+		return &bpf_map_update_elem_proto;
+	case BPF_FUNC_map_delete_elem:
+		return &bpf_map_delete_elem_proto;
+	case BPF_FUNC_map_push_elem:
+		return &bpf_map_push_elem_proto;
+	case BPF_FUNC_map_pop_elem:
+		return &bpf_map_pop_elem_proto;
+	case BPF_FUNC_map_peek_elem:
+		return &bpf_map_peek_elem_proto;
+	case BPF_FUNC_get_prandom_u32:
+		return &bpf_get_prandom_u32_proto;
+	case BPF_FUNC_get_smp_processor_id:
+		return &bpf_get_raw_smp_processor_id_proto;
+	case BPF_FUNC_get_numa_node_id:
+		return &bpf_get_numa_node_id_proto;
+	case BPF_FUNC_tail_call:
+		return &bpf_tail_call_proto;
+	case BPF_FUNC_ktime_get_ns:
+		return &bpf_ktime_get_ns_proto;
+	default:
+		break;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return NULL;
+
+	switch (func_id) {
+	case BPF_FUNC_spin_lock:
+		return &bpf_spin_lock_proto;
+	case BPF_FUNC_spin_unlock:
+		return &bpf_spin_unlock_proto;
+	case BPF_FUNC_trace_printk:
+		return bpf_get_trace_printk_proto();
+	case BPF_FUNC_jiffies64:
+		return &bpf_jiffies64_proto;
+	default:
+		return NULL;
+	}
+}
diff --git a/net/core/filter.c b/net/core/filter.c
index a943df3ad8b0..a605626142b6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -256,17 +256,6 @@ BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
 					  offset);
 }
 
-BPF_CALL_0(bpf_get_raw_cpu_id)
-{
-	return raw_smp_processor_id();
-}
-
-static const struct bpf_func_proto bpf_get_raw_smp_processor_id_proto = {
-	.func		= bpf_get_raw_cpu_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
 static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 			      struct bpf_insn *insn_buf)
 {
@@ -4205,26 +4194,6 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
-BPF_CALL_5(bpf_event_output_data, void *, ctx, struct bpf_map *, map, u64, flags,
-	   void *, data, u64, size)
-{
-	if (unlikely(flags & ~(BPF_F_INDEX_MASK)))
-		return -EINVAL;
-
-	return bpf_event_output(map, flags, data, size, NULL, 0, NULL);
-}
-
-const struct bpf_func_proto bpf_event_output_data_proto =  {
-	.func		= bpf_event_output_data,
-	.gpl_only       = true,
-	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_CONST_MAP_PTR,
-	.arg3_type      = ARG_ANYTHING,
-	.arg4_type      = ARG_PTR_TO_MEM,
-	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
-};
-
 BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
@@ -5983,52 +5952,7 @@ bool bpf_helper_changes_pkt_data(void *func)
 	return false;
 }
 
-const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
-{
-	switch (func_id) {
-	case BPF_FUNC_map_lookup_elem:
-		return &bpf_map_lookup_elem_proto;
-	case BPF_FUNC_map_update_elem:
-		return &bpf_map_update_elem_proto;
-	case BPF_FUNC_map_delete_elem:
-		return &bpf_map_delete_elem_proto;
-	case BPF_FUNC_map_push_elem:
-		return &bpf_map_push_elem_proto;
-	case BPF_FUNC_map_pop_elem:
-		return &bpf_map_pop_elem_proto;
-	case BPF_FUNC_map_peek_elem:
-		return &bpf_map_peek_elem_proto;
-	case BPF_FUNC_get_prandom_u32:
-		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_get_smp_processor_id:
-		return &bpf_get_raw_smp_processor_id_proto;
-	case BPF_FUNC_get_numa_node_id:
-		return &bpf_get_numa_node_id_proto;
-	case BPF_FUNC_tail_call:
-		return &bpf_tail_call_proto;
-	case BPF_FUNC_ktime_get_ns:
-		return &bpf_ktime_get_ns_proto;
-	default:
-		break;
-	}
-
-	if (!capable(CAP_SYS_ADMIN))
-		return NULL;
-
-	switch (func_id) {
-	case BPF_FUNC_spin_lock:
-		return &bpf_spin_lock_proto;
-	case BPF_FUNC_spin_unlock:
-		return &bpf_spin_unlock_proto;
-	case BPF_FUNC_trace_printk:
-		return bpf_get_trace_printk_proto();
-	case BPF_FUNC_jiffies64:
-		return &bpf_jiffies64_proto;
-	default:
-		return NULL;
-	}
-}
+const struct bpf_func_proto bpf_event_output_data_proto __weak;
 
 static const struct bpf_func_proto *
 sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-- 
2.26.2.303.gf8c07b1a785-goog

