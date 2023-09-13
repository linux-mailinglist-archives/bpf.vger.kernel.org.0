Return-Path: <bpf+bounces-9870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891C79DFDB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DE1281E54
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B3179A5;
	Wed, 13 Sep 2023 06:15:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F382A45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:19 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4009172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:18 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58e6c05f529so64492547b3.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585718; x=1695190518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/twNvdph7o8C7N/8hTYJsnndXJEVrCiku6pnMziniOI=;
        b=AT3osPM97KxCf833D/mFwgIAjVfOT+41ETrl9/D2XyqBdfjDGyP4LCfL+Jgd4tWfsI
         Jmih1kke0FOPo/sfWPstJZ2HeRIvF8ECc/eOoJVqADVLrDoePJagu9VG5B76lNLz2dHQ
         YPsQ/CH3wqEM/nLdWKfZOobOROy/6HatE73pLMKNwC5vQ1tn1ixos/7MobJoibGnOxCB
         ZqUc/Hf1bPx+FOgdpXzYlWQhrYpZLCegttzo0Vvv+d2jftlYQNDUNWDhJ5Ib7SjaZqF0
         1zos0OXeiGXeZq9x4fUDluXz0fU43c0Et4mSKNPjLuT3JPRubGqeWC0PGfnfH0M3BWXh
         QvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585718; x=1695190518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/twNvdph7o8C7N/8hTYJsnndXJEVrCiku6pnMziniOI=;
        b=o/5ZEtQYJa6Kax5blzoJCKyIEy0GnMCZzFoDx7d4GkvS4cT/S/g+9u+3MHbUbAHxEn
         VJ/kOofTbdNx3kJqY6nRzeLOXzGzbSe1lVUR/kC5N9kmCxVgqXu2oW8biEVk6SPutR8e
         GJekuYhNO4OrfCsqYe2ZyRsMCFQ7G4yt1TwmcYkN1uimMG82FtIBhpjMMh9YM5pRvDnF
         ggrtcl+NKDw4/BbxQ1TxdFFXDnpjzVF9TH9ehLF8DzhBueQziI7y3OUuvSRgZMAxFPmQ
         B2n3TIqugPvrfHQEWk5kFnn1gLxghpI34MnuNn+Zjeh8YFnZAU2jTXeiNLai5ed3psFA
         kEJA==
X-Gm-Message-State: AOJu0YxMsDYuMuTmlZYZ41CN+vbyN/lNpXbhzdy/SSZm4MdPJspDH0rS
	6I13OP0VyFqLV4zTKZiw8dir12nmTWg=
X-Google-Smtp-Source: AGHT+IFcBOPJRUe3XiTc0Xzd/m15VRK8eNSsWmoEa41XVO3SEz0+teqnzjMGpvUHzXhbfT4pXmUYpA==
X-Received: by 2002:a0d:ebc3:0:b0:583:307d:41bc with SMTP id u186-20020a0debc3000000b00583307d41bcmr1884745ywe.27.1694585717796;
        Tue, 12 Sep 2023 23:15:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:17 -0700 (PDT)
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
Subject: [RFC bpf-next v2 9/9] Comments and debug
Date: Tue, 12 Sep 2023 23:14:49 -0700
Message-Id: <20230913061449.1918219-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 15 +++++++++++++++
 kernel/bpf/syscall.c        |  6 ++++++
 tools/lib/bpf/libbpf.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 845873bc806d..47045b026bec 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -133,6 +133,9 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
+	/* XXX: This ID is not unique across modules. We need to include
+	 * module or module ID as an unique ID.
+	 */
 	value_id = btf_find_by_name_kind(btf, value_name,
 					 BTF_KIND_STRUCT);
 	if (value_id < 0) {
@@ -141,6 +144,9 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 		return;
 	}
 
+	/* XXX: This ID is not unique across modules. We need to include
+	 * module or module ID as an unique ID.
+	 */
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
 	if (type_id < 0) {
@@ -569,6 +575,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
+		/* XXX: Should resolve member types from module BTF, but
+		 * it's not available yet.
+		 */
 		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
@@ -837,6 +846,12 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_map)
 		return ERR_PTR(-ENOMEM);
 
+	/* XXX: should sync with the unregister path */
+	/* XXX: Since we assign a st_ops, we need to do a rcu_synchronize()
+	 *      twice to make sure the st_ops is not freed while other
+	 *      tasks use this value. Or, we can find st_ops again holding
+	 *      the mutex to make sure it is not freed.
+	 */
 	st_map->st_ops = st_ops;
 	map = &st_map->map;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 04d3017b7db1..75c4f0b251a3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1204,6 +1204,10 @@ static int map_create(union bpf_attr *attr)
 		return -EPERM;
 	}
 
+	/* XXX: attr->attach_btf_obj_fd should be initialized by the user
+	 *      space. We should use it to find type infor from
+	 *      attach_btf_id.
+	 */
 	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -2624,6 +2628,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		btf_get(attach_btf);
 	}
 
+
 	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
@@ -4576,6 +4581,7 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		info.btf_value_type_id = map->btf_value_type_id;
 	}
 	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+	/* XXX: copy map->mod_btf->name as well? */
 
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_info_fill(&info, map);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 211889d37320..cd866a30471b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -988,6 +988,7 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
 	 * btf_vmlinux.
 	 */
+	/* XXX: Should search module BTFs as well. */
 	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
 						tname, BTF_KIND_STRUCT);
 	if (kern_vtype_id < 0) {
@@ -5143,6 +5144,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }
 
+int turnon_kk = false;
+
 static void bpf_map__destroy(struct bpf_map *map);
 
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
@@ -7945,13 +7948,32 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
 
 	err = bpf_object__probe_loading(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
+	/* XXX: should correct module btf if needed.
+	 *      obj->btf_vmlinux provides the information of members of
+	 *      the struct_ops type required to load the object.
+	 *      (see bpf_object__init_kern_struct_ops_maps() and
+	 *      bpf_map__init_kern_struct_ops())
+	 */
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__sanitize_maps(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
+	/* XXX: obj->btf_vmliux is not used for loading the object. */
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__create_maps(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__load_progs(obj, extra_log_level);
 	err = err ? : bpf_object_init_prog_arrays(obj);
 	err = err ? : bpf_object_prepare_struct_ops(obj);
@@ -9230,6 +9252,7 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 		 * attach_btf_id and member_idx
 		 */
 		if (!prog->attach_btf_id) {
+			/* XXX: attach_btf_obj_fd is needed as well */
 			prog->attach_btf_id = st_ops->type_id;
 			prog->expected_attach_type = member_idx;
 		}
@@ -13124,7 +13147,9 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 {
 	int i, err;
 
+	printf("Loading BPF skeleton '%s'...\n", s->name);
 	err = bpf_object__load(*s->obj);
+	printf("bpf_object__load\n");
 	if (err) {
 		pr_warn("failed to load BPF skeleton '%s': %d\n", s->name, err);
 		return libbpf_err(err);
@@ -13169,6 +13194,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 		}
 	}
 
+	printf("BPF skeleton '%s' loaded successfully\n", s->name);
 	return 0;
 }
 
-- 
2.34.1


