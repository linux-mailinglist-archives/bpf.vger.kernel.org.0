Return-Path: <bpf+bounces-67584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F390B45E7F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65A917D1B2
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C930B52B;
	Fri,  5 Sep 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwM0Wh/m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE730B50D
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090722; cv=none; b=o3gh0Shue2N1YZmUerkl0lKtm7/tKKfsOr3rWUH0iGkM4Do0yUAeNRHgYSGstJPSMflVuBavmlR1aXsQ36JorgE6I0FzifxC96r7LE3coTihb6btz0DNlifM92XllrdidOowE6Mnu1Vd3OBe8plEOD7WzVkj2yCQBIIWowYhe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090722; c=relaxed/simple;
	bh=neWuvdzL0M1tv13uBMhMlFhVMBJcs5z4KwQeRRgRcV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exfHg+exRxba7J3cXQn3nDo7xMlHaCCRfzZaxjyQC9vec6B0ULBThQIWa/iv/qV55TlgtS56ww2lhKhs2zGV90IqEAineuouJPW6VMozuRfUgED/gw2Qqx4R3EJlaMqx1Zj0LVInzBx00+hpfEAWjTQDJR7p8rsW0dndTFit/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwM0Wh/m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so13057335e9.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090719; x=1757695519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzi5aX5X+u+kM9sDJNvLjpNhhLGMf9gkI6zqfz6E2HA=;
        b=lwM0Wh/mTjTOgGB14s9ot5+HwFy3JCl1qi5UGtTesC6dx7vGLRXz6nrzGquHFwh+Dp
         9bpCq+PSDgd4e5wr4JQn/BtfU23Gjt4e44bs3Awdsa5zfqZzZdJ93RBwV/L3fcqLdBgJ
         YJBJTK+N7eRa8O0oBrjwwXtKAkFmJAnI2NW8UF1e9eezqRzgu1hKldeLD3AzqywLkboZ
         D0r3DXmy458MbDCf04JqQqDCke7LaSkA5nlkgjiwSlozUPxwXT0symPneMYUKOUSLtt7
         rYQgVXfZKZ4rJguvwUyWKoCl885ieIMtQbNL1/mkm2m7OF2dLRhlUVGm/+BHg+jJ9FaI
         Z/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090719; x=1757695519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yzi5aX5X+u+kM9sDJNvLjpNhhLGMf9gkI6zqfz6E2HA=;
        b=Z3Qazyd3X8dPqtjnfvWgv/PL0gvUSWTA91a3hDqOD0nMgpWR3Qpxg+HMNQTqnjC84q
         6rdOBiqpDRvUP152mqMAqA3ZspEAApRgjxh6eboK4ACuYH2/Jw8N/tva9HWe3mYBq6G4
         3uoeC3v7eOBhwLeRVJCz55qp47aC3bNgiTUvYDIW03foDE9Rb0yVIGU4OfpN1b+1r14M
         QJODbqkDzob/oi9gNorVSzbiZW8+zlj+KlKEl4MIfCmnFB+ha6Oxlx2ZEwVtplvcoTCQ
         DZ9DvSQl9B1oicHY6+z8b4JWgLj6mBGZAMYNkl70d7l4WttbyVfGEGhiafwUpgH2a7KW
         EtYg==
X-Gm-Message-State: AOJu0YxXWymoNEwsWmnGgBPhqC80HFhYqz18TKiWq0X79+DWXklamyT4
	Z59O2UbLZRH+5EAk4T5C6lkpTS22MopNVhq9uwnHe21i1N3ZIyVIw54ISIfzLQ==
X-Gm-Gg: ASbGnctUoIkn55rdpiK0ikhP4dm7T2Qs3SUwyWdeZNnPudrvTf+MEpVby8GC2BgtQVo
	Lvq0XWuUW3s9Q6+zQhaoHRzFS5u0sSiKxLyYD2uSNziuh2zTu6UnpB6TtfSRseRIIDLx7tN6i3s
	G3VvOZl2Hszj/iEpB5l5VwdGwAtw+hYmwWCPe9w4kjxyu2PajXEHGluIrGanecT+XMhkS1KsTID
	ed0dQ0KylUXzWdVg+OSIpW1XAA3umOdZLCODu6I7bx76FMcgQdEPmzET0uyWBPLEFtpy+IpDTpl
	GQP0tSJ9nBndyl0N9d4SwVYCrvvIk62qLMRmJfF+xcaHXP+97q/1/XigrYt0YvWvEPEdz+peh4a
	BfRgCFKSK4vC7x7+4Bg+P2Ai8YZ96g+0=
X-Google-Smtp-Source: AGHT+IHSv1o7kptVRKQiREPJnFRjoPXuycIOWTRD5EHXaP4AaFkvGGjip6afP6+4cO8E7SwpudAfYw==
X-Received: by 2002:a05:600c:8706:b0:45c:b523:5a09 with SMTP id 5b1f17b1804b1-45dd5b52cacmr39839805e9.16.1757090718498;
        Fri, 05 Sep 2025 09:45:18 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddc315d78sm7181295e9.4.2025.09.05.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/7] bpf: extract map key pointer calculation
Date: Fri,  5 Sep 2025 17:45:03 +0100
Message-ID: <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
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
---
 kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 89a5d8808ce8..109cb249e88c 100644
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


