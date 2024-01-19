Return-Path: <bpf+bounces-19924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E52B8330EF
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A279F1C21AC4
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F45A7A5;
	Fri, 19 Jan 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzWHW39B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477659150
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704631; cv=none; b=aO3OYSZfTbS3r7Nx5Vpi5dmmx4PZAZwIlpDaeRdhQE2gbhUWpjCnczDONrF4htQg5CyCjaVovbMdJidBa43NEaVAMgAxCu7lTXlKirf7eceAOB+tKQwF1r4bAQCKpFGOJRiTYukpwO2SC3SKR3J6VUOB14SrXsNXe214wBHTk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704631; c=relaxed/simple;
	bh=AgZkhVWjpECPzFoPKqf7EVYE5BkEGNMNRg48vCjwiXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=on0yzWOHmhkqMiNytOtvh2Kv8veermbiD5C1Ima6nhhXwhkOyAUP5WZGditOmcxCsCeZoGPoiZFSg3fbHabAHiH9DL/9EzRuP6shQp0cOhzZLPAj0B31jqjwOJztl7fn/b+8u9nSLQZc6x2Ley8bQwdmrdBWF2zjqDDnBXCQ8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzWHW39B; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff9adbf216so11750017b3.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704629; x=1706309429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgB85CgIeEILzSLSx73mMYa9L9xD1my1Sm7yUVV6Nxk=;
        b=bzWHW39BSXPnyGdKADLl80m+pN4HKAv7Nbn08q8xq4mM5PWP1NdW0ereEqhKO9S+vR
         patJh9uPfBLvrpJ4Zowm07t0jLauZ3CfuOg0kxqeY8KIw8RPlZmhNy+cmoLrzQwMQxed
         w2iVKQKRS7z6edGobNPW+8WY9k4969e76H5RvCgQTTgTNvvoH2SA7sBy0mDyQJRWViVh
         DVA5tw8HKjn+KXxB+NZiI5VyPjLr+vPbSzqihjEQA/07f2r+TOd/VAJnVsrw0tByAAqf
         EMGz+ZB9RVAfDxg3Cw1778rdwwO++07Eh0BnXsgBTKYljDpd5Pr5YzjZSyUtprMqkJh2
         MyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704629; x=1706309429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgB85CgIeEILzSLSx73mMYa9L9xD1my1Sm7yUVV6Nxk=;
        b=an61htSXwAjOnJnnWlnWBXjEls8YObZJ6TwFMxlJW6RA6pbEWp69vGt1Xq2G+Ed+tQ
         fRdiy4QAuSefu4o1iOYaTNLS77LNt63W38HcDcIRdb/WiAmBB/TSETa2TnLk8aVfiP31
         ydnrbpkA0WagMvEi7pHYpyciKS57IFQDuhsz5dbrhYzNoafJ5XhXq3qEY7lsGnZebbuq
         n8GdJhpGIt4K7jHGK2VhnOFrDosRw5W1C1/NeFdilmAXQuYrThCgpNLLKXJIQfwZuuDa
         1hd8WI5JSim9oFPt8AEKNja1dNctkUYTB47r+YfRwMRhTt8/p3/OxahIT8Zw/36Zh5E/
         yNNA==
X-Gm-Message-State: AOJu0Yx9JZys9LYITjMITAiNBQtd3Iasj3m6oqZEtmviNRORokbXbSva
	Ckkxb4uY/Z0j2GJdDWsN9PHBPV61tkYlMN8Y7XSeRNfSAMgpJ4M1qt3GLnse
X-Google-Smtp-Source: AGHT+IFCMHQcqQG7ZA/JjjSYutu9ekoakzQmNVHP7E3YvQW7/Pmh9oGWr100+/NdTDHDTM8IUgiedg==
X-Received: by 2002:a81:5d06:0:b0:5f6:b43:f492 with SMTP id r6-20020a815d06000000b005f60b43f492mr550968ywb.93.1705704628972;
        Fri, 19 Jan 2024 14:50:28 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:28 -0800 (PST)
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
Subject: [PATCH bpf-next v17 04/14] bpf: add struct_ops_tab to btf.
Date: Fri, 19 Jan 2024 14:49:55 -0800
Message-Id: <20240119225005.668602-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
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
 kernel/bpf/btf.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

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


