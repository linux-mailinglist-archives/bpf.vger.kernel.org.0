Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F65A9CE6
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiIAQQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiIAQQp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432746220
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y29so13847944pfq.0
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nsaRt32bGU9db3oBvsXD1o3WCeCEvT2VQ8VQ0NN+DuQ=;
        b=AjGkvzQarWREX80MYqd521cobbbisB71tXVBt1zkuUzMMblPgBytWVeffcjAsKO3Xz
         WjwHNd3YDPp3J5q6qPDwlmeM7rj8rI7Sh0TXuIycZXCgX0enJAZapcMD0ckYYFoQtFVy
         ZtUUiel+e5KqtE4NKw1sk8BkdxyYUIRt2NAQCGtdB22vxAkOWkVs/0YZ9kWoUVPB2jQc
         DsESX8cCxppTmRJnxVkf1ZtWD59gamB4XwYvrnCwQA6COoa5Y8sOqtmOMyJy64A5wHkW
         SXih0ASCqSYrA41JsmYRpK3MaOHJ3wtX4QOhvV8JapSVB9XMI9FlSg4dSP5Vx5qe/bbF
         o05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nsaRt32bGU9db3oBvsXD1o3WCeCEvT2VQ8VQ0NN+DuQ=;
        b=uzAwnheFUEIPiDaKu866tcL3LJ18TPNK+9IyXyUY2a+FKSVkcAzDfikBTGzrE8ixOS
         KNkCOLlrQf/Pgqgid4KwQjyiP2AmTEvYZmFurdPZ9KCPeyLla9sLJbuOBHp2XZ/o+s/s
         wi6MZrAxouGci/5BGd6dT15N4m+kvTJ7dneKfnrCmhhUPBsgL2UAsAhhNgcQVk+/lSy/
         T0tgGA7lzV40ghJi7EuTDKNUtAxifLsq8J7hjqn3s9QkojA9M/DghmtPFgiijrmHjoC7
         Be9wa/dyvVGckQqI7RTZDj0hbhf7mEuhYBKk5ITm9pPnTOhk1wHsNqqbTu6C4mAIFwJE
         xchA==
X-Gm-Message-State: ACgBeo03EHvbfzzZxQ/ya71b7NRIpPIj8Rx5HlQjjZjh4iMmpxBa86A9
        rd64pck8EmIZdlyx5up8hwY=
X-Google-Smtp-Source: AA6agR5fl5WH3XWfSQxaOYgWoidwKTZaD/1MGsZn98/okbXbZF5fM8ZiNCbJW1FLOk6IwQZCyO5jDQ==
X-Received: by 2002:a63:6cc7:0:b0:42b:7d8f:7136 with SMTP id h190-20020a636cc7000000b0042b7d8f7136mr25223605pgc.15.1662049003655;
        Thu, 01 Sep 2022 09:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id a9-20020a637f09000000b004215af667cdsm5537666pgd.41.2022.09.01.09.16.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:43 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 14/15] bpf: Remove prealloc-only restriction for sleepable bpf programs.
Date:   Thu,  1 Sep 2022 09:15:46 -0700
Message-Id: <20220901161547.57722-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since hash map is now converted to bpf_mem_alloc and it's waiting for rcu and
rcu_tasks_trace GPs before freeing elements into global memory slabs it's safe
to use dynamically allocated hash maps in sleepable bpf programs.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 57ec06b1d09d..068b20ed34d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12586,14 +12586,6 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	return err;
 }
 
-static int check_map_prealloc(struct bpf_map *map)
-{
-	return (map->map_type != BPF_MAP_TYPE_HASH &&
-		map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
-		map->map_type != BPF_MAP_TYPE_HASH_OF_MAPS) ||
-		!(map->map_flags & BPF_F_NO_PREALLOC);
-}
-
 static bool is_tracing_prog_type(enum bpf_prog_type type)
 {
 	switch (type) {
@@ -12608,15 +12600,6 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
 	}
 }
 
-static bool is_preallocated_map(struct bpf_map *map)
-{
-	if (!check_map_prealloc(map))
-		return false;
-	if (map->inner_map_meta && !check_map_prealloc(map->inner_map_meta))
-		return false;
-	return true;
-}
-
 static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 					struct bpf_map *map,
 					struct bpf_prog *prog)
@@ -12669,12 +12652,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 		case BPF_MAP_TYPE_HASH_OF_MAPS:
-			if (!is_preallocated_map(map)) {
-				verbose(env,
-					"Sleepable programs can only use preallocated maps\n");
-				return -EINVAL;
-			}
-			break;
 		case BPF_MAP_TYPE_RINGBUF:
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_SK_STORAGE:
-- 
2.30.2

