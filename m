Return-Path: <bpf+bounces-19780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA204831110
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426B2B2362B
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA779CD;
	Thu, 18 Jan 2024 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcPOuDxg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C9539A
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542599; cv=none; b=UnaPp0JqLqv1pR9ECfIv+i7bFazeggE6qaYsezO5SGywNVo1MtDfFBqTeiqNrBSmGKDbo5XjPjGCVHBSxF9l8BRLMstPvh+gZFN/hRbR104+J+VYAAWBOeflP9nZ69+14hA4awNxlRkyT1n3h/NOeApSwedR0TOeGFOvt8zg+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542599; c=relaxed/simple;
	bh=lHlr6xo/jV93GA/GDJi41M1rVRXfLgqfjWdlAq1EEEo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=GadRBI194XF7+jP2kDRrB2dJh4jQlQibkbwXvrrw0XQQd2mhO4eunu+TkL0wJvEtsCqznil68hCoyrfbJNS0f0YyjrfmHKF/K+ppOMiEWDkm820izXgTSv8Hf4NbaQggjpMTa4xNR2QMiM9HiZOJiTonEgGGFth1ifcXt/bn6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcPOuDxg; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff847429d4so2654697b3.1
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542597; x=1706147397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wrl7sbOFgHUbQRf8u0fI0nyuTg4aRrb+2j5aLreyuQA=;
        b=dcPOuDxgYJ5ANoUFBqmdRPS1HcYQ7wYbGr+1IMa0NtzUgrMna6aOVwpRnpnHgjUm3E
         hkA2O29eY4KV1A4v9XMrKscS+gXR2TzINL6jxwvlrC/HHbM8C78Bk55De3a5QEYY+qvC
         qgZerItmNewF2LgRCkr7gpVEGTuATyIIIz0RD4/5kAU8keEo/ahi07y3UxJtUJkcBf8B
         SE3zeGz6GpNoOx5DQgUmSCBEcTVuuF5zxVhvXkgPNZh/XPJ6H79+gsvpLbnq6/PZn7Yt
         uED1rUzdzvH8FijzNTz+GGnMTXGeOaLLur29ooNXcu2Yz+qe+hilDwjYf8jbPC9uUND8
         MsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542597; x=1706147397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrl7sbOFgHUbQRf8u0fI0nyuTg4aRrb+2j5aLreyuQA=;
        b=LooRlpsQFiYoiH+RuA+EkvismG+HWBDjnYPcV8qc2uMkNt8TBE7ZwiVJZk6CV5N/I9
         R0idCtMY6iLNX+xKp4wdiu1jU4LBgXpw1QqpBLM+HGpN5Z0osuPcTH1h3ixKPY+b+zGM
         97tPOgv5Jay+r/VkQbuuTeE9WkNDAqNDSEwooFmci5/K8ZdWFkcq5wWNnmx8QGIpjGek
         jXBESaL3My/157+oNBCOKTpCkEaNo2NS0GveeUcXFCCRq/B/HdU8KMuPgdlgCtmQjdc6
         sG436xe23MEoO2qzB0asgz0fQs+PxrvfeKprkGLkegQvouOWSQbrVbmuCQEyCcXQflTR
         2lAQ==
X-Gm-Message-State: AOJu0Yz2qirq6RrbBP85ZFV4SQoDMc1kCPwj/H6CgkRoi5KXJIhgHZGw
	CVFTq0ZSR34FBLfGBA0xBewoArlE6XJKVP6JsQ+otK+xPFZHljANUdXfCBVH
X-Google-Smtp-Source: AGHT+IG83Q6KvKHEfQEE+IN7GYg/YqqxTa2x6nPatGi7KXCO75wcFbZZ09jWV0Cbv0w0i6vaWmPF1Q==
X-Received: by 2002:a0d:f685:0:b0:5d7:1941:356b with SMTP id g127-20020a0df685000000b005d71941356bmr123426ywf.82.1705542596965;
        Wed, 17 Jan 2024 17:49:56 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:56 -0800 (PST)
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
Subject: [PATCH bpf-next v16 07/14] bpf: lookup struct_ops types from a given module BTF.
Date: Wed, 17 Jan 2024 17:49:23 -0800
Message-Id: <20240118014930.1992551-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
index 1e969d035b42..3d1c1014fdb2 100644
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


