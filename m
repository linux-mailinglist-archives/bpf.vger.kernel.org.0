Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9069EC7F
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBVBrD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBVBrC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAE932E5A
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so3728780pjj.0
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSsP2cTbcAO8kYH41y4wWbsUNHvs4mxp7DEwTns4GbQ=;
        b=OOhKzFBu+9uyDipBpGpLxL28+xJdkqdVtSkdZkqgjMYj3DZKlRjCeYamE7dsq+Q8B9
         gi6pFGyIITcc/Zu2xrxU5tUSDaPkpGTV/DBA9pJVlWSQwy8PaeqqLME9x2b1eNU8QQ+D
         QNauFeZ+VRdWaRa7yXIjzpSfJg4XxL0NeJkLcbPZ9fX6i2V1179Gf5nlPAyKH1ID8uDA
         tsTCftVr0b/vn3b1YSkD16s5KilGSUb4RrCZI3+pNj7FW59av3dlN/d4xrnsIBlXEnn9
         QDYV5PDZwzJnmEGFl388P8QgonIKl6oc1KD6OwF8LuWytTq6dkELpdfv/TA43tdJIfYc
         d6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSsP2cTbcAO8kYH41y4wWbsUNHvs4mxp7DEwTns4GbQ=;
        b=1GekMozPVjWeR+X9swrge328ZIdvp1XFBq5cbrSOJ0uUUL0jjsRMIMMgBDsqoTambY
         AWcf9OMTYB524bcGDbTCXItLq5wFD5Jcj+aBIfb4tL96Zp0yEl9BDATpxtqeTVz3EYg3
         flpxf2RF8mdxG6VsfXe3w/3Ua27arPRzAdkbly+W5BVTyaqCpvpu2yJ3zL5ro1Uh/lco
         pnfoHDnS1JiVtPgEBgw7rL1OQh6KLtJajZ1InxNdWzmxBgcmwS/tK9dli+5owoM/mceK
         PbrExRFTNDlDO2TcDu4qKmI2HB/scR21FOiS3O3FYgWv3QF359VrUnefDxtvcfQhaeY2
         IQgw==
X-Gm-Message-State: AO0yUKWNziTaQngvARwSIdyZ96mEWLPtb+EX/oS8KX9ctjCRT5jqgAaw
        sZjC5xEjsH86qTUiB0B0lyQ=
X-Google-Smtp-Source: AK7set+D9qNiMIx6XcDDlT9yOlpqbVqSYsUTRZPEdPBbViEE6NH/lTbxtVGzR606uwrBdCcA/a1ZFQ==
X-Received: by 2002:a05:6a20:d49b:b0:cb:c015:92b4 with SMTP id im27-20020a056a20d49b00b000cbc01592b4mr1081960pzb.45.1677030421110;
        Tue, 21 Feb 2023 17:47:01 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:00 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 11/18] bpf: queue_stack_maps memory usage
Date:   Wed, 22 Feb 2023 01:45:46 +0000
Message-Id: <20230222014553.47744-12-laoar.shao@gmail.com>
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

A new helper is introduced to calculate queue_stack_maps memory usage.

The result as follows,

- before
20: queue  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 266240B
21: stack  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 266240B

- after
20: queue  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 524288B
21: stack  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 524288B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/queue_stack_maps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 8a5e060..63ecbbc 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -246,6 +246,14 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	return -EINVAL;
 }
 
+static u64 queue_stack_map_mem_usage(const struct bpf_map *map)
+{
+	u64 usage = sizeof(struct bpf_queue_stack);
+
+	usage += ((u64)map->max_entries + 1) * map->value_size;
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(queue_map_btf_ids, struct, bpf_queue_stack)
 const struct bpf_map_ops queue_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -259,6 +267,7 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	.map_pop_elem = queue_map_pop_elem,
 	.map_peek_elem = queue_map_peek_elem,
 	.map_get_next_key = queue_stack_map_get_next_key,
+	.map_mem_usage = queue_stack_map_mem_usage,
 	.map_btf_id = &queue_map_btf_ids[0],
 };
 
@@ -274,5 +283,6 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	.map_pop_elem = stack_map_pop_elem,
 	.map_peek_elem = stack_map_peek_elem,
 	.map_get_next_key = queue_stack_map_get_next_key,
+	.map_mem_usage = queue_stack_map_mem_usage,
 	.map_btf_id = &queue_map_btf_ids[0],
 };
-- 
1.8.3.1

