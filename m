Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6867D6AAF91
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCEMq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEMqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:25 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E61E057
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id l2so4799183ilg.7
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MafW7bXPA88fHr/WGC7tIi2znNqlfrWVpdbFx7QF1LE=;
        b=V8YuuQhIY0hw+e4AFuP0jQwEV+lVJpKyGATSgl333vPw96jO6aV4jvc7d9YK2My5HR
         vgqAAxGvllpypoicDVp1rEsYGdwymbQ/LchzzWAEaNCAZ6wc+cAwlBhRzDJdfJtOqaYG
         fJvyIUIZdfaGY5naFrUFAX4ybtdYjicVgEYfQ5TFihyBc5g7uZiS5xTwYvJ4ZYYyT+1k
         bkMiqf2sytlMF5r4n3x+Eh6k0ybwI2YZPdOOIJ/uFvOqSp4TH3GI+jAfBETxTxZJZbvi
         skgyZb3Mysp2L1BqcWTAOBAL3idiAKniIXqhqVgBgGm8x0seNF2cCTpbSOxnGggEJu/f
         o2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MafW7bXPA88fHr/WGC7tIi2znNqlfrWVpdbFx7QF1LE=;
        b=XnJOYVYzrmHaQ953zHN6gxhP7PHaxa3Qb2OvmfaKcwcK4DWHq2uE2C/pulTBh30O2t
         6cj1IfhdScGuDpE0qaxaY/JrdjLIKJFjs3jqu4hII9A0P8xoY8v01DI0f/ODI9kBuzoq
         jxAiO82tjaYwmT6RQhjVjfnpmWg2unNbwCAwawXPpV2l9uFAUKBXfc88FA3HHZ0ZHu1J
         Rbu0JuSEQ05CgIZLUCl5lJ4uts1qegXs8Ds4t+S6jdetMf0tOPLmhA4NPAnFY5mhf9DY
         3SiPRLcVO2Xg0mYthBURmwXjVlLlUGl7XnqnkOoHb7+FguCzNznx8CAJ6zNBU9AvbegZ
         5kHg==
X-Gm-Message-State: AO0yUKVdXhGcygSR3XnKmCkquoyuDRjjaOVX6dItPRSF+UI0EFTN04tO
        q/c4elx/fBBgz81ImocBMyo=
X-Google-Smtp-Source: AK7set9X+oGneEQ0wWXIrHjNSZ8t+BZ8R7PGyWDJK99ZF2w0E9Vl4Z4hvJ64akRxRfA5NiAtwBeKBg==
X-Received: by 2002:a05:6e02:811:b0:314:27c:a730 with SMTP id u17-20020a056e02081100b00314027ca730mr7423321ilm.0.1678020384035;
        Sun, 05 Mar 2023 04:46:24 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 01/18] bpf: add new map ops ->map_mem_usage
Date:   Sun,  5 Mar 2023 12:45:58 +0000
Message-Id: <20230305124615.12358-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230305124615.12358-1-laoar.shao@gmail.com>
References: <20230305124615.12358-1-laoar.shao@gmail.com>
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

This is a preparation for the followup change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d345680..9059520 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -161,6 +161,8 @@ struct bpf_map_ops {
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
 
+	u64 (*map_mem_usage)(const struct bpf_map *map);
+
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eb50025..073957c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -771,16 +771,15 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 }
 
 #ifdef CONFIG_PROC_FS
-/* Provides an approximation of the map's memory footprint.
- * Used only to provide a backward compatibility and display
- * a reasonable "memlock" info.
- */
-static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
+/* Show the memory usage of a bpf map */
+static u64 bpf_map_memory_usage(const struct bpf_map *map)
 {
 	unsigned long size;
 
-	size = round_up(map->key_size + bpf_map_value_size(map), 8);
+	if (map->ops->map_mem_usage)
+		return map->ops->map_mem_usage(map);
 
+	size = round_up(map->key_size + bpf_map_value_size(map), 8);
 	return round_up(map->max_entries * size, PAGE_SIZE);
 }
 
@@ -803,7 +802,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "max_entries:\t%u\n"
 		   "map_flags:\t%#x\n"
 		   "map_extra:\t%#llx\n"
-		   "memlock:\t%lu\n"
+		   "memlock:\t%llu\n"
 		   "map_id:\t%u\n"
 		   "frozen:\t%u\n",
 		   map->map_type,
@@ -812,7 +811,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
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

