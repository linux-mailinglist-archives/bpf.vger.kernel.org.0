Return-Path: <bpf+bounces-57108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64446AA59F4
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4FE4E38AB
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C732144C9;
	Thu,  1 May 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSSm8+Oq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93461EA7EB
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070055; cv=none; b=TQ3mjLIFPzI4IDi7HBUA12SEKi9qsVs1k7nHVeOeBHbgxwNS3gW4qxv8GiWu/OJTySzRBs9Qus11fJoF889zZqH0mOPkFsbqNcfqANUEAXqx/fxuvajtBCbhUxqy/fXkqpANNXapMaCSUfEf/o4BvOBgErbhtOl+wbKDSMgFo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070055; c=relaxed/simple;
	bh=b+8g285xUkwTGgossD3Ll+us0kWKexwTfXuODmNCExY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WNfMP3BvPfzqnqdd1rbTOi8u2ShyiZRhuM172ZatGpUHewXlXsoEnVaLt+zmCPGGDN/VR0F5SzGijmhXHFUFe5Exid+DWBN0PxJfJgkis5YKXyZMzG5uRBiBTKqHRrwbf3H1vITUeF0BI+iPXMRIHmnKG25iweNAKaVH0q9bNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSSm8+Oq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b0c68092so547532b3a.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070052; x=1746674852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CpmOYXMv5x8HYoOMD/LQvY8JwuNTkgfKlwKcaFFw3o=;
        b=fSSm8+OqsSsq05tHySzmz9TzComqzUSmz27StiZSoZxYUZ2GD1SuBoUMQVtpvdKMfs
         efbRVBUooGf6wuA57Tsy3u3XBE1QcJLFiJdCwJ+UX8ZxAHflMDXDPS9g8LUVQTrI7rZg
         l7vYH5/89qolcxBgFqGNiB/WN5jtPLQYYwUrULSfdZvWNA+mrB8zp07Fjyuof7lJONoD
         WW+/MjR5MLn36AMhQ0fC7kTfCM9Mww4FsW+hpUcQ/k0+pAy0CQ5iJVQ38yuQC+C2FhOv
         eawZwgp00WAGag9h65DCK2ii0Of6pNff3OWURc6LDlKO7EvPii6i+LyJnrqzk5zmARiQ
         GBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070052; x=1746674852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CpmOYXMv5x8HYoOMD/LQvY8JwuNTkgfKlwKcaFFw3o=;
        b=S+OSv8AUvIiLpVdlkEuRA8oy1kQZWXJmt22o7nlrvujChykYljsilq+DSaH3HpVMUr
         xwfvjKyZ3mjmiIFt81kT/Luvgk1iT4Qk79zag6xJ/TBvT20G04CqUbugcbxYeGwmFR83
         J3tu0oV4wGDeJXQPVyPPeBolW49ShYNSF1/6H/t4DSWGWSr+hNZ4LcDE3LQ4EjITDLvl
         ZnJFkxCdP/IW/4rpDsVqIbwKTniJvdafyoa6FxEAJ/dSQNTi73y/+TeuTL17G3+M2+Q5
         OEJfA8vBhx9JbVSRoUxB9ICaiKxN+DOoyuczj9G8fnym31nodWF2cxwCiZ4JPhpDGTNX
         /L0g==
X-Gm-Message-State: AOJu0YyQ72fMt6IcyJ6QHjTxMl95bFiHJOAoJxut29YUWbu/mQud8QAo
	b8HEzy8ytRBvJkx9HD8WMo9BvMVpWQvvZ8m0wfOQdLXNXLar1ltwOKw5KA==
X-Gm-Gg: ASbGncto90wEYKqiNM9mCBkCMdG40WI57jqpkRt2K7AkQkZ7oiJ7sZmcZ8sOnf6XM6o
	ga0fQs3bBMIkC0nI2cRa3F2KjX+JeqXeUbFpeO9Uesu+SCV6rUd9w2NLQZEiCT35Yp8PDEmXYkC
	Exmv9HnL8jFW571Xjtz+89p6jRzKChoCPOP+mklOaFoHqgcYGu7FUfQdwS5ABaYKqtuxpsSq2Nv
	3gp5g/9W55Tw9Hdpf2rgkxboPGbQsUjFfhEMLPLU3xQAwZGWqhmC+jha/ubWG9m+Xluo/x8v5PQ
	pi7zbmwsizdBLmpeM54+DHx7unXGiBnslwgEFX9s5qMiouzmVOjnzpmJyQKFFk1HNh+m
X-Google-Smtp-Source: AGHT+IFBsLSR9UjK82PP1SOfVwgSoWZe2g80w5yd+JPZHymgn2jNwMPlxeBbDw1xeyqzVenZQOLNNQ==
X-Received: by 2002:a05:6a20:3d81:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-20bd714ca4cmr1667057637.25.1746070052456;
        Wed, 30 Apr 2025 20:27:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a5c064sm2494215b3a.123.2025.04.30.20.27.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org,
	willy@infradead.org
Subject: [PATCH 2/6] locking/local_lock: Expose dep_map in local_trylock_t.
Date: Wed, 30 Apr 2025 20:27:14 -0700
Message-Id: <20250501032718.65476-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
is a top level field of any lock that participates in LOCKDEP.
Make it so for local_trylock_t.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock_internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index bf2bf40d7b18..29df45f95843 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -17,7 +17,10 @@ typedef struct {
 
 /* local_trylock() and local_trylock_irqsave() only work with local_trylock_t */
 typedef struct {
-	local_lock_t	llock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+	struct task_struct	*owner;
+#endif
 	u8		acquired;
 } local_trylock_t;
 
@@ -31,7 +34,7 @@ typedef struct {
 	.owner = NULL,
 
 # define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
-	.llock = { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
+	LOCAL_LOCK_DEBUG_INIT(lockname)
 
 static inline void local_lock_acquire(local_lock_t *l)
 {
@@ -81,7 +84,7 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
 
-#define __local_trylock_init(lock) __local_lock_init(lock.llock)
+#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)lock)
 
 #define __spinlock_nested_bh_init(lock)				\
 do {								\
-- 
2.47.1


