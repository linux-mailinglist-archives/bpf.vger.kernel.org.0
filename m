Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1EAE9A8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfIJL4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 07:56:31 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46999 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731890AbfIJL42 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:28 -0400
Received: by mail-wr1-f41.google.com with SMTP id d17so6859398wrq.13
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLJjYP1MYZ5Grpv+ShfvxxQJ0LT2gSMMnI/wBw8xz3g=;
        b=QS51rrwYwcJoe4+24GwRHHVMqMeXsTE54fUIhjbc1X5Gq+NzXDwJcWkAXLRxS9ugwb
         5G9duwPv6NvZLbkHCIcwMVnQu+QBrhWm4wDKo8Yoi/h56zMNzs2cJlaBCap8e+1kN7OP
         XDz4S4i2wY8VH/8IVCJXFYsFFcDETEnqXoZtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLJjYP1MYZ5Grpv+ShfvxxQJ0LT2gSMMnI/wBw8xz3g=;
        b=DgyOXDBrkw4gvGwxuubv/lq6H1k+jw/iHgMDzDNCsn5yBSFZZImv4kX70KmkSR+gi4
         6h2ryp4y0st71F/91DCwA+wFpzmfpyv0r7cGizJOGlUIe9eVxIeC1rTP4/iTaeXbFt/y
         5fxZQbYWW49XfOyUgjJxDypF/Dj6e8K7NCDBdXDhgX9J7yU808huDVdWOZ7xARU/bF2C
         AOm6serFXzpdf18uJ4ohcy3TwldDRqi8FnYGb9DqBeHNIaV6C7USgS49WabCPKCRWJgl
         vlI56rHS2+2FaZF+GWTmNWxrrj7GmXRsiyUA5gPTIe2+kZsKzeGdJRxPyndFM5Hpejjr
         t3yg==
X-Gm-Message-State: APjAAAXhpAUMbV7oUBdNTX7uaoNJnkkzHW4KBZU0fnuTsGwHYqjnThle
        3Am4ebdW0JiWm6JY+kG9ja5P4A==
X-Google-Smtp-Source: APXvYqwOG047syseWRc2VMwNZUDgQPGtjwe5XxRakqNhR8trEgOBjooO3kdOK7zJI821xK6j9IV5bw==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr22298390wrs.125.1568116585087;
        Tue, 10 Sep 2019 04:56:25 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:24 -0700 (PDT)
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
Subject: [RFC v1 02/14] krsi: Introduce types for KRSI eBPF
Date:   Tue, 10 Sep 2019 13:55:15 +0200
Message-Id: <20190910115527.5235-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

KRSI intrdocues a new eBPF program type BPF_PROG_TYPE_KRSI with an
expected attach type of BPF_KRSI. An -EINVAL error is returned if an
attachment is requested.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_types.h |  3 +++
 include/uapi/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c      |  6 ++++++
 security/krsi/Makefile    |  2 +-
 security/krsi/ops.c       | 10 ++++++++++
 5 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 security/krsi/ops.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index eec5aeeeaf92..129594c09b5c 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -38,6 +38,9 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
 #ifdef CONFIG_INET
 BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport)
 #endif
+#ifdef CONFIG_SECURITY_KRSI
+BPF_PROG_TYPE(BPF_PROG_TYPE_KRSI, krsi)
+#endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a5aa7d3ac6a1..32ab38f1a2fe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -171,6 +171,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	BPF_PROG_TYPE_KRSI,
 };
 
 enum bpf_attach_type {
@@ -197,6 +198,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
+	BPF_KRSI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5d141f16f6fa..f38a539f7e67 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1915,6 +1915,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_LIRC_MODE2:
 		ptype = BPF_PROG_TYPE_LIRC_MODE2;
 		break;
+	case BPF_KRSI:
+		ptype = BPF_PROG_TYPE_KRSI;
+		break;
 	case BPF_FLOW_DISSECTOR:
 		ptype = BPF_PROG_TYPE_FLOW_DISSECTOR;
 		break;
@@ -1946,6 +1949,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		ret = lirc_prog_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_KRSI:
+		ret = -EINVAL;
+		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
 		break;
diff --git a/security/krsi/Makefile b/security/krsi/Makefile
index 73320e8d16f8..660cc1f422fd 100644
--- a/security/krsi/Makefile
+++ b/security/krsi/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SECURITY_KRSI) := krsi.o
+obj-$(CONFIG_SECURITY_KRSI) := krsi.o ops.o
diff --git a/security/krsi/ops.c b/security/krsi/ops.c
new file mode 100644
index 000000000000..f2de3bd9621e
--- /dev/null
+++ b/security/krsi/ops.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+
+const struct bpf_prog_ops krsi_prog_ops = {
+};
+
+const struct bpf_verifier_ops krsi_verifier_ops = {
+};
-- 
2.20.1

