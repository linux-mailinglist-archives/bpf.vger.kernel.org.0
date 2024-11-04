Return-Path: <bpf+bounces-43897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA59BBA59
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9869B1F23353
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758361C2325;
	Mon,  4 Nov 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vUxy+76d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5wKubNt2"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0D4A08;
	Mon,  4 Nov 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737721; cv=none; b=Rscge52TbztiXul3LYdOc1LtQqG0ohyqDWZjc0cdxYNBXTaT9IVSqOdibpdAYj2vVsGw1MQ0o8PFNS7LkEKabWzEakgx8Rr7B1qTeYdSJuK4ikDnGcNMpJoCEztwlc4V6TP1fIxCV/j61YORU+2z55DwpD4GxstTuZb9rUISvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737721; c=relaxed/simple;
	bh=1R/Em5fCRSOK0NjH71GssW8QSlYQzsUdM7URV1RwhD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfbBhvJXiyRd6KH5KhE+EFBh1J+HmhrZk1s545q7pea+qtOyeToaOpKChzOkQxa3EtRRaOPOgiqbEuyLFDJbfYr0z3rpTyeg6zY6Vo+HnVUvBsojZNJWG+1nG5dqUbpXOhHkuTaaNI4LMUSC3LINq/OEkErrT9Z0NMQou3e32iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vUxy+76d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5wKubNt2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 Nov 2024 17:28:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730737715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jg03i2HOOyHrghHv90ujEbU+xepLRRkhBI0ZKP+Fm8=;
	b=vUxy+76d/OOJGPok1D8si0OLswywxWeXl0IVefY4wS3UA6Lork9tiCRWNEiqJjTsvU3wB5
	QnxOAjUxqB/9JoZLXGLmcq0NkqXAoy/xgUwHkg8mXU1srxxTkNzlIA/Bmy/6TA33vkcP+M
	lbo16kWWoMu7EO3qoUu/rRfewiHuvfOnjrlwe2uMLGfX1vSy3mBL11CRhTuOFfT7AUult9
	IONaNqxbMEhXe4/WimRIGdknrNowLOCOKCgf1O1ceMt/3GELokrEsBJAF8E7wzKow41nTj
	AcVCqKq5wyOgVWRE+svj+bwHxKLFvzC9ZoxGsmnS/Itl5Rg3x5yZSU0u+MOEvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730737715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jg03i2HOOyHrghHv90ujEbU+xepLRRkhBI0ZKP+Fm8=;
	b=5wKubNt2+FZCON3xpdYkEs+YhjDiMOv6tQfzEC8pkTVZoBwpmlCoDLaxRy1qbMmlcckeNZ
	90bKNGpWDZipIMCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com,
	bpf@vger.kernel.org, daniel@iogearbox.net, eadavis@qq.com,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	longman@redhat.com, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev, tglx@linutronix.de
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
Message-ID: <20241104162832.OQvrGDiP@linutronix.de>
References: <67251dc5.050a0220.529b6.015c.GAE@google.com>
 <67283170.050a0220.3c8d68.0ad6.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67283170.050a0220.3c8d68.0ad6.GAE@google.com>

On 2024-11-03 18:29:04 [-0800], syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 560af5dc839eef08a273908f390cfefefb82aa04
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Wed Oct 9 15:45:03 2024 +0000
> 
>     lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122a4740580000
> start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=112a4740580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=162a4740580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174432a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ffe55f980000
> 
> Reported-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
> Fixes: 560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

This is due to raw_spinlock_t in bucket::lock and the acquired
spinlock_t underneath. Would it would to move free part outside of the
locked section?

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b14b87463ee04..1d8d09fdd2da5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -824,13 +824,14 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			check_and_free_fields(htab, l);
 			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
 
 	htab_unlock_bucket(htab, b, tgt_l->hash, flags);
 
+	if (l == tgt_l)
+		check_and_free_fields(htab, l);
 	return l == tgt_l;
 }
 
@@ -1181,14 +1182,18 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	 * concurrent search will find it before old elem
 	 */
 	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
-	if (l_old) {
+	if (l_old)
 		hlist_nulls_del_rcu(&l_old->hash_node);
+	htab_unlock_bucket(htab, b, hash, flags);
+
+	if (l_old) {
 		if (!htab_is_prealloc(htab))
 			free_htab_elem(htab, l_old);
 		else
 			check_and_free_fields(htab, l_old);
 	}
-	ret = 0;
+	return 0;
+
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 	return ret;
@@ -1433,14 +1438,15 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
-	if (l) {
+	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
-		free_htab_elem(htab, l);
-	} else {
+	else
 		ret = -ENOENT;
-	}
 
 	htab_unlock_bucket(htab, b, hash, flags);
+
+	if (l)
+		free_htab_elem(htab, l);
 	return ret;
 }
 
@@ -1647,14 +1653,16 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		}
 
 		hlist_nulls_del_rcu(&l->hash_node);
-		if (!is_lru_map)
-			free_htab_elem(htab, l);
 	}
 
 	htab_unlock_bucket(htab, b, hash, bflags);
 
-	if (is_lru_map && l)
-		htab_lru_push_free(htab, l);
+	if (l) {
+		if (is_lru_map)
+			htab_lru_push_free(htab, l);
+		else
+			free_htab_elem(htab, l);
+	}
 
 	return ret;
 }
@@ -1851,15 +1859,12 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 			/* bpf_lru_push_free() will acquire lru_lock, which
 			 * may cause deadlock. See comments in function
-			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
-			 * after releasing the bucket lock.
+			 * prealloc_lru_pop(). htab_lru_push_free() may allocate
+			 * sleeping locks. Let us do bpf_lru_push_free() after
+			 * releasing the bucket lock.
 			 */
-			if (is_lru_map) {
-				l->batch_flink = node_to_free;
-				node_to_free = l;
-			} else {
-				free_htab_elem(htab, l);
-			}
+			l->batch_flink = node_to_free;
+			node_to_free = l;
 		}
 		dst_key += key_size;
 		dst_val += value_size;
@@ -1871,7 +1876,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	while (node_to_free) {
 		l = node_to_free;
 		node_to_free = node_to_free->batch_flink;
-		htab_lru_push_free(htab, l);
+		if (is_lru_map)
+			htab_lru_push_free(htab, l);
+		else
+			free_htab_elem(htab, l);
 	}
 
 next_batch:

