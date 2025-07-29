Return-Path: <bpf+bounces-64658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E2B152BB
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B614E7D23
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132923E35B;
	Tue, 29 Jul 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezsddjf/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8523817E;
	Tue, 29 Jul 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813556; cv=none; b=mE4JZxFScj3UN3/wa9PY2MCNGKI6YilZxkZTK4T2jTJ9vlRVKTWwBBJNBqYRom7FUcatJEcipCy5UVTHpLLKk4aWDZ7EOMDMNeBTArapTd7v0VcwSyME+jCmeCd49vvIstxo4uGTHsjyYSLXot4OkOoHQzl+/gr4fnrfQHt4qhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813556; c=relaxed/simple;
	bh=ttTA+9BCJxjYrYVxC6vm7nGR5d1BubYuvGRE9gXExOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfoP1FIFTVXQ/Pfgfk2wmvxhg+RXpnwmKyl/BhOjd+A4S6y04eZggObiCNlet9wB4e7XD3FMPtSDWAZCc9AtS3+i+TAXcSeHck9FB9+30BK6Tr44qc7eMsUpN04p20ur88JuiKlslAk/jetdJEeXEbGdmB/dLsFcSFBlEHels7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezsddjf/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f255eb191so118381a91.0;
        Tue, 29 Jul 2025 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813553; x=1754418353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RowipMpvZj4TkkO3FU+L0B2ZoMNKt+BvHuu9iam7B1A=;
        b=ezsddjf/Pfmu80yRFJB4zjyHsw4LWZt3yTHO6nL8H+loNH4D8OKvQponLCi7OalWKy
         OSRzSwGSlNkZWL9NxysRHq9PEWaYMwBEHH6ZbViLQGWXIR+jI+1kgC3iiPmVzXYYzrJK
         jt/SxIvBxudeLW6ZVvrVkJ0pUUFCeqW5coGxJMw/3ZZuRmrbAzpLaKzBifHSRWI80iPp
         FTQGUkEDeORLgpMbp7QtLgvn42MFSU1iW81C1U1kWMzkASsfPvbi5CffOtFZbaUtolDZ
         NkevaUwqU8Oqn/1Ju6xi6AtNMDbheBN5Oo54eSqV1T6MlpybNKJ6oxttqjPd2PU8NoLv
         gvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813553; x=1754418353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RowipMpvZj4TkkO3FU+L0B2ZoMNKt+BvHuu9iam7B1A=;
        b=EQL2Kx7b8Vf/ISbwE2fwVA8zNB9/jcLi/NFWb9G4MBrkOxVe6HgYX7Bfb7sU+cNQNd
         ZDYASOqHWbpuGp+jFKzr9injeUKpEv9IeIWzijy6zD4SZNlfW0QEFEjt6AUQ9QWD0Owm
         Ia+SzF72wjPJ64ugOkwBoDwCU4ko6nQIECbqGPDZju04ptCjAGEjC8X/waHwIn2ZS8FF
         8Oak+ITFK7E9p4Aw7aXoO+R75iQmz+CeBxGA8AolOg7zslJqWoD/8eGY3X0yQGBMDdsO
         kH3KU+Yq0nkjLDXwGSQQJgP2aT7JMGmjngd361t5z8QEhO7iCVtl6SWMnjjmwNnBXKBv
         hKBA==
X-Gm-Message-State: AOJu0YzAjMX0S4XYdXEYlBjTtLNTHbLyNkNBhCDvFk/ZSynbJtZG8GSI
	czyF6sgAyM7iw3ceMX6AdBO4Be6lsgKADxs8/jPnA8tJIsKC/HljmWUI8leZvQ==
X-Gm-Gg: ASbGnctBfs5tAnopnoz4nbYlRbjTAG+IJfEa44BVxEE/RKPaonCFd/qR4gcG0GrgIQO
	3XagDgTLBDMts63iboqstzyM11elE7WqKOY+2Sf6Y4yQ8tcVQIyajEgoW6iazErLvPtXwf6zXYf
	AzmcsrpixqrAaJ8UTiNoWQ8pc5/DU3ZIrdzWq1HMEbvFQRR6lP/afNwY72hUcqoX9OTeAQhIapm
	W2A+OfNOvL21HclTflnKI05G2ekDMOSPt+6EgcLqoozAkajpZ0wmGAdVmJ6sAEl2agMp8X/s1ig
	ywz7vZB4sYOdaaf4wjjCwjWQHV4Sn7DCxPQi4VFnjX3e8GKO7+siku5oJLh6IqZu2p8GVnqkbk0
	NOlaHBvUGY5IWDQ==
X-Google-Smtp-Source: AGHT+IEfyMbGVOIUnfltNKgKJDBGzwrw2kYQIkMFXBXbbrWPACL5yiPMmjKCeSX/sY2gJltd1OcxRg==
X-Received: by 2002:a17:90b:1dc6:b0:31c:c661:e4e with SMTP id 98e67ed59e1d1-31f5de86d34mr795371a91.33.1753813553154;
        Tue, 29 Jul 2025 11:25:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f310261d6sm1185640a91.4.2025.07.29.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 01/11] bpf: Convert bpf_selem_unlink_map to failable
Date: Tue, 29 Jul 2025 11:25:39 -0700
Message-ID: <20250729182550.185356-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
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
  the middle. Hence, lock both b->lock before the update process starts.

  While locking two different buckets decided by the hash function
  introduces different locking order, this will not cause ABBA deadlock
  since this is performed under local_storage->lock.

- bpf_selem_unlink()

  bpf_selem_unlink_map() and bpf_selem_unlink_storage() should either
  all succeed or fail as a whole instead of failing in the middle.
  As the first step, open code bpf_selem_unlink_map(). A later patch
  will open code bpf_selem_unlink_storage(). Then, unlink_map and
  unlink_storage will be done after successfully acquiring both
  local_storage->lock and b->lock.

One caller of bpf_selem_unlink_map() cannot run recursively (e.g.,
called by helpers in tracing bpf programs) and therefore cannot deadlock.
Assert that these calls cannot fail instead of handling them.

- bpf_local_storage_destroy()

  Called by owner (e.g., task_struct, sk, ...). Will not recur and
  cause AA deadlock.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 75 ++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54d..7e39b88ef795 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -409,7 +409,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
@@ -417,7 +417,7 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
-		return;
+		return 0;
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
@@ -425,6 +425,14 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
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
@@ -439,13 +447,33 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
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
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	bpf_selem_unlink_map(selem);
+	struct bpf_local_storage_map_bucket *b;
+	struct bpf_local_storage_map *smap;
+	unsigned long flags;
+
+	if (likely(selem_linked_to_map_lockless(selem))) {
+		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+		b = select_bucket(smap, selem);
+		raw_spin_lock_irqsave(&b->lock, flags);
+
+		/* Always unlink from map before unlinking from local_storage
+		 * because selem will be freed after successfully unlinked from
+		 * the local_storage.
+		 */
+		bpf_selem_unlink_map_nolock(selem);
+		raw_spin_unlock_irqrestore(&b->lock, flags);
+	}
+
 	bpf_selem_unlink_storage(selem, reuse_now);
 }
 
@@ -487,6 +515,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -509,7 +539,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->owner = owner;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+
+	b = select_bucket(smap, first_selem);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -525,7 +558,8 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map(first_selem);
+		bpf_selem_unlink_map_nolock(first_selem);
+		raw_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 
@@ -539,6 +573,7 @@ int bpf_local_storage_alloc(void *owner,
 		 * bucket->list under rcu_read_lock().
 		 */
 	}
+	raw_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -560,8 +595,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b, *old_b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
+	unsigned long flags, b_flags, old_b_flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -645,20 +681,31 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, selem);
+	old_b = old_sdata ? select_bucket(smap, SELEM(old_sdata)) : b;
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
+	if (b != old_b)
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
 						true, &old_selem_free_list);
 	}
 
+	if (b != old_b)
+		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
+	raw_spin_unlock_irqrestore(&b->lock, b_flags);
+
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
@@ -736,6 +783,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
 	unsigned long flags;
+	int err;
 
 	storage_smap = rcu_dereference_check(local_storage->smap, bpf_rcu_lock_held());
 	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, NULL);
@@ -754,7 +802,8 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		/* Always unlink from map before unlinking from
 		 * local_storage.
 		 */
-		bpf_selem_unlink_map(selem);
+		err = bpf_selem_unlink_map(selem);
+		WARN_ON(err);
 		/* If local_storage list has only one element, the
 		 * bpf_selem_unlink_storage_nolock() will return true.
 		 * Otherwise, it will return false. The current loop iteration
-- 
2.47.3


