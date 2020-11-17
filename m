Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F8D2B6DAA
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 19:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKQSqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 13:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKQSqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 13:46:00 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94534C0617A6
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 10:45:58 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id e18so23586867edy.6
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jBD6bj0JsSmbNVtR6hH8vSBzFtUGZO9+vcL7HJEL0c=;
        b=kl+WIWKT22jxj00XkgCeIgfXjdxE0CW1y1zt6wb6Q23RXLe+sRsesj4ZWB8NnsDuj0
         BaRV+K1LxhBlOuqlgQ68BzfFAG7UWcg9V+n3hqu32qhRDUhDn/hRU+IUDjnSPLhtK8WV
         c5C88SxiEoxOcfnvw4E3/2i08kRvU8M9iFbZWUFhVC3lTGh9pdW7ecBWnf8w6kzeK8OC
         NjYqLcPHYP1vKU5qtSgly7xpxuKIFqE01MV36x63LIPfxcYgnhqzd47TRWgp9rbj+m9u
         c1zddgyKWT21L2Iv8o4S6X9Omb2pKpzxMpDR9GzmBxPLwV+4PJjqxutbO4YPT3esldiT
         Rr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jBD6bj0JsSmbNVtR6hH8vSBzFtUGZO9+vcL7HJEL0c=;
        b=H/fwUK1by9xZ0WI8hcSK397idO2ijBeBmbzvJxGD9TOuRUXkwT9AMrdll+uh2Ewvvv
         ZSGh7JDYHl1jWNNaxyXWfJwORzQvEvXXyhLPHkbmlDykFkDlgTiQIp4wTtN18i6ZbBTm
         +yJWNlAF4CmRHn0PX2mlw02R/qbzM5ntxCWQmcpx++EBrO/osz/hCWemwkI9YgTU4f3I
         103mdEgkr8wxJOTOThz3XcUidve1Bjzf+pjM6GuWt4qgBonL9xNSHKSu5ZBaeSfi/59K
         01z90akQ0COdTqJDfJZWMeoiuiohyx1pvHdEMmf9pxlnmiuibEfhxgHE9NkGP7r3sFHY
         cM0g==
X-Gm-Message-State: AOAM5313Vs703WryT2P1hHAYO2ADxnP5z3BQnhUS5q82pjiMaG9palwn
        U5yAaMt2KdFC145pU3CcJ9Ggq46plye7f4ucPJA=
X-Google-Smtp-Source: ABdhPJysw3YwOx8zohtv/zTz82yA5Kab2zBfQ73umOq910ky24fKYyWRX9umMij/4bUeFV4F+j8KOQ==
X-Received: by 2002:a50:d615:: with SMTP id x21mr22438526edi.200.1605638757126;
        Tue, 17 Nov 2020 10:45:57 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:a9a1])
        by smtp.gmail.com with ESMTPSA id p1sm12164382edx.4.2020.11.17.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 10:45:56 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     kernel-team@fb.com, rdna@fb.com, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andrii@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, toke@redhat.com, netdev@vger.kernel.org,
        me@ubique.spb.ru
Subject: [PATCH bpf-next] bpf: Add bpf_ktime_get_coarse_ns helper
Date:   Tue, 17 Nov 2020 18:45:49 +0000
Message-Id: <20201117184549.257280-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper uses CLOCK_MONOTONIC_COARSE source of time that is less
accurate but more performant.

We have a BPF CGROUP_SKB firewall that supports event logging through
bpf_perf_event_output(). Each event has a timestamp and currently we use
bpf_ktime_get_ns() for it. Use of bpf_ktime_get_coarse_ns() saves ~15-20
ns in time required for event logging.

bpf_ktime_get_ns():
EgressLogByRemoteEndpoint                                  113.82ns    8.79M
bpf_ktime_get_coarse_ns():
EgressLogByRemoteEndpoint                                   95.40ns   10.48M

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/bpf/core.c              |  1 +
 kernel/bpf/helpers.c           | 13 +++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 6 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 581b2a2e78eb..e1bcb6d7345c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1842,6 +1842,7 @@ extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
+extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 162999b12790..b637b68b10a9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3787,6 +3787,14 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * u64 bpf_ktime_get_coarse_ns(void)
+ * 	Description
+ * 		Return a coarse-grained version of the time elapsed since system boot, in nanoseconds.
+ * 		Does not include time the system was suspended.
+ * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
+ * 	Return
+ * 		Current *ktime*.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3956,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(ktime_get_coarse_ns),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 55454d2278b1..ff55cbcfbab4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2211,6 +2211,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
 const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
+const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto __weak;
 
 const struct bpf_func_proto bpf_get_current_pid_tgid_proto __weak;
 const struct bpf_func_proto bpf_get_current_uid_gid_proto __weak;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 25520f5eeaf6..78e9bb968482 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -651,6 +651,17 @@ const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 };
 
+BPF_CALL_0(bpf_ktime_get_coarse_ns)
+{
+	return ktime_get_coarse_ns();
+}
+
+const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto = {
+	.func		= bpf_ktime_get_coarse_ns,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
@@ -695,6 +706,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_discard_proto;
 	case BPF_FUNC_ringbuf_query:
 		return &bpf_ringbuf_query_proto;
+	case BPF_FUNC_ktime_get_coarse_ns:
+		return &bpf_ktime_get_coarse_ns_proto;
 	default:
 		break;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 02986c7b90eb..c3b2222ab573 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1354,6 +1354,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_per_cpu_ptr_proto;
 	case BPF_FUNC_bpf_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
+	case BPF_FUNC_ktime_get_coarse_ns:
+		return &bpf_ktime_get_coarse_ns_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 162999b12790..b637b68b10a9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3787,6 +3787,14 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * u64 bpf_ktime_get_coarse_ns(void)
+ * 	Description
+ * 		Return a coarse-grained version of the time elapsed since system boot, in nanoseconds.
+ * 		Does not include time the system was suspended.
+ * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
+ * 	Return
+ * 		Current *ktime*.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3956,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(ktime_get_coarse_ns),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.24.1

