Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4C6CAA17
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjC0QOL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjC0QOK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 12:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43219BF
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679933603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2AxP1O7sml6Z95M//KVYu3KPUF5AM2A4gmOVSjfr8v8=;
        b=BOeviLK8zKk4IFI/zAyIWNlNGbS3HV4iGuZrLIdnfxeMeb4lHLfdIEQZMj8rTZ06Zoxqa5
        /PAM/SN0BD3ZyC/4eZd90hv+ecuIlQBHy/wI/GILLJwTThNbyI7sJMnJctkZFbwuZoREk+
        wEK183nmygSk9WTtla6ZwBp/WSOStsY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-4Mti2eS0MwSGgsjZ8kg3LA-1; Mon, 27 Mar 2023 12:13:19 -0400
X-MC-Unique: 4Mti2eS0MwSGgsjZ8kg3LA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CED93C18342;
        Mon, 27 Mar 2023 16:13:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D22B140E949;
        Mon, 27 Mar 2023 16:13:13 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Viktor Malik <vmalik@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] kallsyms: move module-related functions under correct configs
Date:   Mon, 27 Mar 2023 18:12:51 +0200
Message-Id: <20230327161251.1129511-1-vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Functions for searching module kallsyms should have non-empty
definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
only CONFIG_MODULES check was used for many of these, which may have
caused complilation errors on some configs.

This patch moves all relevant functions under the correct configs.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
---
 include/linux/module.h | 155 ++++++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 71 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 41cfd3be57e5..eaad4b7a3788 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -608,16 +608,6 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
 /* Search for module by name: must be in a RCU-sched critical section. */
 struct module *find_module(const char *name);
 
-/* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
-   symnum out of range. */
-int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported);
-
-/* Look for this name: can be of form module:name. */
-unsigned long module_kallsyms_lookup_name(const char *name);
-
-unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
-
 extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
 			long code);
 #define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
@@ -661,20 +651,6 @@ static inline void __module_get(struct module *module)
 	__mod ? __mod->name : "kernel";		\
 })
 
-/* Dereference module function descriptor */
-void *dereference_module_function_descriptor(struct module *mod, void *ptr);
-
-/* For kallsyms to ask for address resolution.  namebuf should be at
- * least KSYM_NAME_LEN long: a pointer to namebuf is returned if
- * found, otherwise NULL. */
-const char *module_address_lookup(unsigned long addr,
-			    unsigned long *symbolsize,
-			    unsigned long *offset,
-			    char **modname, const unsigned char **modbuildid,
-			    char *namebuf);
-int lookup_module_symbol_name(unsigned long addr, char *symname);
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
-
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
 
@@ -765,45 +741,6 @@ static inline void module_put(struct module *module)
 
 #define module_name(mod) "kernel"
 
-/* For kallsyms to ask for address resolution.  NULL means not found. */
-static inline const char *module_address_lookup(unsigned long addr,
-					  unsigned long *symbolsize,
-					  unsigned long *offset,
-					  char **modname,
-					  const unsigned char **modbuildid,
-					  char *namebuf)
-{
-	return NULL;
-}
-
-static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
-{
-	return -ERANGE;
-}
-
-static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name)
-{
-	return -ERANGE;
-}
-
-static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
-					char *type, char *name,
-					char *module_name, int *exported)
-{
-	return -ERANGE;
-}
-
-static inline unsigned long module_kallsyms_lookup_name(const char *name)
-{
-	return 0;
-}
-
-static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
-						       const char *name)
-{
-	return 0;
-}
-
 static inline int register_module_notifier(struct notifier_block *nb)
 {
 	/* no events will happen anyway, so this can always succeed */
@@ -831,13 +768,6 @@ static inline void set_module_sig_enforced(void)
 {
 }
 
-/* Dereference module function descriptor */
-static inline
-void *dereference_module_function_descriptor(struct module *mod, void *ptr)
-{
-	return ptr;
-}
-
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
@@ -899,7 +829,39 @@ int module_kallsyms_on_each_symbol(const char *modname,
 				   int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
-#else
+
+/* Dereference module function descriptor */
+void *dereference_module_function_descriptor(struct module *mod, void *ptr);
+
+/* For kallsyms to ask for address resolution.  namebuf should be at
+ * least KSYM_NAME_LEN long: a pointer to namebuf is returned if
+ * found, otherwise NULL.
+ */
+const char *module_address_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, const unsigned char **modbuildid,
+			    char *namebuf);
+int lookup_module_symbol_name(unsigned long addr, char *symname);
+int lookup_module_symbol_attrs(unsigned long addr,
+			       unsigned long *size,
+			       unsigned long *offset,
+			       char *modname,
+			       char *name);
+
+/* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
+ * symnum out of range.
+ */
+int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+			char *name, char *module_name, int *exported);
+
+/* Look for this name: can be of form module:name. */
+unsigned long module_kallsyms_lookup_name(const char *name);
+
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
+
+#else	/* CONFIG_MODULES && CONFIG_KALLSYMS */
+
 static inline int module_kallsyms_on_each_symbol(const char *modname,
 						 int (*fn)(void *, const char *,
 						 struct module *, unsigned long),
@@ -907,6 +869,57 @@ static inline int module_kallsyms_on_each_symbol(const char *modname,
 {
 	return -EOPNOTSUPP;
 }
+
+/* Dereference module function descriptor */
+static inline
+void *dereference_module_function_descriptor(struct module *mod, void *ptr)
+{
+	return ptr;
+}
+
+/* For kallsyms to ask for address resolution.  NULL means not found. */
+static inline const char *module_address_lookup(unsigned long addr,
+					  unsigned long *symbolsize,
+					  unsigned long *offset,
+					  char **modname,
+					  const unsigned char **modbuildid,
+					  char *namebuf)
+{
+	return NULL;
+}
+
+static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
+{
+	return -ERANGE;
+}
+
+static inline int lookup_module_symbol_attrs(unsigned long addr,
+					     unsigned long *size,
+					     unsigned long *offset,
+					     char *modname,
+					     char *name)
+{
+	return -ERANGE;
+}
+
+static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
+					char *type, char *name,
+					char *module_name, int *exported)
+{
+	return -ERANGE;
+}
+
+static inline unsigned long module_kallsyms_lookup_name(const char *name)
+{
+	return 0;
+}
+
+static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
+						       const char *name)
+{
+	return 0;
+}
+
 #endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
-- 
2.39.2

