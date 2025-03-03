Return-Path: <bpf+bounces-53063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09FA4C29C
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A15189542C
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD97213255;
	Mon,  3 Mar 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsxN5HDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4061F3BAF
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010283; cv=none; b=av3PO04kzu75Lb5J/Bx0grAB6JfLQOFZNZ8VlUo4AsvkMfogXKcjuNVVGNn6tFCWkFdk3weHhJK9DAXKpJyKrowIHqzWvwgUfPY4v+fLoByMvsD20kMdj0c7ZVZ4meDViXiwF8kdNeLJ+KG31zrqxlhiBmlJQZQfM7Zs58d2yuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010283; c=relaxed/simple;
	bh=NMW2u+kcVB/LyLy8ep1beAzmPIky9dgtUYyaW5tTf5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbgX0aUxSXO3oIaRiCOmfn2Sc9JleJryJn0HOo5vjHs9SKgetVX+e+l6C+Yy/PAYo9MHZbdivqefSomXoR6+8L0K20qKT0YwN3iXdlRYn3DyDlV3qu3o0Njhbkh9sg3AxXS/1VtOYLy2aYRQkNxqowAIq7yqeu2ZkeTqMiSbVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsxN5HDq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so873697466b.3
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010280; x=1741615080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeYw/PPRWQMXg+ZpGL0OGe8xjmVd2opVwf5zi+vKUjs=;
        b=LsxN5HDqcMqbEWvpe1rBqduADMZz1AOUueIv9jGmiwm+TZ0TDd+TOzlFwW9oCTUXcj
         s4lO4rKmuvr23v7TPfs5rPktKihsRElgggCQFUPqZTWevyg/Q30aduyq9IbFoHSRpGdf
         ejAEI8NHAfP8dN6X1NTvSpWEI8pqYBDfX0MwZ0D7MBOIHBArBefOc8q3RvIVKqWG3vnx
         dGMK276XNfV8yMfgk2NDMLBUNSQ6Vf4473EAsQnuxNrcUkML7Z3KRc7SKumUR+kyyiVR
         AnEneDjt0hMjPCHCO4SC7O3TkNyR9KtFfTMab7GPgGwxszm7vA7JH172HeU3v95Ojh16
         APAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010280; x=1741615080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeYw/PPRWQMXg+ZpGL0OGe8xjmVd2opVwf5zi+vKUjs=;
        b=qrTSHjhmh0yaTlXGIdhRrXICWuwYuyp8I+pRQSvihmHgrPwpPp6KEe0pexZJJ64SSk
         GOyp1DCJ+/nFBVcHIxBDRyPilv/VUCE/fw66RKUdwBgJuf4/u2sw9uDEDqjP3O46OUt9
         gYJh5CJBx1CuldnJSJwLrU51N2LdRbS1fnyjqkIbm1t8RSL0B3+i19DDm205KQS6p0IA
         hdEClei2nhQHI+hUcGaAcR/VH57jq7CPuh0az9Y5mN6mHkOOK/C3lyTsL/6XM1hOFKo6
         gA5TuWXRzKi+v1cQ9aFW0UDZMHDmwtGpx8rjLSBExZA7g4vUBW+8q9rpdaXZyCyDTNOU
         TSgg==
X-Gm-Message-State: AOJu0Yxm/MYkTZkoh02HzrGgCXtnQaO4urjPbyt8e77PWes/H+4ny4ww
	/Av5KIv2KkiuSAiJMCwW/4183aEJ5ug8tGLl2xXqTniWazUwYSIxBKB8yw==
X-Gm-Gg: ASbGncv3N38etAAPIGv6sCPIlGqT1DoxxXpQBk/N80gzZPTkErTe+1D5jBSXp1LzYbp
	wr6d3PrXwC491EFlIE/cPiUevRlAIgkDmeBDt4rZBjbJiI+ME5Jr+ruOAGCO5Pz90XOMqhJeXqe
	4eQvwtVzU63x98hmytvVlnLCX0qNnFqdNt+QxM6MMhVLBXB8bGwTQ5Giq3Z0lBevN5zr0NFcpgo
	jCywZytUMSq0fIldy9Wn03FzNOUU4EBuezpaIyqjLhqsHBE2dzT8B3S/meboPeVRVMCcJ8k1ula
	syF4moLYq9ut3SAeioEUcjezdg/riukHpeGLwGB6+JC3JpRcfbn7BEH7Fhg=
X-Google-Smtp-Source: AGHT+IHjuwNV6peA31YPj9lX2SxzxuqjImZH+wMHcg0QQ4o09bpTVs4jSMhyfrJScuz0eaZb+KJ39A==
X-Received: by 2002:a17:907:6090:b0:abe:fa1a:4eab with SMTP id a640c23a62f3a-abf260d496dmr1784538966b.25.1741010279423;
        Mon, 03 Mar 2025 05:57:59 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:7e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfd7sm817975366b.148.2025.03.03.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:57:59 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/4] libbpf: introduce more granular state for bpf_object
Date: Mon,  3 Mar 2025 13:57:50 +0000
Message-ID: <20250303135752.158343-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
References: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

We are going to split bpf_object loading into 2 stages: preparation and
loading. This will increase flexibility when working with bpf_object
and unlock some optimizations and use cases.
This patch substitutes a boolean flag (loaded) by more finely-grained
state for bpf_object.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4895c7ae6422..7210278ecdcf 100644
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
@@ -4847,7 +4853,7 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
 
 static bool map_is_created(const struct bpf_map *map)
 {
-	return map->obj->loaded || map->reused;
+	return map->obj->state >= OBJ_PREPARED || map->reused;
 }
 
 bool bpf_map__autocreate(const struct bpf_map *map)
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
+	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 	if (err)
 		goto out;
 
@@ -8866,7 +8871,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	if (!obj)
 		return libbpf_err(-ENOENT);
 
-	if (!obj->loaded) {
+	if (obj->state < OBJ_PREPARED) {
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
@@ -13666,7 +13671,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	if (!prog || attach_prog_fd < 0)
 		return libbpf_err(-EINVAL);
 
-	if (prog->obj->loaded)
+	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-- 
2.48.1


