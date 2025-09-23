Return-Path: <bpf+bounces-69388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782BEB959F7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687CD19C29D8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22530321F22;
	Tue, 23 Sep 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFlyX/NX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187E2798FE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626655; cv=none; b=G4N0O3Ksx+FFmwSYIfLERLSMtWIGT1d2oLKx/NX1zq+/KbjHNNJ4vYVdGVERn7QoOhiKUzluWA3ilnHVyfnZz7yUx8CcN9V+d41J5E+kINZFhlzJ8rK/I2/NMkeMwWger62P+zd3/Dzc954ff2BAoCn/HPcEetRlL/uNVH82ibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626655; c=relaxed/simple;
	bh=mYjZflfraofIdIrqNcyASv3dE+/T+CixX0RdQcAvzkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvyR+zOhsR/5Z3I/vhpV1S0TtBQG7gIn4x31sV+ICzv/WyZqfiCCbfejI/LOIrA35mSjz7VFyAt94faZI6d/UztZroS7kwB5GV5mbkWz2AF64L/ZDV8C7oyzEzwnxTdEJEXcPJ10bk/8/KmotTjq3kUle867Ul9tJzrY2gDiPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFlyX/NX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so8249830a12.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626652; x=1759231452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PonWviSEZ7cyWph0UVcu7ayGQBsHDfA/+HZsNb1jRKE=;
        b=jFlyX/NX5K/99vToLCO7NJkVBgGamsQo6/8Vd82XaiKGuI9v6ndOx4exSg9VSeUBZ2
         AL4w6ILO6A2+OzxqCjVKMuuP7keyACpB5E0cdL7cel2mpnZc9c0X0KislzYitrP2IGmG
         wfqLPfpQIcmFsL5k/pUJy61uj/Hil+8sqDRGfqy/YTPgiyeSr3Aw+4/kA0Nn+EgK2G1P
         1PqyXLWBddYPCPZmq9sIVKSFlzneJLXOH1Cs0451n1SKuN/8C+5caOwqTrmkia9rt3RK
         zdux9dRORAK2W0XtGK4bbwK+daGJIW/EwVoGx9Ij0UGIxcgEgoA6wk/ZAVBNYNmrV4yt
         lyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626652; x=1759231452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PonWviSEZ7cyWph0UVcu7ayGQBsHDfA/+HZsNb1jRKE=;
        b=xSC3gGPmDR5v2hMqApkebep7CSLCVJVutbchzEfatGFzTldUeoeMxOk1rYZOzVA9Ka
         SqrOtBpL0PrHSDbqVG+r/zlLomjlHjCdq5Dg8CbFRt4GVo/ajYKyLVW2ucn3p5AGPuNM
         9aRtEQzw57Pua9bLA7K2ZSmpYGKE6GhI3wllWmddjSZ9Wxlc6hL8+aTZLZNPZH6/JnNf
         RAUzsl4kjvp9I+MVkdbBxo3mZSqEPCkC4jqlk9VvY0m6sb1090Totr4dkaeZSgkybWgD
         MmLTzb/amUMbuldLEFYp5ztGmxpCsp0zDyNws6rrjVhpPLCHV/xgVX+Z8GFo4989Imfb
         SORQ==
X-Gm-Message-State: AOJu0Yw5uikux+5U4VKBX5++G1+DfLtgWbEGAaNzQL1Q+3x1pGw0l4Qh
	5YHnxLtEMsR5DmG6mLKM1B8Hek9jU5DPcusQHR/DV7zAMfqHFH4M1w9kcXPq5Q==
X-Gm-Gg: ASbGncsuCELQnEOaqnV39zEkGN6zcK3e53sTBUR0N9sAhNsZK1QkKDe8PHmcVziJEe5
	0KO4dLqOuKZtgE3Shxvjy26H3QuCdVKilQmvSSL5wcK1k+e/p7Uq3b+beaIIAsdU7MSO6GbrTco
	W1baKfAhupumhzcmxPwGCu2XxKMfWjy8bfPlGNF89HIRUAME0V81eHlbPromnaHDM9G0Use1PHk
	SrKvzsQWNbiQ66In4vQxCS6oDC4Xd+hcJC+HmyNLAK/6BHUL/dyki52uInMz+BwPxPq1JMwtmmG
	D+0M6s0Ccbjb7p0t0NGWIlsfhP8wyuzWTss6DkB0V3+hx4mSorh6ADi6tYRyGdO+cgIIIZXWSPO
	/141j7Do0KIqwa2/ULaev
X-Google-Smtp-Source: AGHT+IHpcQtLi4RX0ntLkJsNmLuSosVuLqHjrR02CCwOwFkJEkW5tDRdaFNvryy17CER7DjesUIHZg==
X-Received: by 2002:a05:6402:534e:10b0:62f:6860:2d86 with SMTP id 4fb4d7f45d1cf-6346778e023mr1664373a12.12.1758626652174;
        Tue, 23 Sep 2025 04:24:12 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f27640sm10509573a12.39.2025.09.23.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 2/9] bpf: extract generic helper from process_timer_func()
Date: Tue, 23 Sep 2025 12:23:57 +0100
Message-ID: <20250923112404.668720-3-mykyta.yatsenko5@gmail.com>
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

Refactor the verifier by pulling the common logic from
process_timer_func() into a dedicated helper. This allows reusing
process_async_func() helper for verifying bpf_task_work struct in the
next patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 kernel/bpf/verifier.c | 47 +++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d4183bc3cd1..c1b726fb22c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8431,34 +8431,59 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 	return 0;
 }
 
-static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+/* Check if @regno is a pointer to a specific field in a map value */
+static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
+				   enum btf_field_type field_type)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	const char *struct_name = btf_field_type_name(field_type);
+	int field_off = -1;
 
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
+	switch (field_type) {
+	case BPF_TIMER:
+		field_off = map->record->timer_off;
+		break;
+	default:
+		verifier_bug(env, "unsupported BTF field type: %s\n", struct_name);
 		return -EINVAL;
 	}
+	if (field_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct %s' that is at %d\n",
+			val + reg->off, struct_name, field_off);
+		return -EINVAL;
+	}
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
+	err = check_map_field_pointer(env, regno, BPF_TIMER);
+	if (err)
+		return err;
+
 	if (meta->map_ptr) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
-- 
2.51.0


