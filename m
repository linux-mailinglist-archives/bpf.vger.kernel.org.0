Return-Path: <bpf+bounces-17283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DB80B0F7
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0051F2144C
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542515B4;
	Sat,  9 Dec 2023 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPpCpVsO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F3172A
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:19 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d05ff42db0so24685117b3.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081638; x=1702686438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcijZ7zmEhMwBkAsr+58qnwQoyW4UBii1bAJMTXNQnA=;
        b=UPpCpVsO+EWDhVwP1KUWtuV7Zp2ARCB1Kxt0IkSGygRLS/NX4zhxlxPSomATDcpS7o
         RWP2A2luwPVIEXzshCJRmhAAH6Y9BjIevMX4biP9IBW0bGWZ74NPdUyUu20U56ccJuDZ
         phHrcps4zfdDPE9lLhJefDzMSCrxNjZO7BfWyPaf5iHLE71GfIoI86vMck5qX3Gx5G8w
         ETeM2sB1ZyO4Uvnv0j0HxhVAw7VZ/kpeMebNr3ksmowyN5YCoX3xzCsAiAzkdYMDfU6U
         DPS05ZnkWDytiUqzM4vUuIpe/aaAHNsd+Gzvjgs0g0X7ixL9cTDfgyAX2ePfv0kHhEBk
         crfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081638; x=1702686438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcijZ7zmEhMwBkAsr+58qnwQoyW4UBii1bAJMTXNQnA=;
        b=D+qXUh1hXZ3Nfy3npn8foZN0zMleqUwHlY6LL9UaS2UqmK1483kJL4z+iWDZ+nGJgs
         L1EcC/ByjO57AkcY8FJ/34/fCGj5UJ1sZL54Q/EKuRJNQJgVAGR7N3NnyVPUHyJP43I7
         1fBMLbPoRTOmT/5YCerhWBJ6C1DCKZzjzpSos3ftUo2MVvZv1wEd1mmqGjkDfy2YDIh0
         wgfdjTzOb+coBytdth+QNJLzs79gr4M0KXea0ha8PSp9gJQ65bFaOFygLqpd5QSH+/RO
         M7UrYe/Tqu+hRpEGObct0b25Q7pI7d47lxXIo3Rqv0sO2fSE++65xMwuCRawOYSzmRE1
         zoYg==
X-Gm-Message-State: AOJu0Yw8UlearuJYS6YOIRs3lZKCRd9nY7f3LqWHFLVVv+eQRfnfL1wq
	v5Uh/9TZky8v/weAWAd3Kx+HScvmVyFzrw==
X-Google-Smtp-Source: AGHT+IGAC1GT/GNv0p1h/cadTeckcvzjbCGUiZu2ll8H2m+UJSSDHwn6lv9Z4A8e7QY4CflwFrqx0A==
X-Received: by 2002:a0d:fe06:0:b0:5cd:3d82:1ac6 with SMTP id o6-20020a0dfe06000000b005cd3d821ac6mr829166ywf.42.1702081638547;
        Fri, 08 Dec 2023 16:27:18 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:18 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v13 05/14] bpf: make struct_ops_map support btfs other than btf_vmlinux.
Date: Fri,  8 Dec 2023 16:27:00 -0800
Message-Id: <20231209002709.535966-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Once new struct_ops can be registered from modules, btf_vmlinux is no
longer the only btf that struct_ops_map would face.  st_map should remember
what btf it should use to get type information.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5fbf88e6f4e5..2b0c402740cc 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -46,6 +46,8 @@ struct bpf_struct_ops_map {
 	 * "links[]".
 	 */
 	void *image;
+	/* The owner moduler's btf. */
+	struct btf *btf;
 	/* uvalue->data stores the kernel struct
 	 * (e.g. tcp_congestion_ops) that is more useful
 	 * to userspace than the kvalue.  For example,
@@ -314,7 +316,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int check_zero_holes(const struct btf_type *t, void *data)
+static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
 	u32 i, moff, msize, prev_mend = 0;
@@ -326,8 +328,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
 
-		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+		mtype = btf_type_by_id(btf, member->type);
+		mtype = btf_resolve_size(btf, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -402,12 +404,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
-	err = check_zero_holes(st_ops_desc->value_type, value);
+	err = check_zero_holes(st_map->btf, st_ops_desc->value_type, value);
 	if (err)
 		return err;
 
 	uvalue = value;
-	err = check_zero_holes(t, uvalue->data);
+	err = check_zero_holes(st_map->btf, t, uvalue->data);
 	if (err)
 		return err;
 
@@ -443,7 +445,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
-		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
+		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
 				goto reset_unlock;
@@ -468,8 +470,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (!ptype || !btf_type_is_func_proto(ptype)) {
 			u32 msize;
 
-			mtype = btf_type_by_id(btf_vmlinux, member->type);
-			mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+			mtype = btf_type_by_id(st_map->btf, member->type);
+			mtype = btf_resolve_size(st_map->btf, mtype, &msize);
 			if (IS_ERR(mtype)) {
 				err = PTR_ERR(mtype);
 				goto reset_unlock;
@@ -607,6 +609,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 					     struct seq_file *m)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	void *value;
 	int err;
 
@@ -616,7 +619,8 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 
 	err = bpf_struct_ops_map_sys_lookup_elem(map, key, value);
 	if (!err) {
-		btf_type_seq_show(btf_vmlinux, map->btf_vmlinux_value_type_id,
+		btf_type_seq_show(st_map->btf,
+				  map->btf_vmlinux_value_type_id,
 				  value, m);
 		seq_puts(m, "\n");
 	}
@@ -726,6 +730,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	st_map->btf = btf_vmlinux;
+
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
 
-- 
2.34.1


