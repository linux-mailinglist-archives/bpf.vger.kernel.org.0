Return-Path: <bpf+bounces-74555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC7C5F322
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36AD635E0D9
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8F34A794;
	Fri, 14 Nov 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtJjRs3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C73446CF
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151213; cv=none; b=nIrfXPY1x5PJBRmxvHtjn1xf4B/ZMcU+d6nstg8pQzKQ01v9wIyTx9FGNkKLdqHR/Dtum8QPxPL+yrLw2PdA952F6CXVi/LMw7pgebJWQGX5Y0ykCMHU5XMGXJIgDEQJVV5+Cec/ivX2X9rgboCUmLxtLHRWCo2+y70B6y5sIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151213; c=relaxed/simple;
	bh=CEquJeA0B7qwqGPeAqfkq2sfpRrrFE8MiRneGr6NkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj10ZpHuPhUf47I3YSphL9bemW7oTprepUwZ+Ux1AImbPitIhmgpyO9kW629luguQIWphvBx6DSVKgc/zOdXejmGqfzYjHmFxah930amWbQijU7iYtiwek0vBxJB1ZXMbltP+LE49xp0oyKr5DxjzzxDLYVgNI1hiObdJXhRTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtJjRs3t; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555415c5fso27221755ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151211; x=1763756011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acHq2BOUlgDzCbZtEmgoDWL45nmh/pJ1AbrqttUOy5o=;
        b=PtJjRs3tOj4lt4h0LOF2j8KTYPzMpqlK25ZF3iBaBGNCLi+SAcAMPSMtwFyGd8ikGE
         XZQ/DQf9GjXy20ZmGt0/k78Yuyl2iyj/w+gSthP43irndZBS9jQThB80JIBYHbkv+5fk
         JhFMRpYKL3iHViG+l0+5LhF5iw7lOSqI3JnQ8aHCk22mdKUGuEr7eauP4opMtnfMkyNc
         3voM8H4AYaGaRIkUWNQnqc6wJtpHxEB4+wDNb7FMmU3JO9RuSsG0iSjeuObhBygK7FUI
         MWF6dbS0azErgQpk73t/wUDtlOf4wiBCqGfRiwa/jvOLGs4oIYjcdKU3IX5Ss3Zc1rUp
         6fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151211; x=1763756011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acHq2BOUlgDzCbZtEmgoDWL45nmh/pJ1AbrqttUOy5o=;
        b=I1tE3tIJRvNfp1qwUy6sKxGBNyC7W4BtT+r7Gsh7XAtfBKurwZ34PEfY0yzh+q4Wbr
         yrbbAoRT5bJfANHXgL2xjMQAt53wRyxTDQMnSrby4utmDckphjdVUOq+u0yYkRTZMUIa
         CW71lwRLJvTpyIusv8RoK4tydwvbT1U3L3vS+oVnVzu8PogC3dnyUrY0ZeTgW6TUGmVR
         wiu1iXBNBGCcKQN8f1+p3EXjjLdyNpdOOrqfVHEqSscl16bNnOh1QT6o6nrXWH9qAaA7
         3NGpfhIRLUiEGzkX6fLoFOpG3qfoC3Tx1zkMUkVDOqQho0pOyJpwtlYFNXxpj94gFFgd
         gAAQ==
X-Gm-Message-State: AOJu0YyI5IaCsGSmCcXIDASSogwi8j9a1ZBQfRkCGG3ZF46/lff+Py0B
	XSrSX/2Zn/q810H1vXDk8GQqAeRFiDlYPZzKJ91NAPT+GYxtEW6JddSvZaN11w==
X-Gm-Gg: ASbGncsjRJnqCblUyYShA2DXdkjemGOmjxEHHe/rCS3pINhfhY6ihyH1hkj4ru4zWeU
	0tvNlisQqW3BZR/UT1viGXvbUW0rl14n4J9AWvVB3Nw4OzJcaoygLQIyjcV2Sw1Qos9mic11+Xs
	HVDaj9+gEmS6iSSlhXzPInA77+v3hMzHfJ5P54ZOnfI//WivG84/rUQCqvFgMTiZHPu5AWjSrxG
	XOC2fcg62mMOKkbLlFg55n5D9d9bI+AyBoFGLSD9LKX2W17kgyT7JPecDbsdTbEfvJsXor2XkvL
	nq8DzEd7N6dNsPeKjxm5B0DAnFf2a8YoUCJrqP4GP4IHv45/QzAeyAyaFziKrEPbXQfNXn7fUP2
	BfrAhY+zdPqvYR9ejmzmHOV0L1uhk+9m+eKJIrzLj7ngSY4EMT53tzluo+aQE19eVvBtrIa6Bro
	k6PnZB3WY4g2RS2A==
X-Google-Smtp-Source: AGHT+IHKzhY9M6/DfFzqhXtWxeHMC36K+JWESdfGCGPs/deKUzIPfg36Y/fzXPXsO4OP7D6SpbxmGA==
X-Received: by 2002:a17:902:ef06:b0:298:595d:3d3a with SMTP id d9443c01a7336-2986a7566edmr41509495ad.50.1763151211311;
        Fri, 14 Nov 2025 12:13:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm63122005ad.32.2025.11.14.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:13:31 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/4] bpf: Always charge/uncharge memory when allocating/unlinking storage elements
Date: Fri, 14 Nov 2025 12:13:23 -0800
Message-ID: <20251114201329.3275875-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114201329.3275875-1-ameryhung@gmail.com>
References: <20251114201329.3275875-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a96a44aba556 ("bpf: bpf_sk_storage: Fix invalid wait
context lockdep report"), {charge,uncharge}_mem are always true when
allocating a bpf_local_storage_elem or unlinking a bpf_local_storage_elem
from local storage, so drop these arguments. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_local_storage.c    | 22 ++++++++++------------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 782f58feea35..3663eabcc3ff 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -184,7 +184,7 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
-		bool charge_mem, bool swap_uptrs, gfp_t gfp_flags);
+		bool swap_uptrs, gfp_t gfp_flags);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54d..400bdf8a3eb2 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -73,11 +73,11 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool charge_mem, bool swap_uptrs, gfp_t gfp_flags)
+		void *value, bool swap_uptrs, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_elem *selem;
 
-	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
+	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
 	if (smap->bpf_ma) {
@@ -106,8 +106,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 		return selem;
 	}
 
-	if (charge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
+	mem_uncharge(smap, owner, smap->elem_size);
 
 	return NULL;
 }
@@ -284,7 +283,7 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
  */
 static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 					    struct bpf_local_storage_elem *selem,
-					    bool uncharge_mem, struct hlist_head *free_selem_list)
+					    struct hlist_head *free_selem_list)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -297,8 +296,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	 * The owner may be freed once the last selem is unlinked
 	 * from local_storage.
 	 */
-	if (uncharge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
+	mem_uncharge(smap, owner, smap->elem_size);
 
 	free_local_storage = hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
@@ -393,7 +391,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, &selem_free_list);
+			local_storage, selem, &selem_free_list);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
@@ -582,7 +580,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, true, swap_uptrs, gfp_flags);
+		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
@@ -616,7 +614,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	/* A lookup has just been done before and concluded a new selem is
 	 * needed. The chance of an unnecessary alloc is unlikely.
 	 */
-	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, swap_uptrs, gfp_flags);
+	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
@@ -656,7 +654,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						true, &old_selem_free_list);
+						&old_selem_free_list);
 	}
 
 unlock:
@@ -762,7 +760,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		 * of the loop will set the free_cgroup_storage to true.
 		 */
 		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, &free_selem_list);
+			local_storage, selem, &free_selem_list);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d3fbaf89a698..bd3c686edc0b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -136,7 +136,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 {
 	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true, false, GFP_ATOMIC);
+	copy_selem = bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC);
 	if (!copy_selem)
 		return NULL;
 
-- 
2.47.3


