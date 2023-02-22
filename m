Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50F169EC79
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBVBqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBVBqn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6332E71
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 132so3308963pgh.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQHwjTJNmWcaYoQZxEEd3KAAGtFjO42sdOiYOa2Xw5Y=;
        b=pOFSnBoX96ii4MPld6KlU8FNSrAAy5Pq1QtvjZzIFtf4M/W+kOUlD7yrGqdnuSlmh3
         /yODM1Q8H/9kOGqkdjRzd29vMRDcmc8ktg6W3iKKrzFSv/JyKw3w6G8OUCHo9QlBNptx
         w8C3tkJv7nQECib5P1Muecy7014MozMo/55WwbezgNvWx/+dOA9amVvpZ7yynsFZbWfl
         BAvjof4f+PmqjzaAb8qO0LpG7vj/6rdhU5VKnxJgYiwyGZp6Qu1YwUqR+N8Z5CJ+E0yP
         aR99v+VQ+BHS2EkyUtk0PCqiTymknrKzXXgxbxt1VNhgZ5L9CZwQKqwRLjQqNO2JJvbH
         AY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQHwjTJNmWcaYoQZxEEd3KAAGtFjO42sdOiYOa2Xw5Y=;
        b=Q5SI+V9e4brdRkhRvYkb0Uk20nq/RpZPO9Gxkw1iWFwA6NdurGUPyL5Ywe0H0iRUYX
         UbRDb6NGyaWgfgiAOLUOJu9pXttk+8ZCXarUNBRN9EnhURKTy94+C9IkE1ZSx6LbIaap
         sCBNGnbu95gJV9en5CkZhvfQI8pvYUuMN7/0q+y5Mb06HRrDPQgucOyktTIgiXKMXtzS
         nbRthZq9Up0kaZMBCvbOECwywbxotsv1ujn+QnPnd4beJ1b/Sk2xDcMntm9HXkpRe6x/
         8aFCPdKmYQ0VlotmzQt2knDQLbH5xO4JRQStxS6dzMwUTNSMsk/N70esClxOaGuT0X9W
         BpMw==
X-Gm-Message-State: AO0yUKWKjk3rXq92CEHqLZFxofPn4DTQqMlL4wo3XepLQT5rPRBCR2kJ
        MCa3yhmkX3lKAnBMsOBHxmU=
X-Google-Smtp-Source: AK7set/S8+JUlNZGNmfsHdsecBFP86lB5p5aIFuBdpziBSvbpELDegaxbs4C+SHUYzXHItcMID89bg==
X-Received: by 2002:a62:1704:0:b0:5cf:4755:66d9 with SMTP id 4-20020a621704000000b005cf475566d9mr2898440pfx.24.1677030400465;
        Tue, 21 Feb 2023 17:46:40 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:40 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 05/18] bpf: stackmap memory usage
Date:   Wed, 22 Feb 2023 01:45:40 +0000
Message-Id: <20230222014553.47744-6-laoar.shao@gmail.com>
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

A new helper is introduced to get stackmap memory usage. Some small
memory allocations are ignored as their memory size is quite small
compared to the totol usage.

The result as follows,
- before
16: stack_trace  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 1048576B

- after
16: stack_trace  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 2097472B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/stackmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index aecea74..0f1d8dc 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -654,6 +654,19 @@ static void stack_map_free(struct bpf_map *map)
 	put_callchain_buffers();
 }
 
+static u64 stack_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	u64 value_size = map->value_size;
+	u64 n_buckets = smap->n_buckets;
+	u64 enties = map->max_entries;
+	u64 usage = sizeof(*smap);
+
+	usage += n_buckets * sizeof(struct stack_map_bucket *);
+	usage += enties * (sizeof(struct stack_map_bucket) + value_size);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(stack_trace_map_btf_ids, struct, bpf_stack_map)
 const struct bpf_map_ops stack_trace_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -664,5 +677,6 @@ static void stack_map_free(struct bpf_map *map)
 	.map_update_elem = stack_map_update_elem,
 	.map_delete_elem = stack_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = stack_map_mem_usage,
 	.map_btf_id = &stack_trace_map_btf_ids[0],
 };
-- 
1.8.3.1

