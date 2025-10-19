Return-Path: <bpf+bounces-71318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4927BEEC00
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933D3189A316
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833127E05A;
	Sun, 19 Oct 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY17/LW1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAF1A9F9F
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904930; cv=none; b=oA/rY0N8/9aeAiPdspcSu8TGX1S6KC+ATZKuVX7xD5ebClTdFs+FpG941+rYxsvFDqhQ3gZ3Q6ZRoh+EhnktlpFH33FJcmcRx7rHj4fR60FO+9y5ph0SBS9PksFIofBPHKcug8Ms1cpApmPlaU2eOVEx2WhCiEi+nAhkR6FDIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904930; c=relaxed/simple;
	bh=pyuRFFKQononEcwa2gL0swtUdxcGkBfaZm4k2wB3dYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKSqdBiBvWjJQhQMlMVx9edDL5R7GxkxoJO4MDEP+AlWQRYltRmszRJuSw4MLuapbITCvYUuaMPwzM58bSL3iJzO/4V3SudyUgGfLiNrwljH2oyg+3bnGUcY+PKas9/EJYg+oRca6b6x7vqvmFfl0LPzBScPBk2G+dVzBrZ5ac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY17/LW1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46b303f7469so28059665e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904926; x=1761509726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjUpLM0QL5+mrrx8DTkh1W74twVT0rCRUs9Xs/oHuHA=;
        b=OY17/LW13FMfQp9TWTUF5LV9W/2kMDB2TbbIX9HhoCnieLmZG/R21mCEPkHydtmrwJ
         8VAhEu/TdMjb9jje6HU21TaUIHhzePtRuEAcn6nbAlw5wlxDcD88PXTLpUWbT5EE9BuL
         tRSjvFCMEt4XPNKLJZYeX8w2BqqJJ2jkAFg3zJI0pLn86QclcMQM8HcVZS6DJhGwwKvs
         2BFyrKt8hHwTNiYdUdWoX7PJVDhQGlnvCUgD81p4FY6il9EsBPOYe3qUY3Mrl+UnyeZT
         Hc3199O7H919QV+jsGSe4KkC5SlAZ2sxVipjRZH+aYRhnYyTxBbWkuW/B7YTX0WJ9jUT
         kAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904926; x=1761509726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjUpLM0QL5+mrrx8DTkh1W74twVT0rCRUs9Xs/oHuHA=;
        b=NDfcQ21++SLhUx1Wwk849h9NEjrR0dG7HSupkDPf+ybAB6UjtVWwNKZ1VrBk5i5fvl
         S3kBc6zKY4nCsWzKBl32zsE+gs0Mu8GHXCLISZJE+8zr0X3kdwibctseXDedq34Z3bfj
         m2i6JMpaPHL0pPmZey7ZHs00PtuwYfcWd/djRFV9ks7XrjQzUqX1YJdKC4tA4BvFALf6
         DQR/VsSmmjzbuAtDLHlVM0b4cOSEMVIXRBQiVFHwsjIEZF60+kHP722gvGgXw8dHSpQu
         BsnWQJeXLwhEkR/vTSYH514y/Wet0teAAW0AZzyaVWt5s3juBTKJvDRcVL+v1NnZ9iHK
         VtEQ==
X-Gm-Message-State: AOJu0Yzrb/Hh3apGg1fmOIkw3Eu+3dr6XmmU95KzuNSNn1XhUXmCufOg
	xuuJOKusIz/ixx7TJ8YZsdFC+9gH6iw0ov6NzRphGdrCbFKe4HCrUfvsaUFJmw==
X-Gm-Gg: ASbGncuDhXRHwuRyB5gDR4m1scPgU/IYgbKzfBKlELqPhK9Umtv6H/s82GkuMt2msKD
	IzpaNIRnSp7Q0oapK/ujaqOie7pty4Z5GjlXKMoB/UzW4SrROCrgMtS24uQQqL5EMuzNm4y8esl
	FF4MjHAj4GHU+f8kg9pxoWrbp0G7HwVLTymqALnroIyuwOu0pkiJMYGqKgg/NHXSdoTAcTAQzFm
	kayt7X+bxDrRkW4rKq0mcywQN5ieOejwuX5msTQNZQ5g23psVGJu8jXBlG8cnLgewm+Ktphuvnt
	VFT20lm7yOEmCSGRCIH/L+lRGGZ4MYEA0BW94RRgtwB/zLm7GUCwuUiNogcZd30KEisJPeKzDYv
	ch/RxXlw6CCWd0ZFFupwOyN0izzNKledGa2T2CaK/EenEj136IaMPYiLVZKyPXsPrLTmFcEwKrd
	QJ+F6KXmNvMpKwsT9Hl5U=
X-Google-Smtp-Source: AGHT+IGASmn7IDM/HiChY3/RnHvTDJAFbtx2G1aJob2nAh/imPDfpxP7UOwAWu7aZ/iiH6cmBL1qgw==
X-Received: by 2002:a05:600c:548a:b0:471:669:e95d with SMTP id 5b1f17b1804b1-4711787dcc8mr68934725e9.12.1760904926083;
        Sun, 19 Oct 2025 13:15:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:25 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 03/17] bpf: generalize and export map_get_next_key for arrays
Date: Sun, 19 Oct 2025 20:21:31 +0000
Message-Id: <20251019202145.3944697-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  6 ++++++
 kernel/bpf/arraymap.c | 19 +++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3bda915cd7a8..e53cda0aabb6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2107,6 +2107,12 @@ struct bpf_array {
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
index 0ba790c2d2e5..1eeb31c5b317 100644
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
@@ -789,7 +788,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_release_uref = array_map_free_internal_structs,
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
@@ -815,7 +814,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
 	.map_gen_lookup = percpu_array_map_gen_lookup,
 	.map_update_elem = array_map_update_elem,
@@ -1204,7 +1203,7 @@ const struct bpf_map_ops prog_array_map_ops = {
 	.map_poke_track = prog_array_map_poke_track,
 	.map_poke_untrack = prog_array_map_poke_untrack,
 	.map_poke_run = prog_array_map_poke_run,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = prog_fd_array_get_ptr,
@@ -1308,7 +1307,7 @@ const struct bpf_map_ops perf_event_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = perf_event_fd_array_map_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = perf_event_fd_array_get_ptr,
@@ -1344,7 +1343,7 @@ const struct bpf_map_ops cgroup_array_map_ops = {
 	.map_alloc_check = fd_array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = cgroup_fd_array_free,
-	.map_get_next_key = array_map_get_next_key,
+	.map_get_next_key = bpf_array_get_next_key,
 	.map_lookup_elem = fd_array_map_lookup_elem,
 	.map_delete_elem = fd_array_map_delete_elem,
 	.map_fd_get_ptr = cgroup_fd_array_get_ptr,
@@ -1429,7 +1428,7 @@ const struct bpf_map_ops array_of_maps_map_ops = {
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


