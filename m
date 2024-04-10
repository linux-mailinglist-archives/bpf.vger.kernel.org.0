Return-Path: <bpf+bounces-26342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C157489E704
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B12283DB7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB393D75;
	Wed, 10 Apr 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnFKG6WM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CC1C2D
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709722; cv=none; b=EZ0Gn29+cCVE1G3vJ+1nB8JthFZQKQCc0HbNSmo0ENivV9hYvnp91ILohpHUrl48lBczwrtNbyywxU39NoFOoXy5SbAXw04Ips4G9XENGfNTTwMrVVREKe5QQe48tZjGaacmSf+1KcZCyEaU9C0TIwLhXp4xM64k36ah2FtG7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709722; c=relaxed/simple;
	bh=duJrRbrDbuvEkA+s0FVFEg8myFmF/kzDbiyzFeuepgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEV3T3GZvkxh72EyKDmEvYcVh5JJ9VKq+jUzhdXIaZ4TlxtVNzCXz6iIUtB9fmv8lRdm9rZ01/JTMqLPRPQ1Np+y5IPMxuGGqwkCe4/9gAmjyxbW/s50/fDwgWJD5xqmj0z7rzlaER997/BeQvV0VvJql/IPwXQ18RLf21aJVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnFKG6WM; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea260f51b8so814250a34.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709720; x=1713314520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF8KcRRkTQwJsCZ7FycwHfjPvjuQ14LUR/nslkAUd2o=;
        b=dnFKG6WMa/JZppoyl2n2Brd7sTPH6vNKOwfPXtWyDLiq67eqToOzSKu5lUXdZ7l7bl
         gyWL24WvGvpqGQqTEYNgE8bptGvaaQWvHnh1qvmQK74ZLI9u1S/JkKwVCi2nG3RviT3M
         IO3puOkGoLXOpQs6z601rGf8d0MdJzEdBanqYcYHZEw1jBXMeVC+r99od4lR6fpGST+s
         o/qyxG6FBPZxWBch1V1VUZ6uJCZBUaIWjVioW1ZyXGDmVzL50hOonttELTGdcJwxf1mN
         r1moRP4J6jhqu0jkiSGxCt1xEBRi3iZyLS5x270pVOOjQgarkIK0SNuK84PxbT42tZyQ
         p0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709720; x=1713314520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF8KcRRkTQwJsCZ7FycwHfjPvjuQ14LUR/nslkAUd2o=;
        b=S34SH1ByeHGwE1UO05ueKkpEIctrLW281sJgtwMXvz+jBlIOq3T++yrA/nHrCCBlnk
         LtJjGht+uDH4xJJwcsAjmHHXwI3xfL/vfjSEr0AUKwSdaGjxS+Y0JMLNXq8jqnGxLqhP
         ZBS1BGexu4OaLkMXY0B8RzxKsQAPhBgbJaMQbzAvery+yGDGmdF3nsXCkg3/zEsL5pdF
         R8G0/7lhu2Wryb0w25voSdGsOupYKE9IaHmU+cPUI391KJAlQ5GA1dJFC6GOXTq2JfiW
         L8e11khGdKBNsSARpCvAHgkdSQcd6DNaaUwAzlTxKeDdJM8Y5RXnRDc1QJEG7UCkNFdU
         rU+g==
X-Gm-Message-State: AOJu0YzPK1wepcbQRF435nEE9mus9imoWuldrDFJ2DZC2oVxv+QUmPlt
	bNJn9GQnOpvN8z4NAJH3r3FjhM6iOhudkuDAd6m71Gfz/COTouBDb/4BEvqh
X-Google-Smtp-Source: AGHT+IFjedtfU0iz62u11MLt33WWqzh+27w2Lnn4fd56Lnj45EJJ3Hi6w4s/2/7L20ipjp7OYXW29A==
X-Received: by 2002:a05:6808:20f:b0:3c5:f9eb:6b26 with SMTP id l15-20020a056808020f00b003c5f9eb6b26mr1160623oie.19.1712709720298;
        Tue, 09 Apr 2024 17:42:00 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:42:00 -0700 (PDT)
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
Subject: [PATCH bpf-next 06/11] bpf: Find btf_field with the knowledge of arrays.
Date: Tue,  9 Apr 2024 17:41:45 -0700
Message-Id: <20240410004150.2917641-7-thinker.li@gmail.com>
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

Make btf_record_find() find the btf_field for an offset by comparing the
offset with the offset of each element, rather than the offset of the
entire array, if a btf_field represents an array. It is important to have
support for btf_field arrays in the future.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/syscall.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 543ff0d944e8..1a37731e632a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -516,11 +516,18 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
+	int gt = 1, lt = -1;
 
+	if (f2->nelems == 0) {
+		swap(f1, f2);
+		swap(gt, lt);
+	}
 	if (f1->offset < f2->offset)
-		return -1;
-	else if (f1->offset > f2->offset)
-		return 1;
+		return lt;
+	else if (f1->offset >= f2->offset + f2->size)
+		return gt;
+	if ((f1->offset - f2->offset) % (f2->size / f2->nelems))
+		return gt;
 	return 0;
 }
 
@@ -528,10 +535,14 @@ struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
 				  u32 field_mask)
 {
 	struct btf_field *field;
+	struct btf_field key = {
+		.offset = offset,
+		.size = 0,	/* as a label for this key */
+	};
 
 	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
 		return NULL;
-	field = bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
+	field = bsearch(&key, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
 	if (!field || !(field->type & field_mask))
 		return NULL;
 	return field;
-- 
2.34.1


