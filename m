Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842C67ED40
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjA0SP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjA0SP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:15:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75786265
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id v6so15949697ejg.6
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL1Jf51NGgGd/pmhJ2BM230YZwf+Bd3fcH9fNZ4uAcc=;
        b=1/wMahZjqGEIsu+02OkhkbnKktNakrmKzxpCp4DV+f12SfLl/8PQ5K7GurhKss7WdH
         cZ6yArgNLay6Z5JVAH7jDcpxKt6Pryyit3fi+j/4hqLzQTV4h2wX+ZVvXSs0WnyMdp1D
         pJ06oQgPrvy5qsnYD0UpwQgKwH+sE9uCUGlgrPggGLELX6RGcyisl6PBdJ44pOOmdl1N
         PmjKxwHFl/7Lkjdl3I/nHfsom8PpdEkTEZ7DL5dVPFscU/JvXnbFQhVGEqhwbbw5TIlO
         zdfOLeFZNXDfzvh/hl3HWvPNLe8/w25aVKPAK61BlgNnOXPbrGpBt60kh66NpRDysfVH
         9yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL1Jf51NGgGd/pmhJ2BM230YZwf+Bd3fcH9fNZ4uAcc=;
        b=r3J/t0xs4RGklhAUUIR9xAeyNwXcktMKE1fFki6UtuOEhrqYfmdB/6uQuXJ6W5ML9I
         /HbZRF5z9oaiCU/VBlq3fVpNFProuLnQt9Tmo1iQiloGywmlvOguqfUXyFoOD+fl+LRM
         cLD/Zl57caVQWLuvjyg3X+wSzlLPwdwnSqNQ2pm5x1cA7Hho1mrfuK0H5TlMPYJfP+Ux
         bfiIbXKmuN8cX6RVn6glaq3gG/pp+5tzConmv8d1RrGz79EZszgKB9cO0ne5aW4jF0v7
         hEllh9g9V9T4E+Jv0EvfF7JR6dNN1fRYNpZIKTL7LUufNy4OeaF+LGK4C+AS/FD8MFdH
         tN6A==
X-Gm-Message-State: AO0yUKWHiJRBTCSEu26C3+jhspSGlOXIpVa6KELRf/JUbIYgv4nVSvNu
        /dm7xi4NCrYfjFDOXezrI80KO6X37Wk1sQkL4No=
X-Google-Smtp-Source: AK7set8bcBPkOQqgITQgyYug09D11c7iaQ/Od4f8Z6peLe/NXnT6ipjkveDaPT1rDegD7hdXXAwqzg==
X-Received: by 2002:a17:907:205a:b0:878:4e5a:18b8 with SMTP id pg26-20020a170907205a00b008784e5a18b8mr8136495ejb.66.1674843288698;
        Fri, 27 Jan 2023 10:14:48 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm2639651edr.28.2023.01.27.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:14:48 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 5/6] selftest/bpf/benchs: print less if the quiet option is set
Date:   Fri, 27 Jan 2023 18:14:56 +0000
Message-Id: <20230127181457.21389-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127181457.21389-1-aspsk@isovalent.com>
References: <20230127181457.21389-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bench utility will print

    Setting up benchmark '<bench-name>'...
    Benchmark '<bench-name>' started.

on startup to stdout. Suppress this output if --quiet option if given. This
makes it simpler to parse benchmark output by a script.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bench.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 42bf41a9385e..2f34db60f819 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -648,7 +648,8 @@ static void setup_benchmark()
 		exit(1);
 	}
 
-	printf("Setting up benchmark '%s'...\n", bench->name);
+	if (!env.quiet)
+		printf("Setting up benchmark '%s'...\n", bench->name);
 
 	state.producers = calloc(env.producer_cnt, sizeof(*state.producers));
 	state.consumers = calloc(env.consumer_cnt, sizeof(*state.consumers));
@@ -694,7 +695,8 @@ static void setup_benchmark()
 					    next_cpu(&env.prod_cpus));
 	}
 
-	printf("Benchmark '%s' started.\n", bench->name);
+	if (!env.quiet)
+		printf("Benchmark '%s' started.\n", bench->name);
 }
 
 static pthread_mutex_t bench_done_mtx = PTHREAD_MUTEX_INITIALIZER;
-- 
2.34.1

