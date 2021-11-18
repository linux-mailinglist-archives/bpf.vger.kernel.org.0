Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F396C455A34
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbhKRL36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343765AbhKRL2y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1ZiYznp4j141H60TZcw3n4CkxufbqGykQvRZP9LMQI=;
        b=iHe0FfxKapfXoCfRWh2GYMMxguK+YFE0kPNEGVKIRg3Cql5bl0Q9hoX8wSZ0mageqAlE/m
        fbhl/Ye/u12s2x3cxFv852SCfMSZcMjWiIkshuYY7Y5tGn9/I2c+CLLSRlMZZPTrn0XLzB
        N6l1TL5PG3XRmeIapOkUDaBu1P6pZ3Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-243-0SlRzc3MPjKzHF7umZt6UQ-1; Thu, 18 Nov 2021 06:25:52 -0500
X-MC-Unique: 0SlRzc3MPjKzHF7umZt6UQ-1
Received: by mail-ed1-f71.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so5038060edq.3
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1ZiYznp4j141H60TZcw3n4CkxufbqGykQvRZP9LMQI=;
        b=NPpyTfLIUwejVujYKfXmdW7rE3RI5znXZBiwm0xRvQ0M8Y/enCqje68QwnChsMmp67
         vi/gThrBb+lDu8LJhGKPgnbwY/2QmS4dPbtYxKdsXG5sqR1zxJ11Jjm0sNq8dbpwTtOh
         QI2tb0h3Z4i7wMY2nTMbXr8H5baUzkyyCZV/x5TWg+Al1f+S/2bZo9ifS0RBRU3d5tcS
         78OHoIsP9qg2i3FiR0lDJ9ASXv20T44xa+9fb1Ab2SSfgKYp7FLib+C40+FOhupLf9De
         K/L/GlmbEFoTACI95xg+potGdSZ9a6+noRi0UBBBj7CY70p6WAfXGsaaS2Q3XnN3RLNK
         MaIg==
X-Gm-Message-State: AOAM53149Y8NbUY8IkyDHanfxGf8yqv42KqKSIvMiU+duBnUmi0qVdHq
        Che8+8YMa0f7c/oNdnz0Gju+jcVuCbBxRaAlw3Wsqe9BITYjqZZ2pbLGZujzWYqll6BYIOVMjub
        mgrBgYBUIYLOc
X-Received: by 2002:a50:d741:: with SMTP id i1mr10208649edj.37.1637234751219;
        Thu, 18 Nov 2021 03:25:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMf9bx5Vl/rhIkaqyvY0xlKMIIuiWx7PfjU1RfalJ4dgrnynbQis07rnz2NXs0vtexXPh4HQ==
X-Received: by 2002:a50:d741:: with SMTP id i1mr10208610edj.37.1637234751044;
        Thu, 18 Nov 2021 03:25:51 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id w3sm1422085edj.63.2021.11.18.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:25:50 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 09/29] bpf: Add support to load multi func tracing program
Date:   Thu, 18 Nov 2021 12:24:35 +0100
Message-Id: <20211118112455.475349-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to load tracing program with new BPF_F_MULTI_FUNC flag,
that allows the program to be loaded without specific function to be
attached to.

Such program will be allowed to be attached to multiple functions
in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/syscall.c           | 35 +++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c          |  3 ++-
 tools/include/uapi/linux/bpf.h |  7 +++++++
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c93c629b5725..35f484f323f3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -881,6 +881,7 @@ struct bpf_prog_aux {
 	bool func_proto_unreliable;
 	bool sleepable;
 	bool tail_call_reachable;
+	bool multi_func;
 	struct hlist_node tramp_hlist;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fc8b344eecba..ca05e35e0478 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1111,6 +1111,13 @@ enum bpf_link_type {
  */
 #define BPF_F_SLEEPABLE		(1U << 4)
 
+/* If BPF_F_MULTI_FUNC is used in BPF_PROG_LOAD command, the verifier does
+ * not expect BTF ID for the program, instead it assumes it's function
+ * with 6 u64 arguments. No trampoline is created for the program. Such
+ * program can be attached to multiple functions.
+ */
+#define BPF_F_MULTI_FUNC	(1U << 5)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0df8b2f3d982..648155f0a4b1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -31,6 +31,7 @@
 #include <linux/bpf-netns.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
+#include <linux/btf_ids.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -2040,7 +2041,8 @@ static int
 bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			   enum bpf_attach_type expected_attach_type,
 			   struct btf *attach_btf, u32 btf_id,
-			   struct bpf_prog *dst_prog)
+			   struct bpf_prog *dst_prog,
+			   bool multi_func)
 {
 	if (btf_id) {
 		if (btf_id > BTF_MAX_TYPE)
@@ -2060,6 +2062,14 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		}
 	}
 
+	if (multi_func) {
+		if (prog_type != BPF_PROG_TYPE_TRACING)
+			return -EINVAL;
+		if (!attach_btf || btf_id)
+			return -EINVAL;
+		return 0;
+	}
+
 	if (attach_btf && (!btf_id || dst_prog))
 		return -EINVAL;
 
@@ -2183,6 +2193,16 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+#define DEFINE_BPF_MULTI_FUNC(args...)			\
+	extern int bpf_multi_func(args);		\
+	int __init bpf_multi_func(args) { return 0; }
+
+DEFINE_BPF_MULTI_FUNC(unsigned long a1, unsigned long a2,
+		      unsigned long a3, unsigned long a4,
+		      unsigned long a5, unsigned long a6)
+
+BTF_ID_LIST_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
+
 /* last field in 'union bpf_attr' used by this command */
 #define	BPF_PROG_LOAD_LAST_FIELD fd_array
 
@@ -2193,6 +2213,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	struct btf *attach_btf = NULL;
 	int err;
 	char license[128];
+	bool multi_func;
 	bool is_gpl;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
@@ -2202,7 +2223,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 				 BPF_F_ANY_ALIGNMENT |
 				 BPF_F_TEST_STATE_FREQ |
 				 BPF_F_SLEEPABLE |
-				 BPF_F_TEST_RND_HI32))
+				 BPF_F_TEST_RND_HI32 |
+				 BPF_F_MULTI_FUNC))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
@@ -2233,6 +2255,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
 
+	multi_func = attr->prog_flags & BPF_F_MULTI_FUNC;
+
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
 	 */
@@ -2251,7 +2275,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 				return -ENOTSUPP;
 			}
 		}
-	} else if (attr->attach_btf_id) {
+	} else if (attr->attach_btf_id || multi_func) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(attach_btf))
@@ -2264,7 +2288,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
-				       dst_prog)) {
+				       dst_prog, multi_func)) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
@@ -2284,10 +2308,11 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->aux->attach_btf = attach_btf;
-	prog->aux->attach_btf_id = attr->attach_btf_id;
+	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->offload_requested = !!attr->prog_ifindex;
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
+	prog->aux->multi_func = multi_func;
 
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4249ef6ca7e..af6a39bbb0dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13983,7 +13983,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		if (!bpf_iter_prog_supported(prog))
 			return -EINVAL;
 		return 0;
-	}
+	} else if (prog->aux->multi_func)
+		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		ret = bpf_lsm_verify_prog(&env->log, prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fc8b344eecba..ca05e35e0478 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1111,6 +1111,13 @@ enum bpf_link_type {
  */
 #define BPF_F_SLEEPABLE		(1U << 4)
 
+/* If BPF_F_MULTI_FUNC is used in BPF_PROG_LOAD command, the verifier does
+ * not expect BTF ID for the program, instead it assumes it's function
+ * with 6 u64 arguments. No trampoline is created for the program. Such
+ * program can be attached to multiple functions.
+ */
+#define BPF_F_MULTI_FUNC	(1U << 5)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
-- 
2.31.1

