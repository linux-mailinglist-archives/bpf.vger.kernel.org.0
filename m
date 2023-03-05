Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E76AAF92
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCEMq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:26 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C2CA0F
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:25 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id p13so4783309ilp.11
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ficowSGEUkQCN6NzuyEybzi5V6w1MYg0SyfvaQz1rQ=;
        b=Gf/ZCzbPbyRC/m4885/YtvHioATjlZrw7a6erIpu+0Yqh6rVHFsPUwG5vXFLUGWOPq
         cmSRVKreqUmpFIS9KL41UxQEco55kGbebrmROBPpes8aichsEAR76Th1YHv3CFeEOoET
         YJcFfD0BHvmN+N6dc1MggWnSla9Y9PxuOLnGvKo7bI7d5FzB4RaJMjCeYdzaz5Xcxl10
         cpgt1JKdY7cz3xsr0M7fAtg2BmyMDt7unDUpcCscy86B4ynTrds/MO59oTE2h9lfDqJM
         BMcAlSgOu6L/b05tN8wE+lINLhWypwVgKY1EJwrFnBG7zw92s9RlmpO6MVGB6Pt2OSDL
         Owww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ficowSGEUkQCN6NzuyEybzi5V6w1MYg0SyfvaQz1rQ=;
        b=1wLjiYXpUXKvX1jovZXs5idJpSnj81Q2+zzu9wGQAg2/NrhgdE7SIYzOfqsAzG+UIi
         mY9cbie4BKQ+y9VxxwACtT0BegZdCQ1fzCL+d9qe6D+2wxIKtynzE4v8LCW+6/D5LOhL
         BNbJQVA9qmffFfbIShDghi11vCAQpI2/moJQ+OjiRdL3qgNKTKxpF82sfMECVG+fZoE1
         ebT8F7bb3ffxgSFvUi/MLaTtdOUkD+MRvhp0+zGK1xcbShfMPNNtdyGrRUS2I7fyRcQM
         W+lnJ1IO3tpYapHsQpnfjSLTPo+odbEKEjCDNlxvtjwdJbrA+xgcF8kdg/Myo9oCmc3r
         dC+w==
X-Gm-Message-State: AO0yUKXDcKxzyWDFeMkoDRHJ+GHEzsS0DCqcfegnPcOBuJy86keLKELa
        abSc9hyFiWFuYJVAqD1D2WM=
X-Google-Smtp-Source: AK7set9dmPaOCLfh+5b9MW57tKq99pbxeQG9ccKZ+6XHJMV43i+OiVJsPq+X5AqokPC0A7LTsKxodw==
X-Received: by 2002:a05:6e02:1ba8:b0:313:ce4b:a435 with SMTP id n8-20020a056e021ba800b00313ce4ba435mr7200818ili.25.1678020385177;
        Sun, 05 Mar 2023 04:46:25 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:24 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 02/18] bpf: lpm_trie memory usage
Date:   Sun,  5 Mar 2023 12:45:59 +0000
Message-Id: <20230305124615.12358-3-laoar.shao@gmail.com>
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

trie_mem_usage() is introduced to calculate the lpm_trie memory usage.
Some small memory allocations are ignored. The inner node is also
ignored.

The result as follows,

- before
10: lpm_trie  flags 0x1
        key 8B  value 8B  max_entries 65536  memlock 1048576B

- after
10: lpm_trie  flags 0x1
        key 8B  value 8B  max_entries 65536  memlock 2291536B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/lpm_trie.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index d833496..dc23f2a 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -720,6 +720,16 @@ static int trie_check_btf(const struct bpf_map *map,
 	       -EINVAL : 0;
 }
 
+static u64 trie_mem_usage(const struct bpf_map *map)
+{
+	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
+	u64 elem_size;
+
+	elem_size = sizeof(struct lpm_trie_node) + trie->data_size +
+			    trie->map.value_size;
+	return elem_size * READ_ONCE(trie->n_entries);
+}
+
 BTF_ID_LIST_SINGLE(trie_map_btf_ids, struct, lpm_trie)
 const struct bpf_map_ops trie_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -733,5 +743,6 @@ static int trie_check_btf(const struct bpf_map *map,
 	.map_update_batch = generic_map_update_batch,
 	.map_delete_batch = generic_map_delete_batch,
 	.map_check_btf = trie_check_btf,
+	.map_mem_usage = trie_mem_usage,
 	.map_btf_id = &trie_map_btf_ids[0],
 };
-- 
1.8.3.1

