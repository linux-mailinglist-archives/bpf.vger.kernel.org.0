Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01C6AAF96
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCEMqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCEMqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:31 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C281F74C
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:30 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id r4so4824383ila.2
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQuLzFY+KbTi70OVyTdLGmPLsVqTEok0qqP2ZiCsjVY=;
        b=m0SUc1/ZbIpfsNFM9e8SiSTidFUB7dKzzulYlEUp/e13nIQ0zN108kyGuGh/Cc3JBD
         6eLQ0SIJ6zW9KEbcTfwSxA3cIiEcgzsfAo1rJ59aNpQ1NHzY8/DMrXTCVG1tmJ+uwsfS
         0tTshksuZnc1p+yHMLFUz7VqtAyYmulbY0kmS7sB50XgDNzY6LokJW8UqAphpvbw+4O0
         bNbyvA0D5yzAuolZio4BvAZ4FQiCPeMTztIb26yK3RdNOlcvWNQPLQ0gIdxeBxgQ6YXg
         0U0l1/caJ6Teym0wn6uygMz60+oJQzHlAn3cD5qbAdJklqZdRBSEiZp3tLRGbmrzfT7O
         X45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQuLzFY+KbTi70OVyTdLGmPLsVqTEok0qqP2ZiCsjVY=;
        b=givITCPoFx+AX4Vv+Saz/HsLYqdcpgCdP36/uSEiS4zlViuNZ+RJmk12PvLmZLHoYO
         EalOwynlq1QrnAksDXY6lQA7Vk8Ww1aW+nrdbu3n/+ThbsXr7rr9CRqxwS5gHLqWVLaD
         if50YucHl/0p385ACPh//IZ5LSZC+s9R6pLFr6Emx0TK7qBFM7fcVagQq3geseAvj58Y
         1fSJVyeMA1+j1Y9R7aPyBTzbYbKxPs1SrT+BFDv+ZP6CO5tENGFNmfGaj908RnSDEQkf
         RJAuYv9cigXCZ9hyUfsp+vK4zJA3vzCXacEkY7X4HvQedc0QQNKkfo+xjDrFZJUTVyz7
         YzBg==
X-Gm-Message-State: AO0yUKVkYsBDvefPA24/KY7nQqGgr6jfFx60vps9CkxfRLZ7WNX5GIlb
        Ie8jnmLGE4JydYgMvGGDQmk=
X-Google-Smtp-Source: AK7set8vpt9Lfg4vcQlD+moY5p5C+AF3JDwmTTLbJuNidEi2xTTwmIh3ykvyA0nUOq1aV1lmVrwFAQ==
X-Received: by 2002:a05:6e02:1945:b0:31a:1554:b0a with SMTP id x5-20020a056e02194500b0031a15540b0amr6468417ilu.10.1678020389889;
        Sun, 05 Mar 2023 04:46:29 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:29 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 06/18] bpf: reuseport_array memory usage
Date:   Sun,  5 Mar 2023 12:46:03 +0000
Message-Id: <20230305124615.12358-7-laoar.shao@gmail.com>
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

A new helper is introduced to calculate reuseport_array memory usage.

The result as follows,
- before
14: reuseport_sockarray  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 1048576B

- after
14: reuseport_sockarray  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 524544B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/reuseport_array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 82c6161..71cb72f 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -335,6 +335,13 @@ static int reuseport_array_get_next_key(struct bpf_map *map, void *key,
 	return 0;
 }
 
+static u64 reuseport_array_mem_usage(const struct bpf_map *map)
+{
+	struct reuseport_array *array;
+
+	return struct_size(array, ptrs, map->max_entries);
+}
+
 BTF_ID_LIST_SINGLE(reuseport_array_map_btf_ids, struct, reuseport_array)
 const struct bpf_map_ops reuseport_array_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -344,5 +351,6 @@ static int reuseport_array_get_next_key(struct bpf_map *map, void *key,
 	.map_lookup_elem = reuseport_array_lookup_elem,
 	.map_get_next_key = reuseport_array_get_next_key,
 	.map_delete_elem = reuseport_array_delete_elem,
+	.map_mem_usage = reuseport_array_mem_usage,
 	.map_btf_id = &reuseport_array_map_btf_ids[0],
 };
-- 
1.8.3.1

