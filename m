Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB44FA67B
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiDIJfe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E262CC
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t13so9846521pgn.8
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeHmYgHw7UI5yCAngCSiEUhj4Wa74RE1CCwgygy8rm4=;
        b=L6yqQhTwB/sUOg61iTS58q/Z8LWmukkDtJSxdgCjWcYTQ+almT9hEpoeFmCtO792qq
         kdpA/1o8vSdsOfVKpehOMvT0LVeTJMVMX+R+N7opigvgPRDUGPhwbXVOmuzkzOHSUe5W
         pq7elpV9O8VHa0A7xbkohRkfDFJJOQSDBy/0sInR6oyG3+FO0SIly2J9Y0g97PlRtWYI
         h1RuTdB8ziosydP3iubYFTNL7zoDlGLvYAQ+ABCxXqKsdY3GAijC+47Y0z/VVfd/KOII
         RYFHyxu9dypvoSwtzN6CKJFDbBZw3F6xB/hlBRIawTnC0mk2qyEH2PDkSNGpw/JMRIEH
         xxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeHmYgHw7UI5yCAngCSiEUhj4Wa74RE1CCwgygy8rm4=;
        b=gavLux7ydBjZ6MTSTDTQ3rH34QiYeQok/rtL4kGhYsAn4P+Bzkk0RdieFb0lx5P5Ty
         hN7OIRWIstHnDkymrpEhwWYPVuFl2HXeKLxQ5x2n1J4hrTGeqVu4ClCS1QVcqYO1okRo
         oEPGYdkctUCjjAg6uU09zBoOUJ/Zz/ewC5lGPjhxVuHPllmHVrMqJCatJsH3ebx2H0Qi
         FuzeF2cBxpK+T/vH06/JWcHggjsOVCDqwI0O5eFiOqHXP8x5Bz4PNDCAzCzLXtChTefe
         0nEXWeT4s8LjGxgpIvvdS8Bz9opXU9YXmHX9WIA+o5ajJB6ifETRElLra0/RcOn4vcMI
         PlIA==
X-Gm-Message-State: AOAM531scc/zho3Cfi8D9OUIVVoKOf+UslF9Kst5fvpb8TQvMrCfmnGL
        AM9sIheki4hYMyv5R0hk0V7YyTqNwg4=
X-Google-Smtp-Source: ABdhPJyXjH4hPLIpfKvVdJ4/bOlIjQSDSsWNMQY6K42rX5wS3rLtQkNzOuesbWbZahpSG/HAPxWLCA==
X-Received: by 2002:a63:eb13:0:b0:382:1cd5:7d06 with SMTP id t19-20020a63eb13000000b003821cd57d06mr19040726pgh.280.1649496806465;
        Sat, 09 Apr 2022 02:33:26 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm23830684pgc.51.2022.04.09.02.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:26 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 08/13] bpf: Populate pairs of btf_id and destructor kfunc in btf
Date:   Sat,  9 Apr 2022 15:02:58 +0530
Message-Id: <20220409093303.499196-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; h=from:subject; bh=5b2+P5YwO4457lAKU+5emkQKpLhzD4O4e8iSQTv41ow=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0XuEFPX9mh1gBTnJGOWYWsf9gmqbm8fWa8iJh 9Cqn/h+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8RyoefEA C/wpm/LmyZUHpJaVHB3YoM4YLfrF4syWe/S4EaEW7lNOGRUt/+qHSGJpA1uo94lubPAupM2qWoZptv AEEP2J3rKxGefTKBvWvObFl9yMNyPtREhYn0ywrJYrkkaGZwYB1aCaGR//HWmmKAgZfwFfzbP2DqAd dAkP17REVkQsDWA4Jq91WYmBDG1iHi7tpk1hyKpBrkPzVKoxFC76D71Qbigh8Ws0ssS86RoUqQYNN5 rTkSyhikxwtfmkwTXPI8txHnvDbwLDJLTI2oHAqZsb8ym2sU9eT4eLcnF7NbTQ0RG5+Te12NIe3acI n8IoXyIg6am0MTI4EK6f9RBZS25gLj0iswDDS+NbaLUKlKzWzeI/fi5tMRTP3f3VACf5pMkgyCrAPo SJu3oZ0rlukDB/vGOLaAgXcx96EQvGWPJQRy7IMlPuL2s/ohcpg0R52WZSsaA+GuqlLSFg5CoMvGqD J2qIoq5YmHYw+6WiEk0Yv5H4NgrXKQuU/kbHQPOzU98Y4m8VEXeFpOrO7x4EL2HTIg4vcAHe7jo4Af 04ku8z6LNDYZQPODm8X2JvjDkM9Qh0n9XVdYQHRvZoFahFDC1yzc9Z10cPXmnXdlqqUP5sxXk9f1uN 8JCF//jEoeuAz35R259jHCriJgW1Dm1/kJ6A9CAZsvj4uYaUSaoQQf6Oc/3A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 43ea9ed5652e..8d7cdb8a6391 100644
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
@@ -7021,6 +7039,96 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
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

