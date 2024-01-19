Return-Path: <bpf+bounces-19927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6038330F2
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394F51F215A2
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035935A7BF;
	Fri, 19 Jan 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpbMogwr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBC5A7B2
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704636; cv=none; b=ue1q+b0VLmKC32xgxF7m6n2NNhHwK/tuFyZWFXVACy0FBDr1pvgPaJf1BBp/XogrXy55jr9z0ZewxousMkcUcuGpY6BIrw5Ekj6N5uNyPS0tsr9n61RZYh7dPIYegjXNa02VZdLj6v2Dbuf+E1v6BNuv4JVV7MuVbxPvOTwuwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704636; c=relaxed/simple;
	bh=0OEhiyznf2+jFl1LAqHt/MlSUEdvfcGY/ba+9gVJYFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WA7/H+I2Dj0qhhAAVtzTTk4hzM5SbwzQJ6eUKvrH9BgClRCWE3Jsy6HVGzxCwG8pyp5WQ/eSyLERnfFWX3XAOsCuyGL5xMNfQIoPFWm8Ym1KD0uR+Pf8HqiFQGEAIvaJ8VG/dEpP69Tq2sTawyzbmJb42O9Cf17nE1CicWDRgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpbMogwr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f68af028afso11252977b3.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704633; x=1706309433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTM6OCjQyRcuqIZh3Ve+O1/AyVFgK5XEnZ8UWb2mji8=;
        b=SpbMogwr2i9PsKpCxetdYo15aZt52tsUKW0loHkX9Ks5AFDiKMo4gskwKXoTiX2cmR
         qcpU4MLQnW2nfE9SgDfCtFU7OZgrdamNr4lNLloJ2ueXHmnAI500yWCdI9EGAYqDsEgK
         OBsg7vZN+6WnQ2/FRzTmQJ0upJYJ6uaA9Q2I8sy2jmInnK9oHX9H1Pcb9M2O/rF+k3U2
         y5e4sDSESQLuCJ/RvB5nBz8gmIMKbx5xORise+bUziNn466JO3HxMm8KegTz/6T2oglO
         8k2Z7wlbTbwLt9RDtfE1J//BHfmRyJRoAndDpi12jkLlEW8GJMPjGyGbyI9p9f8HVQT/
         pQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704633; x=1706309433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTM6OCjQyRcuqIZh3Ve+O1/AyVFgK5XEnZ8UWb2mji8=;
        b=L3nYK5f2s/uOn7lOZWtFNc8V5qtAHYGLDfCRgbJfSx58ZsFjA0GuyZF60CZBHdmk+n
         xtVB2STHHBBVRfj4tUc3//5+V+nb5tyF5d/Be2SnL0vbOJbb1YyRU/lfu2BoujjdHfIu
         FGot7nUtSKAXzZp8jgy0GvVTjF8cee/oeevkQfid/0iM7UvPQXZK6QK5/fus2bqZt5Bc
         L75jPmA5aUH6mIbV/h7tWSBsKqgcTFMg50ml8hXyeZ6opOLgUzI70n7XE3Bl/JQVsTPw
         /EEk80y1XOtKjmAJgVivNf1IDLZ29+Y3qLmgdTNQseCDBAXOhc6DdbA/LYSv98v/16sV
         MRDQ==
X-Gm-Message-State: AOJu0YyQ5yCis6jFDCYmyPsGQVK6hhT1n/qfeNuAw0KVCNKQudND0Q1v
	Ei579+I/GFDF4b4uwnFpRbRS09Wh03jcXX13W+Rx0wFptqcc21/tQaK8xZld
X-Google-Smtp-Source: AGHT+IFLa5zmalKc4+sId9eVgb/iM5Be5ojEUEIS4UwX9BWIr8vCE8g71xVIGB+6Tdf5TMOPSmsjpA==
X-Received: by 2002:a81:4841:0:b0:5ff:aa34:7c5f with SMTP id v62-20020a814841000000b005ffaa347c5fmr420760ywa.46.1705704633616;
        Fri, 19 Jan 2024 14:50:33 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:33 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v17 07/14] bpf: lookup struct_ops types from a given module BTF.
Date: Fri, 19 Jan 2024 14:49:58 -0800
Message-Id: <20240119225005.668602-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

This is a preparation for searching for struct_ops types from a specified
module. BTF is always btf_vmlinux now. This patch passes a pointer of BTF
to bpf_struct_ops_find_value() and bpf_struct_ops_find(). Once the new
registration API of struct_ops types is used, other BTFs besides
btf_vmlinux can also be passed to them.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  4 ++--
 kernel/bpf/bpf_struct_ops.c | 11 ++++++-----
 kernel/bpf/verifier.c       |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f53d07931ad4..51121dbf8e98 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1689,7 +1689,7 @@ struct bpf_struct_ops_desc {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1734,7 +1734,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 #endif
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5e98af4fc2e2..7505f515aac3 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -221,11 +221,11 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops_desc *
-bpf_struct_ops_find_value(u32 value_id)
+bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
 	unsigned int i;
 
-	if (!value_id || !btf_vmlinux)
+	if (!value_id || !btf)
 		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
@@ -236,11 +236,12 @@ bpf_struct_ops_find_value(u32 value_id)
 	return NULL;
 }
 
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	unsigned int i;
 
-	if (!type_id || !btf_vmlinux)
+	if (!type_id || !btf)
 		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
@@ -682,7 +683,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
 	if (!st_ops_desc)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a187317500dd..0744a1f194fa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20242,7 +20242,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


