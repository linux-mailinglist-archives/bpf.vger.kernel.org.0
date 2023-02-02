Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF68687322
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjBBBmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBBBmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC287750D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:38 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n13so361601plf.11
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKQM5vml6SlvXVBphY+FPvXDlacnwZjaLK4//iP66Rc=;
        b=l3QJYqqBg/FLpgLF3w9RJzT6LCxhxV+XkCfXCmvbcqX9dmtvv9gqm2MxgFHNi3KsIH
         L+1/Jzgydg9Pvnr7vXfwlJEXyt4Oe1rE4kn05ybn6xcyMfcQMRzN4eG0/xL7461EBLbU
         vf8jElG3ItPsPUFX6RfXXViWPo74PSCLHWNs+XuIEBTlGbqhkMQOkJwZ0PF3jG4JRuIe
         i7wvYJRzchy9EPmYoVbqXKwf7JSxNNIoB43hXNxIn/Q4QNrIUw3Vxkf18pSPBnzibW3l
         6u0M80ydQuUtrqXBFb2K8aWPsqAn+/XoHwWw7L3Uk3NbQoeBfk+DJU4Lww1vd2yFr3da
         kx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKQM5vml6SlvXVBphY+FPvXDlacnwZjaLK4//iP66Rc=;
        b=g1Mp5ASgpROzskQAvHB1u66bDe63l3+JPpKTC8wDTSdhuGbIX28lqkw9Zj65SViVuP
         gEqz8zghc9O1/DgPRBdZNc1DoBwUsxdfLL3qQUOHapFR322wexB0M7QYYQvzrTUPh+8g
         ul4vc3SXoObSQJUJ4a2XXcaVQroa1jCntwEOtrxQ+cCIUr+zE5SkGhDkXmnaUcUCw+WN
         mjeiwsyiOpEiOJzIsMp/l4JDR8C4VXz768epLZCjfnXnZl2Ru8qyjlLj9Hskt9I4xGJy
         XosPCgZb319RKgd79ksWhHlP6oA1fMymyayy9AnSrrSLF+K452h992HTO4UzyqEYvYNC
         +8/A==
X-Gm-Message-State: AO0yUKVZMwlyb58cLC/u8PPMHM3F1DrMTHYqKuwVxFdL7dS9sUuzeKan
        3HUrDUz195+h2Gofd+y0Edo=
X-Google-Smtp-Source: AK7set9ELt2JOyjgVr4+8gniE1xArw7bOYKUK5RSQApxYJDzJ0/kzRDbUTtaVk55GHthACef4ci2vQ==
X-Received: by 2002:a05:6a20:1603:b0:bc:2665:cbe6 with SMTP id l3-20020a056a20160300b000bc2665cbe6mr5916806pzj.5.1675302157573;
        Wed, 01 Feb 2023 17:42:37 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:37 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 5/7] bpf: add new map ops ->map_mem_usage
Date:   Thu,  2 Feb 2023 01:41:56 +0000
Message-Id: <20230202014158.19616-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202014158.19616-1-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
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

Add a new map ops ->map_mem_usage to print the memory usage of a
bpf map.

->map_mem_usage will get the map memory usage from the pointers
which will be freed in ->map_free. So it is very similar to ->map_free
except that it only get the underlaying memory size from the pointers
rather than freeing them. We just need to keep the pointers used in
->map_mem_usage in sync with the pointers in ->map_free.

This is a preparation for the followup change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e11db75..10eb8e9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -160,6 +160,8 @@ struct bpf_map_ops {
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
 
+	unsigned long (*map_mem_usage)(const struct bpf_map *map);
+
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 99417b3..df52853 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -758,16 +758,20 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 }
 
 #ifdef CONFIG_PROC_FS
-/* Provides an approximation of the map's memory footprint.
- * Used only to provide a backward compatibility and display
- * a reasonable "memlock" info.
- */
-static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
+/* Show the memory usage of a bpf map */
+static unsigned long bpf_map_memory_usage(const struct bpf_map *map)
 {
 	unsigned long size;
 
-	size = round_up(map->key_size + bpf_map_value_size(map), 8);
+	/* ->map_mem_usage will get the map memory size from the pointers
+	 * which will be freed in ->map_free. So it is very similar to
+	 * ->map_free except that it only get the underlaying memory size
+	 * from the pointers rather than freeing them.
+	 */
+	if (map->ops->map_mem_usage)
+		return map->ops->map_mem_usage(map);
 
+	size = round_up(map->key_size + bpf_map_value_size(map), 8);
 	return round_up(map->max_entries * size, PAGE_SIZE);
 }
 
@@ -799,7 +803,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   map->max_entries,
 		   map->map_flags,
 		   (unsigned long long)map->map_extra,
-		   bpf_map_memory_footprint(map),
+		   bpf_map_memory_usage(map),
 		   map->id,
 		   READ_ONCE(map->frozen));
 	if (type) {
-- 
1.8.3.1

