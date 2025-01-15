Return-Path: <bpf+bounces-48900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B4A1172C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EE16801D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6A22DF99;
	Wed, 15 Jan 2025 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0X/YzYH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D222DF8C
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907504; cv=none; b=eMs4plaxl8WuQZu5+XKakzyn4xY6hILMCn74/Ido+EPcj84B0ueU99+wxfx068N+C/aMwedNZ6ya3wMuTOcvNoHUe3/8dj+mTNSQEQlaKD45OeDkOuiwMRIeNCM3TxGmFUnpgrOirmESL3Rt/z5n7BdUHYuTkaemRIjudN+5b60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907504; c=relaxed/simple;
	bh=8E6kbq+nXTYfGXRiZYASyUuGhjPSs+DxNVZms7tjApc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBjNgkrWa7D5OPlZ4HJKmuM1Y5gZ/nXtX7aRWupq6PDqolPsjxW/Q2C66+sjUz4Nde5J5+0xHBsg++1Z9ygq9D5AvgPay3WxVdiuUPSW3O0hCf0QszmrgqApwOnDhsDrWi9/Von23aJwDKs275j16K+2L9SarQiv5SWKpKDjbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0X/YzYH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so109020325ad.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907501; x=1737512301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8dNygR7UFFvbzRNwqjbILq73kIw4oFHXTY0L0penA8=;
        b=P0X/YzYHYAhcc5ugiL5j6ockAGRRyxVaGcJbFx0yn8+FLosNvEWriaq6cdumqqHgcZ
         daAm7KM3weGjUWg2QAIA1L3BkrzKZZuyw/BaSPRlE7KQ6mRw8uGulq+NknqaBIKgRBl4
         Em3u8MnWZq1O0PA/fLCYhy8WzsnrsBIekVPK1gXi8YQ1wBp+2l7ZU40IhF+yZ3+CWZ06
         4oEdEyd3+l2bBvHIebgZnXlJSxfrGbAp8l+asgGlHnel9sOdeQ5pHM1+sjUXTPqdFu9F
         PL1g/802HdbtIFBk1hTo89jpxEOrpN2MT0YOU+V1K0vXxoM2Ww6NUF/p4BPhYS5YAog7
         BHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907501; x=1737512301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8dNygR7UFFvbzRNwqjbILq73kIw4oFHXTY0L0penA8=;
        b=cGnk6welKRQYVRLIW73yCe9YXMRfJUHLYe2FNX63YBpAv1JTb+RsO2HRL3U8n/xD5Q
         4XwBjEAjWmrMJ+Gn1nW7Z9PNamMKoRc186LAgT9rlgb0qs+aE2M0uME6IDbryeeoxEq8
         m7kTvcIkgrziFnr4jDj4CvP6i/fNkQNfKddCQDiYnll45NHUPFK23yHEHfI6F/dIBlff
         8D4f1KpOJ56XixhBZCTRF2xHpN0JpGsYJ98cbjV0GMwEeLIsL1w/cpOM/4bvhNBZoF/h
         zDbOR0GaBv5YU/CbjEvXTKmxgndg9dbeJYzV2Kb7W/AxguMJVc0QD2jhsG8fduEp0tHS
         UTmQ==
X-Gm-Message-State: AOJu0Ywq1m3uRFmD/SoXzHF+ogxf4lsau53zz39Cx/Ddmaouw5Sxe4La
	FOH9wcGenSlkEuDpf+pGVLpgaCfiXCOhgWxeN/G+Prf6DCcWXDXQxcxRiw==
X-Gm-Gg: ASbGncu+WPCwPOYZayEjFmcYyCvc1QYdz66AnBuuRYJWfJmx7RUoEu6M+zJbPdCjid8
	U+rWmHOgb+spmSWEvKd1GoY79IjmRUd8x4WYhEghHTHk6D/S38YCRok/pF/XJ8buxOJO8w+ElDN
	m+Zrpdv+MARw40waxhqP+hLBRYtkaQkphepFL5uIGlspZxLLi4SEhmk/Ahpr/cWHA+hTOJ700Bm
	hY8b2RsCKbkzEcZjeb0gHAck9aiJHymXwLRgURvyXRUrk7ZQJeT84GpYM/IgKcy/HgAqQOF53j8
	AWCEa/Zz
X-Google-Smtp-Source: AGHT+IFwyv6v50tn9W5bSyzXASzJW2tC+n3Yvr284DWZQwO0ZzTjXDMbHxo/pZeBv3MUI9+RJdh/7w==
X-Received: by 2002:a17:902:cf0b:b0:215:431f:268a with SMTP id d9443c01a7336-21a83f647e1mr449439745ad.31.1736907501257;
        Tue, 14 Jan 2025 18:18:21 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254040sm72719235ad.232.2025.01.14.18.18.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:18:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 6/7] mm: Make failslab, kfence, kmemleak aware of trylock mode
Date: Tue, 14 Jan 2025 18:17:45 -0800
Message-Id: <20250115021746.34691-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When gfpflags_allow_spinning() == false spin_locks cannot be taken.
Make failslab, kfence, kmemleak compliant.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/failslab.c    | 3 +++
 mm/kfence/core.c | 4 ++++
 mm/kmemleak.c    | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/mm/failslab.c b/mm/failslab.c
index c3901b136498..86c7304ef25a 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -27,6 +27,9 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	if (gfpflags & __GFP_NOFAIL)
 		return 0;
 
+	if (!gfpflags_allow_spinning(gfpflags))
+		return 0;
+
 	if (failslab.ignore_gfp_reclaim &&
 			(gfpflags & __GFP_DIRECT_RECLAIM))
 		return 0;
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 67fc321db79b..e5f2d63f3220 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -1096,6 +1096,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (s->flags & SLAB_SKIP_KFENCE)
 		return NULL;
 
+	/* Bailout, since kfence_guarded_alloc() needs to take a lock */
+	if (!gfpflags_allow_spinning(flags))
+		return NULL;
+
 	allocation_gate = atomic_inc_return(&kfence_allocation_gate);
 	if (allocation_gate > 1)
 		return NULL;
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 2a945c07ae99..64cb44948e9e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -648,6 +648,9 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 {
 	struct kmemleak_object *object;
 
+	if (!gfpflags_allow_spinning(gfp))
+		return NULL;
+
 	object = mem_pool_alloc(gfp);
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
-- 
2.43.5


