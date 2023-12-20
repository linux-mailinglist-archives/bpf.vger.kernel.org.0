Return-Path: <bpf+bounces-18445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4261B81A927
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65981F23C90
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A74BA86;
	Wed, 20 Dec 2023 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfm6T3bG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED894AF64
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5cbcfdeaff3so2317667b3.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111222; x=1703716022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fe4Cc6sFReNUBcJKDRt3tmmSRTHio7j2z7H1Z+m2ik=;
        b=Hfm6T3bGttKb6PzXsuv9RiS1fjhcKQS7tE+WeFhOAc1QCR4zdUaa2VrhvtN2fWBeuv
         UWcMJLwGz9OUBpXygY7VEm2wHMgzW9hnDJJ4yQPZFmbHLiZLQU0lfi4n+szBHuBrfK7/
         U+c/LTh3wFGzb1OrqE+nqamNKaQB1onnCzuJKuE29Ue6twtETmhMoSeqFHlVh8Hs/vvy
         HYAGQL64QDdlICwG9wR4wKQPGEKtuwvpgUQpNglKC3lT3Y9ZrhSr1c7LXadEtzzEUx8N
         7j3oBM13/ANshpSXUJqSh8x0CWBtdymZYbugGO5ZUeSA0XkMx3jSFcaREQARTYVPR0t1
         MV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111222; x=1703716022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fe4Cc6sFReNUBcJKDRt3tmmSRTHio7j2z7H1Z+m2ik=;
        b=iGXsWKiBuRD2Ew9AzZej0PXt5+Q3+WXiZEf3AnT8F07dDaHVu0Paze/UiVKUom8shG
         wknH4HB5mWJe+ntXhvmRwca4TTa/G3p3uEGoe6KijNQhdL5AMS2PVX+yzqOHtEycUFKD
         dvt6kBr0dzLBpGNxIU3C7/dphERJC2At/RW6XgBdVewQhDNp2f+HmKmYOuQCG+zEeW52
         TL92bGX6oMdZ0MZMinv9fnWis68NmV0B9v8awob85OUcdKGsZYNaNUBn8Jspx6gt/frx
         +j4+hdPGsXpI+9oCp8zHLn+XPZ6TfXavOaLdl7hBAtYD332ksGR6DfO2Prn7HS9RdYWT
         f31w==
X-Gm-Message-State: AOJu0YzcW4z/eqJ2heM6iUH9jpgCHTkWI/7NGTeqc6+WEMYU8jniREU1
	CUP2WeAoNzlCXsKq45P3YbUMSQUu9fk=
X-Google-Smtp-Source: AGHT+IGkh2z5uex6uUYF/jSZgYBzYPzYi6xOF6+uVvZmN6RPWmsGEKrgiYwe9D739dey3U6U6cZuQw==
X-Received: by 2002:a81:484f:0:b0:5e8:c249:2b39 with SMTP id v76-20020a81484f000000b005e8c2492b39mr451121ywa.11.1703111222390;
        Wed, 20 Dec 2023 14:27:02 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:27:02 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v15 04/14] bpf: add struct_ops_tab to btf.
Date: Wed, 20 Dec 2023 14:26:44 -0800
Message-Id: <20231220222654.1435895-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220222654.1435895-1-thinker.li@gmail.com>
References: <20231220222654.1435895-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Maintain a registry of registered struct_ops types in the per-btf (module)
struct_ops_tab. This registry allows for easy lookup of struct_ops types
that are registered by a specific module.

It is a preparation work for supporting kernel module struct_ops in a
latter patch. Each struct_ops will be registered under its own kernel
module btf and will be stored in the newly added btf->struct_ops_tab. The
bpf verifier and bpf syscall (e.g. prog and map cmd) can find the
struct_ops and its btf type/size/id... information from
btf->struct_ops_tab.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 62 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1d852dad7473..a68604904f4e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -584,4 +584,6 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+struct bpf_struct_ops_desc;
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1f94c250ab49..3fa84c44b882 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -241,6 +241,12 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+struct btf_struct_ops_tab {
+	u32 cnt;
+	u32 capacity;
+	struct bpf_struct_ops_desc ops[];
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
@@ -8471,3 +8487,49 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
+
+static int
+btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
+{
+	struct btf_struct_ops_tab *tab, *new_tab;
+	int i;
+
+	if (!btf)
+		return -ENOENT;
+
+	/* Assume this function is called for a module when the module is
+	 * loading.
+	 */
+
+	tab = btf->struct_ops_tab;
+	if (!tab) {
+		tab = kzalloc(offsetof(struct btf_struct_ops_tab, ops[4]),
+			      GFP_KERNEL);
+		if (!tab)
+			return -ENOMEM;
+		tab->capacity = 4;
+		btf->struct_ops_tab = tab;
+	}
+
+	for (i = 0; i < tab->cnt; i++)
+		if (tab->ops[i].st_ops == st_ops)
+			return -EEXIST;
+
+	if (tab->cnt == tab->capacity) {
+		new_tab = krealloc(tab,
+				   offsetof(struct btf_struct_ops_tab,
+					    ops[tab->capacity * 2]),
+				   GFP_KERNEL);
+		if (!new_tab)
+			return -ENOMEM;
+		tab = new_tab;
+		tab->capacity *= 2;
+		btf->struct_ops_tab = tab;
+	}
+
+	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
+
+	btf->struct_ops_tab->cnt++;
+
+	return 0;
+}
-- 
2.34.1


