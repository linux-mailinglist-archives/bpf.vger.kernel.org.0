Return-Path: <bpf+bounces-75664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1921C902BC
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 22:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C24D3AAC82
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6A313534;
	Thu, 27 Nov 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmqDbwWc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F021B9F5
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277243; cv=none; b=kX2bz1K6/NZ2z2SBsUwAsBQ7WIitGyqAzQ8bJJonsDO6lkVXycSztSS8yV/9D5poDbSitO4JtdHVipL6yl80vDR5Kqb8WeqqREKj30FjptEfVV1dvHFMbkE+P7rTgakWIcnm6oCqom4RBidM3UpltcF3ufcrGxGa0vlxEwKPBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277243; c=relaxed/simple;
	bh=+taU4Lw6+zQToOoUS/uTdzZRAMV0E3XXwmP/P4+8GjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qocqcRVGQ/gMkltMfwmnH6Ost+HxLGHtRd4Jv4tTniH7gLZ+08+bhyvWIyvo1g9a//XJaHSeaC+OU8xXYLl356x+/oUk0CZUv2bLlXRci9vn4O0dPcxGXSrhz0p8YLM07yyGjgocTTVSI3CyFtYLCIB3NokCUlgR8DaC87zluf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmqDbwWc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47118259fd8so10241495e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 13:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764277239; x=1764882039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z31GEYqAM3hIfqJVhaBUlFjuQeS8bbTkycJEKDbCOxE=;
        b=lmqDbwWcY5hqGI64H7LaCZqnN8TNkcMqgLRttbEURIMl7uEVnQVUmWQZpayVXMPZ25
         YUc+yxTvxEajvBjRZPhx0MfXX8gl+EpDTfXFXQbi8KmRcnvH8f83fFuiJtss1KCfx3qO
         9gQu1RH6Wr/36FnrubWyWKz0vIQYZAZkWKfkSSHtRPRHMvPhMfAfJg2oU7wkxmeOeqwv
         7iQ+OpWzNhBqu/2RIT8vuG4NBY5ySJAbwD6+3rrjAHOyyNF/RBGaLssZj4a4yerggmC2
         NoKU3W63c+TiZyXPOOk9oT4uzVwqbOsNBTkqq9DbG5LXAJ5agI13dyEMgRTgqb9eFXSn
         qrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764277239; x=1764882039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z31GEYqAM3hIfqJVhaBUlFjuQeS8bbTkycJEKDbCOxE=;
        b=Mne9nJF4odDO0r6KERl3cDWNwHpETPLUGuvAK3i4sZToZmccim38d7SzorWqEdeZAq
         499GBMpIbOyFu8BdpESfjz6Vrlgls2etgLPVh3CghXoCObuEy963FJnhYmawUziVSerR
         T/rgKiMo2RGOkh/b+RTamK17K6HgYdD6Ja03wM/vK9qmVHefERZJy0VXUw47VkDw4BDM
         YmFAGwJaN78UqAiG5QloADoLvpt/ETanPSA4PQf9GU6p0VG4sM1uDhUitquYM8ZmeKj0
         kaczDt+yury/BHZjTBpstFbvrLWdS14G453EnXKZ3LavdPOeyYOmlKwvMcpC1PMZMJeO
         IVYA==
X-Gm-Message-State: AOJu0YwQIz6dDZ66ne+xrhlfVgXR+VwKSxiIij1186f+CyfkzuZ9LQPP
	z+aecvmN6ojmAuBCp3IoCLeA2X0g5vEM1wQWNLG5+kOO5ylL8ZTQr135HtE9XA==
X-Gm-Gg: ASbGnctsJCxEM54hDrXnjgxDzOdooC450TZrYCXLBloNB1T0RI4wBfJHOn4mzNecMX+
	Xc8wbu/zFK4MyQBWyCGFd0luJEvY4BHDf/FbpD/G6+wIbIFmb008ke0Q6RPbeBmpcy1Duw/zGSG
	cyKCFT1FqNaIlT1qWIqcdQ6IiTXeG6E2vTwrr9HYsoIn8wNZfJZOmnpOl8UX++yVwEDR+IJkHui
	0CF4UE0A6seeQqTUvGvM+wG4wWh+aveNzKcuvV2ojmWfT37T2c//fFEI0pcOGvTNbHzl0srZiVn
	XxKTM7fjrZNFOHIEqiwN7FlNzpZn7Aw37debSnnU315OQCJQ/FkRVItT1vj7ymmUwxL9+30WSGT
	y8UoapcA4vle1Pflmkr3pQJoAsLmDF0g2+gAtw1YjpiQ1DfGq4ZDWCgQHxhSSd1PVLjLBqCCU6r
	SX1y8XPt22LNcYancc1qGtSXzNAG0O4g==
X-Google-Smtp-Source: AGHT+IE27IPdJpLQp4bZr8jch5WvWwtZLk9IVjw11LAKNKl06EMNXhlN9hEDCDXBxngKqvDcXuCWyA==
X-Received: by 2002:a05:600c:1c19:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-47904b10379mr156466255e9.19.1764277238990;
        Thu, 27 Nov 2025 13:00:38 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add4b46sm123281335e9.4.2025.11.27.13.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 13:00:38 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: force BPF_F_RDONLY_PROG on insn array creation
Date: Thu, 27 Nov 2025 21:06:56 +0000
Message-Id: <20251127210656.3239541-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
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


