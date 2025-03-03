Return-Path: <bpf+bounces-53090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BA7A4C519
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C94162221
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094323717D;
	Mon,  3 Mar 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkDugpBn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B42356D2;
	Mon,  3 Mar 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015420; cv=none; b=WIDvM1dvgOKov/ZLHCFarZEB7FxAuzA695RQQM2TttIZV0PHNIZpPtlgxO4+bmj8l1eNrWVXpOiu/r02pImPRClIsE78txGWwggbdrvJa2fO24XGDe1TJiK7w27TewIvKEfcquiYBcoWNT4T1QyquofAPMlpUAGZcVLaGOXmvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015420; c=relaxed/simple;
	bh=H+4fvDbeMKpg9kdHFVQF9EirB/DOLCaq4vd16HHmH14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRXZjT9Wsj+gf5JjDh0q4/1XHX4w+3FU5soHhHtNwvfFj03mUF12/RV1+OWGqmUY+BimeM/uO0ZYA+DSy6rr5cKgyAtt78wWgOdZIO24nbelqogUjSezSoQOPMCoObkLfibHC/4pxQgCjCOvubIBz8r8RdmycXsEKF3hizVS7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkDugpBn; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso7209845e9.1;
        Mon, 03 Mar 2025 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015417; x=1741620217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ign20YEmiqhrw2u8+y6jgpbQIECAjRoqEHqNv09q2OE=;
        b=TkDugpBnxQ1istzcieqRvVSmwrgdVo5Om7HfAezQOioKJ0ohdJVw6vK3TH/GKYQ9vZ
         suKW6m+VMMRGmnrEraNh8lB3EsUe29ly8uvn3qKSYtHbngTEgt0pWazTs4nhOPLWspGf
         Yz3tREYLMNvNmz1MacKAW2AyAdlE1SmvMwkfqB3LN8xduC9NDvm55rXPOS+WzGON3Nvi
         IL7NYCFoimHwB+T/c6+AUVbZ0yhKyInwJYzOdb6OLN3uICjSkiuc0vnS8LDHdSJvD8kg
         6fW8dygGbm9BhztKxsjr8rNYudrj03vmOUzFcfDzcZ5bZHQ5lRrsYTgI6m2ca9Nw722o
         TLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015417; x=1741620217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ign20YEmiqhrw2u8+y6jgpbQIECAjRoqEHqNv09q2OE=;
        b=q1WxqiJ3yq+WqpC9F9QKI4cx37iCYpoW/PG0ieQIQel7sgwnwgfNxmxcS4P8Z/VsVG
         hOI0hnIpq4zZucr9RMVfQNuM5W5ixyRRD68gk+vjffnVebqpmOQk1CbbrvWz/zHsiFio
         4dRlTA8V7otislpIjPWHSU6cN0ANX1xj0hZmF6qbueB9DPUxxkBH3xF8saBlvCNEZVp6
         ZP51JRUWQDtHjE5bfI98D6py6Jg7umajk2THiQzIIvXQZN266oFJwjMdqgqFxpW8SsIk
         Yc8cFbwLJHvcJytxJSHfMuBreytx9Z8VU8rhSAtAejdL9DqiCJLlJeLCJGlGFls5ep+m
         TMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe1J8pLeA94aS61BYnxTQ76YUsjqOAoQ3tmxxBieKkR/dMcozTpqHddC3DtR38yjHrruh5wNHPosNpODU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLsuCHhZxNDrT34+yRKJpkw7AK1Z6Hj8y8FYBAoFwmbCHdDBI
	uf8mB5Fl/g+Y+b+TByCxOhHFXu0hcdF7Sq3HnGXMVb1Ezg1+xXCnhA/RsOL8a1g=
X-Gm-Gg: ASbGncsSAfjCkpCLZ3VPubugkjDjXk9Bl+z5ZOeIaKkpURkezU4AYMO70xEsBTw9/im
	JyRZrnj1ZKup7eOpV3NYZHA9IWP5rnrbKKXbHQA+SxVeNblS8IYA6KkdSnfTGYQRklEnJ9L2pGx
	dpjXwJi1hXcnWeUA4K10xs7BJ8sneal5BwApDDEaG3Mzy9eJx3qIPJfslMv2Tp4ok+U3KHYL9YD
	angsj34WKDC9C4LorwYjNG79Yybq+7HCoairO3zydD8oLgw3+QnACxMfEQwEhL0v/ZpLZ1aA4SL
	f10lkXXmSalk3xEp9nhXv/aD0jQ0aT3PzA==
X-Google-Smtp-Source: AGHT+IGlleKe6Z0c4L94quE3jCAiGhg6NJQ9iC0AaFH2JLOqqs7KqiXhmqbOtJsTuHI4jJYfhIdEnw==
X-Received: by 2002:a05:600c:a03:b0:439:9b19:9e2d with SMTP id 5b1f17b1804b1-43ba6702becmr131087705e9.16.1741015416963;
        Mon, 03 Mar 2025 07:23:36 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbfece041sm37242865e9.1.2025.03.03.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 21/25] bpf: Convert lpm_trie.c to rqspinlock
Date: Mon,  3 Mar 2025 07:23:01 -0800
Message-ID: <20250303152305.3195648-22-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3875; h=from:subject; bh=H+4fvDbeMKpg9kdHFVQF9EirB/DOLCaq4vd16HHmH14=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWYzhMQMRB+v202mYygVFkG5s/se6GlCLJdFF8d 3MnU/7aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmAAKCRBM4MiGSL8Rym2eEA CegI2sLVgC2H3/ckPAgaXiYSYSB/uZkXAnww6a6gZc4jNT9kbnHO5KY2RaymVBLci89GDlmnX3v+wp WH5WovKA4m3qH12EjfliSemjg4XIf5M+9Ubag8HHRATXQ0yaW0/Qm4ssV5nbBuntkgRgngLkiyA5C8 6fjsJiKGdQIahwdn/67q1wa9oR78sDXdVF+AOJsCO2QuhaU5qq0dltH27b3gJqWKSyc1OZcC5r1l61 elIyx2qtvgu8OqcZZqaRnEqrlW0x0BpkkO7Dgku2PsEA2SH7M+1DMl5mqtd3J2A0MZrUOT6OjSXmg4 p9NU7L83xsKPB1L/pYutorTTzi6toA8506vLLki/zJPux9cMC5JYuSLqcpz0pb1Q9FKfd8pB/9TfSu pbO9LSlidNGUkw43mfpYyTaDXU14Ud+GC+0SLrUZPMF5UwGNMJuS7N5MfGYxZ+Cwmw5fKGhqPOl9iz 9LGmjGVn6Kv7wo6LX+4HFS3gLLUM/eXMg+u9WWdTUBvFK+ksxSCkHM5fghBlgZS02NQfzLCdz6uO07 4a4aGj9rfzYsf+X9gWldSoL3VrCmnfaj9BW6RTJpdYDI5j73EYdqt946jfnpVYlit0hY5aV7DI4ZiI +0MFK7IDXVAmFcgWYbJJ2fnguEXpNKxH7KrBlkDDpqfs578zqAeL7aGfqhUg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert all LPM trie usage of raw_spinlock to rqspinlock.

Note that rcu_dereference_protected in trie_delete_elem is switched over
to plain rcu_dereference, the RCU read lock should be held from BPF
program side or eBPF syscall path, and the trie->lock is just acquired
before the dereference. It is not clear the reason the protected variant
was used from the commit history, but the above reasoning makes sense so
switch over.

Closes: https://lore.kernel.org/lkml/000000000000adb08b061413919e@google.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/lpm_trie.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index e8a772e64324..be66d7e520e0 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -15,6 +15,7 @@
 #include <net/ipv6.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <asm/rqspinlock.h>
 #include <linux/bpf_mem_alloc.h>
 
 /* Intermediate node */
@@ -36,7 +37,7 @@ struct lpm_trie {
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
-	raw_spinlock_t			lock;
+	rqspinlock_t			lock;
 };
 
 /* This trie implements a longest prefix match algorithm that can be used to
@@ -342,7 +343,9 @@ static long trie_update_elem(struct bpf_map *map,
 	if (!new_node)
 		return -ENOMEM;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	ret = raw_res_spin_lock_irqsave(&trie->lock, irq_flags);
+	if (ret)
+		goto out_free;
 
 	new_node->prefixlen = key->prefixlen;
 	RCU_INIT_POINTER(new_node->child[0], NULL);
@@ -356,8 +359,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*slot))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -442,8 +444,8 @@ static long trie_update_elem(struct bpf_map *map,
 	rcu_assign_pointer(*slot, im_node);
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
-
+	raw_res_spin_unlock_irqrestore(&trie->lock, irq_flags);
+out_free:
 	if (ret)
 		bpf_mem_cache_free(&trie->ma, new_node);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
@@ -467,7 +469,9 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	ret = raw_res_spin_lock_irqsave(&trie->lock, irq_flags);
+	if (ret)
+		return ret;
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -478,8 +482,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference_protected(
-		       *trim, lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*trim))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -543,7 +546,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	free_node = node;
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_res_spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	bpf_mem_cache_free_rcu(&trie->ma, free_parent);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
@@ -592,7 +595,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
-	raw_spin_lock_init(&trie->lock);
+	raw_res_spin_lock_init(&trie->lock);
 
 	/* Allocate intermediate and leaf nodes from the same allocator */
 	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
-- 
2.43.5


