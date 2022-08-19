Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDB59A7EE
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiHSVna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiHSVn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA5DF32
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so5166418plo.3
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bW5ocW6PzISfaCgKiPdCkbtq/RA2U8OKQTKMdTGnVOA=;
        b=QL0G/EHoJfksQ4p6mh6jETpl0vwiWZswZj/MQI0CXx3GQ3XVocxIglIesp1mjt6wig
         liFF8jPt0KXoJ+PurPcIH41o7V+QkbIadjk4Okh9eyYvPwKeN2XF0bHWtiHpL1MKxE7P
         C+ePoBtSmYEBPgR/F159rvLFaFgWqmrHo47CKrrYjAlH+WEPNOb3DdMvOn6m4kjqltc7
         iD9zOt6GSKu1/Bu2Ld5wdUAS/2exFqYpqD3DLVdb4K9K446n4ZPAdmO8B4ZYdubYD6C5
         NUVTtVRkpKRUm8k1SelZZIDYmuadXTy+z0Bk3bHXaqzkOhAZg8nc0nglkMGRxm6bub6P
         JJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bW5ocW6PzISfaCgKiPdCkbtq/RA2U8OKQTKMdTGnVOA=;
        b=O4fSaCvGR4GnhX9egA+kNgivyAyxfdQ+e7NDZMg7C5ziKONCJM4VPWlr91pAaIlGjb
         dHHWZsDAe0sZuF48t6DB0auRuGjRVGl554GFQi4/kRXsdAmuRoyRvmGNuQaZHetQdHWE
         JVPlZJ+RI+MGU342sUzHVyE0AsbnjiVl+ES3QfzUVcq4QK3iIlI8dXCvhLXuqc5KBv8q
         cX3WgH6mqluTWWEuxh/NVBtqjYoxvfJgYF/tFp2i2Ik4mHk/nFNX/JR2f2mLRvRCck5y
         HUTMDcicyrodv4NRxRrPUNVSWIWYLBLy60bo2Jg//498lcjrf8UJ+aokQWaj+NJzFsho
         hbjA==
X-Gm-Message-State: ACgBeo3sggdB1kfUIrqrU1udBQJEsk1znU6Fnht1uc6BCC3ckKDVsmXV
        RX8KpXO3t9pXuWjGVOiI1DI=
X-Google-Smtp-Source: AA6agR56faXSMcH0PAhNAx9r0g5F4js3qHybSTN70KIu5Hh8X5AOPg7E/K1Wj532E/7UrKfXAIftFw==
X-Received: by 2002:a17:90b:4a4d:b0:1f5:431c:54fa with SMTP id lb13-20020a17090b4a4d00b001f5431c54famr10378826pjb.199.1660945406270;
        Fri, 19 Aug 2022 14:43:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0016b81679c1fsm3587099pli.216.2022.08.19.14.43.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:25 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 14/15] bpf: Remove prealloc-only restriction for sleepable bpf programs.
Date:   Fri, 19 Aug 2022 14:42:31 -0700
Message-Id: <20220819214232.18784-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a1ada707c57c..dcbcf876b886 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12562,14 +12562,6 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
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
@@ -12584,15 +12576,6 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
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
@@ -12645,12 +12628,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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

