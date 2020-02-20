Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA5316656C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgBTRxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40880 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgBTRw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:52:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so3018125wmi.5
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0abA5E0OjgcrSzHbxE94d8IVvZFrSKJHA7cstMQj5qA=;
        b=P0HVXfLYteXQE5UhSl8LTP0NGCRqCPckfbBRYGOdV+RmW+QOLjeg6HFWkW4sll9KOC
         61YuhuiHt3T2kWLTaB2ZjPNqovlBBvo6TAOc8Xcj0ZU52RlutjB2ldpTEqCrgfcC20eJ
         7WooBGwQcyT7OsQ0lM9rE5C0DncgsRKxsJ98I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0abA5E0OjgcrSzHbxE94d8IVvZFrSKJHA7cstMQj5qA=;
        b=TO0tNednfmGuscQgow3DPf3lTu9ixq9OI28wwRM4TaA00v52kMBMmKDDDmGIqRXqCS
         mvoBwxXfzOk3HlTmnQ8s3YGJUIyWmKd6NMFYkFZr86e2fS5W9NHIOdoPD8EHFyKLJ4ip
         iJT5xK8zcMbKI+fx7YUkB95ENAb51j9Xpekyi6EAsEmBDgsgo4Ege2TeXhSIT48tWFFG
         9Z90DzTGCCLm2J4PqC6NzjSEiDpnrlUh6u0KdNp7M+pq75o9mN7ZF4+ljkaV58LnEAmk
         o4NMh3TXEP0wYPkSzaf0ILsl3i6yHb4RyYVi/hR6g7aus/iZIfixOa87lsGhNw5wdnLB
         4L/A==
X-Gm-Message-State: APjAAAW9+eyNi/xS0qoyDpVWRzsAYaCpoYSfRuqVHy4DYGG+UDc+B1Yv
        v2zOw11+RXoNSWTt1Ocp7uBEZw==
X-Google-Smtp-Source: APXvYqzF1RB3bMF8HHT53VW6yM9RwTMt/SeAq+H3oPgCjQ85zeXqE9yf4W2eoV0TQfF6xtJkN5fZJQ==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr5566673wmk.46.1582221175124;
        Thu, 20 Feb 2020 09:52:55 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:52:54 -0800 (PST)
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
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
Date:   Thu, 20 Feb 2020 18:52:43 +0100
Message-Id: <20200220175250.10795-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
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
 init/Kconfig                   | 11 +++++++++++
 kernel/bpf/Makefile            |  1 +
 kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c       | 12 ++++++------
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf_probes.c  |  1 +
 10 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bpf_lsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..0f603e8928d5 100644
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
index 49b1a70e12c8..c647cef3f4c1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1429,6 +1429,9 @@ extern const struct bpf_func_proto bpf_strtoul_proto;
 extern const struct bpf_func_proto bpf_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 
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
index f1d74a2bd234..2f1e24a8c4a4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -181,6 +181,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -210,6 +211,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/init/Kconfig b/init/Kconfig
index 452bc1835cd4..7d5db2982875 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1617,6 +1617,17 @@ config KALLSYMS_BASE_RELATIVE
 # end of the "standard kernel features (expert users)" menu
 
 # syscall, maps, verifier
+
+config BPF_LSM
+	bool "LSM Instrumentation with BPF"
+	depends on BPF_SYSCALL
+	help
+	  This enables instrumentation of the security hooks with eBPF programs.
+	  The programs are executed after all the statically defined LSM hooks
+	  allow the action.
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
index 000000000000..affb6941622e
--- /dev/null
+++ b/kernel/bpf/bpf_lsm.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
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
index 4ddd5ac46094..a69cb8a0042d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -781,8 +781,8 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
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
 
@@ -1041,7 +1041,7 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_perf_prog_read_value:
 		return &bpf_perf_prog_read_value_proto;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -1168,7 +1168,7 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_raw_tp;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1d74a2bd234..2f1e24a8c4a4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -181,6 +181,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -210,6 +211,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
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

