Return-Path: <bpf+bounces-23223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ADD86EDCF
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EA81F236C4
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97529479;
	Sat,  2 Mar 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxYpKYwf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC518F45
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342390; cv=none; b=MEHz+k9Ra57VnIsQk9sfjc6YaCkjTw/F7K7NWgO417tjKZyiQZOwl25uyHCjTikqm21ukld2TA8Jp/zVU5oi70IWNOwkdBVNyrcyJjek7MJ0MjqVgP0IScZaLWVBXyBLEJOEW/3FOUvRRKiRtYCmhpGFL45sjjnIzTYrD/aRMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342390; c=relaxed/simple;
	bh=0yE/DObzJjc2Zg4crGnGVkVCxyt/u6wvLPD1iui76NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4DisN/NkEy9HRn09KVX1irZbq+FwkTx2qW/Fk9MylogqUKfXWh+OaH8R8pWOh0FIitn4ICIAKcNSbMNPf8m0HIh1kw+fh4gHyT0zI55Niq8ZLqW9tbxBq4MD7gVwT4ztbUVycmAWO0oSgAtBuHUXxo6QOccyMWexg7uyk3aYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxYpKYwf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d347ddc37eso10175151fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342386; x=1709947186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah3fu713JMkYMRn5NrGfdWczvnLtn2aDDPdwpKWiMs4=;
        b=lxYpKYwfLqgeAw2M5xqWIWDkVz1i26wFCze1r+fM9BMfIsrPJ263M/G/t58RPOTLJW
         gy11ThWVJ0pL/U8/FwrsLICipyNdGtubWOgp5JSTW2oFWqDNGJml4+ML1uhcKENC9de9
         68/BdaQI/bKEx4FJHgZszRntUodlMpPe+7h00g8pw3Lx0tjGaApWPt8CSP7TLr3UJTTB
         NPIPvIWEjgpXqu9shIr2Dg7AWF/FUhYmWJWyCQBjlpbCCn3vz4WjQ7u25TD79AvCDX79
         L1Dj+R5XuhpwZZRxqefExQri/Ma9VATFt8FH8RMl1xs+reTnBSig3a9WNx5j7K6qfEEe
         EiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342386; x=1709947186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah3fu713JMkYMRn5NrGfdWczvnLtn2aDDPdwpKWiMs4=;
        b=q7A8g2NAYKQJFzYGymJuOX+ygNZ+FMh0EAumsarbwTjVeodwIrVeeqPXK8wuh77/i+
         ly+ej1xH2LaEZCXDPhBFrY0F3di/fR+CO857BavjIDilg9UL94yFq1eicoipWIZxHuAT
         3TQn/OFDkxZH3FaQSURLwAvepoub4TwDXwcSS6ALIsdfGpaTMnuZUiiNzrWlT5IN04oU
         fEkLfyeWsvDxHbnWE9usX/H3lm0aI1ZojJHj1Y6/9F/THqCgSCo2L7hvK1d9pfJeEIgE
         QbfQBvTLU4nub3g6o0sCr+JT7ijcJa01GZxF5lXxQoXCU73whdsQCNqUEzaspNU+CdHN
         j8Wg==
X-Gm-Message-State: AOJu0YyE4yRu/KFP9D7xzovrgdURPyhWGm81/ZIjehyl9UFbaMQ/KUty
	ceratSyxSVdHK4fbQyACM0i5ASFgz2Ord1aafC/nsgrqtW2y/QflyD9ZDx2Z
X-Google-Smtp-Source: AGHT+IHdsTWF9a8sdkWi4+7MSb1Rn4gJH5pU2Vspsqt4yrbK/OQPQZC3TfAI/TXNDWvsxDjI/YUMVg==
X-Received: by 2002:a2e:98c2:0:b0:2d3:ada:29e9 with SMTP id s2-20020a2e98c2000000b002d30ada29e9mr2292178ljj.12.1709342386280;
        Fri, 01 Mar 2024 17:19:46 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:45 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 10/15] libbpf: replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
Date: Sat,  2 Mar 2024 03:19:15 +0200
Message-ID: <20240302011920.15302-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch would add two new section names for struct_ops maps.
To make working with multiple struct_ops sections more convenient:
- remove fields like elf_state->st_ops_{shndx,link_shndx};
- mark section descriptions hosting struct_ops as
  elf_sec_desc->sec_type == SEC_ST_OPS;

After these changes struct_ops sections could be processed uniformly
by iterating bpf_object->efile.secs entries.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 60d78badfc71..8ecfad091cb5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -612,6 +612,7 @@ enum sec_type {
 	SEC_BSS,
 	SEC_DATA,
 	SEC_RODATA,
+	SEC_ST_OPS,
 };
 
 struct elf_sec_desc {
@@ -627,8 +628,6 @@ struct elf_state {
 	Elf *elf;
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
-	Elf_Data *st_ops_data;
-	Elf_Data *st_ops_link_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -637,8 +636,7 @@ struct elf_state {
 	__u32 btf_maps_sec_btf_id;
 	int text_shndx;
 	int symbols_shndx;
-	int st_ops_shndx;
-	int st_ops_link_shndx;
+	bool has_st_ops;
 };
 
 struct usdt_manager;
@@ -1222,7 +1220,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 }
 
 static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
-				int shndx, Elf_Data *data, __u32 map_flags)
+				int shndx, Elf_Data *data)
 {
 	const struct btf_type *type, *datasec;
 	const struct btf_var_secinfo *vsi;
@@ -1284,7 +1282,8 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->def.key_size = sizeof(int);
 		map->def.value_size = type->size;
 		map->def.max_entries = 1;
-		map->def.map_flags = map_flags;
+		map->def.map_flags = strcmp(sec_name, STRUCT_OPS_LINK_SEC) == 0
+				   ? BPF_F_LINK : 0;
 
 		map->st_ops = calloc(1, sizeof(*map->st_ops));
 		if (!map->st_ops)
@@ -1319,15 +1318,25 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 
 static int bpf_object_init_struct_ops(struct bpf_object *obj)
 {
-	int err;
+	const char *sec_name;
+	int sec_idx, err;
 
-	err = init_struct_ops_maps(obj, STRUCT_OPS_SEC, obj->efile.st_ops_shndx,
-				   obj->efile.st_ops_data, 0);
-	err = err ?: init_struct_ops_maps(obj, STRUCT_OPS_LINK_SEC,
-					  obj->efile.st_ops_link_shndx,
-					  obj->efile.st_ops_link_data,
-					  BPF_F_LINK);
-	return err;
+	for (sec_idx = 0; sec_idx < obj->efile.sec_cnt; ++sec_idx) {
+		struct elf_sec_desc *desc = &obj->efile.secs[sec_idx];
+
+		if (desc->sec_type != SEC_ST_OPS)
+			continue;
+
+		sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
+		if (!sec_name)
+			return -LIBBPF_ERRNO__FORMAT;
+
+		err = init_struct_ops_maps(obj, sec_name, sec_idx, desc->data);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static struct bpf_object *bpf_object__new(const char *path,
@@ -1365,8 +1374,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
-	obj->efile.st_ops_shndx = -1;
-	obj->efile.st_ops_link_shndx = -1;
 	obj->kconfig_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
@@ -1383,8 +1390,6 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
 	obj->efile.symbols = NULL;
-	obj->efile.st_ops_data = NULL;
-	obj->efile.st_ops_link_data = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -2929,14 +2934,13 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 static bool libbpf_needs_btf(const struct bpf_object *obj)
 {
 	return obj->efile.btf_maps_shndx >= 0 ||
-	       obj->efile.st_ops_shndx >= 0 ||
-	       obj->efile.st_ops_link_shndx >= 0 ||
+	       obj->efile.has_st_ops ||
 	       obj->nr_extern > 0;
 }
 
 static bool kernel_needs_btf(const struct bpf_object *obj)
 {
-	return obj->efile.st_ops_shndx >= 0 || obj->efile.st_ops_link_shndx >= 0;
+	return obj->efile.has_st_ops;
 }
 
 static int bpf_object__init_btf(struct bpf_object *obj,
@@ -3642,12 +3646,12 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->sec_type = SEC_RODATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
-			} else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
-				obj->efile.st_ops_data = data;
-				obj->efile.st_ops_shndx = idx;
-			} else if (strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
-				obj->efile.st_ops_link_data = data;
-				obj->efile.st_ops_link_shndx = idx;
+			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
+				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
+				sec_desc->sec_type = SEC_ST_OPS;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
+				obj->efile.has_st_ops = true;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -6960,12 +6964,12 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 		data = sec_desc->data;
 		idx = shdr->sh_info;
 
-		if (shdr->sh_type != SHT_REL) {
+		if (shdr->sh_type != SHT_REL || idx < 0 || idx >= obj->efile.sec_cnt) {
 			pr_warn("internal error at %d\n", __LINE__);
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
 
-		if (idx == obj->efile.st_ops_shndx || idx == obj->efile.st_ops_link_shndx)
+		if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
-- 
2.43.0


