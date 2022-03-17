Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FB4DC55E
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiCQMCG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCQMCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:02:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF78182DB6
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so2946673pjb.1
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjngzZSJ1NJj0Uuwv7x/SiLTjkcymSmxCdtUb26fsI8=;
        b=lUmzOWyPMJdnyV6r2KFsoTdkjYzCl9HPzEenHT+Sb61ekI1Zv8Dg65khlMNyIakdCC
         nTg3XwrR0kmjrWdc3EiGr/4StjBROp1iPnFGKJjF8AT9H/M5aQ//bTqeG8fe1kWomUu9
         pH8OimeDsn/PT/FEYLaFpR/Fi6YeRrTxWDevVLny4HpqGnBVbL6kNFptNy+XNRYyl6N+
         ClE/fY1rzD5oCCDRxQFJuJKeOr2YkyAhbzKN0CIGnDOK4e9Nx6UhWH6Vx6x9boRAzcRq
         QhJMm1W0fIL2xLbULp9rGzdonPBXJN9uqur2psw4Lx8tVKu0ycQs19JSKcE0lt56dDNk
         m8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjngzZSJ1NJj0Uuwv7x/SiLTjkcymSmxCdtUb26fsI8=;
        b=CP2FiiHkkC9mbLFJr7hzNwfpdd/CiEeQSXReAbHUG0B+rCAQR+vzxHr0BbC4zuFjsi
         UzAgVev0ezl/aydzR7F5h0DMVWgh65v+cIHvEc/W5p/xD2uFxQYGHG+kQ+ddUUiOymdi
         gVl8iIErbMsAL+9GUPC5dQmYlaA6JN25J46ZUbsSRNvpsia/A4E8gxMaYhGV6oOtNeqK
         9oUZ5bnQi2W3ZM1WTzmYri1qlfEKHyfDuWjsTkOSVrQsaBD9cUhjIfkShgMLyfoDl2qh
         fHth3aQFO4So8cSypfTSOXptJTr8y7cW68RdsYJlHGAGwVPzzyxwo82nAsy+kr8m1iwf
         /KLg==
X-Gm-Message-State: AOAM5335LrFvY7sSQ6JnHlavEUlqVcu42PGMf0nkhAj6PQA403+nU9Q4
        ZI64lWEyFKd1G5BozLCKCTVZoKPhZCA=
X-Google-Smtp-Source: ABdhPJzV//r34TrcxHekeq+iZWoGouVLfCWtZqfTYtpONvQd4zSJFVjOyBKh9QvzKppMoHqpEFp7QA==
X-Received: by 2002:a17:90b:3909:b0:1c6:4909:1925 with SMTP id ob9-20020a17090b390900b001c649091925mr12555013pjb.202.1647518446951;
        Thu, 17 Mar 2022 05:00:46 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id a32-20020a631a20000000b003756899829csm5143457pga.58.2022.03.17.05.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:46 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 10/15] bpf: Populate pairs of btf_id and destructor kfunc in btf
Date:   Thu, 17 Mar 2022 17:29:52 +0530
Message-Id: <20220317115957.3193097-11-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; h=from:subject; bh=l6wYToCRPrkg6N43IEvVCSaFD2efxBOEmEbLYsDq94A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjSPIYGjR78WYCjZEE6MOsfAKPQ4Lja24Cc1Q+ gNY7hzSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RypjQD/ 9FeOD5gmryHIw+K2xemnHQgAvtlJYQSfMQeYEjD7A3kZsgVmF2BOQnmmRqo2TKBmDXBlGBDx4LJASB vLGPF9rsqjzlLSlO8fFmnTv87Pobbnm9Y3AHO4sntdCFZcAlMnVv3VFVCnYXN2Hpl1eqiDCXHuTFmo LB9DwvMqigCTUTaakbVMShcEoCVFQQK0I7+FoMqSe4X/sraEjjhOKMQEU3noG5MoZzVrG2kZKU2KXQ k9WbeAQWEGTsLODul8x/FTvnB5sc2vDafR9s+9hHT1Pbtqw76w007TbZX1jpo30DDsgwstfzkUDHYB CyyMIwMOBFXu9YjsZNldvJR66uXzfrHFe3w0glincowwJ0qw/2Yex+Lectetj05rkYkrAO2LAujK7W FBd1Eiy1SLEV9d7YUaEuOuTTs9cseyO05efrtD7acXSc5T8WBOMnjhzTlc7jbjai8RKvCowTj71W3g AyaGi7cFn+n8uZjDVO4doiTaOCnK0GnyPQqhJ2JgcUr7tjojaGj5vZK1fbi7cMvMc9JmRrrGtrqRfC XQc/H8Jr2EWP35JwQgeHbovW1RuLaEL/1L1NN4cjb3Wnlld7v6TK6CpNXDYV9pTNiW6CZlGZVNgoty SMmamMgE58W6IJxBx2FTqy4IUlKCY2FHCMorpZPgdsPx1+zC2wGgN2anTBYw==
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
index 5b578dc81c04..ff4be49b7a26 100644
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
index 2e51b391b684..275db109a470 100644
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
@@ -1614,8 +1621,19 @@ static void btf_free_kfunc_set_tab(struct btf *btf)
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
@@ -7026,6 +7044,96 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
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

