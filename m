Return-Path: <bpf+bounces-77009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9ECCD106
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9880300C0F0
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE902F0661;
	Thu, 18 Dec 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ginfWadY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD392F531F
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080594; cv=none; b=MW8t5p3q6Szpry6WaRDFIU1p79th4fH7fs7r7cZrSpjl9rbXyCscJvz8NW5+CZryel64YIOZ7+gbzJlw+9tVPdW0+wRg9ESKAmotV0Qn64H59CkIU2JkE91tTPLrXACZKnS3ZXoO1zaj8FpnSOUYemJewqld2TIcIXmEqgVRLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080594; c=relaxed/simple;
	bh=Zm/2J2Gp/7MOUwKbpHPeot/xaphLr02d/7QUcCjBCAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMTD+rMC8NYaihB5lNHlpV239zmFldu5OEpaL4ELXneSiQeS27YBjK7CVytd00C62AzFVfGBXshzUeIq/hOTGd2sLFsDWG9nWWVT7KisaggO9T5UOVPqtVxFJtvVlRbSV6lIObOdBDslTpfI41O0iOzNqF6PcSnLM197/9EN/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ginfWadY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1161193b3a.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080591; x=1766685391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMxWWMICz468XY7xt2inPsxvaZWi3Dfhd4srr2vNxVc=;
        b=ginfWadYpuUh2pVA+uLnyGLw9ro9JNTWrclBbHiTqPsGRKs66x0vSyS5LbiVEGFg/z
         N+BzpOeHXILAhnmP+qrzbr/JitVYh0uiAODGqM4szoYYg/KVtvIRZLt7horJHe/rSuYG
         FWVrNhe4ImtseE1fvcxX3++e4kBvTyz6E21Ww4NuCsHH4gNlnJqBOG/LWfVtZEIcSN1Q
         ISfssaZLWmdvHwkKXn/e7tL2ccWBlJCqyEaExu9SiNWvp1lF5WWxBOPjAlPyHUIiUpYb
         opXpRgHEd1cWEGnbMqcaWKJwveso2Gwpx4+540koQs46Pk3Kh3tZ6akxpu78fkkatSs9
         j8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080591; x=1766685391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMxWWMICz468XY7xt2inPsxvaZWi3Dfhd4srr2vNxVc=;
        b=ZYBHI2EqmggcPWseuSD+WNU6mpnEjbvsZPgcLfOOFGG+/trTSD26HA0j8QvuXBbf8y
         YHw6he+p9sjucsk136LZI7DmzdltIsoed8xrGSl0GTPXkppI3ornvj6qoFV+itgebpo7
         fAwm6+0Q9InYUTRWBsF+2oRF6FDqMpwF2NxIBRdxsMXlo3ZHMaljEScWel5dIjpO82QV
         41CJUAnpDI7jrqBKIPJrfsM9w3EIjOALGbCKrL5Q05gXnqlpvkdFA/n8kyH64DvZSR7q
         o6g5MGcp2x9/vvGqc7ya6WMaPnTm4FFuSVwN5u4cbuffvAFiI+L/sv8/jrWKDlutPQGH
         S4nw==
X-Gm-Message-State: AOJu0Yyb89W7wBPQ0ZUs86QStpgUIgE1XEsLxfoAUWISkmLGbaLP+ddh
	MixKo/uriF2iV/Dcdeviqvm/DaVZ2ru3WBLGgQfn1SbIQ44Qq2rY4MV+bPDsdA==
X-Gm-Gg: AY/fxX4gIzSvHfijgqVWeMKCf0S/KNxJNoX1+Jv7GkXCdnIDl5jH/UVuVQFp0R7UGoa
	riTaMrr/+vMk0KMfGRqKWHeapdmjfTaHBXEjANywdSriEUyuUzy7UHuEQoyVyO7Owe2eHAowcww
	nMSuEkHvukh5jX0PgjXqdX8vYYwQDwrFOibMq8mw8Z+DrdOuwHRrNEGEAl+Hx3Yx5jMOLEcbMeM
	oBnmXNHuT0HvkcEfUIV9Mvlju9OcpgURfBa3ht/ImXUuYdWY+Wnxj6x+CyC4esN0+bw+gUGaVV4
	7ChjGgWU285yK/I0xeDk9kQQ/SM4bhhFr0927Mr81sUVXDexpXnvp9Xa/zA8is2dczDr3yuC1EZ
	y9Vrb8Qax1SlnYs8V5/6Dvb5N1W0fED5SZ3HWwaatzjZphYdQTbFpW7NCFPohIQ7eoSmMUEA4nz
	3gfBScw7qhAWaWyQ==
X-Google-Smtp-Source: AGHT+IHrlWRYqtYM79QJT4r0eaN0ZCB3vFfm2N8n/1p6ldMPPQXfKmGY8zwR1W0BfIco5ME7ff+YvQ==
X-Received: by 2002:a05:6a00:6c94:b0:7aa:d1d4:bb68 with SMTP id d2e1a72fcca58-7ff648ee293mr194806b3a.20.1766080591496;
        Thu, 18 Dec 2025 09:56:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe11856e88sm3266746b3a.7.2025.12.18.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:30 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to failable
Date: Thu, 18 Dec 2025 09:56:11 -0800
Message-ID: <20251218175628.1460321-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_unlink_map() to failable. It still always succeeds and
returns 0 for now.

Since some operations updating local storage cannot fail in the middle,
open-code bpf_selem_unlink_map() to take the b->lock before the
operation. There are two such locations:

- bpf_local_storage_alloc()

  The first selem will be unlinked from smap if cmpxchg owner_storage_ptr
  fails, which should not fail. Therefore, hold b->lock when linking
  until allocation complete. Helpers that assume b->lock is held by
  callers are introduced: bpf_selem_link_map_nolock() and
  bpf_selem_unlink_map_nolock().

- bpf_local_storage_update()

  The three step update process: link_map(new_selem),
  link_storage(new_selem), and unlink_map(old_selem) should not fail in
  the middle.

In bpf_selem_unlink(), bpf_selem_unlink_map() and
bpf_selem_unlink_storage() should either all succeed or fail as a whole
instead of failing in the middle. So, return if unlink_map() failed.

In bpf_local_storage_destroy(), since it cannot deadlock with itself or
bpf_local_storage_map_free() who the function might be racing with,
retry if bpf_selem_unlink_map() fails due to rqspinlock returning
errors.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 64 +++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e2fe6c32822b..4e3f227fd634 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -347,7 +347,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
@@ -355,7 +355,7 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
-		return;
+		return 0;
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
@@ -363,6 +363,14 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
+}
+
+static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
+{
+	if (likely(selem_linked_to_map(selem)))
+		hlist_del_init_rcu(&selem->map_node);
 }
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
@@ -376,13 +384,26 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
 
+static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
+				      struct bpf_local_storage_elem *selem,
+				      struct bpf_local_storage_map_bucket *b)
+{
+	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+	hlist_add_head_rcu(&selem->map_node, &b->list);
+}
+
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
+	int err;
+
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
 	 * the local_storage.
 	 */
-	bpf_selem_unlink_map(selem);
+	err = bpf_selem_unlink_map(selem);
+	if (err)
+		return;
+
 	bpf_selem_unlink_storage(selem, reuse_now);
 }
 
@@ -424,6 +445,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -448,7 +471,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+
+	b = select_bucket(smap, first_selem);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -464,10 +490,12 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map(first_selem);
+		bpf_selem_unlink_map_nolock(first_selem);
+		raw_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
+	raw_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -488,9 +516,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
+	struct bpf_local_storage_map_bucket *b, *old_b = NULL;
+	unsigned long flags, b_flags, old_b_flags;
 	struct bpf_local_storage *local_storage;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, selem);
+
+	if (old_sdata) {
+		old_b = select_bucket(smap, SELEM(old_sdata));
+		old_b = old_b == b ? NULL : old_b;
+	}
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
+
+	if (old_b)
+		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
+
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, selem);
+	bpf_selem_link_map_nolock(smap, selem, b);
 
 	/* Second, link (and publish) the new selem to local_storage */
 	bpf_selem_link_storage_nolock(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
-		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_map_nolock(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
 						&old_selem_free_list);
 	}
 
+	if (old_b)
+		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
+
+	raw_spin_unlock_irqrestore(&b->lock, b_flags);
+
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
@@ -679,7 +725,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		/* Always unlink from map before unlinking from
 		 * local_storage.
 		 */
-		bpf_selem_unlink_map(selem);
+		WARN_ON(bpf_selem_unlink_map(selem));
 		/* If local_storage list has only one element, the
 		 * bpf_selem_unlink_storage_nolock() will return true.
 		 * Otherwise, it will return false. The current loop iteration
-- 
2.47.3


