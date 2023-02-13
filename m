Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EA694086
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBMJPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjBMJPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8DEB74D
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v13so11855132eda.11
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uwkwAh6msx4qca/8nGaaS+MQVW4h4nThwELZNFbT88=;
        b=XuZaNpJZHxoM2TjY59+LM0o6Rd0a9cUFAFSBhVoTPWR8PcX2X3e9v6WRuSLYIMu+Wx
         592CdgwQOUk7P3S9hHx3oZ9diiVbX2gWcaN02c9D+cBvWbwaVBte6Sm4vKoNGhol5uXR
         akr+jxFm2XPDMma6/08+vRarPZ1F0L1bcAxyFENNx8Fo6HMCUhczHimiv9qCmIwrIGaG
         pnT0DOa9F9Paih+683/efgOYxEr+IYXCLr8cdCYZVRCbo/8P092siDHdarE2FiN/PKq5
         wOvev4UZyglFm555uub+vhn0CCQn36+vtISiyRFyLvwGECicAvrz+4MZv20rnqtCOKOf
         4pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uwkwAh6msx4qca/8nGaaS+MQVW4h4nThwELZNFbT88=;
        b=OHu3yucuONu6S6StdXtVKkbilJOsbFkLOl6hZnODe00ulwS+Eg/7SbRFw9zHKR3Wnq
         31kzWeCwhXTJlb3XAiJa614KrXmLaQrZPV9EFJdzoGZtxqchzG1fd0IwJKZErIhRwazl
         EjbCf+wSIWzJ1VYom2hK1p+k9BYVqL8oVsB2dSgf4038Eth0P+i8FojDMNnTtUZVnPh8
         Lj/2gw6/acSCfEm29AZKaxTSsSiZMWiRpU7rVlqWWprwzb3ltUDWeGDO/Kd3tgqLPNJu
         oWZGZHyt0fYXLjjkjBVKhoNxeWrzmoEO4S7mc4i1dcGFYv5LX/jWbnyfORi4KDILsgtk
         XoYQ==
X-Gm-Message-State: AO0yUKVJBeybpkd6FKT93DZY8YWyLBxYKbH+HYGGh0vfJUDzrjRmns+i
        iBpQQwAM24HIcFqchO7AtVj2XIyIRh0ByYBx0ww=
X-Google-Smtp-Source: AK7set/FdUOliAIOGa0yx4DXs5yRGAdzlG/ZlifBWf4Wl9IkN9Nb15c2gHItU1yiXANh7d065oeDlQ==
X-Received: by 2002:a50:9f85:0:b0:4ac:b69a:2f06 with SMTP id c5-20020a509f85000000b004acb69a2f06mr7309473edf.0.1676279714578;
        Mon, 13 Feb 2023 01:15:14 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:14 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 6/7] selftest/bpf/benchs: print less if the quiet option is set
Date:   Mon, 13 Feb 2023 09:15:18 +0000
Message-Id: <20230213091519.1202813-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213091519.1202813-1-aspsk@isovalent.com>
References: <20230213091519.1202813-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 23c24c346130..767ca679ee67 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -577,7 +577,8 @@ static void setup_benchmark(void)
 {
 	int i, err;
 
-	printf("Setting up benchmark '%s'...\n", bench->name);
+	if (!env.quiet)
+		printf("Setting up benchmark '%s'...\n", bench->name);
 
 	state.producers = calloc(env.producer_cnt, sizeof(*state.producers));
 	state.consumers = calloc(env.consumer_cnt, sizeof(*state.consumers));
@@ -623,7 +624,8 @@ static void setup_benchmark(void)
 					    next_cpu(&env.prod_cpus));
 	}
 
-	printf("Benchmark '%s' started.\n", bench->name);
+	if (!env.quiet)
+		printf("Benchmark '%s' started.\n", bench->name);
 }
 
 static pthread_mutex_t bench_done_mtx = PTHREAD_MUTEX_INITIALIZER;
-- 
2.34.1

