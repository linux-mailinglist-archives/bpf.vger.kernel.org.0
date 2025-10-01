Return-Path: <bpf+bounces-70080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFDBB07B1
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A62A4C1F36
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B742F25F1;
	Wed,  1 Oct 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZM6S4Zv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597452F0C7E
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324987; cv=none; b=nIKA46Hlym/yXRI00Y9t6gsugwJAKKRlAdvlXmpvxUvGBhFCg7o3e0ixj3iOznzFcHApC71LD0t3mNIRzaWbw/typSoR1jGCrcwOHYIYC5NxZQRR7Ajgjlg4fQ8Z57nLBhn4hdEBYI267z6jSfUEn4hPGlzugFTE5XxA5mGJgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324987; c=relaxed/simple;
	bh=XGdCXGyURAfYK+2QgoCuti8S1zLnkD/p4zqxyRDsm/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d56qh2/drxxqGoszTsPD2blTQE5PWONLJ4FdtQuxYg6G87kP889f0SJu+n8hENzJ317+6mU1ifr42+Z1JjexK1GLYQ5OWGJC0DIz4osddMFH3sD4TmLIYiu3nD2Hkl2g2/I+7SRNtOatZRqwPGADDCyIhctJ3AhMkEN7kgnvDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZM6S4Zv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so28494065e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759324983; x=1759929783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpUfrTjc5fBEyBqQ06D1SVAJnrsiCYMHXuVwDuww1Uw=;
        b=RZM6S4ZvuHknOv+0Wt71n3/E/mrkJxcvKx3vg3v5p07NGCpUH9wttA/XzNOgE7Rbju
         g5rs2xE8A/sizP3SVHU+TA2vTptRbZPXAsh7j1ZHrcL9oCM/Pwk1uPfZcCWZiTeP0u89
         GYawBergguG75ABRKlg8aXbiTy2ayRwgkEbFdmvPkbzkNtkJ557GpFctoiynO10EUjXe
         ELKwD11pJjwvVopLykegPtSomqwybvMob2TZE6bFUIT7NW1J4GKtkO/X5OgW7TYkXaA0
         ce6zOOKyEs5CSn0wPrPkFMizAFrKJiTgPWDLiWoWHznYJy3Ed6s7YkZAmXEnKGLxZglv
         eG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759324983; x=1759929783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpUfrTjc5fBEyBqQ06D1SVAJnrsiCYMHXuVwDuww1Uw=;
        b=QjuChnwiHOOaykZfDHxH7gpjzKnIilbJVNgazLwvfc8Z9ovbKwpIFlYoivgHTfFFin
         b8/8NgRbZ1EDdbyOgupsv21Ijgtu56GTh54Dsn0hyUZaCH53Gz+hxXTah00A1H32wmX0
         co/PUUlS0hFimA9NuB/VRkEdvVXS4bi9AN8XO5GDfN32juxv0qlwWFOeDb8al4mvCYPT
         5T3ugp6vp7aukJvtRaWkPloq3UazTIgIDI6pYubwXwlt9Xi1Qnw518J6EcRBsLYLZLzr
         Z3r3SNWcjuKDi79eW4K7EXwf2FtN8i38qKRCnomBIeBf0cjrJwlMFbOpx873dXftPk45
         jI+Q==
X-Gm-Message-State: AOJu0YwIV6E+0+jeF8DZbTwU5hIYbwCkjI5qrQ/yXmDTbW+mQjkdE8Tk
	s4Aw+Ta+6RD6oLndCpPqpGCK1lyerC1ftbviKeK+d4Zwzjj0IGf1p5NEBfyJkQ==
X-Gm-Gg: ASbGncsoPWyHRE0/VcRKkKdf4hzbmjooh/rjtit4dF5BtJ1E2o5E4hBqamtIl3rszkE
	/gTh/6hivL+Ze+16ZkYxRM1+ly+I8nRv9nrZnf2RC/GPkhT6EPQjbsxDcvpufndMdkbBZrxH70x
	ygZwrV3CejDawApITKCfHFDBx9Q6vqzIF4mLEyFQmh0IMip2E9USxbr2nWgv8amYguXsT+iy5ax
	lAzrWcqqUGuDIQnlyx5CIeAMzFkjUDXhV8PQGXL1NLSFA3vIHS6+4rm5y4FrAcrwWHqPP1fIBM4
	nQGM7dd3js7Z4fXhCeIGcmmhj+02OL7hbOuTEnKYWLqx4DSwy/zHobiR4kcCScUWfjvwUaTZ2yI
	r+ZjMySpLNgieXxTCyRk3CyhUWDmPRg==
X-Google-Smtp-Source: AGHT+IGJz610ZQik+UzUe2Yh3aPC7WmbPpfgtXVLFYiHXyIOr7KHLmFOTqWdMGV9Z/3qFD3QdwyNWA==
X-Received: by 2002:a05:600d:61ef:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-46e6127a551mr27520745e9.13.1759324983226;
        Wed, 01 Oct 2025 06:23:03 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:a74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a265f6sm39351855e9.20.2025.10.01.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:23:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 1/2] bpf: verifier: refactor bpf_wq handling
Date: Wed,  1 Oct 2025 14:22:51 +0100
Message-ID: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move bpf_wq map-field validation into the common helper by adding a
BPF_WORKQUEUE case that maps to record->wq_off, and switch
process_wq_func() to use it instead of doing its own offset math.

This de-duplicates logic with other internal structs (task_work, timer),
keeps error reporting consistent, and makes future changes to the layout
handling centralized.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..b2d8847b25cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8464,6 +8464,9 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 	case BPF_TASK_WORK:
 		field_off = map->record->task_work_off;
 		break;
+	case BPF_WORKQUEUE:
+		field_off = map->record->wq_off;
+		break;
 	default:
 		verifier_bug(env, "unsupported BTF field type: %s\n", struct_name);
 		return -EINVAL;
@@ -8505,13 +8508,17 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_map *map = reg->map_ptr;
-	u64 val = reg->var_off.value;
+	int err;
 
-	if (map->record->wq_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_wq' that is at %d\n",
-			val + reg->off, map->record->wq_off);
-		return -EINVAL;
+	err = check_map_field_pointer(env, regno, BPF_WORKQUEUE);
+	if (err)
+		return err;
+
+	if (meta->map.ptr) {
+		verifier_bug(env, "Two map pointers in a bpf_wq helper");
+		return -EFAULT;
 	}
+
 	meta->map.uid = reg->map_uid;
 	meta->map.ptr = map;
 	return 0;
-- 
2.51.0


