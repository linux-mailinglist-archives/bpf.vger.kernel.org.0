Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE531C938
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 12:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhBPLAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 06:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBPLAB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 06:00:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69738C06178A
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g6so12343949wrs.11
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0s0jRVh4fmabtbnB7JD1SFlIfwz3xHcNE/fUPVDxS0=;
        b=d+RFUH4N4NGX1v46Twg+3dLpVZfcawJEhH0/Eos1zK274D3RGpUtWKLXGa0j3bXSst
         4077rnKGeNGMdy54jJ0pZ2CzwBvVIz/qP1unc2y6y8WBsaCHbVp1uRDF7tz4Kc/dP0Z8
         oetgRRBQq10qz34vP4nuXkpc7yi5ewwHmYxl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0s0jRVh4fmabtbnB7JD1SFlIfwz3xHcNE/fUPVDxS0=;
        b=InLpxcZYHPrtfyotoAa2G+pVBxcw9j6v9KdtDCQAQEj2damZqR0CL9OQsc9Q0ySVv5
         7PxeWCZNORCP1yTuzsfOuuS5iVBgRSbKFGm4SpzTcwE4deIzgCkqjipprtyZEKb5axCs
         k22x/X44WGCsQgbqWLX3KzPEWO2hRj7ir9+OIza1iVdJxUr6M9M1RPo3BS/0xY5l5zjf
         yMjtVPlAjvdiA5ErjSDd945HptFJRqQgLdrsTWcqNmaH8jsFz+Xk/altSkm+vHpWEzND
         LcII7PaiOM98PR805axCrrIc1QRpcPV9FsebmqldKjLRMoqBfXCi0i3uthZkb858EmVS
         PSpQ==
X-Gm-Message-State: AOAM5308I2xUyr+ywx4bqhC0fTr3jAEdrBnmgl/yBHXg/3Nr3j8uafXD
        6iEyoQG88KV7ENqdzoGeLHSbww==
X-Google-Smtp-Source: ABdhPJzrFbinBJ2DdaUSzv+7CVJgxLz+JkwyJ4jhKfBByX/xqSkex2y8BqOaTUIGwM96wDtQwT8jpA==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr22631619wrq.423.1613473098197;
        Tue, 16 Feb 2021 02:58:18 -0800 (PST)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l1sm2820238wmi.48.2021.02.16.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 02:58:17 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jakub@cloudflare.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 3/8] bpf: allow multiple programs in BPF_PROG_TEST_RUN
Date:   Tue, 16 Feb 2021 10:57:08 +0000
Message-Id: <20210216105713.45052-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210216105713.45052-1-lmb@cloudflare.com>
References: <20210216105713.45052-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sk_lookup hook allows installing multiple BPF programs
simultaneously and has defined semantics. We therefore need
to be able to test multiple programs with one PROG_TEST_RUN
call. Extend the UAPI to include a prog_fds array which
enables this case. Passing an array with a single fd falls
back to current behaviour. Program types that allow multiple
programs have to provide a new test_run_array callback.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf-netns.h      |  2 +
 include/linux/bpf.h            |  3 ++
 include/uapi/linux/bpf.h       |  6 ++-
 kernel/bpf/net_namespace.c     |  2 +-
 kernel/bpf/syscall.c           | 73 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  6 ++-
 6 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf-netns.h b/include/linux/bpf-netns.h
index 722f799c1a2e..f34800cd7017 100644
--- a/include/linux/bpf-netns.h
+++ b/include/linux/bpf-netns.h
@@ -5,6 +5,8 @@
 #include <linux/mutex.h>
 #include <uapi/linux/bpf.h>
 
+#define BPF_SK_LOOKUP_MAX_PROGS	64
+
 enum netns_bpf_attach_type {
 	NETNS_BPF_INVALID = -1,
 	NETNS_BPF_FLOW_DISSECTOR = 0,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 875f6bc4bf1d..67c21c8ba7cc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -26,6 +26,7 @@ struct bpf_verifier_env;
 struct bpf_verifier_log;
 struct perf_event;
 struct bpf_prog;
+struct bpf_prog_array;
 struct bpf_prog_aux;
 struct bpf_map;
 struct sock;
@@ -437,6 +438,8 @@ bpf_ctx_record_field_size(struct bpf_insn_access_aux *aux, u32 size)
 struct bpf_prog_ops {
 	int (*test_run)(struct bpf_prog *prog, const union bpf_attr *kattr,
 			union bpf_attr __user *uattr);
+	int (*test_run_array)(struct bpf_prog_array *progs, const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr);
 };
 
 struct bpf_verifier_ops {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4c24daa43bac..b37a0f39b95f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -589,7 +589,9 @@ union bpf_attr {
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
-		__u32		prog_fd;
+		__u32		prog_fd;	/* input: program to test. mutually exclusive with
+						 *   prog_fds.
+						 */
 		__u32		retval;
 		__u32		data_size_in;	/* input: len of data_in */
 		__u32		data_size_out;	/* input/output: len of data_out
@@ -609,6 +611,8 @@ union bpf_attr {
 		__aligned_u64	ctx_out;
 		__u32		flags;
 		__u32		cpu;
+		__aligned_u64	prog_fds;
+		__u32		prog_fds_cnt;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 542f275bf252..61e4769f0110 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -411,7 +411,7 @@ static int netns_bpf_max_progs(enum netns_bpf_attach_type type)
 	case NETNS_BPF_FLOW_DISSECTOR:
 		return 1;
 	case NETNS_BPF_SK_LOOKUP:
-		return 64;
+		return BPF_SK_LOOKUP_MAX_PROGS;
 	default:
 		return 0;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c859bc46d06c..f8c7b9d86b3f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3100,13 +3100,17 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	}
 }
 
-#define BPF_PROG_TEST_RUN_LAST_FIELD test.cpu
+#define BPF_PROG_TEST_RUN_LAST_FIELD test.prog_fds_cnt
 
 static int bpf_prog_test_run(const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
 {
+	enum bpf_prog_type prog_type = BPF_PROG_TYPE_UNSPEC;
+	u32 prog_fds[BPF_SK_LOOKUP_MAX_PROGS];
+	struct bpf_prog_array *progs = NULL;
 	struct bpf_prog *prog;
-	int ret = -ENOTSUPP;
+	u32 prog_cnt;
+	int i, ret;
 
 	if (CHECK_ATTR(BPF_PROG_TEST_RUN))
 		return -EINVAL;
@@ -3119,14 +3123,67 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	    (!attr->test.ctx_size_out && attr->test.ctx_out))
 		return -EINVAL;
 
-	prog = bpf_prog_get(attr->test.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if ((attr->test.prog_fds && !attr->test.prog_fds_cnt) ||
+	    (!attr->test.prog_fds && attr->test.prog_fds_cnt))
+		return -EINVAL;
 
-	if (prog->aux->ops->test_run)
-		ret = prog->aux->ops->test_run(prog, attr, uattr);
+	if (attr->test.prog_fds) {
+		u32 __user *uprog_fds = u64_to_user_ptr(attr->test.prog_fds);
 
-	bpf_prog_put(prog);
+		if (attr->test.prog_fds_cnt >= ARRAY_SIZE(prog_fds))
+			return -EINVAL;
+
+		if (attr->test.prog_fd)
+			return -EINVAL;
+
+		prog_cnt = attr->test.prog_fds_cnt;
+		if (copy_from_user(prog_fds, uprog_fds, prog_cnt * sizeof(prog_fds[0])))
+			return -EFAULT;
+	} else {
+		prog_cnt = 1;
+		prog_fds[0] = attr->test.prog_fd;
+	}
+
+	progs = bpf_prog_array_alloc(prog_cnt, GFP_KERNEL);
+	if (!progs)
+		return -ENOMEM;
+
+	for (i = 0; i < prog_cnt; i++) {
+		prog = bpf_prog_get(prog_fds[i]);
+		if (IS_ERR(prog)) {
+			ret = PTR_ERR(prog);
+			goto out;
+		}
+
+		progs->items[i].prog = prog;
+
+		if (prog_type && prog->type != prog_type) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		prog_type = prog->type;
+	}
+
+	prog = progs->items[0].prog;
+	if (prog->aux->ops->test_run_array) {
+		ret = prog->aux->ops->test_run_array(progs, attr, uattr);
+	} else if (prog->aux->ops->test_run) {
+		if (prog_cnt > 1) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		ret = prog->aux->ops->test_run(progs->items[0].prog, attr, uattr);
+	} else {
+		ret = -ENOTSUPP;
+	}
+
+out:
+	for (i = 0; i < prog_cnt; i++)
+		if (progs->items[i].prog)
+			bpf_prog_put(progs->items[i].prog);
+	bpf_prog_array_free(progs);
 	return ret;
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4c24daa43bac..b37a0f39b95f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -589,7 +589,9 @@ union bpf_attr {
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
-		__u32		prog_fd;
+		__u32		prog_fd;	/* input: program to test. mutually exclusive with
+						 *   prog_fds.
+						 */
 		__u32		retval;
 		__u32		data_size_in;	/* input: len of data_in */
 		__u32		data_size_out;	/* input/output: len of data_out
@@ -609,6 +611,8 @@ union bpf_attr {
 		__aligned_u64	ctx_out;
 		__u32		flags;
 		__u32		cpu;
+		__aligned_u64	prog_fds;
+		__u32		prog_fds_cnt;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
-- 
2.27.0

