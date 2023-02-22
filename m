Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9417F69EC7B
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBVBqt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBVBqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:48 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329232E66
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 132so3309066pgh.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEfQ8gbb6YM9AUGhgYD61SWx4aCRStdaB4FDTThUGWI=;
        b=kCR+ZePVvyQz4rL+yEZP8kqFbfZsay2S6d4IMpDJVH6yJwu5+YY1dRKxjGd4T1Ps3E
         9c93jB5nGCjJLz9HR+8q4Ah+dBpJaWOuTfEpOWbEpDA0uUOb477OmNtRdQ50wVLqeD5s
         oGiQBaC84fH0UXWVNaMZrzHOc3LudgPW1RSE8W6cdJtJpBxGCZktyAqUm7iu6R6UgN+u
         0HaQVvJM2yQGY5XX2zo6sSaVAH8/T/F5O7qCGj03nVtLb59ZCuPP5cWz87LAEDCg2BKI
         qjeIu6K2NWApJE7ZuD8MtXV6Gv/fBUPHlZac5Wti8oJSutm4eMBb0JRyaESpmi58aCUe
         YlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEfQ8gbb6YM9AUGhgYD61SWx4aCRStdaB4FDTThUGWI=;
        b=HttkaP8Sc0Jb+RTJ0cGgvsC3AC0gR5G4xGmTxFreQpR/3UiVjsWhGTkGZgS1Em7B1b
         V4/j/f2aQ3kxNB30IzN+Lv4qK+bLHWqvoW9G7iGcCFdgtZbtRqRLLwOyScZCeSNMzfUi
         Zst0ZljP57SsmlsUil/SmW8O1BUnqZe02oPj3kZ3fP6M5pkGXh14/PqrrbAtzdvwXbla
         tP36R9X2yNaEQYMAYCpKDrRLCzFpIOSH6GjzNy7Z8JhO8qGmM8dD4pSPHOVeyu7pDBTh
         FhVfsK02U3EUHRzBMQjDFbpDdACAPS09jHlETaRo42LGCJ2YkEQ31vidUzq4JGjAjcUe
         AfYQ==
X-Gm-Message-State: AO0yUKWwbrnFoac2V7seyBywPemSShhuNhcg+dqskdVNefYNMKFEEgWj
        j+n77o/qlo/GMuceRvoMgYA=
X-Google-Smtp-Source: AK7set8LdJyJrYD+kym21CdYtRgXGV275NgF1/U1gYQfUE0E2ZLEtIHoaikicptQXtDKi+OGAOq5ew==
X-Received: by 2002:a62:3004:0:b0:5a8:4e9c:32a9 with SMTP id w4-20020a623004000000b005a84e9c32a9mr5912833pfw.32.1677030407329;
        Tue, 21 Feb 2023 17:46:47 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:46 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 07/18] bpf: ringbuf memory usage
Date:   Wed, 22 Feb 2023 01:45:42 +0000
Message-Id: <20230222014553.47744-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
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

A new helper ringbuf_map_mem_usage() is introduced to calculate ringbuf
memory usage.

The result as follows,
- before
15: ringbuf  name count_map  flags 0x0
        key 0B  value 0B  max_entries 65536  memlock 0B

- after
15: ringbuf  name count_map  flags 0x0
        key 0B  value 0B  max_entries 65536  memlock 78424B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/ringbuf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 80f4b4d..2bbf6e2 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -336,6 +336,23 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	return 0;
 }
 
+static u64 ringbuf_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_ringbuf_map *rb_map;
+	struct bpf_ringbuf *rb;
+	int nr_data_pages;
+	int nr_meta_pages;
+	u64 usage = sizeof(struct bpf_ringbuf_map);
+
+	rb_map = container_of(map, struct bpf_ringbuf_map, map);
+	rb = rb_map->rb;
+	usage += (u64)rb->nr_pages << PAGE_SHIFT;
+	nr_meta_pages = RINGBUF_PGOFF + RINGBUF_POS_PAGES;
+	nr_data_pages = map->max_entries >> PAGE_SHIFT;
+	usage += (nr_meta_pages + 2 * nr_data_pages) * sizeof(struct page *);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
 const struct bpf_map_ops ringbuf_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -347,6 +364,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &ringbuf_map_btf_ids[0],
 };
 
@@ -361,6 +379,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &user_ringbuf_map_btf_ids[0],
 };
 
-- 
1.8.3.1

