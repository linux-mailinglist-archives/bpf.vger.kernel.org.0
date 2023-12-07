Return-Path: <bpf+bounces-16962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E286A807DFE
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8ACAB211B2
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF311847;
	Thu,  7 Dec 2023 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7NM5dbk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D5D5E
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:11 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d226f51f71so1506387b3.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913210; x=1702518010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmACXT60MQXvHQSw2TSPD/2h/eubxhIjthBeSg/9uI0=;
        b=Z7NM5dbk90uNFZ5E+Sx7aOn2/6SHUOS0izD6BxuJcCVP9WI9uhZIokjcbcxzXET6o/
         hT5J/uxk2T9zPy+hR3mgNrqoZRbIVrY5WmiuVv59Q/wR6XN2lMWj5uW9aIEUftoNjD0Q
         nowA1JF/gibx6Q+v8AnaNpDSOlO2qusZt3Uq/zVL7Jxbpv7zq8T5nSai6jfGHCTZ0Whl
         xYX/6ZBg8Wtkdvp7kmxGi6i/qY9K3CnHHIB7pkoQ1wlomxVLvKBAOdtnYhTXIhnD18jD
         98fxL15jszYpDTIxkt8kzoULcx0Oun4/ZTmU1YCxxa5XThFupBGtstxEAoEGzdsHgoPU
         viZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913210; x=1702518010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmACXT60MQXvHQSw2TSPD/2h/eubxhIjthBeSg/9uI0=;
        b=Ja9TEB8yjNqv7j2HXLYjhikZO/xyTAoK0K7ldFk1KMXT2GuZIIEEfo2w7Occj6kFzX
         /6HZZYBfljjbCrKnNZSMtq9h8Mp4TB58wfNCgDSO1nyAItdR66rIbEcEgYTgOo0bsGmT
         EbSZw94BnavkwxUbeyNECt9zu5+O71ihZDGg7Rhi+VrdjDemzYXBPH1fqGR4VGhh6Eah
         FWXh+8NeI1ynskVkcLj9TLTvaiqknh0HetM8rhQOz1/WQSp1Hc4V7glDx3PYUNC6lKy+
         qU9Cd4y6ckYj1gTE70K4qY1ikwou3Pg1yKV+mtCgDbeSmLOFf8R/k6YDGqdJeJUu92t+
         JAmg==
X-Gm-Message-State: AOJu0Yw1MYKijN3ztUwnN6l8jhKe4IK3T4uuffE8lLMQo5H208yxDZUp
	ddd4vSIaQRTFqFdFLjKk6ivpfecalKk=
X-Google-Smtp-Source: AGHT+IFVv7GvzO7vHboHDX6Lt3AdaTpXcrIFvS3snX4sLMoFEuU4LmoNQoLe2pgm6zW/BELLZ8jx9w==
X-Received: by 2002:a81:4f87:0:b0:5d7:1940:dd85 with SMTP id d129-20020a814f87000000b005d71940dd85mr1850493ywb.91.1701913209730;
        Wed, 06 Dec 2023 17:40:09 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:09 -0800 (PST)
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
Subject: [PATCH bpf-next v12 04/14] bpf: add struct_ops_tab to btf.
Date: Wed,  6 Dec 2023 17:39:40 -0800
Message-Id: <20231207013950.1689269-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
 include/linux/btf.h |  5 ++++
 kernel/bpf/btf.c    | 73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1d852dad7473..e2f4b85cf82a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -584,4 +584,9 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+struct bpf_struct_ops_desc;
+
+const struct bpf_struct_ops_desc *
+btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6935a88ed190..edbe3cbf2dcc 100644
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
@@ -8604,3 +8620,60 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
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
-- 
2.34.1


