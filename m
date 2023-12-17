Return-Path: <bpf+bounces-18117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A8815E05
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F7283B9E
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C902114;
	Sun, 17 Dec 2023 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTNT8z0/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FE1FC2
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77f70206016so200406185a.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800706; x=1703405506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvmt8YREIApGjYxNLedkB7FdNs8C41Y06GXdrYdOM18=;
        b=BTNT8z0/8aWPZsqlBa1Wje0NYqmBXvjTNH5I7Tr1w9l/VNy1kr9oiMiaoriZ1W0vQl
         KJdW/AnrK2HRMTueXjLU6YY/VBbJBSo41p4U+vvM9TLFDLpnvd4nf5sowsm2Y7kh0wiS
         2Igkf+BXSPojoN5b97YVjG81ZVL7ZdXJr85bUFhwi52w85oueQNB8n0JG7Q0W/RCe4ll
         wQk5vE3P/fjkoF8/yLjYK90CnUKTk54sFne1U4eypTILxPq48O+shUMzV/xnb+WTn9jV
         rJF+3Cue+axujjSu8j4BWV7Nh76cYoaNVYIPDCRNN0mSWYcP+vbSyq72lcuMzBAgP5M5
         WjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800706; x=1703405506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvmt8YREIApGjYxNLedkB7FdNs8C41Y06GXdrYdOM18=;
        b=pI8lGhWvHfUX8A3poL8PIRkNBsYsgELTbN/ZynD9sjcA0t0fM1WQ/Zaub8MwIh3QZ0
         afM9gZCt+Cr/d+eQSJ6Q9VU5fd3lvgEYrEcvc2jMC9Socmu0Z2CTKC2uyzIxNmI24hFi
         cvn+kHUMTLoJS0ADyCPDpVMUVKAQJphpyWBhllZS+QPRRQQib2IF+Ngx5OOb2o3zS8r+
         Gs70erpLyxPlwW2Ie420rJ7LNdOH/+buA29otTtShQQ4JyIq8G6XDVuKt42EACkLEcYM
         aQyA+Vfp8zqgl+Qmpz9OmHL0fgn+AmDlMPDzM6pysnPqGSAmhLQ/SgD3tHFJGKP2Ndm6
         vKxg==
X-Gm-Message-State: AOJu0YzQTb+X89ii97fjURVkkCkNL0RE3nvZdVTJMXYRc5owPMcmWdN6
	FBE5syI7yStP4fQ/J9FCJqPEze71KEs=
X-Google-Smtp-Source: AGHT+IFVoodO0oFn0RBIuQVrYQBLLCN3LGCLYw4Rc4L1WWmeUDE+atstaQ6nH/+DrGAUJP74aM1Y9g==
X-Received: by 2002:a05:620a:229:b0:77f:b905:312c with SMTP id u9-20020a05620a022900b0077fb905312cmr3566270qkm.137.1702800706536;
        Sun, 17 Dec 2023 00:11:46 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:46 -0800 (PST)
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
Subject: [PATCH bpf-next v14 04/14] bpf: add struct_ops_tab to btf.
Date: Sun, 17 Dec 2023 00:11:21 -0800
Message-Id: <20231217081132.1025020-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
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
index 46bf3a6f4bb0..2ce2c3fd477e 100644
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
@@ -8597,3 +8613,49 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
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


