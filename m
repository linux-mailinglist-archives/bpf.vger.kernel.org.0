Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7258F6A45F4
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjB0PVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjB0PVo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD011E1E3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so6544709pjq.0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEqHGSzh4ebrLjbpD441xY6idCWwz84uueSdrYMosCU=;
        b=WTVuUqHA9nDmp5UBiufbO5/RpcybHmWsCD5kgmWw+48sIluAS2EuXQy5qlZq7XvAL2
         29zpK5/HZAVN4o38za1ifi7glqjwiiNQML6VMk3zaCr8EOPk//VRscEoEsG4HY80T/+q
         1o6UgbHbf2AWpMZgLMaZ8u1EA3DEmsKXOgYyExoKBTuNC9c/1CgOdjZSHXCFqpdoSka3
         nDfflWrUBOGqDYpgw8BS5iI9HxvuFR6MA5QkCie9A6sRMcTbHMtcfrpFBkf4oEV8vRJG
         qPYo+oTwmo9/4jPIH5RHrXITSDdn5o9kbND2cA5C0LwmyMgT6sSah/vsoftQ/vNsb/g+
         Z4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEqHGSzh4ebrLjbpD441xY6idCWwz84uueSdrYMosCU=;
        b=BgpX4flmOA2hHCVDNk2RsO/IgdLrHSxsOFOvJ6OcjRnmfpfK2Z1ZrgEt6HGskic7/C
         XA5etQWdWNCwXxt7knZXGnahF1d/dvO/JoyRNWn6oiPFR6/o+6QRfWh83H+nInPtd4x2
         mMDUeYFRKJgI+mW1GrMFakT6c23kq9Bzi7pksrf3u65Cqj+YRK4Pkx5nZmeO9dFkSYUl
         ucqYRQVOA84B19HVfq27II+XUxxTAsM6K6ZIxQJvyIB6dGndzoER+QVGyXv7ZbZUVp1S
         VOPPONjC6pSLTzsMGiPZYxFpodiT96oM53FE07VylvxhXcjdCmtNROA+pKsaVLkyT3t3
         J23Q==
X-Gm-Message-State: AO0yUKWQfPTbijQGLXopGtjh0DALjv9UROiZdzd/IzQHhd2oLReV3ROQ
        IHYIpsnYaPnycI3UxVEogyc=
X-Google-Smtp-Source: AK7set+t5Mn3pHM+HlZ5y8OvC3sMphhSd8L8VWbG/voPAK4hfYGmtLyoSOFFhAiG+4Ra1kB94AnQGw==
X-Received: by 2002:a05:6a20:12c4:b0:be:d4be:50a2 with SMTP id v4-20020a056a2012c400b000bed4be50a2mr32218535pzg.32.1677511300908;
        Mon, 27 Feb 2023 07:21:40 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:40 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 16/18] bpf, net: xskmap memory usage
Date:   Mon, 27 Feb 2023 15:20:30 +0000
Message-Id: <20230227152032.12359-17-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
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

