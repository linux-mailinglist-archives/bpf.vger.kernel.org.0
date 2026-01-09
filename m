Return-Path: <bpf+bounces-78324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99028D0A5B2
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA3732D1EEB
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D930CD9E;
	Fri,  9 Jan 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5+5jieY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744135EDB1
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963641; cv=none; b=B7Q2xMKZITOPzVoKpGOzFiTxU/hcA1veLnP3PGChcwFsoT7lDuV60V58zXxagk8WnGabLyJPH8/oFr5vKhxNzWb9OacqJquNMCXAEPPtGncnFNYLZmn8CeTnWoGZPNAts6rBFDUVo5bBrwMgWVcQwkJht1srsUKjNkKvEQhukbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963641; c=relaxed/simple;
	bh=qFOiFrQ22bp9ubPDeW8ptesz6gYdsp1wUr4p9MOrwe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sM2ADtZ8njp5rMCJ8pFzx5ze5j2MhiQn4e0MCUbpWAVt0km1ukLleE/2V0RPTvSD/ZccvU8K99Jcyc6nDZU26P1sPZRC2Qe4NqbMjpEapvkMCrlzUmbS5L7xqw5uq/PgmsrEOssxZCbLUIsIGuEsBBxaR1Z8ZOcZ4DGraZV0rco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5+5jieY; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29efd139227so31760055ad.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963639; x=1768568439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDRdffxeTKmKE87zhNPKSisz6ECoek9qhLj1oBu4sdg=;
        b=R5+5jieYo/+P3mN5FwAfoVkjNxUJKdkKwq0VZUy5gVW2UVotL+tGROJ4u2LLNNTSzu
         /nk58E2jI0/oS+yrnLiRw2qRBD7RfRJK2u3zWf9oCufjVDayjozTGFUwjDblkfARhOAb
         N8iDhJS7u0KtrG05i6MSxcoqaXXQc7Tnxou5VITZrlkWX/T8sVIWmfT6DEZrH8caZb7u
         dzexERjjkH0m/R6iSpMuS2VCqpYU6AgmTrJYL+7VP/6jPpfFE1xm24g+M3UuzKdf921e
         En2qtBg3PLcVQDqb/x0aKYi2HGbCSlVlSduX+pyp4qTeqCdLgUZk+dpdpgXs2156XU3n
         iZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963639; x=1768568439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDRdffxeTKmKE87zhNPKSisz6ECoek9qhLj1oBu4sdg=;
        b=Den0usBbvZhfxLrRReaFTXpXYIeqRGlKcCMEPtakoi6JV6f/5BSHSqqiJ5lqgJ06Qu
         pdGWIpGaWXYCtbSBjKFTJvXk9x/3rz08lgew7Uad7vkYU2UPsj3K/6lF3k3z0VvGCdds
         isycAIQkmGQfUaB7rb1E+mk01WJHBtd1RQOs1E11ZuAQ3/EHIrlmyvdoN9Wdu4qFhNLL
         50FszHO+X3ggOAI8ezoGNGwLCINgKeL54eobbWTSDO7YuDLMFuFEBLei1Xmk0/GTlJNc
         TNW09IpSw7R9NMwlSEJGh2mRGP3Xvh49oLM7Ccywz9uRLXrkYvAxiXlXdJqx2tuXlSz0
         U4NA==
X-Forwarded-Encrypted: i=1; AJvYcCXuAeDyDwPVrZYMApXROL+AnNozUAeoq4NW6yY3Z0YByZn8KWdxQ3LpkunujGey8nY2p78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOlbei2pez9pYOw/SE5YBWuyrBKsWXYmF2YIS8LlqJH3820oV
	MiBzVkGIfue3ZLynDLMLaki59EWmt2FiJTiA32t2XiRfmcbhg+D6BZi8hTWhtAmjEXgqgA==
X-Gm-Gg: AY/fxX6TuxjAzR1pHGn275DD+5uZcFajNkKKjFNNELkPVpSdKdcmWACOwAbIkrgmvsS
	0kit6OuvIlfKgRjE9mVbgyGO5jDDUfYhNs3hHi3cyjI4laoxohcVcycW9u0cHraqgzR7W/kDXLe
	d8pRg65LT4vzlIPyxbO52NvAT+P/f8EXpb7/nEJBi6og6uxsx2K11ALrIzPxLearfH/GIF+1VLQ
	OQu4PoF0p6aS4OxFWIGGzuAflaOyKmcG4uOvmNU8zKFpCw2YRS7MKuS7PYt+P7IFQsg2n/quhJm
	DjL9bqwkLXUMPojFnICAkGsrpSNh0kQt+1vWpIM+NmbPY3wCc5MYmxVI/IAffwpLdu/HuwUEKD+
	Zpg3Stzyl3sx6/ohHaOCZQJ0DJhmdReH/H3Q1En5E53y6Oc7FzWzU8v6k58XpygtL6X21gtiYKz
	cquzJRECrc1Yivrus9TkrEOhfOIVk=
X-Google-Smtp-Source: AGHT+IFnznz6DyLtGA4vTT4bY5CXqP3/QuUv/y4X6750FOCEng8nQ9cRSwMuDPg3wuxcLWTEgVAF4w==
X-Received: by 2002:a17:903:2448:b0:2a1:4293:beb9 with SMTP id d9443c01a7336-2a3ee4edf78mr78283995ad.58.1767963639357;
        Fri, 09 Jan 2026 05:00:39 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:38 -0800 (PST)
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
Subject: [PATCH bpf-next v12 10/11] libbpf: Optimize the performance of determine_ptr_size
Date: Fri,  9 Jan 2026 21:00:02 +0800
Message-Id: <20260109130003.3313716-11-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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
index 9a864de59597..918d9fa6ec36 100644
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


