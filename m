Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA1196A4F
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 01:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgC2AoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 20:44:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51801 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgC2AoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 20:44:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so15870349wme.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7blgUyFIIrVXU7X0EuWXVRLnZG5tDffRat1rkTfOq9s=;
        b=AjJRdfkQK8V4rv3MT1CVxj4JrgZcIhoGpKGyfWFmCWrjLPX/2nygmTAyrJentmQgwl
         wOVz5/ddR+u5hODxWWjJvvqNinCFomAtxS0qnh083h29aQVL2b6LJZD6hYslnqEcFODf
         AmWI/Vf8nLLSjwP5QAzxfjFhuADPBlOo+ZOQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7blgUyFIIrVXU7X0EuWXVRLnZG5tDffRat1rkTfOq9s=;
        b=WG0rfkg+0Zru27P6nUrfFF+zsT6nEqqfclbljPxB8Rm2i+8vyf9hCcGmdDvy29Mbhy
         KjvuOCRaFEBj0f17DYBmVRqtcrUBeGWCiXIHKDomu0PL56AbkluFlx1jcaslen150dHP
         bsdf6+JcC0Os1kKPPfHaKIIm9u03Si/vIxgehp75PxR5DMG7szGqUx7II1yjZFeMFDo+
         13k0kLj2kuwYOYFk1SEmj18XpCGl/aOA2oxG4XhFMF8d8z656S4MIrhFX4RqgHYloFkU
         gyrnPkkX+rwHLdS6PqcaJhYlMdsGvGOyeWjMd9aou21KkfW4CEGp3uJ9xHoADxNqY+3C
         GDuQ==
X-Gm-Message-State: ANhLgQ3N1o1PC/9tQRzc7MzIfnoP8olymUb06UGBq3HlNU2Zonn/9xam
        kV2774ubDWJrRsY68wWZ4q2htA==
X-Google-Smtp-Source: ADFU+vsL+qLjVbG8SMz9ihKx6LI3nR88tJEyib4a8xe5jE1xDVwCLBnUeZwN6Bnvnv/Sq15klHmMYA==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr5897964wmm.53.1585442641569;
        Sat, 28 Mar 2020 17:44:01 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e5sm14577647wru.92.2020.03.28.17.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:44:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
Date:   Sun, 29 Mar 2020 01:43:49 +0100
Message-Id: <20200329004356.27286-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
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
index 372708eeaecd..3bde59a8453b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1515,6 +1515,9 @@ extern const struct bpf_func_proto bpf_tcp_sock_proto;
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
index 222ba11966e3..f1fbc36f58d3 100644
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
index 222ba11966e3..f1fbc36f58d3 100644
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

