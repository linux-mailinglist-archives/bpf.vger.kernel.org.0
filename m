Return-Path: <bpf+bounces-68428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534EB585ED
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1281AA7F6D
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7B2957C2;
	Mon, 15 Sep 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ArMrkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171528D8ED
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967510; cv=none; b=RD45Gm16WD5k/AfLKesL/tmD2yMFA/BwkZ88bhVQPRvD6KCQJPj/YQeAFYRam4dw5xEiN3+bIc+cHBF+c+xdrslNk35tJKLnuRhQ9axjZ5RixCC06CU5dbsHt76x9zBjKyOkoRej4vkhzQw12ioo0SkfpGZgxXVon9xjMmgQ+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967510; c=relaxed/simple;
	bh=buWb1mYIbZuoueQ+igh3aIS856Ucbitya6cvYIQ39j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crh8LwVUf73BAZBbzN7/qOqeTuVbdWgzMWjdRTTpbos2ssDSTMeqLdVlM0jQhKP1CiAz5LZno8Pb2pjEn54AJpfIl313G4rMQFmfhEH4hvEJf37b5/tNMWqnx9MyrR9X7o5MIEzwvTN4eMgmO4OJj1QI0M6YQyLFzE8Tiv9T/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ArMrkZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so2011313f8f.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967507; x=1758572307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk7VDfggOVxoCfJTfXofQn7wwEBoXPibdJy0B7pJLNE=;
        b=E0ArMrkZBEVu59eJHzl5UzQmg+jrPyVDouiAom2opfHDgSMKcV3XsD2a+0LVktX285
         nBUg+IIKAk0A9cN862Kzr4/wPcZtYTZxJnSAOl7pCVWd48DMg43M3jH1xgXs4D3iZmYu
         7bWwJRIxidm7lA9rfo8eMWXwNSBMlvcAgzeyey1Vhl2NMrYIPcHLSXQ4Zjeh0zfjbKeB
         vvtCVRndZlNFp0LJr0wLbDv4TMjELCGUfIfHRiFz3NYV5v6detFYBzirUEY/kt6KIaXR
         nD/qAi4DQ1ksBYspbj1cx0PKYsEcSx7Zub7sHQtwVxEj/si3nbe76r0gqV8kzjnbCguo
         +RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967507; x=1758572307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk7VDfggOVxoCfJTfXofQn7wwEBoXPibdJy0B7pJLNE=;
        b=D+c70EtbJxti6B3tqnv90MVg4ot9geiTUJBRAZAejYCaRY1P/ugE932QetW932spXO
         0SMLTLaWHjKd1IGIuY4MeIxVVSHSlEDIiTsmcYpbHx/+QrYhb9wHyLK6qRg+W6LT6odp
         ep0SIR+gLfPkll1ImJzs+QuuVRYpkZNTs2Vw06pfnOfsRES6K/OtEFXb27nrGYBcVxIH
         3J7Si7zfQF0882DuSRPitq6+WfePTf5CqYBGqFR4R9W55AsDD29Oy1j/+KaAJyW53M5u
         UMnmuC6V2tibPtOHS92Y64ezqkAJNcXFR2fJJOXwHg8TIBZZVCR4Ph96pNE2yVBzLBso
         xDZw==
X-Gm-Message-State: AOJu0Yw7aSkVxB+9Yyy7i5wc/0Yg0txz8kfF+YFJRKOxtxbhiLR5b1hs
	X/XDIqQ9/g8RTQjDM02nj+vCp05fCSnWw6L9jtQoeEEXoIC4bhR3wPkUG0IaXw==
X-Gm-Gg: ASbGncu4ov0SkIU7GD7XKBKj5TDNpSvRq7uoJVKvWtHzryOkcgGZmT2sGW80Rd/prqT
	PQtWc8NXDZn6k06SYpmrVtWJrn+ChqHcOso9nQCiexeaRhQJ81c9oI0OsApc1GYq0dtSNI0tPmO
	qsU7spAKfyymkBmlp02RpnbnmBc1sZRDI5WCqYVSJBZsZV1wx7XIXLt0fewzSrcl2zB8jMoEndb
	RZZ54vShTf8qYtjw6Maax/Z5Ok3I7eIpgcw8iqaTH8JUQq3otDesu0Q2FXVxku/4lBYXPnlZCAC
	12NYuymhTWe+ptw0a0syq+ktmHobnVm+H21pRutf93oMFuk6WVk7rLtbMy1FXOvgMFHfMS4dD6y
	anEc=
X-Google-Smtp-Source: AGHT+IFsg2xDh7ZVhs3WsWArUfgv+7XdL3prijK4/CXPldisHdS6d9ABTZUNQihGfroL5NC7DbKWLQ==
X-Received: by 2002:a5d:5f90:0:b0:3e9:d9bd:5043 with SMTP id ffacd0b85a97d-3e9d9bd5644mr5147298f8f.0.1757967506860;
        Mon, 15 Sep 2025 13:18:26 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372ae57sm188392365e9.8.2025.09.15.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/8] bpf: extract generic helper from process_timer_func()
Date: Mon, 15 Sep 2025 21:18:10 +0100
Message-ID: <20250915201820.248977-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor the verifier by pulling the common logic from
process_timer_func() into a dedicated helper. This allows reusing
process_async_func() helper for verifying bpf_task_work struct in the
next patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0e..ede511ac7908 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8520,8 +8520,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 	return 0;
 }
 
-static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+/* Check if @regno is a pointer to a specific field in a map value */
+static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
+				   enum btf_field_type field_type, u32 field_off,
+				   const char *struct_name)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	bool is_const = tnum_is_const(reg->var_off);
@@ -8530,26 +8532,40 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. bpf_timer has to be at the constant offset\n",
-			regno);
+			"R%d doesn't have constant offset. %s has to be at the constant offset\n",
+			regno, struct_name);
 		return -EINVAL;
 	}
 	if (!map->btf) {
-		verbose(env, "map '%s' has to have BTF in order to use bpf_timer\n",
-			map->name);
+		verbose(env, "map '%s' has to have BTF in order to use %s\n", map->name,
+			struct_name);
 		return -EINVAL;
 	}
-	if (!btf_record_has_field(map->record, BPF_TIMER)) {
-		verbose(env, "map '%s' has no valid bpf_timer\n", map->name);
+	if (!btf_record_has_field(map->record, field_type)) {
+		verbose(env, "map '%s' has no valid %s\n", map->name, struct_name);
 		return -EINVAL;
 	}
-	if (map->record->timer_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_timer' that is at %d\n",
-			val + reg->off, map->record->timer_off);
+	if (field_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct %s' that is at %d\n",
+			val + reg->off, struct_name, field_off);
 		return -EINVAL;
 	}
+	return 0;
+}
+
+static int process_timer_func(struct bpf_verifier_env *env, int regno,
+			      struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_map *map = reg->map_ptr;
+	int err;
+
+	err = check_map_field_pointer(env, regno, BPF_TIMER, map->record->timer_off, "bpf_timer");
+	if (err)
+		return err;
+
 	if (meta->map_ptr) {
-		verifier_bug(env, "Two map pointers in a timer helper");
+		verifier_bug(env, "Two map pointers in a bpf_timer helper");
 		return -EFAULT;
 	}
 	meta->map_uid = reg->map_uid;
-- 
2.51.0


