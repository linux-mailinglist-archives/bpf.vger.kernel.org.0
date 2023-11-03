Return-Path: <bpf+bounces-14174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E37E0C20
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9732BB214F9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44142628F;
	Fri,  3 Nov 2023 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXjt+DIK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6AE2628D
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:18 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A57B7
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:17 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5845213c583so1256765eaf.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053736; x=1699658536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIIeCc1rOs1H9z/uEp49mJo/wLlSpnpYqCNOsj+C9A8=;
        b=jXjt+DIKH1vsUhZICZ1YYHa7SSq+uJiOHz4+9aO3jS2719oP+44hUoCytIO8NVdDrl
         ZhTaaqeqAakYBo3iCbH3IPcLvNbtFlUc3nYIaAPfOopXkwwA3WwVTnIzmlOaWdTpDvrX
         rZjNUxYix0xYsy8TJpdavM6W8xDUXEkbmVpTPjvEfuHaep5WEGpJafGNwnqvVSDnu0Td
         ca8KAmDQOvBnvosoMfvCl0YwRe8zQR6mEfFKKW31t/oHE4DT4mxZO/94GylCkBwAsw0O
         lb6v7y1Za3HTNHR5eNYiELHAZSOIF4RRhKw+AuHemV+eMUYDSrSNLl1MmBANd5/XczUA
         /F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053736; x=1699658536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIIeCc1rOs1H9z/uEp49mJo/wLlSpnpYqCNOsj+C9A8=;
        b=HzTH2mPD3zDVgDMq4WF4Ic0g5IjFkjfZwMeF+siv8K0XODQJNS7PiXJ7Z7BZeqbrYu
         UaMmJOfwbkdbL4krHlv2orX092pHymvLRkWDHh/xo5MJmM1f2oqX4KOonVbb5UI6QvYS
         nLX0zg5GHvVzf8sxniykB1LeEdE5ToRnHk+IDAktdLzq7z+Oxs/5Dxk+UWUFzI7l+2ix
         xuQjrMTw1yQeJSptmSgKQw94EZTQfFX9pWlebvYL5/R3zWQtPhfSzXFXbGRasOsguaU4
         z7EcTZuFyhQIdGct3TyrWvGWnDQcVX3ThxadM0kb5Ks0MdOtvXhUkKzhddLH42yeDiEV
         BAqw==
X-Gm-Message-State: AOJu0YyuWzrqmepsyJ9sJyhWMigYinwYWYN84jZy1Q8l9n068sDFJ9Kw
	iAPBUE5gCZYwNARld7mlV/AEnUvxRgM=
X-Google-Smtp-Source: AGHT+IEphrjYmu/NBYjXUXC1j+EDos7dve4aB/qIm+claxg2ywXAkbMuEDjSRP06P4HCyf+ewbEhLQ==
X-Received: by 2002:a4a:bb09:0:b0:56e:466c:7393 with SMTP id f9-20020a4abb09000000b0056e466c7393mr21255551oop.5.1699053736049;
        Fri, 03 Nov 2023 16:22:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v10 04/13] bpf: add struct_ops_tab to btf.
Date: Fri,  3 Nov 2023 16:21:53 -0700
Message-Id: <20231103232202.3664407-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
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
 include/linux/btf.h |  5 +++
 kernel/bpf/btf.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c2231c64d60b..e613b6b45dc4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -572,4 +572,9 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+struct bpf_struct_ops_desc;
+
+const struct bpf_struct_ops_desc *
+btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..2fd6fa0ea1f4 100644
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
@@ -8602,3 +8618,61 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
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
+
+const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
+{
+	if (!btf)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	*ret_cnt = btf->struct_ops_tab->cnt;
+	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
+}
+
-- 
2.34.1


