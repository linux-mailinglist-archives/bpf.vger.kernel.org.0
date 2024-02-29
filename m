Return-Path: <bpf+bounces-22997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D350386C13B
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39717B24E51
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72410481C7;
	Thu, 29 Feb 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYTmztCZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BA481A0
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189132; cv=none; b=t5Wz7gSKHJgfZjbe2Eyf4XapZUPN3HyciGqFdBtvQcUR0PaLKow+1u5NXKEx578mrmvOonTp/omwsDMUaa+WeHxY4E22IdWMD7AIaNcSpBb8DyMlvoZj8sIyiPhSZpvKe7hnHhm3aQVW/vDnO2V6eMZeiLVQDkKL5YAkvsVdpUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189132; c=relaxed/simple;
	bh=nPn55oAoL7+0rpULCknJS7AjUVTcbbK5Iv1HeQI6JBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyPn9E/Uu8akcJ8aNCr3SfPbUQzFKdw+F3DWGGzOAHUztvO/ns7yQKHVUkQVwLUzSFI6oNg+afaIm6lhSkvnxX3Z90r0sT5g7xrBGubbEjJJGj3XIy+YuohB3s1XhEe9HKOa88LaKO783NCvjNLqA8zsQ7drJuF5zBeaZKYjB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYTmztCZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-608ed07bdc5so6050907b3.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709189129; x=1709793929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9HLAxJ9U4qLmljhg3LCA6GZlLz21K/lGZs0G8MOVVs=;
        b=WYTmztCZlyL3W46gBJ3SLWRGlWPNVv+x6ZvNXTzvHXS0b+IC+G8zP3x5B/7CZrvQpw
         /BKgDCw39bQYFGZNADebETxsaoHnI2FtLMt8b/tl/vYY8cgsB3i3vnhNzOKcpkfXfazP
         KSHqYrv0RppiV8jKEaKfsSX+VSTLcb4tjZ4U8OQMDl8/Xuqo7fLxhUzPQw1LE/+zmyLz
         7TDK74EwX8XplyGkmAhOrp75V5urcf1sGBU6rmKDfxJx0AU75vO5PC9iSoMgZUlKJDTA
         7KGSiFyxjUulmlZ4xUbFiOlF2hwQBMDn4ejlkg7e0G1xmrDXBU9+xnRv+gLGMHjHNqwK
         047Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189129; x=1709793929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9HLAxJ9U4qLmljhg3LCA6GZlLz21K/lGZs0G8MOVVs=;
        b=t3pMIUJVJ4aynJc1h7R92+izgoLE/66T+EyIAIBaPndSq0w98wvRk2zmw1r6BQcET/
         YnQPj8X5HSEL7jhgrF1G/YCmvspcqc+fXO0OZYhfEki0qGHjZJdGOW4+YBrk9GWIaSqG
         LjM4dEEa1Uz6iCJVXGUdEGjzSVJfzewSqqmNsR7WUstu5maeo9BCmx4ndY/lQqnSYCo1
         M0WcqIfZ0xDcLNhIOXGfzbTgmAuGsRmAoU8eOe8LrRJiBv6FZDPFtuUHnOhe81noN0pL
         6/7OoGoqdDwqnf27ijkj3cqfe9ClItHmDsnJ9emWS0Ef/HxOUoNGg/MVi69NAYnf2CQy
         8iyA==
X-Gm-Message-State: AOJu0YwuoNTC/uZUCQ5LYVE7nuS1tWm4d6epQRU4ThaXwSaDADLm/h08
	hOyfhafg3RyBl+nGuh+37slXbaaN6cxxzvLDa3ljxopTBr22MJ/vv6f7ca8b
X-Google-Smtp-Source: AGHT+IG0zJeP8Niex6DQ3bKzrxpoLYw2coepgw7oT8H8jLHzDY8NbWoRT+zC3Zra2rgZgm1dElXO0w==
X-Received: by 2002:a81:7341:0:b0:608:d188:6fd9 with SMTP id o62-20020a817341000000b00608d1886fd9mr1258898ywc.33.1709189129179;
        Wed, 28 Feb 2024 22:45:29 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc86:35de:12f4:eec9])
        by smtp.gmail.com with ESMTPSA id p14-20020a817e4e000000b006048e2331fcsm208581ywn.91.2024.02.28.22.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:45:28 -0800 (PST)
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
Subject: [PATCH bpf-next v6 2/5] libbpf: Convert st_ops->data to shadow type.
Date: Wed, 28 Feb 2024 22:45:20 -0800
Message-Id: <20240229064523.2091270-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229064523.2091270-1-thinker.li@gmail.com>
References: <20240229064523.2091270-1-thinker.li@gmail.com>
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
 tools/lib/bpf/libbpf.c | 43 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c322dd65e10..65d23a9d3e50 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1014,6 +1014,22 @@ static bool bpf_map__is_struct_ops(const struct bpf_map *map)
 	return map->def.type == BPF_MAP_TYPE_STRUCT_OPS;
 }
 
+static bool is_valid_st_ops_program(struct bpf_object *obj,
+				    const struct bpf_program *prog)
+{
+	int i;
+
+	if (!obj->nr_programs)
+		return false;
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		if (&obj->programs[i] == prog)
+			return prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	}
+
+	return false;
+}
+
 /* Init the map's fields that depend on kern_btf */
 static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 {
@@ -1102,9 +1118,16 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		if (btf_is_ptr(mtype)) {
 			struct bpf_program *prog;
 
-			prog = st_ops->progs[i];
+			/* Update the value from the shadow type */
+			prog = *(void **)mdata;
+			st_ops->progs[i] = prog;
 			if (!prog)
 				continue;
+			if (!is_valid_st_ops_program(obj, prog)) {
+				pr_warn("struct_ops init_kern %s: member %s is not a struct_ops program\n",
+					map->name, mname);
+				return -ENOTSUP;
+			}
 
 			kern_mtype = skip_mods_and_typedefs(kern_btf,
 							    kern_mtype->type,
@@ -9312,7 +9335,9 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 	return NULL;
 }
 
-/* Collect the reloc from ELF and populate the st_ops->progs[] */
+/* Collect the reloc from ELF, populate the st_ops->progs[], and update
+ * st_ops->data for shadow type.
+ */
 static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
 {
@@ -9426,6 +9451,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 		}
 
 		st_ops->progs[member_idx] = prog;
+
+		/* st_ops->data will be exposed to users, being returned by
+		 * bpf_map__initial_value() as a pointer to the shadow
+		 * type. All function pointers in the original struct type
+		 * should be converted to a pointer to struct bpf_program
+		 * in the shadow type.
+		 */
+		*((struct bpf_program **)(st_ops->data + moff)) = prog;
 	}
 
 	return 0;
@@ -9884,6 +9917,12 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 
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


