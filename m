Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9F69EC85
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBVBrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBVBrW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C402132E74
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u10so7165717pjc.5
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEqHGSzh4ebrLjbpD441xY6idCWwz84uueSdrYMosCU=;
        b=T8CnC9DdTBUhrEL1XkEQJxIUD6h57d+PI2z/vMBjUSy7hR+wPQXQTM+K4Ky/0C+q5U
         3DRxd70ZmHG250EyV20hLlIPytD+0cp0x8joZ8qDp4c8g/jRcvk1i61mLrFsPomzXJ07
         JM26mRw0z9xfxTipW1eIaXUf2pIHT17gnzRwy0wTsMnOuL+UQgnNTZ+8F0clfvyAhuwP
         MiNVE1IcmcG6dFp+o9K6GL6qs9MnogJtSuEk7OTFJqX3VRgrsQm+wU5v0H+DU8x1uVza
         QHTc6DppmvMgX9mUzFVqFtlXZa69LfI4Z0Z4xps2/6KGN8sfKi6Lj0A0eYMO8i3JmMbD
         Setg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEqHGSzh4ebrLjbpD441xY6idCWwz84uueSdrYMosCU=;
        b=FciDBrUqy1Dr4nlMFHXgCPqQoiJ9Zg828bBG7aK9VpCV8dKlLH4WSN1tRH8RSEKxGP
         SAAqkKXR4VfrkzrRmB8u9I22Nc2uK44gE2DZDjg3JODIMowIRw3Ls4qIxNZ5mMSsUepg
         7rd3A2VR7tL44sdO4YFh/Txc7I4gINl+M9tE3/WSWbTjkx8ETM9UtBCw46sEPOUoqLMA
         Wkxk2dWQy1jp5zcDufKcz2Ur4+1qLNekPT4hZf8nF7nUDaMfNlvhHHYQulp9xYHHNrO3
         dZI+dMycR9ZxIgthxFYaXg6Jqv3vFQAZ1rhp1dzlu6HZz4MbChN+CXeED1Qm9+PoJREC
         MNfg==
X-Gm-Message-State: AO0yUKUqVpe9OyJGyKqvI8oGAqt5Zr+F4/slLwZxbZeD4TDPWOrfqgna
        xnr06O/8dKtM/GMZo6TKVEE=
X-Google-Smtp-Source: AK7set8nN3gEKWCyS22LZRMeNz6WAdAtO74iwizsw4t9wTfr0dmSErGgIh/HzPYk9QSVNDptAjYQ3w==
X-Received: by 2002:a05:6a20:6985:b0:c7:499:4008 with SMTP id t5-20020a056a20698500b000c704994008mr7650305pzk.34.1677030438282;
        Tue, 21 Feb 2023 17:47:18 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:17 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 16/18] bpf, net: xskmap memory usage
Date:   Wed, 22 Feb 2023 01:45:51 +0000
Message-Id: <20230222014553.47744-17-laoar.shao@gmail.com>
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

