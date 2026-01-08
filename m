Return-Path: <bpf+bounces-78198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB0D00D9B
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B8A30D04AB
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20F28488D;
	Thu,  8 Jan 2026 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/noFRlq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E14280312
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842234; cv=none; b=Z9AfCRQ1yYfIGUvJrsOz0wfYrG0mX3HNLKxxWYNf5z7b2nm/JUyevq0/HNhW5PFmuxoyEVoULdyIdBlZ8cSmnerULFxlMxm1SZJ4J5/10j36hz1VQSps4+0sPrCe0eD+7v6SbtIdRDoFP7EBEfVNuplcHi7jBZmtb4bXG30EzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842234; c=relaxed/simple;
	bh=mYzJ+kJtBrf1ZOrVJNkEAMPCA73IwwJ3Vq1Lvdq2Ri0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOPFn5WsdIKqPpZ7xEBPAtnDG9gOWQAwX7hj6pq0WEmNTVkFlWst4LkCou4lx6iIbDgLDTe74nYNNEHgG/4h4vzKkmVdxAmbjAs19u5m3/hjdFaIEzavGhPWs2NajKFATyMQ7bwDvzOdkr2ng6oscCm/co6l2UkbY2IMSWIDvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/noFRlq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2435249b3a.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842233; x=1768447033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUW7LB43dCgnLiOgR7S2ttrd8S36AZDQc8SQtsp0WmA=;
        b=k/noFRlqdM9BAgEccQmcUH6hvF33pgwCGHHMDp8+BHKmm2RqBN9XWZLujecfBdSkul
         sj+bM4EY1679wI0UyWECBJncXZZxDhqhFSqIg6zl4P3I0nRIZq3QaCTDeICtC6aXnXYw
         BaBYvTWlPQjmPFesNGSbUlQe9NgNrepwyJAqDlQBagnEhVYhnVnwF011TJBOixh0j0+D
         Zqa4SvylIT4PNH9VGBdkJ0KJ0D6+CirG7DvsoMcmpBpgKR1Q5AmKkH9drjAFQ7GaHnXO
         rVt84aZJaMyTEzEyjA0aPcChQR9epgT3ZV9CkCPRbnqMgN2k9mksog9jFVO/vCnjfac1
         NUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842233; x=1768447033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUW7LB43dCgnLiOgR7S2ttrd8S36AZDQc8SQtsp0WmA=;
        b=oLxyHZan+rq7HPx8lmHOgbXku73IGXQZ1AkijeZcL3DgWFUh+tc9Ly3Z7pzt55+Gwq
         2AHvX5N3qbU7FAO+OrW1YsqtIfYP6lgxJhbrRhyH0Zgk74VIrPb0b/EQHxrJsPts/9hx
         TDA4AonQyxL53cWhl4kk5lnhK6X4+oWtuMDKWvq7qv6ecV1Z6OhQ/J/gvYls/FDL5JtU
         J3FHPcSeLbjgMGJH7sMjGg9InePKJapERDEiaW+bx2UNLTbmFA3BPmy4Qle+sTa8b8TZ
         oSuaBKufpfN5QbWG9g1tO4WNckdK1ZN0b7/cclk9CE4cdFbQfOG2lYRIjFiY2r+jbMs3
         Z3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwTR0n1ahMsY2Zmf6bnwVknaVpEoAppFjMOuzyzDuw5Wch8jZZDbvdIrJCs5eBeRgOqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgjl3WMGtuKhHVUoUfEaoUwDNEJlXTAxGZF985SXO3o6ZeOaE
	uRzvzLyRqhoLWD1zck5JpEzRddxMHQ/fzNilGJu73OzOK90MPxhbJxUJ
X-Gm-Gg: AY/fxX4VlbvFuBRRcQq2RiMJfRULj+2khBkp1E3xDWS5f/Ss3LtpccpwnGXAtwSwJuV
	d0TiZaIJUQUXkpyJuYt8v1QsFLCUwEuxXhzWwl2Kl+8xn/Sz5RPfcKGy0mpmU5e2A0z7dqIv1sb
	gQuh2KmDXOsB29YiAh5He2wdqUZSl5yX3g/TY5aDGT09Eqm63h5Agk25IqkOWvIppjw8EhxHWi4
	LRao7OXSywmvgJmsWAdl8q7Xd/1zAKRBVMQUm8j4v9Szy9aauPu5I9ILEf+AWaF6xTC1EEE7tNV
	kAl01unFNM6FyxFX7lyKHMAmE7rAcBhLhLa8VwdA0pUsqjwLpH6yUPB25KT6qdHZqzCioZ674Bi
	wwkKrFC580X+mbD3wkPnrtFr/27IElHINXmpzhZNh9CS2/CNiKytsRqeYlTqmaI8/7O4CEIi8H9
	7VSkz+WJp5rNd0xwRCescpRb/rMFk=
X-Google-Smtp-Source: AGHT+IHfnHd8Vmh9kg9OSxh8nSRnoLg5H121xuAGpZndMHXgdQZUDlZaIEVkSuU9Y3qrDpaUIElQPA==
X-Received: by 2002:a05:6a00:2a08:b0:7e8:4433:8fb9 with SMTP id d2e1a72fcca58-81b801cc15emr3408043b3a.65.1767842232722;
        Wed, 07 Jan 2026 19:17:12 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:12 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v11 07/11] btf: Verify BTF sorting
Date: Thu,  8 Jan 2026 11:16:41 +0800
Message-Id: <20260108031645.1350069-8-dolinux.peng@gmail.com>
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

This patch checks whether the BTF is sorted by name in ascending order.
If sorted, binary search will be used when looking up types.

Specifically, vmlinux and kernel module BTFs are always sorted during
the build phase with anonymous types placed before named types, so we
only need to identify the starting ID of named types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d1f4b984100d..12eecf59d71f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,46 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* Note that vmlinux and kernel module BTFs are always sorted
+ * during the building phase.
+ */
+static void btf_check_sorted(struct btf *btf)
+{
+	u32 i, n, named_start_id = 0;
+
+	n = btf_nr_types(btf);
+	if (btf_is_vmlinux(btf)) {
+		for (i = btf_start_id(btf); i < n; i++) {
+			const struct btf_type *t = btf_type_by_id(btf, i);
+			const char *n = btf_name_by_offset(btf, t->name_off);
+
+			if (n[0] != '\0') {
+				btf->named_start_id = i;
+				return;
+			}
+		}
+		return;
+	}
+
+	for (i = btf_start_id(btf) + 1; i < n; i++) {
+		const struct btf_type *ta = btf_type_by_id(btf, i - 1);
+		const struct btf_type *tb = btf_type_by_id(btf, i);
+		const char *na = btf_name_by_offset(btf, ta->name_off);
+		const char *nb = btf_name_by_offset(btf, tb->name_off);
+
+		if (strcmp(na, nb) > 0)
+			return;
+
+		if (named_start_id == 0 && na[0] != '\0')
+			named_start_id = i - 1;
+		if (named_start_id == 0 && nb[0] != '\0')
+			named_start_id = i;
+	}
+
+	if (named_start_id)
+		btf->named_start_id = named_start_id;
+}
+
 /* btf_named_start_id - Get the named starting ID for the BTF
  * @btf: Pointer to the target BTF object
  * @own: Flag indicating whether to query only the current BTF (true = current BTF only,
@@ -6302,6 +6342,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6436,6 +6477,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	}
 
 	btf_verifier_env_free(env);
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
-- 
2.34.1


