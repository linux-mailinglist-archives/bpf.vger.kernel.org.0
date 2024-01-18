Return-Path: <bpf+bounces-19777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483C83110A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484DF1C21E91
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF0568B;
	Thu, 18 Jan 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi/ivfIN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534128FD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542595; cv=none; b=YS7mpb/EtoWLnSh0C7xoVjoX35TLUjrw4IQTl0QoueehOcdUGGlWxtAICyywkb7DJtgpjZZUOmmnJEF4FlRdFzcaO9NNnfNTWiuBTh6hU/7QTAl4Ss/cJuBIbKq3B5rfpjd8v0qTdyjHcOr5kHleHyBe1Wk/xDsrIGRQP6RbJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542595; c=relaxed/simple;
	bh=YRIGwvZW7MeY7BnLmba86/sxXf/RVcO9TPOGwErh2E0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=TIAVubnh7d0VpaREyDiWNuRpstwvxqUN/vbYoxnHKs36UgTFnkYrHGZfsm9uFrWZ7XdrCNi1i+L5YwTgez5uWleGzgL9UlSFZJMwGUYSE/skHtblxUo/aMOb9d3i6Yh7uy9EbH0yGXizoEp7cjdWG8gJcSkvxSaVQMI+Wya9YIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi/ivfIN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e734251f48so2284697b3.1
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542593; x=1706147393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fe4Cc6sFReNUBcJKDRt3tmmSRTHio7j2z7H1Z+m2ik=;
        b=Fi/ivfINa0/+l5QQ4KP51MNITHsgT4e9dAVJz8JrS9QhluPfA+VG7t0G03isEh4Ja3
         taA6aUxGuheOAkx6EeFsKlVESQviENNEpDiibBh7f1BALGmuoVrG1bInwKiBb+C16IqC
         HFvmbCnuA9heDh12IrKv3wbtbQGzaEiztxhzi1T3uBwnHPQ4GCCfX+kihFsC73eLkfQh
         0UTkVZ3jTK0fVMZr+CzNjnG8IiZd07/qyQcSzUFHvnZhY67Q5HFBqNFew+5IAMCIgXMX
         ML+dqdhH17msiMUlG7qVDgMKe8dQZGGqIPf61hfTcy4WcavGu2o7ypW7/MhwkL3/Cs8O
         Bv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542593; x=1706147393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fe4Cc6sFReNUBcJKDRt3tmmSRTHio7j2z7H1Z+m2ik=;
        b=f0mGXS9WssGRQRgOMD+03XHfDgis50zjNsSa9S2hFI8t1GJvl5Rww+wNsntBkZrw7I
         cXze3bV50Q+gSoqoFgbTG/4DYPVtkL2vpr/z24ZsK88HWs1flBs1+zr0r50eCI3RraRJ
         8fZ353Y8V2DFLWQWt7HjsGcmfOcC5auUZzaJz9QaBPKLWeQJGw3gy3bBqiLIZgdjywNU
         vBrb4yFws+cPjz8DGtGE6IQYb4lTF4dVMtu4dkto8p2J59M7ikKn9uAlIO6MDjiiTOGo
         reiYT5Ni3gryRHz2eOtdrxPYn5725p4daWbYc2Z4n7sC3twKdxdwevWOBakIjZkD0cyy
         MkAg==
X-Gm-Message-State: AOJu0YxJ6jpV5mMyYj+rtwvKLhVHQn04sUoidETn2s+9xif20JzWYN0X
	Z6Sz8C41ELrdxVu0WXFMzSzScjJbPVybFuwvmXx/uDvLRZKGm7LjErn7L1Dl
X-Google-Smtp-Source: AGHT+IFXgsfqiOre38poyEaAhuYPj8SeBkoV6lkWz9bXsc5WWK5EXTox9hFlqUSu4Js4OZ2W1MV6Vg==
X-Received: by 2002:a81:5dc5:0:b0:5fa:d966:e223 with SMTP id r188-20020a815dc5000000b005fad966e223mr126407ywb.44.1705542592866;
        Wed, 17 Jan 2024 17:49:52 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:52 -0800 (PST)
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
Subject: [PATCH bpf-next v16 04/14] bpf: add struct_ops_tab to btf.
Date: Wed, 17 Jan 2024 17:49:20 -0800
Message-Id: <20240118014930.1992551-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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


