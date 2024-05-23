Return-Path: <bpf+bounces-30415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B38CD942
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35431F2207F
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BFC7E79F;
	Thu, 23 May 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaN66oFB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9807D3E6
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486135; cv=none; b=HvSMTEha/anxnilxXqk+SkkSHSbSefZ7ZtBJqkQVm7JVoAr3uwB6UrhTDnU6WkQyeY3/wfr5hfJZg+CE4icsL16m657z84mt/AcmxZsE9kZtz9TciL/DputLRWEGbDoFe3ZrwtM/YDYzgl4CRzhbmBglYAjYtemrQuEQ6WIBEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486135; c=relaxed/simple;
	bh=beUO5MCH98hk7B1W+3WxHbLxcpbk5N8JhsxgQEHPOpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxbcNn/6zClRWzivdOQNkuB7X+NDE27aenZbJnnwXUS0WNEdiY3ujC+L/1OWfhL6D5xlp1V/CBDpra5PXgwGHYGcoM17tbKryqbnj0dIW12GhmXQYfvWL4hLuGb7B7i7s6b+sox4rma3PavnN4/vSk5p+oyc+fXsLQD4Y+jfEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaN66oFB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-622f5a0badcso71562207b3.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486132; x=1717090932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EScPTFIUsU9lafWPj5+nn2qz08FusFYqcC6FL2ky40Q=;
        b=EaN66oFBIKLT3YmYjPlWtKK10aeMXe/gso3oEMRZvswHlAWbUSjAeMkDmxAUFW+S0I
         CH7RRajf481VV0qTLk44fJnQ7YQQLlHq6jJ2PMik8IUkzRwzgiF5CCRAvoHPc9rsrmTP
         nhbBJHHnoNhtIN7K1BgiH1LmFO+efNlDnjZcMCgfbAZp1g/2Pb/FYqBA9vFvNpWeod/9
         4r++wSOht3obdaUohA104P9Mo2vTWd3ALzBESNg+HO+dB7O1byekCGMzTjSaDv2pgyOo
         ZrNOR6pgiVJ73n4McPkwjvOhyUCrgNuxirXghp8pRUbi9eMf0hrzo5o+rs5Ob5HynmFj
         /gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486132; x=1717090932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EScPTFIUsU9lafWPj5+nn2qz08FusFYqcC6FL2ky40Q=;
        b=gu3eLBNUqkt9nuEEpBR7pjNk4KIXax6pgayW6WJ+1TYZTO8Wp1KEvq5rc7fNxLEACK
         3hweVju1YbSx+wzrrF4FbvA3w9gL4q1VLKsamHZE7xUBwVMwnxX6qbZZxVR3CjJCxgfO
         BLajj3JgtodZXiZbXf+K8PQ8DIIEflKkJPj1TR1opUg/VVEK8rsJCQzqC3RiJC22Pokc
         T/fb7mRbmIrL0V8x29dr36lsgpPbPGXEZJJXrpeGKbXwew8X2lvGzanYaokGemOPllFE
         p9ib11wB+00IsZUhQYlLF9exPPV1XeAoDnR9tBuP0L6K12XiHW7fX1NHhuY77oACz0lv
         cFEA==
X-Gm-Message-State: AOJu0YysokYPyTLE5r24ltJSc3GJZE6x/2Hito+HRlYkC5RTLzK15HOr
	d+GDee1gcIKypepmZA3CNPUQKs0yk8i9NVouFDGdlc9Hcmfg9NB1Tfs6rQ==
X-Google-Smtp-Source: AGHT+IETJm205xsc1AU3XN//m7LSVClYTGRWlP1fJl+p85GPknn3LzBWNCeaG0A9sGjjwNNyQmJJ/g==
X-Received: by 2002:a05:690c:60c7:b0:627:a382:a0fa with SMTP id 00721157ae682-627e4880150mr66236787b3.52.1716486132572;
        Thu, 23 May 2024 10:42:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:12 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 4/9] bpf: create repeated fields for arrays.
Date: Thu, 23 May 2024 10:41:57 -0700
Message-Id: <20240523174202.461236-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier uses field information for certain special types, such as
kptr, rbtree root, and list head. These types are treated
differently. However, we did not previously support these types in
arrays. This update examines arrays and duplicates field information the
same number of times as the length of the array if the element type is one
of the special types.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ce61c3a7e28..4fefa27d5aea 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3494,6 +3494,41 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
 #undef field_mask_test_name
 
+/* Repeat a field for a specified number of times.
+ *
+ * Copy and repeat the first field for repeat_cnt
+ * times. The field is repeated by adding the offset of each field
+ * with
+ *   (i + 1) * elem_size
+ * where i is the repeat index and elem_size is the size of an element.
+ */
+static int btf_repeat_field(struct btf_field_info *info,
+			    u32 repeat_cnt, u32 elem_size)
+{
+	u32 i;
+	u32 cur;
+
+	/* Ensure not repeating fields that should not be repeated. */
+	switch (info[0].type) {
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
+	case BPF_LIST_HEAD:
+	case BPF_RB_ROOT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cur = 1;
+	for (i = 0; i < repeat_cnt; i++) {
+		memcpy(&info[cur], &info[0], sizeof(info[0]));
+		info[cur++].off += (i + 1) * elem_size;
+	}
+
+	return 0;
+}
+
 static int btf_find_field_one(const struct btf *btf,
 			      const struct btf_type *var,
 			      const struct btf_type *var_type,
@@ -3504,6 +3539,21 @@ static int btf_find_field_one(const struct btf *btf,
 {
 	int ret, align, sz, field_type;
 	struct btf_field_info tmp;
+	const struct btf_array *array;
+	u32 i, nelems = 1;
+
+	/* Walk into array types to find the element type and the number of
+	 * elements in the (flattened) array.
+	 */
+	for (i = 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++) {
+		array = btf_array(var_type);
+		nelems *= array->nelems;
+		var_type = btf_type_by_id(btf, array->type);
+	}
+	if (i == MAX_RESOLVE_DEPTH)
+		return -E2BIG;
+	if (nelems == 0)
+		return 0;
 
 	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 					field_mask, seen_mask, &align, &sz);
@@ -3512,7 +3562,7 @@ static int btf_find_field_one(const struct btf *btf,
 	if (field_type < 0)
 		return field_type;
 
-	if (expected_size && expected_size != sz)
+	if (expected_size && expected_size != sz * nelems)
 		return 0;
 	if (off % align)
 		return 0;
@@ -3552,10 +3602,14 @@ static int btf_find_field_one(const struct btf *btf,
 
 	if (ret == BTF_FIELD_IGNORE)
 		return 0;
-	if (!info_cnt)
+	if (nelems > info_cnt)
 		return -E2BIG;
-
-	return 1;
+	if (nelems > 1) {
+		ret = btf_repeat_field(info, nelems - 1, sz);
+		if (ret < 0)
+			return ret;
+	}
+	return nelems;
 }
 
 static int btf_find_struct_field(const struct btf *btf,
-- 
2.34.1


