Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1056AAF98
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCEMqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCEMqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:35 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B47EF8B
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:32 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t1so942742iln.8
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoFsRKqLdKP02I7g694Qbh39KZF7kQZ2F0Pz2UqBWn0=;
        b=ATIpOr56mhb/z3FLbKDR+xBZbPICjiHqRbRiepxOl1feNlA46C6N/P6wQv5FZhath+
         6n+6j5+De2toxR7gV/TbYZ3hcJmA8wnanlMdNZgzplrmDnFMNRAgGnMQAlXuYMAz1fYo
         ebSoy7wz3p4KqqfFB2lWlYusr2dKlw3KfLPlQx194/LQU4orayAivl+c9iWmhnstH1NO
         MPAJT7O5ipAYhQd16Yg3RMSSm2UbsYZMgvIPDYi00/+WBFHLLQG9MSxzekxRtok9w+38
         jBU4esGaYhja4d/Lskj8PldyNj3oA1jKnK2gruAZMG52aJuhtHDtTgTzPK4oO2QtmI8H
         cPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoFsRKqLdKP02I7g694Qbh39KZF7kQZ2F0Pz2UqBWn0=;
        b=RzepgGV5p7n7wQvRedIz0IDbr6k96V2UJi3PhbCK/aV25aF9D197bX80yLyE4FvwLq
         52+K3W7O0cOZJ3g7dblxpDEe8436RHxODrcJkfXFrynoNvoct4+Cof/JWaokSiOjqxWX
         VNfvJE1oitQS93XMOBMVxg7N4XcXbZRr6DvhoKhNf2VuJ/OSl2b5G7EFUBCifHltMOls
         FfcwFOl/iIflkHPW9f1/k3v59URp0cz3Sw7OOQZ+mMP0WqIbr8du23rcFhhvHP9YBrjo
         gCOfLeVln/iE737azq9GNYWzTm1HIKHirXKUuiEQzrPDdOWkzPH95AVTiIGHtSOFze+8
         gvDw==
X-Gm-Message-State: AO0yUKUM1H/h132Bq7e95rzw+BIf/MywCcJnL/QOzizkZU8YQatR38J6
        svNZfCufbhd+uqehffSECeV9csK+X8OEcTzPj5M=
X-Google-Smtp-Source: AK7set+jgc7+A5B6g4YFuVCPJLQmgwq1D0xZu11bUXbA7vXLMv9mX3SEBculCIdqqQUIhzqW3Nhzdg==
X-Received: by 2002:a05:6e02:1569:b0:316:dc3a:fe80 with SMTP id k9-20020a056e02156900b00316dc3afe80mr7151918ilu.0.1678020392048;
        Sun, 05 Mar 2023 04:46:32 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:31 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 08/18] bpf: bloom_filter memory usage
Date:   Sun,  5 Mar 2023 12:46:05 +0000
Message-Id: <20230305124615.12358-9-laoar.shao@gmail.com>
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

Introduce a new helper to calculate the bloom_filter memory usage.

The result as follows,
- before
16: bloom_filter  flags 0x0
        key 0B  value 8B  max_entries 65536  memlock 524288B

- after
16: bloom_filter  flags 0x0
        key 0B  value 8B  max_entries 65536  memlock 65856B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/bloom_filter.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 48ee750..6350c5d 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -193,6 +193,17 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 	return btf_type_is_void(key_type) ? 0 : -EINVAL;
 }
 
+static u64 bloom_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_bloom_filter *bloom;
+	u64 bitset_bytes;
+
+	bloom = container_of(map, struct bpf_bloom_filter, map);
+	bitset_bytes = BITS_TO_BYTES((u64)bloom->bitset_mask + 1);
+	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
+	return sizeof(*bloom) + bitset_bytes;
+}
+
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -206,5 +217,6 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 	.map_update_elem = bloom_map_update_elem,
 	.map_delete_elem = bloom_map_delete_elem,
 	.map_check_btf = bloom_map_check_btf,
+	.map_mem_usage = bloom_map_mem_usage,
 	.map_btf_id = &bpf_bloom_map_btf_ids[0],
 };
-- 
1.8.3.1

