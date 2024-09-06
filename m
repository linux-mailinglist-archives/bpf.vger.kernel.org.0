Return-Path: <bpf+bounces-39126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F096F548
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219771C22620
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C581CDFD6;
	Fri,  6 Sep 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A45GCZ7W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D681CB152
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629117; cv=none; b=KKhhsbJZwAsZ9fDpuFLtUUgNKcwVYlZixUMkTL1voN0BFyGe3iZc19fuWRXN5Iy34Jt5WFhWeL/fjaj3vp0u3n8W9uo1sEgVp26+WEV/NbIXmmvFF1lXgg8NNpraFRjDjYKnvzx5TesivXDT3ps3JB/MQFJ2FC0drWK/K0J6ZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629117; c=relaxed/simple;
	bh=kDxOzz5SpX585ojBNxPjju528OktYRdmAeM5BnxRqD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHgGxla9+crI7Qrs2mw1ysYQKzXhiKIqJzjY94fKI5Lz8xAoFHWDyKlUCKyHcBK9KK+J2qXocCzsQsSxP+OkHSQcXaI3zVzAcKCSFSFYHepheS/MwHsuUHZDGaTr4FGYnGQMTpbcDRNcxirwcphmqDFNxrQ0vDiRDAnf4ddWS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A45GCZ7W; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3c34e3c39so2981017a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725629114; x=1726233914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sto01fDxQHM3onJKiK7P6Inn/GGU2ODBq7UmU6tmpsE=;
        b=A45GCZ7Wg+qT+d5YOfIX5rXZ+mifBC3SireFhxhFr1HY0WzQTPHNrr7F9ogwrb3I8o
         IlMIIzPb2/i6cdF3i1uK4Al/8D5I/CVvSSMoU5t2sB70SHJ9maLQI5bdNRKOG5HL6sq8
         XstwskQnCme9CIQanjaHoy7PHYokozkuwKxhL3CYajFJTzuvZWRzrWPRDcGsqyqJyTgA
         0gdx3YzeqyFgHnXC84ueV8Y4YCQLEZ1xt3IZHkzvJ6nNsmDkhSfpVZIK/ePh4VvVso4N
         dfiHWSzOkT6G1hx8Lep/KxnV4SNDXmLVDts51iSxFrjHnQfmgyYr+rVXLxuQPAS9eA1Q
         3+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629114; x=1726233914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sto01fDxQHM3onJKiK7P6Inn/GGU2ODBq7UmU6tmpsE=;
        b=MpoBVRDr9n5iY0dAVIfo98qqbf/awiSbL6ae2jXKQecPYfEkyoTF8PnwM/JuKWMa8R
         6DbNK89k0v5wqHyKIHkmy4qleBhgLUdfKC7Z2W4lwE3OR3uAzXFITlLYrLVey/AGHNXZ
         ftRYQ0S9dFLOe0E6tHBOi33nn5+j5sjT0Jf6yIXxeZC6dFfU5UTYLbTupn6MN5MRpVgy
         PrZAdWAoEp0fLEx455eFN8M7oDtJdE4RHVxXts6nbjRNP/evf+7qaRHyNjmdZD/8uv01
         2AJ7ihZ2BjLhKfAzy8AEah5ChkTFiNT9kY4SPGakAxJKANsbkPVtnhWa3BarHcd4J8uT
         PUXw==
X-Gm-Message-State: AOJu0YxZ+q0556q5mvNvBBwCDMkdo2lyujHK00es+bQLnDa+GBCcI4YZ
	byeXSvLe0DTv/qmtQ1okZp860/xqPjCylJxCX6IpYxrN9lgdQMzodX6FL6SR
X-Google-Smtp-Source: AGHT+IH4YlVDbdMhnJxxiCoHIJOOeAX+vuOcYW6Aa65t75qqI8v8W0Pse8tMkS+Urs/O81CZV9rxhg==
X-Received: by 2002:a17:907:6089:b0:a7a:a30b:7b94 with SMTP id a640c23a62f3a-a8a88667a30mr203096866b.28.1725629113165;
        Fri, 06 Sep 2024 06:25:13 -0700 (PDT)
Received: from localhost.localdomain (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8c5366674esm42735566b.97.2024.09.06.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:25:12 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] bpftool: improve btf c dump sorting stability
Date: Fri,  6 Sep 2024 14:24:53 +0100
Message-ID: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Existing algorithm for BTF C dump sorting uses only types and names of
the structs and unions for ordering. As dump contains structs with the
same names but different contents, relative to each other ordering of
those structs will be accidental.
This patch addresses this problem by introducing a new sorting field
that contains hash of the struct/union field names and types to
disambiguate comparison of the non-unique named structs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/btf.c | 80 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 3b57ba095ab6..7d2af1ff3c8d 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -50,6 +50,7 @@ struct sort_datum {
 	int type_rank;
 	const char *sort_name;
 	const char *own_name;
+	__u64 disambig_hash;
 };
 
 static const char *btf_int_enc_str(__u8 encoding)
@@ -584,20 +585,88 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
 	return NULL;
 }
 
+static __u64 hasher(__u64 hash, __u64 val)
+{
+	return hash * 31 + val;
+}
+
+static __u64 btf_name_hasher(__u64 hash, const struct btf *btf, __u32 name_off)
+{
+	if (!name_off)
+		return hash;
+
+	return hasher(hash, str_hash(btf__name_by_offset(btf, name_off)));
+}
+
+static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 id, bool include_members)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	int i;
+	size_t hash = 0;
+
+	hash = btf_name_hasher(hash, btf, t->name_off);
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		for (i = 0; i < btf_vlen(t); i++) {
+			__u32 name_off = btf_is_enum(t) ?
+				btf_enum(t)[i].name_off :
+				btf_enum64(t)[i].name_off;
+
+			hash = btf_name_hasher(hash, btf, name_off);
+		}
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		if (!include_members)
+			break;
+		for (i = 0; i < btf_vlen(t); i++) {
+			const struct btf_member *m = btf_members(t) + i;
+
+			hash = btf_name_hasher(hash, btf, m->name_off);
+			/* resolve field type's name and hash it as well */
+			hash = hasher(hash, btf_type_disambig_hash(btf, m->type, false));
+		}
+		break;
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_CONST:
+	case BTF_KIND_PTR:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_DECL_TAG:
+		hash = hasher(hash, btf_type_disambig_hash(btf, t->type, include_members));
+		break;
+	case BTF_KIND_ARRAY: {
+		struct btf_array *arr = btf_array(t);
+
+		hash = hasher(hash, arr->nelems);
+		hash = hasher(hash, btf_type_disambig_hash(btf, arr->type, include_members));
+		break;
+	}
+	default:
+		break;
+	}
+	return hash;
+}
+
 static int btf_type_compare(const void *left, const void *right)
 {
 	const struct sort_datum *d1 = (const struct sort_datum *)left;
 	const struct sort_datum *d2 = (const struct sort_datum *)right;
 	int r;
 
-	if (d1->type_rank != d2->type_rank)
-		return d1->type_rank < d2->type_rank ? -1 : 1;
-
-	r = strcmp(d1->sort_name, d2->sort_name);
+	r = d1->type_rank - d2->type_rank;
+	r = r ?: strcmp(d1->sort_name, d2->sort_name);
+	r = r ?: strcmp(d1->own_name, d2->own_name);
 	if (r)
 		return r;
 
-	return strcmp(d1->own_name, d2->own_name);
+	if (d1->disambig_hash != d2->disambig_hash)
+		return d1->disambig_hash < d2->disambig_hash ? -1 : 1;
+
+	return d1->index - d2->index;
 }
 
 static struct sort_datum *sort_btf_c(const struct btf *btf)
@@ -618,6 +687,7 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 		d->type_rank = btf_type_rank(btf, i, false);
 		d->sort_name = btf_type_sort_name(btf, i, false);
 		d->own_name = btf__name_by_offset(btf, t->name_off);
+		d->disambig_hash = btf_type_disambig_hash(btf, i, true);
 	}
 
 	qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
-- 
2.46.0


