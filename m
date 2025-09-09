Return-Path: <bpf+bounces-67912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C0B503CB
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DB47B8E89
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE8371E85;
	Tue,  9 Sep 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="O1XugKCu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C335CED7
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437230; cv=none; b=JmKPYpSoLMd+5pkNAaNLwO1hkiNQGw4ej0yvfNY8BXehv29+2PP0smBu/vNk92dmrf8az76g7oI+RQz/sFe0wQ7HEl4m2u51Zzm5iyP2DfuOctrDXwnxRyI/gjJ02gKtoPY9wgQ7GdfLWIasl/4zHg+opvFJ87cxodEgLiaGL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437230; c=relaxed/simple;
	bh=GRNaYpFu1ow67fFJfX9PgMWTzIpmtoGulPXa5ia3ieY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV9MEo/8/GU8ZrvkezPZPh22Bx7bZjx6z7Uh5gVNL3ne8yN7EIYtMV1wTfartH/dO8+0RImicgGQxSl7tMMP7rdNo9gp9IdLU6sXuDZ3ojj3u+XZnICsOgKgDQWYuSUxqz4yJiTmsgLdMP9Zqk/1rhG0zmcmCRPkq9xvyRUhEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=O1XugKCu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77253037b5eso471305b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437226; x=1758042026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjlLBBgxntotUC1C+WrFijaDvm02aVUYHJlsc7RSilM=;
        b=O1XugKCuCj1EFWAxY31/cq5rcuymQ4Aonw4JATPxZjJip8wFFZmzEC92MZg8mz0gED
         JNlAKVVouBx00riHgpLC606MdnLKQhsU7plySFY2mLZIPOZIXvNn2DaiPBA6CnsmBIYv
         HcG7HwYO5kjWLPupWMQiJjj4J0ARzOv0EQHIrUEVNrYdXL7b8YAdv/VTXPLfXvTY+SlF
         bYGENJOfwFUa1t+a78zk83iL+TJyc5Zax96bUFS4scXyxqa79V3MBxaT0jEUt42PlgQ/
         jXAfFzjxVowcd4xmQTg4eUY7kN9DNZdBNPqdFmu39yiDCgcuSX0MACtxwCKkY+S/kv32
         WMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437226; x=1758042026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjlLBBgxntotUC1C+WrFijaDvm02aVUYHJlsc7RSilM=;
        b=WE34kcJAYNfbzjrytudxh9XGPK8kK+/1LES9AB/i3be5NuGYcoiq7wBihLLYnnschg
         wE0pWVmd3a7XNeyMtL9f8bcVCd/Ss78KYafHJ4qNKHCJ2+h+w29A9L8fQ6gBC1WHtuQ5
         XsbNQX01UjAjbjiahnwyy7RG43Zf5cfWqhHbdbgp6j1eYuV9lwtu79C1qG8qCl1iEVBO
         h7E7YoTC/lfUHyATXkTpYgSb76e9SaM7vwvexReGVagZkgRI5YUodkOeZkMD/7a04krP
         ITgydPi6GYFVx17PYbOd3XM9ZEpBGGorXRcOPXJhjCxu00QBiAUVZTo+4qyTab7SormR
         4kow==
X-Gm-Message-State: AOJu0YwHCc8ow70G+54cImCVQWwGJNv3a5R2GY0QAWYaiCQPi3DmnPKm
	zAH/JIKARu4M6U1AmwDS0/yfItRXVo00WiG7NWi5DUMR+wYbC8MF4be77KHo1eVHi8MrwftxbKl
	xucyC
X-Gm-Gg: ASbGncuNJVW7OVnpu08UqOzKY3qFoSYiCU8knYHj77IUc6MIPGgC+dA2M51ohrXPfYn
	NOA+cobbs3KavPQd5ZHfbKD/WZ8lpAifJv7RQrNh0zyXIWrZ7ZPEqViz9oIkVClgtx1kN0f13fV
	YE24LFYhIVoldyWFKdvVll8wii0ibl84BJNAiftVJDfDneCgUXOQq8FnJZ9PoSHqatZpiaSwYp9
	W3A8o/w7dJozkJFlZHxZGwY24wWeBJXLgHqVbESLNRSwuz5G0e1UxJ0vTmTK0C3k2jDi+XLKajc
	wuoRD0IxX5rXhVHxZlpriaMSKqgEQjJCHmW8NvMGS0a8nupjqPNMaGWle1cDVYchg18y4iJbiDy
	fiEDAoXyRfHWThEhwE20qzaWl
X-Google-Smtp-Source: AGHT+IFvKpTPhEcvLGIwMVMCp1F31697K4diw9xpLwaWM5tikvHWU97uIjoq3XBmigE3dAoFsyUlRQ==
X-Received: by 2002:a17:902:d2d1:b0:248:b43a:3ff with SMTP id d9443c01a7336-25172e31da7mr102946895ad.8.1757437224989;
        Tue, 09 Sep 2025 10:00:24 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:24 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 02/14] bpf: Hold socket lock in socket hash iterator
Date: Tue,  9 Sep 2025 09:59:56 -0700
Message-ID: <20250909170011.239356-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sock_destroy() must be invoked from a context where the socket lock
is held, but we cannot simply call lock_sock() inside
sock_hash_seq_show(), since it's inside an RCU read side critical
section and lock_sock() may sleep. We also don't want to hold the bucket
lock while running sock_hash_seq_show(), since the BPF program may
itself call map_update_elem() on the same socket hash, acquiring the
same bucket lock and creating a deadlock.

TCP and UDP socket iterators use a batching algorithm to decouple
reading the current bucket's contents and running the BPF iterator
program for each element in the bucket. This enables
sock_hash_seq_show() to acquire the socket lock and lets helpers like
bpf_sock_destroy() run safely. One concern with adopting a similar
algorithm here is that with later patches in the series, bucket sizes
can grow arbitrarily large, or at least as large as max_entries for the
map. Naively adopting the same approach risks needing to allocate
batches at least this large to cover the largest bucket size in the map.
This could in theory be mitigated by placing an upper bound on our batch
size and processing a bucket in multiple chunks, but processing in
chunks without a reliable way to track progress through the bucket may
lead to skipped or repeated elements as described in [1]. This could be
solved with an indexing scheme like that described in [2] that
associates a monotonically increasing index to new elements added to the
head of the bucket, but doing so requires an extra 8 bytes to be added
to each element. Not to mention that processing in multiple chunks
requires that we seek to our last position multiple times, making
iteration over a large bucket less efficient. This patch attempts to
improve upon this by using reference counting to make sure that the
current element and its descendants are not freed even outside an RCU
read-side critical section and even if they're unlinked from the bucket
in the meantime. This requires no batching and eliminates the need to
seek to our last position on every read().

Note: This also fixes a latent bug in the original logic. Before,
      sock_hash_seq_start() always called sock_hash_seq_find_next()
      with prev_elem set to NULL, forcing iteration to start at the
      first element of the current bucket. This logic works under the
      assumption that sock_hash_seq_start() is only ever called once
      for iteration over the socket hash or that no bucket has more than
      one element; however, when using bpf_seq_write
      sock_hash_seq_start() and sock_hash_seq_stop() may be called
      several times as a series of read() calls are made by userspace,
      and it may be necessary to resume iteration in the middle of a
      bucket. As is, if iteration tries to resume in a bucket with more
      than one element it gets stuck, since there is no way to make
      progress.

[1]: https://lore.kernel.org/bpf/Z_xQhm4aLW9UBykJ@t14/
[2]: https://lore.kernel.org/bpf/20250313233615.2329869-1-jrife@google.com/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 103 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 16 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 005112ba19fd..9d972069665b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1343,23 +1343,69 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
 struct sock_hash_seq_info {
 	struct bpf_map *map;
 	struct bpf_shtab *htab;
+	struct bpf_shtab_elem *next_elem;
 	u32 bucket_id;
 };
 
+static inline bool bpf_shtab_elem_unhashed(struct bpf_shtab_elem *elem)
+{
+	return READ_ONCE(elem->node.pprev) == LIST_POISON2;
+}
+
+static struct bpf_shtab_elem *sock_hash_seq_hold_next(struct bpf_shtab_elem *elem)
+{
+	hlist_for_each_entry_from_rcu(elem, node)
+		/* It's possible that the first element or its descendants were
+		 * unlinked from the bucket's list. Skip any unlinked elements
+		 * until we get back to the main list.
+		 */
+		if (!bpf_shtab_elem_unhashed(elem) &&
+		    sock_hash_hold_elem(elem))
+			return elem;
+
+	return NULL;
+}
+
 static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
 				     struct bpf_shtab_elem *prev_elem)
 {
 	const struct bpf_shtab *htab = info->htab;
+	struct bpf_shtab_elem *elem = NULL;
 	struct bpf_shtab_bucket *bucket;
-	struct bpf_shtab_elem *elem;
 	struct hlist_node *node;
 
+	/* RCU is important here. It's possible that a parallel update operation
+	 * unlinks an element while we're handling it. Without rcu_read_lock(),
+	 * this sequence could occur:
+	 *
+	 * 1. sock_hash_seq_find_next() gets to elem but hasn't yet taken a
+	 *    reference to it.
+	 * 2. elem is unlinked and sock_hash_put_elem() schedules
+	 *    sock_hash_free_elem():
+	 *        call_rcu(&elem->rcu, sock_hash_free_elem);
+	 * 3. sock_hash_free_elem() runs, freeing elem.
+	 * 4. sock_hash_seq_find_next() continues and tries to read elem
+	 *    creating a use-after-free.
+	 *
+	 * rcu_read_lock() guarantees that elem won't be freed out from under
+	 * us, and if a parallel update unlinks it then either:
+	 *
+	 * (i)  We will take a reference to it before sock_hash_put_elem()
+	 *      decrements the reference count thus preventing it from calling
+	 *      call_rcu.
+	 * (ii) We will fail to take a reference to it and simply proceed to the
+	 *      next element in the list until we find an element that isn't
+	 *      currently being removed from the list or reach the end of the
+	 *      list.
+	 */
+	rcu_read_lock();
 	/* try to find next elem in the same bucket */
 	if (prev_elem) {
 		node = rcu_dereference(hlist_next_rcu(&prev_elem->node));
 		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
+		elem = sock_hash_seq_hold_next(elem);
 		if (elem)
-			return elem;
+			goto unlock;
 
 		/* no more elements, continue in the next bucket */
 		info->bucket_id++;
@@ -1369,28 +1415,47 @@ static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
 		bucket = &htab->buckets[info->bucket_id];
 		node = rcu_dereference(hlist_first_rcu(&bucket->head));
 		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
+		elem = sock_hash_seq_hold_next(elem);
 		if (elem)
-			return elem;
+			goto unlock;
 	}
-
-	return NULL;
+unlock:
+	/* sock_hash_put_elem() will free all elements up until the
+	 * point that either:
+	 *
+	 * (i)  It hits elem
+	 * (ii) It hits an unlinked element between prev_elem and elem
+	 *      to which another iterator holds a reference.
+	 *
+	 * In case (i), this iterator is responsible for freeing all the
+	 * unlinked but as yet unfreed elements in this chain. In case (ii), it
+	 * is the other iterator's responsibility to free remaining elements
+	 * after that point. The last one out "shuts the door".
+	 */
+	if (prev_elem)
+		sock_hash_put_elem(prev_elem);
+	rcu_read_unlock();
+	return elem;
 }
 
 static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(rcu)
 {
 	struct sock_hash_seq_info *info = seq->private;
 
 	if (*pos == 0)
 		++*pos;
 
-	/* pairs with sock_hash_seq_stop */
-	rcu_read_lock();
-	return sock_hash_seq_find_next(info, NULL);
+	/* info->next_elem may have become unhashed between read()s. If so, skip
+	 * it to avoid inconsistencies where, e.g., an element is deleted from
+	 * the map then appears in the next call to read().
+	 */
+	if (!info->next_elem || bpf_shtab_elem_unhashed(info->next_elem))
+		return sock_hash_seq_find_next(info, info->next_elem);
+
+	return info->next_elem;
 }
 
 static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-	__must_hold(rcu)
 {
 	struct sock_hash_seq_info *info = seq->private;
 
@@ -1399,13 +1464,13 @@ static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static int sock_hash_seq_show(struct seq_file *seq, void *v)
-	__must_hold(rcu)
 {
 	struct sock_hash_seq_info *info = seq->private;
 	struct bpf_iter__sockmap ctx = {};
 	struct bpf_shtab_elem *elem = v;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
+	int ret;
 
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, !elem);
@@ -1419,17 +1484,21 @@ static int sock_hash_seq_show(struct seq_file *seq, void *v)
 		ctx.sk = elem->sk;
 	}
 
-	return bpf_iter_run_prog(prog, &ctx);
+	if (elem)
+		lock_sock(elem->sk);
+	ret = bpf_iter_run_prog(prog, &ctx);
+	if (elem)
+		release_sock(elem->sk);
+	return ret;
 }
 
 static void sock_hash_seq_stop(struct seq_file *seq, void *v)
-	__releases(rcu)
 {
+	struct sock_hash_seq_info *info = seq->private;
+
 	if (!v)
 		(void)sock_hash_seq_show(seq, NULL);
-
-	/* pairs with sock_hash_seq_start */
-	rcu_read_unlock();
+	info->next_elem = v;
 }
 
 static const struct seq_operations sock_hash_seq_ops = {
@@ -1454,6 +1523,8 @@ static void sock_hash_fini_seq_private(void *priv_data)
 {
 	struct sock_hash_seq_info *info = priv_data;
 
+	if (info->next_elem)
+		sock_hash_put_elem(info->next_elem);
 	bpf_map_put_with_uref(info->map);
 }
 
-- 
2.43.0


