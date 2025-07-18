Return-Path: <bpf+bounces-63685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BAB099B9
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EC17B566F
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126621B4156;
	Fri, 18 Jul 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9JhUYWR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6370825
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805014; cv=none; b=WCP6Cy+duD5Zn+E0chnB9clKM6MORIO73E6nDRihZ2sVIDJ3whr+6DA+/oIdAJwHtJZMh1vH3THzfiWMiL+eVDsfOCCTGgzyC+YqStv7mv4ReXSJtsg6tWeV8c1bJT8WdxHQ8uhA7SvPnl8gQE4/rSeERA+WPCOAtRUNu58fmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805014; c=relaxed/simple;
	bh=oPpc/owN0nnybCG8ZrOpKDTYgxnCo+M0v02f6gECNLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enH8QWPTJCRAYQQWUm/EC+CNkYDfhmxqM/UZXRqBmQ9a8nQ6Xt6W56ObVXGo9UOIPlVcSPLHN5es0h/tFbtptUQCKy/HX3AOMpH1XfW3ROocJmvuafLj2RuCEBNmbKNTdRL+DUbV9sPGBzDXDvUXQOHdvp7d8aVUicnysGmAYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9JhUYWR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso1548870a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805012; x=1753409812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIhGNjzYvU0LF9WvNv9O3HmVQLiCNpvjb+HJX/OSNPE=;
        b=G9JhUYWRXJKVEEkQgAWcWKhvwZuQ6XVwygiouyoUth+kcXdCL3VsUqQnOlYPDCBZ3m
         3EUfmLRg3qZ81o+hWYa8CAsrKI8jYhhlQkuAT0kO2r7S1cWt2bmqbbe9r7RnUTJ5Ye4I
         iwq8RURICLR8+He4bL5NZPN80wUay5XBZUDkNt4fwW5/g/p8WGodRT7pz5065h2QyFue
         HqCddKyp+a62JXXAjicym65d+hXE33KlZf4j+H651lAVq7EaxnUjfS7hl9J1N/9PV74x
         u49bvdG9w771tg08hjsUMi3rHQ2ZFBWjKFAvmqC7zeqk2TflqatbIONU/MP+JDWkJSp4
         AE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805012; x=1753409812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIhGNjzYvU0LF9WvNv9O3HmVQLiCNpvjb+HJX/OSNPE=;
        b=P7bGrFWV8Y1YOMq4nVNvyj+rY73m43mFQgMLOpew3R6QHC//+e78yYppwSmvLWRHYr
         DRAElofAugTR49poEvCksQWxWU3G6uiZGZqDN/qORX6ikZXlvw0wTB5wjxKCgh7spRae
         cO/JHMRoYfQdwcjDTdw9p/AUIC5oV3ArCAFzS7tq2fP3EH+XuFw6y0MVFDYZP9KS9l0f
         pt7k67dD1wRpm1/vEzYmFy37eoiiEz3vZ9InF2XWokVQSKrigOOiTFuqAMs0k8sRqT9A
         +/0Mp25yvlH6vxEhwceqUsanhVKuzFUAC8ULIAovYZazS/eSvEmf0vNvBnlafgJmvY3o
         sosw==
X-Gm-Message-State: AOJu0YxHg7rp24eFCzepZFIb2fTzMn+pEQkJPlqNfLRrmynqJM5ATz12
	oyC4sNhMmrQ4kIxWFClnv4niCYy6q9agMzBs2Nl/IMxyizvOtT/VON8NBF/PhQ==
X-Gm-Gg: ASbGncuPfXzAbiIZJbwVPfF0NBUB5MVhtwOjyWmHn+x/8PiAQIecRLe3bKliUDLJWle
	f6+XrLP/r9OEsKt6CkauKe0U1E8kAi1ftHbmCl+MgbRdEg4HwVrMkhOgIE/z2S6TYadaNfYc2O5
	Sq3eVXlLHtNrxWUmZCGJh3xfj9w8iyNb6t+oqSej7M5ep1MCgeQ6X7WDWDHCPYEj1SRihghsHfo
	2mlJ4vLK/w057e9ytdBW/7euI6/rkgbGoPHY6n2enFjIzgBApXkFv18N+wOKlK3Yi7LbQOdAT2O
	wN2F6zxqdRcbsPPbSTGiO8h7dCFa2JHJAao63Qks5aSrY/s7mZWM0YafEj1McQfUUHqWwT2SzbV
	HW9FrqsTEnRYgjHur1MCuH+xby7IRjl6P0vahJg72el9KoPNtfJaWovGn4bPIbEk=
X-Google-Smtp-Source: AGHT+IGUTr2ssiwc+Q/DxQkSyymIb/HkWdb6h+t44qN6znpvcLwh2+OCFlaQX/CKqvK+LvFsBWCg3A==
X-Received: by 2002:a17:90b:4fca:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-31c9f48a301mr13192447a91.35.1752805011963;
        Thu, 17 Jul 2025 19:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f162d5sm214591a91.22.2025.07.17.19.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:16:51 -0700 (PDT)
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
	hannes@cmpxchg.org
Subject: [PATCH v4 1/6] locking/local_lock: Expose dep_map in local_trylock_t.
Date: Thu, 17 Jul 2025 19:16:41 -0700
Message-Id: <20250718021646.73353-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
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

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock_internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8d5ac16a9b17..85c2e1b1af6b 100644
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


