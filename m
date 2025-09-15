Return-Path: <bpf+bounces-68431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFDB585F0
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD82A393C
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117A296BDB;
	Mon, 15 Sep 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxXNeAys"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997C296BCC
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967514; cv=none; b=rrAn9i303u1qEQBcajr4CNKXj+nuei1a7uGUhrPD1CTIeGNlWBomJKLZ9zE/8YdHYkm274raswadWOxqHhqPIgnuEVbQTBv9lz5AEt6XIkB5Cg2va+Tv+V/eqPnU5TbJTBQwGMBIvST/VDFPm85SVbQF4kxh2y1aESa6USHgH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967514; c=relaxed/simple;
	bh=h+ALXtpP2NAlcrQ6yGv/RegILDHUGKVWENXa+weNO6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz+vz5JDJMrHlILRn4dS5GJBT2tbwl7UnBK2nPEOuh/FNHmEuDiESROAT/DvqXdqJemmTrD6yujEywCU1+MardcEiuRywjzheho0ZpJpbkNT7BDWrkTtTQ+q0MFnMHTDbTvf004lS9VWsmFzEXoCPBZymQwn86+gMl6jrcFZmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxXNeAys; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45e03730f83so21808705e9.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967511; x=1758572311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueFzl/U/bDUIr6CSgD6Ai8w8T+EdgbFSg4eSa1t2+8s=;
        b=lxXNeAyshi0BUqvuXWigIy/jnyMvSMTB0Mj/sKwChKpke+zkrEgcqNFFhNhaAtCM9Q
         by9bfX49bt4IEy5cu83WtQfa6rY3oMFnmfWNJnvzHVEvuX248fULRVOMXr0GC5GMnEaR
         IUWmyK7H5KbENJdHSq7AGNHtC9X8TYl5PuyD4kVX4BPDt56pjRD+mwv5aqb2jFV75NM/
         3/4C11EPDgBdSJt3UB09JVcg0pENUVi22R80qJ7hPC9WvvgVTWatkoZd9fFc5LE0s6zr
         7ZdqfL2vGO0JCce4Gp5tHVYNOJTdt950uy/yVlS199YRc9TW5loFu5dKhrbAnoaunXyv
         Aypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967511; x=1758572311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueFzl/U/bDUIr6CSgD6Ai8w8T+EdgbFSg4eSa1t2+8s=;
        b=vL4jaIgdz0KzoOvxeObjFiE6nPB+NRIsbTgL6TiqNCGtN0rjprcGybOfNxIDmE75dV
         RRWTM+YCTHLsq4Vld1Eh+5uXF4B1C62FgfyM10JKNurT5/0BhncDiyB0EuBZDnLKMpwn
         BX+sOCi4wLUc25vY4oLTExrnRNI9Np3QpSPqviJTuB7F7HkTt9mdguW0rrRtv7Jewnb/
         7G90oFZAfoBWdT695vUQEXWpqOeADh10bvUXpKIGeiu1GmnzL0ndjvojeT7ASX/nk4XE
         zRnhf/AsC16KegxVoZBZFYh7aQo9lm7Cy6Jw2tV3pFKCkvmWVZLlLnEbfjifagQaiuug
         8fVA==
X-Gm-Message-State: AOJu0YwS5nNXAgq6ZSkIvVmMuonxqq7ae5ymX0hdxIAxJMiMACYOOWsS
	t70H2lIL8Eg6wrF2xEQgFsMDx4EPb0xJzrKPmoMnVcPBaArLHGe1/NWsSvz2Vg==
X-Gm-Gg: ASbGncvTs5c8GBYj19ZS/IEgparsUJSxd9g9yxAVB0dP6eRJZOxE3NXtOI/fPK/U4Zk
	AysKf7T3CP76cakNmVZJQZ1NvDCsQyYm3VuqyRQKympPXTy/9lKhXXZLjz5Z1vBgJlNVzxkUZzN
	j/3CwYv2dBw08gxeo/EkNOxEtAS4p5uTPUn4tg+hOSYrGSINzZVQ4PpFZ91jHXVmX6q2uL+fiUo
	LT6NnKl93iUi4Ri0+GLCg9PlniYV+ixzBTgyoPR7Z5ocg3IwFlMYMOA5viSNVYRk/oxvkl8b9wl
	ndHGV50iqedyeWvu/fFJXWC9B3v6JN3nTmX2Zs+QjtmEOmH+Zm0DZqDaRyhdf1OcbZM7WU1s5mV
	mvnVMQnxNW7Ce2g==
X-Google-Smtp-Source: AGHT+IHDAPDLtBmwMERpqJarRqF6UDNKdcjerceTF1P3WdgpbkxFzGpf9Q90K2+FH6HdiaqYDtGVVg==
X-Received: by 2002:a05:600c:4f0b:b0:45d:d718:3b9e with SMTP id 5b1f17b1804b1-45f2165e852mr134564565e9.10.1757967511015;
        Mon, 15 Sep 2025 13:18:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm15452300f8f.58.2025.09.15.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 6/8] bpf: extract map key pointer calculation
Date: Mon, 15 Sep 2025 21:18:14 +0100
Message-ID: <20250915201820.248977-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Calculation of the BPF map key, given the pointer to a value is
duplicated in a couple of places in helpers already, in the next patch
another use case is introduced as well.
This patch extracts that functionality into a separate function.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0fddf7d0954b..5ea18509bc37 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1081,6 +1081,18 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
+{
+	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
+		struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+		*arr_idx = ((char *)value - array->value) / array->elem_size;
+		return arr_idx;
+	}
+	BUG_ON(map->map_type != BPF_MAP_TYPE_HASH && map->map_type != BPF_MAP_TYPE_LRU_HASH);
+	return (void *)value - round_up(map->key_size, 8);
+}
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
@@ -1163,15 +1175,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	 * bpf_map_delete_elem() on the same timer.
 	 */
 	this_cpu_write(hrtimer_running, t);
-	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
-		struct bpf_array *array = container_of(map, struct bpf_array, map);
 
-		/* compute the key */
-		idx = ((char *)value - array->value) / array->elem_size;
-		key = &idx;
-	} else { /* hash or lru */
-		key = value - round_up(map->key_size, 8);
-	}
+	key = map_key_from_value(map, value, &idx);
 
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 	/* The verifier checked that return value is zero. */
@@ -1197,15 +1202,7 @@ static void bpf_wq_work(struct work_struct *work)
 	if (!callback_fn)
 		return;
 
-	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
-		struct bpf_array *array = container_of(map, struct bpf_array, map);
-
-		/* compute the key */
-		idx = ((char *)value - array->value) / array->elem_size;
-		key = &idx;
-	} else { /* hash or lru */
-		key = value - round_up(map->key_size, 8);
-	}
+	key = map_key_from_value(map, value, &idx);
 
         rcu_read_lock_trace();
         migrate_disable();
-- 
2.51.0


