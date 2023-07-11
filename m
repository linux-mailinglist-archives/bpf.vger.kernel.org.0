Return-Path: <bpf+bounces-4728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D774E7AC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137681C20ACD
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 07:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C222F171B7;
	Tue, 11 Jul 2023 07:07:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89530171A3
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:07:30 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15DA18D;
	Tue, 11 Jul 2023 00:07:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6689430d803so2752581b3a.0;
        Tue, 11 Jul 2023 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689059240; x=1691651240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr4EEb8lSN9rAL80ANZydUG7gs/Koz0Z+OrxyJ5aSvw=;
        b=hf4FYqhBmre3m/JYcxT1W5OJhsdYVIELbmLg4wdeO67Ow1M7v8XJSB8LMo4knmsQY3
         XSgTRiSVyJSUMonjEfU4Wd4XuWjMCzH680If8+RPFVqN/gnBPT33rIRbJCQF6Dp6pEHw
         VjglaDdbDPH8G9H25ieY+iXdEuPsKjx+0gx3h2Kb2ngutQclWQsXdr9EK9Kb/QGsu0hg
         Mz95r28+Xdx3BXk3BgZ8KjwLpzNqGIdyW5uFjDfKRl7OCBiVARy+ZOYETUEwTKc16MV1
         CXlorm/jxS+vLgVUAtha/eA4XPS7QpDR0JwBbU/FTGgi0/xxFjaoHbKiPhIOSIMyvlEH
         EG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689059240; x=1691651240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lr4EEb8lSN9rAL80ANZydUG7gs/Koz0Z+OrxyJ5aSvw=;
        b=XqzzCjqergO8pIb0QwRkUNIqjdbtlgyrkJ/hnSduNBiUZixJxuTQ+GQm8mTAJbab7T
         kUMRBGFy4twHby7ls98f9v6kuUvEld4mN/uUWdb6mbjeZoYgWASK0RrLPr3N0h7b8xy6
         +gIWRaUO3GqR8Ueu2DmDu3nUXj8xFRkBe6FdEYjsBOY9nXOZBsj/7+MACWMDYZ5/uGxt
         WgE40QdfkN8UfMHZogHSHKHxHKhY/0RVVgCmj+zyz13wROAJ4+9iXoOyuBHFx5vEvtqz
         ZrQl8xZFHHvUs7OKi85xe4ah6UWBKqetMTetKhJXlAl+ggnB1pmWgKtylqVF9odJqNAG
         x8Cw==
X-Gm-Message-State: ABy/qLYpNbCTyMsFuJSjy24RmHHl2ZN2MjS6YZ5jvQ/aImyWZLFR9szB
	AS2M3ApBOqEyyWoJ40g6gso=
X-Google-Smtp-Source: APBJJlG2n+1X8OOFL1uOgyU7Z/1eHhJXKjELPvPVdYR21E4dHKcvowsuNGvEWfmvMDjgH5pMhUwigg==
X-Received: by 2002:a05:6a21:78a8:b0:12b:93d4:4964 with SMTP id bf40-20020a056a2178a800b0012b93d44964mr14970823pzc.30.1689059240145;
        Tue, 11 Jul 2023 00:07:20 -0700 (PDT)
Received: from localhost ([2409:8a3c:3609:db21:fbac:2cf0:59be:e1b8])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b00678cb336f3csm986154pfn.142.2023.07.11.00.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:07:19 -0700 (PDT)
From: John Sanpe <sanpeqf@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH v3] libbpf: remove HASHMAP_INIT static initialization helper
Date: Tue, 11 Jul 2023 15:07:12 +0800
Message-Id: <20230711070712.2064144-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the wrong HASHMAP_INIT. It's not used anywhere in libbpf.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 tools/lib/bpf/hashmap.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 0a5bf1937a7c..c12f8320e668 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -80,16 +80,6 @@ struct hashmap {
 	size_t sz;
 };
 
-#define HASHMAP_INIT(hash_fn, equal_fn, ctx) {	\
-	.hash_fn = (hash_fn),			\
-	.equal_fn = (equal_fn),			\
-	.ctx = (ctx),				\
-	.buckets = NULL,			\
-	.cap = 0,				\
-	.cap_bits = 0,				\
-	.sz = 0,				\
-}
-
 void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
 		   hashmap_equal_fn equal_fn, void *ctx);
 struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-- 
2.40.1


