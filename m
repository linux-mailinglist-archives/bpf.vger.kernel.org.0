Return-Path: <bpf+bounces-315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B96FE73E
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 00:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5173E1C208FD
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2718C23;
	Wed, 10 May 2023 22:33:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167342F23
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 22:33:54 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5932691
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:33:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aafa41116fso54698735ad.1
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683758032; x=1686350032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GMPiUiQkPt+90ew8W+UNhD+ztJGeV5OqPLpSurjmbk=;
        b=H+NCULFA1Wbb9xgCGxEXlHVM7TKBaAa2EhOi/HG1rrvyBPxLbO/9GSV0PvL+2iMNkw
         qOmu258TPkwKyDi94yq84/JuOdDfPKmsimSQtkLXgM37pTWheiL9y/Np/C9EjErwF8se
         VioCuUHcdLqfuNztksZg6WWDwsJWLPm3/18bTD8twXuQAiCORwdnXKgNIHER737yew6+
         P069S0ThYWY2qyJAQtVGuPXsbGFVDXrK/H0jHUDEOdks2iIEBYCgsuKmCSGVOpW9xmyn
         Rz6P8qEJE+xdHYPk8jvx07OEJ7wKXN2TrQ92UDA46lKiLz84FCeKFiMtBviCS7/lyzmz
         FhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683758032; x=1686350032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GMPiUiQkPt+90ew8W+UNhD+ztJGeV5OqPLpSurjmbk=;
        b=GMUYbYrL2iOzsOm3eCNpBb7C9wmSlPLv6OfnuSfvYslULlqBifI61KJspgEhnjOtHW
         HPM8LdhUplFWDijynmdlGsIJL4g3j++eI4ACZBFzw+/JKYEyz+mOb7YWn/P7kddLOUqn
         QF0TUkYcDOoCSk/xvaN2H6zhXCdSubtKANiJTHEQYw9b8xNi4qnRSzBt+1RyzYJnJZtm
         wIslTLzhuToU2jD9/Z/yW1+f3xvsmOqD93XuQc4nz+X7ubHosdi9M2D8x/kZiOpkns2j
         b0rwx1jHbIEqQbT8ZOqitwWyHNboH6oBmEEH/zIsXy5xVRQuAS0jtxCsradb6Cha1csl
         Ouxw==
X-Gm-Message-State: AC+VfDwHPMW4E58hinUk2tE9fcKEzRwmhw3qWV6ZyMmeo/YLZASObSgm
	Vig3XCdaTWKBg/LnS50s7EdMWNgO5t8=
X-Google-Smtp-Source: ACHHUZ7BMCeXE4bYILq75HtB3dSEwgCp9u1hQmVkmvp7Yxgpx7Lz59B5xmQmV4EzmXv7dtkboHPHyw==
X-Received: by 2002:a17:902:ab08:b0:1a6:ebc1:c54d with SMTP id ik8-20020a170902ab0800b001a6ebc1c54dmr16112607plb.30.1683758031722;
        Wed, 10 May 2023 15:33:51 -0700 (PDT)
Received: from toolbox.. ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001ab12ccc2a7sm4308891plp.98.2023.05.10.15.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:33:51 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com,
	inwardvessel@gmail.com
Subject: [PATCH v2 bpf-next 1/2] libbpf: add capability for resizing datasec maps
Date: Wed, 10 May 2023 15:33:41 -0700
Message-Id: <20230510223342.12886-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510223342.12886-1-inwardvessel@gmail.com>
References: <20230510223342.12886-1-inwardvessel@gmail.com>
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
---
 tools/lib/bpf/libbpf.c | 158 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1cbacf9e71f3..50cfe2bd4ba0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1510,6 +1510,39 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	return map_sz;
 }
 
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
+		return libbpf_err(-errno);
+
+	/* copy pre-existing contents to new region,
+	 * using the minimum of old/new size
+	 */
+	memcpy(mmaped, map->mmaped, min(old_sz, new_sz));
+
+	if (munmap(map->mmaped, old_sz)) {
+		pr_warn("map '%s': failed to unmap\n", bpf_map__name(map));
+		if (munmap(mmaped, new_sz))
+			pr_warn("map '%s': failed to unmap temp region\n",
+					bpf_map__name(map));
+		return libbpf_err(-errno);
+	}
+
+	map->mmaped = mmaped;
+
+	return 0;
+}
+
 static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 {
 	char map_name[BPF_OBJ_NAME_LEN], *p;
@@ -9412,12 +9445,135 @@ __u32 bpf_map__value_size(const struct bpf_map *map)
 	return map->def.value_size;
 }
 
+static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
+{
+	int err;
+	int i, vlen;
+	struct btf *btf;
+	const struct btf_type *array_type, *array_element_type;
+	struct btf_type *datasec_type, *var_type;
+	struct btf_var_secinfo *var;
+	const struct btf_array *array;
+	__u32 offset, nr_elements, new_array_id;
+
+	/* check btf existence */
+	btf = bpf_object__btf(map->obj);
+	if (!btf)
+		return -ENOENT;
+
+	/* verify map is datasec */
+	datasec_type = btf_type_by_id(btf, bpf_map__btf_value_type_id(map));
+	if (!btf_is_datasec(datasec_type)) {
+		pr_warn("map '%s': attempted to resize but map is not a datasec\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* verify datasec has at least one var */
+	vlen = btf_vlen(datasec_type);
+	if (vlen == 0) {
+		pr_warn("map '%s': attempted to resize but map vlen == 0\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* walk to the last var in the datasec,
+	 * increasing the offset as we pass each var
+	 */
+	var = btf_var_secinfos(datasec_type);
+	offset = 0;
+	for (i = 0; i < vlen - 1; i++) {
+		offset += var->size;
+		var++;
+	}
+
+	/* verify last var in the datasec is an array */
+	var_type = btf_type_by_id(btf, var->type);
+	array_type = skip_mods_and_typedefs(btf, var_type->type, NULL);
+	if (!btf_is_array(array_type)) {
+		pr_warn("map '%s': cannot be resized last var must be array\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* verify request size aligns with array */
+	array = btf_array(array_type);
+	array_element_type = btf_type_by_id(btf, array->type);
+	if ((size - offset) % array_element_type->size != 0) {
+		pr_warn("map '%s': attempted to resize but requested size does not align\n",
+				bpf_map__name(map));
+		return -EINVAL;
+	}
+
+	/* create a new array based on the existing array,
+	 * but with new length
+	 */
+	nr_elements = (size - offset) / array_element_type->size;
+	new_array_id = btf__add_array(btf, array->index_type, array->type,
+			nr_elements);
+	if (new_array_id < 0) {
+		pr_warn("map '%s': failed to create new array\n",
+				bpf_map__name(map));
+		err = new_array_id;
+		return err;
+	}
+
+	/* adding a new btf type invalidates existing pointers to btf objects,
+	 * so refresh pointers before proceeding
+	 */
+	datasec_type = btf_type_by_id(btf, map->btf_value_type_id);
+	var = btf_var_secinfos(datasec_type);
+	for (i = 0; i < vlen - 1; i++)
+		var++;
+	var_type = btf_type_by_id(btf, var->type);
+
+	/* finally update btf info */
+	datasec_type->size = size;
+	var->size = size - offset;
+	var_type->type = new_array_id;
+
+	return 0;
+}
+
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
+	int err;
+	__u32 old_size;
+
 	if (map->fd >= 0)
 		return libbpf_err(-EBUSY);
-	map->def.value_size = size;
+
+	old_size = map->def.value_size;
+
+	if (map->mmaped) {
+		size_t mmap_old_sz, mmap_new_sz;
+
+		mmap_old_sz = bpf_map_mmap_sz(map);
+		map->def.value_size = size;
+		mmap_new_sz = bpf_map_mmap_sz(map);
+
+		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
+		if (err) {
+			pr_warn("map '%s': failed to resize memory mapped region\n",
+					bpf_map__name(map));
+			goto err_out;
+		}
+		err = map_btf_datasec_resize(map, size);
+		if (err && err != -ENOENT) {
+			pr_warn("map '%s': failed to adjust btf for resized map. dropping btf info\n",
+					bpf_map__name(map));
+			map->btf_value_type_id = 0;
+			map->btf_key_type_id = 0;
+		}
+	} else {
+		map->def.value_size = size;
+	}
+
 	return 0;
+
+err_out:
+	map->def.value_size = old_size;
+	return libbpf_err(err);
 }
 
 __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
-- 
2.40.0


