Return-Path: <bpf+bounces-67825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE760B49E72
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEF44E02A8
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFEC2222B7;
	Tue,  9 Sep 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVjR2i7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1721C9E5
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379631; cv=none; b=f9TEhQ7awmOi+TLAwMOAPoxMXfqdrKjRw7wIYcSuMJMzWNEJsmELEYv4JFgt+zbbptHEtFY5yCx8Pb70NQvrSA913ZPMoYZ9HjxG07lvlyIkzU5gHodW+ToY/Q/dehHqFrTk2HY4bLvNFyHV+yVXUFJC8+nRLBlq4QTer+PZg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379631; c=relaxed/simple;
	bh=4UcLZuCae8FTnFGQm1X9lnZGVSgxyWXY2Ge0iKX34SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPCPXbeXi0k1gUTynJz+4jbg3y92ZXYiTSK69MRq+J6gEtJ60eVPHZeFJ6comiVfa0lXQ4/44aSq2rIK35LM6/ZFB7TPqh8b10YLnoTrhIDjYA1ts1tkIAbb3+YJW7TLc3XfK6YDlpoksR7sky3uFXoF5kDscPMZCh8DuROIWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVjR2i7n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-327f87275d4so4911049a91.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379628; x=1757984428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxrQ50WwxcJf+ZNsWb3xAkAINo/uoo8WPlO+broFxXY=;
        b=DVjR2i7nwAzCyvsRFL0kIpzoYaDxJUnGfX7qOlCGiLZw7GksUsShF4QDjkxgZyDJv1
         G2WVdOH/Rg3GzzQbbaYSEQ2m5FRK4pd/kS1IZSwwa4PamwYTR3zkUqg7Kel+EwijeP90
         ZwnKbEoFukPyulsWOn+ACi8VcqoXOTd4HKBNOGGNg9IiyXuOzBBKKNnOixTj/DbSLsr+
         XXFowPeCrtIjBJGW3ZfP3oqsvKrionFWPO9xgfi4IB0DA9mwAzGgvCETr3swO/X8gy7c
         sujJR8v/fQShz6m6j1CxkJspMcOK0WoEkkxBPGOwcp6q/BBcYyGZw0YmnH1hN0KPt9ot
         U8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379628; x=1757984428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxrQ50WwxcJf+ZNsWb3xAkAINo/uoo8WPlO+broFxXY=;
        b=gFg8epReJhrVNg63zMgfF9+jKTKF9ELhBJBh/itnLSt8xESXk4Kkakxb0BsnO1SX7k
         zBHnT4jTZ01dTnMLji2PGOMG1FYOQkBhM197xc327NJPRJtAKSTDj8GgdscvzbFlnR6Q
         I8Vbi/umYn82aRZCyv3XeKg/Szaf5NXW7fGd/EdIfhs8BYyg67N6ni9ToXMJ7X5upbJo
         2Ww1Q7YKAJ32vUgePeZSvkhztsbjGNmH+NpN9qf9genTa6Ht3Ua9iBxdkmD839SbZPXe
         z4QZ70PAMdi7vSHKNoBF3GetMyE9jikAnHywVt4eI4NPLvxverZ8vIMKxRbiHQYBTxGF
         W0rw==
X-Gm-Message-State: AOJu0Yz4UzckUq5yE4+fzj3PdR+Uc6kn76NQsWOf6Xmm3kUdueLOm/7y
	pGMQeigqC2zO9q4TlkyVXfHB5Jc7BaCiw4ym7sax9eVnuERYTplIvDrwCSPjpQ==
X-Gm-Gg: ASbGncs5WgCNozy+IfL2NtWQKbkdz5tzds8UAtr00w5orHv64Jri16khN0ijTfYYssO
	L5niJ/H2ouKAzUKPbWkl0iQDlwIkm/w0VY6k/BcvfozF+WgBHqLeKspqiJeTnWbRURnoIr/9USN
	wNBkN5kPizHcWW+jGrOWSzMDwLym5VUCLGap02KDhQucbBBnAixOabwRrgtnDVqmd6PQNiJMq20
	PZT2N95lo6Y2OxRnvJxnSpjwga2aKISelb0EcMCZ6Py0ACcQY8ibACVv98us9QA4/YHajKS4BBV
	Dfh2Tya+WOda5Zkd/s64ficolFDJ00U7deK8rKsK01W2lMFpjGqkPcAdh0Q72bGHivxwoDVocPr
	XesL++A3dnYH5zmpLYo/7Wl9DRuenqf2epVqFI6jy9eM9cEGcU2FqinDmUUpZLRw=
X-Google-Smtp-Source: AGHT+IFeNRsm2QUYba1YavtLTYPQrodCKr9T+9C2GXnH04y7bOF/iflwDTL9GGDN4Q/Rcq7n4vEJ1Q==
X-Received: by 2002:a17:90b:3d81:b0:32b:8edb:12ce with SMTP id 98e67ed59e1d1-32d43f18b0bmr16536473a91.15.1757379623296;
        Mon, 08 Sep 2025 18:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e673ad423sm24264403a12.50.2025.09.08.18.00.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:22 -0700 (PDT)
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
Subject: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Date: Mon,  8 Sep 2025 18:00:06 -0700
Message-Id: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Since the combination of valid upper bits in slab->obj_exts with
OBJEXTS_ALLOC_FAIL bit can never happen,
use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
instead of (1ull << 2) to free up bit 2.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/memcontrol.h | 10 ++++++++--
 mm/slub.c                  |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..d254c0b96d0d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -341,17 +341,23 @@ enum page_memcg_data_flags {
 	__NR_MEMCG_DATA_FLAGS  = (1UL << 2),
 };
 
+#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
 #define __FIRST_OBJEXT_FLAG	__NR_MEMCG_DATA_FLAGS
 
 #else /* CONFIG_MEMCG */
 
+#define __OBJEXTS_ALLOC_FAIL	(1UL << 0)
 #define __FIRST_OBJEXT_FLAG	(1UL << 0)
 
 #endif /* CONFIG_MEMCG */
 
 enum objext_flags {
-	/* slabobj_ext vector failed to allocate */
-	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
+	/*
+	 * Use bit 0 with zero other bits to signal that slabobj_ext vector
+	 * failed to allocate. The same bit 0 with valid upper bits means
+	 * MEMCG_DATA_OBJEXTS.
+	 */
+	OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
 	/* the next bit after the last actual flag */
 	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
 };
diff --git a/mm/slub.c b/mm/slub.c
index 212161dc0f29..61841ba72120 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2051,7 +2051,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 	 * objects with no tag reference. Mark all references in this
 	 * vector as empty to avoid warnings later on.
 	 */
-	if (obj_exts & OBJEXTS_ALLOC_FAIL) {
+	if (obj_exts == OBJEXTS_ALLOC_FAIL) {
 		unsigned int i;
 
 		for (i = 0; i < objects; i++)
-- 
2.47.3


