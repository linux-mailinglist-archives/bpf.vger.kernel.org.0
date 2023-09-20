Return-Path: <bpf+bounces-10467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179517A8928
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E55D1C209B6
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4DF3E463;
	Wed, 20 Sep 2023 16:00:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BF3C6AA
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:56 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF1C2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59bbdb435bfso71405127b3.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225653; x=1695830453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmYfJ0n9C4k+lzQmV8lhuWqIZALd5vy1dnG8L2YhGKk=;
        b=inAxvidqgoWTudE/zcxa2Q6p+iuAiBpRJA4aIjFxu3cufhjQ2dlQe2IvcwqmzrihUM
         DMghZpzIz8zU9EbsmaxEUdLx0Rd601wSVVNx/LtpUbYnf12yIf/ArZ3br2EQNxLKItxb
         NlSIEAUF4xR5AOPOgztTah2+Ys6p7IeJ5c3wYg0ypwmTUm/h2zXuSrZfGPiJehKa8xHa
         lyx/iDWjKpM8dzEQPZXKZH0+BMFtUM5Kx2zKwflfd1De9N37tTWh83giBbyLwiU6dQ8r
         BCm6lTzGv55O5EDogujMqcEXbv4sNkX/9ipGVkiQSeqNR1mJ9OUEFm+Mk5zT4iElGBsI
         snDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225653; x=1695830453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmYfJ0n9C4k+lzQmV8lhuWqIZALd5vy1dnG8L2YhGKk=;
        b=Bx2Grysl0JVet9jQhpOfvvinXYoullDDW1USF0N4K+NKznbS/Rcpua7aH6ZcatyToG
         a0QWoyRmcM+qvPkKOqIn6MaSO+plx7MOQNM0CeSxchPbbFE40mVHp6pDo2Za0XxDjlRa
         heBbFd8Lx8cv97iIXSNvtZlC0VrTtZtdr7v8rjyryQVyM7+qYcccvI5N901OWULazgBQ
         SxxdvxB+10duxaCAy6KHzBB8sROb3Ft13SPfE/UzMMzKYniEwmCLfwWaBHdS+Gn0s3uu
         bnZi0GAxSs3o4nqvmtM4LqIzfU7jeXtStjK/47GuIoWcr4VO+PSWfqt2roNw+V4Ucrjs
         YDoA==
X-Gm-Message-State: AOJu0YymNVfq9bP4GUu6RasXPvpSVD8a+IBDhctZ/5f2fWOpWV8O1p1/
	ZofnD18Qz2t9aPy+xNlnFePlAcLC7X4=
X-Google-Smtp-Source: AGHT+IGKeauAIRi5HkotH3AQJgYhZNNWujEV5AQ5aEOP625fxp1uPH9yiI4ein/1iqTkZ02V/fh/AA==
X-Received: by 2002:a0d:f905:0:b0:595:320d:c9e2 with SMTP id j5-20020a0df905000000b00595320dc9e2mr2813355ywf.24.1695225653334;
        Wed, 20 Sep 2023 09:00:53 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:51 -0700 (PDT)
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
Subject: [RFC bpf-next v3 08/11] bpf: pass attached BTF to find correct type info of struct_ops progs.
Date: Wed, 20 Sep 2023 08:59:21 -0700
Message-Id: <20230920155923.151136-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

The type info of a struct_ops type may be in a module.  So, we need to know
which module BTF to look for type information.  The later patches will make
libbpf to attach module BTFs to programs. This patch passes attached BTF
from syscall to bpf_struct_ops subsystem to make sure attached BTF is
available when the bpf_struct_ops subsystem is ready to use it.

bpf_prog has attach_btf in aux from attach_btf_obj_fd, that is pass along
with the bpf_attr loading the program. attach_btf is used to find the btf
type of attach_btf_id. attach_btf_id is used to identify the traced
function for a trace program.  For struct_ops programs, it is used to
identify the struct_ops type of the struct_ops object a program attached
to.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/bpf_struct_ops.c    | 12 +++++++++++-
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  4 +++-
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 73b155e52204..178d6fa45fa0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1390,6 +1390,10 @@ union bpf_attr {
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
index 8b5c859377e9..d5600d9ad302 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -765,9 +765,19 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
+	struct btf *btf;
 	int ret;
 
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
index 85c1d908f70f..fed3870fec7a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1097,7 +1097,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD mod_btf_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99b45501951c..11f85dbc911b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19623,6 +19623,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -19630,8 +19631,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
index 73b155e52204..178d6fa45fa0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1390,6 +1390,10 @@ union bpf_attr {
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


