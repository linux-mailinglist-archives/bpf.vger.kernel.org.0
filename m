Return-Path: <bpf+bounces-70751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE1BCDFA1
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 18:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3BC94E86B5
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D42F8BEE;
	Fri, 10 Oct 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMsrJH7F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E691ACED7
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114776; cv=none; b=oGl+CK4O8FzEjrEMz6LrVnFMqzktjkN+pvNeLBJUoArBqtJnj7KO3tgaJlKoTvWESCkwE+suKjIgGVwXOmKK3hc3G8Al4mfAJx6fzfsJ7WcOy21dynxPqn4mZXvgBCx8jvLzHdUk8C2pJ/GMPlVVoCmV/Zf6anyBNzdmTszTERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114776; c=relaxed/simple;
	bh=pt6uVl2va0017+usTJPtB2mgd02MUjIvG/vyseBfMA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8ygIppzJbtbSKLF+mh8YGBPh0M0M1yl4aoHFzhmqfHwAsvXDke0O7g3VDKzRbC8+Iu3bwc7+sO6oUQO7RByulTqeIpg/MwaLkIoW/qi6y1oamCclmnf5OBiLOHGupul61DsuTKqXPswXyOh/BDrSALFdTP0FMTlwjEzRk0BfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMsrJH7F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so22579905e9.3
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760114772; x=1760719572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTZb7gvf4mYiD/+BcSu2mE9chUq77bafq2p8amfYPNg=;
        b=PMsrJH7Fni0xv9wNzotGiiOPPNhCuO1ztysrFYeVd4frMlTbqvAy2j28x2JEDNCBYs
         UwgPg4ir2UxhR3IZrIJ8oZHErTZyjSIGBXmFFoB5dGgujl1JokyZDSEeSabmirkF+ACu
         drZbPXe2b1QBsoA9dJsBU4S5PDOOzMLYu2Bi+9gHBlBDXipnXxVnOHIUgugGIjfmrhMQ
         VUkmcPlLB5z2WwX7Z7GIsut0iJBVlaDW09nvCycmTzCWMg56+LjsTCFEKHWdJEi4drJ4
         1QYHK0fRw1FFA8mNc3jPyCtRbXSJYv6epmQFQO+pGVGJMQVmsw7aWtyr265W7/4Xj8Su
         yqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114772; x=1760719572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTZb7gvf4mYiD/+BcSu2mE9chUq77bafq2p8amfYPNg=;
        b=RtSumbT32qMDs/lCpiDPo4SXhZ3KqzSOMMLf7gI9rQW2jwWp80235zY+4fyY/SEQ4I
         wsQc0MJAFuF+CXKwyfOo1vHwQbEInruZvr4Fl73/LverN75TD+s+2rWA0W/FRF40tnnc
         c64PyPuE/0oVsEjCByEL6RRdII4EUejL4lxAlJSlG9MtP0ZNh5R3ANTXDjEdYPIZ/aEa
         pgPcI0KzCle/a5d5LZDGYgGN5tHZxC0U8EYtGjpjDGufxpGwtguo94RjWbaPm/dxi7n1
         8uKnzFwKyGbExgk+XCiBQZrhrqANbszseWOIXtHoZsRwCBUW0LgT7V1V4Ns7VaziXXPN
         qijA==
X-Gm-Message-State: AOJu0Yxa/rUj3cE4Ok+CG9P9tTq2OF8njJ/bMNEDq41Nmk2zfF1nPWGH
	hGF0i0AYS7c9iz5nsyrAipZp1hPLkxWHhSOjJlnTC5cmAYoIiYlMpcUVpn3KpA==
X-Gm-Gg: ASbGncusiL38BDwBjz/Ro8XOQqO7mM7QN6MbfIiPDqgRQSE/kOs+xBQS9kacxr0xeYE
	eBkMSrt1vNykBomNAtUY1KGVGVn4+TRC5x0hKVWhzkIbnZP+2S38DKtgGgdlv2CqC00nIhpOhuv
	jK2H+lwcAhzY/BA4YO/zLYLp5bppOMZbVfL2OuoWj0wsBG2qW389S2NtzcOO3kYnJ1IraT+zGAq
	otk7wWTvttAfD6kzFn+bsWTMkOuJL/0TPZR/R4+P5e77QdGd4S/axcSCNlkRScpLTNCnWPZYQHI
	mNtaU7zJz9gQJGmTNBfVhWNAMqW6BQ82MYsV0cb6cEAUAPnVKD0KTkUhlxucLkQ9ZosH9FDBLkg
	OvD4CMl34nuoSBL7gnpGkQq2+nqhsz9ZNAg1+nUT9tcW1KjbMtsWBzUw=
X-Google-Smtp-Source: AGHT+IEfyvaAsIHKAqICgIvcz/fFrJNd4U15Au8JXM5z2b++FgiG3sJGLcHYaj4snSYI9arIfLcMmg==
X-Received: by 2002:a05:600c:34c5:b0:46e:4ac4:b7b8 with SMTP id 5b1f17b1804b1-46fa9b05361mr78524305e9.25.1760114772338;
        Fri, 10 Oct 2025 09:46:12 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8141sm4798678f8f.48.2025.10.10.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:46:11 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 1/3] bpf: verifier: refactor bpf_wq handling
Date: Fri, 10 Oct 2025 17:46:04 +0100
Message-ID: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
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

Fix handling maps with no BTF and non-constant offsets for the bpf_wq.

This de-duplicates logic with other internal structs (task_work, timer),
keeps error reporting consistent, and makes future changes to the layout
handling centralized.

Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


