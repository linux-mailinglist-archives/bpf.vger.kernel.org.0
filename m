Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20A46AAFA0
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCEMqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCEMql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:41 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58738FF2B
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:40 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id p13so4783487ilp.11
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEqHGSzh4ebrLjbpD441xY6idCWwz84uueSdrYMosCU=;
        b=dDzEbLwfjit3gopVaJUO01+sxRx7VlFyGGRjxrQouHboSDzYXl7kcCMlc4o7PJfw+e
         qBFQ9kPtrlKU6zIAI3vXRzQ6/iHjDGPkU8ZgSGXy9tNvp+OFKPqgGU90WvnrhrETogMA
         jPbJRw8bioyaHFQBhKbsG42a2yCssT0f9jTiVjq/cxSxSF2zQSLraIirfVXdWE4qf0j7
         q6H1uccpAfGyyTg8OqS5U42waZL9M8yZ9qIMu4tXgd9S78U9/3YjRbI8+RO7TmHBHYBD
         MROyb3wdTyi2r+9Ec5twIJqgQsm47Auio3Ww4ETL8/05VHmxmx0b5T7vvj8ZdqEvzp80
         9JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEqHGSzh4ebrLjbpD441xY6idCWwz84uueSdrYMosCU=;
        b=DgbvNovK7mh4Vshe240I3GpZ3zKR2QpKkCp0MguQrEHYxK21Lay85Qf9gBe6etFgZA
         jd5xZ8bA97Q/3UDZN+24+HKxIpc1u3Iw4/UQikbPw+Q4Xor2Z/s/QaXGd3reWIUsKBY7
         bOdX5W7gzVRtqhjPn08yMzQyXOyiEEy4N+1pXOvB4ZfafhQ6lnbRV4hCEJ6X6wVl8uds
         8sr5W5gBjzQkhC0ckSkXzAkw/SIUpJ5RUQPhtoT+RGMsdd/f2m/mHsTvcheT4uiMI6YU
         SfOe20n+u/B0w7GKKsVuCaRWb4n/2RtInj9Qd5Q3KlbaST46qF5GdqV+VWPSZ3iLxR3B
         G4Jg==
X-Gm-Message-State: AO0yUKVyhmFDD1gu2Yxg6jRj5ranWKpaKSYbzeLCUFwvzBY/VYFGygs/
        Sdr2Br5kqCnQeHUKntJYFXM=
X-Google-Smtp-Source: AK7set9dQlfwanyXZ0TZv9cPZNQruxxPgJdbzE+prAM7280kNKWMmabBtaXdMDVGUQYc/h/QDJs3aQ==
X-Received: by 2002:a05:6e02:12ca:b0:315:8589:f598 with SMTP id i10-20020a056e0212ca00b003158589f598mr7534942ilm.6.1678020400126;
        Sun, 05 Mar 2023 04:46:40 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:39 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 16/18] bpf, net: xskmap memory usage
Date:   Sun,  5 Mar 2023 12:46:13 +0000
Message-Id: <20230305124615.12358-17-laoar.shao@gmail.com>
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

A new helper is introduced to calculate xskmap memory usage.

The xfsmap memory usage can be dynamically changed when we add or remove
a xsk_map_node. Hence we need to track the count of xsk_map_node to get
its memory usage.

The result as follows,
- before
10: xskmap  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B

- after
10: xskmap  name count_map  flags 0x0 <<< no elements case
        key 4B  value 4B  max_entries 65536  memlock 524608B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xskmap.c       | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3057e1a..e96a115 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -38,6 +38,7 @@ struct xdp_umem {
 struct xsk_map {
 	struct bpf_map map;
 	spinlock_t lock; /* Synchronize map updates */
+	atomic_t count;
 	struct xdp_sock __rcu *xsk_map[];
 };
 
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 771d0fa..0c38d71 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -24,6 +24,7 @@ static struct xsk_map_node *xsk_map_node_alloc(struct xsk_map *map,
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_inc(&map->map);
+	atomic_inc(&map->count);
 
 	node->map = map;
 	node->map_entry = map_entry;
@@ -32,8 +33,11 @@ static struct xsk_map_node *xsk_map_node_alloc(struct xsk_map *map,
 
 static void xsk_map_node_free(struct xsk_map_node *node)
 {
+	struct xsk_map *map = node->map;
+
 	bpf_map_put(&node->map->map);
 	kfree(node);
+	atomic_dec(&map->count);
 }
 
 static void xsk_map_sock_add(struct xdp_sock *xs, struct xsk_map_node *node)
@@ -85,6 +89,14 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 	return &m->map;
 }
 
+static u64 xsk_map_mem_usage(const struct bpf_map *map)
+{
+	struct xsk_map *m = container_of(map, struct xsk_map, map);
+
+	return struct_size(m, xsk_map, map->max_entries) +
+		   (u64)atomic_read(&m->count) * sizeof(struct xsk_map_node);
+}
+
 static void xsk_map_free(struct bpf_map *map)
 {
 	struct xsk_map *m = container_of(map, struct xsk_map, map);
@@ -267,6 +279,7 @@ static bool xsk_map_meta_equal(const struct bpf_map *meta0,
 	.map_update_elem = xsk_map_update_elem,
 	.map_delete_elem = xsk_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = xsk_map_mem_usage,
 	.map_btf_id = &xsk_map_btf_ids[0],
 	.map_redirect = xsk_map_redirect,
 };
-- 
1.8.3.1

