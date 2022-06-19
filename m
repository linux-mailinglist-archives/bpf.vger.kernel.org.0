Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFF550BF6
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiFSPvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiFSPvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:51:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E31BE05
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:51:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso8129997pja.2
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwCrlHiRqBK3TQXbqbFOzQOTzh9qCJzbmrIFhJw7nPY=;
        b=gG5XX7PqlXa2X73375TmgCa4Z4pHjtha1wTFLorvCMGCCG36m1IsgvAHVnj/+kxo0i
         bWjyjchH3NmfZsW8qb5crT1xlS7txgjFZBq6XHUtzm5v7+d5b1Jfe7SBqP3xa2NivqE3
         F7nM5p8L3hCk7zsN+8OlXjO49kBQox6Pjc22I8Nfqgo9hUW/SzxD8+SCypdijeEFIQcz
         9zyiIDcWGRXH1RgYtszLyCKiIQZRixcRQZs+NkJIGA8ynrZxUXI3prYBc1yQQlqwKI3v
         sYHP1GcXC93i3jEvjKVjPrOrB8b6Ukbxq90/8tq+kV1wG7hFeFgZ7l+K62H6HbTNaP9u
         PXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwCrlHiRqBK3TQXbqbFOzQOTzh9qCJzbmrIFhJw7nPY=;
        b=H4X7THl42o+E4ekmFGOsQo42fU4LYOuleJ0lu16SwTlgM8fU3LZulWtZ9BCZft3mQG
         hpGQBnRW084C1bB06bDQ63m7Lt5v+uG5cXuyMwBBfguKhqo+YDlK6vdzc/TK4zIPKbN2
         rl9K5yXX69cgS8skFq2zOn/Wkijqxc2C4hJLx3P89J5S5V8YEToYwFeU7pHIJAe9oGcZ
         8fYdHMkUmkYVzW4C+qoelq/kumuVNRYvGJ7fBTjP0g6PskSZN3UVgF6Eud6f9N8H/d05
         MsjwYvmeDTO5kH4581S3Dw2q81yk06yV7bPxgePiPwRBc0eHIG6Zy+/rQWy5A72yEPb/
         Ku5g==
X-Gm-Message-State: AJIora+hK7ZdPMwXJgCXs1+nhkd+haccs2h3WGW8jbudc/Wxj64BBxzk
        RHj0IfXW62iVIAdKuyef6lw=
X-Google-Smtp-Source: AGRyM1vAxtpulJ0ehxCQm0vNdQXfcu7UMbEBF0DvHPLPdUMcTffedr4blykuzh6+o2/NsoGPcNcR7w==
X-Received: by 2002:a17:90a:408f:b0:1d1:d1ba:2abb with SMTP id l15-20020a17090a408f00b001d1d1ba2abbmr32595817pjg.152.1655653861217;
        Sun, 19 Jun 2022 08:51:01 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:51:00 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 09/10] bpf: Make bpf_map_{save, release}_memcg public
Date:   Sun, 19 Jun 2022 15:50:31 +0000
Message-Id: <20220619155032.32515-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
MIME-Version: 1.0
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

These two helpers will be used in map specific files later.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h  | 21 +++++++++++++++++++++
 kernel/bpf/syscall.c | 19 -------------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b18a30e70507..a0f21d4382ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,7 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/memcontrol.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -248,6 +249,26 @@ struct bpf_map {
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 };
 
+#ifdef CONFIG_MEMCG_KMEM
+static inline void bpf_map_save_memcg(struct bpf_map *map)
+{
+	map->memcg = get_mem_cgroup_from_mm(current->mm);
+}
+
+static inline void bpf_map_release_memcg(struct bpf_map *map)
+{
+	mem_cgroup_put(map->memcg);
+}
+#else
+static inline void bpf_map_save_memcg(struct bpf_map *map)
+{
+}
+
+static inline void bpf_map_release_memcg(struct bpf_map *map)
+{
+}
+#endif
+
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
 {
 	return map->spin_lock_off >= 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8817c40275f3..5159b97d1064 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -417,16 +417,6 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static void bpf_map_save_memcg(struct bpf_map *map)
-{
-	map->memcg = get_mem_cgroup_from_mm(current->mm);
-}
-
-static void bpf_map_release_memcg(struct bpf_map *map)
-{
-	mem_cgroup_put(map->memcg);
-}
-
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node)
 {
@@ -464,15 +454,6 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 
 	return ptr;
 }
-
-#else
-static void bpf_map_save_memcg(struct bpf_map *map)
-{
-}
-
-static void bpf_map_release_memcg(struct bpf_map *map)
-{
-}
 #endif
 
 static int bpf_map_kptr_off_cmp(const void *a, const void *b)
-- 
2.17.1

