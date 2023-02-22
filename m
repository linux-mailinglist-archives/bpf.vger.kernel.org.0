Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0369EC83
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBVBrR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBrQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A932E5B
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n5so3802171pfv.11
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9yAL066kb5/fOCVw5E7uXU6m1iQadFMqnUoLomFIFc=;
        b=JkV4rFFJ21kllRKZbjZqGoVv0BtUXFV9xT0y4LhzyzaPjix7u1dqVjLSk/4a1rfW4V
         bztDkawcoZKReWkIbWAX8O3xydIOC92icXJF1Oo8kXECMd4O3250bQgDe1pa1ybVrpP3
         Y8wAvThIuwerC1q1sk0wVHxcBBHwT+Jb1/Gb5SsDksuJn/R+yDKpX7ziGuj23xklNG1G
         J82SE26W56+lAJL86PVFGtuMF75ipqDJa/LkCb2grUYydsNnc/VQXnjaEgQbuLFvdbdp
         b86FZQl1+weN2j10n8xRBOW5Y2k517DZWOYIqASRFMvesJJrFTztaFjFxU0fAOcdIX3B
         1Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9yAL066kb5/fOCVw5E7uXU6m1iQadFMqnUoLomFIFc=;
        b=T/BqGV3HaixPtP69Mqwq6+aYxy5P/TpP+WzLLVJQFGruBXDXDOLDka0pjr1jFvYStX
         zCIcwWl/4MYTGkemIGGHGnhyB3mIYCCSUVgs8UfLjlSdKE0jJRFzQanOe9uSziY/X4kB
         SuXTjeKT/wJPBB4THuF+9oT10d1+fYmirTIPPZScxNDJnPJdHcV8zMUNEYvrBsAiVwtp
         NGvaIgPZOP9dg5AkfCA5+Hj57FiDlILtOccYt7GbuERDsxnx65kEhMOW4zwDDcqvx3gP
         qNjZ7mvhBBrNRBKP254wmdIomZwfepkzwWpRgCV2uIjgHEQ2xI1O9zxt2v3scmzJ3+V8
         xPOg==
X-Gm-Message-State: AO0yUKU2kj8QL7UCv91AuGsE2qZcl44GJ4ls05lE1EyadRw4cC7bkLBI
        3sIwnu2ohekMOCNB8wdBRJo=
X-Google-Smtp-Source: AK7set99X4dPB2QdjA/YHG3xI0AsP1nt4i+zPtIoThn/0PA4SmFtO+PQ/k9D6OsqemB+STTAiiapuA==
X-Received: by 2002:aa7:9543:0:b0:5a9:c797:a1d6 with SMTP id w3-20020aa79543000000b005a9c797a1d6mr6132154pfq.2.1677030434744;
        Tue, 21 Feb 2023 17:47:14 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:14 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 15/18] bpf, net: sock_map memory usage
Date:   Wed, 22 Feb 2023 01:45:50 +0000
Message-Id: <20230222014553.47744-16-laoar.shao@gmail.com>
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

