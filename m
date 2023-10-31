Return-Path: <bpf+bounces-13681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4F7DC664
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01FB0B20D4E
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116610FD;
	Tue, 31 Oct 2023 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOJzbdVm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312D101ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:48 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBAFE6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:09:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso4605415276.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732566; x=1699337366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuU+s8K5qY6DLjk1vpQNd0S4x+HIhdAsE9ULK1mQDi4=;
        b=gOJzbdVm9vT1X3GUFA1tBcmAxGpz1E+5iS+/wBq6GZhwisRXXUzyZNdHZcQN6a/lhN
         i8xCs9qXtOYRdVvf3LCESAOtW0dlryvAT3cD5oQPd1H38wNYYkqdp9G5Irp4OcTQtB3h
         RkC5gcE4lhYkWIcZ6lkquRJocn+/lBxB9eidzpLYL99pEL9IcpT3tyUv7KnojTyAb44q
         +UOb116u4A63iIuJ7ixK5TW+c/KAD7Pd2WhUgs4vzoB2o6HpTwfSMmOiMoSULkGFZmrB
         BR9+DvEDjsJUoKYSwZXkLsN8OroyiPnOU038mHGTxbBXj+CGhfev3FovqaXzML8mQqzv
         8GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732566; x=1699337366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuU+s8K5qY6DLjk1vpQNd0S4x+HIhdAsE9ULK1mQDi4=;
        b=LptzuLk4fMzKzdDrZ9Ba8mrRthCSVffQJIA6ICD2ImwnbZkNhBXUPnVnr7TdnPqRMG
         oxqwrLDwtLjbOgLmbjjSklXd7zTZWRVvLfuhYERd7SPKgAGxT/EeCmy2R/YS2UGaNbNQ
         mPPWIqz3bGQNZMRj5Ae9WSPr4DLKyRBpFW8gWxXXqoxsKOH0O/QLV7TYzDUWq5dFykRu
         XKEWdawskpWNAj2sUgUEG1w5Gv3R1WICpJre4iQSN5hcm9aMsYco5Hl4suFQOg4GGrSD
         fTz3AmPGxl5dS5ndroThRBE210xBn7hYCl01EaTIe98Q3sDDVXGuojsUwhhUewYsPy4F
         iXQg==
X-Gm-Message-State: AOJu0YyoDTi6rfgpH2mYg7iS2b6smKTRvBBi7YFshSX77SiyGKBMParh
	qeFBMt5cdewR6f9X34Mx2ut9roA5U1Tu8A==
X-Google-Smtp-Source: AGHT+IEu0SYEjJPy4HQULg/Z3NrURM7HhNBssMvdHj+lUKT+E9eSjvrIEyoi+5r+nupY4KYfBU/cWA==
X-Received: by 2002:a17:902:c951:b0:1cc:5cbf:50d2 with SMTP id i17-20020a170902c95100b001cc5cbf50d2mr3181913pla.59.1698732018241;
        Mon, 30 Oct 2023 23:00:18 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:17 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
Date: Tue, 31 Oct 2023 01:24:02 +0000
Message-Id: <20231031012407.51371-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031012407.51371-1-hengqi.chen@gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds minimal support for seccomp eBPF programs
which can be hooked into the existing seccomp framework.
This allows users to write seccomp filter in eBPF language
and enables seccomp filter reuse through bpf prog fd and
bpffs. Currently, no helper calls are allowed just like
its cBPF version.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/bpf_types.h     |  4 +++
 include/uapi/linux/bpf.h      |  1 +
 kernel/seccomp.c              | 54 +++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c        |  2 ++
 tools/lib/bpf/libbpf_probes.c |  1 +
 5 files changed, 62 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..7c0a9fc0b150 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -83,6 +83,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
 	      struct bpf_nf_ctx, struct bpf_nf_ctx)
 #endif
+#ifdef CONFIG_SECCOMP_FILTER
+BPF_PROG_TYPE(BPF_PROG_TYPE_SECCOMP, seccomp,
+	      struct seccomp_data, struct seccomp_data)
+#endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..f0fcfe0ccb2e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -995,6 +995,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..5a6ed8630566 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -15,6 +15,7 @@
  */
 #define pr_fmt(fmt) "seccomp: " fmt
 
+#include <linux/bpf.h>
 #include <linux/refcount.h>
 #include <linux/audit.h>
 #include <linux/compat.h>
@@ -2513,3 +2514,56 @@ int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_SECCOMP_CACHE_DEBUG */
+
+#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_BPF_SYSCALL)
+const struct bpf_prog_ops seccomp_prog_ops = {
+};
+
+static bool seccomp_is_valid_access(int off, int size, enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >= sizeof(struct seccomp_data))
+		return false;
+
+	if (off % size != 0)
+		return false;
+
+	if (type == BPF_WRITE)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct seccomp_data, nr):
+		if (size != sizeof_field(struct seccomp_data, nr))
+			return false;
+		return true;
+	case bpf_ctx_range(struct seccomp_data, arch):
+		if (size != sizeof_field(struct seccomp_data, arch))
+			return false;
+		return true;
+	case bpf_ctx_range(struct seccomp_data, instruction_pointer):
+		if (size != sizeof_field(struct seccomp_data, instruction_pointer))
+			return false;
+		return true;
+	case bpf_ctx_range(struct seccomp_data, args):
+		if (size != sizeof(__u64))
+			return false;
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static const struct bpf_func_proto *
+bpf_seccomp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
+const struct bpf_verifier_ops seccomp_verifier_ops = {
+	.is_valid_access = seccomp_is_valid_access,
+	.get_func_proto  = bpf_seccomp_func_proto,
+};
+#endif /* CONFIG_SECCOMP_FILTER && CONFIG_BPF_SYSCALL */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..455d733f7315 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -217,6 +217,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 	[BPF_PROG_TYPE_NETFILTER]		= "netfilter",
+	[BPF_PROG_TYPE_SECCOMP]			= "seccomp",
 };
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
@@ -8991,6 +8992,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("seccomp",		SECCOMP, 0, SEC_NONE),
 };
 
 int libbpf_register_prog_handler(const char *sec,
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..b3ef3c0747be 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -180,6 +180,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_SECCOMP:
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		opts.expected_attach_type = BPF_NETFILTER;
-- 
2.34.1


