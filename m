Return-Path: <bpf+bounces-70012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A43BAC8D7
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B01C81DA
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EF2FABFF;
	Tue, 30 Sep 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/po8Uy0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE2F6193
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229390; cv=none; b=JIhFpxnb2IFYhu5MDJy1u/zuh+4RyfvbAmId3RhZASVPlrCaxYqiRZfFC/WIzRD6R3jL//bpovmG0qKcfidwxgNddv7ZxUVK79S5cMVXR0pZ1qkoOzYnjJYgTF+H5//wlOI9Po9U5zpY9qaDI/dHNBdoKgZQDy9L9tt3hucwTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229390; c=relaxed/simple;
	bh=jTLMPYhR0dDSebuZLbnlTz246Ee8anVG8yl7RaA4JgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOjtVzv4Z2v5hokbEsCb4bWhy5hS2yo0sijViL2Nl0hmG9UdjW1o3xg/qLXZTMzZkG7CDb33i8+HB1n5A2s97zZFqPvvf9NGtcdw6+TC7HM702lDnqQdymU8UTqADJQ1TYjm6fr4piBIRMWIEf6yi1qqSHeZ6TBTB7pU059bCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/po8Uy0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3976648f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229387; x=1759834187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b9xeoyNpSMlEo0wjY4j1doLPn7ID5VIzPOImjV938g=;
        b=H/po8Uy0gdZQzDO4ANg/mwEladHtcdYyb/JgReYwlixWsPs5ZEhzgw91dkDLUUPi6M
         GWdEwkMMdExupeeoeEb5irXN6TXWXap1axol0c8G3rkCkU1tpy6XYEvEB2OWmlytGKpJ
         Zc0HfBYGCHbSlA4DxM31DL7x9RECJ9tlyxl7rUVMpy11W6vXPJsicuLpg+3OjgnE6ayA
         QLfKtXAUTIH8vSUaZTAsOn5NfXOzPVsedGcyj8+oUZ5elygZf4NLeZepVZqnPPGLLHnl
         5j3PZVYjyLTGKIlu7f3Zj6u7rQ8mjZiFmRd+KIBkzKAv2SW5/WrIiIMDG6NWG4Payd6C
         H3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229387; x=1759834187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b9xeoyNpSMlEo0wjY4j1doLPn7ID5VIzPOImjV938g=;
        b=S6jbWz2TMvzOIK/8oupDFzbo7elQGjQnKtinPLG6462VFVpFJHp1CRpgxrk5tumjTV
         +BQDmJtKP5O3g6WLckDNYtYb5WWtjVSDYYH1oxue2bwfXfw2+ry+5WHIobRriVcynYrV
         hVcmvFHrsBd62hGQmH4qdHLkwgBhy1lhaSSc/HffkyiARdYRXFr7d9le6lI6J+9dVSwf
         CTZnX5QnMSXj9pSlJp4z09a3M7ob92INNHNKgzOWez1Fi1vPZx2yF4caDxvdKzp1j3kJ
         N5wQE59v6Dm2Bo2NcPaqlmvYlPgdT8Zr+vM7vJoqDHhEU1ZVlWFQ3QI/qGtmlkSqUBZR
         NGvg==
X-Gm-Message-State: AOJu0YzBamfwHKqUQ6oVVXiSkDPGsRDqlgBjXVPo7xYNz1Xu3e3f3TW2
	KxnElHWN9H+GuXDOuoFgyf9dRDHkb/o+Qem8sirvD172jQoumNSQ3evrHCKKfQ==
X-Gm-Gg: ASbGncvkOfcokOVe9DirJHlspaxwDpW4T08Tt2QDW5bEjqACzOOspxTMY0C6+9R04eY
	/MUi9tLa9OTplxzmPMMJ2mbVUdit7vQo8jzh573UTgwUoHU0adU2JJaGXmCqO0xuTD69LRNP7/o
	Xn9hBXyf57QF65gVgVMMOr30nuHatIGOsy+EggjY1iIZrglyx/XMCs9uEerMPeN0m7sgbPu8Vxw
	CFVcoV/EbwgL5hKg7vjV+1BDJS+wwPcOIT1zdGUFniGYTHAF5tQQoK6F3gGAVOEA+upjiLJ3lLS
	tgVwdwLqfTHMC96aN+oukSCrjTVOXz2FeTLN55WIhNKxe3wgVZNe9vxlT7A27dUJLd7Er/f+KPT
	YAwEHpF/deMssmxYbkniLShJ513BJFTps4HZ4heIgcBpOkmOyDCi/738XU4sx0TUt+towFOC4/n
	FX
X-Google-Smtp-Source: AGHT+IGJmfJdQwculYto3IRn+rX20Bp1Xks9+wI0jD5PDNkdF3kb2TgOczn7rHHI03tvUXrfAs/Dpw==
X-Received: by 2002:a5d:64e7:0:b0:3fa:ebaf:4c3e with SMTP id ffacd0b85a97d-40e4cd57861mr18608170f8f.54.1759229386503;
        Tue, 30 Sep 2025 03:49:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:46 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v4 bpf-next 03/15] bpf: generalize and export map_get_next_key for arrays
Date: Tue, 30 Sep 2025 10:55:11 +0000
Message-Id: <20250930105523.1014140-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel/bpf/array.c file defines the array_map_get_next_key()
function which finds the next key for array maps. It actually doesn't
use any map fields besides the generic max_entries field. Generalize
it, and export as bpf_array_get_next_key() such that it can be
re-used by other array-like maps.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   |  6 ++++++
 kernel/bpf/arraymap.c | 19 +++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 50b6fc2071d0..f2d284c550d3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2089,6 +2089,12 @@ struct bpf_array {
 	};
 };
 
+/*
+ * The bpf_array_get_next_key() function may be used for all array-like
+ * maps, i.e., maps with u32 keys with range [0 ,..., max_entries)
+ */
+int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key);
+
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 26d5dda989bc..da00e9edb685 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -335,18 +335,17 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 }
 
 /* Called from syscall */
-static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
-	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = key ? *(u32 *)key : U32_MAX;
 	u32 *next = (u32 *)next_key;
 
-	if (index >= array->map.max_entries) {
+	if (index >= map->max_entries) {
 		*next = 0;
 		return 0;
 	}
 
-	if (index == array->map.max_entries - 1)
+	if (index == map->max_entries - 1)
 		return -ENOENT;
 
 	*next = index + 1;
@@ -794,7 +793,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_release_uref = array_map_free_timers_wq,
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
@@ -820,7 +819,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
 	.map_gen_lookup = percpu_array_map_gen_lookup,
 	.map_update_elem = array_map_update_elem,
@@ -1209,7 +1208,7 @@ const struct bpf_map_ops prog_array_map_ops = {
 	.map_poke_track = prog_array_map_poke_track,
 	.map_poke_untrack = prog_array_map_poke_untrack,
 	.map_poke_run = prog_array_map_poke_run,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = prog_fd_array_get_ptr,
@@ -1313,7 +1312,7 @@ const struct bpf_map_ops perf_event_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = perf_event_fd_array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = perf_event_fd_array_get_ptr,
@@ -1349,7 +1348,7 @@ const struct bpf_map_ops cgroup_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = cgroup_fd_array_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = cgroup_fd_array_get_ptr,
@@ -1434,7 +1433,7 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_of_map_alloc,
 	.map_free = array_of_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = array_of_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = bpf_map_fd_get_ptr,
-- 
2.34.1


