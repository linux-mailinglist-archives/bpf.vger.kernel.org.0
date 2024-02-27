Return-Path: <bpf+bounces-22752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03301868581
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 02:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B292F28730C
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B64C89;
	Tue, 27 Feb 2024 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IodHR3ss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270104A31
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995884; cv=none; b=Ea3taq2aqr1TXgtaP4jKaQkJDm29Bv6Fq/hbGsDslW1ZKLLpL81M9PZqdQqPa1wfgHfuimYkK3/aMlzs0AhceE5jh1WDEI8QxwO86Ckn5uiZcYeVEHrACf4OFFne2RIR7ZGcb3iSPRMeLBm/o3yI8LdFsVWl1/gJw78WCIC7GSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995884; c=relaxed/simple;
	bh=qlzIsVIhJLxgRDzA0yVSTYms/ohIRRDxP4a22qXzz+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaYRBdx5Q491UdIlA9I9Z2LAik7HlJkFtVmXCrSuaD+flHQ0c05qL4wXHRBJFlSEM9vJkZFl+AZt3w1xKe6wYI0lHP/yjDk2AhbmmybYB3hFO6NHVeCHAu1oS3REFhphoFuduKwDG+Ns5Fs//9xtOZhAzXZb8K6e6MXG5MBNRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IodHR3ss; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6092387bdd0so3194227b3.3
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 17:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995881; x=1709600681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMqk02IIEeZvjATR0snmBdS3w8x6eoKpCnnb8BcMKSM=;
        b=IodHR3ssnDwazC8Ij4tqW3JkM03uWv5wkFoRDUiuGEkus1IS1AuaM3qi0v1SoaOvtY
         +RGRce+RItQMxASl8e72R5cRcRZ4Lssdc4IXwekWE5kMYxkDFbEh8/ci4nERXI0D8jv9
         rxyt1nzhkBQLo7n2AAeVgV1swPeHfK+ix+kNsbXBbzlqvNnDo+B0QUjzYEBnWpkzLFbt
         +uL0FHwhRiydwseEWuqXXYRAy+7dAgop8O2o9qqPV9rL16zASVwvD8mTr4eQEUGsD0S7
         6abCJGNevNncr3vCWN2HhZosophnh+vM5jouptDkWcbuX2XQegNCAufIt7BkeJ0iPpL2
         ZPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995881; x=1709600681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMqk02IIEeZvjATR0snmBdS3w8x6eoKpCnnb8BcMKSM=;
        b=JnF0M9tb5qSzbfSgN3Ons5k9R1R3BhMh9YqXbK0ibekOVibln06FlSRXlzhQ0esv+g
         BPzfw1+7L++DkI95z5JVSiVRGEVB7I6uhq22EHHbvhRYLYHPI1N2lfLI/yCihukRLawf
         xTAc1NQHtearI3knOF2QjaZMZpgMXi8WPkVUPDj6qsBdHbEX5AIC8S8hrhfY2ZKX988D
         eA/w7kPHcBXUm+Jcl6QZLOB7INnfgB6mf146lilUm3k+iMPonPqZ26bP2hGWgdoMAsfG
         PwJPY8W6x8FeqOQzMb8S5E7WHFEjliNzv0x0ZtuiBcUcAyPjjTdYsPufbcLAboJrHHsW
         KSsA==
X-Gm-Message-State: AOJu0YwSRjBlCHS9muJwYVc2YSE7riBPxc9e1lJkKTU5sP5C0KqXsJGv
	sVVl3cS4/HrY4QurBumI3i8OW3FXt/NTgbSrRdnaiTlePlSjCg8eHmlPofK9
X-Google-Smtp-Source: AGHT+IFa5O5q5I+PNjkPQkkOURTyvdmUcYwrbh1dLVYtTEZNeg6IAYyHXDamsPVlqyJlutMgwF5YzA==
X-Received: by 2002:a05:690c:ec8:b0:609:15e2:1e2c with SMTP id cs8-20020a05690c0ec800b0060915e21e2cmr1018490ywb.27.1708995881533;
        Mon, 26 Feb 2024 17:04:41 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm1458818ywe.104.2024.02.26.17.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:04:41 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 3/6] libbpf: Convert st_ops->data to shadow type.
Date: Mon, 26 Feb 2024 17:04:29 -0800
Message-Id: <20240227010432.714127-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227010432.714127-1-thinker.li@gmail.com>
References: <20240227010432.714127-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert st_ops->data to the shadow type of the struct_ops map. The shadow
type of a struct_ops type is a variant of the original struct type
providing a way to access/change the values in the maps of the struct_ops
type.

bpf_map__initial_value() will return st_ops->data for struct_ops types. The
skeleton is going to use it as the pointer to the shadow type of the
original struct type.

One of the main differences between the original struct type and the shadow
type is that all function pointers of the shadow type are converted to
pointers of struct bpf_program. Users can replace these bpf_program
pointers with other BPF programs. The st_ops->progs[] will be updated
before updating the value of a map to reflect the changes made by users.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 465b50235a01..2d22344fb127 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1102,6 +1102,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		if (btf_is_ptr(mtype)) {
 			struct bpf_program *prog;
 
+			/* Update the value from the shadow type */
+			st_ops->progs[i] = *(struct bpf_program **)mdata;
+
 			prog = st_ops->progs[i];
 			if (!prog)
 				continue;
@@ -9308,7 +9311,9 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 	return NULL;
 }
 
-/* Collect the reloc from ELF and populate the st_ops->progs[] */
+/* Collect the reloc from ELF, populate the st_ops->progs[], and update
+ * st_ops->data for shadow type.
+ */
 static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
 {
@@ -9422,6 +9427,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 		}
 
 		st_ops->progs[member_idx] = prog;
+
+		/* st_ops->data will be expose to users, being returned by
+		 * bpf_map__initial_value() as a pointer to the shadow
+		 * type. All function pointers in the original struct type
+		 * should be converted to a pointer to struct bpf_program
+		 * in the shadow type.
+		 */
+		*((struct bpf_program **)(st_ops->data + moff)) = prog;
 	}
 
 	return 0;
@@ -9880,6 +9893,12 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 
 void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 {
+	if (bpf_map__is_struct_ops(map)) {
+		if (psize)
+			*psize = map->def.value_size;
+		return map->st_ops->data;
+	}
+
 	if (!map->mmaped)
 		return NULL;
 	*psize = map->def.value_size;
-- 
2.34.1


