Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B96AAF9B
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCEMqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCEMqg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:36 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9EEF8E
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:35 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k9so4289743ilu.13
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSsP2cTbcAO8kYH41y4wWbsUNHvs4mxp7DEwTns4GbQ=;
        b=SHPrPRT4voAq43xpTpn2L5Q1SUzjYpPKxudUGfUaXTLCXkvRwVXRCMpyQ6zEniCVg2
         ZsNO3cjLtErspBbfl3ZLQeMj6kcSzmgjwLr1EoEkzdJJqokiTV3Cwjleg8NSsa9hAobn
         +u8w09kLp/ooMebkv7GRZuaDwvFFOyvsbG6kClqaJDIucm1S3qOQ40H/5/jg2fZUitb1
         wAs1ppTw/9XSe/ee4NuYiWXNS4xI6zAmheGDmUwK1KpzKkCDKYmdjK/j4dM5VrIK1b72
         76/7Fa8gNx1Y1LljNVPHX+K3FMt2w5+tfeebQ0MuW6XGS2alCcfYjekKVUHiBOEmiXsC
         VuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSsP2cTbcAO8kYH41y4wWbsUNHvs4mxp7DEwTns4GbQ=;
        b=YiViC6VSDOtSEMP7n/wFeFA9yHLXFxATWQ6Tr5oGxAlsmJ4+Sza7T/U6Nm8FOgXcF2
         yAQXIa9wlihtIDfTUXhWkvSDMfoxq/xyRl0f1aI0FDeH6X7yr3OgLSQ3/I+PZGynEnl5
         TEUBpkefs2HN1XrpXtS8aoclcLyRDf088e3shCsOMq9WibnN9nZbNlROi7Epy1bAh/RS
         qyEE53ITHLUtxwFVGkBoDH2AxsPS0u8UiKGRbu9lH56GXVQ58YuFKqsnLmyUjMp+i6WU
         fwUl6IMenzP3iYPeTeztBmzlkqQ3346/E4zHLC51AvGRuQjj+tT5uL8Jw735ltibQ15s
         478Q==
X-Gm-Message-State: AO0yUKWWYVE/bkIRt0NdpcqZZrixCfs3cYyobqTOVHdn4t9Rl2BMqrJ+
        DaKOik9LZhBo31VbeT4H3ss=
X-Google-Smtp-Source: AK7set+Pqijc+AxjzacF3hDyHbhDcUV4GSbsOrPN06R3f9rui7epRrJUzB5So4pEgVkCuzCO+ir57Q==
X-Received: by 2002:a05:6e02:e13:b0:315:ac3e:9639 with SMTP id a19-20020a056e020e1300b00315ac3e9639mr8035909ilk.4.1678020395032;
        Sun, 05 Mar 2023 04:46:35 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:34 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 11/18] bpf: queue_stack_maps memory usage
Date:   Sun,  5 Mar 2023 12:46:08 +0000
Message-Id: <20230305124615.12358-12-laoar.shao@gmail.com>
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

