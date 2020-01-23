Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B497146CB8
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAWPZv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:51 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37382 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgAWPZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:17 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so1466451pjb.2
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVnvq+rdY3S8cnNkWIr/Sx9lQ7Cq9VlVRk5jzqLcR2I=;
        b=cZSeeL5RhX6TetUuhke9ho3TlNGzquX9MiXzXGHooL2yL+N/bQpV19bFyQ/8kFq7Py
         wXnmG+6uX1toic0eFfn8LGq9VAlodU+JqAKDRK6/l72iJpE6OmY1OTEfFvrSffbJYnpz
         lous7ANG5IKdLNPIah1UXxISk+yn9uIW8Dpn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVnvq+rdY3S8cnNkWIr/Sx9lQ7Cq9VlVRk5jzqLcR2I=;
        b=gp0bxZvfm0JI1jrBOcTvbH8V97xAzR+xve6UlTNm8AhrFlZSoqJKSIkrSthaXxfVvZ
         A9GN2CYoOToPgIlW+LCqkMVw3Jj4rUUNvuu0nUuvO+hSHWjXjvjVw+Aw0uq8AyTXqJ6I
         FdXlIeG8WKJkz63dZOc+QM6xvhqxZwWCu3kmSvDKEw7PL59DkGuRIWFizFjGcx6RiO9O
         KExxWeuHA8hyl+tpU319WXV+4ByxfRBJW5tryK8KW4xq7xdubxO+HOGnFsRme9abH+B0
         CPzxPWlFFn2/63fcY56PszmnRGCAo6PugpYGIxALfoKxXvAJ/oEEQRQIPMtWV7BjKEV8
         7zzQ==
X-Gm-Message-State: APjAAAW1HPnYJP35noAHC5sCcWSxUUE2vR++pQD/idzyzM1E+/LLf7US
        UDLjBSoGJAIhSLrZ/YrEfBRIVg==
X-Google-Smtp-Source: APXvYqyZdMZRBGhIMmDhzMUiOJKBbQPmGCt4q71t3x85OZaN6YlXk2wVApZmGobBbW/OsgsnHg/AEA==
X-Received: by 2002:a17:90a:26e1:: with SMTP id m88mr5081754pje.101.1579793117156;
        Thu, 23 Jan 2020 07:25:17 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:16 -0800 (PST)
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
Subject: [PATCH bpf-next v3 05/10] bpf: lsm: BTF API for LSM hooks
Date:   Thu, 23 Jan 2020 07:24:35 -0800
Message-Id: <20200123152440.28956-6-kpsingh@chromium.org>
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

The BTF API provides information required by the BPF verifier to
attach eBPF programs to the LSM hooks by using the BTF information of
two types:

- struct security_hook_heads: This type provides the offset (using the
  lsm_hook_idx passed by the userspace) to which a new dynamically
  allocated security hook must be attached
- union security_list_options: This provides the information about the
  function prototype required by the hook

The type_ids for these types are calculated once during __init as
bpf_type_by_name_kind does an expensive linear search with string
compariason.  Furthermore, the total number of LSM hooks which can be
determined from the btf_type_vlen of security_hook_heads is needed (in a
subsequent patch) to initialize the mutable hooks for the BPF LSM.

When the program is loaded:

- The verifier receives the index of a member in struct
  security_hook_heads to which a program must be attached as
  prog->aux->lsm_hook_idx.
- bpf_lsm_type_by_idx is used to determine the func_proto of
  the LSM hook and updates prog->aux->attach_func_proto
- bpf_lsm_head_by_idx is used to determine the hlist_head to which
  the BPF program must be attached.

Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h        | 12 ++++++
 security/bpf/Kconfig           |  1 +
 security/bpf/Makefile          |  2 +
 security/bpf/hooks.c           | 75 ++++++++++++++++++++++++++++++++++
 security/bpf/include/bpf_lsm.h | 21 ++++++++++
 security/bpf/lsm.c             | 35 ++++++++++++++++
 6 files changed, 146 insertions(+)
 create mode 100644 security/bpf/include/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 57c20b2cd2f4..5e61c0736001 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,6 +19,8 @@ extern struct security_hook_heads bpf_lsm_hook_heads;
 
 int bpf_lsm_srcu_read_lock(void);
 void bpf_lsm_srcu_read_unlock(int idx);
+const struct btf_type *bpf_lsm_type_by_idx(struct btf *btf, u32 offset);
+const struct btf_member *bpf_lsm_head_by_idx(struct btf *btf, u32 idx);
 
 #define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
 	do {							\
@@ -66,6 +68,16 @@ static inline int bpf_lsm_srcu_read_lock(void)
 	return 0;
 }
 static inline void bpf_lsm_srcu_read_unlock(int idx) {}
+static inline const struct btf_type *bpf_lsm_type_by_idx(
+	struct btf *btf, u32 idx)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline const struct btf_member *bpf_lsm_head_by_idx(
+	struct btf *btf, u32 idx)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 
 #endif /* CONFIG_SECURITY_BPF */
 
diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
index 595e4ad597ae..9438d899b618 100644
--- a/security/bpf/Kconfig
+++ b/security/bpf/Kconfig
@@ -7,6 +7,7 @@ config SECURITY_BPF
 	depends on SECURITY
 	depends on BPF_SYSCALL
 	depends on SRCU
+	depends on DEBUG_INFO_BTF
 	help
 	  This enables instrumentation of the security hooks with
 	  eBPF programs.
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index c526927c337d..748b9b7d4bc7 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -3,3 +3,5 @@
 # Copyright 2019 Google LLC.
 
 obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
+
+ccflags-y := -I$(srctree)/security/bpf -I$(srctree)/security/bpf/include
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index b123d9cb4cd4..e9dc6933b6fa 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,8 +5,12 @@
  */
 
 #include <linux/bpf_lsm.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/srcu.h>
 
+#include "bpf_lsm.h"
+
 DEFINE_STATIC_SRCU(security_hook_srcu);
 
 int bpf_lsm_srcu_read_lock(void)
@@ -18,3 +22,74 @@ void bpf_lsm_srcu_read_unlock(int idx)
 {
 	return srcu_read_unlock(&security_hook_srcu, idx);
 }
+
+static inline int validate_hlist_head(struct btf *btf,
+				      const struct btf_member *member)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(btf, member->type);
+	if (unlikely(!t))
+		return -EINVAL;
+
+	if (BTF_INFO_KIND(t->info) != BTF_KIND_STRUCT)
+		return -EINVAL;
+
+	if (t->size != sizeof(struct hlist_head))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Find the BTF representation of the security_hook_heads member for a member
+ * with a given index in struct security_hook_heads.
+ */
+const struct btf_member *bpf_lsm_head_by_idx(struct btf *btf, u32 idx)
+{
+	const struct btf_member *member;
+	int ret;
+
+	if (idx >= btf_type_vlen(bpf_lsm_info.btf_hook_heads))
+		return ERR_PTR(-EINVAL);
+
+	member = btf_type_member(bpf_lsm_info.btf_hook_heads) + idx;
+	ret = validate_hlist_head(btf, member);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return member;
+}
+
+/* Given an index of a member in security_hook_heads return the
+ * corresponding type for the LSM hook. The members of the union
+ * security_list_options have the same name as the security_hook_heads which
+ * is ensured by the LSM_HOOK_INIT macro defined in include/linux/lsm_hooks.h
+ */
+const struct btf_type *bpf_lsm_type_by_idx(struct btf *btf, u32 idx)
+{
+	const struct btf_member *member, *hook_head = NULL;
+	const struct btf_type *t;
+	u32 i;
+
+	hook_head = bpf_lsm_head_by_idx(btf, idx);
+	if (IS_ERR(hook_head))
+		return ERR_PTR(PTR_ERR(hook_head));
+
+	for_each_member(i, bpf_lsm_info.btf_hook_types, member) {
+		if (hook_head->name_off == member->name_off) {
+			t = btf_type_by_id(btf, member->type);
+			if (unlikely(!t))
+				return ERR_PTR(-EINVAL);
+
+			if (!btf_type_is_ptr(t))
+				return ERR_PTR(-EINVAL);
+
+			t = btf_type_by_id(btf, t->type);
+			if (unlikely(!t))
+				return ERR_PTR(-EINVAL);
+			return t;
+		}
+	}
+
+	return ERR_PTR(-ESRCH);
+}
diff --git a/security/bpf/include/bpf_lsm.h b/security/bpf/include/bpf_lsm.h
new file mode 100644
index 000000000000..f142596d97bd
--- /dev/null
+++ b/security/bpf/include/bpf_lsm.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_LSM_H
+#define _BPF_LSM_H
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+struct bpf_lsm_info {
+	/* BTF type for security_hook_heads populated at init.
+	 */
+	const struct btf_type *btf_hook_heads;
+	/* BTF type for security_list_options populated at init.
+	 */
+	const struct btf_type *btf_hook_types;
+};
+
+extern struct bpf_lsm_info bpf_lsm_info;
+
+#endif /* _BPF_LSM_H */
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
index a25a068e1781..736e0ee3f926 100644
--- a/security/bpf/lsm.c
+++ b/security/bpf/lsm.c
@@ -7,6 +7,8 @@
 #include <linux/bpf_lsm.h>
 #include <linux/lsm_hooks.h>
 
+#include "bpf_lsm.h"
+
 /* This is only for internal hooks, always statically shipped as part of the
  * BPF LSM. Statically defined hooks are appended to the security_hook_heads
  * which is common for LSMs and R/O after init.
@@ -19,6 +21,39 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {};
  */
 struct security_hook_heads bpf_lsm_hook_heads;
 
+struct bpf_lsm_info bpf_lsm_info;
+
+static __init int bpf_lsm_info_init(void)
+{
+	const struct btf_type *t;
+
+	if (!btf_vmlinux)
+		/* No need to grab any locks because we are still in init */
+		btf_vmlinux = btf_parse_vmlinux();
+
+	if (IS_ERR(btf_vmlinux)) {
+		pr_err("btf_vmlinux is malformed\n");
+		return PTR_ERR(btf_vmlinux);
+	}
+
+	t = btf_type_by_name_kind(btf_vmlinux, "security_hook_heads",
+				  BTF_KIND_STRUCT);
+	if (WARN_ON(IS_ERR(t)))
+		return PTR_ERR(t);
+
+	bpf_lsm_info.btf_hook_heads = t;
+
+	t = btf_type_by_name_kind(btf_vmlinux, "security_list_options",
+				  BTF_KIND_UNION);
+	if (WARN_ON(IS_ERR(t)))
+		return PTR_ERR(t);
+
+	bpf_lsm_info.btf_hook_types = t;
+	return 0;
+}
+
+late_initcall(bpf_lsm_info_init);
+
 static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
-- 
2.20.1

