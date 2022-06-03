Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DEF53C389
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 06:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiFCERK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 00:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiFCERI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 00:17:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987F2C117
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 21:17:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c99cb3d4dso59041097b3.6
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 21:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1BsRtBAmOlVYU0X5fbG0S2pRq+lwbEah2uHUy+hlBpc=;
        b=PNpb7lAUWhaEKQ51mR2StQfbPWqXTDAQ5v+xMQEdFL01N5gEzOXwaqQvi2ehoTMmhE
         kKBj1ADbYt+999lWcGGZforge6SALcIw8PFsLHpeuL87d5uOzjkTNFi8Ur3I2WnsUapY
         ljkNZgaOn/aTAJEEcsumb0w9NBSAo3Z/6Q6qW71mXNPxctk2qA4WIF1sousCLrUJxryt
         GRbVolGOn3k2e2kl4JZVIgFSRE0X4eXfNHtyGR9l3RSn5gXcm0duhLsvUtAqkQVvnT9i
         l/IHRRkUh6+N3x+CheeczYN93qdyIyrUVFcLM3ijn8SuVRcaMODvv2ivWhPkJaTDc1JE
         OXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1BsRtBAmOlVYU0X5fbG0S2pRq+lwbEah2uHUy+hlBpc=;
        b=oiIed/ewHmqn3o7RAaNDaCkn0x0YpGKy91RnHcyC61odLqt9k8xpuXTR3N8FnW5S6j
         VMvA6/cR4y/JaYxroEeR2iiF/Tjj9NUcHdC/h4o4JWW8hg24Byy4DVGVHiog4S0ENwd6
         disRDIhJocQ5kWgU8PVcHoZX8LB4X5LQx0JKXeLoSBQoD8iCOZzBxPPgd+gGJu8V0Oyr
         wOg/Md+I8/A9qjQgL4dlhCiRh9iQ/eA8PNfaSZ744yzgBA7qkeYqv1WsdjCr4fliY6fO
         RHJIw/FZ3RVT2JxAgaECUJ8DJCguzg8+qX4mLt2JnmKRspV0l7EGyAT/tDMcm60KEWHV
         XksA==
X-Gm-Message-State: AOAM531K1F8/u4Y3LGTJyVw7X6UCkYvsos6zFoNlrLLoqlHpdPshyBgV
        mLmRiDeXMWw7D7mClZIGcwQhVSuoIons
X-Google-Smtp-Source: ABdhPJyncQ59ohwrf8WGY/GsbBhrkQPGT4t6b3aYpN9jUOflHJ6PqJhebEFokesypUtUFM4/B6pu59vq1GHP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7125:61ca:dfbf:5f0b])
 (user=irogers job=sendgmr) by 2002:a25:1cc3:0:b0:660:1c62:1f3b with SMTP id
 c186-20020a251cc3000000b006601c621f3bmr8849106ybc.115.1654229826128; Thu, 02
 Jun 2022 21:17:06 -0700 (PDT)
Date:   Thu,  2 Jun 2022 21:17:01 -0700
Message-Id: <20220603041701.2799595-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] libbpf: Fix is_pow_of_2
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuze Chi <chiyuze@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yuze Chi <chiyuze@google.com>

There is a missing not. Consider a power of 2 number like 4096:

x && (x & (x - 1))
4096 && (4096 & (4096 - 1))
4096 && (4096 & 4095)
4096 && 0
0

with the not this is:
x && !(x & (x - 1))
4096 && !(4096 & (4096 - 1))
4096 && !(4096 & 4095)
4096 && !0
4096 && 1
1

Reported-by: Yuze Chi <chiyuze@google.com>
Signed-off-by: Yuze Chi <chiyuze@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3f4f18684bd3..fd0414ea00df 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4956,7 +4956,7 @@ static void bpf_map__destroy(struct bpf_map *map);
 
 static bool is_pow_of_2(size_t x)
 {
-	return x && (x & (x - 1));
+	return x && !(x & (x - 1));
 }
 
 static size_t adjust_ringbuf_sz(size_t sz)
-- 
2.36.1.255.ge46751e96f-goog

