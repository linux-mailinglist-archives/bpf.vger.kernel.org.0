Return-Path: <bpf+bounces-10461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AFF7A8921
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CD71C209DD
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4D3C6BE;
	Wed, 20 Sep 2023 16:00:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE73C6AD
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:15 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17727CA
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:11 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c26aa19b7so50783407b3.2
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225609; x=1695830409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtJbohVhk0WyNbN/Q1S7T79++xtb34kxXnJ3o+TzdA4=;
        b=My9pQMK1CsdvwHBlmOWq54mX6Ll9D4tr32Xc/o2J1gJv8XGpZNHTz3pGsw8fKkc444
         /p7wmK0UdU3Bzx586bNnT0/G72/mkiM+H6N5qPwsPXI+/6lCfUn+F64vcnixwvzz+xyT
         qZOCK983JUqS3GvwvmQK/tG7lHIzErh1UpAW7i7JA96GYW1UVHGi0q4R1VyLdw8teSFl
         XSWoMOkJ33pksJ0ZLyskZfpzWJIBE8sdhCLcl5ctvupdbW91a+rlXPptn+x1Gcc5GLfX
         /DgI+AN9EWCPRPMkZl3Gwdj5h1yiHsbtv8vwrA055LWXlH2URM/WSQz57Uay+Xo0Xpqe
         giJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225609; x=1695830409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtJbohVhk0WyNbN/Q1S7T79++xtb34kxXnJ3o+TzdA4=;
        b=LiLscOvR0aF9hmgfEnZMvH4jSc4rFOnqVavpRx67uqc+nW5dm7xP5/wu6MEaSfXxCH
         hLXXhqB/UyzfNxqv+TgXXaF8mAnFJtB8v0/JSeX1N2Ezk/raj+SPBzheCyZwp7FpelsJ
         wjd98BvuEwZBqegEBznr/SUgUawFLavUEFTnePNK0j9XRGlF1E8f5mM8WZKLnE67AjNY
         QJNoW8q5J6FbP1zvjS70+9bHVq9UppXcObVcmCWDjdvsIaAdpXhJatuJAaJzjSQs+cHk
         HJUzpXe0ep9UFgUCKYQ7aRMvC1XT8kA3n2lsywvXni6/L7t/gdJg5O1t7wjG0/EAMEU3
         HnzA==
X-Gm-Message-State: AOJu0YxeDjA9Qacu7GVYxuIJ/Aqfsfhpe/auQcVuXvNQifeHEljZXUpm
	dX1xRJHCuxaxaV2vM6YTksJxM3PFKl8=
X-Google-Smtp-Source: AGHT+IGMyJHEK3oX/82m9WGknhe3i9Bl65/DLEuWdl2+M5ys76AIsEzdepw/AT6qhXvN8Gdo9d1hVA==
X-Received: by 2002:a81:7bd5:0:b0:586:9f6c:4215 with SMTP id w204-20020a817bd5000000b005869f6c4215mr2929590ywc.33.1695225609233;
        Wed, 20 Sep 2023 09:00:09 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:08 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 02/11] bpf: add struct_ops_tab to btf.
Date: Wed, 20 Sep 2023 08:59:14 -0700
Message-Id: <20230920155923.151136-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

struct_ops_tab will be used to restore registered struct_ops.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/btf.h |  9 +++++
 kernel/bpf/btf.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 928113a80a95..5fabe23aedd2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -571,4 +571,13 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+struct bpf_struct_ops;
+
+int btf_add_struct_ops_btf(struct bpf_struct_ops *st_ops,
+			   struct btf *btf);
+int btf_add_struct_ops(struct bpf_struct_ops *st_ops,
+		       struct module *owner);
+const struct bpf_struct_ops **
+btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f93e835d90af..3fb9964f8672 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -241,6 +241,12 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+struct btf_struct_ops_tab {
+	u32 cnt;
+	u32 capacity;
+	struct bpf_struct_ops *ops[];
+};
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -258,6 +264,7 @@ struct btf {
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
+	struct btf_struct_ops_tab *struct_ops_tab;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1688,11 +1695,20 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 	btf->struct_meta_tab = NULL;
 }
 
+static void btf_free_struct_ops_tab(struct btf *btf)
+{
+	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+
+	kfree(tab);
+	btf->struct_ops_tab = NULL;
+}
+
 static void btf_free(struct btf *btf)
 {
 	btf_free_struct_meta_tab(btf);
 	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
+	btf_free_struct_ops_tab(btf);
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
@@ -8601,3 +8617,71 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
+
+int btf_add_struct_ops_btf(struct bpf_struct_ops *st_ops, struct btf *btf)
+{
+	struct btf_struct_ops_tab *tab;
+	int i;
+
+	/* Assume this function is called for a module when the module is
+	 * loading.
+	 */
+
+	tab = btf->struct_ops_tab;
+	if (!tab) {
+		tab = kzalloc(sizeof(*tab) +
+			      sizeof(struct bpf_struct_ops *) * 4,
+			      GFP_KERNEL);
+		if (!tab)
+			return -ENOMEM;
+		tab->capacity = 4;
+		btf->struct_ops_tab = tab;
+	}
+
+	for (i = 0; i < tab->cnt; i++)
+		if (tab->ops[i] == st_ops)
+			return -EEXIST;
+
+	if (tab->cnt == tab->capacity) {
+		struct btf_struct_ops_tab *new_tab;
+
+		new_tab = krealloc(tab, sizeof(*tab) +
+				   sizeof(struct bpf_struct_ops *) *
+				   tab->capacity * 2, GFP_KERNEL);
+		if (!new_tab)
+			return -ENOMEM;
+		tab = new_tab;
+		tab->capacity *= 2;
+		btf->struct_ops_tab = tab;
+	}
+
+	btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++] = st_ops;
+
+	return 0;
+}
+
+int btf_add_struct_ops(struct bpf_struct_ops *st_ops, struct module *owner)
+{
+	struct btf *btf = btf_get_module_btf(owner);
+	int ret;
+
+	if (!btf)
+		return -ENOENT;
+
+	ret = btf_add_struct_ops_btf(st_ops, btf);
+
+	btf_put(btf);
+
+	return ret;
+}
+
+const struct bpf_struct_ops **btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
+{
+	if (!btf)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	*ret_cnt = btf->struct_ops_tab->cnt;
+	return (const struct bpf_struct_ops **)btf->struct_ops_tab->ops;
+}
-- 
2.34.1


