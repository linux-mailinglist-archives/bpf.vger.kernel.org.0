Return-Path: <bpf+bounces-67581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D155B45E7B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F301717BE68
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADB309F02;
	Fri,  5 Sep 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+zFMOwB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2452F7ACE
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090718; cv=none; b=HIBUOkMKMQU6j231g5PIITmT+f9PFe8lsQNJFZtmQWsS/lTQvmJuINgh81HxGoepQd7u5PTcjHa/5HD1H26XteGxliG5Immnlib9sgytADI63c0QHHBQz6Pqao1S9lEwH5ibvjHq6awu89IPpNlv/EZYp/MHolbExgsFivffoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090718; c=relaxed/simple;
	bh=v3KB9I3KbznufVXm9NrjrsbvI/Lid3OGi5TDnItzEDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QY/7ZOsYML3RuQP+WeOmUDUIGSOiv5vFKLlgwaJ0vdIfCGIPc34uaeGlgFXDyODRrBBpDY1laPXgdurrYhSoNL9cjgbHV+pdlIX7LufNqmEZZyqz3mraXpxB5txFey0ECXmnJjVxI/rkhtU56pD/f9ahcUojniaJqcMlh158JW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+zFMOwB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1336769f8f.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090715; x=1757695515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxytmS/Ckk7m1jV2iytTHllbgR5XXiv+XYUENzBL1c0=;
        b=K+zFMOwBnH/ZfBmvK2H95jMfbYYF6cczAD++9vIY691lPIBkfNs6ta7+C41abRdCyQ
         M4TaLGJiwYZb32IMHT5xgkzt87fWOzPXOQOp/bI104Z7/36fizlRQOau+lbDlrP6YdkH
         mhWHbZwVOYwovltkCHItwFQXoQwoEarzrQ5XsShg3yk/mAbh/3X27+Xc+tZ40pQ6EPK+
         5DQtIulB9K6g4u6ZclWgUbsQMXWDsbQj11flOjfFB4/gdfEI+uRx6WYhtrKvb2VpzghM
         vv844ctnj+4MhABSbfiHaRVIag7z1p41KvHlwyoNZMDC6V7dAWcva8Vy1Mh2/ydxxV2o
         +f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090715; x=1757695515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxytmS/Ckk7m1jV2iytTHllbgR5XXiv+XYUENzBL1c0=;
        b=OccEvwMicKFIIXp/OgEkjt/8DSg3J2Qh5JhbU3wC8cpCdTlNXnv2L6ZdGNXj3qZhPS
         XvAcTpJvBbesRclYKwOR5IM/joM9F+mX+8vmj9XXMWp8L+lOrrcmrNXK2OV0kU8Q/59W
         /DPJM1rGHfg/Tqp/5/vr4m0UaYbjHa5OqPwgg66oIUH6BmrLkb7drOobho8GFHjx0apT
         KKMj4wqc2nXaEBkxIDulkyJYa1a25Tg/pwOvh3hnjtcsjSt4fMyfAwuRY1XMnqrUXqb1
         p05XPMC8umT23ERCbf5/8snPrGfOv/XeybEhirKyJwluCa/EW0kTDAu7/fHeIhOgeB5G
         23Ew==
X-Gm-Message-State: AOJu0Yw11xoup6BG7MjCaTTVPAUJtRHgZvGjVQxLtub6iT28THGzjZec
	slHg7rv8HPvdAE1SLHuT77i8tc6k2vB+3HIbkJbADqSbJ4niEitbV/d6MFLJkw==
X-Gm-Gg: ASbGncuAVtGQZ9RPeCj60iKLxUsSYNk6EeV41BNTMrNkpd7nQ5FBxHAPBUF4x2/Ug5E
	uDL9HuROj00WNRLj8TAIZ/gmjHyVjoji3s23c7AOrxQlV1OmVrqK9qzCscpO+1DInKsSBeV33mQ
	fVxG9qqE4rHSgTR1WaRUbvJLKBXg7TL40OE0l2bCbxWR6QKumJMVQT8hiy/e9mEQSdzUpDi/e2Z
	HI7MG9/tL2pRaSliLqVlVx4qcVxxKEWwpVf0Bjb/A8yHDASuGjO+FNTwbrAKe4gj2X6Ou+Bj5dS
	y5ZEBZCuUPR2P1SE9SuH9ylSnEez0lFjmotV/aWBLtXJNpP6EPtPIHvUog29npYDdMKR4r5rz2k
	Hrdo8t37RFtbxZMqzqxae3lg2QvMIVQY=
X-Google-Smtp-Source: AGHT+IFGUSqNhVSFcjLWd552jj3A3+UsZz302te3gQUBFRUUIea/UaE63PrpDhlQ9ArqAqxcGYHM5A==
X-Received: by 2002:a05:6000:2a02:b0:3d4:a64:6725 with SMTP id ffacd0b85a97d-3d40a646ab1mr12767794f8f.10.1757090714928;
        Fri, 05 Sep 2025 09:45:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dbead0b247sm12949512f8f.6.2025.09.05.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/7] bpf: extract generic helper from process_timer_func()
Date: Fri,  5 Sep 2025 17:45:00 +0100
Message-ID: <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
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
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0e..a5d19a01d488 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8520,43 +8520,52 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 	return 0;
 }
 
-static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+static int process_async_func(struct bpf_verifier_env *env, int regno, struct bpf_map **map_ptr,
+			      int *map_uid, u32 rec_off, enum btf_field_type field_type,
+			      const char *struct_name)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	int *struct_off = (void *)map->record + rec_off;
 
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
+	if (*struct_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct %s' that is at %d\n",
+			val + reg->off, struct_name, *struct_off);
 		return -EINVAL;
 	}
-	if (meta->map_ptr) {
-		verifier_bug(env, "Two map pointers in a timer helper");
+	if (*map_ptr) {
+		verifier_bug(env, "Two map pointers in a %s helper", struct_name);
 		return -EFAULT;
 	}
-	meta->map_uid = reg->map_uid;
-	meta->map_ptr = map;
+	*map_uid = reg->map_uid;
+	*map_ptr = map;
 	return 0;
 }
 
+static int process_timer_func(struct bpf_verifier_env *env, int regno,
+			      struct bpf_call_arg_meta *meta)
+{
+	return process_async_func(env, regno, &meta->map_ptr, &meta->map_uid,
+				  offsetof(struct btf_record, timer_off), BPF_TIMER, "bpf_timer");
+}
+
 static int process_wq_func(struct bpf_verifier_env *env, int regno,
 			   struct bpf_kfunc_call_arg_meta *meta)
 {
-- 
2.51.0


