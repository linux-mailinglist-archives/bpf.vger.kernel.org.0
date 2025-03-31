Return-Path: <bpf+bounces-55002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB97A76F5B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00BD18835CA
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151521507C;
	Mon, 31 Mar 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btYP6HTD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64B18C011
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453121; cv=none; b=NEWH2b5f96TxtLxo5VAl2t7K8i7Bd/SdGEvR6/wAAFszr65wW8hdPY/xUfROmXCBtxEgQFWOdj3geRYf+sByN6gUfZ29UVXKQr7DhFmRLauSkii6ZEenfEUfQ4ViWpujKDNWNLa3F7SzB9em3ii69aiwGvnyVA1XqrLhD5kcrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453121; c=relaxed/simple;
	bh=Wu07E+Y5i4mLlE+UakbdmEzWOpcAUc9uQ591upu/OnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YsMnXjUdhQjfHr41LA2ClET0mmQN7k74GM/3hjQweMtCMivK6e9/nTbc/BiOrpQeui8NDl9Xznl5j6js7JYDnlZYmzAikhHvFNKzrXDwB2e23pClekpdiuvEOPWs3boslJ9XzYe471GItPU7NADbAiDGG/5LAuUycMXSQI3bEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btYP6HTD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so9147244a12.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743453118; x=1744057918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6mPXaH0REzFw0L8CGzgEE4fixiOdRKweEDSQ5Mwu6g=;
        b=btYP6HTDBKQ2An0xxLEFGCgPzn4IZfSZ+Nz3JAxO7NL09tqGUCnsoxfFadLMhnWVAK
         dYXXvkURqwqNd/NKX8+EFS907eazjSFQxnYyYJNIleMYS1zy/GGl1G+1e2tiyIwqemi0
         c4GW7IPWNynomZfleJ55FzkqS6Dx3W/KYiixh2QJdrWiu+QpWKfVzq5712Oe33DCzI0d
         xGQpeIv9pn+Y6pyLqSfEjZLYohrmTXSMJKjxdTbB1x10+32iNKePCMu8uuOz1QlG2+LF
         X8bPfVcE6ri6dUeBHiPxgv9YZoQgra9K8KrK4FyG4sNVynhW70rUPhKMDojKkoKcGZ/1
         zk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453118; x=1744057918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6mPXaH0REzFw0L8CGzgEE4fixiOdRKweEDSQ5Mwu6g=;
        b=E5o23zVYnLdLi8VcA31NKAj5yXp9GVEW/VPgLRItbc2UEU0Kee7yZ0TjoW+H8cSkdl
         En0zU/8ceeaXVlvnpBGFnmsSKwswCwNDkA3uPkIphKffPFAbIPSYQm/UhITXlo2TFw9i
         ExOgpmpiblrJb2NU8U9IoLchsad6MLszkPZvVrRArp6gdzyzv73SmS0YxEi2eshaP690
         6bxFdd+oYXfEo140t+TkxbGSKI4xcfJ+MyXL8yONGP6s6DHsBdkpqDitetpC296e3z2A
         jMz6nqmskzsD6EwZDDunrkatLcJ3mfnPPVipr26hGo4Kb3meJMcJ4P0l+OFARYSZRUJF
         3NHw==
X-Gm-Message-State: AOJu0Yx0mGcQtHVZ+kNDVOa3uXpUtCUeNejibVA1/Zl4KzUgz9Pv2vKR
	mzu1AHOXY4C7qlYaknFxrgYg4Fr8W4O/PS1CoZ6rmxy9CJQWMUswSqFqEA==
X-Gm-Gg: ASbGnct6PupxZXCL8eJM0tSQUFC3roHTNakJFMGvKtgnQo6S+l3jT4o8KfXbIlsbTzP
	X40I5sg4oBBFlpVd9MgGu7WAhDzBnWdc80IsMHRZGMT8u8rOrLYVx+2q8p/EfgCUt/SsA+n7gaR
	r8p/EB5n1a/xe2Teg9ecs/lE2KzJ1WAWV2bA8eeJB38R35mMYDueCY8HeJrR8D7z9EehbsPoEkT
	bpbIvyC2Ga2W4WxNCB2zPAb8dbn/lyQb682V4i7a8gWMqLFdbMwQ76qnmYiREL8Xw9wAKqgNLYa
	y1QhtQSeNcBuMg7ND0Fufdyr9EjYOXUKD1iaY0FQUKLphvQkeYmWw2RWKYOyYlGU
X-Google-Smtp-Source: AGHT+IFywBuh66UPW3QVZUAhY9nO0kvQ54Jw029DM0LgEc4UvWyXTGbeF+Oh4QJmkl1oK+jqFm4u3w==
X-Received: by 2002:a05:6402:5112:b0:5e6:17e6:9510 with SMTP id 4fb4d7f45d1cf-5edfcbe92b8mr7526171a12.6.1743453117573;
        Mon, 31 Mar 2025 13:31:57 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae2fsm6030589a12.4.2025.03.31.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:31:57 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 2/2] libbpf: add likely/unlikely macros and use them in selftests
Date: Mon, 31 Mar 2025 20:36:18 +0000
Message-Id: <20250331203618.1973691-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
References: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few selftests and, more importantly, consequent changes to the
bpf_helpers.h file, use likely/unlikely macros, so define them here
and remove duplicate definitions from existing selftests.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h                       | 8 ++++++++
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 3 ---
 tools/testing/selftests/bpf/progs/iters.c         | 2 --
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 686824b8b413..a50773d4616e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -15,6 +15,14 @@
 #define __array(name, val) typeof(val) *name[]
 #define __ulong(name, val) enum { ___bpf_concat(__unique_value, __COUNTER__) = val } name
 
+#ifndef likely
+#define likely(x)      (__builtin_expect(!!(x), 1))
+#endif
+
+#ifndef unlikely
+#define unlikely(x)    (__builtin_expect(!!(x), 0))
+#endif
+
 /*
  * Helper macro to place programs, maps, license in
  * different sections in elf_bpf file. Section names
diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index fb8dc0768999..4e29c31c4ef8 100644
--- a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -95,9 +95,6 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-#define likely(x) __builtin_expect(!!(x), 1)
-#define unlikely(x) __builtin_expect(!!(x), 0)
-
 struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 427b72954b87..76adf4a8f2da 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,8 +7,6 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
-#define unlikely(x)	__builtin_expect(!!(x), 0)
-
 static volatile int zero = 0;
 
 int my_pid;
-- 
2.34.1


