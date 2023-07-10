Return-Path: <bpf+bounces-4569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4774CC7A
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 07:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B76280F73
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FABA3C05;
	Mon, 10 Jul 2023 05:56:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA93D76
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 05:56:23 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A709FB;
	Sun,  9 Jul 2023 22:56:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2493232b3a.3;
        Sun, 09 Jul 2023 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688968580; x=1691560580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cK1x7/nM0Cjas77MKbrDrci2giElHlRRe0nf5SDUA/Q=;
        b=gOsWlU3viJi4hKcl8hByMxJux95mzWltv/LffiSsgScUv6yBmQ+6DI/8siUOwZpwhZ
         nPKqAfy9GiUfRX+cE83QpQLOttJfLm+DedX3wq3T+2KwEx9PHs07KZ57TM5Zysh1dWrO
         9F3154g0UVryflySl322outVAh5xBHzYa5SK72wfuyuWQQfNJ5GhbK5TDV5y2Cjhngqc
         WAT1lzv0xJ8BdbSemBivjR+ThJBwXNAea/EMGbbRTFTFIAMQEa6tjsarDdCbIrN0cxpD
         lR1FW0koRWuaZI+BU/PNGdmtj+wHu+ym7p/Hi7fBQPmDqNyECuXitx8S9BxwkYuYE53s
         GFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688968580; x=1691560580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cK1x7/nM0Cjas77MKbrDrci2giElHlRRe0nf5SDUA/Q=;
        b=iKp4JH0S9okqZnnaxE2CWtWdgPkn57h1tSXVytZ7FeVLSI+BrBFlwgx1RULhNSQnXO
         nJ9CjGAqgfomv/6hGguPAXV82b8JtpGL1GDeR1TK8BuPjwaYmPfXwgEBDutiuIqwwXBo
         +Oe3LJnU8fZ1TT14LmEmHT0Kg3G/7sYA0bhckOH/PMDWB7ZEW1nLchLVM2C/nS1ybcJU
         2yYDjXgV3Lam3NsSmLLAKIt3CE0Pq8ezGLgFn2DL56ICWgrOpJRYBbPObXIF4OIHwtSP
         wgRrT7UF8z+ACO7JdlWsTaFu/G3qS/Hj143xhGAOqr1qPn2LC5swpePD0nm9r4wVVtSJ
         0J3w==
X-Gm-Message-State: ABy/qLaCY99hIrLkOSpmZxLVhD88SxGW37rSl4t20dT5/6faD/pUQXwV
	4yAGetiBB8mfxeFPfSxqsGdQBt40htglgBycGns6XA==
X-Google-Smtp-Source: APBJJlG6eKjGXeR2hj8CJWd9gfReuSEcCX+YXgDH8FTEUKw8E6SMj0hImj49j39kOAh6BCq2Cc2OZw==
X-Received: by 2002:a05:6a20:3d85:b0:10b:b6cf:bbb0 with SMTP id s5-20020a056a203d8500b0010bb6cfbbb0mr10769933pzi.42.1688968580491;
        Sun, 09 Jul 2023 22:56:20 -0700 (PDT)
Received: from localhost ([2409:8a3c:3609:db21:fbac:2cf0:59be:e1b8])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ebd200b001aaf2e8b1eesm7247061plg.248.2023.07.09.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 22:56:20 -0700 (PDT)
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
Subject: [PATCH v2 2/2] libbpf: fix some typo of hashmap init
Date: Mon, 10 Jul 2023 13:56:14 +0800
Message-Id: <20230710055614.1030300-1-sanpeqf@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the whole HASHMAP_INIT. It's not used anywhere in libbpf.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 tools/lib/bpf/hashmap.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae3feaf29d0..c12f8320e668 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -80,16 +80,6 @@ struct hashmap {
 	size_t sz;
 };
 
-#define HASHMAP_INIT(_hash_fn, _equal_fn, _ctx) {	\
-	.hash_fn = (_hash_fn),				\
-	.equal_fn = (_equal_fn),			\
-	.ctx = (_ctx),					\
-	.buckets = NULL,				\
-	.cap = 0,					\
-	.cap_bits = 0,					\
-	.sz = 0,					\
-}
-
 void hashmap__init(struct hashmap *map, hashmap_hash_fn hash_fn,
 		   hashmap_equal_fn equal_fn, void *ctx);
 struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
-- 
2.40.1


