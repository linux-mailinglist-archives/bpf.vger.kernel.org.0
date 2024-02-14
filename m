Return-Path: <bpf+bounces-21940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F25854160
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086F31C27098
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E198F47;
	Wed, 14 Feb 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc3DQy4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB96138
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876528; cv=none; b=TqS8jBik4aMVZHvHdV1kxV6Lq5/Dku3EUjz8JE+Prn1Y4EUof9dlJwOWnULx6g7FvbgQL/hD1J3JHyUVvBaodUbYAz09G1my8YGp7ZpSe8SxPkkIwq27eCqtVAvgb48DuCqg75Z2MsW8RY0Vf73NcK7/5JbokrQDlsRwdHpKwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876528; c=relaxed/simple;
	bh=cwhTtlpyBvYRzhLElp2zfDAiWmOy3W1GfAhUJ9o0W0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjmbQJdE+tsH3cLh5fNWVz3bBpxUdEx0yVandgIo5aUTXzi2Sdnb4vu+mWBuIhjN4MPYmaG+vPQUuLS3ETrCPjItP6e+dAwI6CvGwzQ61egrZ3X8VmxxPcXwX7yOSfh/ZtvqYSXduhpGjpmqBVqfMgkZmyoaT7HoLIw6PVnCXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc3DQy4z; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso2273792276.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707876525; x=1708481325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySEb+RhEnn7fjRukPpR9W+Dg4RoCgjYlqvoMU8NyNy8=;
        b=Hc3DQy4z5hrD/oC+Dxp3faac19/s0yXM1PobWKuR+PXfBwv09xmIkjZjomsxnXeE9M
         zQKoToYibdbpA7wHB0LEiQr/URpc2UbOj+2QJbfhRnWHRVDg91x0OGERgLI/xReY7si3
         ubdFWItzk8jUOYojPO32uCXGbIUXMX3THWyi7/vTGzxutwRv63b84uqBPJpOzrDVRpHY
         8cX7CHNhsJBMI572Jg89YKONnmZoZTEJdA/0s4uMY4amuCnKturot2RedxbgtWCsZ35s
         mX8nRu41Lu/eCqpd8Ykc+//0zbFJ1rgtzBr8JWd2IWF53LNjnLXeoETuUkmGFAZLB2eS
         6k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707876525; x=1708481325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySEb+RhEnn7fjRukPpR9W+Dg4RoCgjYlqvoMU8NyNy8=;
        b=jEUHQTnqF/pAaKJgydGWwqQ8FhAtK99hdWYVyj62DG5nJxDYEHf+0sSmUgwl4CkdGT
         Sk8PFJvs0eJ5Z2JvctwstCbRkVZes2tOn9B2QWqrs6t53ti02Omon1Uh390mRfPE3edW
         K05e+gUvzr9HMZ5sUSnLW+7RdGwvuhu1UcJBP+8AQDlZ9abTTRmuj+jP3fsmmO8ex/Jv
         gIr1QJnJXIj725AKwJu3PwmfVYGBd3MItmdVHNYnKOXTaQFD/vhW+s+taGY0jtuG2hEp
         FbBkMZM+AWm4Li6+S/NAAGtgZJ3xaV6Ibo5wXFpo4wDC3awKz1uX4xaIuxhUoX9lMtFr
         h/kg==
X-Gm-Message-State: AOJu0Yyf2LdlRIL+SO/rIr2EriU9RVO3kT0N28oRrIRmA5btHUb/PwCN
	GZV+axRcUx1SGopPnyQ3ycDyKQAzJOdjG6IdVvo9zbY9yPNj7+Vjbc0VHEjV
X-Google-Smtp-Source: AGHT+IG1JB+KCod1LOMOYNDUCf/GIvHUTrIN8EWEUZAPV7Ej22tdgeF5Z47bKgp8Y1sieDamzMaTmA==
X-Received: by 2002:a05:6902:2585:b0:dcc:57ff:fb70 with SMTP id du5-20020a056902258500b00dcc57fffb70mr979735ybb.60.1707876525239;
        Tue, 13 Feb 2024 18:08:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/MP+N9Kp/mol27G0QI2Eoz122Nsa0S5aOe6nVKTjI97X/FEgihqlAVuOy1uqi3YOo/zg9bbSLSdWdGHdDR9VKoXFw6uUAhyzv0mza94r4jRZ5jYxgZtESyo4oAjsfPwVCf8giqF8HxgGzbB1KwOB72K0ADcKDWfz2gOYJRUM2o457uNTfZXk0xYp4Fd9hmqZoibwzz93SkRGO9EcjC6vv/KRmJMpY5c4+Lt2AK1/paXUggT1/2g==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:966f:7edc:e6e6:cd97])
        by smtp.gmail.com with ESMTPSA id s17-20020a258311000000b00dc2310abe8bsm1894752ybk.38.2024.02.13.18.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 18:08:44 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 2/3] bpftool: generated shadow variables for struct_ops maps.
Date: Tue, 13 Feb 2024 18:08:35 -0800
Message-Id: <20240214020836.1845354-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214020836.1845354-1-thinker.li@gmail.com>
References: <20240214020836.1845354-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Declares and defines a pointer to a shadow copy for each struct_ops map.

Create shadow info to describe the layout of shadow copies of every
struct_ops map. The shadow info will be passed to libbpf when calling
*__open() of the skeleton.  And, initialize the pointers to shadow copies
created by the libbpf.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/gen.c | 358 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 350 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a9334c57e859..fb5d01dcfe17 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -909,6 +909,281 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
 	}
 }
 
+/* A callback (cb) will be called for each member that can have a shadow of
+ * a map.
+ *
+ * For now, it supports only scalar types and function pointers.
+ */
+static int walk_st_ops_shadow_vars(struct btf *btf,
+				   const char *ident,
+				   const struct bpf_map *map,
+				   int (*cb)(const struct btf *btf,
+					     const char *ident,
+					     const struct btf_member *m,
+					     __u32 member_type_id,
+					     bool func_ptr))
+{
+	const struct btf_type *map_type, *member_type;
+	const struct btf_member *m;
+	__u32 map_type_id, member_type_id;
+	int i, err;
+
+	map_type_id = bpf_map__struct_ops_type(map);
+	if (map_type_id == 0)
+		return -EINVAL;
+	map_type = btf__type_by_id(btf, map_type_id);
+	if (!map_type)
+		return -EINVAL;
+
+	for (i = 0, m = btf_members(map_type);
+	     i < btf_vlen(map_type);
+	     i++, m++) {
+		member_type = skip_mods_and_typedefs(btf, m->type,
+						     &member_type_id);
+		if (!member_type)
+			return -EINVAL;
+
+		switch (btf_kind(member_type)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			/* scalar type */
+			err = cb(btf, ident, m, member_type_id, false);
+			if (err)
+				return err;
+			break;
+
+		case BTF_KIND_PTR:
+			if (resolve_func_ptr(btf, m->type, NULL)) {
+				/* Function pointer */
+				err = cb(btf, ident, m, member_type_id, true);
+				if (err)
+					return err;
+			}
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int gen_st_ops_sahdow_var(const struct btf *btf,
+				 const char *ident,
+				 const struct btf_member *m,
+				 __u32 member_type_id,
+				 bool func_ptr)
+{
+	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
+			    .indent_level = 3,
+			    .strip_mods = false,
+			    );
+	struct btf_dump *d = NULL;
+	int err = 0;
+
+	if (func_ptr) {
+		printf("\t\t\tconst struct bpf_program *%s;\n",
+		       btf__name_by_offset(btf, m->name_off));
+	} else {
+		d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
+		if (!d) {
+			err = -errno;
+			goto out;
+		}
+
+		printf("\t\t\t");
+		opts.field_name = btf__name_by_offset(btf, m->name_off);
+		err = btf_dump__emit_type_decl(d, member_type_id, &opts);
+		if (err)
+			goto out;
+		printf(";\n");
+	}
+
+out:
+	btf_dump__free(d);
+
+	return err;
+}
+
+/* Add a pointer of a shadow copy to the skeleton for a struct_ops map.
+ *
+ * A shadow copy of a struct_ops map is used to store the sahdow variables.
+ * Shadow variables are a mirror of member fields in a struct_ops map
+ * defined in the BPF program. They serve as a way to access and change the
+ * values in the map. For example, in struct bpf_testmod_ops, it defines
+ * three fields: test_1, test_2, and data. And, it defines an instance as
+ * testmod_1 in the program. Then, the skeleton will have three shadow
+ * variables: test_1, test_2, and data in skel->st_ops.testmod_1.
+ *
+ * Now, it doesn't support pointer type fields except function pointers.
+ * For non-function pointer fields, the shadow variables will be in the
+ * same type as the original fields, but all modifiers (const,
+ * volatile,...) are removed.
+ *
+ * For function pointer fields, the shadow variables will be in the "struct
+ * bpf_program *" type.
+ */
+static int gen_st_ops_shadow_copy(struct btf *btf, const char *ident,
+				  const struct bpf_map *map)
+{
+	int err;
+
+	printf("\t\tstruct {\n");
+
+	err = walk_st_ops_shadow_vars(btf, ident, map, gen_st_ops_sahdow_var);
+	if (err)
+		return err;
+
+	printf("\t\t} *%s;\n", ident);
+
+	return 0;
+}
+
+static int gen_st_ops_member_info(const struct btf *btf,
+				  const char *ident,
+				  const struct btf_member *m,
+				  __u32 member_type_id,
+				  bool func_ptr)
+{
+	const char *member_name = btf__name_by_offset(btf, m->name_off);
+
+	codegen("\
+	\n\
+			{						    \n\
+				.name = \"%2$s\",			    \n\
+				.offset = (__u32)(uintptr_t)&((typeof(struct_ops->%1$s))0)->%2$s,\n\
+				.size = sizeof(((typeof(struct_ops->%1$s))0)->%2$s),\n\
+			},						    \n\
+	", ident, member_name);
+
+	return 0;
+}
+
+static int gen_st_ops_member_infos(struct btf *btf, const char *ident,
+				   const struct bpf_map *map)
+{
+	int err;
+
+	printf("\tstatic struct bpf_struct_ops_member_info member_info_%s[] = {\n",
+	       ident);
+
+	err = walk_st_ops_shadow_vars(btf, ident, map,
+				      gen_st_ops_member_info);
+	if (err)
+		return err;
+
+	printf("\t};\n");
+
+	return 0;
+}
+
+static void gen_st_ops_map_info(const char *ident)
+{
+	codegen("\
+		\n\
+			{						    \n\
+				.name = \"%1$s\",			    \n\
+				.members = member_info_%1$s,		    \n\
+				.cnt = ARRAY_SIZE(member_info_%1$s),	    \n\
+				.data_size = sizeof(*struct_ops->%1$s),	    \n\
+			},						    \n\
+		", ident);
+}
+
+/* Generate information of shadow variables for every struct_ops map.
+ *
+ * The shadow information of map includes the name, the offset, and the
+ * size of each supported member field in the struct_ops map to describe
+ * the layout of a shadow copy. The shadow info of struct_ops maps will be
+ * passed to libbpf to create a shadow copy for each struct_ops map.
+ *
+ * For example, in struct_ops_module.c, it defines "testmod_1" in struct
+ * bpf_testmod_ops, which has three fields: test_1, test_2, and data. Then,
+ * the shadow information will be:
+ *
+ * static struct bpf_struct_ops_member_info member_info_testmod_1[] = {
+ *	{
+ *		.name = "test_1",
+ *		.offset = .....,
+ *		.size = .....,
+ *	},
+ *	{
+ *		.name = "test_2",
+ *		.offset = .....,
+ *		.size = .....,
+ *	},
+ *	{
+ *		.name = "data",
+ *		.offset = .....,
+ *		.size = .....,
+ *	},
+ * };
+ * static struct bpf_struct_ops_map_info map_info[] = {
+ *	{
+ *		.name = "testmod_1",
+ *		.members = member_info_testmod_1,
+ *		.cnt = ARRAY_SIZE(member_info_testmod_1),
+ *		.data_size = sizeof(struct_ops->testmod_1),
+ *	},
+ * };
+ * static struct bpf_struct_ops_shadow_info shadow_info = {
+ *	.maps = map_info,
+ *	.cnt = ARRAY_SIZE(map_info),
+ * };
+ *
+ * testmod_1_shadow_info() will return the pointer of "sahdow_info" defined
+ * above.
+ */
+static int gen_st_ops_shadow_info(struct bpf_object *obj, const char *obj_name)
+{
+	struct btf *btf = bpf_object__btf(obj);
+	struct bpf_map *map;
+
+	codegen("\
+		\n\
+		static inline struct bpf_struct_ops_shadow_info *	    \n\
+		%1$s__shadow_info()					    \n\
+		{							    \n\
+			typeof(((struct %1$s *)0)->struct_ops) *struct_ops = NULL;\n\
+		", obj_name);
+	bpf_object__for_each_map(map, obj) {
+		const char *ident = bpf_map__name(map);
+		int err;
+
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+
+		err = gen_st_ops_member_infos(btf, ident, map);
+		if (err)
+			return err;
+	}
+	printf("\tstatic struct bpf_struct_ops_map_info map_info[] = {\n");
+	bpf_object__for_each_map(map, obj) {
+		const char *ident = bpf_map__name(map);
+
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+
+		gen_st_ops_map_info(ident);
+	}
+	codegen("\
+		\n\
+			};						    \n\
+			static struct bpf_struct_ops_shadow_info shadow_info = {\n\
+				.maps = map_info,			    \n\
+				.cnt = ARRAY_SIZE(map_info),		    \n\
+			};						    \n\
+		\n\
+			return &shadow_info;				    \n\
+		}							    \n\
+		\n");
+
+	return 0;
+}
+
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
@@ -923,6 +1198,7 @@ static int do_skeleton(int argc, char **argv)
 	struct bpf_map *map;
 	struct btf *btf;
 	struct stat st;
+	int st_ops_cnt = 0;
 
 	if (!REQ_ARGS(1)) {
 		usage();
@@ -1048,8 +1324,33 @@ static int do_skeleton(int argc, char **argv)
 				printf("\t\tstruct bpf_map_desc %s;\n", ident);
 			else
 				printf("\t\tstruct bpf_map *%s;\n", ident);
+			if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+				st_ops_cnt++;
 		}
 		printf("\t} maps;\n");
+		if (st_ops_cnt) {
+			/* Generate the pointers to shadow copies of
+			 * struct_ops maps.
+			 */
+			btf = bpf_object__btf(obj);
+			if (!btf) {
+				err = -1;
+				p_err("need btf type information for %s", obj_name);
+				goto out;
+			}
+
+			printf("\tstruct {\n");
+			bpf_object__for_each_map(map, obj) {
+				if (!get_map_ident(map, ident, sizeof(ident)))
+					continue;
+				if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+					continue;
+				err = gen_st_ops_shadow_copy(btf, ident, map);
+				if (err)
+					goto out;
+			}
+			printf("\t} struct_ops;\n");
+		}
 	}
 
 	if (prog_cnt) {
@@ -1075,12 +1376,9 @@ static int do_skeleton(int argc, char **argv)
 		printf("\t} links;\n");
 	}
 
-	btf = bpf_object__btf(obj);
-	if (btf) {
-		err = codegen_datasecs(obj, obj_name);
-		if (err)
-			goto out;
-	}
+	err = codegen_datasecs(obj, obj_name);
+	if (err)
+		goto out;
 	if (use_loader) {
 		err = gen_trace(obj, obj_name, header_guard);
 		goto out;
@@ -1099,7 +1397,17 @@ static int do_skeleton(int argc, char **argv)
 			static inline const void *elf_bytes(size_t *sz);    \n\
 		#endif /* __cplusplus */				    \n\
 		};							    \n\
-									    \n\
+		\n\
+		", obj_name);
+
+	if (st_ops_cnt) {
+		err = gen_st_ops_shadow_info(obj, obj_name);
+		if (err)
+			goto out;
+	}
+
+	codegen("\
+		\n\
 		static void						    \n\
 		%1$s__destroy(struct %1$s *obj)				    \n\
 		{							    \n\
@@ -1133,6 +1441,24 @@ static int do_skeleton(int argc, char **argv)
 			if (err)					    \n\
 				goto err_out;				    \n\
 									    \n\
+		", obj_name);
+	if (st_ops_cnt) {
+		/* Initialize the pointers of struct_ops shadow copies */
+		bpf_object__for_each_map(map, obj) {
+			if (!get_map_ident(map, ident, sizeof(ident)))
+				continue;
+			if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+				continue;
+			codegen("\
+				\n\
+					obj->struct_ops.%1$s =		    \n\
+						bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
+				\n\
+				", ident);
+		}
+	}
+	codegen("\
+		\n\
 			return obj;					    \n\
 		err_out:						    \n\
 			%1$s__destroy(obj);				    \n\
@@ -1143,7 +1469,23 @@ static int do_skeleton(int argc, char **argv)
 		static inline struct %1$s *				    \n\
 		%1$s__open(void)					    \n\
 		{							    \n\
-			return %1$s__open_opts(NULL);			    \n\
+		", obj_name);
+	if (st_ops_cnt)
+		codegen("\
+			\n\
+				DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);\n\
+			\n\
+				opts.struct_ops_shadow = %1$s__shadow_info();\n\
+			\n\
+				return %1$s__open_opts(&opts);	     \n\
+			", obj_name);
+	else
+		codegen("\
+			\n\
+				return %1$s__open_opts(NULL);		     \n\
+			", obj_name);
+	codegen("\
+		\n\
 		}							    \n\
 									    \n\
 		static inline int					    \n\
-- 
2.34.1


