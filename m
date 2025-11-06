Return-Path: <bpf+bounces-73859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE84C3B327
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0437E500A9B
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67F3328F4;
	Thu,  6 Nov 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTjErpzD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AB3321B9
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435233; cv=none; b=sNKRegKEXIvVr2HThytYnbRQZ/x+cyuDUWeSjLklMwQpJZAas28ApWbJaCwA+yP9f/zZUf9cnbB0GUzfNPPULWBr72Ml4JByG5hEDTeDfURSK8Nk+9uojfcrcnX820tmcFKuvtL9DlHdMHTa7vZJpHqYYdvCBtg+HbKQw3welTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435233; c=relaxed/simple;
	bh=9IIrVWj4EOAFacobzgV9OdSZQ7IU230SlMHy8PsLO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHEAB3W6eDs4VR0fGX/LTpEkICxo7eAjHE6AJLMLgD4Clno6vFFjSmDJd30iOtW86UaCEP/ZfuKcp1RBfABZxP6oPgifc423MC0xL5ahBkYHjdwD4Iwua30UETTkxKVSCmBSKrpkSk4BB6/6jZIRaGlNYXxHVESGxAobj9TUmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTjErpzD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-330b4739538so960589a91.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435231; x=1763040031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpLkwEVaZQ31ymQfuOb0WcKoTYd7LV9JMIguVBgQh3c=;
        b=RTjErpzDzneMzIhtVkTSCyy5q1v6TCxqD1w1JHSQZfDN55zUTjrsXOBGQ/XeRLSDNd
         yL3AU8Dc+xDs1Q83JJVwvuVwg4K0KvgyDt9rqAo2OrTffYeDx9L1P4ttYR8YwEiiO2K7
         mH0icQSrgQqPp8KL+l35eZpGgTdMeccfMq3Ld/LTiWPljo4p43fz4lPLdnuKgHa20E3U
         5sNSJHFOhwN6tyVKLZXo4bw0jS7Ho4AszmJQk27mzrvnynsATRzcS5Rb8h80ek2Xjh5w
         LF0P1RRIvjJIh9/9AniXHIPxT4DxI01ImSXkBN2SGD2Bi9omH/GRwISgXLBGyaqVrG02
         CmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435231; x=1763040031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpLkwEVaZQ31ymQfuOb0WcKoTYd7LV9JMIguVBgQh3c=;
        b=ofFMTv420fo7t12wPOVMjPcLwztz9tFe5nAeSV1EuGMDfToa/RdlNrLUfCMiIBER0d
         PKmJ0UQQtaHs3Nd7kBXYZoAKcBJyVYnXy1lmSY1axHI7wlHWuvg3LHNxxCtIRNPvd988
         GzbVd9/Cq1SSnSQ3a2iNPNzUQKE6pxyUaKjzuIP+ev2f2n1wMoWG4dT6AC28W2bGZAqk
         nwKbosxV/xlYCHxsQWjbl5qcEBs3/MNRu1o5WC9s2BKKIVhWlXH8bflj/Zw6BiIlMMq7
         BhgJY2XE3Yj5CBTfuX5lIMFNpdZgN1j9uzyqjM5fgfMYJwEUv/HzN1PiPGozNlr/tGHt
         FVIw==
X-Forwarded-Encrypted: i=1; AJvYcCWmhGbe6liQbqqd6y2WwtTRIcLe4IWNpZLYpoxvQYuzL4n5nY/KNOBrmJtrgm7r+3quKNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5v3UF0Hl1C4hG77A6Z/1N4qmlyAvpE4VJySbJ+9TclLu2IgK9
	SSWtvekXxXPEcs4yYFLlUopI6XfT6Ge+QH8r5Noi/Cjc1nsZpCrP2jCQ
X-Gm-Gg: ASbGncsok2NyYMN4vO/26Yk6KD4NUcSBFrrmZ4umxUJz8mIfOz1DUu9o91SfvXN+2ap
	BC0UmNuWt0Bm03qx4mUvpG3clQpx34qABYocpuf6iEGwmq3A9lKDsQTjhEHiiUGkzjV2i8ujyHH
	TAh8/tI3jrFbo7O2B/67DxtI/plL3886pWH0aHYwtOkFUnp8bd5eMY/wydOsStbb/aBgKkciHLH
	bF6MJICTIrvnIcTG8IkVwlUKx8Tja1dkrq13GRFH/NrvG0xh/FwZgx6CxWW2ir0hCd6FkjN6Gya
	PXbNYeUXqYUqzYbxrn1t3lcS0ni+RiojW32beV5FAZJ3ylphEXirdxfMB8cqVbmCe2Cr74gePto
	xRCzeQFzOfKP2ROG+d6LHT6WwHfLV+saIBb4iVAMH1P3721383puAWpeEXmyN9jD+Mf6hUvZckp
	047pymmtG7IF3wz8IT
X-Google-Smtp-Source: AGHT+IH8xXHumIVLMZrCxwSH55ZPpWyKAGLDtEe4kXor9petOsUVlk2TDe4v5DrC1SE3U/hEmx1AMw==
X-Received: by 2002:a17:90b:3812:b0:341:8ae5:fde5 with SMTP id 98e67ed59e1d1-341a6dc4bdemr8230717a91.18.1762435231258;
        Thu, 06 Nov 2025 05:20:31 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:30 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH v5 4/7] libbpf: Implement lazy sorting validation for binary search optimization
Date: Thu,  6 Nov 2025 21:19:53 +0800
Message-Id: <20251106131956.1222864-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106131956.1222864-1-dolinux.peng@gmail.com>
References: <20251106131956.1222864-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch adds lazy validation of BTF type ordering to determine if types
are sorted by name. The check is performed on first access and cached,
enabling efficient binary search for sorted BTF while maintaining linear
search fallback for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index be092892c4ae..56e555c43712 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -911,6 +911,73 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+	bool anon_a, anon_b;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	anon_a = str_is_empty(na);
+	anon_b = str_is_empty(nb);
+
+	if (anon_a && !anon_b)
+		return 1;
+	if (!anon_a && anon_b)
+		return -1;
+	if (anon_a && anon_b)
+		return 0;
+
+	return strcmp(na, nb);
+}
+
+/* Verifies that BTF types are sorted in ascending order according to their
+ * names, with named types appearing before anonymous types. If the ordering
+ * is correct, counts the number of named types and updates the BTF object's
+ * nr_sorted_types field.
+ *
+ * Return: true if types are properly sorted, false otherwise
+ */
+static bool btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, k = 0, n, nr_sorted_types;
+
+	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
+		goto out;
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		goto out;
+
+	nr_sorted_types = 0;
+	n = btf__type_cnt(btf) - 1;
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			goto out;
+		t = btf_type_by_id(btf, i);
+		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+		nr_sorted_types++;
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+
+out:
+	return btf->nr_sorted_types > 0;
+}
+
 /* Performs binary search within specified type ID range to find the leftmost
  * BTF type matching the given name. The search assumes types are sorted by
  * name in lexicographical order within the specified range.
@@ -970,7 +1037,7 @@ static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
 		start_id = btf->start_id;
 	}
 
-	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
+	if (btf_check_sorted((struct btf *)btf)) {
 		/* binary search */
 		__s32 end_id;
 		bool skip_first;
-- 
2.34.1


