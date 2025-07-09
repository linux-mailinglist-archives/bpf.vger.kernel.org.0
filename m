Return-Path: <bpf+bounces-62737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96DAFDD2A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F009171929
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5B198E9B;
	Wed,  9 Jul 2025 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="uS9T4MUx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7E137932
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026240; cv=none; b=U7B4zq+hWz9HFUwXADVHeOv/ZPNwheSYeYkW16PBdJjV9eL4G9zpAwkcj7+h3crG2TrWa5zFGcvSbfJhiQ2trLqmotpjyYnqRTvKa+hCPYdAzHCuWXMTL26iXOhjfzwyzIlqlI2mjTgNhbNJoVknGBSzwrhNsMYVZyEKyiI3GAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026240; c=relaxed/simple;
	bh=14mSjPg4+F4hRyuI4xEiSo4AjxdpUORz/4rjdErLhVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoxOwqC96Z/WDGFHg1EdzRW8v/3iu+TtWxGucXpa310Ju0vTRkRNcLjAsS2lNneTuXWavvkeDVbDsr+WIAF1wIpulJJZwhlaSD9yxhUDkiSk08bi3udmDu/+HDciV2I8In+/K9hzJ7htAdmvK7gcSUP9qlWVw1LsKvj78rxpYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=uS9T4MUx; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d09a17d2f7so454629685a.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752026237; x=1752631037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qSob9Nyh3DPUpqr3bgVvc1lDKTweoRVLhNXj727VRA=;
        b=uS9T4MUxj5m8t5jiiekSNWRM9E+o0h0swJvlD4aPAYpfAUnk2YhvtHeKoAHlQc8Vqw
         JxoOMlIilpArn6kifH8DVqq9Ff/4JSrBmo5jPbANkwK1tLTYWAfz0Ebdj0W1rQ5IGz6Q
         U9RbFhU+8oOX8SBa0V9kZdW6VIdMO+UP4GzXdhxySJiIImguZ/wnOxXpPsqP8s+LibBA
         wTERi895A6PYcPG0Indpdp2NlVd76l39Qk9g6qV3tdtRru28oJ0ICZPUlKez09gBv03T
         cAb+OK/HFPpp9RmdivnVQqJyU+3oyaT+FnSfazZ5qHEzaobxqCdxyDP7hNYx9U+YD7/O
         DRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026237; x=1752631037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qSob9Nyh3DPUpqr3bgVvc1lDKTweoRVLhNXj727VRA=;
        b=QMZA8IEgKcApAvWoHzHMqWYT0rFiNm/z7p2gBtW1enq/WCNbTzZBqzbIcmM9qetld3
         tCC7CcJq+JooLS2P2y4DVmtWs6AY96PXjdGuZpeO4ehtBo0dCbn4zI4P/DW9VzPpB3aA
         ambYc1iMipl+5a13sX4u3vlFPdWr+NWxV7iHcUADHz+dSeldgskbIRWIOxSLr6ioNVPa
         Zrn4mT5Jnng1ouH5kg3kUwPdTXAPGEqCD9FZHzKcUFkq0opajPuAD+GT0h50+R5md3tN
         LSnQdecLFSADTs6ZsgQ/y8XCT72iDjU5LQeou1CP9Z3dQR8smv1d/qXu2Uqs4mLjylW5
         /L9g==
X-Gm-Message-State: AOJu0YxhrD1/kxsymq+lTdztTCBJpr4ZUeCJa4plwhr5bbiPxqdXVb1g
	XsP6t8LkJH4iMfxD+t936KOMh6d6G6fgpzojnfNrlQvmcevCBnvIqL4s/w8H2hOZefeOG9EM+OH
	sUbJkiYk=
X-Gm-Gg: ASbGnctepPaFWUXSpJGFZ3iMmZ3mW9c4kGalRlQZzvprKBmPwAslU1MmtCx1pXwbArK
	Y4r2qIVtM3w9cIGMZNyPRwrbsdcC2dFWfGG8J109SCxJVzb8Um8DaPgHNBtJHoqmxUypSeka9fN
	54p5SlzZACGGcqvfW9BBkPu+djxEffMVz3QnE6HpXDVjMoUjzQdOBdelLoe5MLPWy95fUkGJ22P
	o1bx8zk6g4v7P86SGY6DusyT36iYRdZI9y/ewpXJdh0gfAMYJzs/SP9CQwm3mT/KJbIEFqkGTE9
	YHUEaghARnkec2wCHvOA94ERsJBWw6jn98JWiFmuxr80xyj5ptoruAbDgcM=
X-Google-Smtp-Source: AGHT+IFpUwDIZdatZ/BaqotN+PuflvVC6MM3PjG04G4hWM780MZL77EvrlXbR8bYEE8depQMTf7d9w==
X-Received: by 2002:a05:620a:1a27:b0:7d4:43aa:6a7c with SMTP id af79cd13be357-7db7dc6ec53mr132921185a.57.1752026237521;
        Tue, 08 Jul 2025 18:57:17 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a79106sm92041421cf.45.2025.07.08.18.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:57:17 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
Date: Tue,  8 Jul 2025 21:57:11 -0400
Message-ID: <20250709015712.97099-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709015712.97099-1-emil@etsalapatis.com>
References: <20250709015712.97099-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF arena kfunc for reserving a range of arena virtual
addresses without backing them with pages. This prevents the range from
being populated using bpf_arena_alloc_pages().

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0d56cea71602..5b37753799d2 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -550,6 +550,34 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	}
 }
 
+/*
+ * Reserve an arena virtual address range without populating it. This call stops
+ * bpf_arena_alloc_pages from adding pages to this range.
+ */
+static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt)
+{
+	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	long pgoff;
+	int ret;
+
+	if (uaddr & ~PAGE_MASK)
+		return 0;
+
+	pgoff = compute_pgoff(arena, uaddr);
+	if (pgoff + page_cnt > page_cnt_max)
+		return -EINVAL;
+
+	guard(mutex)(&arena->lock);
+
+	/* Cannot guard already allocated pages. */
+	ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret)
+		return -EBUSY;
+
+	/* "Allocate" the region to prevent it from being allocated. */
+	return range_tree_clear(&arena->rt, pgoff, page_cnt);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
@@ -573,11 +601,26 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt
 		return;
 	arena_free_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA)
+		return -EINVAL;
+
+	if (!page_cnt)
+		return 0;
+
+	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
 BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_RET | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0


