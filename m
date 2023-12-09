Return-Path: <bpf+bounces-17282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6480B0F6
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48311F2140B
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AEB136C;
	Sat,  9 Dec 2023 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoApqesh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB571986
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:18 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d400779f16so19673967b3.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081637; x=1702686437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmACXT60MQXvHQSw2TSPD/2h/eubxhIjthBeSg/9uI0=;
        b=aoApqeshkYMfzEgU/df6Ryv6AZ9Q2bKrrqOXb+4Z4qtCGxXD37AAOroadvY1ieY9Oh
         RULkyaY93gAyAToTBdXM0g2BA5i/MErK3SRjhMYOvw3PDCWlOa9aM8Dvf6Crvjf4YJps
         AmBD/R2S+1QyPGkvwZL8M2pdv7rpxX8g7TkSokYbCxe8jVYlWWh+D+AGar0LxJOF0UXp
         Ow7Un8qMqTUPYi/+ukss2BoRMHXZk1epB5KdWL1rKxd5YPMWpfbGNVPCS2bHeP+ti0yG
         qnGaL7vV18Apw2GCWPefoUd8RLHg0ElpkNbbWseU5RerUappIPHmJb3EHhZLMCU8lrtg
         D5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081637; x=1702686437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmACXT60MQXvHQSw2TSPD/2h/eubxhIjthBeSg/9uI0=;
        b=ahdCBX72wfbnbbhjkIU7FxC1u2UgmQyzHoH5yq6kLTu2nugozrjGp3+LL56lQPejqE
         U4dPaTub6+8u/g9jrTpbgCIcqBD3j7gwWzyET7FAp7giWY9J3mXcTSfB9yYnDntFzUlI
         zn5r69qHupo1LUOKomlpDUKbxdSD8QSBJIXsgSq6O6j7dFUjWeOn7yxv8j+dPd/LYnpv
         EG7ZZ5u2JzZ2E7yVo/l8AbAYJqyrWACXp8ah2Fxk0NWZzUfyhBp3ycDHYJFaM0ebtvE1
         Qv6v2Ad38ZQDbyiQINOZb9tv5iq4RQff8IlTD2GNXA6U4I0y7CB258qLWw2yFGIfZXex
         9Bhg==
X-Gm-Message-State: AOJu0YyAI6tPwdoxvKV4WGHl2D3T6IFtxScKrbOsRSuMbkQMa01XJjs1
	PIkqiFMfEiiRlMmS76hR3xJ0ezUOsiy9nQ==
X-Google-Smtp-Source: AGHT+IEn9A2hV7jbiR4E5EH/4wKcveeCwE/1udKMgePHYFwHCjvYQiWUTvIfC1jGwlU0OOuMuxz+tQ==
X-Received: by 2002:a81:d50e:0:b0:5cd:ef57:ce3a with SMTP id i14-20020a81d50e000000b005cdef57ce3amr943023ywj.0.1702081637169;
        Fri, 08 Dec 2023 16:27:17 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:16 -0800 (PST)
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
Subject: [PATCH bpf-next v13 04/14] bpf: add struct_ops_tab to btf.
Date: Fri,  8 Dec 2023 16:26:59 -0800
Message-Id: <20231209002709.535966-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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


