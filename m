Return-Path: <bpf+bounces-63398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB3CB06BB3
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03397AD080
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077E2749E6;
	Wed, 16 Jul 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClPZJ7cY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626612E36EF
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632998; cv=none; b=AHr9MTvVazXk29+jzWKS9j24vtcE6lDghACFMLroLb0jYJ5DD652/Wg2I6njb+lxDSm+siccjbtG6sIEeX/A17wX22N0vq9oogtgoesAWLpedZGsawFVPSPmYaQIQ8/OoD9Q1keRUtz2/+W+QDZUCuDVcdzPQUOoJCSNjfSXFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632998; c=relaxed/simple;
	bh=oPpc/owN0nnybCG8ZrOpKDTYgxnCo+M0v02f6gECNLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLohwMX+tv0BPe6VjzRjU37eXUIkJkbMbMzvnyYkPaArShdj0NAWw/U79QJqmP27Oa0vnJfK1oRGqRpWNYGFNTQLoO2MdCZCTVTXtfeEnNXyTmAn9bFY61461GZaLECMUCb33Y9km2RK7uxvjJ0Dir61K5l5ZiX7zC/ARX2zJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClPZJ7cY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4622208a12.3
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752632996; x=1753237796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIhGNjzYvU0LF9WvNv9O3HmVQLiCNpvjb+HJX/OSNPE=;
        b=ClPZJ7cYSf4wTm14knzXiWD4jhj8K4Iz5o929ofBK12+ihpaduYytEsRbr0ZO9n2t5
         ptnvQ25uRRPeaJJSCvgK3ZqYjH0KL1AGB1AVNfLUWCCIY8A0rYhL3pfX49haLi2vXrFd
         7uAhXt+jQN1Ip9z7RzpnS3STQG9gh/yGHOYLH/qMcM08sudgicFIYOH0/PfkZRqFECDF
         WNF6uLrIZWkCxZVMzUiQnQAt1SJ1X+/WHVLBAoaKZPryAZ9wVjTb8dtssnttvjUctOAQ
         Uh0kYJEHCE5/aTx3SGD90mJYxE8R109wUdZCf5woZMu/XcgtYvQG2IOCIBN1n8D+BdlR
         bjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752632996; x=1753237796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIhGNjzYvU0LF9WvNv9O3HmVQLiCNpvjb+HJX/OSNPE=;
        b=Xo8mqp4EMv8uB+xnVSj54u8bOGPV9VOfeoCzubF8sgK0OelobK7UjBpjOTw4s0axmI
         M6PtoFKUr0PzK3c9Z8TAWkc0M4LZKRogSzApWeXlxlJaFkdRg6fymkE61Ji43kwrQf2a
         bab/Tm/mkqipmkdLHQbabmalOTkOH/QSfTFJ0RAFsqZjP4eN+XY6eDV9xBnVu3zTGCn/
         i3naYl7vol8QZPoQGWseSKovT/c1c/YaXK8cR4xlalB9xowNtbQ+wLvJLZdbrVyRnIL4
         0Smk7G7MAkhBKhgaZDCxizFeSZ4/8NA4o+/ATrnYd4nnDv1ZI1HSbS6i8sl7CGbRizAZ
         NsDw==
X-Gm-Message-State: AOJu0Yxjm84YQNJ7aBAADkDD7To/yxg36tYOGCIzsKsiwylcvRLzVWno
	edxFWnCePuPS41vKnQFbb71CZ4PBVsBCkFOL7NS8MMnkofOp3xZZcqZWbCuNOw==
X-Gm-Gg: ASbGncs7ujzBQVbMyRGuH14lEymY68kqg/Ic4pg2dhQRTJCp0zi84OXhE+5KgR9r6of
	Q0MjcImIWUPIsslxIGJeQIfkkynULwGayPxPHUewPFrGWUa7ZYxoUQcfeDT7LiByTdh0e8K3Wrc
	QRBZvUb5Okq90sIWnZQGmVsCaFP+b58nC9N2p+sk/DAeyO7aFKDj8b180LwPqBm7bGb6x9hg9ox
	qpzYNZn9rSD2+7Ev0WVQIy87feXIb8kkK5AsuA23eNwpPxMu3aVGtbj7AGFNNagsNv5mdVEsrS6
	LEotq1nGF+ozd3IjvA9uLY20GFeeJmvOIaNOBp5rwgtEtlgTdbsaOqfa8/oSoyMFvAFZS6b6eMy
	HXlhYCdh6pQZaYUKYzBhKZlx9hWIaPw4g46YcZDq1dnFPohG/Vgld1eCq5k7tMIznTZtFyuAMUw
	==
X-Google-Smtp-Source: AGHT+IHCbDCnBNsYFUrlELiNVRR+WQGwclzTbTvrNbJRvXa814XxhR4RgGxtQ8AbYbbnq0npyYXQAg==
X-Received: by 2002:a17:902:e743:b0:235:e76c:4353 with SMTP id d9443c01a7336-23e25000edfmr16416005ad.51.1752632996321;
        Tue, 15 Jul 2025 19:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1fb8dbsm307910a91.22.2025.07.15.19.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 19:29:55 -0700 (PDT)
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
Subject: [PATCH v3 1/6] locking/local_lock: Expose dep_map in local_trylock_t.
Date: Tue, 15 Jul 2025 19:29:45 -0700
Message-Id: <20250716022950.69330-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
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


