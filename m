Return-Path: <bpf+bounces-14318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826797E2DF0
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57F31C2074D
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688C2DF83;
	Mon,  6 Nov 2023 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXNXZ7HT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194C2D040
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:09 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24F1705
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:08 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59e88a28b98so42719537b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301586; x=1699906386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdjC3A3kTFuPwPdeKcpFm/TM7CKQZoYYZyB+QOusRL8=;
        b=IXNXZ7HTylOnfi1Jg2e8VBlZ4PuEEGKWpo82MUSzMmo0zb/lReD9/rYfU63dOwz+Qm
         4xfg58XD3gZIsd36XlNTO+yo3RcuVmMmEZFPY7vsLxtYI4ix8kP2qQcNcFEyszzl6jdl
         BXJ5y6I/Rg3rE3cphxvv3J/wh1x/nOEBM51KB/PQBOFxKwRwNWfW9J9vM++iRkpNf1Xi
         jCnnTEMBmgGLgNy/2mHD0qPYiIptiiBYSoxU6i68tB7U+lc4CxpRUflx7cSt7BOws/wk
         e9KbbDzyUH8FOZigzZ9/wdHYotZhOwEJhTn8MaxJBqcxPSffXW6sbMgnGhf78ckAEZyH
         zeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301586; x=1699906386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdjC3A3kTFuPwPdeKcpFm/TM7CKQZoYYZyB+QOusRL8=;
        b=vUk6ayXLDaKbrzzHd8Q6GaPe+4i+4p2oHoXpu4WUBNvVck6hSKpCkfX3n9A2LoonNn
         07lXp7HsBMITngiNu7lZpiB15JtCdwb2YawV43jn4xylLRNbph1NpYOO3T8HX/ugcBKq
         Z2r8idP09RhSMkRrH+KxHODeKlQUeDgs1/fRd3dZjpmCxk/RLxpXnOHIySIp2cvRIkna
         MsW/iPbMUmB4ASeNgGJ1F2G8k1ApPY01e0sSt+Bn0isd11fHpv7MtT9kqdrOMlbl7WfA
         RpxV5xHIAe38fb6Ainu8fMUsWT72CzUfgVzEqIbRIP1NcYKss0oTZEfAY9jFwWaB5EJR
         qwYg==
X-Gm-Message-State: AOJu0YzUyAIVQ1Pxvawop8yqLldjcRiT5RQTRJ9nHj4KDZNaMVA/y2SZ
	rY1YyPhmh75h3E0Cd1FxDBPvOrLd0So=
X-Google-Smtp-Source: AGHT+IEJwDyixLCWxc7F0Yw4NX7MYCpz/H06CoqK8vtkKU0pw+vK7MnDafseEOVxYJsjXbAtN37mSg==
X-Received: by 2002:a0d:dbcc:0:b0:5a8:1a54:ba4b with SMTP id d195-20020a0ddbcc000000b005a81a54ba4bmr462681ywe.13.1699301586454;
        Mon, 06 Nov 2023 12:13:06 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:05 -0800 (PST)
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
Subject: [PATCH bpf-next v11 05/13] bpf: make struct_ops_map support btfs other than btf_vmlinux.
Date: Mon,  6 Nov 2023 12:12:44 -0800
Message-Id: <20231106201252.1568931-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Once new struct_ops can be registered from modules, btf_vmlinux is not
longer the only btf tht struct_ops_map would face.  st_map should remember
what btf it should use to get type information.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d804801c7864..a0291877a792 100644
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
@@ -395,12 +397,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
 
@@ -436,7 +438,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
-		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
+		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
 				goto reset_unlock;
@@ -461,8 +463,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (!ptype || !btf_type_is_func_proto(ptype)) {
 			u32 msize;
 
-			mtype = btf_type_by_id(btf_vmlinux, member->type);
-			mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+			mtype = btf_type_by_id(st_map->btf, member->type);
+			mtype = btf_resolve_size(st_map->btf, mtype, &msize);
 			if (IS_ERR(mtype)) {
 				err = PTR_ERR(mtype);
 				goto reset_unlock;
@@ -601,6 +603,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 					     struct seq_file *m)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	void *value;
 	int err;
 
@@ -610,7 +613,8 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 
 	err = bpf_struct_ops_map_sys_lookup_elem(map, key, value);
 	if (!err) {
-		btf_type_seq_show(btf_vmlinux, map->btf_vmlinux_value_type_id,
+		btf_type_seq_show(st_map->btf,
+				  map->btf_vmlinux_value_type_id,
 				  value, m);
 		seq_puts(m, "\n");
 	}
@@ -720,6 +724,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	st_map->btf = btf_vmlinux;
+
 	mutex_init(&st_map->lock);
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
-- 
2.34.1


