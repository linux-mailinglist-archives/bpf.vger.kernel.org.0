Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F095A1F14
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiHZCpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbiHZCpb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5307E0B1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso6805446pjl.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uV2iJKt1r8T4/kLPE+0S1a5qg1z9UcPmTn8EI+FbVTo=;
        b=gtEwsy4x+ddZbQwM7VlCCFDOxzrhgFhLglupjaRgCD3AJZlTMpit1vdMX5v8Bni/HA
         vDa71MrVWUlvn5LpFBMWOWVw6vMcrOCd/fUEeM1UMXpCTra44xMBlSb+iMsNNFy3CH7m
         4JXWN4MlEX3rJMhhnlxU7n+Od+4H1MZVHWvG1TMSziWe03JZKAfH5asgRhyi32or0QX0
         tqkGfCdKrOVoFtOXf/ySkKi1evQRMdtWo0NRmE31kSGsSO0hc3jVAukkBFPjftA40wXx
         onIV8UusP66eO+hVTj1a5Htqwo3bXAk8c727wkzss96LrUc2Gdsf0oPeoaQWnjVAOM9W
         SIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uV2iJKt1r8T4/kLPE+0S1a5qg1z9UcPmTn8EI+FbVTo=;
        b=PPnlroXy7ZfIsrwxlC8raFOgVCT9wHG+CAMBygBy7sypGjPWtzF0sZuJuNR2QNVkud
         MffKs1S/IbJFdM2aYlFlOofOZEjkRycuf9lVCDDG/JcaEmQ0EdCBsejKzEneUA5Mqmu+
         YlxUDjMZ/P/gsNkbEwKCN0RUnl+C29xmSG5Mc3h2O2eHl5Q4+DevpSvNZtKjc/3N4x5q
         ntVPSnCQIE9wuEge6tHnSEta+Jir/zhRgN+Eon+Oh1CJ+tIZeZqZ21OyXe4/24heGpad
         iHhPGLlkkYBwx2mQN86QN8/w3MsukYrtXbfbi8jUls45fvZCVEUg67XtP3tkCMUaBXuB
         zQ4Q==
X-Gm-Message-State: ACgBeo1WLqa0DZ9qO4XfK7z+aXdphYPp/561Si9g61bPitxLq3FVwqZw
        N0WXgSyj7mCAaA/9vS3BPF893f1sUUc=
X-Google-Smtp-Source: AA6agR6cxdfOqJFcJA44Y7BdIgBjd3RcuOdJYy4wgdgAkiQKPwJQN8WC3FxYM1NwvpDrniv6z1pgVQ==
X-Received: by 2002:a17:90a:1d0:b0:1fa:c551:5e83 with SMTP id 16-20020a17090a01d000b001fac5515e83mr2116468pjd.106.1661481929024;
        Thu, 25 Aug 2022 19:45:29 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00172c7d6badcsm259849plb.251.2022.08.25.19.45.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:28 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 14/15] bpf: Remove prealloc-only restriction for sleepable bpf programs.
Date:   Thu, 25 Aug 2022 19:44:29 -0700
Message-Id: <20220826024430.84565-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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

