Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313FB649767
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLLAho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiLLAhn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:37:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668310AA
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so10475288pjm.2
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWked+wJERqcTSi79JV5oNIuOa0tfY0vnwLs5gY8MS8=;
        b=bWMeQ5bnX0TAF6bOdYkP/oOKV5jf+3Uc15vF0wU9CfGJjw8kfYoU9EPZGM+bc1iKJx
         ky0g+H15r5zMpolW5OyrMmBrnfZpvmLsGwkUUacNNe8GZ4BzalwNbsYnV8siK0KSl7lv
         9/STfhGYSN5Bjms4C9NOCDfn0fZIaDlTYFfh4UM012DUHv+Y/RfbqnWW06UsZxe8BGa4
         +qnpdhR49of03EqQmxuVAUhq0r8nqWyKiAn1qvq5SLlOTbQKqnSOoCbL3MnLuPcYWUUF
         p3LOJ5YBnQDwUEvNREGZPpa+SVWD17iJwLObXxC6Z/3sjrjshYcCezzIqtZ1d8aoDxMB
         UFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWked+wJERqcTSi79JV5oNIuOa0tfY0vnwLs5gY8MS8=;
        b=6kyNsHqwMte6iv8o7k95++vfoXalbqzOFZhpXIZgoMTbXcFgZE6l81ov9+PX2fZaWt
         4Ysv/MsUBLZsnexN8QPFjvr7VPtUv7E5IzIi4Nf/WrHkIoaW7e+vKUlevlartUC4VMIH
         2ZL2Z0E8s2ndlOSZ3B5HiWjkDXrpYpxXx7Ke+hNqvu/7saer2MQOOqvU3LT5Zj+wQFrR
         Z1MNF//TqGKSy7G3251zOHj1Ph6RVmFlt64kAeSkX5HSAtZKcHLXXFzlGtapx+6voR7R
         rfNvEUbbvO3BaTjaPz/2+P8vriXgDDrKHctu0RVlm4iBIQHiID+HYr5YlGPXv665XApl
         UTfA==
X-Gm-Message-State: ANoB5pkoOAEmMcIS8Wq2bQfgFjzkqsickUnbTcnaxqGe27nA3gdTKluC
        L78z4LF/BYJle6D4R39KrepgX9nwoDAVcfMEAiU=
X-Google-Smtp-Source: AA0mqf7ELqiSpWsfHtvtdVOpa+IdGBSzwZN2i+Zxsp57q2bOLFd/Qst7Jv0nZP60GjGAejI5hY2y/g==
X-Received: by 2002:a17:902:728d:b0:189:6293:e01a with SMTP id d13-20020a170902728d00b001896293e01amr13335786pll.12.1670805461055;
        Sun, 11 Dec 2022 16:37:41 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:37:40 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/9] mm: Introduce active vm item
Date:   Mon, 12 Dec 2022 00:37:03 +0000
Message-Id: <20221212003711.24977-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new page extension active_vm is introduced in this patch. It can be
enabled and disabled by setting CONFIG_ACTIVE_VM at compile time or a boot
parameter 'active_vm' at run time.

In the followup patches, we will use it to account specific memory
allocation for page, slab and percpu memory.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/active_vm.h | 23 +++++++++++++++++++++++
 mm/Kconfig                |  8 ++++++++
 mm/Makefile               |  1 +
 mm/active_vm.c            | 33 +++++++++++++++++++++++++++++++++
 mm/active_vm.h            |  8 ++++++++
 mm/page_ext.c             |  4 ++++
 6 files changed, 77 insertions(+)
 create mode 100644 include/linux/active_vm.h
 create mode 100644 mm/active_vm.c
 create mode 100644 mm/active_vm.h

diff --git a/include/linux/active_vm.h b/include/linux/active_vm.h
new file mode 100644
index 000000000000..899e578e94fa
--- /dev/null
+++ b/include/linux/active_vm.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __INCLUDE_ACTIVE_VM_H
+#define __INCLUDE_ACTIVE_VM_H
+
+#ifdef CONFIG_ACTIVE_VM
+#include <linux/jump_label.h>
+
+extern struct static_key_true active_vm_disabled;
+
+static inline bool active_vm_enabled(void)
+{
+	if (static_branch_likely(&active_vm_disabled))
+		return false;
+
+	return true;
+}
+#else
+static inline bool active_vm_enabled(void)
+{
+	return false;
+}
+#endif /* CONFIG_ACTIVE_VM */
+#endif /* __INCLUDE_ACTIVE_VM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c5b505..ba1087e4afff 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1150,6 +1150,14 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config ACTIVE_VM
+	bool "To track memory size of active VM item"
+	default y
+	depends on PAGE_EXTENSION
+	help
+		Allow scope-based memory accouting for specific memory, e.g. the
+		system-wide BPF memory usage.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..347dcff061d5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_ACTIVE_VM) += active_vm.o
diff --git a/mm/active_vm.c b/mm/active_vm.c
new file mode 100644
index 000000000000..60849930a7d3
--- /dev/null
+++ b/mm/active_vm.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/page_ext.h>
+
+static bool __active_vm_enabled __initdata =
+				IS_ENABLED(CONFIG_ACTIVE_VM);
+
+DEFINE_STATIC_KEY_TRUE(active_vm_disabled);
+EXPORT_SYMBOL(active_vm_disabled);
+
+static int __init early_active_vm_param(char *buf)
+{
+	return strtobool(buf, &__active_vm_enabled);
+}
+
+early_param("active_vm", early_active_vm_param);
+
+static bool __init need_active_vm(void)
+{
+	return __active_vm_enabled;
+}
+
+static void __init init_active_vm(void)
+{
+	if (!__active_vm_enabled)
+		return;
+
+	static_branch_disable(&active_vm_disabled);
+}
+
+struct page_ext_operations active_vm_ops = {
+	.need = need_active_vm,
+	.init = init_active_vm,
+};
diff --git a/mm/active_vm.h b/mm/active_vm.h
new file mode 100644
index 000000000000..72978955833e
--- /dev/null
+++ b/mm/active_vm.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MM_ACTIVE_VM_H
+#define __MM_ACTIVE_VM_H
+
+#ifdef CONFIG_ACTIVE_VM
+extern struct page_ext_operations active_vm_ops;
+#endif /* CONFIG_ACTIVE_VM */
+#endif /* __MM_ACTIVE_VM_H */
diff --git a/mm/page_ext.c b/mm/page_ext.c
index ddf1968560f0..3a3a91bc9e06 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -10,6 +10,7 @@
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 #include <linux/rcupdate.h>
+#include "active_vm.h"
 
 /*
  * struct page extension
@@ -84,6 +85,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
+#ifdef CONFIG_ACTIVE_VM
+	&active_vm_ops,
+#endif
 };
 
 unsigned long page_ext_size = sizeof(struct page_ext);
-- 
2.30.1 (Apple Git-130)

