Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4313CA8F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAORN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:13:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgAORN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so16457732wro.9
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qpppvmxUsdoHOAo4Mt0fdfqe/zAKnsM8OMMV6DxgYo=;
        b=JkYY+k1nQptDXMc1K3ZJXsjo5EisX3f4Se8aov6LIW3URg1EZSqPii8H35t2Ba5kRp
         q3AbE+l2t7G2L+AHhLEma/CQnkJ4UcMWFTaMW8KbfeO+1yHA8NdorBrBU9Ye2uEtrOV/
         VoaPDoyccqGCcJnIbKLR0oGRhJARcqBUxSlq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qpppvmxUsdoHOAo4Mt0fdfqe/zAKnsM8OMMV6DxgYo=;
        b=W++4Cha5pcV72AsNrsHuRdUASGNEsvZRUIirnkr6cfIA6rd1g/8jA1UJJeAAbBgy7L
         TbWUuVI5YxzwdCseaBv9jpp42LycA/3TJlUsf63B9ftQCAzbOuqJpeIGNvlPpSuk89+1
         vGuSjjt2K33z5S3+IG1AHcSZJTEx0x2NDw4gsefjRF/6zbtsSvd1IoDJStglVKVEYvG/
         0c+HtwkkjiVtbAGulxWomjiCBJVZqU4XM6PROAAMmHmTEWVb/JeXuElJ6v7/3Xc5MPl9
         U5+YSaTnvaphsfziz8ugqRtg/sH7dAZrndRFCPWJTwaLeEP7aEEhke15To5eV9g/zM6+
         S6Lg==
X-Gm-Message-State: APjAAAV+zpwaN4OHHe77YseVp9xTefJUAYHfSxFlNpmMKm6C2ob0nbEb
        P+gPMPj78Hi+ALWOX3ah+I9TeA==
X-Google-Smtp-Source: APXvYqz/VjlQXnNTb8DZIKjOpRbcHFB5LHITo4nFweinfMbDgY2p9mOZN9D7fnWO11/ygS2/nbpcYA==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr33246082wrt.256.1579108404001;
        Wed, 15 Jan 2020 09:13:24 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:23 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v2 03/10] bpf: lsm: Introduce types for eBPF based LSM
Date:   Wed, 15 Jan 2020 18:13:26 +0100
Message-Id: <20200115171333.28811-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

A new eBPF program type BPF_PROG_TYPE_LSM with an
expected attach type of BPF_LSM_MAC. Attachment to LSM hooks is not
implemented in this patch.

On defining the types for the program, the macros expect that
<prog_name>_prog_ops and <prog_name>_verifier_ops exist. This is
implicitly required by the macro:

  BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm, ...)

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_types.h      |  4 ++++
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           |  6 ++++++
 security/bpf/Makefile          |  2 +-
 security/bpf/ops.c             | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf_probes.c  |  1 +
 7 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 security/bpf/ops.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9f326e6ef885..2f5b054500d7 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -68,6 +68,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport,
 #if defined(CONFIG_BPF_JIT)
 BPF_PROG_TYPE(BPF_PROG_TYPE_STRUCT_OPS, bpf_struct_ops,
 	      void *, void *)
+#ifdef CONFIG_SECURITY_BPF
+BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
+	       void *, void *)
+#endif /* CONFIG_SECURITY_BPF */
 #endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 52966e758fe5..b6a725a8a21d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -176,6 +176,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -205,6 +206,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f9db72a96ec0..2945739618c9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2151,6 +2151,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_LIRC_MODE2:
 		ptype = BPF_PROG_TYPE_LIRC_MODE2;
 		break;
+	case BPF_LSM_MAC:
+		ptype = BPF_PROG_TYPE_LSM;
+		break;
 	case BPF_FLOW_DISSECTOR:
 		ptype = BPF_PROG_TYPE_FLOW_DISSECTOR;
 		break;
@@ -2182,6 +2185,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		ret = lirc_prog_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_LSM:
+		ret = -EINVAL;
+		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
 		break;
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index 26a0ab6f99b7..c78a8a056e7e 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright 2019 Google LLC.
 
-obj-$(CONFIG_SECURITY_BPF) := lsm.o
+obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
diff --git a/security/bpf/ops.c b/security/bpf/ops.c
new file mode 100644
index 000000000000..81c2bd9c0495
--- /dev/null
+++ b/security/bpf/ops.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+
+const struct bpf_prog_ops lsm_prog_ops = {
+};
+
+static const struct bpf_func_proto *get_bpf_func_proto(
+	enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_map_lookup_elem:
+		return &bpf_map_lookup_elem_proto;
+	case BPF_FUNC_get_current_pid_tgid:
+		return &bpf_get_current_pid_tgid_proto;
+	default:
+		return NULL;
+	}
+}
+
+const struct bpf_verifier_ops lsm_verifier_ops = {
+	.get_func_proto = get_bpf_func_proto,
+};
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 52966e758fe5..b6a725a8a21d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -176,6 +176,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -205,6 +206,7 @@ enum bpf_attach_type {
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 8cc992bc532a..2314889369cc 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -107,6 +107,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_STRUCT_OPS:
+	case BPF_PROG_TYPE_LSM:
 	default:
 		break;
 	}
-- 
2.20.1

