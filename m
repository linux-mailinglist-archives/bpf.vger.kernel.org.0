Return-Path: <bpf+bounces-26661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AC8A37A3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DF7287AAA
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74052155311;
	Fri, 12 Apr 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbaiV6lc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93F154441
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956104; cv=none; b=hQLmGFnkXSIXbGNCG5TsizHO6Ep2wnPi2Mse8HEDqtnVMtwo3SkBHWYZhjIaAnKDxEYSmu2I1U6BRuophYk6GKvhNvf5bzLZFMW4USF8ZKs6jsNE/Ezhk3A17zOGNr3Q46hIEy1pSYG3Ldn60xfsMsGNhx2hRHwmnTg0LU8omYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956104; c=relaxed/simple;
	bh=WAQo3zeuYTuwBDnZIKOUNP3Zlaq6IdsaiiH7yQ3arVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZmL+7LdFyavZ7Udnt/5MYtsa+hQdkxU6DfsXv4PNQ2mC2B+omQPsPt/FJ+bQDWzYBiBMxdUP5Cw3H4NmiivSBETtyZeak/1VYnDH0ZJ8BWpKAUId7ZkvGjCDVLQElhY/ySH5ZxDuMetUb2xymcEoe6fhkocoBjmM9pnM/VUlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbaiV6lc; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22ecc103220so802524fac.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956101; x=1713560901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4evj/sl1m/knLQ1ldzpUWvsY/xm9y/3A4+Z0ZfNuB0=;
        b=jbaiV6lcxEu38gQWJC3LHa6LjkCA3+/e/McQ35uHr9W1SsRp44sHe6OTahdOuVNYEH
         0fLpSQduPNKSabdz4nE7x4KwJT2ojCXBrUt2gU2klowqgFCm6siqYzaOzlE/8YW9kIIj
         EgDFuHoMVnEw6q1cGd3triJ0APYNSQt6WI1ad/qMWYBIOZaTxCKJAYk9KPRbYygLBpNr
         /Eiz+Dqyn0qLVYEP0xatVX02tAzJsXZirW52KUsaPqC8O9y9kquLEyGiAAgMjbFCMv9/
         T0iFHCooJyvtodUBr6oqFC4jghSk/sl9Usq2g1MAOB0RoFM8d3XuHCaG3lon6HEE8vph
         sdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956101; x=1713560901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4evj/sl1m/knLQ1ldzpUWvsY/xm9y/3A4+Z0ZfNuB0=;
        b=jToDrYj5XUUx0jQ5iQd3SMs60Dhv4J7kgeB8HpUGNOQRq0+W7cQ+wvORYSoKgMyRSN
         IYPWAnQvVkBp6AZDR4gejvGoY7YgyP4o2wa0r5uHW6T/N9fd3PTgx0Sn1mRJVWqQciFI
         qZ05L9Ppor/Tvq8x6MM/8twF+S7eKsZtyE0Cc7pwq7LagFTrx0gc3/E3Xv3tH8V+x3th
         s64OSG4efbap/hrn2qOQkz7VmxjtAdnVv8dwQGrKUVJj/lvNtw9S4o+1bezaYaS9pdMz
         IbH5P6UI3WbQbxVPSqUDdt+nOGdKHhhCmlHDw8mMWqPrzsyfx7zWIPu4OkvFs5mFi4qD
         MonA==
X-Gm-Message-State: AOJu0Yzus5GIQGjPM4S8uxh84kBR2Wuhk5kdkNhxeqsopCrKboFrXbea
	Ts6/DrpYEkEyTytacJcNvOqNOfdJnKhp0G7STeGsmmXOPjCvmPiUxMjTaA==
X-Google-Smtp-Source: AGHT+IF9jzcAAL/L0BcZki8qmn5P0Ux7DfTHYwIL0W4Eu5YFrM43iHJvO81pJmpzXAamuHtnCBgR6Q==
X-Received: by 2002:a05:6870:7694:b0:22e:d61d:a53c with SMTP id dx20-20020a056870769400b0022ed61da53cmr2481737oab.51.1712956101195;
        Fri, 12 Apr 2024 14:08:21 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:20 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 03/11] bpf: Add nelems to struct btf_field_info and btf_field.
Date: Fri, 12 Apr 2024 14:08:06 -0700
Message-Id: <20240412210814.603377-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support global field arrays for bpf_rb_root, bpf_list_head, and kptr,
the nelems (number of elements) has been added to btf_field_info and
btf_field. The value of nelems is the length of a field array. Nested
arrays are flatten to get the length.

If a field is not an array, the value of nelems should be 1. In the other
word, you can not distinguish an array with only one element from a field
with the same type as array's element. However, it is not a problem with
the help of the offset and size in btf_field.

field->size will be the size of the array if it is.

The value of nelems of btf_field is always 1 to deactivate arrays for now,
but the nelems of btf_field_info has been updated as the number of elements
for data sections.  A later patch will activate it.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/btf.c    | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..cab479925dfd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -226,6 +226,7 @@ struct btf_field_graph_root {
 struct btf_field {
 	u32 offset;
 	u32 size;
+	u32 nelems;
 	enum btf_field_type type;
 	union {
 		struct btf_field_kptr kptr;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e71ea78a4db9..6fb482789f8e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3289,6 +3289,7 @@ enum {
 struct btf_field_info {
 	enum btf_field_type type;
 	u32 off;
+	u32 nelems;
 	union {
 		struct {
 			u32 type_id;
@@ -3548,6 +3549,7 @@ static int btf_find_struct_field(const struct btf *btf,
 			continue;
 		if (idx >= info_cnt)
 			return -E2BIG;
+		info[idx].nelems = 1;
 		++idx;
 	}
 	return idx;
@@ -3565,6 +3567,19 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
+		const struct btf_array *array;
+		u32 j, nelems = 1;
+
+		/* Walk into array types to find the element type and the
+		 * number of elements in the (flattened) array.
+		 */
+		for (j = 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); j++) {
+			array = btf_array(var_type);
+			nelems *= array->nelems;
+			var_type = btf_type_by_id(btf, array->type);
+		}
+		if (nelems == 0)
+			continue;
 
 		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 						field_mask, &seen_mask, &align, &sz);
@@ -3574,7 +3589,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			return field_type;
 
 		off = vsi->offset;
-		if (vsi->size != sz)
+		if (vsi->size != sz * nelems)
 			continue;
 		if (off % align)
 			continue;
@@ -3582,9 +3597,11 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_REFCOUNT:
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
-		case BPF_REFCOUNT:
+			if (nelems != 1)
+				continue;
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3615,7 +3632,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			continue;
 		if (idx >= info_cnt)
 			return -E2BIG;
-		++idx;
+		info[idx++].nelems = nelems;
 	}
 	return idx;
 }
@@ -3834,6 +3851,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		rec->fields[i].offset = info_arr[i].off;
 		rec->fields[i].type = info_arr[i].type;
 		rec->fields[i].size = field_type_size;
+		rec->fields[i].nelems = 1;
 
 		switch (info_arr[i].type) {
 		case BPF_SPIN_LOCK:
-- 
2.34.1


