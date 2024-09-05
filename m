Return-Path: <bpf+bounces-39060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E2396E3C4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705D2286560
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749C19307F;
	Thu,  5 Sep 2024 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLtQv3Yo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C01917DA
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567175; cv=none; b=Gvn9ewATn4nTkF9/vBXl62TFHV5RmHhGXPeupPphYrty09jWEjS9YWQjiYm2XNP15r3+t9r283VNUcYaXCsiTA8MbkLCdv5xSwqVQiOtJgKUNRxLZCnUx1DN3R2PPAefV4uXUfdQQTM4Q2l8HNdC3Xgwj78Xcl27UG9eXsxaEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567175; c=relaxed/simple;
	bh=HSx4DwKGBORnGewnDfvK0tdyj4scLDOek4oOfD8Vg/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfbMXIzZS4DNidcubSwwdh15ee4O86gYSare3DTqfHgyN+KjkqkZBLTJrN/uXI9GMih2LIOJpcRaQgXCDF+TK6MjXWB880QnPQib5b889P6stRW08SQR6SXj5cRWhI85FiRQos7uoohDJ0yerQ4+N7vpe3Sw5yDAEL6NxBZrp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLtQv3Yo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so1625229a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567172; x=1726171972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqiom7KHKthAzU96mtwPh2Dwt+xYoy6P+21V83yvMDU=;
        b=BLtQv3YoCW4yFBCoWVcW5putd+y/ZYhLcwh7fIMZ4oyhNP3Pq5LBxLKluT04DIxo+K
         JCSagp8xSGxGfeomw9cSGt14yaV3Ah6/OYX+PkbP6gzJMJnZbGpoKAs0L7Po4ytCCNTH
         3YXO3+0Ajwm0FrBOOCw9+Od+/4Zh4i2BJ8XMmx0u2vg3ozgByj+EQ1EwjoMRk5SWCzso
         RyfV1YJP7VIIvX3mf4wV3IMx+k8vbSPIJupOTW0mGdJ6DmXP28GklfGcwTAPquUH/pqa
         5IvTuSCU6B/zWlOCabiI9Qz186ftSHBZrWscLhszgNs9E9LrRAhSHa1ovbOQRNRb9/4i
         Fpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567172; x=1726171972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqiom7KHKthAzU96mtwPh2Dwt+xYoy6P+21V83yvMDU=;
        b=Md64A9ntkybLA/I7Jw/3Q7ZWxvLGQeTg09DS0Y8NF1hZNQ7IccO7ZZYDmJpbgoa83M
         o0Wrw2mwo6YuIsmbMJdDFUtcFsEsEv1x+5TTSTN/1h6+MUrYKNa4gE/RiPR/sLqIbpNc
         EM1iiqhASOWU1JK2tCRMURHk1gfSESz6ograasXBUxEdffiv4MYohWnY5bRKabzcYljO
         XIOsZC9MgteKyL0AA6zfiI+lup6xoO08I87F3FY5nCzfuvu4Wz5eXhdPhGAXzYPtHScN
         TzXJzt8Qm/n09Ma8rRG7Eaj0XEWFuRiqNOUhtQNtQr/9IvbKFkIhJA3SuH0uEGt49jQx
         5RLA==
X-Gm-Message-State: AOJu0YxmfXTvavgyxHbAgJVQnCNadMBKLY3sGVHAPuvZMlrjPs5/hgvd
	XXgLxnp7jTVAbmX4a7fgByVHtRJNyTiIEpTa1lgJOdnnWWQbw/4OuvB+Y9Vz
X-Google-Smtp-Source: AGHT+IFzq+A5JUS7hg6HXgxaordy5VuAbvyoA2qdpvoY9Uyb7UzK7GQ2RHj9LYjv2oypLoDOVadFAg==
X-Received: by 2002:a17:907:1b09:b0:a8a:6d66:ab86 with SMTP id a640c23a62f3a-a8a88667927mr16416366b.38.1725567171081;
        Thu, 05 Sep 2024 13:12:51 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::7:3e72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e3530sm176001166b.205.2024.09.05.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:12:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpftool: improve btf c dump sorting stability
Date: Thu,  5 Sep 2024 21:12:06 +0100
Message-ID: <20240905201206.648932-1-mykyta.yatsenko5@gmail.com>
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
 tools/bpf/bpftool/btf.c | 93 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 3b57ba095ab6..0e7151bfc3d5 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -50,6 +50,7 @@ struct sort_datum {
 	int type_rank;
 	const char *sort_name;
 	const char *own_name;
+	__u64 disambig_hash;
 };
 
 static const char *btf_int_enc_str(__u8 encoding)
@@ -557,17 +558,6 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
 	const struct btf_type *t = btf__type_by_id(btf, index);
 
 	switch (btf_kind(t)) {
-	case BTF_KIND_ENUM:
-	case BTF_KIND_ENUM64: {
-		int name_off = t->name_off;
-
-		if (!from_ref && !name_off && btf_vlen(t))
-			name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
-				btf_enum64(t)->name_off :
-				btf_enum(t)->name_off;
-
-		return btf__name_by_offset(btf, name_off);
-	}
 	case BTF_KIND_ARRAY:
 		return btf_type_sort_name(btf, btf_array(t)->type, true);
 	case BTF_KIND_TYPE_TAG:
@@ -584,20 +574,94 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
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
+static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 index, bool include_members)
+{
+	const struct btf_type *t = btf__type_by_id(btf, index);
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
+	r = d1->type_rank - d2->type_rank;
+	if (r)
+		return r;
 
 	r = strcmp(d1->sort_name, d2->sort_name);
 	if (r)
 		return r;
 
-	return strcmp(d1->own_name, d2->own_name);
+	r = strcmp(d1->own_name, d2->own_name);
+	if (r)
+		return r;
+
+	if (d1->disambig_hash != d2->disambig_hash)
+		return d1->disambig_hash < d2->disambig_hash ? -1 : 1;
+
+	return d1->index - d2->index;
 }
 
 static struct sort_datum *sort_btf_c(const struct btf *btf)
@@ -618,6 +682,7 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 		d->type_rank = btf_type_rank(btf, i, false);
 		d->sort_name = btf_type_sort_name(btf, i, false);
 		d->own_name = btf__name_by_offset(btf, t->name_off);
+		d->disambig_hash = btf_type_disambig_hash(btf, i, true);
 	}
 
 	qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
-- 
2.46.0


