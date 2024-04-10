Return-Path: <bpf+bounces-26339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2C789E701
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13DC1C2117B
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3DE1388;
	Wed, 10 Apr 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC5KmXT+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345364A
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709719; cv=none; b=tjsFUfVm9exCjVPw9t3mjalzqvlgxtpaZJZd+ugqDS9p7LcSUgBt//IR8YcpmQSb2rDQ53sVlSgE5thOLeNreymx+L3Jrqg1VDRQAKm9Zqw9hMCqjeHepQS7DJkedOxKoVi8B0hxrf2/Q/RQN3jTXT0TvyCl9bcvOYiULHmHKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709719; c=relaxed/simple;
	bh=vJnGMV9m02pWXOm3WPiZ6qA+dpqSfgOz+UF6/SJT8dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqCnluCDVlcYmnV+UJy8BJh/HkglIv0LuIuGPds7PoYm69efYNvXfIWCZddIR3j/mzX7U7iX+R0G0NZO8yvcpvV6KodXLJEycp7AwP/kuzTPrWVoMCCNe2OLHwXuZnN4d7cAsFnex3TD94ijLlob3FbQnIuv8zO5YQLuXuTtXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC5KmXT+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c4f23d23d9so3690984b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709717; x=1713314517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sTdDquWYFj1Nz0bN4Jj16pF/LNQ7Xc6jrYCY8FQPyg=;
        b=mC5KmXT+DW7SMOALdLVx9CWBbeVg3ie8cnqaWtRZGLwckvNcbRbMSx7YV9xjMwFYAs
         t5yDgbyvhBi42OVy2yqfDDmtCMPW6wOoN1YtAXrd9LEux9LbMMWt0AjVDPmw5M1vyx7s
         WlrFcwGrpCyuhnzltybUeeZOoKlXkwYZfJmLWXOxQvDu5fAS4kAdJ9JW/sxa3h9SsV0j
         m+Qha3bUoYYrMCq/EI1gPVj0IkykO715f3P6FRv601T6+fOnkSp6If76eA5qTOOJCaZO
         qzpSPWXu64JmVBjiNuvCPinirs1UKegTzuNPLE/ZnwmEp4qVoU8eir9sc75X3ecdvsm/
         vVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709717; x=1713314517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sTdDquWYFj1Nz0bN4Jj16pF/LNQ7Xc6jrYCY8FQPyg=;
        b=GGxyr9QnSm1+oUs3jV1YxnvBOJPzhDAivj3rLyj4zDjJv1IXE50vkaH0flsaDWcpH4
         Mn7/6UzjAajV30BySOnRvdrw8WoMNN4aaUezBjhJViUSGwBDQ3ZMbQvueB4V0YrlT661
         7dLpaO/lf1xy8uKGIpFV9MJlforZBTop6URU52tSr9Lq4W+YlZAVgpjAdUcZjMN6XMCA
         GiwnDIxRtFaaQrIsNojEOXp660fhoXFFpSN/voaMVwyYynhAG5jIMLzHeaP7B3Q3xZIY
         0JlWOGRH6fJZ6Kut61HuWZt1tT/Ww50BeMMUDKBByhth1XGwukDm+i7ziUIDcT29dCLW
         dFxA==
X-Gm-Message-State: AOJu0YyfQEIxEo3iW97LIbref6Wv+Qmz8lg2/NDT65LlhNPgUbQOwAv+
	UM5PbMXr1ZhjP64duwSDnq6dP8F1nqi7xjjdpaN3iUjJ90+ac2vkArEcsdLK
X-Google-Smtp-Source: AGHT+IEtcoRuNW2deHaPI8yW2nxZHv8KjsDTUko7rEaQpqspEwdcZCSkKGjUT8BNS9uW6TBeqNWL+g==
X-Received: by 2002:a05:6808:2a5c:b0:3c3:c0e5:8d47 with SMTP id fa28-20020a0568082a5c00b003c3c0e58d47mr1166453oib.31.1712709717153;
        Tue, 09 Apr 2024 17:41:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:41:56 -0700 (PDT)
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
Subject: [PATCH bpf-next 03/11] bpf: Add nelems to struct btf_field_info and btf_field.
Date: Tue,  9 Apr 2024 17:41:42 -0700
Message-Id: <20240410004150.2917641-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
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
 kernel/bpf/btf.c    | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 62762390c93d..f397ccdc6d4b 100644
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
index e71ea78a4db9..831073285ef2 100644
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
@@ -3582,9 +3597,12 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_REFCOUNT:
+			if (nelems != 1)
+				continue;
+			fallthrough;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
-		case BPF_REFCOUNT:
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3615,7 +3633,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			continue;
 		if (idx >= info_cnt)
 			return -E2BIG;
-		++idx;
+		info[idx++].nelems = nelems;
 	}
 	return idx;
 }
@@ -3834,6 +3852,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		rec->fields[i].offset = info_arr[i].off;
 		rec->fields[i].type = info_arr[i].type;
 		rec->fields[i].size = field_type_size;
+		rec->fields[i].nelems = 1;
 
 		switch (info_arr[i].type) {
 		case BPF_SPIN_LOCK:
-- 
2.34.1


