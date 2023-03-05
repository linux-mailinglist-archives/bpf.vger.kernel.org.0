Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375D6AAFA2
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCEMqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCEMqn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:43 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516DCEF8F
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:42 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t1so942878iln.8
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IX58MH2QLoXhpmV/zJOVM+Ywg98JYzy0v23r4fWWAo=;
        b=U7ZVKK79PWpLTOb8M9fifa50phlLR/LB6xE1iqGAemhL1PICF5TN9AD1PQMHz+/SGS
         2msGJIZ6vkZ2tyEi5VyMtGCTn+GL2a7I8mCpXKpb8U5AFEnZpWQs0dDxH/7FG8lbSYMN
         8V3iyM4MxdEHofFC/FyN5WiH3rVS1RL7u3XTyPrSxlw/+TuhR91BTdUKyhKEJE74Zd4G
         kVe7z7HnJlmqkjfcan8G95fpFCs0R8knPvogd4KLRiHBxHJ0BIH5mZY712/3If1Re1ql
         8c/vi/hK2e06T5Il7igOh5FJz7vkzWjRUwEhm4UCpQ5AnnlzAisJDBccwhB4ZciymXNz
         3HdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IX58MH2QLoXhpmV/zJOVM+Ywg98JYzy0v23r4fWWAo=;
        b=ZHI7xPapsjn8ovLSf9w/MM7HxfhjtMo9swFvElyhqJojvtU6d34/vm/3L2eQVgNzSP
         jGEkhOoJ1gnGQB8PrX07KAGn/ZYdJCdbj5pyOLZWyN7RJF08FvQZGOy3H2YhX9ZByZF1
         XKoeAIaIG7IFPbH4HNAgrRV2HUBr3lx8lQrcRGFvDOGjIQ5Kgh9l0Iz+X/gBTBatNF4b
         AP0ofAmtWX9sSqB/6hz/rnNT6M4pDqzGo29pi/KAmfnAs47NxCyukyi3oWIwwB3D0CPO
         nDGT76vWsG84Ds2AMczLShpL/lxtAWdV4ImNa001RUR/wpnsZPUkhRtdYvcWR7tdtz5q
         Dy1w==
X-Gm-Message-State: AO0yUKVssFyqH9PMDNIZ0b1jZxbnEsILJCepbQMZAW/AnS/bBo3aAFe9
        9bX+0EgCmNeQ6rOUY/FLjF36rDf2TbBVt62LexM=
X-Google-Smtp-Source: AK7set9Yp3QuAqdeVlhRpreVDVq84HYzC++mxeM8a4bkdjAMoMnwrqnNB7xqMI967mKHoMVwJYTh7A==
X-Received: by 2002:a92:1a43:0:b0:315:40d1:62a3 with SMTP id z3-20020a921a43000000b0031540d162a3mr5767228ill.24.1678020402041;
        Sun, 05 Mar 2023 04:46:42 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:41 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 18/18] bpf: enforce all maps having memory usage callback
Date:   Sun,  5 Mar 2023 12:46:15 +0000
Message-Id: <20230305124615.12358-19-laoar.shao@gmail.com>
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

We have implemented memory usage callback for all maps, and we enforce
any newly added map having a callback as well. We check this callback at
map creation time. If it doesn't have the callback, we will return
EINVAL.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3532c1e..da1e762 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -129,6 +129,8 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	}
 	if (attr->map_ifindex)
 		ops = &bpf_map_offload_ops;
+	if (!ops->map_mem_usage)
+		return ERR_PTR(-EINVAL);
 	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return map;
@@ -775,13 +777,7 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 /* Show the memory usage of a bpf map */
 static u64 bpf_map_memory_usage(const struct bpf_map *map)
 {
-	unsigned long size;
-
-	if (map->ops->map_mem_usage)
-		return map->ops->map_mem_usage(map);
-
-	size = round_up(map->key_size + bpf_map_value_size(map), 8);
-	return round_up(map->max_entries * size, PAGE_SIZE);
+	return map->ops->map_mem_usage(map);
 }
 
 static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
-- 
1.8.3.1

