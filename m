Return-Path: <bpf+bounces-29526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8098C2A87
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546FD2823F7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB60502A2;
	Fri, 10 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAVp5N2n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36174D135;
	Fri, 10 May 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369060; cv=none; b=KoVnpH7JN3E/t6O/pUYfLTS46l4n/9X4JIyiXXK44nRAr8PEc2agZGTRf8739M5SStTYByRYuteEprYn60N4L08/dJiL9eylqp9dKSEIkuv8KQqD1QH5xj2RXfYYr8jSyLtj404zvf+0xSybHRCe2EGdDacrLdAQJBZN+2cuxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369060; c=relaxed/simple;
	bh=FwrEGylC4YNlzqjMfKbV8tttqeM65gtqhap5vUcMyrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1P4YV6SYxccosNBy1Vk3L8HbCNsyAciPUzdUo97VpstnZUgiGhcQP+lIWIzP43mUO/KPPA7+AOw4wX8JOJitTmAga+YjC32RNb1D9N+iUMMRpJueTgDRgPgEtNLG+wbUU3ojk8JC2JKy4/fiLD0cIXFhB1QpWNvxSjG+50QoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAVp5N2n; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b283d2b1b4so593102eaf.0;
        Fri, 10 May 2024 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369057; x=1715973857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIUJawt0aviLgC4egL3XBtE2Jfbiei8RIU4+1Vt6Fpc=;
        b=XAVp5N2nqaDpSnG+rmmTpc8adf7Rhy+s+09d5I+4jNgajNoboEbPNosw6i5JbENKWz
         b1sFCo6sbfG+BUBH7lkNVEawKXbRU8qmdyM4ZoAtqQBn3j12UBioxTpzKJg/WkXMY3VC
         3kT05e5DaMe4IMOxUK21auZ+MbrzidUiXNfidlsFEYhvhtFAF7+uLrRy6VO82ugmiIzv
         T85fk4PJNADA5ZJc38EjOUIy8gwcIIJNopHTktB/nkFlRQwjwpz+iWHOBNPjWTWKspP5
         Ca7XtIM3yiodyUvrRvt3fdurropCU0G/Na8+HjLBZxLFeFLjcTzPgPtiL474I7uiJfkD
         YZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369057; x=1715973857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIUJawt0aviLgC4egL3XBtE2Jfbiei8RIU4+1Vt6Fpc=;
        b=DeEtMLr7TGy14sdTioq7KGruzVjSPLYN6IbJ7g0HkQikj4jxfYpq61xNsbLvZE+beX
         Ua/1V6aFkT+EV2LGmjar3nGWujOXVNhokPNfMG6rN5jr9PUcJ4ruy24ul/pA7P2YKCjW
         BlLTGBmH7HE/Cch+jRMdZg3IN7I3Bth2Zi1Y6RSVgE0jLsbZmYvjBKCfZttW28/JSprs
         dNfAoAEGis0bGMXWiGGBU0p5mRs1uqlYKhF/s41Tr/wR2rJxMIwKn5xbYZTHUImASB9O
         Q0/v/OHfFFLnKz/LIJLqAfQ0hcgnx3cZiOMqb62CGfhogGA7xfKdWB+fO4UTPD4AIWGp
         taNA==
X-Gm-Message-State: AOJu0Yw26s6kflrl4XdtSGNGgyP5eKQRH/kwMaKUgwRVvfESIu6lqR+Z
	wSF8wU7Ru0/5fmKWvbSW0mVKFEywXs470wVhLPkV0T5Un68R2JqNmyZYcg==
X-Google-Smtp-Source: AGHT+IFRabZ/ZaL16AoNnu91bmRwZobadIDbFxADs+tZHXq49BQ/zQH1oRJadPFcuDMxL8H3aY8T/A==
X-Received: by 2002:a05:6358:63a4:b0:18f:8613:12b8 with SMTP id e5c5f4694b2df-193bb3fd3e1mr424120555d.5.1715369056581;
        Fri, 10 May 2024 12:24:16 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 05/20] bpf: Generate btf_struct_metas for kernel BTF
Date: Fri, 10 May 2024 19:23:57 +0000
Message-Id: <20240510192412.3297104-6-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, only program BTF from the user may contain special BTF fields
(e.g., bpf_list_head, bpf_spin_lock, and bpf_timer). To support adding
kernel objects to collections, we will need specical BTF fields (i.e.,
graph nodes) in kernel structures as well. This patch takes the first
step by finding these fields and build metadata for kernel BTF.

Unlike parsing program BTF, where we go through all types, an allowlist
specifying kernel structures that contain special BTF fields is used.
This to avoid wasting time parsing most kernel types that does not have
any special BTF field.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e462fb4a4598..5ee6ccc2fab7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5380,6 +5380,11 @@ static const char *alloc_obj_fields[] = {
 	"bpf_refcount",
 };
 
+/* kernel structures with special BTF fields*/
+static const char *kstructs_with_special_btf[] = {
+	"unused",
+};
+
 static struct btf_struct_metas *
 btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 {
@@ -5391,6 +5396,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		} _arr;
 	} aof;
 	struct btf_struct_metas *tab = NULL;
+	bool btf_is_base_kernel;
 	int i, n, id, ret;
 
 	BUILD_BUG_ON(offsetof(struct btf_id_set, cnt) != 0);
@@ -5412,16 +5418,25 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		return NULL;
 	sort(&aof.set.ids, aof.set.cnt, sizeof(aof.set.ids[0]), btf_id_cmp_func, NULL);
 
-	n = btf_nr_types(btf);
+	btf_is_base_kernel = btf_is_kernel(btf) && !btf_is_module(btf);
+	n = btf_is_base_kernel ? ARRAY_SIZE(kstructs_with_special_btf) : btf_nr_types(btf);
 	for (i = 1; i < n; i++) {
 		struct btf_struct_metas *new_tab;
 		const struct btf_member *member;
 		struct btf_struct_meta *type;
 		struct btf_record *record;
 		const struct btf_type *t;
-		int j, tab_cnt;
+		int j, tab_cnt, id;
 
-		t = btf_type_by_id(btf, i);
+		id = btf_is_base_kernel ?
+		     btf_find_by_name_kind(btf, kstructs_with_special_btf[i],
+					   BTF_KIND_STRUCT) : i;
+		if (id < 0) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		t = btf_type_by_id(btf, id);
 		if (!t) {
 			ret = -EINVAL;
 			goto free;
@@ -5449,7 +5464,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		tab = new_tab;
 
 		type = &tab->types[tab->cnt];
-		type->btf_id = i;
+		type->btf_id = id;
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
 						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
 						  BPF_KPTR, t->size);
@@ -5967,6 +5982,7 @@ BTF_ID(struct, bpf_ctx_convert)
 
 struct btf *btf_parse_vmlinux(void)
 {
+	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
@@ -6009,6 +6025,23 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
+	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
+	if (IS_ERR(struct_meta_tab)) {
+		err = PTR_ERR(struct_meta_tab);
+		goto errout;
+	}
+	btf->struct_meta_tab = struct_meta_tab;
+
+	if (struct_meta_tab) {
+		int i;
+
+		for (i = 0; i < struct_meta_tab->cnt; i++) {
+			err = btf_check_and_fixup_fields(struct_meta_tab->types[i].record);
+			if (err < 0)
+				goto errout_meta;
+		}
+	}
+
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
@@ -6021,6 +6054,8 @@ struct btf *btf_parse_vmlinux(void)
 	btf_verifier_env_free(env);
 	return btf;
 
+errout_meta:
+	btf_free_struct_meta_tab(btf);
 errout:
 	btf_verifier_env_free(env);
 	if (btf) {
@@ -6034,6 +6069,7 @@ struct btf *btf_parse_vmlinux(void)
 
 static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
 {
+	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL, *base_btf;
@@ -6091,10 +6127,29 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
+	if (IS_ERR(struct_meta_tab)) {
+		err = PTR_ERR(struct_meta_tab);
+		goto errout;
+	}
+	btf->struct_meta_tab = struct_meta_tab;
+
+	if (struct_meta_tab) {
+		int i;
+
+		for (i = 0; i < struct_meta_tab->cnt; i++) {
+			err = btf_check_and_fixup_fields(struct_meta_tab->types[i].record);
+			if (err < 0)
+				goto errout_meta;
+		}
+	}
+
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
+errout_meta:
+	btf_free_struct_meta_tab(btf);
 errout:
 	btf_verifier_env_free(env);
 	if (btf) {
-- 
2.20.1


