Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D880146CBA
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWPZz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35706 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgAWPZO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so1553287pgk.2
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOgW7lcXGtnBKERztN8ZYLITTM6bIMZTuIfirqHWInE=;
        b=Sd/REqC2xMx3gXm3vWuonOosNbIknnr7sb8eU7WJ45Jkxi5hbmo3Rh9zHsOOlZ680F
         dX2+GfvsBxzesS7kOJJWI0kLHbMedyxut5gEPoZXqhRmXKzSDAPLK4mLWzPlAH3qi0Kw
         3fVx4g9e4N9XWruZLaoMzM+T5xinGEs2JOno8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOgW7lcXGtnBKERztN8ZYLITTM6bIMZTuIfirqHWInE=;
        b=j4loQvx1XVjhjaEI7rh1Gx3O2BzMqr5sOT3F2zif1HC7IoSFgAHYpImjTa/0A9ov+N
         twDvwkDyIzZ8uIxfUaPrByL4K1hAJiVTuPRSLdXPx5LdMiZLpZXkcaxdQQdC7+fZC7Yl
         sXZikFVaAYj5wToMpBT02Qxz5pruk9PkBnOeywW0TG2ycSUVFRLGHZIdgfgPzY4H3wsk
         oIsz0ruWkJ6u7yaJNbZqdYW1KrNWqqStYtrLFOGJT0jtaVQPGA4HIVLRhoYDwaqQaPkf
         jEsJggmIaHZbpu0VWgEG0yR846cR4aDek3WWHgtp9TecOiSZhC04yUYFJe8exUQWXXuC
         TyDw==
X-Gm-Message-State: APjAAAVqAxeprb3osB+f0CLprI8qn1MEgeO8bcC4lsJZjdu2nyoLodfR
        4aOd3Ao5egajhw7omRXSo02d3g==
X-Google-Smtp-Source: APXvYqygc+cRwf48735fBToutn7dQqalMu9GLbzzxo+aD4TUlffbFL4gbcJME4MCdblTk8HCTth2Lg==
X-Received: by 2002:a65:6794:: with SMTP id e20mr4475292pgr.152.1579793113577;
        Thu, 23 Jan 2020 07:25:13 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:12 -0800 (PST)
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
Subject: [PATCH bpf-next v3 03/10] bpf: lsm: Introduce types for eBPF based LSM
Date:   Thu, 23 Jan 2020 07:24:33 -0800
Message-Id: <20200123152440.28956-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
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
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
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
index c81d4ece79a4..c36790b202e3 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -70,6 +70,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_STRUCT_OPS, bpf_struct_ops,
 	      void *, void *)
 BPF_PROG_TYPE(BPF_PROG_TYPE_EXT, bpf_extension,
 	      void *, void *)
+#ifdef CONFIG_SECURITY_BPF
+BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
+	       void *, void *)
+#endif /* CONFIG_SECURITY_BPF */
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
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a91ad518c050..eab4a36ee889 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2396,6 +2396,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_LIRC_MODE2:
 		ptype = BPF_PROG_TYPE_LIRC_MODE2;
 		break;
+	case BPF_LSM_MAC:
+		ptype = BPF_PROG_TYPE_LSM;
+		break;
 	case BPF_FLOW_DISSECTOR:
 		ptype = BPF_PROG_TYPE_FLOW_DISSECTOR;
 		break;
@@ -2427,6 +2430,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		ret = lirc_prog_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_LSM:
+		ret = -EOPNOTSUPP;
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

