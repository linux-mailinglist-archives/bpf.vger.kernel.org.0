Return-Path: <bpf+bounces-74739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B3C64606
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 218D735EED5
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F833507F;
	Mon, 17 Nov 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC/QqyE5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDB334C26
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386009; cv=none; b=LPo+OIzoXv1F3PLhfhLXVZLxnS7a7Ms6Zb2otV027ERB/8jyKa6+WL4KsJCnj2CZTEs6aS0jzTAW0eSVwRte8Rx2DiexeliK3f4nihEOlPBTBpxReG63cFXt88a7qpBXfpfiJCDTmBbjvCXfOul0pqnzJ4yyrph9b0LPMYLqCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386009; c=relaxed/simple;
	bh=TlQb3BbQR+c28ZRJL32xlMCjA7W2OgjyhhJH/DnySmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PENvg1Et9DO7e8sLiOaBOg58rL6WP3cupKbMXrLYpXij8Tsdj5K/Rtesqco8UXEpcZq7A02oe4r+l4FrDlajWUAlMKsMcg/XDD55NHPeO7qMi6kFva7BRABvQpsMEe2hdap64D8AnBDBRHl6k4TGBHrn/KqYsTA3eYTwH3+6KW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC/QqyE5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso2984851b3a.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386007; x=1763990807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ9pJtF62LZXJAT0luPwqHz3BLuxpObXSz+phDq9x5Q=;
        b=PC/QqyE5zN22D8dOTrnhkoppHyu+e3svsKIjw1gY+npQ8G89b9K+BLmackOVu/tF0A
         xE9r9vxpoGSCHqHiJVQRG2mEpj5nvTb7bsXQsFcQrSWvADfIUdpe8AapF340axIwZuBE
         07Cl0fkZMI099Mdc0VyFfepUdILa0nNHO5ma7mYg6nFXkAbVYzuOoy+sqJOgRYedHdzq
         mJdKiuuYeAWX+8J+/kU2NV6/vnF1yOtmCRc81iumW3AfALe0W0BguWi4HGaOdSfiUC6f
         y3iYO5nFMmwAusx24joYg4GcjeqqCSvezyadETGwlZrbfM7DZhtCIFoev0Fz0rzjoYUM
         /FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386007; x=1763990807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJ9pJtF62LZXJAT0luPwqHz3BLuxpObXSz+phDq9x5Q=;
        b=amEAM0vfK+6fOyh2FAez25xmjEFSHjbiwf+83QZZLSk2gskIE7uRUFu5f7ysYpjC6u
         8qP2wCW2xvpd97lk1cxfUkcdZQAWLp61iI8UK7Am2TN3cwHAUroal3fxVLvB8Ki8DK+W
         lU5KMmcs27pZTQZHtIOVK8eSmLbALXH+AGYoVngPztXiE4dOu0lOPsjzEZU2AzU9kMqa
         Z7iCSh9RG5CTDSpqhaaPeNmZW1L+kcfDf0GiEH8ORy6IS/GUeaw71nuWqD6iekbMGuef
         24LgU7QzqCEoMCZwfUCS/hVWmghDUZrBsobWskrdfLDEFCD3KzVJW0SxcaAjPppxTkDM
         sHiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0hcPBOZUbYETqOn3L4HiZFsUKs3oOR9aAyFzGwq1iwj5sbWaL6bplmLVXCO9dMf/9tGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswbPDm1QWdjxDpJX1ug8LiNeWtDels1TM3EbNU47tiuSo6DQb
	SRlqkaYGwewYQql7rCAIHkHviba/gwizsac18e3bWPuEO3fq8bFkLoaSQeCXLEf3q60=
X-Gm-Gg: ASbGncsKGb9gGw2aAvrjla+IQnGZmff7OY0RO5DHngupg7DN8sVsgQ0l6+m22UCynvN
	snvkhJJIu+VwcnumsKW9m5QO5dUvsBmKkJEICZbhj7FXZStGhK8xidTCduPFlpEC6GuuRb1VWa3
	njf7OUGqYwgoLHvv4tEXRPsaHRaSoKWbzBPVo156iuW7oN2g5JljNCcqOjjzN/C5bcVAhNM12Yi
	XNLTCYJ+Z79TmYDrcLxsyjTJ2S4zMDI0JYa3Cilev55sORdE7wWefCFZ25GvLPyGlo9Gt1lj8xW
	TOZOkMDCRbZ1aSt/mD4yNlILcpxDsBxzRPJfhhwZKd2YeZRy9eO7K1N4IBdL+Nn/hYZKBcQmeCN
	OOSqDi8aw7wASuHZHIZ1epUgdHRbNqHxSTPs+fdbecrvjtINKALbyyvsc1AVtfvIs4P6UHg+aQ1
	mNQ90i89Pdv62ZuDTIwqP9h+DvdHY=
X-Google-Smtp-Source: AGHT+IHA5iK4wG/HkFcfe0rJP4GZNcbweMfRLzaI9ghvyze6nCPnMhT+DU1blJmo3HvsWVSmn7L5KQ==
X-Received: by 2002:a05:6a00:991:b0:7aa:5053:f42d with SMTP id d2e1a72fcca58-7ba3c665a52mr12595036b3a.22.1763386007052;
        Mon, 17 Nov 2025 05:26:47 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:46 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v6 5/7] libbpf: Implement BTF type sorting validation for binary search optimization
Date: Mon, 17 Nov 2025 21:26:21 +0800
Message-Id: <20251117132623.3807094-6-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch adds validation to verify BTF type name sorting, enabling
binary search optimization for lookups.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index bb77e6c762cc..b29f5859c10b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -903,6 +903,64 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
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
+ */
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, k = 0, n, nr_sorted_types;
+
+	if (btf->nr_types < 2)
+		return;
+
+	nr_sorted_types = 0;
+	n = btf__type_cnt(btf) - 1;
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
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
+}
+
 static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
 						__s32 start_id, __s32 end_id)
 {
@@ -1148,6 +1206,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
@@ -1332,6 +1391,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	} else if (btf_ext) {
 		*btf_ext = NULL;
 	}
+
 done:
 	if (elf)
 		elf_end(elf);
-- 
2.34.1


