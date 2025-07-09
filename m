Return-Path: <bpf+bounces-62732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E57AFDD1D
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE23A176FE8
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B351922F5;
	Wed,  9 Jul 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wXKVDAWT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2F19066D
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026000; cv=none; b=j1hqR6dFyydO3zY9+6zEPdP7cSaq7KevQaNfqtOTNHZxDiSOt2+PhmOUT2SZZU0PgCD5QgFBMLHdYfyXAh/Iv20P7aqrsfsMAUWKY972123TF5TDbLt9s2E7e8lw9Y/FZjPP9xH0W6TtDcxEO1JC+rAjhunI7Wkgt/Rc/73B1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026000; c=relaxed/simple;
	bh=14mSjPg4+F4hRyuI4xEiSo4AjxdpUORz/4rjdErLhVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdpmSfFZ0PW5SQDXR+6vtS23mGX6xrhLJgm9MQ41K0lbvd7nho2cXtL72MvOvAn/26ihZH03BcR4Q31+tpDh0uk2ewuwIKIKR+0hzvadcBlZMLBvz+EfdK3PbvyY697c4J100ZKuYbe0ax9LSW79SwY9fRA9Ew1FYkY1jrKlfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wXKVDAWT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-702b5559bbdso26072496d6.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752025997; x=1752630797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qSob9Nyh3DPUpqr3bgVvc1lDKTweoRVLhNXj727VRA=;
        b=wXKVDAWTqLhkiRTb1Jvs9vqTJW26SQDbeD4RNEJzu9QgKoYdwLgKSh6Ugd6Lb0HxSX
         SN8LuNlQJJXLHSMcEA3SqRybmLeuYxtjmqdukeKYbdDqelcqdYZVeSZ13L4YwkMFK40f
         VYyVqrHBLdDTS0iMRKV31+YSjWRLx3lJoOBHuHsn9SrW5Ss/8Bwc9lPyJyFuJhZ/dPTp
         FyJxqfChejfI/Lr/xKnVI9fi2G6tSus9xH5vJb3UMztP+x+y8UyAgmGkYYuaYcGsaGev
         v7nRhb18w73vFhNzYLcGCkmCBA3YAjihzaGAwRP7l/f7Aj9lBTSOqRymvtYJbKgw+Cic
         pxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025997; x=1752630797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qSob9Nyh3DPUpqr3bgVvc1lDKTweoRVLhNXj727VRA=;
        b=CHvIuuBJTuF4KfBEYZCG0c317qdKuR5bPMuwmqikOqLpqG652M/L8mNsO3wtAR++Vm
         YOuSamczVMoo/+Dtl65Va2rQzOwWXpqc/czU0zXss+lwUlstschT31xe2yMT7s3wwnyT
         RqGF9wma+LbXI8llMPE0Q3uHG/IPhjwqa/Ui92cK4HRywIQXm7vuEYVbKCrjvbhJhtga
         HdcSDhZAqs3M28AsiUiiqTJAbF6L05EkWgVQPFpbcoAJ5itfxQPyeXCvavGePy5oMKoT
         +bRGh1KxKccynoJUCxdGEjemmNCqva/Fm5n6WJcorMuUyU78UEGtRLPNv4kadQ9dTnsr
         FCCw==
X-Gm-Message-State: AOJu0YyMPAx04oRNuHHNTrRyE2ObKfo+/1GaL3LEaMcvjKpjfw+GH9LK
	hoaH4xRI6YTbBQtnmeBP9RHe9yy3S5kYhMJwQRWB3MkSNOOACt4+GV6SFY+VGzoC14C73YPkNyX
	9GQ1heBU=
X-Gm-Gg: ASbGncvLu+qhsa353tP46FgEIk3WldkvFtWvdRjEYbtI4by0HHPQose4u93mwhbyLhL
	uMOchVr3iPsCWKdJHyF6j7DJewlHVX0hFa/W+mFMva9KzQq4KmPTdOEMiRyz0PNnYrMF+GERE8I
	mPiqj7lIR6rUfOYwircu33WTk03oNw+UIpSuda5UghkvxZlwbTWG3sosvrF3lNkzPb3kHCwWkXS
	SgqQIc5lloHbOsAgDBjEJNN2J0PFNnKkbM1ulxWeHD4W4Pcn4OzavwwIYBJD52uZIfywl1Jqqhm
	zv0LeKerM7vTmB9wqM6vGbOj8ejnEy4f2GLK7Ga6y4c+4pZcgcD0paBx788=
X-Google-Smtp-Source: AGHT+IFmzFzYTN+HTRV6NkCX1NzXE/BEBG8mzGeElHaL7LTTVX0TFJJdAKEItjKMK6aiO/xtKJhXeA==
X-Received: by 2002:a05:6214:29cc:b0:6fa:facf:7b7a with SMTP id 6a1803df08f44-7048ba03e9emr11938726d6.42.1752025997120;
        Tue, 08 Jul 2025 18:53:17 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702d5e53246sm59807986d6.1.2025.07.08.18.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:53:16 -0700 (PDT)
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
Date: Tue,  8 Jul 2025 21:53:08 -0400
Message-ID: <20250709015309.96742-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709014751.96274-1-emil@etsalapatis.com>
References: <20250709014751.96274-1-emil@etsalapatis.com>
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


