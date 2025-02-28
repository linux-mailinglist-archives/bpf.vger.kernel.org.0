Return-Path: <bpf+bounces-52884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A977DA4A0EB
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B8189A53B
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931AB26F444;
	Fri, 28 Feb 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQlRoVVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C72500AA
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765186; cv=none; b=UbOyljeQdYYSy/6KNTTxAGP8ByFJrNXYi0Ee0Ow+hiw8Sz5SE40bscPiy+gs60uhoY7XiEZAtNnBObaJCK/vo8IYnQC1wZO6I68LR0yepZ7G6NXoTnZRtKdbOEyKtjE7CoRfAfsvUduEv5PTf1X/VqRxWVxixJTElaNvCvjSsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765186; c=relaxed/simple;
	bh=SkQzZknmpcJv/gbUwgtOVlw06lcQxQ2SkSNdRR0tHMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYucCmAswpXXTbbiCl+09XwSqUZUYymAY27Jmi8rmxqZKTbCZKAYujQzab6vY8eqPmCOKB1R/ZGyMX4HLRmmUJn4or+lIltLFawxmNfdFmbfzOCBimwJELdsU+/XbsHdjaZl53DKcakgpZHAKjCV5Z+38pXJ6bYvmqz7zmUYZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQlRoVVX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso25900885e9.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740765182; x=1741369982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmkGcfiLXY4+tkfqzh2amxmlBPsMMB9OQnpgy2uUVAc=;
        b=lQlRoVVXaK0c3ZUe8wbSvWlGVrzxdb996oYrGOm5aGZ9JKz8isKe06QEsoSyKvB0tx
         91t6rCPci+ou38l+k8Xqn5DXK3mtVRKsgbG25UIf0gEDPM8e81EUQQIE1mNX0k6NCry1
         X5OMfjGC1/WBDhOw/zm3sEGqgWFoaSwDrTbfinH/OPPTG5jMJVRFWEaI9OTwAZMuwZyc
         tzp72goEMlgjKSG49AKF3my46zgLV3JnBK5b+fBMo+ex3OTO/A2OaHcgZZe3/jHj7VXK
         1LlT/rUOIroy/YBecwJht1HdqucmDQXyoWrwXGXmHbEGOoTI+jiOe27uwkKh+ThOhw7a
         xD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765182; x=1741369982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmkGcfiLXY4+tkfqzh2amxmlBPsMMB9OQnpgy2uUVAc=;
        b=wYTecL7zd+eM4NUpTK6tyOoLNX6ZiqwrFPORpMILTCX+B4PDdbWda5bCv6T1tHYK0H
         XQx17R1lW8q1UGAM9xKWreFyjRY/TldnCtBqrLLkmLSBsnHKM3ZfM6onJ3Twah9upuB/
         sXxoZTNSSWq81YyJ3zP8aIFpaFHqpwczkdXfaV857FGfgLwmDTh8Fd30zSfLFUEeK71R
         mbbr9dlGSF6vAsKpes+gB2GwuA2LYRjLE5ZNAZIYSlIDnvnLbfRBds7yaInyDH4ntOAK
         m0ixVu1JNBJ2JWqbkblESeqIJxUfvB1+H9jA+LjqfJdVydgZkNTbYRRqlI8+FcF2trWv
         wnjw==
X-Gm-Message-State: AOJu0YxgGueMg3LAKBCV2nhR7ZUuEYjlIDPUKOXwscGTwWCcV/0vxcpC
	Itm/IWQPrHok5Fk+BTNporPsLzA30IWhiHk3cVb6CK9CCYMK823QSrrunA==
X-Gm-Gg: ASbGncvTMimf5sB5nrryipCi6Q3pCkEv815hgTAICH3q9hgn/lHL1Ni0SFiT7IGfySR
	rDTzq3vmeB4H9Th52FqfUnh7nqWqbew04gkr0tOhLouG9DYyb/j7xUAtOe776vBD10l+L0zCHB5
	f+M6J+nUv2ZW+XjmGupz80a5XR7LaYhvE0M6N1z/CHwOhbuv4bKhCleIiYLAqy0tbPrhTKcqCVn
	IyMh59aI89Lod45h0/5OGtC/6iKpikhoqT2Tkx1fjbbc9+mHMJBtBI7uRq4PrEV11WjkQlKjl6H
	Ktruhg/0zipku5sXK7VkWtOpDJ4PJpdCh1fXd1lRvKLV1pgy11eavCYRrPFpMJ754Hi9eXpydQu
	jLBD7q3U7NCl2k+OopC73WkaRquLlbMw=
X-Google-Smtp-Source: AGHT+IH+Qb7vQ04DYgCqEWWYtQ0fy+GJCPbcU8Qdt0eqY8BWNutFAcyrW8l2WyqtJawSwQ7lbKdWGw==
X-Received: by 2002:a05:6000:1acd:b0:38f:51a3:a708 with SMTP id ffacd0b85a97d-390ec9bcb07mr4817698f8f.28.1740765182225;
        Fri, 28 Feb 2025 09:53:02 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm5861664f8f.40.2025.02.28.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:53:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/3] libbpf: introduce more granular state for bpf_object
Date: Fri, 28 Feb 2025 17:52:53 +0000
Message-ID: <20250228175255.254009-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add struct bpf_object_state, substitute bpf_object member loaded by
state. State could be OBJ_OPEN - indicates that bpf_object was just
created, OBJ_PREPARED - prepare step will be introduced in the next
patch, OBJ_LOADED - indicates that bpf_object is loaded, similar to
loaded=true currently.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 47 +++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 899e98225f3b..9ced1ce2334c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -670,11 +670,18 @@ struct elf_state {
 
 struct usdt_manager;
 
+enum bpf_object_state {
+	OBJ_OPEN,
+	OBJ_PREPARED,
+	OBJ_LOADED,
+};
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
 	__u32 kern_version;
 
+	enum bpf_object_state state;
 	struct bpf_program *programs;
 	size_t nr_programs;
 	struct bpf_map *maps;
@@ -686,7 +693,6 @@ struct bpf_object {
 	int nr_extern;
 	int kconfig_map_idx;
 
-	bool loaded;
 	bool has_subcalls;
 	bool has_rodata;
 
@@ -1511,7 +1517,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->kconfig_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
-	obj->loaded = false;
+	obj->state  = OBJ_OPEN;
 
 	return obj;
 }
@@ -4852,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
 
 int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 {
-	if (map->obj->loaded)
+	if (map->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	map->autocreate = autocreate;
@@ -4946,7 +4952,7 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
 
 int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 {
-	if (map->obj->loaded)
+	if (map->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	map->def.max_entries = max_entries;
@@ -5193,7 +5199,7 @@ static void bpf_map__destroy(struct bpf_map *map);
 
 static bool map_is_created(const struct bpf_map *map)
 {
-	return map->obj->loaded || map->reused;
+	return map->obj->state >= OBJ_LOADED || map->reused;
 }
 
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
@@ -8550,7 +8556,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	if (!obj)
 		return libbpf_err(-EINVAL);
 
-	if (obj->loaded) {
+	if (obj->state >= OBJ_LOADED) {
 		pr_warn("object '%s': load can't be attempted twice\n", obj->name);
 		return libbpf_err(-EINVAL);
 	}
@@ -8602,8 +8608,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	btf__free(obj->btf_vmlinux);
 	obj->btf_vmlinux = NULL;
 
-	obj->loaded = true; /* doesn't matter if successfully or not */
-
+	obj->state = OBJ_LOADED;/* doesn't matter if successfully or not */
 	if (err)
 		goto out;
 
@@ -8866,7 +8871,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	if (!obj)
 		return libbpf_err(-ENOENT);
 
-	if (!obj->loaded) {
+	if (obj->state < OBJ_LOADED) {
 		pr_warn("object not yet loaded; load it first\n");
 		return libbpf_err(-ENOENT);
 	}
@@ -8945,7 +8950,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 	if (!obj)
 		return libbpf_err(-ENOENT);
 
-	if (!obj->loaded) {
+	if (obj->state < OBJ_LOADED) {
 		pr_warn("object not yet loaded; load it first\n");
 		return libbpf_err(-ENOENT);
 	}
@@ -9132,7 +9137,7 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
 
 int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
 {
-	if (obj->loaded)
+	if (obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
 	obj->kern_version = kern_version;
@@ -9229,7 +9234,7 @@ bool bpf_program__autoload(const struct bpf_program *prog)
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
 	prog->autoload = autoload;
@@ -9261,7 +9266,7 @@ int bpf_program__set_insns(struct bpf_program *prog,
 {
 	struct bpf_insn *insns;
 
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	insns = libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns));
@@ -9304,7 +9309,7 @@ static int last_custom_sec_def_handler_id;
 
 int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 {
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	/* if type is not changed, do nothing */
@@ -9335,7 +9340,7 @@ enum bpf_attach_type bpf_program__expected_attach_type(const struct bpf_program
 int bpf_program__set_expected_attach_type(struct bpf_program *prog,
 					   enum bpf_attach_type type)
 {
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	prog->expected_attach_type = type;
@@ -9349,7 +9354,7 @@ __u32 bpf_program__flags(const struct bpf_program *prog)
 
 int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
 {
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	prog->prog_flags = flags;
@@ -9363,7 +9368,7 @@ __u32 bpf_program__log_level(const struct bpf_program *prog)
 
 int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level)
 {
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	prog->log_level = log_level;
@@ -9382,7 +9387,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 		return libbpf_err(-EINVAL);
 	if (prog->log_size > UINT_MAX)
 		return libbpf_err(-EINVAL);
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
 
 	prog->log_buf = log_buf;
@@ -10299,7 +10304,7 @@ static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
 
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
-	if (map->obj->loaded || map->reused)
+	if (map->obj->state >= OBJ_LOADED || map->reused)
 		return libbpf_err(-EBUSY);
 
 	if (map->mmaped) {
@@ -10345,7 +10350,7 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 {
 	size_t actual_sz;
 
-	if (map->obj->loaded || map->reused)
+	if (map->obj->state >= OBJ_LOADED || map->reused)
 		return libbpf_err(-EBUSY);
 
 	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
@@ -13666,7 +13671,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	if (!prog || attach_prog_fd < 0)
 		return libbpf_err(-EINVAL);
 
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-- 
2.48.1


