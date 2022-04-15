Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166E502D74
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355700AbiDOQHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355698AbiDOQHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:07:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206762DEC
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 22so1184509pfu.1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=su6frkfYQmMnwSil0Ek9irDFEukCs+JLVPc1VjrYxVk=;
        b=arkNqOR/L0W699OVg1GYWEa0VKftysY4qeogbN/0qBrbOXKHxvBtul6qHwuRg83aqh
         yAwRCaVB3yjrvFDMHm3X8jG3j+if6FTBsXjpRfJteXtw6LejULcWoZ3Jjx/3kCqprSOy
         cBaSv7tU3wAgEf72pPLKJG23WEUObt+JTQP0GEdJfv+XtYdd29WY0mSsj/vly6KOafeM
         Mr3NScMwa8+oE2J39CLsLFAdtgxjVCv3rH6/NhclcplC4AJiXws2tZ+xfPOiOjrrfuCV
         TEeZqJgMimVAF4UP3nLKAuDKZibLhAqANDgcWdJ13pAhT8hyxiVBJG3CS4lcJSCRQtcj
         kG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=su6frkfYQmMnwSil0Ek9irDFEukCs+JLVPc1VjrYxVk=;
        b=VRrDrsqUrLeFifyYqgm0h6G6V7zzDHmwUWBtVuihdM9nDygVbDMQMx6qhH9zvorjJF
         9SWqQngY9SBssjpiCC20LYsuSZtPdgSkaPYQFVzFrx1+LAAACVokENzE92dYgPl9QKQ4
         cqVMhUL+44ELcKzEa/ORA2tKWFExsSPsnGnAQHL5YYac23j6j6arzCkEWSnvo7mEVFjP
         wQVLNGjSnVBUP0IRc/3is0sBaRgjjKPKhFNY8O1Rlbqa2oEfakt8KEwDyazMBgVBdXp8
         c6kY1wMawQpLPrS2mCQxKMTsjfNnYismvkXxGu0RCiUJysC/woy2bhGLqfCnbxnkWNos
         ow9w==
X-Gm-Message-State: AOAM531F6GlhCjGZFN9t5OK7ciRD/nBUxKjpagoRmD4/qxc9mGSbNns0
        ui7W9lJLgYTRTJJR/DFLWSPHpKYvOkw=
X-Google-Smtp-Source: ABdhPJxZypLpnXpCJDTGBKa7RGYOfAvSVckM9rwSuxgOVu5VYa/uJQ/Q6V1YAqFzheIwF0xkt1xQ3g==
X-Received: by 2002:aa7:8888:0:b0:505:a3e1:d246 with SMTP id z8-20020aa78888000000b00505a3e1d246mr9544686pfe.76.1650038673434;
        Fri, 15 Apr 2022 09:04:33 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id s11-20020a6550cb000000b0039daee7ed0fsm4671216pgp.19.2022.04.15.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:33 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 08/13] bpf: Populate pairs of btf_id and destructor kfunc in btf
Date:   Fri, 15 Apr 2022 21:33:49 +0530
Message-Id: <20220415160354.1050687-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; h=from:subject; bh=ZDCM33jHBDII/op1q9toFIb9RgeIMaK1eXOC/DI6rWQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdCJYdHyQmFmaevGVbOPzWUvwvhRWSOibn4T3bL k2ulJn2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQgAKCRBM4MiGSL8RyoMTD/ 9D4B4pmpYwRP+qARc2RmVBp7Q5lxxI2QsjZ7qbFmTwnzAhxTqmAiUHVj/m2jXtn9Vj/rTIRGQSjf+/ IaJTFblD6b0x1xJWPN9V5FpnmmGiCJcV/JIS5hkTUEkx/WNqd4sQjpwAjVYAEEz6EOeCDCfBGa7zXe 7/pMAe4wOwJ7rioLx3vMu+JFyqAuEcNz8LGmqu2grsPpud7Ztc7Q5gT1WcQU5P7kt7zCZWhSxDPwQd YHUTg5teNy/P1YqNiDjYfmMN3dfX5UT5hNcldUt9yf1D4h99DEue8zoUXky9jpmI+vN8PZ2sMscjOR NiTpezdlt4Nq5IH+E3Br8velmekn6bbRTqiLE7l0SYOvEKAs9AujR/w5ajh8rVBsdJiJsYP91W+Y50 zcRd4ddtMgJzDXjqh84+/bPqPT8gFI0qALB72WUNF+4frjsrNonMGDsUK/3QDGeSBVUEFY/yVCKEOh yWBJGkD+1/736WoLdsgM94TN5r81mwJr1c4iCJ+mryaEjYWN9i/BBlY2Od4MEDQJUCtBqxXsIKrTc3 sN4BEb2y9HCa4HGI4YfZL9NcLQ11iTkD4ca8sqodyS0cRCSHbZcK7C+zYiQLM9gcfJemx2NKpvBuxv dtuZdSwe/eyfXzlNPXb+JV+0Rd0wkg/HnCtsmhdB12c08VV75kTgc6Bzt2Rg==
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
index 0c5559157c77..fdb4d4971a2a 100644
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
@@ -7024,6 +7042,96 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
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

