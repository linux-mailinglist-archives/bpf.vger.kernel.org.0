Return-Path: <bpf+bounces-9865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4079DFD3
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A6281DE3
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984B168AC;
	Wed, 13 Sep 2023 06:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498CA45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:13 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B08B172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-592976e5b6dso62590177b3.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585711; x=1695190511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr4AIWlExL9eRr0C6fZHCn1X+Q+PDAn7ykQLj2v5mA8=;
        b=P/G94Z7G0KyTT6UaVe7JeQ9X0W/cLlFYwGjiVN/cXsg9vPEE/ZC4ewOyImci9xR8ex
         rNirsGo8eezPxhnLwZ/uGoi8G1PMoNxo3pYyCuZLoSkuui06uNssojc+a0xErJ+UWgk1
         JrzzwFY1lJoYsk9cE0EHQkvZd7yuND8ZOKtaTPPmp1FepJOieEkEdy0+qykg+wPTEM15
         eqyftjrZpNK6MYBXFpnLxulKsbd7+HQAufJp7t4UajyNAbJr+gzxIm6QUofiFZEAzSLp
         BVGp/rJWiyocVJlMGy33aKQvOCCrfZfqaM43/Zb3Rr7E7Cry4TGjZ5rKkewEpzuXdF04
         a8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585711; x=1695190511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr4AIWlExL9eRr0C6fZHCn1X+Q+PDAn7ykQLj2v5mA8=;
        b=IZCDTqtvBP5D19PEH1P8YUWsWDca00ytS6ymGMYI5l+iibtlXAqiJ/pombFVlokgM5
         lDuRpnevpulh4+Lr8TAHTuuT5QZvn9cpRYOBgbGMxvymn+aTItAaG11QQ0NNzdGqoaFC
         1aGIjK5reO6hIOwqfwb606z0VMS20h/dXUFBAi+4vB4FyK/vJ70gjxYcBwvk2gPBPkT4
         Vm3v7evBGHWknOrOpV4H4ovc7XnTeIpHkYLQgbKRg82K5f6ttUoIdk/zKrowx9Pb1FQa
         n24RI+s2mctRGDnymIgh6lDz9mD9N/KDVY21Fxe8OTrcdTpqotuXVScu5SxlEOG4S8Ga
         t/Lg==
X-Gm-Message-State: AOJu0YxGQ9fK99rG9/9M2k/phJeFsM2B9xIQiW24FjyiNuCfxl7jWuHY
	EHvD0ZkOpPimkUpnLC/LQB+xgQyLVG0=
X-Google-Smtp-Source: AGHT+IGpXkWnBqskaFMybfvxIOyirAKqqATHXPCzYpWghn4+WwXakEevysFUyXP/WHmWRI3oQLQgzw==
X-Received: by 2002:a81:840e:0:b0:589:ca07:c963 with SMTP id u14-20020a81840e000000b00589ca07c963mr1660681ywf.42.1694585711364;
        Tue, 12 Sep 2023 23:15:11 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:10 -0700 (PDT)
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
Subject: [RFC bpf-next v2 4/9] bpf: use attached BTF to find correct type info of struct_ops progs.
Date: Tue, 12 Sep 2023 23:14:44 -0700
Message-Id: <20230913061449.1918219-5-thinker.li@gmail.com>
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

The signatures may be declared in the module defining the structs type.
So, we need to know which module BTF to look for type information.  The
later patches will make libbpf to attach module BTFs to programs. This
patch tries to use the attached BTF if there is.
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/bpf_struct_ops.c    | 11 ++++++++++-
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  4 +++-
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8790b3962e4b..f0882d341433 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1383,6 +1383,10 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__u32   mod_btf_fd;	/* fd pointing to a BTF type data
+					 * for btf_vmlinux_value_type_id.
+					 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 82cc3f0638fa..c93baf54a538 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -786,7 +786,16 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	struct btf *btf;
 
-	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
+	/* XXX: We need a module name or ID to find a BTF type. */
+	/* XXX: should use btf from attr->btf_fd */
+	if (attr->mod_btf_fd) {
+		btf = btf_get_by_fd(attr->mod_btf_fd);
+		if (IS_ERR(btf))
+			return ERR_PTR(PTR_ERR(btf));
+	} else {
+		btf = btf_vmlinux;
+	}
+	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eb01c31ed591..04d3017b7db1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1093,7 +1093,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD mod_btf_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0cab601b2a6..8eab8d3fc398 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19183,6 +19183,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -19190,8 +19191,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	btf = prog->aux->attach_btf;
 	btf_id = prog->aux->attach_btf_id;
-	st_ops = bpf_struct_ops_find(btf_id, btf_vmlinux);
+	st_ops = bpf_struct_ops_find(btf_id, btf);
 	if (!st_ops) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8790b3962e4b..f0882d341433 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1383,6 +1383,10 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__u32   mod_btf_fd;	/* fd pointing to a BTF type data
+					 * for btf_vmlinux_value_type_id.
+					 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-- 
2.34.1


