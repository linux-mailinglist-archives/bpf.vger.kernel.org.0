Return-Path: <bpf+bounces-73861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E2C3B30C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158811A41C6F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBA33372C;
	Thu,  6 Nov 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP4Weuxz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26876330D38
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435240; cv=none; b=iqYW8JDtyOvMXeVuy+7osChqDqFyw++QhCiNu1lD5opskKFdEE06w6sw8oWguZcPv2828eFTsret+7YzVhZKhSdLwirlvk0f8J4OMXvqKf8vFXPbgZoi+32srbBTp6KUWYlO8MgEYGYo9PWe90PNSaJV7BfTzdwgUfRsiv3VWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435240; c=relaxed/simple;
	bh=/oZgc5EZQ0oqNKRJlEKYw6rWHvpsXgnnWABDSIU5hdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP1G2J3fwEDq9H5QVTS7xc4wdWdvukk8kDvVMlB4q5aBl8RyoQk37iXwk5CV5O5xtvJlM2Owul9xTiKfHVLDL90aBrPgqD0zfaNbc681JsT9Guwdu9ObtKBr9EAFUMvjUzw3kdI9CRVsPxOftx8FSDBBjgvH0GD+WFYTlsO4mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP4Weuxz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b67684e2904so569673a12.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435238; x=1763040038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgFobqwTDCy/M0FzLCDbAJgfJuKUpynhUI9wDqv4IFk=;
        b=fP4Weuxzzc5ghHkGZgCdmZU3ZOa2/PFr5IruKjJPDxHS+QDBurApmMSWGsuf5su7oC
         Og1CSuyDR3UEvWRjVnQHkfCB7CfoHsuRiP3Ne4KMdNxWPfkTYlPEXzfNcxHn9+Ncm3PN
         da66Tl05YXaJi3cFLTjpJLrApBv2qP5aGTymCkMlVJ/krPIdQL7guK0GO55E3wB3lst8
         np56ciNydDhTPkEhPQAqHqT9x8Z9Yy3aAa1iUpX4u3VYSumCk3aDOpJ8FuWdVVIQv75j
         HprxJDf6VYe59rajnaKPv7pObdKy5SZSjtgcZlgdD50ovPEapx9xorqfFRiCUtTHJso8
         e+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435238; x=1763040038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgFobqwTDCy/M0FzLCDbAJgfJuKUpynhUI9wDqv4IFk=;
        b=Us5/3Vg8AQ+92Mo2h+uj26jJcDPTiW/x8XReh3IyqhmCxmQM7bCMuCMHIb38rTTYIc
         Yq1XpeqhG5+xBxeo0o8wPQpvF/MY7J74fSWNuN93KGpX5Kg+Uz4x0aSkp+2rp0o1FNzR
         bUQ99KpQHpbDO9aWsx4ej3DcIdyLvUgP8blgshdY6Gx45HMrHNTRHxz9UirDotKA9eAL
         YaXeS7pl7QSwc89mD/4aFJt5Vkex02z+YEUfPrPFCmua1KakT8BSm3S037YSl5kn0s8Y
         ljrN15Ueq8dorlu4OqlJ7hYv3pdf1MfOb9a0epwGL5nLuq0yvTDHCrcoPyGxl5BI8LeA
         8UzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC4kylWV64kKGjmbCtpaG6KIAik3K7866MO/OJgk0e1IIo3jv9avAVqZBfmSoVKfXJsms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxincd/Z00F6IrYkOY7jqLHlN9KbsK9SMvgyMVQDxxHzIPuwO8F
	GJt893FsqD/9STToVHHvLS3tAnlxv5CnFA2kSzPkNSH7pouXZqgkSFgF
X-Gm-Gg: ASbGnctUpSRXSXRj14iwzJlO/Ta6DxSf1nUe83WbTjja9a1sjFaRBJjNvxFg2DQ33Pl
	ts+LqZ9Vunsq2hBo0ZD50u92zUAXt/CbX4bKNln2i+8P13/qJb9lMh9xeeYmjf+mMrceKTiDGq7
	AqwGhf1f7q4frr7MQWgA8UEq+LFNE+r/9iI1EGGzuXfbRwwbUIdjBX91K0FMBBnujzDBYjRAXMb
	S89Fs1H1yeKK3nJxM7kkxmlZiV+h/9Xn4MO7InQwYyrSD2JLp3psWIfKHmTwT/45K8HKWSKtb4S
	G21eQ1ev7Ra2LMQbVzNcwLkctpXLCVwq2mUBCeAwlRo+k3hLvR4OHgxcplBiehLXl5vOMsQQjgd
	wJB1PMoTACnTs5rZOz61ZL5fS818/hwxxO2GkpHfDBpnRZBgoo0cH0B9AghPavPniO0pMziKB1U
	iuWVosZR6N6ryF2yyL
X-Google-Smtp-Source: AGHT+IGmChUlKr4zR+bh7ahXgtDaj2BWrn64VpiXcCg95goTFuCvcJ8ABcPCYkwKgODrux1uBreeEw==
X-Received: by 2002:a05:6a20:6a0f:b0:34f:1c92:769 with SMTP id adf61e73a8af0-34f83b0e78cmr9394651637.16.1762435238328;
        Thu, 06 Nov 2025 05:20:38 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:37 -0800 (PST)
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
Subject: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
Date: Thu,  6 Nov 2025 21:19:55 +0800
Message-Id: <20251106131956.1222864-7-dolinux.peng@gmail.com>
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

Implement lazy validation of BTF type ordering to enable efficient
binary search for sorted BTF while maintaining linear search fallback
for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/btf.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 66cb739a0598..33c327d3cac3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	if (!ta->name_off && tb->name_off)
+		return 1;
+	if (ta->name_off && !tb->name_off)
+		return -1;
+	if (!ta->name_off && !tb->name_off)
+		return 0;
+
+	na = btf_name_by_offset(btf, ta->name_off);
+	nb = btf_name_by_offset(btf, tb->name_off);
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
+	int i, n, k = 0, nr_sorted_types;
+
+	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
+		goto out;
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		goto out;
+
+	nr_sorted_types = 0;
+	n = btf_nr_types(btf) - 1;
+	for (i = btf_start_id(btf); i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			goto out;
+
+		t = btf_type_by_id(btf, i);
+		if (t->name_off)
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (t->name_off)
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
@@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 			goto out;
 	}
 
-	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
+	if (btf_check_sorted((struct btf *)btf)) {
 		/* binary search */
 		bool skip_first;
 		s32 start_id, end_id;;
-- 
2.34.1


