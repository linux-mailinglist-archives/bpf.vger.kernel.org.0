Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC58750D55F
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiDXVwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVwI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093E644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d15so8477191plh.2
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJ1/LKMR2t4dgOCk06S5LuRwphhBDfbddTkoYjvu3X4=;
        b=df3Undvcctjzg0vkXJPF581NvFWg0NPa3jLMYRGc7TNSG4+Z5WD19S1AVaAn0fyYkx
         Lk+pv6Q6YI/oqe0DIGQRknW6Z3KV7BcOGLgtyupZMKiaERlEIOzfshZBb5ZTqpvNa3V7
         Mt7uFMIeLSEjellUHI7l90veqrYnKsWDPzV+2xFQT8kXLIr/2LSJyjVqN9i5VmWzo7r8
         xUB+nPnawae/Q5LkR/tjCc65ScijvLSOBjltUzETRvtBaT+EXKnh4NT/A79ixj6C2Jc+
         tmxXlV+thevvTkFU2LEcwgWVowHD6XbJbjvL3b1+fDUIEhWXaXripFjapdUGZbHi16gS
         BCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJ1/LKMR2t4dgOCk06S5LuRwphhBDfbddTkoYjvu3X4=;
        b=ecqfhSCRUkEYqTNHDuHdhlej0HzFH7m+cD8/enEp35BRFYY4fCbXKIThnKITwOxdhu
         tlirH0fVguEbg6feKxIbI2pxP6GD1gjftmiaQBrU54xGmXGWnXCQYzwPaWdb5G1kpMLT
         c45DuLXEm/rGFcdj3OM74LRrrsQcF1p0KkaM46Yc2+HZsM4BseyYpzC6s3o+aAAbCnCA
         qoU1MtsHiBk/WtdcBX9lPefgRADG00SgVRDjMkJnvO7UT7AkUy8kiSw7slIaWGPfAAVO
         JBK7VM8d+sjqts+8tAk+ODTByyP9HL9rrdRqRNgOAFtbeVAQwnwWOpcbu3ntM7IeJFz5
         8PXg==
X-Gm-Message-State: AOAM5306vLqb9HIZo+jnz2kw13p2AtyuGtZwC+4DwD1BkiAA6bo4HQuN
        vTFReK/11UIy8cMLUemHJL6ZmGCCxh0=
X-Google-Smtp-Source: ABdhPJzcP2YLqXpIayzPL8ofj9C2Bm2qWrzKmlyh47XkIzoB2By5fP+lMc7FCsg6gRXRV4GVA4N7vw==
X-Received: by 2002:a17:902:ecc5:b0:15b:2d64:5104 with SMTP id a5-20020a170902ecc500b0015b2d645104mr15157644plh.20.1650836946117;
        Sun, 24 Apr 2022 14:49:06 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a2e0700b001cda0b69a30sm12353606pjd.52.2022.04.24.14.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 06/13] bpf: Populate pairs of btf_id and destructor kfunc in btf
Date:   Mon, 25 Apr 2022 03:18:54 +0530
Message-Id: <20220424214901.2743946-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; h=from:subject; bh=0MRi6q2iFF3LlAjawf7OMC4lVAGihXOFR+LO/zsKYus=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLe3DnMBbpakF+pn5nAHkckhX8fqauW7Es6yl5 snUbC7qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8Ryn+GEA CtMyNZv/Nqi565g6EWpWq1epQXXfrBnwTX5XIMOYfURMu7pNqQ6R2RvPjdnIX6PCqt1yQAkTy7nYv3 NtiPwm+ULteKZxKUq7JguNTYgCxnvWFtQl1MrgdnlQBRIowRUnzyMh7cyrSoMwm9ekN0NgPUeccYj/ E2QoZQ+5SGHif+9JNv8GTCHhFlYf3OawSdJTiwSQnkpk8kw9ZBGgMLS2pLJTTO1CNYZOyg3wx5SBmY LrlcvYiEbok90YbivWz8tq0A1n9ctDR/hb4xhfummCzOA7v9A1NfKqUWmfTa5wMUoV539NEC1QcvzO L7WD70dH1pVtXXbxq5Wrf8d3Aa4LOA593k0VDaatUFbdoNlt/4/nZ9LzFPIaRtB5HUFT2i4ApeiW2N BECUsMI0Fy+3dFm9Xg70uwtCE+S0Rn3bdRVooZVLZ0IbGsnlT2gZ+SJXD0kEwQ8XQ/vnLorO2A+R11 kKg8l6h1NciVQWkIbx+Z5qs+9UyizBaO9tnZHcJ2xttL5W0s4EbM7Iku2qJ/m6/MpE3+RxEywgzwYL syM3egBrQkJJYTkjQz1s+9cyCz78TC/UP2Wu/Goq+AgDP/oVRk/qPJmQ9C0iewUdvAH/2eOTBoRIIk O7gMQ+Abt8ZJ19/qKeWnLgU9jVLE15X/bZICT/crtYmjRq50XQVkBrsd/MyA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

To support storing referenced PTR_TO_BTF_ID in maps, we require
associating a specific BTF ID with a 'destructor' kfunc. This is because
we need to release a live referenced pointer at a certain offset in map
value from the map destruction path, otherwise we end up leaking
resources.

Hence, introduce support for passing an array of btf_id, kfunc_btf_id
pairs that denote a BTF ID and its associated release function. Then,
add an accessor 'btf_find_dtor_kfunc' which can be used to look up the
destructor kfunc of a certain BTF ID. If found, we can use it to free
the object from the map free path.

The registration of these pairs also serve as a whitelist of structures
which are allowed as referenced PTR_TO_BTF_ID in a BPF map, because
without finding the destructor kfunc, we will bail and return an error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h |  17 +++++++
 kernel/bpf/btf.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 19c297f9a52f..fea424681d66 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -40,6 +40,11 @@ struct btf_kfunc_id_set {
 	};
 };
 
+struct btf_id_dtor_kfunc {
+	u32 btf_id;
+	u32 kfunc_btf_id;
+};
+
 extern const struct file_operations btf_fops;
 
 void btf_get(struct btf *btf);
@@ -346,6 +351,9 @@ bool btf_kfunc_id_set_contains(const struct btf *btf,
 			       enum btf_kfunc_type type, u32 kfunc_btf_id);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
+s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
+int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
+				struct module *owner);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -369,6 +377,15 @@ static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 {
 	return 0;
 }
+static inline s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
+{
+	return -ENOENT;
+}
+static inline int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors,
+					      u32 add_cnt, struct module *owner)
+{
+	return 0;
+}
 #endif
 
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4138c51728dd..a0b1665a4a48 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -207,12 +207,18 @@ enum btf_kfunc_hook {
 
 enum {
 	BTF_KFUNC_SET_MAX_CNT = 32,
+	BTF_DTOR_KFUNC_MAX_CNT = 256,
 };
 
 struct btf_kfunc_set_tab {
 	struct btf_id_set *sets[BTF_KFUNC_HOOK_MAX][BTF_KFUNC_TYPE_MAX];
 };
 
+struct btf_id_dtor_kfunc_tab {
+	u32 cnt;
+	struct btf_id_dtor_kfunc dtors[];
+};
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -228,6 +234,7 @@ struct btf {
 	u32 id;
 	struct rcu_head rcu;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
+	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1616,8 +1623,19 @@ static void btf_free_kfunc_set_tab(struct btf *btf)
 	btf->kfunc_set_tab = NULL;
 }
 
+static void btf_free_dtor_kfunc_tab(struct btf *btf)
+{
+	struct btf_id_dtor_kfunc_tab *tab = btf->dtor_kfunc_tab;
+
+	if (!tab)
+		return;
+	kfree(tab);
+	btf->dtor_kfunc_tab = NULL;
+}
+
 static void btf_free(struct btf *btf)
 {
+	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
@@ -7076,6 +7094,96 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
 
+s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
+{
+	struct btf_id_dtor_kfunc_tab *tab = btf->dtor_kfunc_tab;
+	struct btf_id_dtor_kfunc *dtor;
+
+	if (!tab)
+		return -ENOENT;
+	/* Even though the size of tab->dtors[0] is > sizeof(u32), we only need
+	 * to compare the first u32 with btf_id, so we can reuse btf_id_cmp_func.
+	 */
+	BUILD_BUG_ON(offsetof(struct btf_id_dtor_kfunc, btf_id) != 0);
+	dtor = bsearch(&btf_id, tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func);
+	if (!dtor)
+		return -ENOENT;
+	return dtor->kfunc_btf_id;
+}
+
+/* This function must be invoked only from initcalls/module init functions */
+int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
+				struct module *owner)
+{
+	struct btf_id_dtor_kfunc_tab *tab;
+	struct btf *btf;
+	u32 tab_cnt;
+	int ret;
+
+	btf = btf_get_module_btf(owner);
+	if (!btf) {
+		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
+			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
+			return -ENOENT;
+		}
+		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
+			pr_err("missing module BTF, cannot register dtor kfuncs\n");
+			return -ENOENT;
+		}
+		return 0;
+	}
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	if (add_cnt >= BTF_DTOR_KFUNC_MAX_CNT) {
+		pr_err("cannot register more than %d kfunc destructors\n", BTF_DTOR_KFUNC_MAX_CNT);
+		ret = -E2BIG;
+		goto end;
+	}
+
+	tab = btf->dtor_kfunc_tab;
+	/* Only one call allowed for modules */
+	if (WARN_ON_ONCE(tab && btf_is_module(btf))) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	tab_cnt = tab ? tab->cnt : 0;
+	if (tab_cnt > U32_MAX - add_cnt) {
+		ret = -EOVERFLOW;
+		goto end;
+	}
+	if (tab_cnt + add_cnt >= BTF_DTOR_KFUNC_MAX_CNT) {
+		pr_err("cannot register more than %d kfunc destructors\n", BTF_DTOR_KFUNC_MAX_CNT);
+		ret = -E2BIG;
+		goto end;
+	}
+
+	tab = krealloc(btf->dtor_kfunc_tab,
+		       offsetof(struct btf_id_dtor_kfunc_tab, dtors[tab_cnt + add_cnt]),
+		       GFP_KERNEL | __GFP_NOWARN);
+	if (!tab) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	if (!btf->dtor_kfunc_tab)
+		tab->cnt = 0;
+	btf->dtor_kfunc_tab = tab;
+
+	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]));
+	tab->cnt += add_cnt;
+
+	sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL);
+
+	return 0;
+end:
+	btf_free_dtor_kfunc_tab(btf);
+	btf_put(btf);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_btf_id_dtor_kfuncs);
+
 #define MAX_TYPES_ARE_COMPAT_DEPTH 2
 
 static
-- 
2.35.1

