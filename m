Return-Path: <bpf+bounces-68576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B92B7DB67
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EC87B3A9A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4662D3230;
	Tue, 16 Sep 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faoo07/x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116A2D8375
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065829; cv=none; b=F6FII4igUdZPPpz4SWLX2PgzDUoFdfWakngDlk12EItHRpLLDfWPK8keILPzP1QIgStGPBX2GpuVpOs3pHTHqS5EtKt1UTSCAzL/wh9EdsQjZafrGhfnn0AOUgpT0iga4oaDaXQfnx4Mi4fyzJkHjquW7QS94+3Qeapeuy2BVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065829; c=relaxed/simple;
	bh=XjLza55rP9W9yOAWKHcHEwQaaRJ0Xds7EniB3O3lItg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TevwGM/JNKB5sO0rP43/yLhOdyPfZGZP8D/BICXxdwRLqdG1EDvq9NDWGqRMAVYap/f6ncMsQmKGBbTwXG4B/V4QoIYlMUADKDcJtBW54AnoA2McZwl4wAXSmyhtx4ftJvD4Wevlba3PimRFlch5+7tCK/JncNy0c2RSLPaterI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faoo07/x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so2706219f8f.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065826; x=1758670626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7t/Lvgpl/7FPTm9hDpNb7vYOHi8mpYL69ZK3hJ/ctg=;
        b=faoo07/xfjxs48/vcMvHQLDbnpc3dpUXQVP2eSjbqP2ogNMAq6sTgEO/+RWr0ohvK6
         QddyRx4o+yGgGxcuPoO+rToOVjvFqPhcibiDOceRYaSMPUUATq4+geVLFCsl5elWvabw
         cHLUIlkmUngAc4SfIHO+aOTqlzJwKEQJLNofSKrcJFcgMyt2X9hcoSwTfbPH22544JQd
         dPRHgMpyxH+b6n0/A+79aay7V+xnfAu6z/KpMLKpVgAOEcQocHJlHtKhF1VU8FYPNnDj
         PWGuwf+Cv+NSjJuugwXJrJGP4IaUrUInwjmwx4W+sGsXk/o3xSFB4qbdDM4tSERv9xVY
         gkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065826; x=1758670626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7t/Lvgpl/7FPTm9hDpNb7vYOHi8mpYL69ZK3hJ/ctg=;
        b=vFM5jeIoui063ezvapGxyo3veEYardVxJgWplF25BBQYHu9j1JVWC3jz6GETbEvrJk
         H5w1OrWGkhgIZQKJfqnQRww1IbEqLosqWPO/Vz0oH6tt9Jm/lxXpjUEdRo47uyoS8E4o
         JdMsRFj8KTWknnBXZ4Q0GXzQuo1+f4iz30aljum9yBaCmmbRpB/LtUdja15NRXOXIUh3
         TJWE8PryxDoTd7o2KTgSvynLRWi1IsUAfd9lsfUI0lDM6RpOEqGyJe5yp3POHaHwyNO2
         x3LxqqS6WE91+pv3hpqtz/DAign0YjoMgjzHNcCRvBKkX8Yo0QXYkNryfjEKla1SqsUZ
         ydpg==
X-Gm-Message-State: AOJu0YyIprzaEZnRoQgmLYqY3+gE4Bv61mLaJxfNU807gav1BA8hYpSc
	nnubp5SoNOtVWMz0w8JqzL2s7t98xay9EXTOL9h+ELqiUppS5r+3/mHbv6nwww==
X-Gm-Gg: ASbGnct3kCGf+XhZdKb0TsuBnRClCRT3Sdo9C7M5mSPOs80tQhTw92dDOj2iTzKygVN
	JPucwJfyTd3h+AHn/H/M+mI9D1GJSUY6AEQKDVcXCAwmKgAr7Kcr93Y0L0ylSKWUI/u1a8v17Y/
	I2Kzi+ZpeZBO/+HX/govkPoP0c1LIJAGFXIQItM3+ir7ptNzjBl+y9HchErUuudWIhASZnzpK+f
	7wtPpxDiJZoZwdNG+9p+byRkL+jokAjfj9Fl81GGTm6Qe0/hIyyfiZBRPX+GJZOpvs55dMTczQG
	ylFsjIzUL1stX4W+GXLc06PCaGmbAgRLBOGDm7ZuM5jbyM92ZpfCgUaQMnML2NxFHq0/FOnJebF
	ANmsJfDmfrMd9jSxdlrk0FQ==
X-Google-Smtp-Source: AGHT+IG2Fono7gnm8q0WmcqnUkgZtPU4F2T+0RcWTqfDfvQ/bvEQjtadW6CNl7lZGAyNpFuq+8J5og==
X-Received: by 2002:a5d:64c8:0:b0:3ea:e0fd:290b with SMTP id ffacd0b85a97d-3ecdfa0d2f1mr121527f8f.40.1758065825732;
        Tue, 16 Sep 2025 16:37:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm17601449f8f.27.2025.09.16.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:05 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v5 2/8] bpf: extract generic helper from process_timer_func()
Date: Wed, 17 Sep 2025 00:36:45 +0100
Message-ID: <20250916233651.258458-3-mykyta.yatsenko5@gmail.com>
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

Refactor the verifier by pulling the common logic from
process_timer_func() into a dedicated helper. This allows reusing
process_async_func() helper for verifying bpf_task_work struct in the
next patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 kernel/bpf/verifier.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0e..c9e68c3f0991 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8520,34 +8520,54 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 	return 0;
 }
 
-static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+/* Check if @regno is a pointer to a specific field in a map value */
+static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
+				   enum btf_field_type field_type, u32 rec_off)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	const char *struct_name = btf_field_type_name(field_type);
+	int field_off;
 
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
+	/* Now it's safe to dereference map->record */
+	field_off = *(int *)((void *)map->record + rec_off);
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
+	err = check_map_field_pointer(env, regno, BPF_TIMER,
+				      offsetof(struct btf_record, timer_off));
+	if (err)
+		return err;
+
 	if (meta->map_ptr) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
-- 
2.51.0


