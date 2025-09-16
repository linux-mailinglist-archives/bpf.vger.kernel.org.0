Return-Path: <bpf+bounces-68580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F94B7DCF2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AF51BC83A3
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9B2F3610;
	Tue, 16 Sep 2025 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNUy3x2m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EB2D3ECC
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065833; cv=none; b=SXmXk4unXC+5wnyLxQSIhbpTuT9MDDb64RNgLgGp5x9m7hxvXk7plfC4F6HxupJK0PxGwA3ZaIto/mOVtBX6fOBbDN01Ap6ZjqcWq5DPAxysJS421qYC67vhhLiiOXCHAx+FyevQGQpVWwGywYDBpmbdXK8M0ykUwptSZEoSj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065833; c=relaxed/simple;
	bh=h+ALXtpP2NAlcrQ6yGv/RegILDHUGKVWENXa+weNO6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiQlneHvllpd3IUFl3kYHSAfIME7z6U6P6IFLHhf2AKawekcOCaa8LAylumsm6AZ3+NiJWpN6rfmd6spKdwlV6YQMrmOMufauCIA0lAnqSv7JCKEw8VRZlCVZUCi3w/DBUDmmIm2yXjOAb3LzBNDYgGz0VIc4C4T1Nn/Ze6Upww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNUy3x2m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso60371255e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065830; x=1758670630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueFzl/U/bDUIr6CSgD6Ai8w8T+EdgbFSg4eSa1t2+8s=;
        b=TNUy3x2m/wvFH48pmbdF7+HZt+glBE35jmDmjg2e7somOxqFBc78EvSk6KTzL1EqB6
         9AMn8c0F4LiQDHrmiCbTan47h/akc83wqg9zL0fKbIVmf8UK85c1QZZUf+Ht0M2HXigU
         e019whxbL2S2CbTVe2iaEmls5349ZqjjW5kyu3nVQnQ2s87NDWlMKc+QN3YgUEexVfH3
         wX8P2DvDDZnnoT1u6Ou1fKulmb2J6BkFL80QIbdTLLUlFJ8pPgWoXjoAyPh+h0pDwmwB
         vpzNfzHow94tOb9xvNAl7wlg8DoVH4aBKwU+NOUDdqFVESB5j/g0/pSqW5x140b4mLpJ
         ZUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065830; x=1758670630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueFzl/U/bDUIr6CSgD6Ai8w8T+EdgbFSg4eSa1t2+8s=;
        b=NDHRfg/cOHHQZGY2kzVQkyxzE8m9zedYMZvOWiXZJMB6h1Hcstjwig4JpJzs9w0eHg
         cctV0wghOgDLfc3iPAzXTs5Rp9cs41jFHuWk2wKwlNiWoajgf8+9hntPjWFtQCU0Bnl/
         NCIKaOFcRGUYuL9vkITvd+Fsul8QlFegceNvfWS7TBxV9crEf0ItLQG4DXY/OMpaVaXg
         7YideDfLMTCmoCK95ip1LOpH8g0xvymyoZBYq9eqsh22/zlQQIRV4jZhqLzMv1xtwGr4
         ybj3+R3EIFiHcjVyZ3ETCM09Se/9puK4eXENushySTS6YvvahGQLBrFpQGmKIKQ/nSvN
         ZG/g==
X-Gm-Message-State: AOJu0YyZ3IKxtCMqVHP38c+dqIybSWklKAgOM/MipC6bL74NfKZ5I/Sh
	XVep5YS0C5MHu9sOQhMoHnQ7ycujbGI3LI5xZeBN7XlQF/B7S/Zuz67MYAYdew==
X-Gm-Gg: ASbGncskLHGze+tLUjs9C8USbBA8jNgDTMM9IAd72S/qWMg/g7guS+lM59RvWJAOG2G
	jDF9DjavyqkA3obsTLely2or5dx6V1j3hKEP0R8gZR2DA8cYW1i+sajXXyRXiKxJdsWrRpztZIZ
	zm8F84Sul9f6MeNklkmWI0sHFNbTTLMqw8444q+ryPJ1nyybUFkjPO+LNVVMTEIuper5T78ndzU
	Gv88oHQFOKhXCI2Dd9N3mnzNtssd4dh/bzd/pVegfHt2oqXU8vx4AlZtSRk2uFSKb2mGNox/06G
	T1pqh8/V7aQjcH2M3j/OryZy9Sc2wttDOfkCTbRYRs6eNW/tjBM+XZj8xhDio0DIwrI+Fyt6tQ4
	pij8K9TTiPVR3NdDdoqW0xA==
X-Google-Smtp-Source: AGHT+IFcJABYXyvXXd5g07vKWgU2h2dV4Gc4xMJbXOPPzguvGQFM1RDvUt9GDd2bhAgwXSYxpjXKiw==
X-Received: by 2002:a05:600c:310a:b0:45f:2919:5e91 with SMTP id 5b1f17b1804b1-462037705d1mr840315e9.16.1758065829989;
        Tue, 16 Sep 2025 16:37:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm8601259f8f.54.2025.09.16.16.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 6/8] bpf: extract map key pointer calculation
Date: Wed, 17 Sep 2025 00:36:49 +0100
Message-ID: <20250916233651.258458-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
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


