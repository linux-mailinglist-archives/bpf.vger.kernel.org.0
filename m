Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F076A45F3
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjB0PVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjB0PVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:38 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FD1C313
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v11so3535286plz.8
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9yAL066kb5/fOCVw5E7uXU6m1iQadFMqnUoLomFIFc=;
        b=JJnyhmL0ArCl0KtUokgLLK1cP4VbM887cXlQeeFqAevk2RUSevj+N+2Dr/ZTNBtqAo
         B8/UD+QBy+aejiVZ4MPr9/b1EX4nw/wBf/yCJJIugPW4i/hIDZMrwvTc8KfaPSOFWxkl
         lVRhtEhNLubNqCUjjQg1kzCA4aQVjt3NUNR8rItJmY1dm8uJCM7lvKdzD86YM8zoul7M
         +3lk1LLu0OZjdDDfRI45pK9qXM7E3pM/wgknyjYRuHOUToRgXaTfYrh1JmuQmjG5lxxn
         yJ3h32Vc+95Zx4XqxHv4GeyeflBducCkWV2ORXfdNBSKk64JDC5DJP2Y+Y0P9mtyPXyq
         Qo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9yAL066kb5/fOCVw5E7uXU6m1iQadFMqnUoLomFIFc=;
        b=TPHjpbOAf2km/ioBYSWCa0JwbJQoWMpKXaxxf1nChlevlYwubHSOVKgkESeSt0PUsN
         EfH+hG9BeCCBpl2dkb6f756U3Uud+qnlMmpL2azP8xlBsYNfG+tzPtC62Uv8hpZDNCfI
         m15ilyMDZqrj4LVj3m+DvwOqJ/h0GEx9GbkDjXudvV9ZVaOyYqQrQcfLBr6U1shVjdmp
         2jdIL5SzlD5+XU3liN9WIERZ9EFRAVJ3WAkmTFqqzEwKzeNcNV+U4Nllrc/UNzPjFIqP
         vRtaZpK77KdqGjOTbopABN3k6hNKeXc9z2kWbEBqqOHH1wP7py2BvcY1kKxMYOIwa1LG
         P3tw==
X-Gm-Message-State: AO0yUKWh4GTaRNGQnFSdO6SwCYIL6j3yMgCGRENm0zD26fK9aRNkCJQL
        aXnOl9KZTeek74JdTjPONZo=
X-Google-Smtp-Source: AK7set/8SHrzBsvj0xRZOw6FRftIOZqSKkp/EflQbKsQ8UzGe6NeKu2w1XEVbt4GMWjV9Y+nib5zSg==
X-Received: by 2002:a05:6a20:440a:b0:cd:7d01:7671 with SMTP id ce10-20020a056a20440a00b000cd7d017671mr2728956pzb.22.1677511297301;
        Mon, 27 Feb 2023 07:21:37 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:36 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 15/18] bpf, net: sock_map memory usage
Date:   Mon, 27 Feb 2023 15:20:29 +0000
Message-Id: <20230227152032.12359-16-laoar.shao@gmail.com>
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

