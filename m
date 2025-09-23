Return-Path: <bpf+bounces-69392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0BB95A03
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED2C17591B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC58F3218DC;
	Tue, 23 Sep 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYVC6ScL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13B3218BE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626663; cv=none; b=pMZ17qBGFNVBd7+bV17z1NOrMmzgMYm0aaFHMq0T66f/+reeAEq84p1R54W9z7IbHNO1tugscvQPInGx9YfIbhtVJe6ee7TWd+WDTd1iLqrEX/uy8BanMGKj6icNS1UULTnqXgBQA6aHNnsD/KK+SxRnYLQlmMFN0QbU39Pm80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626663; c=relaxed/simple;
	bh=cnu9r9VFMwxE//kQWF8MD4Wvh+Hn0DFebBHljMWlEEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogtu3+uPqUSV4uQ+VOyyzDb64zLBY0KEv2/wmDOPRy03AM8yooChlDxR+288zJ2ziCwXqvLwFGk0oRZX1EXKYHpdvVcn3VDTsVK0bVK+Ey9wT/KpyomluHbEQpVRiL/qC0h+S1blTxrtf9Nn0wvfxeOnDf/kUajrkQFkcJpu5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYVC6ScL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63053019880so5729745a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626658; x=1759231458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkahzeL9cMvliCLw5mKRBeX2gXRTVQ5tFjbWEwW37GM=;
        b=MYVC6ScLSxTHfQItM0M2vQBBWVmwclUbDe+Ig7w3qvSONcGx4hRFQCIz/om5PP2Bnr
         X2h0uurfZmflJj210dXMlODhoSdWD/dbN7hNDTJ+/zhubx4sUp780QrKjAt7amj6RfAU
         yZ5hv0J1EwD5ys4DVZTgMLdrI2enFm4Tqxp65d6tY7xLxu4toH5PrX3yASpCfgd7mntc
         kaCQW4mmkArUQpvQcgA+OWlC0scehy9EaLMuYiL3Xc8GZW5uh+YKIFqiubgQdn3PFIxE
         6DlNFgEW1s89LsnptpLoHdIxUpGVBK+uwnZeIm/xrmXG1c2r8ZQToHB5KGSseOI1IyKK
         uStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626658; x=1759231458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkahzeL9cMvliCLw5mKRBeX2gXRTVQ5tFjbWEwW37GM=;
        b=eHpDxZrZKLmvISj2uk7jSoBkez72iidk7xm4+i/bZGI6BCmKtVi81Czl44knghgORd
         0GYOluRMy3Y+4Tyc6vMF2bI2BbyX5OwW1GvG/bKMY+s1ipFU6jjyEHvPOaqothsly9hc
         QyhtjqrCxKL8w2ff1z4nPvgr5P8UuaFx2mzFB7nfommDzqDlWGVTWVUkwkAJRRjD7xWL
         aZ7H7iBuZKiOM+X81vvNsksyTMJvg7jOhWjyJjwSr1nsTXtDy93H+/+KKWkiFRiLjxVI
         C1gs9iAqW25DAdEsOZHuFqb2UMc8HHvxAnfao0d5/hw22dE1OPge7bWSt1WvGPKh4nuK
         uK4A==
X-Gm-Message-State: AOJu0Yw6SekOX3AN7kYbNRMyzaQ28+JZSAlASGmm/oy/ly6TwdAOjrpF
	2m1T/bWjZjvHivT4uDFrSIGHh9ez0uOJ3NRRGqYIfRDbnb+xA8Xm+oPOxMH0Uw==
X-Gm-Gg: ASbGncuz47QsxFH+lVisQu+UBnIVTwDnoCETvhLn1sKS9aSThBLT3ZWLgIKjCZSkYmO
	4G1OoqKSEOIYKyf1ANleXhHAZk2VxKtvfCV/se8G16prTPTEwD3Nb3iFi0XNkL0QUZ7Ke+55WYk
	tROZZfuL193d/OWKOYYkSma72IbcRApJ6F3CFgx5gqPcC+FeCCgLnOxdvl6XsTZtW4581L47VOA
	bbN4Mu+A9cblHOG3B/MOGkNPNj7QdoMtjWKWc0tqT+skAIcV+om/uGyDycsU15eHEpIP4WJSZwK
	CWD1y5/CLCFHTG0Zi3W8aPiETAIY9zLU6yXSmCrQDmiZTauKBGBXIYt5adO3oencg3tWXswiZ9u
	LCJRxQJRXvA3lqBbTMrJP
X-Google-Smtp-Source: AGHT+IF7rTK2atEZQJlm78jVMntVBTzKzYbbV3vbbQMf5GodMuJMQ+HC/aZnK/WEzWWsHktUTPVG8g==
X-Received: by 2002:a05:6402:5354:20b0:62f:9731:a1c6 with SMTP id 4fb4d7f45d1cf-634677eb8ccmr1547222a12.21.1758626657865;
        Tue, 23 Sep 2025 04:24:17 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f138acsm10632768a12.26.2025.09.23.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 6/9] bpf: extract map key pointer calculation
Date: Tue, 23 Sep 2025 12:24:01 +0100
Message-ID: <20250923112404.668720-7-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
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


