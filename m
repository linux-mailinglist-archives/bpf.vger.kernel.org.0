Return-Path: <bpf+bounces-65786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB33B28649
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD3B62750
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 19:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B617A2F6;
	Fri, 15 Aug 2025 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkzjDNF6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259E347DD
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285728; cv=none; b=iMgc5fccTGA4ZsOEoJ3asa5utc/jGgi3ydfY/yWG7ATaSg/OL1rCidgysMrrpq3LhyCBt9Mv7WdyQndDXpB8IS3hL2cPWdflX5JDMBsVkWbkJG7S3og2nAmIY80d+jICS+SEGpcg1w4C04nkJ/Xypfw3qQxQmwo3ogDc7x4cPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285728; c=relaxed/simple;
	bh=I/RkD3/nm0aMglb5HqBigEEdh14RIuemSOTiz8p+rWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apXFKhcEab/SorEMQ3xsfkRL/r+LwPobTlSMsQ0arXDFbT/3oY53C4QjnDXDWUPLo0jgGAae7d7lwHXFOLy0fTSG5kewJYJ3QxHCyzM6/4zuETSia9VdipUCQLM7HrXNi/+YhCNpHKaUSLjwRbAr1HngSOSlerBHIoiXFtTAb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkzjDNF6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so1232027f8f.3
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755285725; x=1755890525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdHAatA3wlLPoj481omaJWopzUmUBDDMnWRHcNMwmo8=;
        b=UkzjDNF6nYPfVtKKfxmSWz/1bM/p+5xqeqc/18LRIAAcdMw5m9AfVBqrBZnAIrGUMt
         DJmv+PZAH9JB1TEQ1RCKtIEWgLBnBFzdNwTMckZMA67ShCkRWWry4eoksBAGZCLBpwnL
         Jq2tyL0pJ+NWrnVtdCtP2tmSZcVDjV2kwqEHD1KryEVr4L0+jhVioMX5WFGzmVanC7lS
         UcgKAE2k+cVZ+q+9l+kE7XHGVeNkJjpWE7FWgsJmu75LB1gWq3RfO/JbJg6Wh463ieUW
         JFAq1v0fWqQLeD3bu81jMgHp8hgkNRxT8mXXkmRRWFB7wsHe4ZBcnpeIKcE1WzBImTpu
         KIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285725; x=1755890525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdHAatA3wlLPoj481omaJWopzUmUBDDMnWRHcNMwmo8=;
        b=F9YgcyH2U2brcSiYzXSnA5X63NBJVp3Wz+xW5DwBsFD0622hWnlplTQv0r6COYcY6I
         lpSizcgm7kZae8gocwp1ImYq3P9rVPXnf1lbP79nvcBP+6RXY/2oxUf4AyhujyUwC7dm
         P0p2M4u/u3442Ie8kJDRiSC4RoY3+nN+sq6fUYE7c+/GnwPurPaiRsf4AzVc9zDuay5s
         G4iCJb7n6nXVu3IptFBAP+gc6N/T40gT46BGO5wU0m4694ojnZmdGJbwiyExNljSEuwh
         UBfAMYT4PYGVTRruKQjsbBj6UnS7LNX17MnfyOaGGZDpQoeJI7HoB00ujNC1O7vD7DPp
         9XMA==
X-Gm-Message-State: AOJu0YxbTotn/CJ+BLpf7yUNkh/b5hY6YKAo7Km4+sEBv5QVjS1N+4zj
	w8QYbz8sR86YBfF8nZfL/kSppksUPjnkWQIxfYENfwtorfGjgO3jga8O6Epe6A==
X-Gm-Gg: ASbGncvQOnjq5qcg5ygFaAI/iFCSuY5KQWtdKGNuVuX8RYMPlnOyHn98LDu9jo0v7KT
	Xbilmhk4BcavqSRoKjxH6qB9Gsa12lUCderM/GLtjxSJmj7Q+XVY8rbDxCyw+zoZ5NZuUmIj4wX
	SGI+v/93z/udWNgzPfR7XaHfODDAIMhhhvDpwGc3y/krVlr+gXUKNlaccYSkMk7We7ayQLWOCWg
	BaMYpHpbo4qojO8xWDpV+eYFb9VUiCa2i9HaTgAfwLyoJkYRY1nRDplYWxEIgj6vreg39GylySN
	7L9NZBuY4rOI1nj+TnFCSjR686d2ii0ZF8JyaljZxI7i5XP4um/m91pY1WVfShhm1wl03UxoiGm
	J3EJvl1stTFpLxT2T3ueqWxq67cSHAqs=
X-Google-Smtp-Source: AGHT+IFv6DEaOaPNi7KEPzUIk2JxX2RH6neevl75uX01msM3sIJe9YT9AL19f1mp2qUrFz5tp/afew==
X-Received: by 2002:a05:6000:2204:b0:3b8:dabe:bd78 with SMTP id ffacd0b85a97d-3bc6afea967mr157827f8f.54.1755285724929;
        Fri, 15 Aug 2025 12:22:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6863d9a4sm2868010f8f.61.2025.08.15.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:22:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/4] bpf: extract map key pointer calculation
Date: Fri, 15 Aug 2025 20:21:54 +0100
Message-ID: <20250815192156.272445-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/helpers.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 144877df6d02..d2f88a9bc47b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1084,6 +1084,17 @@ const struct bpf_func_proto bpf_snprintf_proto = {
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
+	return (void *)value - round_up(map->key_size, 8);
+}
+
 struct bpf_async_cb {
 	struct bpf_map *map;
 	struct bpf_prog *prog;
@@ -1166,15 +1177,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
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
@@ -1200,15 +1204,7 @@ static void bpf_wq_work(struct work_struct *work)
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


