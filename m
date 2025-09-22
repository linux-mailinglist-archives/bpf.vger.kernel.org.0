Return-Path: <bpf+bounces-69284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE52B93931
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B857B0EFC
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F32315D32;
	Mon, 22 Sep 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9772QfV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87A2FB09E
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583589; cv=none; b=t9wDu0p4I04rv9aCrZkILEGaDmngQIZ3RnMU2qHdh9DYvpf+Tm3LVA2/SnH4a3mY/8+tjgXvkVTzFX5mep9p1yZcc0M79Cz6pWZ08z8HsZOjXytrQ4mTTCcb5n85BDHnp5+Oqdio57HqvZ8N8+HM2D0n3I3tyjpHYx1lUwFWiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583589; c=relaxed/simple;
	bh=cnu9r9VFMwxE//kQWF8MD4Wvh+Hn0DFebBHljMWlEEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6HsVyb4GPxXQHEDn/xUOgbdBicC2yJryBzoSBun5ZUJ31n0ABBAlWEVSPF0EWyBVZqPFGDAYONo/aP0anJoOdUSjIMqcyQfmf3oCnznSghWKv8VrFTeXCUXuvixoOL097DHlBTxs2PJYDNVBCbNgKfuDEEdrJ5oW3GjZVcD5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9772QfV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so6448632a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583586; x=1759188386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkahzeL9cMvliCLw5mKRBeX2gXRTVQ5tFjbWEwW37GM=;
        b=l9772QfVeYcoUVomW2mDzDRStNYgckNuhDRps3dYXpTjQM9yzzFaA2V65YjZwDQqqF
         qLQOWdAJf348B/bprVhqgJeRIhorUPtl+b95iPP/cqbmNWaz/GQfMOJPz/zfX+9wa+uP
         /8DDzaXJkKrFLN2HJDq1foUfitoX4jn6mWWmt9kx4u7VXAP/oS1bY0ir2Kpr4yD6+pwQ
         UD06C9nlXcV3/eGP1tNnAkYt5E9BZRysJiMTRw0y5JPjX1MfgOheMT8lH1A6UZxYlg4+
         t3ddHt41t2sDCOdU2YBIKyONlTCCThsG+56CLEObD1B+QxbUktL52uyG6VlKba1zr9K7
         PG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583586; x=1759188386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkahzeL9cMvliCLw5mKRBeX2gXRTVQ5tFjbWEwW37GM=;
        b=Cs4pTvYTY2JepdYtvz0GXHXH0U4ddUqq0U4SIsRSH0/Sqtj+DImyofTDHnaJrAd5M6
         2NREilNKsE60XMWOK+mgkYjfQ8NKf0GNtgnLDh1wJB6bTcPMqUH5fYxMGyF8o6RjFDrH
         n+zGpOIR8krUvAOkY3SOO2kyNdXGNf+AWsuQM3R1viQVpZaja9LPZORxXvzYdrxzaAYv
         nqJHm2zWipPc7jnczxaFd9vKBDsN6G/fedBFvgr4LW2RjkWdFdEMEWm+R1wZPtJcuxyL
         ik+viTqMMgeX6Ip/aUYPlj8z8+JSA5zoWzB7ss6rpsgyke8I91HTZg33KFMxgXOiwMD/
         UlMw==
X-Gm-Message-State: AOJu0Yx9MpVZdFCq6mKJlsOHoxXfy5+rgFwtpxmjE5uHt/bgj/gJKEdc
	dAFhXQdS5wqLIOcTBrZVU6GyvSMZNYC61zNdXmD71NV0C6Zl+PIDhcUaOc1g2g==
X-Gm-Gg: ASbGncucc9T8gObShSQYdXFP9mRP/mfhHRLejm5IFkrmLSXwDoSki7Hfurhn6Gt6f/w
	DPNYQ3NdnjxM40oZ/c3zUFwQAMZhBrDT/+KKmpHnI4+b/mCQ5I4jaQMEqoTKLO66uXjfVbvztWb
	ysVv32ZYqZzwHZu32KJaj5Hbwq1XUsjwIj6cLQ6+qsxTAXtP6XlQaY6/jzWLl3FXS7DOchPBy2/
	NaaaI/prAtHzovwPbdyfTQsW9nUtHM49F3W2VN95wqmNuBWf6ArlZoAZB/XdbFMf02Y3RWfRL55
	hOd6j4qlsV+1s4Z/8rG0ALv7oTUwtM8HU8n02nkcZJ7GoDZZvNChsdguZhXFlzpjiD8FlD8+rXO
	xCjkN9G3tBm1px4Hk7A+c
X-Google-Smtp-Source: AGHT+IFbUGwn1DvcBie9Ru6AZMoRw5juqXfbtbfjRlH92g7Os9V8Dphf410WrK4YAa44nW+kpstiew==
X-Received: by 2002:a05:6402:20db:b0:62f:a87c:494d with SMTP id 4fb4d7f45d1cf-634677f730amr461572a12.27.1758583585710;
        Mon, 22 Sep 2025 16:26:25 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f14e64sm9648644a12.25.2025.09.22.16.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 6/9] bpf: extract map key pointer calculation
Date: Tue, 23 Sep 2025 00:26:07 +0100
Message-ID: <20250922232611.614512-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/helpers.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d9c9a33dbafc..6d072fffa89e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1082,6 +1082,17 @@ const struct bpf_func_proto bpf_snprintf_proto = {
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
@@ -1164,15 +1175,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
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
@@ -1198,15 +1202,7 @@ static void bpf_wq_work(struct work_struct *work)
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


