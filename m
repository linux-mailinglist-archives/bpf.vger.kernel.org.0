Return-Path: <bpf+bounces-75680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB612C90F03
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 757904E2341
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BC2C3259;
	Fri, 28 Nov 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0C84aJy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DF168BD
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311178; cv=none; b=gvfyfRWhMImGCSobxDtjDUdHvm44XQroNDP6bcdW03GZZ2Epzs/CdBwu/oaOuc/kl6h6uhsuZCPNDVgV3SRwfLojHEVLS0UtzJV+wIqfGIkBe59Qb+tL872Wzcm3nzQIvEcxUPTFd4dgiV5Uqy3MXO6sy5cCeHvR47IgM3f6cBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311178; c=relaxed/simple;
	bh=+taU4Lw6+zQToOoUS/uTdzZRAMV0E3XXwmP/P4+8GjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTpL0NQXjbm5frdmcKz6F8a70FkrEhJWZZZOh0Fuh8aKzarNGF8lcLmV9u2Yp1XuopnW/E2rOTeqQB0qpNyW52QntpQXX6qlLgTe/LuvaXZJmgfFY6Z+1GcyDF6eEiWUvSEhh+hJm3qay0U3VDXztMCn4F0jGzpAL6h/OBr1qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0C84aJy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so13724845e9.2
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 22:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764311174; x=1764915974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z31GEYqAM3hIfqJVhaBUlFjuQeS8bbTkycJEKDbCOxE=;
        b=D0C84aJy1+cIq9uVYmSjXPT+vd2GrO9O2nIfxqSPIP7JoxrrJSTScnnyRQGdL+BCOP
         bF8Rn4Zz1qaf3+PABPWuxJZMGTxyjEXhYRbuBwPAJ+SzB0WOwrYcLcRvpTMIaIDIBqzx
         +wIr5sBgk0xHhiNA6a84jJYAcZGY3JcWW13i2e4xAW3CyVQ0c6V11uLj/uk80iKNSxCl
         SM9AhQlhj0E5YkqOiD5cY1GfKLftd8+jsXzeETYLGxDmLXSvgLxO26bg4kWEwUcVwMgt
         T15CSeOEqNdtb4YUzmZSM1Kvs9+1pmBLrTH2HBogNRmDW+DXUhpc+cc9NklybE1r5TNt
         ppLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311174; x=1764915974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z31GEYqAM3hIfqJVhaBUlFjuQeS8bbTkycJEKDbCOxE=;
        b=HtIq323CD9FBbi+eqUJGMzbLKSRLaKKo9jTRz/XczDttsxMaKN6FCV/lmxdkcqS32g
         yB47jZSLhk4CmAlK34T1Wluf3DKZzrkQRTImETKXCF2eTIA7e/6oj/Bu3a92cvsdWhHW
         Hg2GsMztgaKF8pYoiFNp24m+Oj4sBeVXotIJ0AWQTpgQMf37qWSB9meCzW/rRvbTWkj4
         ih6bHe5EUaRuzCbT914A378ZterNUYRnMHlGxoSzFiLNclDj4vhx5HPybWWnvgqdZHf4
         V0ysFw3t7EptZkBmnbfg0jHDkfQswsdrp7tsBc2O83GLbZ2QXbg2vAlrkDQuoJkQSZ7A
         RtlA==
X-Gm-Message-State: AOJu0YzLksvc3Nw89+FcWvqtAFWYZS7Bm/37G5tCW5BuTaGGlB3XqKgr
	9orN7hy1YIm6r5bZLKJr1VtzQRbmOn7kbwqWI8hB3q48gWaWYSz/k8yl4b3nEw==
X-Gm-Gg: ASbGnctDPAc/ppUUANuVxQTjtwvUzCWjEuTywnz+jPT4SczUz5beuBa7MSVa0C5Aqxk
	fP0mXdYxzkNTtzkVELPyW64RUWjRyX/gaDsBr5S/cqSbiC+2H8P3zVIuq0Bhnv7lqw0K69fZ4CA
	GJy13RRU5wv1+1qopmd91V3moQ2OuU92kI9Zmk8vHVVz6j2J9HB+azDS5c29WvlN+b+v/4YBqqo
	R3JN5Ib0BTznzhYh3hiYd/lxffC+m/pKhRrVq1XEgAY24xwMKxxQ4IxRMSwKRksWTxxmAXkqCYW
	1CChwH6E8i6ZmRYpZaw2Cc17pfRCnVHme2fMqp7lCEEJpkJd65VT4Opv6aZlAk81hC7GBc4jMoO
	bDdclO1OAPDtjnAqd102uvSW9gbPEZBXSND8ghHi9TwyFC4wl7d7Fv7LkYGGTVdvscICi8lTywW
	qsQZXDxGidHhOE0b7fuoTOfW6duiy5cA==
X-Google-Smtp-Source: AGHT+IE2l3xlLw91WovPt8qQPJi+wMPlaiM/GcwhEm77qHymCryWgZs9KjelkVkS2fCbXrECdoTIqA==
X-Received: by 2002:a05:600c:1554:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-47904aebeb2mr154536355e9.15.1764311174089;
        Thu, 27 Nov 2025 22:26:14 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm84784575e9.2.2025.11.27.22.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:26:13 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: force BPF_F_RDONLY_PROG on insn array creation
Date: Fri, 28 Nov 2025 06:32:23 +0000
Message-Id: <20251128063224.1305482-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
References: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original implementation added a hack to check_mem_access()
to prevent programs from writing into insn arrays. To get rid
of this hack, enforce BPF_F_RDONLY_PROG on map creation.

Also fix the corresponding selftest, as the error message changes
with this patch.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/bpf_insn_array.c                        |  3 +++
 kernel/bpf/verifier.c                              | 13 ++++++-------
 tools/testing/selftests/bpf/progs/verifier_gotox.c |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 61ce52882632..c96630cb75bf 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -55,6 +55,9 @@ static struct bpf_map *insn_array_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&insn_array->map, attr);
 
+	/* BPF programs aren't allowed to write to the map */
+	insn_array->map.map_flags |= BPF_F_RDONLY_PROG;
+
 	return &insn_array->map;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d865848b789d..58f99557ba38 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7565,11 +7565,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			verbose(env, "R%d leaks addr into map\n", value_regno);
 			return -EACCES;
 		}
-		if (t == BPF_WRITE && insn_array) {
-			verbose(env, "writes into insn_array not allowed\n");
-			return -EACCES;
-		}
-
 		err = check_map_access_type(env, regno, off, size, t);
 		if (err)
 			return err;
@@ -7584,10 +7579,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		} else if (t == BPF_READ && value_regno >= 0) {
 			struct bpf_map *map = reg->map_ptr;
 
-			/* if map is read-only, track its contents as scalars */
+			/*
+			 * If map is read-only, track its contents as scalars,
+			 * unless it is an insn array (see the special case below)
+			 */
 			if (tnum_is_const(reg->var_off) &&
 			    bpf_map_is_rdonly(map) &&
-			    map->ops->map_direct_value_addr) {
+			    map->ops->map_direct_value_addr &&
+			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
 				int map_off = off + reg->var_off.value;
 				u64 val = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 536c9f3e2170..607dad058ca1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -244,7 +244,7 @@ jt0_%=:								\
 }
 
 SEC("socket")
-__failure __msg("writes into insn_array not allowed")
+__failure __msg("write into map forbidden, value_size=16 off=8 size=8")
 __naked void jump_table_no_writes(void)
 {
 	asm volatile ("						\
-- 
2.34.1


