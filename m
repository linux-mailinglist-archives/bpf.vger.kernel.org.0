Return-Path: <bpf+bounces-78201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CBD00D98
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2737F30605BD
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8228934F;
	Thu,  8 Jan 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+FlhBeU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C9288C24
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842243; cv=none; b=YrIvkMgqaZIK5qqOIg9UTVlnuwd41W2kvQprj8WPhz3vHPDkpqg39FPmG51AlUd3Vf3SAiaXtLwxhImf/xWi0oSPnod0ow/IGXd+hkrWfAf4PadvSa95SNrgDQdAz/NLOJSOxsrqrlMPPXc0RhND0K7zTV13LrH+qk2nb+lwHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842243; c=relaxed/simple;
	bh=k/SsHZ5DiNBKCwpIZ6HyT/U/YK/VAISbL5KNMEGIsjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Owm36p3HUGnjA2JPzC35aOmuOyWcIv14zza+Xz+U0JPMj33xaPNTJTAnH39i0ZgLT6s7G38SRjQ4pgJtfNiJM1AD7zKaQdx4eIUITa5pJ6VpE3UsBFmMuyzmNi0FemHiFBkghAt7D46sbM0dzxHpvxQQY/7qjNM3fPDgFx2J3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+FlhBeU; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so2471707b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842241; x=1768447041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppA0C32r+tZo1J9bYSHe7omsyAFm3sfGap53g1ih6tk=;
        b=b+FlhBeU98dF8LDu2Yuc9JsHL4tJjq+ppZoCYorYprgrL8SgHV67QMKDNd+TAvVL8W
         nmmMpGr9+w871ztSfWdBfJnjs1Hcr4vuRB2NfgW8FvhYUeCW/yqX1teWisxZD4oy3WPe
         s9NOi/SigXV3vS/xlhmx7ASIR45lEVGtEK0a8VKZMYRvJXfBKCKHY37sUF0UL4b81Hih
         8A0uO7BzGgb2u913Y/yZ3VAq6OoEHXv9FORLMyK2Y3Y2W0dcigKwoDbOYh5ZGU//9Bm4
         T8LYnq7wxyimzoGxPO2DQGPJe5CZLGIlvZtw+qH8Q93lf6/9VeIMa9tsPGbE4nygjvz8
         O/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842241; x=1768447041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppA0C32r+tZo1J9bYSHe7omsyAFm3sfGap53g1ih6tk=;
        b=CaaXqxfGklEU1DJ8dHBVcn3EKcbn9G7RWqclo9C4aUiueenu55WEsU5jQwZaIBTHre
         oy/09Nru8nT8ID0+lZGT6g5m85thDz39wPliMA/5PNnJuR5op/U2QCaOOifWx4ZmHIeF
         GUa8HGSDcXq56O1s5cqtsPGTUJ9PtHzlOSL5l0yU9g3eNKZ7pSzJPw2Jpc5aZp2va88v
         YSit0wN5A0g1vMn5/AcHX8+a2iwm0DtKL0+KU2zKJ0B3hh5XMUcO0gyDHppZOZHWhJfY
         tvu04WLQ4nGQA5/57FSg7tPAZrbucizEG+bvvRryw6Y4DhXIvnmF/gUEodOuSNEGCzhH
         qNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnjly9JynuVYhgX5agO9SNAFjSUV/lCaVYCHHCdZLHSIlnrdHvblsRTKig/BmLR2QrQyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQF347UsBFeFRv4TJMnMy+AjnHnmWo8hRe7wm7B21NxGAc7gQ
	KhTNTsrD4ZAp6U/TP6DBhbkg1s8Kz23y56BHgxGNTS7OFYxPNUJIwfyr
X-Gm-Gg: AY/fxX7Wl7OEeT0ISDgnwHm+CTfxI0imw/MOuh4wzgoc+Z+Czhjlk+Qkm8PaCKeRfEc
	0aA9h8D3Y8n0yW6J5gxEERhDo+PxaoodL8PfbAMOUR3TotMgod5DuYAvNuqilAdoN0sp1vCeBH5
	SNNHFXqqlqIWKChI9ot6pv08UqnIw7CBZS6QzEQygwEel4B38OZHF9CiyFKfoV/la7ETrrm0/Qh
	CMN9ox5iKMezzWff6BS/AsK8RuoCKOjLNN1a6wrvg/VyoPTdv5ugBZ6rMc/5wnyFCm+y7Q3U62n
	m+IfoGnO4IBrkvw7xkGGy65qK9OCnnnrTJU9gV9j+3PKnoSuVD1VDGHJEOS0xjTXPFL+XK9ChsO
	3/6oxscI2c5jVfffT9096JNGm6YMDlXHzZUK7iRRT4VfaR6D7IjeIwlotW7tHv23h6iPYTgOOFW
	v9de9lDQ5tmx4iNldHO5rCClfBXeA=
X-Google-Smtp-Source: AGHT+IFST5MI6yDneKKwxRZqXrRJHnWyFrSyRG8+UfqIpoNr8TF9Bt7R6vZlLpFwpqTGnOdCk3i6vg==
X-Received: by 2002:a05:6a00:90a6:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-81b7f9d1932mr3793392b3a.49.1767842241503;
        Wed, 07 Jan 2026 19:17:21 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:20 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v11 10/11] libbpf: Optimize the performance of determine_ptr_size
Date: Thu,  8 Jan 2026 11:16:44 +0800
Message-Id: <20260108031645.1350069-11-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Leverage the performance improvement of btf__find_by_name_kind() when
BTF is sorted. For sorted BTF, the function uses binary search with
O(log n) complexity instead of linear search, providing significant
performance benefits, especially for large BTF like vmlinux.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 277df0077df6..9e8911755a79 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -659,29 +659,21 @@ static int determine_ptr_size(const struct btf *btf)
 		"int long unsigned",
 	};
 	const struct btf_type *t;
-	const char *name;
-	int i, j, n;
+	int i, id;
 
 	if (btf->base_btf && btf->base_btf->ptr_sz > 0)
 		return btf->base_btf->ptr_sz;
 
-	n = btf__type_cnt(btf);
-	for (i = 1; i < n; i++) {
-		t = btf__type_by_id(btf, i);
-		if (!btf_is_int(t))
+	for (i = 0; i < ARRAY_SIZE(long_aliases); i++) {
+		id = btf__find_by_name_kind(btf, long_aliases[i], BTF_KIND_INT);
+		if (id < 0)
 			continue;
 
+		t = btf__type_by_id(btf, id);
 		if (t->size != 4 && t->size != 8)
 			continue;
 
-		name = btf__name_by_offset(btf, t->name_off);
-		if (!name)
-			continue;
-
-		for (j = 0; j < ARRAY_SIZE(long_aliases); j++) {
-			if (strcmp(name, long_aliases[j]) == 0)
-				return t->size;
-		}
+		return t->size;
 	}
 
 	return -1;
-- 
2.34.1


