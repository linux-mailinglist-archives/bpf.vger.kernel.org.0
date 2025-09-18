Return-Path: <bpf+bounces-68789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA331B84CD9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD847B73A6
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64730CB2C;
	Thu, 18 Sep 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ArrKNA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40D30C60A
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202003; cv=none; b=HpjbJT/c88ajRxpYl7WAdmhm3WKj6AXbWcMTIoijmoGBkKPX6lOeXaRuO3xXnAZu93XAJWbLwrciKUj53KIu2D3hIVYbQ5TBlMgp3uPz8Q0MV4rWQpVByO6P3H/GO4nKDannlveaYuk6K1cxjVXK08vk4cAl39OpgqftADDHwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202003; c=relaxed/simple;
	bh=NjpQ0yeJoA1+NAhUJXzQsfFhggkzUrE5zAXXlao9ZJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXK/HyGY1k2r2BjKhaV70IUB+T/IpSezt0bLIrnyRKigack+KX6XOZtkKLMyziK+i1ptYnyUddFlLlyaTQYjWSx4dt1KNMIsxY1xPsNFupM+73VHi+5XkRmeIZF33hRBMuyLTIw1kB6BjZ/A4EH7mA16zpiTjGh8BtvgOzPrQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6ArrKNA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso7617355e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758202000; x=1758806800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9WSGyNH86RGuClyKFJmOmdzW1aJHd26qZ34R4/eWtM=;
        b=g6ArrKNAuMAYi0XYYqrij1GyGx/DH88DPW/JZu5j/9DfL3HUXJWJJHCDwq49DTMHCM
         JtDRLD7HukBfQ3fsOJiTg6WnN47cwNH9ZAE6lApd1PGIIGdilTphOzJVbszPn2s4WPmY
         RviICqGfWr/IZsO8xCXVJXXwS2Ka80wiG8n7xv7jiXfhhP2HDI5AFH7DXPArhqfEryvH
         i5qkBAkDp3FhggxYv6WIg96ALhtcJrI4c3b0Qy5XoZYN4KILeczpQZ1FIuu2sHWxjF86
         rhQBfbnFrSNNzC3QXMw3wfFgCjMdZGqKTYPGugIsy2wukrz7qTYsMXhgQRDLuaXvvg9H
         Q+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202000; x=1758806800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9WSGyNH86RGuClyKFJmOmdzW1aJHd26qZ34R4/eWtM=;
        b=r/hWlocwBKlOGgBOiIj6jlgm7Qna1unn9b1FMKskR+1SfWxlmEL4JHUq9N+K5g8tT6
         CsqRlnkojtbdOdXlWBwqz1AQW8GAv+XFK2f4GyYhAPjAma71aCRf3giRTmRLjiKX5Y+D
         Xh+DtBudZ3AT37zgeD/VwbsPYYcLlLREa42IYjRbHzNLEB8DY5Ql4zoqrfYTsoK7IeKo
         /DMR3K1FYnCWqGnuNPCOU9P/ZCaZW74mOh/uojDc0Kr/YxBAcfFannGt0EWfRA/uwY1x
         FnA7bI2BcMY1850OwQbRE/+FDZlU30XkzJk5x1zkLghzJkNlx9lV1838PEm/ka9RF10Z
         o9Dg==
X-Gm-Message-State: AOJu0YwoO3/MtI+DXQKNAOVmy48zwZLUsZv8jS4z4AGZJSXAGKarJolw
	xjWK/NvGrdEVYHqSL0nnR9zDzCuhvLHUzdvOxPzajvC/PGqIH8enwD+FTEsjWdMA
X-Gm-Gg: ASbGncvLNtCjB/uE8Pg+Gptp1LDue2Kv/d4zO9FtR1P7kJEP1cTLnUZjOr54M+PoSNX
	Gz4mIGGe9pEajGe4cYhL5LnR+n1/ErzVN1FdRTfbJI6CpYPm+0OJsHJlE/FaMInTqFe/xhZNUML
	hfePkk84RVIRPxbfmAhHIyOy8Sv68lcIthD3QaylJi5fxMjQEf0N/EzosYVqECK1kVPncxBeS3B
	JQWQncYw/eGJqNmTl3J1l0/+C5jevK98Za1wz6cheTNswBLLckUAoBsC1gqpNIPwBt0FLrWMNPq
	Io9WOtApwtmeGGSkYejmqSFBB0LUxQraeEKWHTTRuCiUt9O9ts7kBkBXeKhCDiQ1d+vgAkQEmI+
	U8cZza5bmbp9iNLebhdEJO2Srt3ifMHM=
X-Google-Smtp-Source: AGHT+IH6QH9/zZQ4VGyhlc2pc1B6PGaE1GUNDgcCuv0AUcGszQl+HYvE2kaTenjSk6V1jb53DFTs6A==
X-Received: by 2002:a05:600c:1c87:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-46201f8aeb4mr69059215e9.8.1758202000280;
        Thu, 18 Sep 2025 06:26:40 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a2850csm41124705e9.19.2025.09.18.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:26:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/8] bpf: extract map key pointer calculation
Date: Thu, 18 Sep 2025 14:26:13 +0100
Message-ID: <20250918132615.193388-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
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
index 0fddf7d0954b..2d6a2fe6c374 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1081,6 +1081,17 @@ const struct bpf_func_proto bpf_snprintf_proto = {
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
@@ -1163,15 +1174,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
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
@@ -1197,15 +1201,7 @@ static void bpf_wq_work(struct work_struct *work)
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


