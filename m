Return-Path: <bpf+bounces-70254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021DBB593A
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F6E3A4606
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6042C11D0;
	Thu,  2 Oct 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdCW0YzM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DF2C0276
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445648; cv=none; b=fPJFdJv4eF+2Jfz9+HG802iiGIKpQs67ev6y+5f4U/rXZqjvuu8UgPXNlRe6Kr016EJ+BF0V99wqjNB5Db9gfApm44kqr3HfKwxSUmlLv1JdJCA7cN6sEfG3MOiFNLS6cT79y8ZiAPkOixVI9Fm5EFq9r6uR8cpZNCUhIh5d8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445648; c=relaxed/simple;
	bh=zAQ5ubKPKove2VdF9p5kOqbb5Ij41CZ9vyaqNg8m5vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbLO9OGCBigAKwsPmpVwibnhts1BMmIoGl+chzf9jklch1uZk3PrYDK6DCEySmp1BR7Z5mEIT91ceYji+L/VWIkrmEvjkJnlL0Qcnk9ZCFDqhqPZZ7r8U36Y59jgecD3Z6TuYpmh58EiTdG8JMGzW8ArZRfTrvqsYugbnYH9s9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdCW0YzM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1355107a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445646; x=1760050446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rU8XxuS09On1+d2XIUmC4XcClm0Yd0oYj9m+pQryRI=;
        b=RdCW0YzMcTAVZSiqrWq4k0TZgyw3wrxKyPlUoJ6NTPtV6H9XjNG5orDWW9lxPEANT2
         Nxy/hXZvtiVjZwv1hBSp/YrLntB4BXXhBtb6n+drjUeH8MMmbUcYv4qaM27IWK0EDzOM
         p+8EcESxVQQnm8SOxCfI89tyCwSnoIYY1JzdrYKld4WEY7IYNcrM77JYb6ugnecqN8ju
         +GLO4W8euUJjKQ4wHRSY6Ru5NsawPfLyEuBq8N0XPxFdLWr9VLxRU5Zs5QdKiVsoWNtG
         e7trB6U2zsb7IZ+1Uop0Q+2zgL4YSsvA4l7hNrJOGkhFq191bW4IZkzPIzDwWcs0TSKo
         FXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445646; x=1760050446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rU8XxuS09On1+d2XIUmC4XcClm0Yd0oYj9m+pQryRI=;
        b=LUMlDuasVP9BM4n/GM7dGYrhC6W2j2IJJx2gI/nHZdZAybR7BW+Vs1v4wbmj0OCPtV
         U8WkaMWoSoBPBb1i1++BAw5U/r3qYOX99U+ujOde+3Tc3bUA3lLPFiqW+VAcCxVS9tGT
         GQWGHIq9+/e+HIfIBmccfdlsDeRhM/oPJzDhX6Yx1UkjMeDksu627kQN6P3FbDjsb1+I
         O+48qf9ytdWw5y3AgCZCI2VUsgfE0oASZE48Jkf4Jwn/89cyVx2z0ha260wLBUzmQuxI
         P6wow8KgCryZKhvU65ZdSNyb2ZKZa6L8vMbxgP5AHbYpYF50ga/d8zt861zq8WvdfGDw
         hMXA==
X-Gm-Message-State: AOJu0YyJs+gExJss0BVP3B5TbiSQ1RPlBwC8vby/6pD2BQ4ozDoS0N0s
	f0i+rpsiUaszEZ/6iwc44RPf7hsuVZnxZK/K1a3myWEA2kgrMgMJUkYI74FJag==
X-Gm-Gg: ASbGnct64qIWX25VVhuecDN2bV3U7bHoSJv7scDqWqMLqNTYeVFt+m+4FHFys8zfduY
	D8bmFdEw/z+zbC7ks1tC92FfyVjrkJ1kwPlBBVeJZi6Vtk2HauZMvro6tOLRjGa1ome7OZORLSV
	kbBpG51vhzcF2cX5pKaZKgnpPeC10V7Bhv3mqPAijCkgxqV/b82CKpp3HIaNbMmABOcLShDxE4F
	xhvLKhdMDXl2PzfWLsBlnIL2RilxjJZyObCDzAwsFqKQjMXUsT8E5K4kLLCx0H+HPlrO23X50WY
	HfZdE04oBhkVh/rPH+DioqL88ugh5WB+KBzJ6WRszmutLe9HZu/W0asMQza7tUD/i3oYHa71+7v
	TSWXNEKqagx/7C+Ro55uNsLn5rTMHkgyRoCpRQQ==
X-Google-Smtp-Source: AGHT+IHqR6H6hGlhBIo+llhw/Xp62JQQganbeUcGmSTUmxj07G0xPfMfOfCq/hwVCYGyRadAYliVeA==
X-Received: by 2002:a17:90b:1e10:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-339c27bf6c3mr944772a91.34.1759445645587;
        Thu, 02 Oct 2025 15:54:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebe5f2sm5955236a91.11.2025.10.02.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:05 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 09/12] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Thu,  2 Oct 2025 15:53:48 -0700
Message-ID: <20251002225356.1505480-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu locks have been removed from cgroup and task local storage. Now
that all local storage no longer use percpu variables as locks preventing
recursion, there is no need to pass them to bpf_local_storage_map_free().
Remove the argument from the function.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 3 +--
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_inode_storage.c    | 2 +-
 kernel/bpf/bpf_local_storage.c    | 7 +------
 kernel/bpf/bpf_task_storage.c     | 2 +-
 net/core/bpf_sk_storage.c         | 2 +-
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 2a0aae5168fa..5888e012dfe3 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -170,8 +170,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4f9cfa032870..a57abb2956d5 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -119,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index cedc99184dad..470f4b02c79e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -184,7 +184,7 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &inode_cache, NULL);
+	bpf_local_storage_map_free(map, &inode_cache);
 }
 
 const struct bpf_map_ops inode_storage_map_ops = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 572956e2a72d..3ce4dd7e7fc6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -917,8 +917,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -951,11 +950,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			while (bpf_selem_unlink(selem, true));
-			if (busy_counter)
-				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index dd858226ada2..4d53aebe6784 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -217,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, NULL);
+	bpf_local_storage_map_free(map, &task_cache);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 7b3d44667cee..7037b841cf11 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -62,7 +62,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3


