Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687264976E
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLLAiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiLLAiS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:38:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67BB873
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w23so10406144ply.12
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzAnvaTBJovo8xlms0y3igjQiNiSLX0cTsxqHTkuwSM=;
        b=eI2+IZqPnNU+fWYDGLSbjTEgzHl4BXtLMuGhA0MtZ/EVxW2o2LK1qM8+6vA0Qk6JD9
         avFzijOjoV482Nc2xWtNub++FUgX2aQQeh8wyK4R2ltGlzHEFPz6p9oSU4CilG47spe/
         wAMMsCWcJf7Yiupe6+CCTwSTzn1Ef6ow/O1PRSmqvhYuuo38Ez8SBGxe0QeJtxeFn7ik
         3WfYXwhlyHCNbsTQXRzne+6AJytjw2lHIwee4IH7b82XSUiHCjtp7YGkBm8oxARfv6cJ
         aVUBb5N8UcXGeog32P/+1cJdhozcbt/PmipuOqt0dJBNY3XIGjYd4my+0OEFVlpRZdI2
         BMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzAnvaTBJovo8xlms0y3igjQiNiSLX0cTsxqHTkuwSM=;
        b=ExWf2In7D6219kYFxIOB9pAWu0XgmwIY369j4VSS8QSpL95SSgas/vmuN6+CtY0FRS
         prMLgxgd5Lhlb9S93/xBihK6nFco3joGUTkHMUtmEn9Rtzl+VWeq7Zr0JAUhqJjAJMVN
         4868Dbol4Uo3ToPLvfS/i3WwTK5aTzz72Yg3SOXu2WF57kXIcUs6rfOl5+ILGkS0IXCS
         8BeelJm2d/oCbH4u7K3BgvyzpbCg/JgDhjevXdq/Swg560uh9QG9J77i4s7ysWLhl4tL
         wJ2cJImCWJ9TAYZXZUKuJxVtX9U+oEJBThHhL3WC3mONS6Bvis4Z25jycfN54OuVcKz8
         oE1w==
X-Gm-Message-State: ANoB5pmrRvvPyJQrXdil5hfNcUN9pKvRJfi5o/ZMgVl5TJ1UabF655/Y
        NjBuw0xp7wCd/WXRAHOqZYw=
X-Google-Smtp-Source: AA0mqf4zVo0bbhsURr5t16X4g/g03JHmX3vwRlJEnZVQmsaxmoghlhj+eGYNGx0eCT7QsIDY4UOTuw==
X-Received: by 2002:a05:6a21:329a:b0:a4:829f:a43f with SMTP id yt26-20020a056a21329a00b000a4829fa43fmr22545343pzb.2.1670805497345;
        Sun, 11 Dec 2022 16:38:17 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:38:16 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 8/9] bpf: Use bpf_map_kvcalloc in bpf_local_storage
Date:   Mon, 12 Dec 2022 00:37:10 +0000
Message-Id: <20221212003711.24977-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
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
index 3de24cfb7a3d..80aca1ef8cc5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1873,6 +1873,8 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags);
+void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
+		       gfp_t flags);
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags);
 #else
@@ -1889,6 +1891,12 @@ bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
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
index b39a46e8fb08..0e43cecfdc07 100644
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
index 35972afb6850..c38875d6aea4 100644
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
2.30.1 (Apple Git-130)

