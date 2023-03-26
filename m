Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7D6C936A
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCZJW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCZJWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D01F9032;
        Sun, 26 Mar 2023 02:22:22 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w25so5876524qtc.5;
        Sun, 26 Mar 2023 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01YykE5VdF3mbRIggVDZ1yArVGph94w2fkqHep9wJ/M=;
        b=HDH3pJEizmyJMBwcqdhwW7RySQMEhGJzrjzbgOB8zDeEHz1yjmTofopEYWHefgJ2OR
         QcSB6O+IfmUfQnQA73rLVs/YvdRkyc7zTqzBVezuQ8j4geqUA90RDJyorvJf3uvQD+Yb
         MPlcrWgJZyg9zjGgajNSlgm4T60dvHQjXby77Uec5AMaNALib9jaXP0nphLXzyZvU1qF
         PpeWn9bGdsUysDNshGWuFXBOmAYrANq0okxkckRb2VIgyXBwmTw8DSjWm4dADyWWFw2M
         md4V5XO48fMRoCHOpbc4zJk5tZpRynM6BctAdB/PEwB7+pWIHum1Jy6yFiEPDtgKBPSt
         9QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01YykE5VdF3mbRIggVDZ1yArVGph94w2fkqHep9wJ/M=;
        b=h5iD1eYYrXJPDKvyLYTPx+MUhdoBPWolmDeT8q0I0PokOHpiSV/JCtxD0C4HPmE6xx
         nTVJABrOX+h5/3R7ycYuSQWPGbH9mw5yXc8qYoZ+6FQu5606yRZ1M+5OiUom+/OrNtdN
         bPJ7Z1tdUMzMsC1dwLS+j+pwbGCdY+NVQNmQjOTYz5Y7yu+6gJ3d+vYSQLST8PgNFSuY
         EnOUbSBNrWMcxuAJTEBY2KtKGzx33wdydgcrCNEbF6esNBdApqPPYnbFHCdFqA7w1ct2
         8LbFj8ONJOp8e52HFJ4WV/W/Cdm7odbJC16M0K7vtMrkLugo0z+IUHxd3McceMG2imDx
         pN8g==
X-Gm-Message-State: AAQBX9d38bpQ7nSpYlLhUvGdDGY/uuenr4YlmjSCC4Ta2rN/dJpgfltD
        6XnYv6QI8u91dXSwfa1JG64=
X-Google-Smtp-Source: AKy350ZvRbDR2S6vDYQtlTB5zvkVrZFBwi/+I2BXm08Hu3WT5IMgowREeafYFAGFl+ZfxP5Qdri1XA==
X-Received: by 2002:ac8:7fd4:0:b0:3e4:e61a:669c with SMTP id b20-20020ac87fd4000000b003e4e61a669cmr1164203qtk.8.1679822541457;
        Sun, 26 Mar 2023 02:22:21 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 05/13] bpf: Make bpf objects id have the same alloc and free pattern
Date:   Sun, 26 Mar 2023 09:22:00 +0000
Message-Id: <20230326092208.13613-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make them have the same patthern, then we can use the generic helpers
instead.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/offload.c | 15 +++++++++++--
 kernel/bpf/syscall.c | 62 ++++++++++++++++++++++++----------------------------
 2 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index d9c9f45..aec70e0 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -134,9 +134,20 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 
 static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
 {
+	struct bpf_map *map = &offmap->map;
+
 	WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
-	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
-	bpf_map_free_id(&offmap->map);
+	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map.
+	 *
+	 * Offloaded maps are removed from the IDR store when their device
+	 * disappears - even if someone holds an fd to them they are unusable,
+	 * the memory is gone, all ops will fail; they are simply waiting for
+	 * refcnt to drop to be freed.
+	 */
+	if (map->id) {
+		bpf_map_free_id(map);
+		map->id = 0;
+	}
 	list_del_init(&offmap->offloads);
 	offmap->netdev = NULL;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f3664f2..ee1297d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -382,30 +382,19 @@ static int bpf_map_alloc_id(struct bpf_map *map)
 	idr_preload(GFP_KERNEL);
 	spin_lock_bh(&map_idr_lock);
 	id = idr_alloc_cyclic(&map_idr, map, 1, INT_MAX, GFP_ATOMIC);
-	if (id > 0)
-		map->id = id;
 	spin_unlock_bh(&map_idr_lock);
 	idr_preload_end();
 
-	return id > 0 ? 0 : id;
+	return id;
 }
 
 void bpf_map_free_id(struct bpf_map *map)
 {
 	unsigned long flags;
 
-	/* Offloaded maps are removed from the IDR store when their device
-	 * disappears - even if someone holds an fd to them they are unusable,
-	 * the memory is gone, all ops will fail; they are simply waiting for
-	 * refcnt to drop to be freed.
-	 */
-	if (!map->id)
-		return;
-
 	spin_lock_irqsave(&map_idr_lock, flags);
 
 	idr_remove(&map_idr, map->id);
-	map->id = 0;
 
 	spin_unlock_irqrestore(&map_idr_lock, flags);
 }
@@ -748,8 +737,11 @@ static void bpf_map_put_uref(struct bpf_map *map)
 void bpf_map_put(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->refcnt)) {
-		/* bpf_map_free_id() must be called first */
-		bpf_map_free_id(map);
+		/* bpf_map_free_id() must be called first. */
+		if (map->id) {
+			bpf_map_free_id(map);
+			map->id = 0;
+		}
 		btf_put(map->btf);
 		INIT_WORK(&map->work, bpf_map_free_deferred);
 		/* Avoid spawning kworkers, since they all might contend
@@ -1215,8 +1207,9 @@ static int map_create(union bpf_attr *attr)
 		goto free_map_field_offs;
 
 	err = bpf_map_alloc_id(map);
-	if (err)
+	if (err < 0)
 		goto free_map_sec;
+	map->id = err;
 
 	bpf_map_save_memcg(map);
 
@@ -2024,29 +2017,18 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	idr_preload(GFP_KERNEL);
 	spin_lock_bh(&prog_idr_lock);
 	id = idr_alloc_cyclic(&prog_idr, prog, 1, INT_MAX, GFP_ATOMIC);
-	if (id > 0)
-		prog->aux->id = id;
 	spin_unlock_bh(&prog_idr_lock);
 	idr_preload_end();
 
-	return id > 0 ? 0 : id;
+	return id;
 }
 
 void bpf_prog_free_id(struct bpf_prog *prog)
 {
 	unsigned long flags;
 
-	/* cBPF to eBPF migrations are currently not in the idr store.
-	 * Offloaded programs are removed from the store when their device
-	 * disappears - even if someone grabs an fd to them they are unusable,
-	 * simply waiting for refcnt to drop to be freed.
-	 */
-	if (!prog->aux->id)
-		return;
-
 	spin_lock_irqsave(&prog_idr_lock, flags);
 	idr_remove(&prog_idr, prog->aux->id);
-	prog->aux->id = 0;
 	spin_unlock_irqrestore(&prog_idr_lock, flags);
 }
 
@@ -2091,7 +2073,15 @@ static void bpf_prog_put_deferred(struct work_struct *work)
 	prog = aux->prog;
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
 	bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
-	bpf_prog_free_id(prog);
+	/* cBPF to eBPF migrations are currently not in the idr store.
+	 * Offloaded programs are removed from the store when their device
+	 * disappears - even if someone grabs an fd to them they are unusable,
+	 * simply waiting for refcnt to drop to be freed.
+	 */
+	if (prog->aux->id) {
+		bpf_prog_free_id(prog);
+		prog->aux->id = 0;
+	}
 	__bpf_prog_put_noref(prog, true);
 }
 
@@ -2655,8 +2645,9 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_used_maps;
 
 	err = bpf_prog_alloc_id(prog);
-	if (err)
+	if (err < 0)
 		goto free_used_maps;
+	prog->aux->id = err;
 
 	/* Upon success of bpf_prog_alloc_id(), the BPF prog is
 	 * effectively publicly exposed. However, retrieving via
@@ -2730,9 +2721,6 @@ void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 
 static void bpf_link_free_id(int id)
 {
-	if (!id)
-		return;
-
 	spin_lock_bh(&link_idr_lock);
 	idr_remove(&link_idr, id);
 	spin_unlock_bh(&link_idr_lock);
@@ -2748,7 +2736,10 @@ static void bpf_link_free_id(int id)
 void bpf_link_cleanup(struct bpf_link_primer *primer)
 {
 	primer->link->prog = NULL;
-	bpf_link_free_id(primer->id);
+	if (primer->id) {
+		bpf_link_free_id(primer->id);
+		primer->id = 0;
+	}
 	fput(primer->file);
 	put_unused_fd(primer->fd);
 }
@@ -2761,7 +2752,10 @@ void bpf_link_inc(struct bpf_link *link)
 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
-	bpf_link_free_id(link->id);
+	if (link->id) {
+		bpf_link_free_id(link->id);
+		link->id = 0;
+	}
 	if (link->prog) {
 		/* detach BPF program, clean up used resources */
 		link->ops->release(link);
-- 
1.8.3.1

