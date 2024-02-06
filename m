Return-Path: <bpf+bounces-21377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C798D84BFC7
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2BD1F22F45
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DC1C287;
	Tue,  6 Feb 2024 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnWm5p4m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39B1C282
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257135; cv=none; b=LyNwAIl3hxRYY+VX4aqnXaEgdnjF+ZO+Gb1zHO1Mns2M7Gd1zuZCtIfXVE4PVGTKxv5C5oDYQolD6HmJe0WjRYPQXZ0lrUPICBglPTgLfbWn5URs3YyM8E0NI2czzfq5FSYXD1S2KNuKtwHqfoDmMRxbNU+8lbO4ntU8H1j2Ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257135; c=relaxed/simple;
	bh=34DPUo57nj9loxjfLiNGICNBllqELHt4su73eaCRX6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C02T+DIPUWYYvAKntIFtf/yZtKJNcttE1+CRQaXaXt0RJ52FL4YL7kKeZykbOFwdvZHMhUtp3FbvsnDhuvCEOcOcQKJ8vwg7Sb+Me4Avi2VlQzceUuV9X8iWO20F3YtLgWu3FpNfQeX2MkRFIHE+qrHFS2b+DpdGWyFe+9jF7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnWm5p4m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e03f7f427aso6222b3a.2
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257133; x=1707861933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpvr7dgsK6u0sIpxAzSJWUuWXV5TlyIi0UfrrFuy1/I=;
        b=dnWm5p4mwYfbzAXJDiXSBs3dzU9aincIb5iKMyqY5KK4O7+gkaDBqlf8KPWkZizmWB
         y5X2ds8WZO+sIg1XVdghUmY3DJtqKbhdmqOXTF9zcdBzcONHsTTJ0Xc35DnmdZk+6TGl
         8w51Xey4KGB0ZhG11caws+XS2nyCDl5lpaZkafl/xp35O8mk0lLXgJo3kfaanHjw7s9Y
         3HUEuOSXfsh9LDYeUbUoSHPlnUiUTaEt/GXej/bA0q7BZ8Hfjo+An9qW87yzT1KBoyCl
         Nn46ZoI9cXRbOHtWZ7viFGcfn32L06Y+Fd3TEieLoSbxRcpsbW2AW9zUwoCzXfQgVidH
         YWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257133; x=1707861933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpvr7dgsK6u0sIpxAzSJWUuWXV5TlyIi0UfrrFuy1/I=;
        b=ZAgss8LWWE6l0V7tyVnhrirNltqBnhj557jUM4v12FUEUeSv7TscejZ1qK495e3Ixb
         XcVbpdeu727kgKhEsVrZmxY6TJtd0yD3SMxtfNIVzFbo3cozzMHlsyDnO0nQwyWg2AFn
         aNyJziOQ5AAgLG+sFfmQKjaYDItPwzKgPDPCr/6XPMNfIyARo3D8Q2w7d+1SRei47vy1
         144UNGQT22XUKRHknQ3dmMhAoZ+F1zYgOlT5WCQ6bAlnJYZHFiLZCNeIw9mfp5UsxOlG
         EmE9rkg0PaVLnHKzwM+rhYNXdgI7qdxgIpn8IlkxV+6AEF3wAZ0r4PE9JChrqKgBWGZ2
         xCrQ==
X-Gm-Message-State: AOJu0YyvdII9Fvn2NZ4nBtMv5jtAiOFBi3bHiueaUvzO6u6axBwLx5Jg
	50IHaoS4TONUBwRBapAn29SYOOnj7r8QgtUM5rQi2DINdWrS17ykHH2nxxW3
X-Google-Smtp-Source: AGHT+IEY4Ho/vNriwoPjJ4S75OBCY2kHP9G7jpkOFNGGYsmw17IByMEq936vsD27kQ2v+hwLcnpchA==
X-Received: by 2002:a05:6a00:c83:b0:6db:d4f8:bb1d with SMTP id a3-20020a056a000c8300b006dbd4f8bb1dmr1301419pfv.2.1707257132982;
        Tue, 06 Feb 2024 14:05:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2OGvHfmq89UQzCp1rwME6GQJLViCec64yB9gCcsghB2SWpFWsKo6/ZGOtD8X8cwbT65OVFmOToCbMFo8mIFHt5dOdX6bHawLpFq78B2yQpO2SQ+CAyDi7JP85wFUDSkEALC6cY8Jt2uzOJxzQANZN9nuIkX26PjvSgZmc7qjDGyu1p3St4AYihBbq9XC9KxRjpCsu9huR4K68LTgrecJJNvFuvorikOF9KmU1EEzO123aAdBH3wpLRjJAe2ZyON/Sjy5Gv2v9eyZ3yOVxj/zYKjqBFSWlngGz
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id o1-20020a056a001b4100b006ddc7ed6edfsm2497587pfv.51.2024.02.06.14.05.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 12/16] libbpf: Allow specifying 64-bit integers in map BTF.
Date: Tue,  6 Feb 2024 14:04:37 -0800
Message-Id: <20240206220441.38311-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

__uint() macro that is used to specify map attributes like:
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __uint(map_flags, BPF_F_MMAPABLE);
is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements" field.

Introduce __ulong() macro that allows specifying values bigger than 32-bit.
In map definition "map_extra" is the only u64 field.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h |  1 +
 tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9c777c21da28..fb909fc6866d 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -13,6 +13,7 @@
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name
 #define __array(name, val) typeof(val) *name[]
+#define __ulong(name, val) enum name##__enum { name##__value = val } name
 
 /*
  * Helper macro to place programs, maps, license in
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c5ce5946dc6d..a8c89b2315cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2229,6 +2229,39 @@ static bool get_map_field_int(const char *map_name, const struct btf *btf,
 	return true;
 }
 
+static bool get_map_field_long(const char *map_name, const struct btf *btf,
+			       const struct btf_member *m, __u64 *res)
+{
+	const struct btf_type *t = skip_mods_and_typedefs(btf, m->type, NULL);
+	const char *name = btf__name_by_offset(btf, m->name_off);
+
+	if (btf_is_ptr(t))
+		return false;
+
+	if (!btf_is_enum(t) && !btf_is_enum64(t)) {
+		pr_warn("map '%s': attr '%s': expected enum or enum64, got %s.\n",
+			map_name, name, btf_kind_str(t));
+		return false;
+	}
+
+	if (btf_vlen(t) != 1) {
+		pr_warn("map '%s': attr '%s': invalid __ulong\n",
+			map_name, name);
+		return false;
+	}
+
+	if (btf_is_enum(t)) {
+		const struct btf_enum *e = btf_enum(t);
+
+		*res = e->val;
+	} else {
+		const struct btf_enum64 *e = btf_enum64(t);
+
+		*res = btf_enum64_value(e);
+	}
+	return true;
+}
+
 static int pathname_concat(char *buf, size_t buf_sz, const char *path, const char *name)
 {
 	int len;
@@ -2462,10 +2495,15 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->pinning = val;
 			map_def->parts |= MAP_DEF_PINNING;
 		} else if (strcmp(name, "map_extra") == 0) {
-			__u32 map_extra;
+			__u64 map_extra;
 
-			if (!get_map_field_int(map_name, btf, m, &map_extra))
-				return -EINVAL;
+			if (!get_map_field_long(map_name, btf, m, &map_extra)) {
+				__u32 map_extra_u32;
+
+				if (!get_map_field_int(map_name, btf, m, &map_extra_u32))
+					return -EINVAL;
+				map_extra = map_extra_u32;
+			}
 			map_def->map_extra = map_extra;
 			map_def->parts |= MAP_DEF_MAP_EXTRA;
 		} else {
-- 
2.34.1


