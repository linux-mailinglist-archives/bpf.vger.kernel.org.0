Return-Path: <bpf+bounces-16963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E55807DFF
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4282825CA
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76E1868;
	Thu,  7 Dec 2023 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjW9jTSN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B06D63
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:11 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d852ac9bb2so1520437b3.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913211; x=1702518011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W10fWCq60U+vyTX2LGOyezGgr8b7qL/gUmRRjU5kts0=;
        b=HjW9jTSNJKuNj8GxAZmVLZamNuaGc1MzjQ0MEkuEzHHGeVTAe4laExm+Z/UQmY51n1
         CQdgGi2A4288uxYp/TWJ2rzWYkhMurLfHxSihfxw/dubA+zstJgdnqs/ezB789YKfHK0
         oHnQpD2q+cssHyavjslhrvnlNXo5d/c8Q1vw9hPH3YKDLF44QPIxMlfmvi02D3EXzbGc
         kpeTLZ7haPL1937yFHoMUjge9djrIBlfdjiodFrdYGmqgONzm7EgJZSdor4GeY702Bs3
         suybSxMBvOHYIaLP6oEiI8h0H/o62/DgFGVo8NHq3Q/QIrktFHRFYdQkkGsxvk7rNm/F
         x2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913211; x=1702518011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W10fWCq60U+vyTX2LGOyezGgr8b7qL/gUmRRjU5kts0=;
        b=GeZDkn4JsxFAiwQwebclPXZCfxd+TCR/TFf0YD/A0LckDTzp74fGo8buBJtRE1RBHT
         a2nxiR+TmHTACo+DRbpO2WpixrlYtswoAEpEsY4f5xChIdbjjMjW/aNdCO48YdTuFlGT
         tK0pFvyM9LJ90nYc15iIc8/UubctW5xwkHXgTG2Pcph62VD6bDBUiHOwvR7Ezl8PsxJE
         p8iRqKAf3grqPivpyGrkiJ0vQLi99f+7v2NfGW8xATbgn75O68Qg00vuud+l2kfMWSNr
         EiWc0n3nO952GfzQm946AyD61i657d1dx97InyCrg2PcN2GNmyjQrkFnoz7XEzm2OtF/
         J+0w==
X-Gm-Message-State: AOJu0YzHzBNoT7HcVsrbhz0RGq3XppVi2vmF3UB686leq4uFbeLRV6gS
	1TeeWLLUIo/RwlkGHmJxgt1YJnL5Pz8=
X-Google-Smtp-Source: AGHT+IG25S2c9RhaF6/eTtXDKbG4nfBETExmYe0VwTUM0zqo6WVyCiEXVYrYGqQRTtxWXIN2m/Louw==
X-Received: by 2002:a0d:d94d:0:b0:5d7:1940:53e4 with SMTP id b74-20020a0dd94d000000b005d7194053e4mr1565521ywe.92.1701913210875;
        Wed, 06 Dec 2023 17:40:10 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:10 -0800 (PST)
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
Subject: [PATCH bpf-next v12 05/14] bpf: make struct_ops_map support btfs other than btf_vmlinux.
Date: Wed,  6 Dec 2023 17:39:41 -0800
Message-Id: <20231207013950.1689269-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
index 338b65f90692..9e5d77ea738a 100644
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


