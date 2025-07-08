Return-Path: <bpf+bounces-62715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F75AFDB8F
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BB21AA1F9C
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032CB23182B;
	Tue,  8 Jul 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSJpgmvj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641C22A4D8
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016110; cv=none; b=aDdDz/ZwcY9egDU3rxlWWEXbY2A34oVjmL2DXKlbn1rZMCdjpIC7ITe1g+reVwWCEJRlfWX9IvehGUQs/U+fxvYMyG2B4RdELHbLBptsim0M9RrVMPj3kndGSpCKs4Un9a2OZlZ4KVHkroXcW1bcn6P4TZOs7jhhXvpcAiAJXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016110; c=relaxed/simple;
	bh=FxkwUY/WVirElTMxhME7Bi7BBml2L7mJjlgtdEeICt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u39aGQ0EFSw/T9R3pJ/qwuhdM7+nmE0dwrxmKL10sp3hkenwWfA2K9ZDfQorfJDU/HTQpixPKjsTTcEryyDfmFwPW8jG21BwDnuEcNUu89Q+TYkZrzJtOgMFdKBAXvIbIgLWcpXZfeSbPkvbPehoM01IIUW88urNLIP3+ByQYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSJpgmvj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6839309a12.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016108; x=1752620908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXp+5yC/eIwHET1oj+oWwLqHQhUfkw9KqCwSfhv8wt0=;
        b=fSJpgmvjWWK47NwM7BUEEq8Fisg+sYN8iw6a9S4C+oC3fyG4Ps/8SaoJGfivf0J9fy
         DHQREkFP3xyTdR2Cqq8Oiojg5frVe87ZrYNxIJ5BZjCUbbrL5X+7CiQV/vM4bXQvDnSj
         kpuOUI0wZCOKnICsR8jALgjUsqdOB9AiANH2b2r63jdGmSSrte5RF1nUtbRi1bo1H5b2
         L0TX+gzrSPsMbgJQAph4hG+kFxYVfF/mmtyY3ZTYTcLfA08UYjzaCxdmiOd3zbiZlhuZ
         Htd4jNaQtJK32Irsw8XWUmtPxUbI+F4TsUWATrA6nbPpLvzoDZ9ejODr7NyIlrzLZyE4
         HMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016108; x=1752620908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXp+5yC/eIwHET1oj+oWwLqHQhUfkw9KqCwSfhv8wt0=;
        b=F+BjZ/8J8/vTmbGH5RsdBvqvyC3Ly7J3dClJ2qZ+QXdmrlUjxtZDc7AmwpwnJA9UTj
         liL3Il0/6/uhWbNKrU6HFmHBj8dQfHZ1lUjIyYSZp3B6CBito9mfsY4iEsuQelx8Cgk5
         OWsr2rkdzUkI9MnXgffvH+DVhMyxvu9d+7Ek5ap+QvgD4X51j/fRJSacU2Qb5zWfK5cg
         394CrgYqzGBryowdVIRMizuhVcndew23yxxZ2VuwQHOT2t1Fw6tPH1exQPSdfrUTSBNP
         flNfdMzaTYWv10PgyaoLDZUrMoAb0hlw8aELXRrLSBbUzN4iLeVbMIJwLUEr6mPJ0GKL
         0j9w==
X-Gm-Message-State: AOJu0YxUWxyaxmsyD5gsSgDQDyi8iAMhUDT65uuDj3yTbui211QAnrLP
	yB75eNBoPBdWKN+z3uat+aBYaC0KHG36IIfvo8khn4FlBroowLq22g7Ndii+fg==
X-Gm-Gg: ASbGnctoOY7Z7IWZIIMxmVMYkjgGW0zcV2NbxLE0qdcWJFQ+mZTJ1u4PgsWxeJdcoM3
	H6eJ7IJbN0RzkIbBRmN2yyg0h+Q8XRc71bxX0MU2oQ0VvhyA8Ux3IePz51Oa4oWMgw4HWhFbF4N
	AdItv+m3zCEmqUqH+PHpveTXran7aTrCYmaoQFaUk8vMA/cZZmY0gr6BgGq9XZJfywaiWFesdB4
	2p6PNxnsKBljQXlvPaxAFlrQMgGSRCDKK07EdSCPthYoD5+PDq0C0fhVFea6gHnh+v5v8SJsL01
	zv7nAI9vdwn8KojnET6tK9OZLFQAVrgKkcG4wF0PAbir7lx3qegJHUkEa7kUzYo=
X-Google-Smtp-Source: AGHT+IGsIjTyiHoCHpzpaSQYvvPjrL3H0f6ikIJrvrG3HBnmFJGCOKSjfC9bUqlHfq/7Pau3n1U+gw==
X-Received: by 2002:a17:90b:56ce:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31c2fce6a50mr678208a91.12.1752016107668;
        Tue, 08 Jul 2025 16:08:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455e720sm119013665ad.118.2025.07.08.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 16:08:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 1/4] bpf: Factor out bpf_struct_ops_prepare_attach()
Date: Tue,  8 Jul 2025 16:08:22 -0700
Message-ID: <20250708230825.4159486-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708230825.4159486-1-ameryhung@gmail.com>
References: <20250708230825.4159486-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support cookie for struct_ops attachment, the trampoline needs be
created during link_create. To prepare for it, factor out the creation
of trampoline and ksym from struct_ops map update. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 148 ++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 55 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 96113633e391..4d150e99a86c 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -673,6 +673,95 @@ static void bpf_struct_ops_map_free_ksyms(struct bpf_struct_ops_map *st_map)
 	}
 }
 
+static int bpf_struct_ops_prepare_attach(struct bpf_struct_ops_map *st_map)
+{
+	const struct bpf_struct_ops *st_ops = st_map->st_ops_desc->st_ops;
+	const struct btf_type *t = st_map->st_ops_desc->type;
+	struct bpf_link **plink = st_map->links;
+	struct bpf_ksym **pksym = st_map->ksyms;
+	const struct btf_member *member;
+	struct bpf_tramp_links *tlinks;
+	void *udata, *kdata;
+	int i, err = 0;
+	u32 trampoline_start, image_off = 0;
+	void *cur_image = NULL, *image = NULL;
+	const char *tname, *mname;
+
+	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
+	if (!tlinks)
+		return -ENOMEM;
+
+	udata = &st_map->uvalue->data;
+	kdata = &st_map->kvalue.data;
+
+	tname = btf_name_by_offset(st_map->btf, t->name_off);
+
+	for_each_member(i, t, member) {
+		const struct btf_type *ptype;
+		struct bpf_tramp_link *link;
+		struct bpf_ksym *ksym;
+		u32 moff, id;
+
+		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
+		if (!ptype || !btf_type_is_func_proto(ptype))
+			continue;
+
+		moff = __btf_member_bit_offset(t, member) / 8;
+
+		id = *(unsigned long *)(udata + moff);
+		if (!id)
+			continue;
+
+		mname = btf_name_by_offset(st_map->btf, member->name_off);
+		link = container_of(*plink++, struct bpf_tramp_link, link);
+
+		ksym = kzalloc(sizeof(*ksym), GFP_USER);
+		if (!ksym) {
+			err = -ENOMEM;
+			goto out;
+		}
+		*pksym++ = ksym;
+
+		trampoline_start = image_off;
+		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+						&st_ops->func_models[i],
+						*(void **)(st_ops->cfi_stubs + moff),
+						&image, &image_off,
+						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
+		if (err)
+			goto out;
+
+		if (cur_image != image) {
+			st_map->image_pages[st_map->image_pages_cnt++] = image;
+			cur_image = image;
+			trampoline_start = 0;
+		}
+
+		*(void **)(kdata + moff) = image + trampoline_start + cfi_get_offset();
+
+		/* init ksym for this trampoline */
+		bpf_struct_ops_ksym_init(tname, mname,
+					 image + trampoline_start,
+					 image_off - trampoline_start,
+					 ksym);
+	}
+
+	if (st_ops->validate) {
+		err = st_ops->validate(kdata);
+		if (err)
+			goto out;
+	}
+	for (i = 0; i < st_map->image_pages_cnt; i++) {
+		err = arch_protect_bpf_trampoline(st_map->image_pages[i],
+						  PAGE_SIZE);
+		if (err)
+			goto out;
+	}
+out:
+	kfree(tlinks);
+	return err;
+}
+
 static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 					   void *value, u64 flags)
 {
@@ -683,14 +772,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops_desc->type;
-	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
 	int prog_fd, err;
-	u32 i, trampoline_start, image_off = 0;
-	void *cur_image = NULL, *image = NULL;
+	u32 i;
 	struct bpf_link **plink;
-	struct bpf_ksym **pksym;
-	const char *tname, *mname;
 
 	if (flags)
 		return -EINVAL;
@@ -710,10 +795,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks)
-		return -ENOMEM;
-
 	uvalue = (struct bpf_struct_ops_value *)st_map->uvalue;
 	kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
 
@@ -730,18 +811,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	kdata = &kvalue->data;
 
 	plink = st_map->links;
-	pksym = st_map->ksyms;
-	tname = btf_name_by_offset(st_map->btf, t->name_off);
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
 		struct bpf_tramp_link *link;
-		struct bpf_ksym *ksym;
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
-		mname = btf_name_by_offset(st_map->btf, member->name_off);
 		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
@@ -811,51 +888,13 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog);
 		*plink++ = &link->link;
 
-		ksym = kzalloc(sizeof(*ksym), GFP_USER);
-		if (!ksym) {
-			err = -ENOMEM;
-			goto reset_unlock;
-		}
-		*pksym++ = ksym;
-
-		trampoline_start = image_off;
-		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
-						&st_ops->func_models[i],
-						*(void **)(st_ops->cfi_stubs + moff),
-						&image, &image_off,
-						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
-		if (err)
-			goto reset_unlock;
-
-		if (cur_image != image) {
-			st_map->image_pages[st_map->image_pages_cnt++] = image;
-			cur_image = image;
-			trampoline_start = 0;
-		}
-
-		*(void **)(kdata + moff) = image + trampoline_start + cfi_get_offset();
-
 		/* put prog_id to udata */
 		*(unsigned long *)(udata + moff) = prog->aux->id;
-
-		/* init ksym for this trampoline */
-		bpf_struct_ops_ksym_init(tname, mname,
-					 image + trampoline_start,
-					 image_off - trampoline_start,
-					 ksym);
 	}
 
-	if (st_ops->validate) {
-		err = st_ops->validate(kdata);
-		if (err)
-			goto reset_unlock;
-	}
-	for (i = 0; i < st_map->image_pages_cnt; i++) {
-		err = arch_protect_bpf_trampoline(st_map->image_pages[i],
-						  PAGE_SIZE);
-		if (err)
-			goto reset_unlock;
-	}
+	err = bpf_struct_ops_prepare_attach(st_map);
+	if (err)
+		goto reset_unlock;
 
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
@@ -897,7 +936,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
-	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
 	if (!err)
 		bpf_struct_ops_map_add_ksyms(st_map);
-- 
2.47.1


