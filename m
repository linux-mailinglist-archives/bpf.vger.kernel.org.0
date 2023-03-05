Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91B6AAF9C
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCEMqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCEMqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:37 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69479EF8B
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:36 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y9so3768319ill.3
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8bqcj+fQi+LPKTwP58l/gYDYaKLYdssShQrHrw6wI4=;
        b=enkl5ENiyCDGmgWozJha2dGyDH4IeEnZ5mmxA58gDcAjtquO7kQPWkVkd8QbpsE/5R
         J/Y9UWkuN6Mo5V1cvbc+bcD99rLYCfZALjOaJH41ilkktUg+KE/47sq6d6+ol9jo0JHz
         xVJQai7VeSCRXztqpZHC/6tePvZa8bZRNajRmat+uwf3GvvCbyBQiG49b1s3BqSty+ut
         0h+PS1VTqsaxs/hm0s/j6tucWtgbmVvk7LxhlBUcpImG9QQ4Eu73z0KuFfaCV+KGlJLZ
         iDX4sgGh1lkY5sRm5cQxxWoNMrj/gfY1rN31CULvsoPYz1FMuvD87stKsKYsiUr4EBbE
         UQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8bqcj+fQi+LPKTwP58l/gYDYaKLYdssShQrHrw6wI4=;
        b=ONz6B/55l6861B2rMj2u/HsTzXEbiXdp1OT7nJxmbBBSBbS2Me27YoAiPyv55/a2WD
         chJayHIV3ZH1WfmfjWg4NWnrB0W/tqut+omKU0eEmFiyJveqxqR4JDjgZB9EntwrLavW
         XUiO3cmPKxg4cjbdKg3Fs5vg1RWrH1SdIjwgJWh7MkxYl8nQe387E4cs+nTBqr4I8TxU
         nx6QjsdHtA++aE+l3kDqsg6nQwrPeiBDShuLe5dgHRNOcEC8RFQTiOAZYwXqBKO3GG9D
         K7bT9FsGp/UokhSqwZCPLejxITVVOk5yrWxtlmJbfQs+41Lu4el+j27zt0DJq8jUGnAy
         A4LA==
X-Gm-Message-State: AO0yUKXGhyHTWgceXmRKcjus+1vg5qviiKMPrjY+gBA4GUfchhG19HY6
        FX4NyXjB2n0ve8dGvCs0gk4=
X-Google-Smtp-Source: AK7set/TR1tFS7bzgwkJGxHuTU+WWw4mzvSi4vbtqeT2iivhnmAmPJeChi5paT0lENRazWBw+t2jrw==
X-Received: by 2002:a05:6e02:1d83:b0:317:b8a5:6d2d with SMTP id h3-20020a056e021d8300b00317b8a56d2dmr7266301ila.17.1678020396102;
        Sun, 05 Mar 2023 04:46:36 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:35 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 12/18] bpf: bpf_struct_ops memory usage
Date:   Sun,  5 Mar 2023 12:46:09 +0000
Message-Id: <20230305124615.12358-13-laoar.shao@gmail.com>
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

A new helper is introduced to calculate bpf_struct_ops memory usage.

The result as follows,

- before
1: struct_ops  name count_map  flags 0x0
        key 4B  value 256B  max_entries 1  memlock 4096B
        btf_id 73

- after
1: struct_ops  name count_map  flags 0x0
        key 4B  value 256B  max_entries 1  memlock 5016B
        btf_id 73

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ece9870..38903fb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,6 +641,21 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	return map;
 }
 
+static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	const struct bpf_struct_ops *st_ops = st_map->st_ops;
+	const struct btf_type *vt = st_ops->value_type;
+	u64 usage;
+
+	usage = sizeof(*st_map) +
+			vt->size - sizeof(struct bpf_struct_ops_value);
+	usage += vt->size;
+	usage += btf_type_vlen(vt) * sizeof(struct bpf_links *);
+	usage += PAGE_SIZE;
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(bpf_struct_ops_map_btf_ids, struct, bpf_struct_ops_map)
 const struct bpf_map_ops bpf_struct_ops_map_ops = {
 	.map_alloc_check = bpf_struct_ops_map_alloc_check,
@@ -651,6 +666,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	.map_delete_elem = bpf_struct_ops_map_delete_elem,
 	.map_update_elem = bpf_struct_ops_map_update_elem,
 	.map_seq_show_elem = bpf_struct_ops_map_seq_show_elem,
+	.map_mem_usage = bpf_struct_ops_map_mem_usage,
 	.map_btf_id = &bpf_struct_ops_map_btf_ids[0],
 };
 
-- 
1.8.3.1

