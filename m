Return-Path: <bpf+bounces-57109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABADAA59F5
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D81BA2F2E
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E322F773;
	Thu,  1 May 2025 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNJu7kcn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C631A0BFE
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070059; cv=none; b=NlVNAygxlM/P0SmX0ERSSJpgE6EjliDpkyyQG9iX6TAZuvgjik6hS/BfmZA3Y3UC5pGw2zUua5vzOlaSdu6KbzNtqXq6UoA50LnRaozmfi+OwrKDigEEgkvhAaBRwnYyuO+Hbox5mUFRBp4B6MOOT1fX+UzkuBvbn5l6L+hS2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070059; c=relaxed/simple;
	bh=HjIfpQRxFrxMsvfABCrtIU2emn1PXkFONVOG1N8efH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtifrBIJ55Oo6dig52dqQRp8Xj3T/f5BIXVJ4hTiyGd5zV7pjjbYJIPeLQMbogiQMRahyI7XUQycB9HuB3a9kN+MTp+lvI6LjCuN3is1SV0AxHooJD3Pqxr6IC+hkb/y+TIcT9QwPq0CIe4QqaguKOCOR9gF2dx6qjBCjFCa3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNJu7kcn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33e4fdb8so4790825ad.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070057; x=1746674857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs691KFuj59Fa11CnnK5tGag5b7DiKtSdIZMyxxJPso=;
        b=RNJu7kcnNJASzcmK+XSCqbts7dBsnLGugsNUIYFhVY30bCjIWJRpi8Vx+8zEe5toSI
         vKfDp3YUAON+IS6wx8uwxmvV5ADtWKhsL+w12NBHFFDz2KKSZuQxF/gq3XNzscjK2e2Q
         OzBZcnnqLeDaHEkIUfPPFpHmO2EnL6nx6flW1wUbWj0+LsHTRigR59iV1uXr+LhBlPz7
         VyK7eCci2Tj1JYom8neSUjruRKmBFqvNGalfg/NXroSNVdaXD0YCTLMby5ZYJZ0xK++F
         de6rIX7iXNeShujeyNi29bLjm5L16OCD6lGAJvyWdsV4cwAXaDWt9oFU/+dh4hhhohHP
         DZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070057; x=1746674857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs691KFuj59Fa11CnnK5tGag5b7DiKtSdIZMyxxJPso=;
        b=vFg2lKAMLXuEpHtuo691ots6YZtX3hKzzGUXFYrPY7OCnC5CqsHYBa1oZVBI6Opvb8
         FnfAKkdh0Offq2e5KiSWduKrY2zAACDpnMHE9qT4VQm4uhhlf2pnwO04zu8+r2PWOEhe
         aN4snhid9iFtBO3ox6FYVb2Q0AZF/Xj8kX/ztceRV43eniusG4XhT+ZTy4Jy5iWBNptk
         h7a/PWhuhspIL7Gqhyi9S784hxntCg9MsGgVyyfZDfk62cKq5CVA68BN1trRBls8qTAe
         sJTAl4VWoLEGxWzHsbAzuuQM3zJ5G8xjuolmU0ZAGey2GlwldhnvoykPNZtLc3vxEQwi
         GZyg==
X-Gm-Message-State: AOJu0YwCMp6hXyl+53NFDNuICzf1F1DkKwhnqa1hPhvc71gGZxvQYLSb
	pw91VLuL2gyBqc/yTXbvj7F4wGjmEXa30j3WbWCLjNscMoxDeZE8L5iNXQ==
X-Gm-Gg: ASbGncvnIES6j4GTsWyZtSKPxeYObYjrKXi88vFwyXOTqFt91hWOG+A4ZOPfKUw74yG
	rLXb0FbLknM+ctw9eTyLbcx6grdC4nsCaFVn9i1f/rK57+kwWbE5E8kkb+Cmv/XG5jX9akpPLAa
	4ZskiRohrJVF0j80uQMGHXaC0sHSVdnJGwdf4vIYfrzBKDzdZQqQIkf/x1lYSP8ybMfADqggUXL
	vVmkNlohXhA05qS10/4OgvYLiXSG781z60r9h9EkOvcaymQ0pXX4KNcxFQAC3fliZqgGSMiL229
	0QHTghSO0hF8DNSVo21URNyXUVcznBg3kGXvfbr62Ak7E3mwou5kbUuhqwQD828U3fKC
X-Google-Smtp-Source: AGHT+IGd8wDRcYgmuk/xHfqNy1WE/4i6NTFWjhvcaNrsimprcVMvtuHAbomADDuld4pfi74N1ofJlA==
X-Received: by 2002:a17:902:d550:b0:223:3630:cd32 with SMTP id d9443c01a7336-22e0864a49amr16883425ad.53.1746070057161;
        Wed, 30 Apr 2025 20:27:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216527sm130652965ad.223.2025.04.30.20.27.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:36 -0700 (PDT)
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
Subject: [PATCH 3/6] locking/local_lock: Introduce local_lock_is_locked().
Date: Wed, 30 Apr 2025 20:27:15 -0700
Message-Id: <20250501032718.65476-4-alexei.starovoitov@gmail.com>
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

Introduce local_lock_is_locked() that returns true when
given local_lock is locked by current cpu (in !PREEMPT_RT) or
by current task (in PREEMPT_RT).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          | 2 ++
 include/linux/local_lock_internal.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 16a2ee4f8310..092ce89b162a 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -66,6 +66,8 @@
  */
 #define local_trylock(lock)		__local_trylock(lock)
 
+#define local_lock_is_locked(lock)	__local_lock_is_locked(lock)
+
 /**
  * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
  *			   interrupts if acquired
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 29df45f95843..263723a45ecd 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -165,6 +165,9 @@ do {								\
 		!!tl;						\
 	})
 
+/* preemption or migration must be disabled before calling __local_lock_is_locked */
+#define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
+
 #define __local_lock_release(lock)					\
 	do {								\
 		local_trylock_t *tl;					\
@@ -285,4 +288,9 @@ do {								\
 		__local_trylock(lock);				\
 	})
 
+/* migration must be disabled before calling __local_lock_is_locked */
+#include "../../kernel/locking/rtmutex_common.h"
+#define __local_lock_is_locked(__lock)					\
+	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
+
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.47.1


