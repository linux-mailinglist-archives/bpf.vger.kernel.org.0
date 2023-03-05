Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7616AAF9F
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCEMql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCEMqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:40 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39FEFBF
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id l2so4799369ilg.7
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9yAL066kb5/fOCVw5E7uXU6m1iQadFMqnUoLomFIFc=;
        b=iIyQvJUaPeTbJt3LUNrdSyA+Oi2qf0dtbMoVwoFym4qSxucjkGPBerV6qkdweaHLxU
         FJBbe4L/HXI6k7HBlN1BgV6jZko4GxrfC9A5BK8lCtyPL2kEzoKno4lZ6pf+mufxVspV
         Swjf//RhEqm4dtMgilvxz+VB+EleohOENZH02KF1ssl+EupIwAabcNOdigDXpQVYJ91l
         uhW21zZb6WL6dsaSa3GNT5iQ2OCo09q7qhoUCC1RSL1Y2YN7hWrO9d4061zGnaNfzvuU
         iRYcOYd5uRsW4vUWrnFk6tCdznPC5YOplRkoTQUrZcGi1JBN5HTnroH8rln+ZuDPJEtA
         U4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9yAL066kb5/fOCVw5E7uXU6m1iQadFMqnUoLomFIFc=;
        b=BFzD2aME65CXJRMSHmnxvcLRBhQdUTDrn2PUDmobZXVcyUQZJ5f6b230qQo4FP1vwn
         wV2RgLKm/Ds7HcDHTU4f2eAVM5RsX1IZVm6Kt+623UDgXg8NLo9VDdWSsV/0FAXgM9pA
         7+dbh53jvIzLozAeBufwFdYXUmfVieduI6oNLrc8nMnTQvmAzwHH8WzlnM1ReYNbiFSK
         Mn5jHwnVEoduY0DGrthEJSXfLpvTaMeqmkr4ufleSUxvwpE7od27c49NdJlJM/gnRMO+
         a7QODBquQw36PPhtQx4I6qG9Xcgi+tPb8Ji+HX7fQlj/5wPeIunfk/dDPdJXovlYfbZR
         BKfw==
X-Gm-Message-State: AO0yUKUJs1poyyI5RIMLTczeyQyrsslXH+FFamKDmqKet9vy8lnNAglH
        GgogzQJvr46wAx8buBERWrg=
X-Google-Smtp-Source: AK7set/PWmr8MYw5pwBrQ00bcq5m+KZEilTBIcsh4nsOzHGI9rQv3KXAek7B+sRp9TjfMahpaX6G4w==
X-Received: by 2002:a05:6e02:16ca:b0:316:ecbf:5573 with SMTP id 10-20020a056e0216ca00b00316ecbf5573mr7894243ilx.12.1678020399122;
        Sun, 05 Mar 2023 04:46:39 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:38 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 15/18] bpf, net: sock_map memory usage
Date:   Sun,  5 Mar 2023 12:46:12 +0000
Message-Id: <20230305124615.12358-16-laoar.shao@gmail.com>
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

sockmap and sockhash don't have something in common in allocation, so let's
introduce different helpers to calculate their memory usage.

The reuslt as follows,

- before
28: sockmap  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B
29: sockhash  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524288B

- after
28: sockmap  name count_map  flags 0x0
        key 4B  value 4B  max_entries 65536  memlock 524608B
29: sockhash  name count_map  flags 0x0  <<<< no updated elements
        key 4B  value 4B  max_entries 65536  memlock 1048896B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/core/sock_map.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index a68a729..9b854e2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -797,6 +797,14 @@ static void sock_map_fini_seq_private(void *priv_data)
 	bpf_map_put_with_uref(info->map);
 }
 
+static u64 sock_map_mem_usage(const struct bpf_map *map)
+{
+	u64 usage = sizeof(struct bpf_stab);
+
+	usage += (u64)map->max_entries * sizeof(struct sock *);
+	return usage;
+}
+
 static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
 	.seq_ops		= &sock_map_seq_ops,
 	.init_seq_private	= sock_map_init_seq_private,
@@ -816,6 +824,7 @@ static void sock_map_fini_seq_private(void *priv_data)
 	.map_lookup_elem	= sock_map_lookup,
 	.map_release_uref	= sock_map_release_progs,
 	.map_check_btf		= map_check_no_btf,
+	.map_mem_usage		= sock_map_mem_usage,
 	.map_btf_id		= &sock_map_btf_ids[0],
 	.iter_seq_info		= &sock_map_iter_seq_info,
 };
@@ -1397,6 +1406,16 @@ static void sock_hash_fini_seq_private(void *priv_data)
 	bpf_map_put_with_uref(info->map);
 }
 
+static u64 sock_hash_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
+	u64 usage = sizeof(*htab);
+
+	usage += htab->buckets_num * sizeof(struct bpf_shtab_bucket);
+	usage += atomic_read(&htab->count) * (u64)htab->elem_size;
+	return usage;
+}
+
 static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
 	.seq_ops		= &sock_hash_seq_ops,
 	.init_seq_private	= sock_hash_init_seq_private,
@@ -1416,6 +1435,7 @@ static void sock_hash_fini_seq_private(void *priv_data)
 	.map_lookup_elem_sys_only = sock_hash_lookup_sys,
 	.map_release_uref	= sock_hash_release_progs,
 	.map_check_btf		= map_check_no_btf,
+	.map_mem_usage		= sock_hash_mem_usage,
 	.map_btf_id		= &sock_hash_map_btf_ids[0],
 	.iter_seq_info		= &sock_hash_iter_seq_info,
 };
-- 
1.8.3.1

