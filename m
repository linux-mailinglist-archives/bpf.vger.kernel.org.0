Return-Path: <bpf+bounces-29425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9EF8C1BED
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16261F22B8C
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E4E13AA45;
	Fri, 10 May 2024 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROP2WRId"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738D13AA31
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303602; cv=none; b=WP06qQAmAAZYyD2E04JLXQCUzTHHxv1SwfAKPfckSg+VULG/ymu0VWXdqhYitIHlVRILkr5bZ2Gh9y2PYQrf9PGD5jYp+nWHpkS2O49lrd7KRJN0aM4XAxH9wcCV2rVxMlR2GS5S2nsTYXhPPL2e3KjaVnEOTr0YWkMYjv+zjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303602; c=relaxed/simple;
	bh=beUO5MCH98hk7B1W+3WxHbLxcpbk5N8JhsxgQEHPOpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA5NBzsFRulgYXvCU/GEruD1XicJea+jXeL14L6X/8Mh1K/UDOvl+9EXfSOd4VHSfmPGZzpaJPpx+L0AYF6w8vsy+07CQfrgDUAMrTZd5l7CJvMU/OQyY4FtZL0DzkpttHPWRmuw0RfHlEFw4VWAW9KjF4hxAgCnuru6CBcXxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROP2WRId; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f04ec17bacso968551a34.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303599; x=1715908399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EScPTFIUsU9lafWPj5+nn2qz08FusFYqcC6FL2ky40Q=;
        b=ROP2WRIdGzkrjVTkE0YPH3AcofJu9gmOclhqS51qpU+UzKhe+GSj8z7CvdOTJfo2dC
         6llcmhGy0XphNSoyFNxT+GNA+FvKvVIk/psAFRKKaQjIk1cuga3vYQbm6ZXLbzfe4wLn
         DgBa+8OESFInnkGTGJT8yU2a37TnVCBCvULBJWLFDljD5MJXFjY3Bs17XlxiU6/Pchqp
         emv4ZWXFIAhgHONln8j66E6FoAt73Gd8D+wFb2pSIzurE8ciBSQadi/cD/kr5kkksrPt
         jRGEtysA0xdNcuokira9Nro0HQP005M232wIAislI0sGE+OIjyUpj82wjigNsc1ldDSZ
         iwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303599; x=1715908399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EScPTFIUsU9lafWPj5+nn2qz08FusFYqcC6FL2ky40Q=;
        b=sOgAlV32xGh5tprowM309sbyEu+bOnhoDEly+2np8iitY2XMquvSlVcQ/9YkU2p20Z
         aWiD/LSbMBsWSkQDYxXQ/6U5bO/FnCHecI2EUXhqm/vD4hkNuN9es3Viwrn+ulri0wBw
         pgmH2dVy9l1TXHObdpLmwfahJZaioEobakAJgtCJGY5RnmZ0iQEvdjNyH8PJg7ZLdAkG
         vKj/bTLYD9o4/GqN359qNxrhzo6QtNuf1cJADgM7RlNMc1hY9/KobFeOyoQZ+vWLDcIC
         fYG8QXnepGyIYAww6OLnSb6/Zsa35AwfkF41yJ9pElT2OvuPfCRKl/K8x5oaNVFdWE5b
         7M0A==
X-Gm-Message-State: AOJu0YyUSEa1R02DOL7zUQ/E6L7Gw3EDIxzo3n7xQO10Cup3J//M49kh
	VI7eOgTYmxymTfVFvHpjkvmrGfPVyOxyAxkQ5NkGMs1jOPLXvTD+2eFpSw==
X-Google-Smtp-Source: AGHT+IECdL4r79GmJfG6MT6wYPicTclfHUAHaqdIJn+ZLdpDuSthi+IE0/XGlynoq4mUz3stipLFtg==
X-Received: by 2002:a9d:7503:0:b0:6ee:ead5:25c with SMTP id 46e09a7af769-6f0e90f60e7mr1504580a34.1.1715303599203;
        Thu, 09 May 2024 18:13:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:18 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 4/9] bpf: create repeated fields for arrays.
Date: Thu,  9 May 2024 18:13:07 -0700
Message-Id: <20240510011312.1488046-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
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


