Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F420B69EC76
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBVBqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBVBqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6BD32E5F
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c23so2281694pjo.4
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq2nVwWGrK3a0pC1Iu9mkxB4TlvHW+/gHuyRu9N7pEk=;
        b=ZBFduowT7w4DABKZSwtMtdQJ6LA2XjIJbzRIoWhDnrCCVyURaibqaSjwlR264pVnly
         XPVn7UqztnabwBZccE9RyCJSHlvN9+kcR+8PFHtegtNUakrp+Yc4sphQ774YxC1ESpWB
         mIzSBVDGEXhgYydXHI6KliSKOa6E8T/kP+RuwRXG3vwRCQ9Q8crkn4C0t5mttm1Dt3OQ
         zP8AMqgMYME2uITj2NgRHUHOv5kVty5ZsXs4A0793Le1sCvDz+MoZKCduyJoZAjqEmw2
         ZVzqOsTDJypIGO8xBRuP48ZgnoKUGMX4upKS1qatzARXpMruw17EecsveDpJnFFvCgsX
         FCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq2nVwWGrK3a0pC1Iu9mkxB4TlvHW+/gHuyRu9N7pEk=;
        b=dztCcLUJLzNdam11ZObj+WektIHYrqQkuoHRAbg+9ma/X+/UgGil+bk8F7VFV8Tba6
         D9cCx0X/ZmHS8vDbadPO8Wr7EXjQJTE3uhOh8dXaB+KJccvfs4WHuJbZ9HHJL2hbgYTU
         X2lU9vFFZ9Yt1NtH+4kZXrWM25K5eAhzQ9efNa5oUk7/BuJYJS5AfyHKvsJXg9nLITZf
         MEQs3yNPflnvyxb/tFsY/7QTLAoS59zvV/tlOKjKaXA+/cxsFJX9hp2R9E0r+hinj8NA
         06sCZzZfT9dp7u2z7Ygbs2Ri74SKac1DJOP1iwN6ve7cgXxKd1dpehyxMYB47d86geMz
         k1Ug==
X-Gm-Message-State: AO0yUKXntQPqt4HnLEzSNALIFvuGnCvWbW2w3VupzVCD8P9cRYXLtcxg
        eoWaZjohcBW1ovOF6Sw6nRI=
X-Google-Smtp-Source: AK7set+WifdXPC5i+29S7BNBO4Jhc99x3pI5QSJvzcqSOJLFqUDhF2QrzvbuBOMi5ZEFNiDX4ESdrA==
X-Received: by 2002:a05:6a20:4425:b0:c7:45c6:d344 with SMTP id ce37-20020a056a20442500b000c745c6d344mr8142333pzb.43.1677030390147;
        Tue, 21 Feb 2023 17:46:30 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:29 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 02/18] bpf: lpm_trie memory usage
Date:   Wed, 22 Feb 2023 01:45:37 +0000
Message-Id: <20230222014553.47744-3-laoar.shao@gmail.com>
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

