Return-Path: <bpf+bounces-46590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0EE9EC200
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62237188B869
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFDB1FBEB2;
	Wed, 11 Dec 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU9HZtY4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFC1AAA00;
	Wed, 11 Dec 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883174; cv=none; b=ZGMFHYdzQlyzP1oRQznWSDnD2SMYi3NlYeAGF/xQGowbkwjtkk1E1bXeqRIR8Vdr8EvKbuojT0Wxk2zNob85U+55sEtKr99qJTcOq48VPhxKQ2T8bTtryq2BPhNxg9PPb+d5VbtNw/yCjLPYNw2X99eip8OxsImPobq0kXqCODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883174; c=relaxed/simple;
	bh=NjRaaAO6uex0kdaiIQaOYi7H2xOTaN60xPEIg5ToN0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bheJspGrOxQXuuKVpjT9X5widkSIxgRt6WsTKz8nZlZjPSgs/NWR4+m5fpkItfdg1aac5ReZ8mTztwzAuG3l96eAn/eCEd3eQKJ8gjYwqYiiLXPauSU5ZRYizT1d1ezolU8UYsgb3q8q1i434hTHxS/Sp0PXIcJZtMkm3ZORAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU9HZtY4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216634dd574so17169925ad.2;
        Tue, 10 Dec 2024 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733883172; x=1734487972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aNATulEVG1VuSXf5yPINwpgfqOcEXSA+A1XLcEmzZk=;
        b=mU9HZtY4uVEockpeBOyBvibMyMyHHiTQ8Wylqo30R8uO+UimeKcE/pnasRRXmjSHnR
         MkxyNJPYU7TPfvahJ/heIfdOX9upEi5m1FWhAl37R1N0sbJe4J7C7YUEJUV5MXXlpGFq
         y1b82YLSwwXQ5DO2L2lzbUtT1NrqoESHfbYEiMQTptx2Ygb0V7TC86V+j4IeH4DytdL5
         R+8dvVlNOvBYSJocjt9bP1Dk2K5liitBot7ztYVnQJFhwAvhy8x+vJ73xyE8Bb7LYz0f
         ibMFdBvTERmgYJmEuei4EmWhLY0HF9bPHFSTez9Io1wzf5RqWLdLmQAbWOKRQHyeej37
         8x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733883172; x=1734487972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aNATulEVG1VuSXf5yPINwpgfqOcEXSA+A1XLcEmzZk=;
        b=U9u3XO9Jr4pT3ixjWWdRdQKGi8duMk1XVpjyF192mm8XG9lvE1IOhf85j1iXA2b4cL
         nabg4heWVILlkSWT1dJNqZlX3RamSvcSaJzkQkhVVizFhPQVc3P6quIINP4odihjVCk0
         GGxK88IA7IYMILswQDvB5p0K2ARfgxYj33r/waob8I/+zkyePRA8vvYpvbBJme1wMaej
         D33ZgRLret89iQKajwhJ6n/TNkYBAuq/hAwEsx68YmIpptCIC2kml7bCaAx3CcAjldvn
         eB9tiPdSoKoZxsfbq/tzF/21HQ2UQKVqCV1nZERdiRSTMfUP8Py8sYP8OgCn5Bm382p4
         W1Bw==
X-Gm-Message-State: AOJu0YyqPD5tkC9+BQiW9H6bI+5cLwQILK7Zv2rgh6qN0V3YpzQVbpxN
	ArrJr9WLGrNA/tYa2Lm0pxS4V3sw7O9WVxZMVNLvbt3d/5IU4vKvNx8fIA==
X-Gm-Gg: ASbGncuAGTd+ph8cAHeUat/zuwPrDCQLdyJfXqhpK+79Ccuw4M4I6FLV/XLNTv+r68U
	prQPpZZXiJGPY+tTMTO98n0D6Y8zYMSQQ16tqKjnT8pYYPSarrGL6TXvXHWN5WFIrCHLpusB8EL
	lMyk20eX8zdLyszbjILwDSqSIhO9ceoexgBUdz05bcIbUaiCrQ3cx6Dy1lhyU6cdSPERb3vlFTF
	PAOA7Ojg8yRx9ywzaxzgZeJZK7Y5a7KSdvPx202nfuOtcC+8Q==
X-Google-Smtp-Source: AGHT+IGyDdrKTSIntUAePjiyO1cqihLCOUbzoRyivebYrB3swvGtGur8GUriovXy9zEkaWJheaLelA==
X-Received: by 2002:a17:902:ce86:b0:215:7cde:7fa3 with SMTP id d9443c01a7336-21778509fa3mr20710385ad.25.1733883171655;
        Tue, 10 Dec 2024 18:12:51 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e5f2sm96573975ad.13.2024.12.10.18.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:12:51 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com,
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH dwarves v1 1/2] btf_loader: support for multiple BTF_DECL_TAGs pointing to same tag
Date: Tue, 10 Dec 2024 18:12:26 -0800
Message-ID: <20241211021227.2341735-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_loader issues a warning when it sees several BTF_DECL_TAGs
pointing to the same type. Such situation is possible in practice
after patch [0], that marks certain functions with kfunc and
bpf_fastcall tags. E.g.:

  $ pfunct vmlinux -F btf -f bpf_rdonly_cast
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc), ignoring
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
  bpf_kfunc void * bpf_rdonly_cast(const void  * obj__ign, u32 btf_id__k);

This commit extends 'struct tag' to allow attaching multiple
attributes. Define 'struct attributes' as follows:

  struct attributes {
        uint64_t cnt;
        const char *values[];
  };

In order to avoid adding counter field in 'struct tag',
as not many instances of 'struct tag' would have attributes.

Same command after this patch:

  $ pfunct vmlinux -F btf -f bpf_rdonly_cast
  bpf_kfunc bpf_fastcall void * bpf_rdonly_cast(const void  * obj__ign, u32 btf_id__k);

[0] https://lore.kernel.org/dwarves/094b626d44e817240ae8e44b6f7933b13c26d879.camel@gmail.com/T/#m8a6cb49a99d1b2ba38d616495a540ae8fc5f3a76

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/dwarves/Z1dFXVFYmQ-nHSVO@x1/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_loader.c           | 31 +++++++++++++++++++++++--------
 dwarf_loader.c         |  2 +-
 dwarves.c              |  3 +++
 dwarves.h              |  8 +++++++-
 dwarves_fprintf.c      |  6 ++++--
 tests/btf_functions.sh |  2 +-
 6 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 4814f29..af9e1db 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -459,9 +459,28 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
 	return 0;
 }
 
+static struct attributes *attributes__realloc(struct attributes *attributes, const char *value)
+{
+	struct attributes *result;
+	uint64_t cnt;
+	size_t sz;
+
+	cnt = attributes ? attributes->cnt : 0;
+	sz = sizeof(*attributes) + (cnt + 1) * sizeof(*attributes->values);
+	result = realloc(attributes, sz);
+	if (!result)
+		return NULL;
+	if (!attributes)
+		result->cnt = 0;
+	result->values[cnt] = value;
+	result->cnt++;
+	return result;
+}
+
 static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 {
 	struct tag *tag = cu__type(cu, tp->type);
+	struct attributes *tmp;
 
 	if (tag == NULL)
 		tag = cu__function(cu, tp->type);
@@ -475,15 +494,11 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 	}
 
 	const char *attribute = cu__btf_str(cu, tp->name_off);
+	tmp = attributes__realloc(tag->attributes, attribute);
+	if (!tmp)
+		return -ENOMEM;
 
-	if (tag->attribute != NULL) {
-		char bf[128];
-
-		fprintf(stderr, "WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
-		       attribute, tag__name(tag, cu, bf, sizeof(bf), NULL), tag->attribute);
-	} else {
-		tag->attribute = attribute;
-	}
+	tag->attributes = tmp;
 
 	return 0;
 }
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 598fde4..34376b2 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -513,7 +513,7 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 
 	dwarf_tag__set_attr_type(dtag, abstract_origin, die, DW_AT_abstract_origin);
 	tag->recursivity_level = 0;
-	tag->attribute = NULL;
+	tag->attributes = NULL;
 
 	if (cu->extra_dbg_info) {
 		pthread_mutex_lock(&libdw__lock);
diff --git a/dwarves.c b/dwarves.c
index ae512b9..f970dd2 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -210,6 +210,9 @@ void tag__delete(struct tag *tag, struct cu *cu)
 
 	assert(list_empty(&tag->node));
 
+	if (tag->attributes)
+		free(tag->attributes);
+
 	switch (tag->tag) {
 	case DW_TAG_union_type:
 		type__delete(tag__type(tag), cu);		break;
diff --git a/dwarves.h b/dwarves.h
index 1cb0d62..0a4d5a2 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -516,10 +516,16 @@ int cu__for_all_tags(struct cu *cu,
 				     struct cu *cu, void *cookie),
 		     void *cookie);
 
+struct attributes {
+	uint64_t cnt;
+	const char *values[];
+};
+
 /** struct tag - basic representation of a debug info element
  * @priv - extra data, for instance, DWARF offset, id, decl_{file,line}
  * @top_level -
  * @shared_tags: used by struct namespace
+ * @attributes - attributes specified by BTF_DECL_TAGs targeting this tag
  */
 struct tag {
 	struct list_head node;
@@ -530,7 +536,7 @@ struct tag {
 	bool		 has_btf_type_tag:1;
 	bool		 shared_tags:1;
 	uint8_t		 recursivity_level;
-	const char	 *attribute;
+	struct attributes *attributes;
 };
 
 // To use with things like type->type_enum == perf_event_type+perf_user_event_type
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index e16a6b4..c3e7f3c 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1405,9 +1405,11 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
 	struct ftype *ftype = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
 	size_t printed = 0;
 	bool inlined = !conf->strip_inline && function__declared_inline(func);
+	int i;
 
-	if (tag->attribute)
-		printed += fprintf(fp, "%s ", tag->attribute);
+	if (tag->attributes)
+		for (i = 0; i < tag->attributes->cnt; ++i)
+			printed += fprintf(fp, "%s ", tag->attributes->values[i]);
 
 	if (func->virtuality == DW_VIRTUALITY_virtual ||
 	    func->virtuality == DW_VIRTUALITY_pure_virtual)
diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index 61f8a00..c92e5ae 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -66,7 +66,7 @@ pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
 	sort|uniq > $outdir/dwarf.funcs
 # all functions from BTF (removing bpf_kfunc prefix where found)
 pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf 2>/dev/null|\
-	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
+	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/btf.funcs
 
 exact=0
 inline=0
-- 
2.47.0


