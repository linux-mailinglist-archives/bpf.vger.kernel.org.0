Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDE18FA2D
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCWQog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 12:44:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40503 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCWQoc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 12:44:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so17941540wrw.7
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NF/GtUL8fX0TNE30GKs59tWr3ikDUbPiSsDzQ55A96E=;
        b=mnYy+Nab6pL+E8ynECF/1xOWHihSkx6z8J187oGRe2l9/PvFhNKcG6JruVE/2blEdB
         +Fyb8H+OtBM3gRvmzZXXYluDD8m3lB4il4a7OHZOog2CkFKgGbmjYIWcgtasxK43Z5kb
         uC2O+frP43Z/Z8lDO9kj1CroQejCuBQCI9uP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF/GtUL8fX0TNE30GKs59tWr3ikDUbPiSsDzQ55A96E=;
        b=BP/RbU5LnJd8FzS5stGPo3+PxdPVYYa8V70T9WUJIcRMTGukoF519MswLMPcGRTgdm
         aBrCjHZPouZXFEzy+4QUGmvI4JWSQAozH8sNuIWTlEQ0h5RjZYgvDVc32yjh1mWyqtZJ
         FU/14jrW5K4XAfWUqIhMDgKzI8uGuMtHu0obFWUQLmIKcEMxvPjI/QCqd3zFLILmsxbM
         CwT6MXxUDxHxy+rP5T1LGOT28GdRAOmF28Hf5gUreV13qQ/gykRNMA1DP0X55StI8G++
         slO/Kz1ydwfBbXLxH6qNpTgJAh+2PFFPF4GNPbyimiE7ZD1nQWVs9qR14+9fej8/RnAs
         mvxQ==
X-Gm-Message-State: ANhLgQ0xRSa15ng7RBSwYRGbgmSD510b0HqPM1Invln8CvLC6avZi0NW
        iP/XmBaa+zg+huqACpVzSvcZZQ==
X-Google-Smtp-Source: ADFU+vvAWvoqPaE26h8zeaWeAXnHnoYIPnj6B/dJqDr/iUauHEYrpSIH4BWxBip37QaDajGyNNTMPQ==
X-Received: by 2002:a5d:468c:: with SMTP id u12mr16557877wrq.394.1584981869117;
        Mon, 23 Mar 2020 09:44:29 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id l8sm199874wmj.2.2020.03.23.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:44:28 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v5 1/7] bpf: Introduce BPF_PROG_TYPE_LSM
Date:   Mon, 23 Mar 2020 17:44:09 +0100
Message-Id: <20200323164415.12943-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323164415.12943-1-kpsingh@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
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
---
 MAINTAINERS                    |  1 +
 include/linux/bpf.h            |  3 +++
 include/linux/bpf_types.h      |  4 ++++
 include/uapi/linux/bpf.h       |  2 ++
 init/Kconfig                   | 10 ++++++++++
 kernel/bpf/Makefile            |  1 +
 kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c       | 12 ++++++------
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf_probes.c  |  1 +
 10 files changed, 47 insertions(+), 6 deletions(-)
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
index 20a6ac33761c..b2c9a833bc58 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1616,6 +1616,16 @@ config KALLSYMS_BASE_RELATIVE
 # end of the "standard kernel features (expert users)" menu
 
 # syscall, maps, verifier
+
+config BPF_LSM
+	bool "LSM Instrumentation with BPF"
+	depends on BPF_SYSCALL
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

