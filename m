Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC476BE606
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCQJ5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCQJ5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 05:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924AE1FED
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679046979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c8I+qykTI74Ab/VGldPB2UipRn0pmrBXTGeZi/iZopU=;
        b=Q2vfd2AASj1d9/KFo5lNNrAGAFUvBW5oK3qQCZcgvCHWA0OHpflBw2IhiGNGz3HUN4+F2G
        PDR9tWzbgdCL4RwuefHxUn2z9QRS/FzLQbC8khgdKIgMR9O6+roVyj5p8kFvfeJYTiObv+
        a9IngosL8aptL208bbJ0hny28qFywmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-Ig_oibI_OreWsZwzXHgosg-1; Fri, 17 Mar 2023 05:56:16 -0400
X-MC-Unique: Ig_oibI_OreWsZwzXHgosg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56D4F185A78B;
        Fri, 17 Mar 2023 09:56:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0C60483EC0;
        Fri, 17 Mar 2023 09:56:11 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viktor Malik <vmalik@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] kallsyms: move find_kallsyms_symbol_value out of internal header
Date:   Fri, 17 Mar 2023 10:56:01 +0100
Message-Id: <20230317095601.386738-1-vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving find_kallsyms_symbol_value from kernel/module/internal.h to
include/linux/module.h. The reason is that internal.h is not prepared to
be included when CONFIG_MODULES=n. find_kallsyms_symbol_value is used by
kernel/bpf/verifier.c and including internal.h from it (without modules)
leads into a compilation error:

In file included from ../include/linux/container_of.h:5,
                 from ../include/linux/list.h:5,
                 from ../include/linux/timer.h:5,
                 from ../include/linux/workqueue.h:9,
                 from ../include/linux/bpf.h:10,
                 from ../include/linux/bpf-cgroup.h:5,
                 from ../kernel/bpf/verifier.c:7:
../kernel/bpf/../module/internal.h: In function 'mod_find':
../include/linux/container_of.h:20:54: error: invalid use of undefined type 'struct module'
   20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
      |                                                      ^~
[...]

This patch fixes the above error.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303161404.OrmfCy09-lkp@intel.com/
---
 include/linux/module.h   | 8 ++++++++
 kernel/bpf/verifier.c    | 2 +-
 kernel/module/internal.h | 6 ------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 4435ad9439ab..41cfd3be57e5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -616,6 +616,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
 
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
+
 extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
 			long code);
 #define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
@@ -796,6 +798,12 @@ static inline unsigned long module_kallsyms_lookup_name(const char *name)
 	return 0;
 }
 
+static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
+						       const char *name)
+{
+	return 0;
+}
+
 static inline int register_module_notifier(struct notifier_block *nb)
 {
 	/* no events will happen anyway, so this can always succeed */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d62b7127ff2a..99394a2f7ee4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,7 +24,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
-#include "../module/internal.h"
+#include <linux/module.h>
 
 #include "disasm.h"
 
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 5c9170f9135c..1c877561a7d2 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -246,7 +246,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 void init_build_id(struct module *mod, const struct load_info *info);
 void layout_symtab(struct module *mod, struct load_info *info);
 void add_kallsyms(struct module *mod, const struct load_info *info);
-unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
 
 static inline bool sect_empty(const Elf_Shdr *sect)
 {
@@ -256,11 +255,6 @@ static inline bool sect_empty(const Elf_Shdr *sect)
 static inline void init_build_id(struct module *mod, const struct load_info *info) { }
 static inline void layout_symtab(struct module *mod, struct load_info *info) { }
 static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
-static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
-						       const char *name)
-{
-	return 0;
-}
 #endif /* CONFIG_KALLSYMS */
 
 #ifdef CONFIG_SYSFS
-- 
2.39.2

