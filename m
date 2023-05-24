Return-Path: <bpf+bounces-1142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BE70EA6C
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8461B28105D
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399AC15A3;
	Wed, 24 May 2023 00:45:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33D1380
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:45:50 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED8CD
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:45:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so135161b3a.3
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684889148; x=1687481148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ry/uH/EREVSo10di6T/Feeqcr6T7kTp7Sm3zbdct/g=;
        b=VS9Z5N6fQ68qJb2Hgx3p4E4oa7I0XuTHwapN3NukgYmFcPOrS3ymD6Nd5R4qV7TZ+N
         JvY/MKtag+AGwhiZlOdo+IpOWmZDukI4QLOivZk6X635cXWr1jTTkXDhogFQqvCnaAc3
         Z+6qL++UlyVcHpf1D/+MZJHPzESaHLkz2puoaxAJDxrg5VyWic2MnUOXj5tPTVDxpm+E
         YrD+ueLQz1XXCJm0/NA14JX0A+VH6MMEBzfZB5ETxtlxDM7TKcOqfWU/1i4MuM2jnOt1
         q0uBjRzGeELKrsHZdMLRidPdEKKQupI6qqCaoZwuSTKIUFL+xWWINx1jbJDWPp7w4Hw2
         OPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684889148; x=1687481148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ry/uH/EREVSo10di6T/Feeqcr6T7kTp7Sm3zbdct/g=;
        b=AchwIs7DlSYcCf8WJb7OIiKqZUDVPYmcYos2QovRt/D/Ik4mwb+v0gz4o3LV+Lgarf
         debBhmVw5MhohBRhj1piWkJV2HXLk1crgwJHsc8GRFxNtgjDRyUilkRAlZ0Xqk5qsOhn
         awK2thtSyC4lmVqFkuclh0Ao7iNEpCxqEUuhtR1NpluJLfRxg9yhaSaboGeV4iusJ/PR
         VUCmxw0ZysMipq+xO+VLhtS1wH5JRwyHINkb2wzsZ56J65mjgYWM09zJnFGI8YIbkbPr
         JAe/PJvliJLjyL6gMea0/E6JKXFsVIaJTPLK8+mDZS25zCsTR2oqIg1tnR+KIWzX19Qn
         m6Ew==
X-Gm-Message-State: AC+VfDxYTDneagmPLSel+kExYuDIKtPusJjMwH6qXUvVKHJ1jU2DEHFP
	+xK0txR2HXf8FTfIznYHiHsNNfET9wgMgg==
X-Google-Smtp-Source: ACHHUZ4QwN0t6heUhJyIQ+rtJalo/l5SWwEBrRgmT2TerkovCL5zMkm2ulodXCwWj7jbPeSW8E2nqw==
X-Received: by 2002:a17:902:a589:b0:1ad:dd21:2691 with SMTP id az9-20020a170902a58900b001addd212691mr17180985plb.10.1684889148471;
        Tue, 23 May 2023 17:45:48 -0700 (PDT)
Received: from toolbox.. ([98.42.24.125])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001a673210cf4sm7399292plg.74.2023.05.23.17.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:45:48 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com,
	inwardvessel@gmail.com,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 1/2] libbpf: add capability for resizing datasec maps
Date: Tue, 23 May 2023 17:45:36 -0700
Message-Id: <20230524004537.18614-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524004537.18614-1-inwardvessel@gmail.com>
References: <20230524004537.18614-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch updates bpf_map__set_value_size() so that if the given map is
memory mapped, it will attempt to resize the mapped region. Initial
contents of the mapped region are preserved. BTF is not required, but
after the mapping is resized an attempt is made to adjust the associated
BTF information if the following criteria is met:
 - BTF info is present
 - the map is a datasec
 - the final variable in the datasec is an array

... the resulting BTF info will be updated so that the final array
variable is associated with a new BTF array type sized to cover the
requested size.

Note that the initial resizing of the memory mapped region can succeed
while the subsequent BTF adjustment can fail. In this case, BTF info is
dropped from the map by clearing the key and value type.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 130 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  17 +++++-
 2 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..0bd0419e9f56 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1510,6 +1510,37 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	return map_sz;
 }
 
+static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
+{
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t map_sz;
+
+	map_sz = (size_t)roundup(value_sz, 8) * max_entries;
+	map_sz = roundup(map_sz, page_sz);
+	return map_sz;
+}
+
+static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz)
+{
+	void *mmaped;
+
+	if (!map->mmaped)
+		return -EINVAL;
+
+	if (old_sz == new_sz)
+		return 0;
+
+	mmaped = mmap(NULL, new_sz, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (mmaped == MAP_FAILED)
+		return -errno;
+
+	memcpy(mmaped, map->mmaped, min(old_sz, new_sz));
+	munmap(map->mmaped, old_sz);
+	map->mmaped = mmaped;
+	return 0;
+}
+
 static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 {
 	char map_name[BPF_OBJ_NAME_LEN], *p;
@@ -9412,10 +9443,109 @@ __u32 bpf_map__value_size(const struct bpf_map *map)
 	return map->def.value_size;
 }
 
+static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
+{
+	struct btf *btf;
+	struct btf_type *datasec_type, *var_type;
+	struct btf_var_secinfo *var;
+	const struct btf_type *array_type;
+	const struct btf_array *array;
+	int vlen;
+	__u32 nr_elements, new_array_id;
+	__s64 element_sz;
+
+	/* check btf existence */
+	btf = bpf_object__btf(map->obj);
+	if (!btf)
+		return -ENOENT;
+
+	/* verify map is datasec */
+	datasec_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
+	if (!btf_is_datasec(datasec_type)) {
+		pr_warn("map '%s': cannot be resized, map value type is not a datasec\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* verify datasec has at least one var */
+	vlen = btf_vlen(datasec_type);
+	if (vlen == 0) {
+		pr_warn("map '%s': cannot be resized, map value datasec is empty\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* verify last var in the datasec is an array */
+	var = &btf_var_secinfos(datasec_type)[vlen - 1];
+	var_type = btf_type_by_id(btf, var->type);
+	array_type = skip_mods_and_typedefs(btf, var_type->type, NULL);
+	if (!btf_is_array(array_type)) {
+		pr_warn("map '%s': cannot be resized, last var must be array\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* verify request size aligns with array */
+	array = btf_array(array_type);
+	element_sz = btf__resolve_size(btf, array->type);
+	if (element_sz == 0)
+		return -EINVAL;
+	if ((size - var->offset) % element_sz != 0) {
+		pr_warn("map '%s': cannot be resized, requested size does not align\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* create a new array based on the existing array,
+	 * but with new length
+	 */
+	nr_elements = (size - var->offset) / element_sz;
+	new_array_id = btf__add_array(btf, array->index_type, array->type,
+			nr_elements);
+	if (new_array_id < 0)
+		return new_array_id;
+
+	/* adding a new btf type invalidates existing pointers to btf objects,
+	 * so refresh pointers before proceeding
+	 */
+	datasec_type = btf_type_by_id(btf, map->btf_value_type_id);
+	var = &btf_var_secinfos(datasec_type)[vlen - 1];
+	var_type = btf_type_by_id(btf, var->type);
+
+	/* finally update btf info */
+	datasec_type->size = size;
+	var->size = size - var->offset;
+	var_type->type = new_array_id;
+
+	return 0;
+}
+
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
 	if (map->fd >= 0)
 		return libbpf_err(-EBUSY);
+
+	if (map->mmaped) {
+		int err;
+		size_t mmap_old_sz, mmap_new_sz;
+
+		mmap_old_sz = bpf_map_mmap_sz(map);
+		mmap_new_sz = __bpf_map_mmap_sz(size, map->def.max_entries);
+		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
+		if (err) {
+			pr_warn("map '%s': failed to resize memory mapped region\n",
+					bpf_map__name(map));
+			return err;
+		}
+		err = map_btf_datasec_resize(map, size);
+		if (err && err != -ENOENT) {
+			pr_warn("map '%s': failed to adjust btf for resized map, clearing btf key/value type info\n",
+					bpf_map__name(map));
+			map->btf_value_type_id = 0;
+			map->btf_key_type_id = 0;
+		}
+	}
+
 	map->def.value_size = size;
 	return 0;
 }
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0b7362397ea3..137459803803 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -869,8 +869,23 @@ LIBBPF_API int bpf_map__set_numa_node(struct bpf_map *map, __u32 numa_node);
 /* get/set map key size */
 LIBBPF_API __u32 bpf_map__key_size(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_key_size(struct bpf_map *map, __u32 size);
-/* get/set map value size */
+/* get map value size */
 LIBBPF_API __u32 bpf_map__value_size(const struct bpf_map *map);
+/**
+ * @brief **bpf_map__set_value_size()** sets map value size.
+ *
+ * There is a special case for maps with associated memory-mapped regions, like
+ * the global data section maps (bss, data, rodata). When this function is used
+ * on such a map, the mapped region is resized. Afterward, an attempt is made to
+ * adjust the corresponding BTF info. This attempt is best-effort and can only
+ * succeed if the last variable of the data section map is an array. The array
+ * BTF type is replaced by a new BTF array type with a different length.
+ * Because BTF info is modified to do this, pointer invalidation occurs. Any
+ * previously existing pointers returned from bpf_map__initial_value() or
+ * skeleton pointers must be reinitialized.
+ * @param map the BPF map instance
+ * @return 0, on success; negative error, otherwise
+ */
 LIBBPF_API int bpf_map__set_value_size(struct bpf_map *map, __u32 size);
 /* get map key/value BTF type IDs */
 LIBBPF_API __u32 bpf_map__btf_key_type_id(const struct bpf_map *map);
-- 
2.40.0


