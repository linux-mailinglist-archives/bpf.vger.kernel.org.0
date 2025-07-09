Return-Path: <bpf+bounces-62729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC46AFDD1A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB0F5409BB
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10C191F72;
	Wed,  9 Jul 2025 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDefO6mY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17283A14
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025991; cv=none; b=b7KJ+vecIYd/GwO5JaPCOtkuryKPFTx4GJWDhG4SORLzOJNaFZH0T8aU+SxW9Davu9iEUNUvq3qreKwmuu3NKgY4xUFDwqv/k+WjQtt+aIyeJSuiZwybELtejlW2ypxPa3ZwewyPeLQLUjwBflzWa+dtS6aAXo/MEMHC3mDKT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025991; c=relaxed/simple;
	bh=LJRmmqmhKuGc3u4fO3jaC43F0Cyz5CMI9vm6Dl///go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJZF/wflXyZ2arFcHy+EV9Ljy0NUSDGNfvEm2zHJv4IiAniXtMruRefy2k2lyBIio7ZP+M4EMzBKuD3WO9574ZQZTipXoDNcTMnr/4uDDY0H2e2Rrd14t9T+69T3kS0NAYdOhpKRx4XiQ1S55wEgeTbMSDdqrQ7zb1aiER5P8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDefO6mY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2779284b3a.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025989; x=1752630789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/+X0DXw9OUm5wzNulgieDQHWxYahBqcZn2zhcA2wDA=;
        b=fDefO6mYLXUj7jUXpyGArKylnKTXWcX1I2AUq++SdSJjZrjFqjzyto5vTYRjsstQA9
         pE+SpLR9ucZBzQ64px8V7svzzA47qAwQzuqSoadcfgPCEFK3J7xp+a7xLnodVvkzb1Ui
         JZEsfjE33um0ErN530oJ69nqfREZ3cfJFvk7Tat/7f4oG0htbXeu9UBU1r7KDv91bN3Y
         v6ES1uRskLUu51D/0XQLDarsbpwKd2Z6Zd4VwHkk1JmxODwoyrtHk9Zj+knlIEQSk2HH
         sfzquTM6rz1A5lYoAQJsAqkhW135o4YIlYVO4+pUzxUD80tCmpnCrx2bnPAORd2NosRm
         vuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025989; x=1752630789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/+X0DXw9OUm5wzNulgieDQHWxYahBqcZn2zhcA2wDA=;
        b=sj9GFXMdde8rzJI2CTk/SVfDASi0mvDn18CCzc4BNO0zyoV88ng4/UQ/hrLl3HmQVn
         RsqTnT5IVSsYRGvTQ4sTs5vD0N/or3K0TWtkV1ziDi6d/t44Ayj+gk/t2Lg5Wg35Zfq6
         FbGX6lbnAO93Md60uuvp+UlvdCMY1W+sVwFhpzRuqIHoeZNKyGfdGI0el6FTtuhGDbgg
         1YA57kprWbHPvn4v3fEsh3RWAKUqWBJs0Ba0ZXabKvUd/QvNsnOa+YEzBMHitF1TkdcI
         E2Lb5L55v+f3js3eacrMGFNNmhSR5S2kZbDWMsSOYTMjivB0O6FlUR5Gr6lLmvqx1ivB
         /jMw==
X-Gm-Message-State: AOJu0YyFbwcmuVB/zqa3ym6Yz6w2/ISDRXxNwgnTmy53D0Ix3BAuQwLE
	3qwgqBGTeK/tpxd8yMvvNouw8A3O0IUPZ8VeT+Hxj2MGDUr7k3lFRwSucFSBiA==
X-Gm-Gg: ASbGnctnVUGk3sM4i/7jcj1EPc4VIqXof04ix59p2MY7A+P/qUg6Isg+Ce1SIQJ5amZ
	H0vK1XZMrtjXnuuhv8MGL7WEoE9UjWG8oDwLTiGzNSkG4vhDbNbV2RmZPTIrcIGj7+rTHwsbISR
	kWMyPNxiqvQYgr01U9Jw1eIMr25HuAa8ePVodIIOMA6ETQjfLvnL9VNLD38gFHVUIoxgDU8u4Fl
	aZdz1pEgeWTqHKpRXCCp9mkL2AdONG4eJ4gF14y7Y8tIaNh0qbWTcenL/LsrkhT6X7GL3KOi+7Q
	5rvjzg1h6COgusMk2qFr7KUmXHHuh5ql9AJ4OCUtc9nRlLJttSmN1mhrQyn+rUpAtl/B5g8/yk8
	eacIfL1Enk+3PD7U68H6t5RYn1Ew=
X-Google-Smtp-Source: AGHT+IGEp6q46XZSMJuTp/cGNB3vfUy3QkwFgTTL+IYrvCA/HXzf91RG3Roch9rLK1q/X7AwuKsMEA==
X-Received: by 2002:a05:6a21:62cc:b0:217:4f95:6a51 with SMTP id adf61e73a8af0-22cd7770afemr1029281637.29.1752025988514;
        Tue, 08 Jul 2025 18:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417ddebsm12860927b3a.84.2025.07.08.18.53.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:08 -0700 (PDT)
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
Subject: [PATCH v2 1/6] locking/local_lock: Expose dep_map in local_trylock_t.
Date: Tue,  8 Jul 2025 18:52:58 -0700
Message-Id: <20250709015303.8107-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
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


