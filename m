Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C598D195EAE
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0T3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:29:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42238 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgC0T3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so12821803wrx.9
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fi0wlo+PTlR63f+1WnfYaQN4JRPMx/qWTtudseh8Beg=;
        b=NlM0vxBeUU64PoXr1EWEKkuqWfLl1QZL+7Nqunf9O9OOSYVK2ViZhd7Zc3ATS9LRkZ
         dHGzw9f1nKFfYkpDWaPK9oFMsAjOZK/KQQkslRDo2VTcbSRUmJRzECd5CiTBMDPZd3GJ
         /qYAdUMHlH8cWuaIYGOUU/nQZehvUYNtCSZVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi0wlo+PTlR63f+1WnfYaQN4JRPMx/qWTtudseh8Beg=;
        b=aqlTHoSzMrUjmUw9rO6C4BSbwbWxuz+I+FMHwH/wfVextKB0wBw7IzlzSxO3MHEcDa
         52XQQU+BTtsWKnHyItb5tcTb7UD4xMGgp92cqq+lcsdYODEs1+AGJQrgAFXLdS9Jo1DK
         NskdMbxuP75JGvLgrQ9mpYX8wwpqoDhjZUD91dLXQbCZf4V1yythibR26TRSiX455508
         pDfN3uYFCBUqBQe06K7EfhLkj5nU2KaAbeAEkb5jJhsyBAhLHNZDHgeWMVZwJL7Gjqjs
         E7cOFzuix8Zf790ByxHLKDjQt+h0GFvJNsT4DuiLJwnVVCWSmNxzf8XT7z73dFBG+zRZ
         /poQ==
X-Gm-Message-State: ANhLgQ3J3TmUI143pNg3OEkntVQ2nzp3Cjk4t3yDN0z10T1nSAc9hk22
        D2+OIEdaFcILoCJ+A4xZOCJfUQ==
X-Google-Smtp-Source: ADFU+vuXRWIiqAJMSMd9KjKjuXwIt/+1fiisBjKy7luq52mLV0uQKsG9k5SlQwCEdMfhOzLO2EUjpA==
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr1050394wrt.398.1585337338621;
        Fri, 27 Mar 2020 12:28:58 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id h132sm9828537wmf.18.2020.03.27.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:28:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v8 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
Date:   Fri, 27 Mar 2020 20:28:47 +0100
Message-Id: <20200327192854.31150-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327192854.31150-1-kpsingh@chromium.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Introduce types and configs for bpf programs that can be attached to
LSM hooks. The programs can be enabled by the config option
CONFIG_BPF_LSM.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
---
 MAINTAINERS                    |  1 +
 include/linux/bpf.h            |  3 +++
 include/linux/bpf_types.h      |  4 ++++
 include/uapi/linux/bpf.h       |  2 ++
 init/Kconfig                   | 12 ++++++++++++
 kernel/bpf/Makefile            |  1 +
 kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c       | 12 ++++++------
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf_probes.c  |  1 +
 10 files changed, 49 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bpf_lsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dbee41045bc..3197fe9256b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3147,6 +3147,7 @@ R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
 R:	Andrii Nakryiko <andriin@fb.com>
+R:	KP Singh <kpsingh@chromium.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb981c204fa..af81ec7b783c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1513,6 +1513,9 @@ extern const struct bpf_func_proto bpf_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
 
+const struct bpf_func_proto *bpf_tracing_func_proto(
+	enum bpf_func_id func_id, const struct bpf_prog *prog);
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c81d4ece79a4..ba0c2d56f8a3 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -70,6 +70,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_STRUCT_OPS, bpf_struct_ops,
 	      void *, void *)
 BPF_PROG_TYPE(BPF_PROG_TYPE_EXT, bpf_extension,
 	      void *, void *)
+#ifdef CONFIG_BPF_LSM
+BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
+	       void *, void *)
+#endif /* CONFIG_BPF_LSM */
 #endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5d01c5c7e598..9f2673c58788 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -181,6 +181,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -211,6 +212,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
 	BPF_MODIFY_RETURN,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/init/Kconfig b/init/Kconfig
index 20a6ac33761c..deae572d1927 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1616,6 +1616,18 @@ config KALLSYMS_BASE_RELATIVE
 # end of the "standard kernel features (expert users)" menu
 
 # syscall, maps, verifier
+
+config BPF_LSM
+	bool "LSM Instrumentation with BPF"
+	depends on BPF_SYSCALL
+	depends on SECURITY
+	depends on BPF_JIT
+	help
+	  Enables instrumentation of the security hooks with eBPF programs for
+	  implementing dynamic MAC and Audit Policies.
+
+	  If you are unsure how to answer this question, answer N.
+
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 046ce5d98033..f2d7be596966 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -29,4 +29,5 @@ obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
+obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
new file mode 100644
index 000000000000..82875039ca90
--- /dev/null
+++ b/kernel/bpf/bpf_lsm.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+const struct bpf_prog_ops lsm_prog_ops = {
+};
+
+const struct bpf_verifier_ops lsm_verifier_ops = {
+	.get_func_proto = bpf_tracing_func_proto,
+	.is_valid_access = btf_ctx_access,
+};
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e619eedb5919..37ffceab608f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -779,8 +779,8 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
-static const struct bpf_func_proto *
-tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+const struct bpf_func_proto *
+bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
@@ -865,7 +865,7 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_override_return_proto;
 #endif
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -975,7 +975,7 @@ tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_tp;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -1082,7 +1082,7 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_read_branch_records:
 		return &bpf_read_branch_records_proto;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -1210,7 +1210,7 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_raw_tp;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5d01c5c7e598..9f2673c58788 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -181,6 +181,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -211,6 +212,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
 	BPF_MODIFY_RETURN,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index b782ebef6ac9..2c92059c0c90 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -108,6 +108,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_STRUCT_OPS:
 	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
 	default:
 		break;
 	}
-- 
2.20.1

