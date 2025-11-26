Return-Path: <bpf+bounces-75555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB42C88C25
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30D4D4EBBB8
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C4320A32;
	Wed, 26 Nov 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q95TwzBI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367B320A0A
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147051; cv=none; b=KVaJkZwvwGQECZCzYpe7wGEeoao7/VZHdVOUEaYgUdmrhMG7NE4muS8TiCsO9JujJ518PYTV+4SlIVc7y+qvP0TeAGHns1a0UT/q8sSheIddn5qfbDKAOxLsq3ZNlkLH8+XGAUw3Z3vLrA1GuOX8OFKT3bbNFm0id4HuUUI3zQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147051; c=relaxed/simple;
	bh=8hsjVTc4iHNm8LdtJrSwh8RnQyLo12TybfR54C1ppls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAkvGs5V8UWhrQQTGr0kh/URsJ8JMIYcwTouFEJe2Bb8vneH0WxwkAcND04ORiLcjTR7mO7VPDT7Li272jpbDs7ieas3KRno7oMrZf7e6F1mC0+Af6E410mFypCf7s8vJ+UIoHOJlu4B89ZvO283SzSMnLaIahox2oYC7YIKdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q95TwzBI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso9810152b3a.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147049; x=1764751849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAB27SW8ze5pe2PA9+A7ZhKextxDBm6v0Soq1ZoL2Ng=;
        b=Q95TwzBIWLoIWY7yGyjEa+OiZMKCMGMTCqr+Xo09xos5bty7k+aaFtgOY1KTaE/Uc0
         2EjysvwZIaV4MVwRQ6onn9pTtu+sOVmMWJfiFOf90mPP1Sw/2NlJw7qQbyuJqQJPkGZu
         O/YPGWHyzQifVhml2fS6GP8OaHkEeSF630FpCX0GZpQle2Wxcb5RQhL2hFnG/uygpKLZ
         r1SKSx/rWu+SkEt38J3yK7EKs6Y3aQ7Dd5dQLHT7fZIuZy+maDE2Se0RKlcgEIIK5v2Y
         d3H2RmzItsQLSlww+3tcwJCboizjvhrRjfOuuGVUZcUpG9FaKDfA0o0YEq/CplATngkO
         tjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147049; x=1764751849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAB27SW8ze5pe2PA9+A7ZhKextxDBm6v0Soq1ZoL2Ng=;
        b=obh7BaaFI84ln5lMfzbrG9PoFteZbG/aIY4FiqIeuJbuweuWhSOixTEImtJnLLb3xG
         LIyI59432qCFCahIuirsF8ifJaxJImTDe5SW8MlEEMejVeGW4Yc9L83130XB5MgWEFMg
         btMO4PBjAuqEc3PiaNeZOAcI6fe+RhglXx+7zI5Nsy1l9n2NcoFBuxVyc4tolXcifoJJ
         h+G5yhCwHZSkWIXTe0jDXJwK0RgFQZX9fUCVGzInHMtR3VkgpO0J9qd5qZxDqSd/rm0l
         6l4zhstCheHP9vTwjVN6wikfybhF47FKiItOY7mq1qF1eHarxCK5yIDrqEEhlWsOcp4r
         WIhg==
X-Forwarded-Encrypted: i=1; AJvYcCXowQveCb7BF6/lE2B/PRrbPFgr4E/sca6DiGkxhxGzww/Gl2ZhPtxtxJC30cnNnxzuVXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7u00Sjlh8hLqBYXqLETeM7dEgwl50JUdtmW8A0ZYJTd5BOhO
	5Tq+KztxDITnyCm6jPD5TTifv8lVGVt5WZzTExupDSvB4DI6HwhnlYz2
X-Gm-Gg: ASbGncsBsd/kHt50OVgjH2oF2obXRpMS2Thp1de9q8T9kKi3BSR8QjLjgcDon8KU4m6
	8eZg0exRx+zOOJL8VLW1ukFl0eGukTQWIKJr0Yw8pG94WZH9SFj4+9HBJU3T7gJpqhuy7Zo/CyP
	xt0CQjN9GQC3/ItIJgnAGNto7cpP0U/Hg9pZrBtbX+GrSjxw58TD0zXVMIcEexf7//Ww9SX/gD5
	q5oT1AiZ2xFD9OYjSlEQFGqd1ALVDXpoV9a9/O2wTMTsADlyRJizGQiRCKQWx8Lhqrj/H/MqiPU
	yB2l/T+eBkjnQWvjLGYu2To5LEnW7kYLrcm25A2Rgf7Ct3QDrn8znv8YrVk++AogOhTJydmoDNM
	emsy5w5ZM9HKOur1WFH6iGCjhc+UgYNKR1BCdf81Ilyeg4KZqJCv+lzFeQti3ZGGDbBKXGc07u5
	pFV5QreLafDvSyXWYUgOuBOXB0wt0=
X-Google-Smtp-Source: AGHT+IGq8Oo2JKr1dmJgr6hMlqWRYmEBgM0iCXG7gLktRGpc3fCfrvlGdc+e2qanX74xdGTGMMUy8w==
X-Received: by 2002:a05:6a00:21c1:b0:7ab:653a:ca0e with SMTP id d2e1a72fcca58-7ca89a6c262mr5965607b3a.23.1764147048836;
        Wed, 26 Nov 2025 00:50:48 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:47 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next v8 5/9] libbpf: Verify BTF Sorting
Date: Wed, 26 Nov 2025 16:50:21 +0800
Message-Id: <20251126085025.784288-6-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch checks whether the BTF is sorted by name in ascending
order. If sorted, binary search will be used when looking up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7f150c869bf6..a53d24704857 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -899,6 +899,49 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+/*
+ * Assuming that types are sorted by name in ascending order.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, k = 0, n;
+	__u32 sorted_start_id = 0;
+
+	if (btf->nr_types < 2)
+		return;
+
+	n = btf__type_cnt(btf) - 1;
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+		t = btf_type_by_id(btf, i);
+		if (sorted_start_id == 0 &&
+			!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			sorted_start_id = i;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (sorted_start_id == 0 &&
+		!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+		sorted_start_id = k;
+	if (sorted_start_id)
+		btf->sorted_start_id = sorted_start_id;
+}
+
 static __s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
 						__s32 start_id, __s32 end_id)
 {
@@ -935,7 +978,7 @@ static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 
 	if (start_id < btf->start_id) {
 		idx = btf_find_by_name_kind(btf->base_btf, start_id,
-			type_name, kind);
+					    type_name, kind);
 		if (idx >= 0)
 			return idx;
 		start_id = btf->start_id;
@@ -1147,6 +1190,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
-- 
2.34.1


