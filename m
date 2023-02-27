Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8F6A45E6
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjB0PU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjB0PUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:20:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368C22DF8
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:52 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 132so3732779pgh.13
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq2nVwWGrK3a0pC1Iu9mkxB4TlvHW+/gHuyRu9N7pEk=;
        b=Twx5i7unsp4aKk6w3XQTYkH3OnyZTdoNsmm1vZhFfN+7Kgp5ttFpWKd42sVzddqWwH
         4K3c/jjFWsG2CtolqTVWclzcv80sdDpikMYbozih6dQRfkXjuj67dl5+JjMlvAvUloAZ
         W3lN2VWO9A0VHNv1W7vq9abRkkHurUaIbnlRnsEoKObkbWuj74OkZBmHMDisS9IkiQvm
         SIgfl2WyxUk4bzJRDhiXGCiWnF710lC0QTSyAPx8xQldGL+C2hhjcTXUJKZAu54OI4zd
         iaM8LBtxH64evspHP8ZPgOEKS2/cPcUZfTipSFOUzKqpKxGo9Ugy1hDYP0DMWxZSGwn7
         JRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq2nVwWGrK3a0pC1Iu9mkxB4TlvHW+/gHuyRu9N7pEk=;
        b=47r2D3YWSdHfeepr4Aw23QeGWYIsBLTgYf4lK2ioBijea1EZYDskuYwFrfqWdge/9e
         ZrC82vtum+M4nSVT+6kWxTYt7TT5MPCgneNSMwHeLxrYaj3hUQwAuBgH+ALiv1wVD2wW
         eLX6oR53+JD7XBiM+iWYlFy1bzihy7s7W9h8rAMBCZkyn8A5b7USNSe4iJ3K+3AjowN4
         qlVr+ob2916RSWouYw4vIDDlUGECa5H1wZgo4rkxprfteMM3QIimP4GdWiNMHr8i8ole
         vIz8PQ+kagZgc3shOEd16duYxE67Sp0an5rObw0dNy1WbFnfX9Pc2YraTtPIlkp9BkAk
         CI7w==
X-Gm-Message-State: AO0yUKV4iocCt2HDwdnUlKFClmuU3W04MbYT2oDKVO+hkDUJxyRdRTyy
        sp1tPpA+TeMyI7qxXHxBUpM=
X-Google-Smtp-Source: AK7set8EvB2hw+Ezr/FUCw3qH3m7547RAyp6gbaepcFygtWS9prxB93R3yQLwWOA3jP7U70R8zdiDQ==
X-Received: by 2002:a62:8494:0:b0:5a8:9fc6:6fb5 with SMTP id k142-20020a628494000000b005a89fc66fb5mr27121834pfd.16.1677511251730;
        Mon, 27 Feb 2023 07:20:51 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:20:51 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 02/18] bpf: lpm_trie memory usage
Date:   Mon, 27 Feb 2023 15:20:16 +0000
Message-Id: <20230227152032.12359-3-laoar.shao@gmail.com>
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
index d833496..e0ca08e 100644
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
+	return elem_size * trie->n_entries;
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

