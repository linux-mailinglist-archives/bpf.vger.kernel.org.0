Return-Path: <bpf+bounces-65130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E443B1C7D7
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71A716E2C5
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E361C5D4B;
	Wed,  6 Aug 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpxs4uuR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203218BBB9
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491579; cv=none; b=CxyJmio6zbOnJHezA8VIvKd85HqZLbMTpIVP2uWOm1hcLb7t6o56BYJ2Hghqmi3t/BnZWU9LzXMKh63gscDUfWW3nD38rStGfyBiDIXj7Gwyhzo5G2GRMNprgEwdX8t2pG8EOCCv0uQy8/ss7SeCePWe/ZxXx7OLIqsF1wPIhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491579; c=relaxed/simple;
	bh=uwKkFwN0XRe0Crs2S4sNr35ojPKgEclF4rkbL3OSjBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM66uGDh6xZuWYUZaN4Hl+0x9ON1zMnd9t4NrhlT3QhAQCHPtZIeLBj9vxv9HNLUjjHZmS78GVl0mi1/gPqhPJq9yIMzhf7kKEY9twbEZQHlggczN5uKNlpPuicmqa+5qUiDegyZ408RpTNOIrdiOCrJTReEp/ItXDwzUcbQ+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpxs4uuR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b7920354f9so6261828f8f.2
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754491576; x=1755096376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=080Y9Era9H8/BrYn9vl2qDiO8zcTDM7gXpUeiSJz39o=;
        b=Wpxs4uuRf1vu+1L5qXoM1TTaycTQR1LPSRiEr3Fo2QnPK0RJJ/0bttVvpdsUJcFomq
         9g/5cgaYsBFwyTMXGrjxi31BtCuiuq6hH5SnV+xlN/7s3WhbpkgUMot4MHSY8rxVt8Ks
         h0Mh5gG0oqg/fEncEQusGb0v/z3uS19FtQP70lDHjTwp4wsEgiAfSsilNxqI981P3Sty
         +SQXkbGO/jmn862tFGLDXxtCohSZsG7mUKC3rb+vKpNoYJDcRwWLQbI29ch9Rv2KHWXp
         NernyVhuJZ3/SYMDuDIfMssWJ9/86nIipVfSbCxnE0XqM4q0zoOxqifCx7lIsEFPVKnC
         Jrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491576; x=1755096376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=080Y9Era9H8/BrYn9vl2qDiO8zcTDM7gXpUeiSJz39o=;
        b=ninGtaMfLYLFZg+IPnuvFB4vhqlvkrDQCJRUZgoRVto1NnPcHMiw7o/gD+psMUpFry
         FqBUoJ9Ys31myC5cx1UilOdT2H4cUCfSv/psYO640IutwGx/09Djmxw5D4qMEK/ka4lQ
         CxKcwBNkdbVfgIOHOyxgCnYh20Yh+wBudhvWZKPqRTyVDCi52yMvVYa+6tI4801dPUzN
         Y3cv0o1mB6OR32jR7csWI50HgZStHiAk2lwYvPSq/P677MytbozHIDyxnIr/N4hT+FSI
         JQz0sxqBfcCGHiPL4NOc77Vni7skzl1gAGddgPl52KNoNS6wt2vULRJfMXBeRO4DqR+Z
         RAlw==
X-Gm-Message-State: AOJu0Yx8UcRSWcTUb3ESgfShGN5Mmo5vCnR5UtizVdP1FK2YCI3DREWK
	GFeKdm9nZbqbAW4ZpaND8jrqriYbLxkighq9JYL7hEfa17u3xzsa6eegcM2CqA==
X-Gm-Gg: ASbGncvJ3eWMaDz0HP+tnBWO16GwE53hMJFcGBIccQG3n4TdCnR5zBDTN+tM4iiaMSa
	i7Ra6iR07MQs6KYSjW/yNseuWuqEC3SVLAWfXi1friga2Z9mrxOCaNQny33DJwIgWxaTKCL0qk+
	eAKh72f7Moz6od6nLgjl22+bNeR2GoxZXDCp4qjSD4q5SBDmHbk42cRNfNC0WQaeyR2RiNTMNSF
	CNe9jz0EdC574YmPjfvpgDyz/tJ2j63pIlpesRJVQ8I30YKqweCmJyC8slYi2wDf7Ft5GEMk+o7
	2qbFatOYIaOozbOXSw6KdN8B+Vd9/XTEliFN966medstYcf7gniyrT0rWOkdTiHNOjDAyhNUGjq
	h
X-Google-Smtp-Source: AGHT+IFCZroNM753jZbUlspZ6zWWxMRIIQ0p95sW5jh5JzVm5lD+Pthv3Ae3jiGmGG6kYSJK6u8YeA==
X-Received: by 2002:a05:6000:4382:b0:3b7:664a:8416 with SMTP id ffacd0b85a97d-3b8f41670aemr2578189f8f.23.1754491575724;
        Wed, 06 Aug 2025 07:46:15 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:ba0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e9464f46sm9101269f8f.19.2025.08.06.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:46:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 2/4] bpf: extract map key pointer calculation
Date: Wed,  6 Aug 2025 15:45:22 +0100
Message-ID: <20250806144554.576706-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
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
---
 kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 322ffcaedc38..516286f67f0d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1084,6 +1084,18 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
+{
+	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
+		struct bpf_array *array =
+			container_of(map, struct bpf_array, map);
+
+		*arr_idx = ((char *)value - array->value) / array->elem_size;
+		return arr_idx;
+	}
+	return (void *)value - round_up(map->key_size, 8);
+}
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
@@ -1166,15 +1178,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
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
@@ -1200,15 +1205,7 @@ static void bpf_wq_work(struct work_struct *work)
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
2.50.1


