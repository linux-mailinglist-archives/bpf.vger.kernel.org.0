Return-Path: <bpf+bounces-59096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175AAC6055
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5491BA86BE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83220F07E;
	Wed, 28 May 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM9Wq0Jr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DF20C001;
	Wed, 28 May 2025 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404194; cv=none; b=EvMdxrAwbU4nvd+hW3l8aGz26U22w17TPEWNjW+2pd4Ybg2yTj2qLAZeIJfrBIDnQc6RNYqqh+P4h28DdYBu+FDoJv7blfDGjLGaCdGPcAunumG/80Nr5FyefvvM0EXLZuWtszd8V5e0zo0LFgVbXmFIzS8Vj6lP6wEfqOhoEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404194; c=relaxed/simple;
	bh=hoagNbJPn239NTj8+NoBSGh3wAvcPZsWqDyYt8a0HGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJbcYWMj0NzzRL/PasI5k5dNGiULgIcQdl9MC1jSeTUhi+cCImZA3SUD3NJ8jcLJzTCzlV+BtMfy17/HZxmU0oEA02LdB9ZNoGy5+414BXr3fS2X63BAX8nEqwLTtrUyJELcWZT3Ah4rMh8s/WS7sX5uSBurw8iX7d6uaEvwzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM9Wq0Jr; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22c33677183so28641495ad.2;
        Tue, 27 May 2025 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404192; x=1749008992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6Gzs/Wo0vrVWTxQToES+CRwnjtt6Uid9yBONVnTXyo=;
        b=SM9Wq0Jr20Ar7aD5/jr/N67J7TApKQ9Vaos32wuGHkaN4lUs8hwPfIb9aS5XAGNGOt
         U+sY+BAZiCcNgzVNzO1diQh/UU2ClaNESlpvvpLYi08JmJiGZtrFcVpCpq6qy6i8nWBT
         YnrL17nbLW7MroMxrVkiPyRXmk/ZObhmLLnUq2gVbaKQzVIYUw9sl52j0LzETTqFkQk5
         SpZJ3fCsSJAgIQgH316Y1KE8TQLXAFuRt9M7eVed9ZEJ7dZq7RRVxY6hoHqVq4uTCFSr
         mojd6nTF0COVt5U2dJD4LXm5cJD4EZxsqnWvZomY8HQ62iRkGc12WR1hevOCTuUvMPiI
         QmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404192; x=1749008992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6Gzs/Wo0vrVWTxQToES+CRwnjtt6Uid9yBONVnTXyo=;
        b=J+wvmuVfwj07NV7G7r0eZZLeUnP7pMBlJr2oeT6hI8eVNE4zt1DHXOk7TUr0AmmfdF
         13Up+AugGQPuk/DfB7Gif56Qp7S4fF635wqzwumu5ntQL+cwQjoFVYTvHvxZZPEs4uLs
         355gS5J4Nm0ErRL7vk9idU7FJNT5BRpaXtprzzvaen/FK7sLPDDq51ZrZichwzwMsrk0
         tzVksljooa8oz5aEH/PEw/TO7DYG+MeQtQMVKj18w0PVoF1eejkBtXN3KZdpYGYgw+0+
         jk0svyFNqLTOMw8QG+pp8PD9kpwyXMmkncB20zRmwt7iulNTHnnktN59jBz4uJAIg6Wh
         3H1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvvjJz13ZjAoxP/yvIs+MErWjPwgJVXBv7zYZQe/KbqFPFVgQuGlvNqmhHc8u6uygSAQICNouWgpiWnr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ezjYZr0Nvl21aKqhSbEWsbs8u+oODVFD8kxPsaNqm2WHgT6R
	NHgZjU8Q5ATaDDuLD17T1RThSqZJPKJp2sMwntsaNeMsERDf3XbF5k3R
X-Gm-Gg: ASbGncuf9cQ0Tq8Vl/Dvr763d9ZDBQWMC89OkqrRTVoR5Ys8I6y3m1pzmuCnAZN1tiI
	5hU5VCynsA8s2jgovVHy8xftGj6TccA3w0ks4m3Eyey7DIxWQKo/95BLWmIYNgSTnlx/C8mKC5x
	74ZMNxZmM6Vb5/WjLidQ9WPwIfSffDOrmFy7JVETR90o7BDWnOHEStEfmUUHjQ5Z8LhQco5YAVx
	vQ0yoSlVOC2mFbeHgJVjWrxksNN6iMMgusOJyyUZlqfnKgMdn1k7bpimu/4xdIzH+Ee3DgOPpyB
	Kk96ovT99M9kzySWhWZpeVkgeJWpAYNaOX8pHD2eBRrGUYTuLp9SslEv9wZUTyZttA+p
X-Google-Smtp-Source: AGHT+IGM0AOHtSF2ccrQGi6tNXesN8k9w9fUc1m2GNea3HWDHe6VMVannBjtamAWqHBOJhD+/kS6ow==
X-Received: by 2002:a17:902:fc84:b0:234:c65f:6c0c with SMTP id d9443c01a7336-234c65f6d0fmr25229395ad.15.1748404191731;
        Tue, 27 May 2025 20:49:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:51 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 07/25] ftrace: add reset_ftrace_direct_ips
Date: Wed, 28 May 2025 11:46:54 +0800
Message-Id: <20250528034712.138701-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can change the address of a direct ftrace_ops with
modify_ftrace_direct(). However, we can't change the functions to filter
for a direct ftrace_ops. Therefore, we introduce the function
reset_ftrace_direct_ips() to do such things, and this function will reset
the functions to filter for a direct ftrace_ops.

This function do such thing in following steps:

1. filter out the new functions from ips that don't exist in the
   ops->func_hash->filter_hash and add them to the new hash.
2. add all the functions in the new ftrace_hash to direct_functions by
   ftrace_direct_update().
3. reset the functions to filter of the ftrace_ops to the ips with
   ftrace_set_filter_ips().
4. remove the functions that in the old ftrace_hash, but not in the new
   ftrace_hash from direct_functions.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/ftrace.h |  7 ++++
 kernel/trace/ftrace.c  | 75 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fbabc3d848b3..40727d3f125d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -526,6 +526,8 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 void ftrace_stub_direct_tramp(void);
 
+int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
+			    unsigned int cnt);
 #else
 struct ftrace_ops;
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
@@ -549,6 +551,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
 {
 	return -ENODEV;
 }
+static inline int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
+					  unsigned int cnt)
+{
+	return -ENODEV;
+}
 
 /*
  * This must be implemented by the architecture.
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a1028942e743..0befb4c93e89 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6181,6 +6181,81 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+/* reset the ips for a direct ftrace (add or remove) */
+int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
+			    unsigned int cnt)
+{
+	struct ftrace_hash *hash, *free_hash;
+	struct ftrace_func_entry *entry, *del;
+	unsigned long ip;
+	int err, size;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!hash) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* find out the new functions from ips and add to hash */
+	for (int i = 0; i < cnt; i++) {
+		ip = ftrace_location(ips[i]);
+		if (!ip) {
+			err = -ENOENT;
+			goto out_unlock;
+		}
+		if (__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
+			continue;
+		err = __ftrace_match_addr(hash, ip, 0);
+		if (err)
+			goto out_unlock;
+	}
+
+	free_hash = direct_functions;
+	/* add the new ips to direct hash. */
+	err = ftrace_direct_update(hash, ops->direct_call);
+	if (err)
+		goto out_unlock;
+
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
+
+	free_ftrace_hash(hash);
+	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS,
+					  ops->func_hash->filter_hash);
+	if (!hash) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+	err = ftrace_set_filter_ips(ops, ips, cnt, 0, 1);
+
+	/* remove the entries that don't exist in our filter_hash anymore
+	 * from the direct_functions.
+	 */
+	size = 1 << hash->size_bits;
+	for (int i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (__ftrace_lookup_ip(ops->func_hash->filter_hash, entry->ip))
+				continue;
+			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (del && del->direct == ops->direct_call) {
+				remove_hash_entry(direct_functions, del);
+				kfree(del);
+			}
+		}
+	}
+out_unlock:
+	mutex_unlock(&direct_mutex);
+	if (hash)
+		free_ftrace_hash(hash);
+	return err;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.39.5


