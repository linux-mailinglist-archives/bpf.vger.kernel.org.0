Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3FB6AAF95
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjCEMqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCEMqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:30 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841DAF741
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:29 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k9so4289664ilu.13
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQHwjTJNmWcaYoQZxEEd3KAAGtFjO42sdOiYOa2Xw5Y=;
        b=PqOZJnFrDB86cB7btPiL6nolTzkufEP4VayhsRlUwPdZHZBcpwwLc5HZ/6Q3Hxl9C/
         buLvHBYpOmg8Fed4RA+oKLNqje54kJ8S8fQMmC6FUcCr2RWn9TRSjbLKG388agJDCy68
         zg1fjYc+Vk4sJujxTgNSaLHoJt6qkeqhyvpYC0ZFzPAan0K8Crpy95y7YvL/7f+jlrol
         NnrJaStC0DH4lV5Cmkuj//v5HPJAHWyvIbuhFdHPEvV7sIacyPIq4zowl4pr5s21wT+v
         cHoMW8MET5x2o/mi4n28Kjtf3gZL7VJnPS0VAwZDV8oMq8RONLXP7LuRBSc1SsfwCGO4
         9iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQHwjTJNmWcaYoQZxEEd3KAAGtFjO42sdOiYOa2Xw5Y=;
        b=GMG3JKuVzLYQxXrCw6/0vpU8NskTJcWppLOZz8DUUvB73pTyQJNARFdTh+MI3ouvfz
         dTY2lVK7bQkcdgTYR6Zx0AhBjFS8Zsol6CVFab8ZuBYlMr26anwGJq430FwX9ETsXY6Y
         kFgWZ3CQOq/8Xcwpg1VySJq2qcGmq8EvS+BQRJYrzX+dqE3FfjrkS4cPCv2eWI8RksBw
         xQxzeVEnq2XjxJzpehz5Bum2a4/wmMjrdVIyOENgHOPo+fLKcnPvwwcT9mcEXWl4f4l6
         18H/RF/2d/FTL7GTSXTNfgJuL5wdsJdkppCmVvo/zSRRioS6wrzJqn5FkDGAk+mhlmvX
         Z+ew==
X-Gm-Message-State: AO0yUKVycnGamD0uOUFIwWmUPrA8VespGPXQ1aQKyTUtQwEQag1UGHiw
        OwycH4K66NHyop/oZqzHOqs=
X-Google-Smtp-Source: AK7set9pGyP7wOtEyM+cVf+Zvo9fNmNxQ1bZjs5an1Oc+ILBlslGoZMqxE/dZSX29W0QL2IffzdJ8w==
X-Received: by 2002:a92:b509:0:b0:317:9d16:e6bc with SMTP id f9-20020a92b509000000b003179d16e6bcmr5873233ile.5.1678020388893;
        Sun, 05 Mar 2023 04:46:28 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:28 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 05/18] bpf: stackmap memory usage
Date:   Sun,  5 Mar 2023 12:46:02 +0000
Message-Id: <20230305124615.12358-6-laoar.shao@gmail.com>
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

A new helper is introduced to get stackmap memory usage. Some small
memory allocations are ignored as their memory size is quite small
compared to the totol usage.

The result as follows,
- before
16: stack_trace  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 1048576B

- after
16: stack_trace  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 2097472B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/stackmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index aecea74..0f1d8dc 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -654,6 +654,19 @@ static void stack_map_free(struct bpf_map *map)
 	put_callchain_buffers();
 }
 
+static u64 stack_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	u64 value_size = map->value_size;
+	u64 n_buckets = smap->n_buckets;
+	u64 enties = map->max_entries;
+	u64 usage = sizeof(*smap);
+
+	usage += n_buckets * sizeof(struct stack_map_bucket *);
+	usage += enties * (sizeof(struct stack_map_bucket) + value_size);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(stack_trace_map_btf_ids, struct, bpf_stack_map)
 const struct bpf_map_ops stack_trace_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -664,5 +677,6 @@ static void stack_map_free(struct bpf_map *map)
 	.map_update_elem = stack_map_update_elem,
 	.map_delete_elem = stack_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = stack_map_mem_usage,
 	.map_btf_id = &stack_trace_map_btf_ids[0],
 };
-- 
1.8.3.1

