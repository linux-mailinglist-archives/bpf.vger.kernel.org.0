Return-Path: <bpf+bounces-19778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE883110B
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB731F2294A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4146A8;
	Thu, 18 Jan 2024 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzwWyFfE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4A5665
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542597; cv=none; b=jKeKy1rni6rZ6A8JrmHztSpI/f4HNK5Ut77KtuxlKo1YF7fH4Z2frotXHoJ9XPZJVTBhQqK0oMYuQHQR+8c+3NsBdeXrf3UHB1pGBAXvKQDsCOnbDhvP3rM8DSYSWLV8SBsBTAz9RtCxVkejpEDfEhVdIg0mqUj8kSE64l8Jutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542597; c=relaxed/simple;
	bh=XbywLo7TLmwiVSYMFXgs0Q7tcoif4V/s/i7wQ9R8joQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=CS0X2RGIfWrGTkztG25UCFWCemmQ94dTRtSLaBvu8J24vrum+wZvL4Gc5DMmjiBmCLCKqOKL3Kvg7gHn9DpflPe16PzCqtRo/PgaPJC8Mk1PTVI4Os2/xOMaV3Q41bokftESAoGm5ri+qluNa8ha2vlQjER5K/01BfAzqim19lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzwWyFfE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7dc53ce0so6440307b3.1
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542594; x=1706147394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cX5edNAyRXlgv6ZNVD4EGw6vjLdbpUYx/HNHgTpU3w=;
        b=NzwWyFfENzr7WKXhRHx1OJ+U/XBH/25DvK3mOay1heXyqDBCQ3NTPWI8D9x259AFmm
         MKQVahEJe4AJNj1XILAoDHJAiCpVf6++z4tDK3wVi/TVK3ww1eZTMAhXv9R0C9kDZo3h
         tOePJdLo0W/JYndGNCxKPJW6+tPIH4Hmek2QzqK2juAgSUsg3vCk5/YrRedjDfEkGAOg
         rTJxJpzVM126VC4oAf74JACzjGxgQIFL5d+VgZo/gfaMTC/KUr+yBEYNVwgXoWoVsRYA
         jPrJ9XVuv/a/kgnBTf8dtPOFJ0Z+7ifP0EHODAB1DcP92P7RuXaECU7CfOwa1alUobnI
         g5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542594; x=1706147394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cX5edNAyRXlgv6ZNVD4EGw6vjLdbpUYx/HNHgTpU3w=;
        b=KdAOA5fy215/+4zLjmrZYMsRnohRa7d6RCe2lspZfIeONx7x6j6hDh8jMwXXl1JnWL
         9EOTjJYyZnFBwEBuyzmmIRI/Q5Xj3dMGpGrcW+oZ4Qtd44K71smnREQXaXZVO6NQISeF
         ch6P7ItRmpf/zspJbj3BuG9AJT/mfBPMmTFQOP0AKFKrCxmR+fU6HA/r276vACMGbf5d
         Dfi1DoIIzCoekjceTq9l0TauLjcOKWAs1nmaPu78giiAgFIyl1EH1AyDT0llyDGgLwSR
         wuHekkhNEpypV42qPEFNfm7d5dlQJjYDL9XraPA6kzMvxwOGCcDXv9Qtc26CRePZBC1r
         rNfA==
X-Gm-Message-State: AOJu0YwyS77kitX84Sol21za4tOdp4aIeQWVVclFl+wmqaJ8HAWFzVmL
	t/3SXLv9fufl2Rxbjv/6+fq99DTovOBmDb53DQ6LELecbMSLfarXMikmkZCQ
X-Google-Smtp-Source: AGHT+IGGCBX5PK+iBV47VkR2gXsnuFPz2D1uUn3LyycuNXFo1mTY+FUZSmh7ePCcukrat/p8zo6JSw==
X-Received: by 2002:a81:fd0c:0:b0:5d7:1940:8df8 with SMTP id g12-20020a81fd0c000000b005d719408df8mr103428ywn.95.1705542594300;
        Wed, 17 Jan 2024 17:49:54 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:53 -0800 (PST)
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
Subject: [PATCH bpf-next v16 05/14] bpf: make struct_ops_map support btfs other than btf_vmlinux.
Date: Wed, 17 Jan 2024 17:49:21 -0800
Message-Id: <20240118014930.1992551-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
index 9774f7824e8b..5ddcca4c4fba 100644
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
@@ -401,12 +403,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
 
@@ -442,7 +444,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
-		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
+		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
 				goto reset_unlock;
@@ -467,8 +469,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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


