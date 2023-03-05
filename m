Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0B6AAF99
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCEMqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCEMqg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:36 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE1C649
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:33 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 4so4805794ilz.6
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiBhjvmvPZBvwRpF2x1Rob9RQFfAqLPRi1VOzXV3z/U=;
        b=pTRWptfZGDb0EQ+CVKa8mjKJBZd3QAf6yoZB4LXli3GRdXMrKuANSjBhJZMe8ootVv
         8dlDX6FuQcnfAr6ZRGTm6JNZBi1vBjEwkek99LciRsDhWEBTmHUu9U9jE0+HNKpLVVPw
         gwVIPP3lq8bd3RjDk9aLxe3kQMv78vPgRrR1mxeH3c24vxlf37pXtlo5Qgi67P3jyLOu
         kRFs1yKW7+rECnEBSlNBbsSw5yjd50MCjPYjbiQ9GoRCfLxKgNf1EZthpJvu2r0t7O/1
         3633jE/9wpA4dc0qneRhYcpoY1kzv8YEeKt+OCkuLHMj+/Ig9Qg4QjoiqU2cOxV2n2eJ
         1uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiBhjvmvPZBvwRpF2x1Rob9RQFfAqLPRi1VOzXV3z/U=;
        b=x5TLeCyzLPb3224lG2pQoCeSVDafo+1NtfCm2dZLbOj7VMJv/qHJlAoGyN9mynnBuk
         OE1kl4X5nUsMJxjw8seuZlR/hrLUz8ghFrGd6d8ojn5LdeUNHnHBuo6Gj7YLcZBKX58q
         dcIucdekOmtXKR3MJr0Umd2+ELeMJDUhL30VfyoQ8h8nGa2lyba1oAC6Cv9Gcnw4E6hM
         VRxNr3F16qNzhw3e2WY/bp3zJncu+p7tv9qbsp36Xq8NOZDFracO1TmoV/L6VzecE8Kj
         sL4aEkepnBv0Hps+bPD88ZOLEF+i1Xj+0kYxdEzJmkJbwhN+42n7RLn4xz4+6DVut58F
         ftJw==
X-Gm-Message-State: AO0yUKWtvFK/JK3OrslwNz37O+2hxAHjIVZN61f9ELW2k+XwG+1etP6r
        Z9d8LZN6q64oev0CuSix2a8=
X-Google-Smtp-Source: AK7set9ES5Kqsl3YdAyhf5E5o2RnX2jTAwwRiwlMer5NkTQAsGcEBKXwrXyPhLw7+joigCmrLo9qaw==
X-Received: by 2002:a05:6e02:1705:b0:315:3421:ef2a with SMTP id u5-20020a056e02170500b003153421ef2amr8579182ill.25.1678020393075;
        Sun, 05 Mar 2023 04:46:33 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:32 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 09/18] bpf: cpumap memory usage
Date:   Sun,  5 Mar 2023 12:46:06 +0000
Message-Id: <20230305124615.12358-10-laoar.shao@gmail.com>
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

A new helper is introduced to calculate cpumap memory usage. The size of
cpu_entries can be dynamically changed when we update or delete a cpumap
element, but this patch doesn't include the memory size of cpu_entry
yet. We can dynamically calculate the memory usage when we alloc or free
a cpu_entry, but it will take extra runtime overhead, so let just put it
aside currently. Note that the size of different cpu_entry may be
different as well.

The result as follows,
- before
48: cpumap  name count_map  flags 0x4
        key 4B  value 4B  max_entries 64  memlock 4096B

- after
48: cpumap  name count_map  flags 0x4
        key 4B  value 4B  max_entries 64  memlock 832B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index d2110c1..871809e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -673,6 +673,15 @@ static int cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 				      __cpu_map_lookup_elem);
 }
 
+static u64 cpu_map_mem_usage(const struct bpf_map *map)
+{
+	u64 usage = sizeof(struct bpf_cpu_map);
+
+	/* Currently the dynamically allocated elements are not counted */
+	usage += (u64)map->max_entries * sizeof(struct bpf_cpu_map_entry *);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(cpu_map_btf_ids, struct, bpf_cpu_map)
 const struct bpf_map_ops cpu_map_ops = {
 	.map_meta_equal		= bpf_map_meta_equal,
@@ -683,6 +692,7 @@ static int cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 	.map_lookup_elem	= cpu_map_lookup_elem,
 	.map_get_next_key	= cpu_map_get_next_key,
 	.map_check_btf		= map_check_no_btf,
+	.map_mem_usage		= cpu_map_mem_usage,
 	.map_btf_id		= &cpu_map_btf_ids[0],
 	.map_redirect		= cpu_map_redirect,
 };
-- 
1.8.3.1

