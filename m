Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8B5AB9F0
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIBVL5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIBVL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD2DD4D6
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x19so3096482pfr.1
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nsaRt32bGU9db3oBvsXD1o3WCeCEvT2VQ8VQ0NN+DuQ=;
        b=C/CaWD4ElLDtQ9OCjP7zOMpPGB6pYoJ90/7pZPfC3SrcvyyHOFoqMO6a0yYQyCi1X2
         Qv3gXak4IX/7E9+oBq/vaMNOdlWTE4mbN1D2NtlDP8JvL+1NH31u2uuL3lxCvb+CqmHm
         RXFf4dGQeIV6ptFYGiSLSYq962jDG0shEmm6CR81FJIgTI5qT8zUCa/aOgsETE6nQbH+
         FjkDYoz2XK6ynUFRIimGHCiVkJr4Ek+QsKm/d5b4B36jf8JNV8g6zlfGQKUPXIjAFLmn
         S9EbAHCx0R26ODJyrFWANcbyPq7Ll6QBDUzDb0IokS/ZCsbI79XGtAJfUD6EpE81F26s
         28jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nsaRt32bGU9db3oBvsXD1o3WCeCEvT2VQ8VQ0NN+DuQ=;
        b=z0m7/COtFai28AWKPJXz9IwC0JUqZypYXgCFlB4QW0uP6UEgzn34aDLcUn/JyZZsif
         1hKPCCTuVDPCfnGq5zshmNORUWAJ8etfXGpISwkkJt6hdYcrpYId5JPYA2cUvBUCum6x
         Jwq58MpcGfAuTyxbWj3lerckT7I5Boj+nTmM8h91ppamZs1q3wO/PnqBggovfmDFSXxE
         K6LktabLTVHFE5ofqFKXGjSTGTKI/FLAOu8XFidO2k79XBG14BEY3fsE1MZkLGYE584L
         mgcO3u+/UeaCsusrBVLTvog3+6nKbF2ANpMm30XO3UxUMAxhzawJZn/iRsbj/1Iz7ivW
         Wmqg==
X-Gm-Message-State: ACgBeo0cg0U5y93CEs9QPqKHSK53YplD/VBUGUoa2Kfcd159KZ7YtF9m
        55DG7P8rfG1AHX/oqmDi54U=
X-Google-Smtp-Source: AA6agR7n2Lcnr0pfUz+dYSYvV00llofPH/wKroO0zBTAg4E6DBUpTD3EVRZhXHdvzx96c3xWOiTC+Q==
X-Received: by 2002:a05:6a00:1797:b0:538:7c07:f36d with SMTP id s23-20020a056a00179700b005387c07f36dmr21628092pfg.12.1662153113858;
        Fri, 02 Sep 2022 14:11:53 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id u6-20020a62d446000000b00537f7d04fb3sm2328371pfl.145.2022.09.02.14.11.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 14/16] bpf: Remove prealloc-only restriction for sleepable bpf programs.
Date:   Fri,  2 Sep 2022 14:10:56 -0700
Message-Id: <20220902211058.60789-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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

