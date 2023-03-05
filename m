Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A856AAF97
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCEMqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCEMqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:33 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB4EF91
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:31 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y9so3768254ill.3
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8UDH+wlPN8uSpySWEpYYit/mpYRRJI5xeMgR3o6Mx4=;
        b=QBgbiAgLpxSYBD5r/n6S0ASsKMv7ibET5mUUjhzDSSBiwQWICyrtPDto0lH83OgoM3
         SfgNJsr2xh3pvsjFnEXzOJkTOsm4B8PJ2EV7UKteKiEctld3Xk/JcPk+T7PkCdYV2gFN
         kPn5bcLhuCfIejZlv9Cdp4Y0O4fLnNmzfaTGFSd6FywVv6Km398QE3hikKC4LyQnfE9F
         Fc0MTy+W6dbX92oU6PkM82kqNSVKuQL353RjdGBfkzcdKpkiCkbUFciNStIzABjU5gnF
         Ytjs31g2ZgfXg+UCyXO9IIgZ92ZqBU9iqwjOGsFuWoiAakB1gus2O68OAvccZckUG9tb
         FspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8UDH+wlPN8uSpySWEpYYit/mpYRRJI5xeMgR3o6Mx4=;
        b=XdaWZyBq+oCRhC0xK1jOx/LcBoEUAht0V0pgHke8CZAl49SwYKUTLv47Z8+vYivPbV
         BEYVblqEf+1H11H66jEeAY2ZLmmiZqvUg2/VVjXDyXYkql/VSqwdUZRHOFgDDm18a3Cg
         Jbn42fY+I1WTve1eJlCcrZGYAt3svMqJHjYM6yHayF21ADEBl2sr2DRRsMLGdIPsndTt
         sy6zSSuAdUandc31k8/HSv2oMm+VYAQR9U75r/uX7sp/m5H0GWnR3Q8ydkdpzoalW+Aa
         LCbcGywbDa5UYyuIziEOY+DxXrTR/SbuX9RlGrR2QjJUVxRWhIHm7rT3MadoX5pJ+ujw
         VMDQ==
X-Gm-Message-State: AO0yUKWaWABDqjSp+UHx8Fozq2cmu6FOsDgmo/8EXdNiGKDF6B7GUWK1
        IqYSvC3d5TB7QQgvELn8qZI=
X-Google-Smtp-Source: AK7set8VGtH+41mg5WJip6DxKG5bCZBe4x1pKCf1mw1TPn6h1lJrX6I6fdLKzwvWH/A9JpSA3hYs3g==
X-Received: by 2002:a05:6e02:1b09:b0:315:34b8:4c6d with SMTP id i9-20020a056e021b0900b0031534b84c6dmr6666816ilv.17.1678020391001;
        Sun, 05 Mar 2023 04:46:31 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:30 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 07/18] bpf: ringbuf memory usage
Date:   Sun,  5 Mar 2023 12:46:04 +0000
Message-Id: <20230305124615.12358-8-laoar.shao@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/ringbuf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 80f4b4d..57b8896 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -19,6 +19,7 @@
 	(offsetof(struct bpf_ringbuf, consumer_pos) >> PAGE_SHIFT)
 /* consumer page and producer page */
 #define RINGBUF_POS_PAGES 2
+#define RINGBUF_NR_META_PAGES (RINGBUF_PGOFF + RINGBUF_POS_PAGES)
 
 #define RINGBUF_MAX_RECORD_SZ (UINT_MAX/4)
 
@@ -96,7 +97,7 @@ static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 {
 	const gfp_t flags = GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL |
 			    __GFP_NOWARN | __GFP_ZERO;
-	int nr_meta_pages = RINGBUF_PGOFF + RINGBUF_POS_PAGES;
+	int nr_meta_pages = RINGBUF_NR_META_PAGES;
 	int nr_data_pages = data_sz >> PAGE_SHIFT;
 	int nr_pages = nr_meta_pages + nr_data_pages;
 	struct page **pages, *page;
@@ -336,6 +337,21 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	return 0;
 }
 
+static u64 ringbuf_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_ringbuf *rb;
+	int nr_data_pages;
+	int nr_meta_pages;
+	u64 usage = sizeof(struct bpf_ringbuf_map);
+
+	rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
+	usage += (u64)rb->nr_pages << PAGE_SHIFT;
+	nr_meta_pages = RINGBUF_NR_META_PAGES;
+	nr_data_pages = map->max_entries >> PAGE_SHIFT;
+	usage += (nr_meta_pages + 2 * nr_data_pages) * sizeof(struct page *);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
 const struct bpf_map_ops ringbuf_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -347,6 +363,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &ringbuf_map_btf_ids[0],
 };
 
@@ -361,6 +378,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &user_ringbuf_map_btf_ids[0],
 };
 
-- 
1.8.3.1

