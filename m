Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF05AC675
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiIDUmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiIDUmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62F2CE0F
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kk26so13420406ejc.11
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XTV2jo8xb7qAQaOJs3VoJkEatZmdDpLuqYMTY4nwlhc=;
        b=qq5GvdYBIsY8DiRqzSyRM1QSf7nNKOILWlnbWU4FU9khKFZB7/v35kh10AkAuYaLHy
         WgKdXXWC+XOjskECScbSCOQkc1z8GQjh83s5xb8Dz8HvqBbo3dUm1xH35/mb0pa2Z1Io
         +jZE5sN2TgtrU1f82IV2NmqeQw4Ut3ndO4v+GKno5pviWgtiZ438rKDeq/j89un/9nLc
         YUH1mL8O2cTCdDKAEVl9VsFMtEi7MdAfSIIPptHg53YFKHT4/sQEBjaVkddaVnDVZVs+
         b/jwl/7H0NKpxFpoEEO8WEuugS108locvP1yk3lTA4+9O+7Rdy01GoolUzy6r8odm7tm
         i1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XTV2jo8xb7qAQaOJs3VoJkEatZmdDpLuqYMTY4nwlhc=;
        b=1YWMdaHzQQUs2WzJA4Br09PdkOdQ6Oax7XLem7WDE0VNCJ9H54dj0WML4afLq32ErR
         g5VXMgxDRyIMMxPmRPZpFSmYBqaeGNEPqULVtqa0KCikG0efXDxPhmk4d1DX2MUfxWFV
         EjUY0+KkA8BWK2MYHxTv4QA9a7eJRXR6PjiHwnKJ1Hayv0n2b/Kpa+1CBFjPsTA5xh75
         X6ifFnR5yz8jz6sJuu2A6k+DhChS3bEbtCjwtuyQJOrYa1zcrD31btQOFq3JTsbMjC9Y
         aMC+HbEpeHmO2VIQzMrm6HYFRbV5xvWmca7YAz1glCfXHs9EGo9kwNrDTVuEGFMpBh4J
         jYsQ==
X-Gm-Message-State: ACgBeo0d82r1aCmroUTFM6DLdYEl/Oem05G64EKRlAgsjbtFlfgBrcMf
        OUmjn6hcpdXKNyuRTLVPq3utEshjWy0Ljg==
X-Google-Smtp-Source: AA6agR4DXcFL9yXM8jPV7m8bOlZ1L+5nvWNbdbHve8CuCIaO6gjnIi1xu7gmg+ACj1yiWGFeBfxA4g==
X-Received: by 2002:a17:907:9484:b0:738:6f9f:6032 with SMTP id dm4-20020a170907948400b007386f9f6032mr33997463ejc.602.1662324127221;
        Sun, 04 Sep 2022 13:42:07 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id eg46-20020a05640228ae00b0044e7862ab3fsm1254048edb.7.2022.09.04.13.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:06 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 17/32] bpf: Support bpf_list_node in local kptrs
Date:   Sun,  4 Sep 2022 22:41:30 +0200
Message-Id: <20220904204145.3089-18-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14495; i=memxor@gmail.com; h=from:subject; bh=hUv8NsdzC+PNrlRt8xHRUqFOMzi5g+Fep/ZsZtqVUOc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wVDJisPre+a+QzuWkfzGrzhdQ6X0w2EIMGP+T q4CJS4uJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RyukFD/ 98hLDJ7zA5TMunTZNNNqWYbVenC6w0xbCERREeoD2DxBH8qv+kTkh3RCTyuLiB1N2qV078L/LnlAeg tYywhPNn1zHpZoOtolxQdmnQ1Qgdph/UEONugv2t/xKPT3djTsyF4q3xUuitWwYgVld5RvBX47FpoH 8cI7eI/7flc63Mse+vgec+JvCXoJgJYQB4ZaKG3L1Dxd3HBbKm+cCpyyVYCgdbQ/uX79oOYo65MOZS gxgXtvCTTjSLHyxh8Nq4nF27BUtvaL1AjCdFi8P8bwmntUjel+xnJEPiLGI90fqeUfrxbFRVyZqD6C TbRudGLfCxWqkE4NbgT98Qn19b+jksgtvbOF2Y/9uSLZDl21jcQvTu8m2+W2rJWQdF9PTi6vi+rVI7 bRvTFMnUlsjm7T3Q3s+rBMS2R4QGT9IJrUxkcGuKMqUXcVod7ESeVJkCIcj5I037STPxRWQXpChFM0 aaayFJ3HF6ek6W0cdeXs81hB2fTvZOG01dnt3nRa0j5xtkJLqBFTqI2it9KjCceDPEyuTHgi+j9ROQ lP3lzfpuF/Or3k7Kn3iWHlR050qOEZ/GsHYDLrhr2ICvUNX8/BMOs9OachACggJl9I67hJWl9qHJBv nUldYefXKi/xvEbP/onv4DejYp0UXEwk2UT4hldLuYJ0BdOA4b98CV5qALAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

To allow a user to link their kptr allocated node into a linked list, we
must have a linked list node type that is recognized by the verifier fit
for this purpose. Its name and offset will be matched with the
specification on the bpf_list_head it is being added to. This would
allow precise verification and type safety in BPF programs.

Since bpf_list_node does not correspond to local type, but it is
embedded in a local type (i.e. a type present in program BTF, not kernel
BTF), we need to specially tag such a field so that verifier knows that
it is a special kernel object whose invariants must hold during use of
the kptr allocation. For instance, reading and writing is allowed to all
other offsets in the kptr allocation, but access to this special field
would be rejected.

To do so, it needs to be tagged using a "kernel" BTF declaration tag,
like so:

struct item {
	int data;
	struct bpf_list_node node __kernel;
};

In future commits, more objects (such as kptrs inside kptrs, spin_lock,
even bpf_list_head) will be allowed in kptr allocation. But those need
more plumbing before it can all be made safe.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           | 15 ++++
 kernel/bpf/btf.c                              | 86 ++++++++++++++++---
 kernel/bpf/helpers.c                          |  8 ++
 kernel/bpf/verifier.c                         | 46 ++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  9 ++
 5 files changed, 146 insertions(+), 18 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index fc35c932e89e..062bc45e1cc9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -433,6 +433,10 @@ const struct btf_member *
 btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, enum bpf_prog_type prog_type,
 		      int arg);
+int btf_local_type_has_bpf_list_node(const struct btf *btf,
+				     const struct btf_type *t, u32 *offsetp);
+bool btf_local_type_has_special_fields(const struct btf *btf,
+				       const struct btf_type *t);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -471,6 +475,17 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 {
 	return NULL;
 }
+static inline int btf_local_type_has_bpf_list_node(const struct btf *btf,
+						   const struct btf_type *t,
+						   u32 *offsetp)
+{
+	return -ENOENT;
+}
+static inline bool btf_local_type_has_special_fields(const struct btf *btf,
+						     const struct btf_type *t)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17977e0f4e09..d8bc4752204c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3186,6 +3186,7 @@ enum btf_field_type {
 	BTF_FIELD_TIMER,
 	BTF_FIELD_KPTR,
 	BTF_FIELD_LIST_HEAD,
+	BTF_FIELD_LIST_NODE,
 };
 
 enum {
@@ -3319,8 +3320,8 @@ static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
 }
 
 static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
-				 const char *name, int sz, int align,
-				 enum btf_field_type field_type,
+				 const char *name, const char *decl_tag, int sz,
+				 int align, enum btf_field_type field_type,
 				 struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_member *member;
@@ -3334,6 +3335,8 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 
 		if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
 			continue;
+		if (decl_tag && !btf_find_decl_tag_value(btf, t, i, decl_tag))
+			continue;
 
 		off = __btf_member_bit_offset(t, member);
 		if (off % 8)
@@ -3346,6 +3349,7 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
+		case BTF_FIELD_LIST_NODE:
 			ret = btf_find_struct(btf, member_type, off, sz,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3377,8 +3381,8 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 }
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
-				const char *name, int sz, int align,
-				enum btf_field_type field_type,
+				const char *name, const char *decl_tag, int sz,
+				int align, enum btf_field_type field_type,
 				struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_var_secinfo *vsi;
@@ -3394,6 +3398,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 
 		if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
 			continue;
+		if (decl_tag && !btf_find_decl_tag_value(btf, t, i, decl_tag))
+			continue;
 		if (vsi->size != sz)
 			continue;
 		if (off % align)
@@ -3402,6 +3408,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
+		case BTF_FIELD_LIST_NODE:
 			ret = btf_find_struct(btf, var_type, off, sz,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3433,7 +3440,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  enum btf_field_type field_type,
+			  enum btf_field_type field_type, const char *decl_tag,
 			  struct btf_field_info *info, int info_cnt)
 {
 	const char *name;
@@ -3460,14 +3467,19 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 		sz = sizeof(struct bpf_list_head);
 		align = __alignof__(struct bpf_list_head);
 		break;
+	case BTF_FIELD_LIST_NODE:
+		name = "bpf_list_node";
+		sz = sizeof(struct bpf_list_node);
+		align = __alignof__(struct bpf_list_node);
+		break;
 	default:
 		return -EFAULT;
 	}
 
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, name, sz, align, field_type, info, info_cnt);
+		return btf_find_struct_field(btf, t, name, decl_tag, sz, align, field_type, info, info_cnt);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info, info_cnt);
+		return btf_find_datasec_var(btf, t, name, decl_tag, sz, align, field_type, info, info_cnt);
 	return -EINVAL;
 }
 
@@ -3480,7 +3492,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
 	struct btf_field_info info;
 	int ret;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info, 1);
+	ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, NULL, &info, 1);
 	if (ret < 0)
 		return ret;
 	if (!ret)
@@ -3493,7 +3505,7 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
 	struct btf_field_info info;
 	int ret;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info, 1);
+	ret = btf_find_field(btf, t, BTF_FIELD_TIMER, NULL, &info, 1);
 	if (ret < 0)
 		return ret;
 	if (!ret)
@@ -3510,7 +3522,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	struct module *mod = NULL;
 	int ret, i, nr_off;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
+	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, NULL, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (!ret)
@@ -3609,7 +3621,7 @@ struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf, const struct btf
 	struct bpf_map_value_off *tab;
 	int ret, i, nr_off;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_LIST_HEAD, info_arr, ARRAY_SIZE(info_arr));
+	ret = btf_find_field(btf, t, BTF_FIELD_LIST_HEAD, NULL, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (!ret)
@@ -5916,6 +5928,37 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	return -EINVAL;
 }
 
+static int btf_find_local_type_field(const struct btf *btf,
+				     const struct btf_type *t,
+				     enum btf_field_type type,
+				     u32 *offsetp)
+{
+	struct btf_field_info info;
+	int ret;
+
+	/* These are invariants that must hold if this is a local type */
+	WARN_ON_ONCE(btf_is_kernel(btf) || !__btf_type_is_struct(t));
+	ret = btf_find_field(btf, t, type, "kernel", &info, 1);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return 0;
+	if (offsetp)
+		*offsetp = info.off;
+	return ret;
+}
+
+int btf_local_type_has_bpf_list_node(const struct btf *btf,
+				     const struct btf_type *t, u32 *offsetp)
+{
+	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_NODE, offsetp);
+}
+
+bool btf_local_type_has_special_fields(const struct btf *btf, const struct btf_type *t)
+{
+	return btf_local_type_has_bpf_list_node(btf, t, NULL) == 1;
+}
+
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype __maybe_unused,
@@ -5926,6 +5969,27 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 	int err;
 	u32 id;
 
+	if (local_type) {
+		u32 offset;
+
+#define PREVENT_DIRECT_WRITE(field)							\
+	err = btf_local_type_has_##field(btf, t, &offset);				\
+	if (err < 0) {									\
+		bpf_log(log, "incorrect " #field " specification in local type\n");	\
+		return err;								\
+	}										\
+	if (err) {									\
+		if (off < offset + sizeof(struct field) && offset < off + size) {	\
+			bpf_log(log, "direct access to " #field " is disallowed\n");	\
+			return -EACCES;							\
+		}									\
+	}
+		PREVENT_DIRECT_WRITE(bpf_list_node);
+
+#undef PREVENT_DIRECT_WRITE
+		err = 0;
+	}
+
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d417aa4f0b22..0bb11d8bcaca 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1710,6 +1710,13 @@ void *bpf_kptr_alloc(u64 local_type_id__k, u64 flags)
 	return kmalloc(size, GFP_ATOMIC);
 }
 
+void bpf_list_node_init(struct bpf_list_node *node__clkptr)
+{
+	BUILD_BUG_ON(sizeof(struct bpf_list_node) != sizeof(struct list_head));
+	BUILD_BUG_ON(__alignof__(struct bpf_list_node) != __alignof__(struct list_head));
+	INIT_LIST_HEAD((struct list_head *)node__clkptr);
+}
+
 __diag_pop();
 
 BTF_SET8_START(tracing_btf_ids)
@@ -1717,6 +1724,7 @@ BTF_SET8_START(tracing_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_kptr_alloc, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
+BTF_ID_FLAGS(func, bpf_list_node_init)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64cceb7d2f20..1108b6200501 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7755,10 +7755,14 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 
 BTF_ID_LIST(special_kfuncs)
 BTF_ID(func, bpf_kptr_alloc)
+BTF_ID(func, bpf_list_node_init)
+BTF_ID(struct, btf) /* empty entry */
 
 enum bpf_special_kfuncs {
 	KF_SPECIAL_bpf_kptr_alloc,
-	KF_SPECIAL_MAX,
+	KF_SPECIAL_bpf_list_node_init,
+	KF_SPECIAL_bpf_empty,
+	KF_SPECIAL_MAX = KF_SPECIAL_bpf_empty,
 };
 
 static bool __is_kfunc_special(const struct btf *btf, u32 func_id, unsigned int kf_sp)
@@ -7922,6 +7926,7 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 
 struct local_type_field {
 	enum {
+		FIELD_bpf_list_node,
 		FIELD_MAX,
 	} type;
 	enum bpf_special_kfuncs ctor_kfunc;
@@ -7944,9 +7949,34 @@ static int local_type_field_cmp(const void *a, const void *b)
 
 static int find_local_type_fields(const struct btf *btf, u32 btf_id, struct local_type_field *fields)
 {
-	/* XXX: Fill the fields when support is added */
-	sort(fields, FIELD_MAX, sizeof(fields[0]), local_type_field_cmp, NULL);
-	return FIELD_MAX;
+	const struct btf_type *t;
+	int cnt = 0, ret;
+	u32 offset;
+
+	t = btf_type_by_id(btf, btf_id);
+	if (!t)
+		return -ENOENT;
+
+#define FILL_LOCAL_TYPE_FIELD(ftype, ctor, dtor, nd)        \
+	ret = btf_local_type_has_##ftype(btf, t, &offset);  \
+	if (ret < 0)                                        \
+		return ret;                                 \
+	if (ret) {                                          \
+		fields[cnt].type = FIELD_##ftype;           \
+		fields[cnt].ctor_kfunc = KF_SPECIAL_##ctor; \
+		fields[cnt].dtor_kfunc = KF_SPECIAL_##dtor; \
+		fields[cnt].name = #ftype;                  \
+		fields[cnt].offset = offset;                \
+		fields[cnt].needs_destruction = nd;         \
+		cnt++;                                      \
+	}
+
+	FILL_LOCAL_TYPE_FIELD(bpf_list_node, bpf_list_node_init, bpf_empty, false);
+
+#undef FILL_LOCAL_TYPE_FIELD
+
+	sort(fields, cnt, sizeof(fields[0]), local_type_field_cmp, NULL);
+	return cnt;
 }
 
 static int
@@ -8439,10 +8469,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			 * setting of this flag.
 			 */
 			regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
-			/* TODO: Recognize special fields in local type aand
-			 * force their construction before pointer escapes by
-			 * setting OBJ_CONSTRUCTING.
+			/* Recognize special fields in local type and force
+			 * their construction before pointer escapes by setting
+			 * OBJ_CONSTRUCTING.
 			 */
+			if (btf_local_type_has_special_fields(ret_btf, ret_t))
+				regs[BPF_REG_0].type |= OBJ_CONSTRUCTING;
 		} else {
 			if (!btf_type_is_struct(ptr_type)) {
 				ptr_type_name = btf_name_by_offset(desc_btf, ptr_type->name_off);
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index bddd77093d1e..c3c5442742dc 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -32,4 +32,13 @@ struct bpf_list_node {
  */
 void *bpf_kptr_alloc(__u64 local_type_id, __u64 flags) __ksym;
 
+/* Description
+ *	Initialize bpf_list_node field in a local kptr. This kfunc has
+ *	constructor semantics, and thus can only be called on a local kptr in
+ *	'constructing' phase.
+ * Returns
+ *	Void.
+ */
+void bpf_list_node_init(struct bpf_list_node *node) __ksym;
+
 #endif
-- 
2.34.1

