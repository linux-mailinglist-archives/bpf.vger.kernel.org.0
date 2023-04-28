Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175466F20C9
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbjD1W2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 18:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjD1W2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 18:28:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221EA3584
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 15:28:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a5197f00e9so4032695ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682720890; x=1685312890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amKhIgBsjaTREOkegPKlL8n2EOYyZZTYliZAVqjO+DM=;
        b=aGAaUw8j/39O76gOXZSTIFzHH+6zvkbgrI4tFr5cYsHtEvf3GYSEMrtxm1GtS/dGL+
         0d7LHxDi25DHthv0wB6atXY22IpELvixW3PfZc+AhNpNh3422A8Zuym0VsxDYE1H/nDq
         dgacyWtzf+XOYrcmnKjYBtw3YXtYbrhBge/Y2rKa3qBWXD7Ei+fwNZzXigQ2aHS+H5Bb
         Wc8PYJQw5GUR6GNPVbF/W6O44mB1LQV6o4Wy+FTaa9DXE26qeR6Wthl9NJ3ggPCQxQXm
         AJ3TmrNDWkGBK4ORul6qsW1ijRtRA+WTnblv2lfS4ROpSTCJBsgdwbHQv/BjphGBwSal
         rxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720890; x=1685312890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amKhIgBsjaTREOkegPKlL8n2EOYyZZTYliZAVqjO+DM=;
        b=fX8ZyJXABqTYTVQBdU6iW0az5yu4c2YBIkQxH5AB5V0PNw93aDjvVrC68+sHxXVk4G
         79qGBHsmZxcQF3iB1N8iXz4X6X/WrsanZcrTde3q67vdgd3ZIxSvnY4VQLBSwok9lD6i
         WLLZh+2XMPYvjtXTfxhRdY8zJ+5caBs5TLfvgI14XALg5XgH0hlYYfvFcTs4XG4pe8jw
         kqVGgEEHwdrlxdcoyrPBVsx+tpzpi5uiwgWl5HGdsri37Q892t0mrbSq2O9WcsOaZHSv
         dwnnJgWW7f8fPCBLbMR6Jv4FfsKwPWSuHzv4vAs5Sn0DeOyAyeGR+tLdI9ChocTHSlt1
         jOLQ==
X-Gm-Message-State: AC+VfDz/0SmfmzaGyqQH7wTPqIM0+Hf3HkMBk/ymVqH7y847yocvg/VK
        JBss2iUIrv7vbylT9CSW9rg2AEuq3oE=
X-Google-Smtp-Source: ACHHUZ745YFCDnWFK1WlDcVcUNftqxJjR0T/caAYdQubWXCv+Bl6ZAaaTYsx42XSPXGt/8COhWWYHQ==
X-Received: by 2002:a17:902:db03:b0:1a6:e1ac:ecb8 with SMTP id m3-20020a170902db0300b001a6e1acecb8mr8684403plx.43.1682720890447;
        Fri, 28 Apr 2023 15:28:10 -0700 (PDT)
Received: from toolbox.. ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id ba11-20020a170902720b00b001a63ba28052sm10465738plb.69.2023.04.28.15.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:28:09 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: add capability for resizing datasec maps
Date:   Fri, 28 Apr 2023 15:27:53 -0700
Message-Id: <20230428222754.183432-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428222754.183432-1-inwardvessel@gmail.com>
References: <20230428222754.183432-1-inwardvessel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch updates bpf_map__set_value_size() so that if the given map is a
datasec, it will attempt to resize it. If the following criteria is met,
the resizing can be performed:
 - BTF info is present
 - the map is a datasec
 - the datasec contains a single variable
 - the single variable is an array

The new map_datasec_resize() function is used to perform the resizing
of the associated memory mapped region and adjust BTF so that the original
array variable points to a new BTF array that is sized to cover the
requested size. The new array size will be rounded up to a multiple of
the element size.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 tools/lib/bpf/libbpf.c | 138 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1cbacf9e71f3..991649cacc10 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9412,12 +9412,150 @@ __u32 bpf_map__value_size(const struct bpf_map *map)
 	return map->def.value_size;
 }
 
+static bool map_is_datasec(struct bpf_map *map)
+{
+	struct btf *btf;
+	struct btf_type *map_type;
+
+	btf = bpf_object__btf(map->obj);
+	if (!btf)
+		return false;
+
+	map_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
+
+	return btf_is_datasec(map_type);
+}
+
+static int map_datasec_resize(struct bpf_map *map, __u32 size)
+{
+	int err;
+	struct btf *btf;
+	struct btf_type *datasec_type, *var_type, *resolved_type, *array_element_type;
+	struct btf_var_secinfo *var;
+	struct btf_array *array;
+	__u32 resolved_id, new_array_id;
+	__u32 rounded_sz;
+	__u32 nr_elements;
+	__u32 old_value_sz = map->def.value_size;
+	size_t old_mmap_sz, new_mmap_sz;
+
+	/* btf is required and datasec map must be memory mapped */
+	btf = bpf_object__btf(map->obj);
+	if (!btf) {
+		pr_warn("cannot resize datasec map '%s' while btf info is not present\n",
+				bpf_map__name(map));
+
+		return -EINVAL;
+	}
+
+	datasec_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
+	if (!btf_is_datasec(datasec_type)) {
+		pr_warn("attempted to resize datasec map '%s' but map is not a datasec\n",
+				bpf_map__name(map));
+
+		return -EINVAL;
+	}
+
+	if (!map->mmaped) {
+		pr_warn("cannot resize datasec map '%s' while map is unexpectedly not memory mapped\n",
+				bpf_map__name(map));
+
+		return -EINVAL;
+	}
+
+	/* datasec must only have a single variable */
+	if (btf_vlen(datasec_type) != 1) {
+		pr_warn("cannot resize datasec map '%s' that does not consist of a single var\n",
+				bpf_map__name(map));
+
+		return -EINVAL;
+	}
+
+	/* the single variable has to be an array */
+	var = btf_var_secinfos(datasec_type);
+	resolved_id = btf__resolve_type(btf, var->type);
+	resolved_type = btf_type_by_id(btf, resolved_id);
+	if (!btf_is_array(resolved_type)) {
+		pr_warn("cannot resize datasec map '%s' whose single var is not an array\n",
+				bpf_map__name(map));
+
+		return -EINVAL;
+	}
+
+	/* create a new array based on the existing array but with new length,
+	 * rounding up the requested size for alignment
+	 */
+	array = btf_array(resolved_type);
+	array_element_type = btf_type_by_id(btf, array->type);
+	rounded_sz = roundup(size, array_element_type->size);
+	nr_elements = rounded_sz / array_element_type->size;
+	new_array_id = btf__add_array(btf, array->index_type, array->type,
+			nr_elements);
+	if (new_array_id < 0) {
+		pr_warn("failed to resize datasec map '%s' due to failure in creating new array\n",
+				bpf_map__name(map));
+		err = new_array_id;
+
+		goto fail_array;
+	}
+
+	/* adding a new btf type invalidates existing pointers to btf objects.
+	 * refresh pointers before proceeding
+	 */
+	datasec_type = btf_type_by_id(btf, map->btf_value_type_id);
+	var = btf_var_secinfos(datasec_type);
+	var_type = btf_type_by_id(btf, var->type);
+
+	/* remap the associated memory */
+	old_value_sz = map->def.value_size;
+	old_mmap_sz = bpf_map_mmap_sz(map);
+	map->def.value_size = rounded_sz;
+	new_mmap_sz = bpf_map_mmap_sz(map);
+
+	if (munmap(map->mmaped, old_mmap_sz)) {
+		err = -errno;
+		pr_warn("failed to resize datasec map '%s' due to failure in munmap(), err:%d\n",
+			 bpf_map__name(map), err);
+
+		goto fail_mmap;
+	}
+
+	map->mmaped = mmap(NULL, new_mmap_sz, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (map->mmaped == MAP_FAILED) {
+		err = -errno;
+		map->mmaped = NULL;
+		pr_warn("failed to resize datasec map '%s' due to failure in mmap(), err:%d\n",
+			 bpf_map__name(map), err);
+
+		goto fail_mmap;
+	}
+
+	/* finally update btf info */
+	datasec_type->size = var->size = rounded_sz;
+	var_type->type = new_array_id;
+
+	return 0;
+
+fail_mmap:
+	map->def.value_size = old_value_sz;
+
+fail_array:
+	return err;
+}
+
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
 	if (map->fd >= 0)
 		return libbpf_err(-EBUSY);
+
+	if (map_is_datasec(map))
+		return map_datasec_resize(map, size);
+
 	map->def.value_size = size;
+
 	return 0;
+
 }
 
 __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
-- 
2.40.0

