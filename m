Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1830667A32
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjALQBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjALQAv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1176542
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:46 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id jr10so9500493qtb.7
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS5gOGm/FV0EomE+G/HxAF0nnvFi+9pGVhYFw6UMCCU=;
        b=UwdPEQKpeaenmGBhuznEUg2Sgbzj2CbVaC5pOx/wXR0lBhCD+Kmr+Ukcq32XrTVLeX
         QD5J4wEyXv36kjjM5LJZD2ViCBneCDE+D38KzvcyswB6pmGebWYMatgB/TlTiTBbJVJt
         4X/EnkVd1Js9zemKZm9qMUdchkr7bKUQEeIoIcwG+HebxpzFEJ7wnAtwcbpJMOpR3QxL
         UZcwi5dRYZOX6riW+E4KupYoGQEPruyPGDOYSOkjE/yH8L2ypWd/VEi6SQRHHnZdlRUW
         IVP5tx2gBV77V9Fjfr9na9W1tsh3ny+CcrEIlk/NIilzOE1vy8vTwWzy6zZ8H7H4nh2D
         69RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rS5gOGm/FV0EomE+G/HxAF0nnvFi+9pGVhYFw6UMCCU=;
        b=A9scgzXjOqIQplsXmJQNtbFtMSfrhmGmXiI3r+lmvYHXHYNeOrnVjGEHGa9SV+phDG
         N0JnrDfECSKK2EhlW8QxRSzFrdGLCfxHjgUucBvOEkZ74i8zwqXFToYO30Dld/0Oc5oY
         jVs5KFZY2X9+3YVu8ZoooyC3A1J3eqnj3QZQUNRPtXZZYyd69RZrRaRWW9Fh3W33Bkx2
         csSTgpBBNcCxUM8XTCVRnmqr28FYqAkHyNgPVwQ13rM01WncUuEGWJORMWP3FRCkilO+
         SBEjWwtXKV0TjozGLpT2XkaNPQujCuMGMy6DBeWHuK29ZfhYq/fg/a1hWGnMpznmm4wO
         JjIA==
X-Gm-Message-State: AFqh2krTcowc5BLGxG/mC9ASJGlU9IVsyWhTk1nEnQVkvjyBXDdsrKNT
        7qIYTffdANbJUiGSdME89CY=
X-Google-Smtp-Source: AMrXdXs89lOju7eofF5NQ1SL2Vit25d1eDBdT+g9j1z0eBLF0PzlschIVu6iMcAjd8ub9ViVM50vww==
X-Received: by 2002:ac8:5e90:0:b0:3a7:ea9b:5627 with SMTP id r16-20020ac85e90000000b003a7ea9b5627mr13990618qtx.13.1673538825926;
        Thu, 12 Jan 2023 07:53:45 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:45 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 09/11] bpf: use bpf_map_kvcalloc in bpf_local_storage
Date:   Thu, 12 Jan 2023 15:53:24 +0000
Message-Id: <20230112155326.26902-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce new helper bpf_map_kvcalloc() for this memory allocation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h            |  8 ++++++++
 kernel/bpf/bpf_local_storage.c |  4 ++--
 kernel/bpf/syscall.c           | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae7771c..fb14cc6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1873,6 +1873,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags);
+void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
+		       gfp_t flags);
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags);
 #else
@@ -1889,6 +1891,12 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 	return kzalloc(size, flags);
 }
 
+static inline void *
+bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size, gfp_t flags)
+{
+	return kvcalloc(n, size, flags);
+}
+
 static inline void __percpu *
 bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 		     gfp_t flags)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 373c3c2..35f4138 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -568,8 +568,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
 	nbuckets = max_t(u32, 2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
-	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
-				 GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
+					 nbuckets, GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		bpf_map_area_free(smap);
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35ffd80..9e266e8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -470,6 +470,21 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 	return ptr;
 }
 
+void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
+		       gfp_t flags)
+{
+	struct mem_cgroup *memcg, *old_memcg;
+	void *ptr;
+
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
+	ptr = kvcalloc(n, size, flags | __GFP_ACCOUNT);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+
+	return ptr;
+}
+
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags)
 {
-- 
1.8.3.1

