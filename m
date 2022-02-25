Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4904C522B
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiBYXod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiBYXo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C52194144
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d74a0ff060so46201947b3.6
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=93Dy3pXp1EtGBKvAGMRWdloXVx8eO4YCYmEbzoeaeYk=;
        b=pnXI1KrV9MNxcdc11kWQSQhoY7dWYBJtcK64UyHbc02BWWucUIXvShTv3FROxsL5BW
         8vhoSDADnCQlSzakUBv1jjkdIoXtTZJKwyKp4vIZumKf4lK8elweUo9MrpFKaMqNsP1C
         UljZGZKErOTVs8LZhCK/mR6FK+aAZobtlX80IqAAEBRl7Qe0B+CSCUHaDKs3wiaxWx5v
         Z62FCKndn+O4YNFQgUuOl24uOevsHtzutVCrKav7zJn6AGUf0ysKVgFesRF5a4fbE0rz
         WuajkK0JLUtcXqS6vpwYJ6i7eCHQ8hEC2mdov2uSU4z88wcDUhFlB9dzaJI8HK/2cM//
         Cefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=93Dy3pXp1EtGBKvAGMRWdloXVx8eO4YCYmEbzoeaeYk=;
        b=PJMla5bU4AEdG7NdvjAUOvoBGmSqr9Ga2vy6VEYBfZvG2VEvYu2VxPlA/tLuT0ZVD7
         HboO+ef7reOl1Dm6u/SMYJe2FB450RErhLMx/SLTQj3df27nmXTp1wK4n+Zi0EnThoGl
         XohUn8PaGhGHYrbHI27KBQjYMiNDswhY9paCelt/907lWr/d2RNB+B/ki6kyJDMV6lxB
         EKBMIc0BVq2NaMjkAlL7IhLM3hYfTMKjOHcGKdvS/728yjZaJMLkNa/5GPU7SmwV9yMO
         iANSgW2zui14YtsWp+AxxfID8kCgUtJka1lQNq0DhI9qGMwhcu8cVBHVrNoQj9tzY9Aa
         r3oA==
X-Gm-Message-State: AOAM5300FJNSGCPjqsAajhA6qJUquEzfr2BTpR+eKc89zV8Uu5MTYJUk
        c2XHf9ameFZOGkcxszZctEcxmsrXLMQ=
X-Google-Smtp-Source: ABdhPJwaleac35eNfnnuZ5ZlgBLZqZSBlHD/27YuV/VOvM8XhXeNJ4XcCUmMceiEyeGNtaHSURlTJU5++EE=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a81:f0c:0:b0:2d6:83ab:7605 with SMTP id
 12-20020a810f0c000000b002d683ab7605mr9979774ywp.150.1645832633202; Fri, 25
 Feb 2022 15:43:53 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:34 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new type of bpf tracepoints: sleepable tracepoints, which allows
the handler to make calls that may sleep. With sleepable tracepoints, a
set of syscall helpers (which may sleep) may also be called from
sleepable tracepoints.

In the following patches, we will whitelist some tracepoints to be
sleepable.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h             | 10 +++++++-
 include/linux/tracepoint-defs.h |  1 +
 include/trace/bpf_probe.h       | 22 ++++++++++++++----
 kernel/bpf/syscall.c            | 41 +++++++++++++++++++++++----------
 kernel/trace/bpf_trace.c        |  5 ++++
 5 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c36eeced3838..759ade7b24b3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1810,6 +1810,9 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
 
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
+const struct bpf_func_proto *
+tracing_prog_syscall_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
+
 void bpf_task_storage_free(struct task_struct *task);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
@@ -1822,7 +1825,6 @@ struct bpf_core_ctx {
 
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn);
-
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2011,6 +2013,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	return NULL;
 }
 
+static inline struct bpf_func_proto *
+tracing_prog_syscall_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
 static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index e7c2276be33e..c73c7ab3680e 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -51,6 +51,7 @@ struct bpf_raw_event_map {
 	void			*bpf_func;
 	u32			num_args;
 	u32			writable_size;
+	u32			sleepable;
 } __aligned(32);
 
 /*
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 7660a7846586..4edfc6df2f52 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -88,7 +88,7 @@ __bpf_trace_##call(void *__data, proto)					\
  * to make sure that if the tracepoint handling changes, the
  * bpf probe will fail to compile unless it too is updated.
  */
-#define __DEFINE_EVENT(template, call, proto, args, size)		\
+#define __DEFINE_EVENT(template, call, proto, args, size, sleep)	\
 static inline void bpf_test_probe_##call(void)				\
 {									\
 	check_trace_callback_type_##call(__bpf_trace_##template);	\
@@ -104,6 +104,7 @@ __section("__bpf_raw_tp_map") = {					\
 		.bpf_func	= __bpf_trace_##template,		\
 		.num_args	= COUNT_ARGS(args),			\
 		.writable_size	= size,					\
+		.sleepable	= sleep,				\
 	},								\
 };
 
@@ -123,11 +124,15 @@ static inline void bpf_test_buffer_##call(void)				\
 #undef DEFINE_EVENT_WRITABLE
 #define DEFINE_EVENT_WRITABLE(template, call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
-	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
+	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size, 0)
+
+#undef DEFINE_EVENT_SLEEPABLE
+#define DEFINE_EVENT_SLEEPABLE(template, call, proto, args)	\
+	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0, 1)
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
-	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
+	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0, 0)
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
@@ -136,19 +141,26 @@ static inline void bpf_test_buffer_##call(void)				\
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(call, proto, args)				\
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
-	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
+	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0, 0)
 
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
-	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
+	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size, 0)
+
+#undef DECLARE_TRACE_SLEEPABLE
+#define DECLARE_TRACE_SLEEPABLE(call, proto, args)			\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
+	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0, 1)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 #undef DECLARE_TRACE_WRITABLE
 #undef DEFINE_EVENT_WRITABLE
 #undef __CHECK_WRITABLE_BUF_SIZE
+#undef DECLARE_TRACE_SLEEPABLE
+#undef DEFINE_EVENT_SLEEPABLE
 #undef __DEFINE_EVENT
 #undef FIRST
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9e6d8d0c8af5..0a12f52fe8a9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4827,12 +4827,6 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
-const struct bpf_func_proto * __weak
-tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	return bpf_base_func_proto(func_id);
-}
-
 BPF_CALL_1(bpf_sys_close, u32, fd)
 {
 	/* When bpf program calls this helper there should not be
@@ -5045,24 +5039,47 @@ const struct bpf_func_proto bpf_unlink_proto = {
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
-static const struct bpf_func_proto *
-syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+/* Syscall helpers that are also allowed in sleepable tracing prog. */
+const struct bpf_func_proto *
+tracing_prog_syscall_func_proto(enum bpf_func_id func_id,
+				const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
 		return &bpf_sys_bpf_proto;
-	case BPF_FUNC_btf_find_by_name_kind:
-		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
 		return &bpf_sys_close_proto;
-	case BPF_FUNC_kallsyms_lookup_name:
-		return &bpf_kallsyms_lookup_name_proto;
 	case BPF_FUNC_mkdir:
 		return &bpf_mkdir_proto;
 	case BPF_FUNC_rmdir:
 		return &bpf_rmdir_proto;
 	case BPF_FUNC_unlink:
 		return &bpf_unlink_proto;
+	default:
+		return NULL;
+	}
+}
+
+const struct bpf_func_proto * __weak
+tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	const struct bpf_func_proto *fn;
+
+	fn = tracing_prog_syscall_func_proto(func_id, prog);
+	if (fn)
+		return fn;
+
+	return bpf_base_func_proto(func_id);
+}
+
+static const struct bpf_func_proto *
+syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_btf_find_by_name_kind:
+		return &bpf_btf_find_by_name_kind_proto;
+	case BPF_FUNC_kallsyms_lookup_name:
+		return &bpf_kallsyms_lookup_name_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a2024ba32a20..c816e0e0d4a0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1691,6 +1691,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		fn = raw_tp_prog_func_proto(func_id, prog);
 		if (!fn && prog->expected_attach_type == BPF_TRACE_ITER)
 			fn = bpf_iter_get_func_proto(func_id, prog);
+		if (!fn && prog->aux->sleepable)
+			fn = tracing_prog_syscall_func_proto(func_id, prog);
 		return fn;
 	}
 }
@@ -2053,6 +2055,9 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
+	if (prog->aux->sleepable && !btp->sleepable)
+		return -EPERM;
+
 	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
 						   prog);
 }
-- 
2.35.1.574.g5d30c73bfb-goog

