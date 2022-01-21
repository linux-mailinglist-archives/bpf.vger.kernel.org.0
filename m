Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8D4965CD
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiAUTkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiAUTkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:40:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23574C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18so18798539wmg.4
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d36JwKRJF+F/VQLZSK738N+rbIWQmy8XZ1M8bl9WcNg=;
        b=LIVekycD4PHpyBoap1bHQrfMfGL2LN9wMYyihTbsKRzOzFSeckshevQ9qczEJpJXKh
         DTb4EK0rJiGTY/Dm2VA5RHF4iLQEQMX784SnR8qYRMVlvwcvUIvLx9oL0OZlfN8rc+4q
         NfK7FP0w1eUQF83vIRFp5e7mXoCnV1ukxR7si6V0wgDSPeN7lUlrZNLAs2N2LoWjETZy
         T5AGb6S/AxCmgky/t8W1DG1fgtxT1kEVPrn2/2Kf/BL4lCo23ULfdXxBLBzTtfzNlXci
         LxP7s0z72oz42kmPqudBled0XZEY9RP3ZgTODQGKc2ECYANYuwSaJDXtGl3NKgWp4Z3q
         VLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d36JwKRJF+F/VQLZSK738N+rbIWQmy8XZ1M8bl9WcNg=;
        b=UKZZviG5l4/9PE5pgnz01k5XT1uHqrs2jTVKvDSGVBFyNaeezKGV2o9SqOg3POI2ac
         EA6QGW3M/8BbG6uKHqIFSosdFuoIYt+/5U8hJflTOOUDM3rqaAfmqLhYbWCUv6eEp4Gx
         6Huwt0YfvwzDCcQ0HjdkGfn0dQ0Wa6g4MzP3NXTn0K5QN677sefvvLnReFLyDhU4a0Fr
         GBQzLNFuaBkZQJpE2uAEV/kESqUckU1QcrnMRrvcG+J6jVWcLF+YT7ALi6GguUMomGGB
         BU5fiNnnC5mvoIa3R6x27EOwL5AH4H5jIK4WNDEtHa7c7uYblQ4Xe1Wwh68wdMX1HAtN
         B42A==
X-Gm-Message-State: AOAM532e0/7IHdp2QP5ziKNYMxvRfWjtwmInBMMVFW1SRRw/xw6GND5o
        GhAMe85Il/IFgZ89d6rSy+3RAzpF5QYfCA==
X-Google-Smtp-Source: ABdhPJxBLJMAnDGVmM1SYYn+E/akS3YfI61ornwmr8QCV/AIW37RWJtFeKNyKRmbfbGM9EXs/JS8hw==
X-Received: by 2002:a05:600c:3783:: with SMTP id o3mr2024471wmr.74.1642794019576;
        Fri, 21 Jan 2022 11:40:19 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:575f:679d:7c2f:fa19])
        by smtp.gmail.com with ESMTPSA id n14sm6988059wri.101.2022.01.21.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:40:19 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com
Cc:     fam.zheng@bytedance.com, cong.wang@bytedance.com, song@kernel.org,
        Usama Arif <usama.arif@bytedance.com>
Subject: [RFC bpf-next 1/3] bpf: btf: Introduce infrastructure for module helpers
Date:   Fri, 21 Jan 2022 19:39:54 +0000
Message-Id: <20220121193956.198120-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121193956.198120-1-usama.arif@bytedance.com>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for calling helper functions in eBPF applications
that have been declared in a kernel module. The corresponding
verifier changes for module helpers will be added in a later patch.

Module helpers are useful as:
- They support more argument and return types when compared to module
kfunc.
- This adds a way to have helper functions that would be too specialized
for a specific usecase to merge upstream, but are functions that can have
a constant API and can be maintained in-kernel modules.
- The number of in-kernel helpers have grown to a large number
(187 at the time of writing this commit). Having module helper functions
could possibly reduce the number of in-kernel helper functions growing
in the future and maintained upstream.

When the kernel module registers the helper, the module owner,
BTF id set of the function and function proto is stored as part of a
btf_mod_helper entry in a btf_mod_helper_list which is part of
struct btf. This entry can be removed in the unregister function
while exiting the module, and can be used by the bpf verifier to
check the helper call and get function proto.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 include/linux/btf.h | 44 +++++++++++++++++++++++
 kernel/bpf/btf.c    | 88 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b12cfe3b12bb..c3a814404112 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -40,6 +40,18 @@ struct btf_kfunc_id_set {
 	};
 };
 
+struct btf_mod_helper {
+	struct list_head list;
+	struct module *owner;
+	struct btf_id_set *set;
+	struct bpf_func_proto *func_proto;
+};
+
+struct btf_mod_helper_list {
+	struct list_head list;
+	struct mutex mutex;
+};
+
 extern const struct file_operations btf_fops;
 
 void btf_get(struct btf *btf);
@@ -359,4 +371,36 @@ static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 }
 #endif
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+int register_mod_helper(struct btf_mod_helper *mod_helper);
+int unregister_mod_helper(struct btf_mod_helper *mod_helper);
+const struct bpf_func_proto *get_mod_helper_proto(const struct btf *btf,
+	const u32 kfunc_btf_id);
+
+#define DEFINE_MOD_HELPER(mod_helper, owner, helper_func, func_proto) \
+BTF_SET_START(helper_func##__id_set) \
+BTF_ID(func, helper_func) \
+BTF_SET_END(helper_func##__id_set) \
+struct btf_mod_helper mod_helper = { \
+	LIST_HEAD_INIT(mod_helper.list), \
+	(owner), \
+	(&(helper_func##__id_set)), \
+	(&(func_proto)) \
+}
+#else
+int register_mod_helper(struct btf_mod_helper *mod_helper)
+{
+	return -EPERM;
+}
+int unregister_mod_helper(struct btf_mod_helper *mod_helper)
+{
+	return -EPERM;
+}
+const struct bpf_func_proto *get_mod_helper_proto(const struct btf *btf,
+	const u32 kfunc_btf_id)
+{
+	return NULL;
+}
+#endif
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 57f5fd5af2f9..f9aa6ba85f3f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -228,6 +228,7 @@ struct btf {
 	u32 id;
 	struct rcu_head rcu;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
+	struct btf_mod_helper_list *mod_helper_list;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -6752,6 +6753,93 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+int register_mod_helper(struct btf_mod_helper *mod_helper)
+{
+	struct btf_mod_helper *s;
+	struct btf *btf;
+	struct btf_mod_helper_list *mod_helper_list;
+
+	btf = btf_get_module_btf(mod_helper->owner);
+	if (!btf_is_module(btf)) {
+		pr_err("%s can only be called from kernel module", __func__);
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(btf))
+		return btf ? PTR_ERR(btf) : -ENOENT;
+
+	mod_helper_list = btf->mod_helper_list;
+	if (!mod_helper_list) {
+		mod_helper_list = kzalloc(sizeof(*mod_helper_list), GFP_KERNEL | __GFP_NOWARN);
+		if (!mod_helper_list)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&mod_helper_list->list);
+		mutex_init(&mod_helper_list->mutex);
+		btf->mod_helper_list = mod_helper_list;
+	}
+
+	// Check if btf id is already registered
+	mutex_lock(&mod_helper_list->mutex);
+	list_for_each_entry(s, &mod_helper_list->list, list) {
+		if (mod_helper->set->ids[0] == s->set->ids[0]) {
+			pr_warn("Dynamic helper %u is already registered\n", s->set->ids[0]);
+			mutex_unlock(&mod_helper_list->mutex);
+			return -EINVAL;
+		}
+	}
+	list_add(&mod_helper->list, &mod_helper_list->list);
+	mutex_unlock(&mod_helper_list->mutex);
+	btf_put(btf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_mod_helper);
+
+int unregister_mod_helper(struct btf_mod_helper *mod_helper)
+{
+	struct btf *btf;
+	struct btf_mod_helper_list *mod_helper_list;
+
+	btf = btf_get_module_btf(mod_helper->owner);
+	if (!btf_is_module(btf)) {
+		pr_err("%s can only be called from kernel module", __func__);
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(btf))
+		return btf ? PTR_ERR(btf) : -ENOENT;
+
+	mod_helper_list = btf->mod_helper_list;
+	mutex_lock(&mod_helper_list->mutex);
+	list_del(&mod_helper->list);
+	mutex_unlock(&mod_helper_list->mutex);
+	btf_put(btf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unregister_mod_helper);
+const struct bpf_func_proto *get_mod_helper_proto(const struct btf *btf, const u32 kfunc_btf_id)
+{
+	struct btf_mod_helper *s;
+	struct btf_mod_helper_list *mod_helper_list;
+
+	mod_helper_list = btf->mod_helper_list;
+	if (!mod_helper_list)
+		return NULL;
+
+	mutex_lock(&mod_helper_list->mutex);
+	list_for_each_entry(s, &mod_helper_list->list, list) {
+		if (s->set->ids[0] == kfunc_btf_id) {
+			mutex_unlock(&mod_helper_list->mutex);
+			return s->func_proto;
+		}
+	}
+	mutex_unlock(&mod_helper_list->mutex);
+	return NULL;
+}
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id)
 {
-- 
2.25.1

