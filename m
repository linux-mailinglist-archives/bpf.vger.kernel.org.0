Return-Path: <bpf+bounces-14316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D67E2DED
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E4DB20A9C
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF02E62C;
	Mon,  6 Nov 2023 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5EOTfRI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F12DF7D
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:08 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0E10FA
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:06 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7d9d357faso56896937b3.0
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301585; x=1699906385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIxgpYPb+01U3nw7xil8DaGgEzXfn5HrFTdRhQ2d06s=;
        b=M5EOTfRIxKFP9tdmZXhCnO3YLYJtfIKrb9buZ9pJ9ZmgogrP+Ug5rGWFe/yjl//MVd
         p3aGXZGsrYg2kbPCONjIM4YawOz1wjcdOTLq0oV/uTZUBDzm/zQ8OoIc5jk3L4ZQMLz+
         /SJuRXbkwEpx27PDZrVmAJPyI7JAiv2fcISlnWhCYzgxGvsCkSwGs1o33o/kuLU9Fx6z
         z533BNFfxO0hIWkGDLGA9vKjT6Z79oc0GLZORAKD33Ys8NQ5o7vXgyfn9NVc3lQgVJW7
         Uw6kNFv4v0UuoWJjSX05zhuUAVIcR4vBuCoz3MHLL0LILd0xZpHCUy/8aq7ETJ9Du8Oc
         EAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301585; x=1699906385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIxgpYPb+01U3nw7xil8DaGgEzXfn5HrFTdRhQ2d06s=;
        b=q8d5VsXZvJ0aVaLVgCzIzSQweW3+5kjYv4KWhHHDc6Oa1sazEGg9+JKEeYM+nlqRWG
         jUpE2y4Df9QSbePAYMqHRpkk+qlgP0WKXeZgr4Xa/Kmg6BG/2hAMSQYkbTrywP1mdiNE
         BIX5cEM5k9SJv9Un0F79FXdYobxypNmmdd8xUJMq79bPza05Hy1TNIPmch39YP+M1+p2
         HDyDHqZVdO13X+GVYzCQUl9l/+BOD0UMYeSLmglXpotubjLbb4RAs/lyDNaxKHXnNRYP
         wgSqDz7mpxeRQbtbVudnUzC0a2JmX8MCMijF0H6XFFjydAv2oF08PAtDruvXz6XstL+/
         y4gQ==
X-Gm-Message-State: AOJu0Yw6ZSseEqTQacKjz9eRx319ute/dor+CoFGoeYYYiAszsEWmKZ5
	LLf2LKrdhgrksRfYyySL2QoJAocRMsA=
X-Google-Smtp-Source: AGHT+IFQKNe1uCwyMxwwY9Re/cIiC6YtJF5xDkoEwm7/pYpiX0eilpl2La37hand91HnBY2F8rfGVA==
X-Received: by 2002:a81:8387:0:b0:5ad:c699:f21d with SMTP id t129-20020a818387000000b005adc699f21dmr12515360ywf.32.1699301584930;
        Mon, 06 Nov 2023 12:13:04 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:04 -0800 (PST)
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
Subject: [PATCH bpf-next v11 04/13] bpf: add struct_ops_tab to btf.
Date: Mon,  6 Nov 2023 12:12:43 -0800
Message-Id: <20231106201252.1568931-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
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
 include/linux/btf.h |  8 +++++
 kernel/bpf/btf.c    | 83 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index c2231c64d60b..07ee6740e06a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -572,4 +572,12 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+#ifdef CONFIG_BPF_JIT
+struct bpf_struct_ops_desc;
+
+const struct bpf_struct_ops_desc *
+btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
+
+#endif /* CONFIG_BPF_JIT */
+
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..263715af10cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -241,6 +241,14 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+#ifdef CONFIG_BPF_JIT
+struct btf_struct_ops_tab {
+	u32 cnt;
+	u32 capacity;
+	struct bpf_struct_ops_desc ops[];
+};
+#endif /* CONFIG_BPF_JIT */
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -258,6 +266,9 @@ struct btf {
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
+#ifdef CONFIG_BPF_JIT
+	struct btf_struct_ops_tab *struct_ops_tab;
+#endif /* CONFIG_BPF_JIT */
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1688,11 +1699,22 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 	btf->struct_meta_tab = NULL;
 }
 
+static void btf_free_struct_ops_tab(struct btf *btf)
+{
+#ifdef CONFIG_BPF_JIT
+	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+
+	kfree(tab);
+	btf->struct_ops_tab = NULL;
+#endif
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
@@ -8602,3 +8624,64 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
+
+#ifdef CONFIG_BPF_JIT
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
+#endif /* CONFIG_BPF_JIT */
-- 
2.34.1


